#include <iostream>
using namespace std;

class B {
protected:
	static int x;
	int i;

public:
	B()
	{
		x++;
		i = 1;
	}
	~B() { x--; }
	static int get_x() { return x; }
	int get_i() { return i; }
};
int B::x;
class D : public B {
public:
	D() { x++; }
	~D() { x--; }
};
int f(B* q)
{
	return (q->get_x()) + 1;
}
int main()
{
	B* p = new B[10];
	cout << f(p); // afiseaza: 11
	delete[] p;
	p = new D;
	cout << f(p); // afiseaza: 3
	delete p;
	cout << D::get_x(); // afiseaza: 1 (destructorul din baza nu este virtual, deci cand se face delete p, se decrementeaza o singura data x)
	return 0;
}