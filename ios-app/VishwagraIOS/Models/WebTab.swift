import Foundation

enum WebTab: String, CaseIterable, Identifiable {
    case home
    case courses
    case student
    case contact

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home:
            return "Home"
        case .courses:
            return "Courses"
        case .student:
            return "Student"
        case .contact:
            return "Contact"
        }
    }

    var systemImage: String {
        switch self {
        case .home:
            return "house.fill"
        case .courses:
            return "book.closed.fill"
        case .student:
            return "person.crop.circle.fill"
        case .contact:
            return "phone.fill"
        }
    }

    var path: String {
        switch self {
        case .home:
            return "/index.php"
        case .courses:
            return "/course.php"
        case .student:
            return "/student/login.php"
        case .contact:
            return "/contact.php"
        }
    }
}
