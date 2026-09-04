Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B722A35DA64;
	Fri,  4 Sep 2026 02:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490041; cv=none; b=JCMIeJghHieFO58MD5s4HKexkxQoNUGubyOWE0L6KRLMW+qDtMSC8vPqajl8dGiNJ7r0F02o4XIyFzsTbuOOUpWTsIIEmKCdRZMXPY0rz0xXsdzJwFBQg7d2vtNDCgohjpanz0lp96gsd6OYsu8FGnqBAr9H78cHZei3exzANHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490041; c=relaxed/simple;
	bh=ywz8jRsqA3EsvEqGc9pY+R+20urVhWiJ8KhDSKW4BHg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iC14dyPtKuCNIOKKGk+PVAU+uRgTUAu+U1RqfRhq1b9JL0Yn4Zf7E9T/IiMqSRsYxkYdqTFXmAvQ9BAQRZwP+/iZNwshSsa0ysjXP0/sIzgIiN+8rYKWT+m2EDv7MbyyIeUpEPLAJaeBqqFs9Fa3TkYKYWG4GEKd34dUgABaqUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=a/9VVkwY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="a/9VVkwY"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6842kjUI34102286, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1788490006;
	bh=ywz8jRsqA3EsvEqGc9pY+R+20urVhWiJ8KhDSKW4BHg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=a/9VVkwYZapq2CZYbRYcwrBOVwqKDaMHb6ErCunFgSrwhHGg7dSz6GsD4mMDMkH7Z
	 dtsvSjeOaDWU9IEugea5SHE/L6hu5QmUsCFx90g5BjQPm9yyA2WJnuInverACv/T4g
	 UNzgllTlHr+LkiOiBLbR3BGC8HxGwIwxEIVgS8dHT43QY5pjCHgNNK8P+iN+0YcA4p
	 8wG2jtPHiX0hiZnMxlPbniO9dbhpPiU4AI1tqLRYwRp5b4BWQdWDS2+A4YOhsaQxUG
	 aJ9uAA0g29bfYj/8VJR7m53JcAoGj7CSVtZ4BZlGWANjKp04xRa00j56zUFcLWIIp3
	 Alc+VWewABa1A==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6842kjUI34102286
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Sep 2026 10:46:45 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 4 Sep 2026 10:46:45 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.043; Fri,
 4 Sep 2026 10:46:44 +0800
From: Javen <javen_xu@realsil.com.cn>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "nic_swsd@realtek.com"
	<nic_swsd@realtek.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [net-next,v12,1/7] r8169: add support for multi irqs
Thread-Topic: [net-next,v12,1/7] r8169: add support for multi irqs
Thread-Index: AQHdO+SwSF+mLp6wXkqeIRUODtunHLa9tgzA
Date: Fri, 4 Sep 2026 02:46:44 +0000
Message-ID: <50122c7ae7704e6485684b2d2bac92e0@realsil.com.cn>
References: <20260831053940.620-2-javen_xu@realsil.com.cn>
 <178846812155.3394541.6579774818900952909@kernel.org>
