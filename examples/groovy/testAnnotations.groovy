public class GradeReport {
        @Property name
        @Property subject
        @Property String grade
}

GradeReport mathGrade = new GradeReport();

mathGrade.name = "John"
mathGrade.setSubject("Math")
mathGrade.grade = "A-"

println mathGrade.name                        // returns "John"
println mathGrade.getGrade()                // returns "A-" 


artGrade = new GradeReport(name:'Kristen', subject:'Art', grade:'B+')

println artGrade.name