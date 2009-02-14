//

import groovy.swing.SwingBuilder
import java.awt.BorderLayout
import java.awt.FlowLayout
import java.awt.GridLayout
import javax.swing.border.TitledBorder
import javax.swing.border.BevelBorder
import javax.swing.SwingUtilities
import javax.swing.WindowConstants as WC
import javax.swing.SwingWorker
import javax.swing.JOptionPane

class Timebox {

  Timebox() {
    SwingUtilities.invokeLater({createAndShowGUI()} as Runnable)
  }

  static void main(args) {
    new Timebox()
  }

  void createAndShowGUI() {
    def swing = new SwingBuilder()
    def days = swing.textField(text:'0')
    def hours = swing.textField(text:'0')
    def minutes = swing.textField(text:'0')
    def seconds = swing.textField(text:'0')
    def startTimer = {
      def alert = daysToMillis(days.text.toInteger())
      alert += hoursToMillis(hours.text.toInteger())
      alert += minutesToMillis(minutes.text.toInteger())
      alert += secondsToMillis(seconds.text.toInteger())
      def worker = new TimerWorker(alert)
      worker.execute()
    }

    def setHour = swing.comboBox(items:1..12)
    def setMinute = swing.comboBox(items:0..59)
    def meridian = swing.comboBox(items:['AM', 'PM'])
    def startAlarm = {
      def worker = new AlarmWorker(setHour.selectedItem, setMinute.selectedItem, meridian.selectedItem)
      worker.execute()
    }

    def frame = swing.frame(title:'Time Box', layout:new BorderLayout(),defaultCloseOperation:WC.EXIT_ON_CLOSE) {
      panel(constraints:BorderLayout.WEST, border:new TitledBorder('Egg Timer'), layout:new GridLayout(0,2)) {
        label(text:'Seconds:')
        widget(seconds)
        label(text:'Minutes:')
        widget(minutes)
        label(text:'Hours:')
        widget(hours)
        label(text:'Days:')
        widget(days)
        label(text:'')
        button(text:'Start', actionPerformed:startTimer)
      }
      panel(constraints:BorderLayout.EAST, border:new TitledBorder('Alarm Clock'), layout:new GridLayout(0,2)) {
        label(text:'Hour:')
        widget(setHour)
        label(text:'Minute:')
        widget(setMinute)
        label(text:'Meridian:')
        widget(meridian)
        5.times {
          label(text:'')
        }
        button(text:'Start', actionPerformed:startAlarm)
      }
      panel(constraints:BorderLayout.SOUTH, border:new TitledBorder(''), layout:new FlowLayout(FlowLayout.RIGHT)) {
        button(text:'Exit', actionPerformed:{System.exit(0)})
      }
    }
    frame.pack()
    frame.visible = true
  }

  private daysToMillis(days) {
    hoursToMillis(days * 24)
  }

  private hoursToMillis(hours) {
    minutesToMillis(hours * 60)
  }

  private minutesToMillis(minutes) {
    secondsToMillis(minutes * 60)
  }

  private secondsToMillis(seconds) {
    seconds * 1000
  }

}

class TimerWorker extends SwingWorker {
  private alert

  TimerWorker(alert) {
    this.alert = alert + System.currentTimeMillis()
  }

  protected Object doInBackground() throws Exception {
    def now = System.currentTimeMillis()
    while (alert > now) {
      Thread.sleep(1000)
      now = System.currentTimeMillis()
    }
  }

  protected void done() {
    def sdf = new java.text.SimpleDateFormat('h:mm a')
    def now = sdf.format(new java.util.Date())
    JOptionPane.showMessageDialog(null, "Time's up. It's ${now}")
  }

}

import java.util.Calendar

class AlarmWorker extends SwingWorker {
  private alarm

  AlarmWorker(hour, minute, meridian) {
    def cal = Calendar.getInstance();
    switch (meridian) {
      case "PM":
        cal.set(Calendar.HOUR_OF_DAY, hour + 12)
        break
      default:
        cal.set(Calendar.HOUR_OF_DAY, hour)
    }
    cal.set(Calendar.MINUTE, minute)
    cal.set(Calendar.SECOND, 0)
    cal.set(Calendar.MILLISECOND, 0)
    this.alarm = cal.getTime()
  }

  protected Object doInBackground() throws Exception {
    while (new Date().compareTo(alarm) < 0) {
      Thread.sleep(1000)
    }
  }

  protected void done() {
    def sdf = new java.text.SimpleDateFormat('h:mm a')
    def now = sdf.format(alarm)
    JOptionPane.showMessageDialog(null, "Time's up. It's ${now}")
  }

}