In-Reply-To: <178846812155.3394541.6579774818900952909@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Pg0KPj4gK3N0YXRpYyBpbnQgcnRsODE2OV9yZXF1ZXN0X2lycShzdHJ1Y3QgcnRsODE2OV9wcml2
YXRlICp0cCkgew0KPj4gKyAgICAgc3RydWN0IG5ldF9kZXZpY2UgKmRldiA9IHRwLT5kZXY7DQo+
PiArICAgICBzdHJ1Y3QgbmFwaV9zdHJ1Y3QgKm5hcGk7DQo+PiArICAgICBpbnQgaSwgcmM7DQo+
PiArDQo+PiArICAgICBmb3IgKGkgPSAwOyBpIDwgdHAtPmlycV9udmVjczsgaSsrKSB7DQo+PiAr
ICAgICAgICAgICAgIG5hcGkgPSAmdHAtPnJ0bDgxNjlfbmFwaVtpXTsNCj4+ICsgICAgICAgICAg
ICAgcmMgPSBwY2lfcmVxdWVzdF9pcnEodHAtPnBjaV9kZXYsIGksIHJ0bDgxNjlfaW50ZXJydXB0
LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOVUxMLCBuYXBpLCAiJXMt
JWQiLCBkZXYtPm5hbWUsIGkpOw0KPj4gKyAgICAgICAgICAgICBpZiAocmMpDQo+PiArICAgICAg
ICAgICAgICAgICAgICAgZ290byBmcmVlX2lycTsNCj4+ICsgICAgIH0NCj4+ICsgICAgIHJldHVy
biAwOw0KPg0KPlsgLi4uIF0NCj4NCj4+IEBAIC01MTA3LDggKzUxNjIsNyBAQCBzdGF0aWMgaW50
IHJ0bF9vcGVuKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpDQo+Pg0KPj4gICAgICAgcnRsX3JlcXVl
c3RfZmlybXdhcmUodHApOw0KPj4NCj4+IC0gICAgIGlycWZsYWdzID0gcGNpX2Rldl9tc2lfZW5h
YmxlZChwZGV2KSA/IElSUUZfTk9fVEhSRUFEIDoNCj5JUlFGX1NIQVJFRDsNCj4+IC0gICAgIHJl
dHZhbCA9IHJlcXVlc3RfaXJxKHRwLT5pcnEsIHJ0bDgxNjlfaW50ZXJydXB0LCBpcnFmbGFncywg
ZGV2LT5uYW1lLCB0cCk7DQo+PiArICAgICByZXR2YWwgPSBydGw4MTY5X3JlcXVlc3RfaXJxKHRw
KTsNCj4+ICAgICAgIGlmIChyZXR2YWwgPCAwKQ0KPj4gICAgICAgICAgICAgICBnb3RvIGVycl9y
ZWxlYXNlX2Z3XzI7DQo+DQo+W1NldmVyaXR5OiBNZWRpdW1dDQo+RG9lcyB0aGlzIGRyb3AgdGhl
IElSUUZfTk9fVEhSRUFEIHRoYXQgY29tbWl0IDg3MGY1MzFlMTc4ZSAoInI4MTY5OiBzZXQNCj5J
UlFGX05PX1RIUkVBRCBpZiBNU0koWCkgaXMgZW5hYmxlZCIpIGFkZGVkPw0KPg0KPnBjaV9yZXF1
ZXN0X2lycSgpIGhhcmRjb2RlcyB0aGUgZmxhZ3MgYW5kIGhhcyBubyB3YXkgdG8gZXhwcmVzcw0K
PklSUUZfTk9fVEhSRUFEOg0KPg0KPmRyaXZlcnMvcGNpL2lycS5jOnBjaV9yZXF1ZXN0X2lycSgp
IHsNCj4gICAgICAgIHVuc2lnbmVkIGxvbmcgaXJxZmxhZ3MgPSBJUlFGX1NIQVJFRDsNCj4NCj4g
ICAgICAgIGlmICghaGFuZGxlcikNCj4gICAgICAgICAgICAgICAgaXJxZmxhZ3MgfD0gSVJRRl9P
TkVTSE9UOw0KPiAgICAgICAgLi4uDQo+ICAgICAgICByZXQgPSByZXF1ZXN0X3RocmVhZGVkX2ly
cShwY2lfaXJxX3ZlY3RvcihkZXYsIG5yKSwgaGFuZGxlciwgdGhyZWFkX2ZuLA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaXJxZmxhZ3MsIGRldm5hbWUsIGRldl9pZCk7IH0N
Cj4NCj5XaXRoIGhhbmRsZXIgIT0gTlVMTCB0aGUgZmxhZ3MgYXJlIGV4YWN0bHkgSVJRRl9TSEFS
RUQsIHNvIG9uIGEga2VybmVsDQo+Ym9vdGVkIHdpdGggdGhyZWFkaXJxcywgb3Igd2l0aCBDT05G
SUdfUFJFRU1QVF9SVCwgX19zZXR1cF9pcnEoKSByZWFjaGVzOg0KDQpIaSBIZWluZXIsDQoNCklu
IHByZXZpb3VzIHJldmlzaW9ucywgSSB3YXMgc3VnZ2VzdGVkIHRvIHVzZSB0aGUgbmV3IGFwaSBw
Y2lfcmVxdWVzdF9pcnEoKS4gSG93ZXZlciwgc2luY2UgaXQgaGFyZGNvZGVzIElSUUZfU0hBUkVE
IGFuZCBkb2VzIG5vdCBhY2NlcHQgY3VzdG9tIGZsYWdzLCBpdCBkcm9wcyBJUlFGX05PX1RIUkVB
RCBmb3IgTVNJL01TSS1YLiANCg0KVG8gYXZvaWQgdGhpcyBwZXJmb3JtYW5jZSByZWdyZXNzaW9u
IGRldGVjdGVkIGJ5IGFpLCBzaG91bGQgSSByZXZlcnQgdG8gdXNpbmcgcmVxdWVzdF9pcnEoKSAr
IHBjaV9pcnFfdmVjdG9yKCkgaW4gdjEzPyBDb3VsZCB5b3UgcGxlYXNlIGFkdmlzZSBvbiB0aGUg
YmVzdCBhcHByb2FjaCBmb3IgdjEzPw0KDQpUaGFua3MsDQpKYXZlbg0KDQo+DQo+a2VybmVsL2ly
cS9tYW5hZ2UuYzppcnFfc2V0dXBfZm9yY2VkX3RocmVhZGluZygpIHsNCj4gICAgICAgIGlmIChu
ZXctPmZsYWdzICYgKElSUUZfTk9fVEhSRUFEIHwgSVJRRl9QRVJDUFUgfCBJUlFGX09ORVNIT1Qp
KQ0KPiAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gICAgICAgIC4uLg0KPiAgICAgICAgbmV3
LT5mbGFncyB8PSBJUlFGX09ORVNIT1Q7DQo+ICAgICAgICAuLi4NCj4gICAgICAgIG5ldy0+dGhy
ZWFkX2ZuID0gbmV3LT5oYW5kbGVyOw0KPiAgICAgICAgbmV3LT5oYW5kbGVyID0gaXJxX2RlZmF1
bHRfcHJpbWFyeV9oYW5kbGVyOyB9DQo+DQo+c28gcnRsODE2OV9pbnRlcnJ1cHQoKSBiZWNvbWVz
IGZvcmNlLXRocmVhZGVkIGFuZCB0aGUgdmVjdG9yIGlzIG1hc2tlZCB1bnRpbA0KPnRoZSB0aHJl
YWQgcnVucywgd2hpY2ggaXMgd2hhdCA4NzBmNTMxZTE3OGUgc2V0IG91dCB0byBhdm9pZC4NCj4N
Cj5Ud28gcmVsYXRlZCBvYnNlcnZhdGlvbnMgb24gdGhlIHNhbWUgY2hhbmdlOiBNU0kgYW5kIE1T
SS1YIHZlY3RvcnMgYXJlIG5vdw0KPnJlcXVlc3RlZCBhcyBJUlFGX1NIQVJFRCBldmVuIHRob3Vn
aCB0aGV5IGFyZSBub3Qgc2hhcmVhYmxlLCBhbmQgdGhlIG5hbWUNCj5yZWdpc3RlcmVkIGluIC9w
cm9jL2ludGVycnVwdHMgY2hhbmdlcyBmcm9tICI8aWZuYW1lPiIgdG8gIjxpZm5hbWU+LTxOPiIu
DQo+U2hvdWxkIHRoZSBjaGFuZ2Vsb2cgbWVudGlvbiB0aGUgbmFtZSBjaGFuZ2U/DQo+DQo+PiBA
QCAtNTA3NCw3ICs1MTI3LDEwIEBAIHN0YXRpYyB2b2lkIHJ0bDgxNjlfbmV0cG9sbChzdHJ1Y3Qg
bmV0X2RldmljZQ0KPj4gKmRldikgIHsNCj4+ICAgICAgIHN0cnVjdCBydGw4MTY5X3ByaXZhdGUg
KnRwID0gbmV0ZGV2X3ByaXYoZGV2KTsNCj4+DQo+PiAtICAgICBydGw4MTY5X2ludGVycnVwdCh0
cC0+aXJxLCB0cCk7DQo+PiArICAgICBmb3IgKGludCBpID0gMDsgaSA8IHRwLT5pcnFfbnZlY3M7
IGkrKykgew0KPj4gKyAgICAgICAgICAgICBydGw4MTY5X2ludGVycnVwdChwY2lfaXJxX3ZlY3Rv
cih0cC0+cGNpX2RldiwgaSksDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZ0
cC0+cnRsODE2OV9uYXBpW2ldKTsNCj4+ICsgICAgIH0NCj4+ICB9DQo+PiAgI2VuZGlmDQoNCg==
