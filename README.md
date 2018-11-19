# class1

## Informaciones Generales

### ¿Qué es Xcode?
Xcode es un entorno de desarrollo integrado (IDE, en sus siglas en inglés) para macOS que contiene un conjunto de herramientas creadas por Apple destinadas al desarrollo de software para macOS, iOS, watchOS y tvOS. Su primera versión tiene origen en el año 2003 y su versión más reciente es la 10.1

### Lenguajes de Programación
Permite compilar código C, C++, Swift, Objective-C, Objective-C++, Java y AppleScript.

### ¿Qué es Swift?
Swift es un lenguaje de programación multiparadigma creado por Apple enfocado en el desarrollo de aplicaciones para iOS y macOS.

[swift.org](swift.org)

### ¿Qué es un Storyboard?
Un storyboard contiene la representación gráfica de las “pantallas” (los controladores) que componen nuestra aplicación y de las relaciones entre ellas. Además el sistema se encarga automáticamente de moverse por las pantallas cuando sucedan determinados eventos, instanciando los controladores y las vistas automáticamente.

### ¿Qué es UIViewController?
La clase UIViewController define el comportamiento compartido que es común para todos los view controllers.

Sus principales responsabilidades son las siguientes:
* Actualización del contenido de las vistas.
* Respondiendo a las interacciones del usuario con las vistas.
* Cambiar el tamaño de las vistas y gestionar el diseño de la interfaz general.
* Coordinar con otros objetos, incluidos otros view controllers, en su aplicación.

### ¿Qué es Outlets?
Son propiedades especiales declaradas con la palabra clave IBOutlet. IBOutlet le indica Xcode que vamos a conectar esa propiedad con un objeto de un Storyboard.

```swift
@IBOutlet weak var myTextField: UITextField;
```

### ¿Qué es Actions?
Las acciones son métodos que devuelve IBAction. La palabra IBAction le indica a Interface Builder que el método puede ser disparado desde un evento lanzado por un elemento gráfico de un Storyboard.

La primera definición recibe como parámetro el elemento que lanzó el evento que produjo que se invocase al método. 

```swift
@IBAction func var onClick(_ sender:Any) {

}
```

## Código

### Servicio
https://avires.net/suma/

```swift
@IBAction func onClick(_ sender:Any) {
    let urlComponents = URLComponents(string: "https://avires.net/suma/")!
    urlComponents.queryItems = [
      URLQueryItem(name: "n1", value: "textInput1.text!"),
      URLQueryItem(name: "n2", value: "textInput2.text!")
    ]
    
    let task = URLSession.shared.dataTask(with: URLRequest(url: urlComponents.url!)) { data, response, error in
        if let error = error {
            print ("error: \(error)")
            return
        }
        
        guard let data = data,
            let response = response as? HTTPURLResponse,
            (200 ..< 300) ~= response.statusCode,
            error == nil else {
                print ("server error")
                return
        }
        
        do {
            if let responseObj = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            {
                // Código que se ejecutara después que se cast los datos de la respuesta en un Diccionary
            } else {
                print("bad json")
            }
        } catch let error as NSError {
            print(error)
        }
    }
    task.resume()
}
```
