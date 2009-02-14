
## Example: dining.awk - Dining Philosophers
## Demonstrates the dining philosophers problem using Java threads.
## "status" can be entered on stdin at anytime during the execution
## of the script to get a status of what chopstick is in use, as well
## as which philosopher has completed dining.

implements Runnable

BEGIN {
  ## configurable section
  NUM_PHILOS = 5
}

BEGIN {
  for (i=0;i<NUM_PHILOS;i++)
	chopsticks[i] = true	# true = chopstick is available
  for (i=0;i<NUM_PHILOS;i++) {
	## threads also act as {synchronization} locks to the chopsticks
	## (see lock() and unlock() functions below)
	(threads[i] = new Thread(this, "philosopher " i)).start()
	Thread.sleep(new Long("900"))
  }
  for (i in threads)
	threads[i].join()
  ## must exit because stdin is read for "status" command,
  ## and the user should not have to close this stream to exit the script
  exit
}
function run(	philo) {
  $0 = THREAD.getName()
  philo = $NF
  print THREAD.getName() " is thinking..."
  Thread.sleep(new Long("" (1000+philo*300)))
  if (philo == 0) {
	## righty
	lock((philo+1) % NUM_PHILOS)
	lock(philo)
  } else {
	## lefty
	lock(philo)
	lock((philo+1) % NUM_PHILOS)
  }
  # use the chopsticks
  print THREAD.getName() " is eating!"
  Thread.sleep(new Long("" (1000+philo*300)))
  unlock(philo)
  unlock((philo+1) % NUM_PHILOS)
  print THREAD.getName() " is DONE eating!"
}
function lock(chopsticknum) {
  synchronized(threads[chopsticknum]) {
	while(! chopsticks[chopsticknum]) threads[chopsticknum].wait()
	chopsticks[chopsticknum] = false
  }
}
function unlock(chopsticknum) {
  synchronized(threads[chopsticknum]) {
	chopsticks[chopsticknum] = true
	threads[chopsticknum].notifyAll()
  }
}
/^status$/ {
  for (i=0;i<NUM_PHILOS;i++)
	print "chopsticks[" i "] = " chopsticks[i]
  for (i=0;i<NUM_PHILOS;i++)
	print "threads[" i "].isAlive() = " threads[i].isAlive()
}
