Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA4A26B74A;
	Thu,  7 May 2026 02:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778120378; cv=none; b=nYCgVPgLSrncRuxePF4SJjvuuRJ5KGZL4BQ4Osmbhawi1BWCIbH3m16WovVLeWBwM6UFvIq3u1BC9ZbjlRFdOV/jTfkHFwYLWEajbAiy4xA5UgyhjlftEtSWTTGQYcjtGjCnr2T+vv3slRJb2U535/qftO5mbdUgvJkZAyB3nok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778120378; c=relaxed/simple;
	bh=qjFilWVss5AY7bYp0brrB/FpWiuO5XUQXaUF82jMcxc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M6Z875AoijmjfG+CmhRYLhzv55CL66mkvpuIYOKiuVCe7nKVbhc8Frtn8Nyvg10SHdR85V0/qfzvastMmH0XL2C+Z/UtcUbjrdtJBccXcDCtRIuf8G0jHXn9QJkkRIhMHOYmRPJZPFung8ZkI+BYVX8d22J4QmfA0wMOVBc0KSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=V8JEDcBJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="V8JEDcBJ"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6472J8gwC2419201, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1778120348;
	bh=qjFilWVss5AY7bYp0brrB/FpWiuO5XUQXaUF82jMcxc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=V8JEDcBJZ+awcYuERjBkSx3LFFTaWc9GQTe10GpISD26gxjGQ6fPDarGANh62ivqV
	 hnPEDrLAhboIl3GBt+5pmO8ul2KvVNq6DfmaqvA1Iyw+3yeIucEuXwhl/aUFC59tv8
	 12aENheZ9iPdwp/6TakVAm6N9KnMrSCccqGWS8E1p/OcGtHcQUwAX+DhcECP59wCto
	 X8NdemzEZa5cSxMGIqCb4WLYtTQtaL0lB2a4sEK3MAoiaWSGbVX6RZOBPkaZ1+KtK6
	 5V6f8WLTLNnZjDjEthxfk1sWBd+JRgsOEB2ZQe4+5/HC/btYTSns0PSPbuthSh0tyg
	 kJyQx6LiqmvAA==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 6472J8gwC2419201
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 May 2026 10:19:08 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 7 May 2026 10:19:07 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Thu,
 7 May 2026 10:19:07 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Heiner Kallweit <hkallweit1@gmail.com>,
        "nic_swsd@realtek.com"
	<nic_swsd@realtek.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org"
	<horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch net-next v1 0/7] r8169: add RSS support for RTL8127
Thread-Topic: [Patch net-next v1 0/7] r8169: add RSS support for RTL8127
Thread-Index: AQHc3TA4bLhmf8usJUuCTwhJsRu3nrYA9uoAgADVSAA=
Date: Thu, 7 May 2026 02:19:07 +0000
Message-ID: <8ac5c803876048eaae2ba597eda63c4d@realsil.com.cn>
References: <20260506081326.767-1-javen_xu@realsil.com.cn>
 <bf301c5e-f6a3-459f-8eaa-a4032aaa3aa3@gmail.com>
In-Reply-To: <bf301c5e-f6a3-459f-8eaa-a4032aaa3aa3@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Pk9uIDA2LjA1LjIwMjYgMTA6MTMsIGphdmVuIHdyb3RlOg0KPj4gRnJvbTogSmF2ZW4gWHUgPGph
dmVuX3h1QHJlYWxzaWwuY29tLmNuPg0KPj4NCj4+IFRoaXMgcGF0Y2ggc2VyaWVzIGFkZHMgUlNT
IChSZWNlaXZlIFNpZGUgU2NhbGluZykgc3VwcG9ydCBmb3IgdGhlDQo+PiByODE2OSBldGhlcm5l
dCBkcml2ZXIsIHNwZWNpZmljYWxseSBmb3IgUlRMODEyNyAoUlRMX0dJR0FfTUFDX1ZFUl84MCku
DQo+DQo+U2VyaWVzIGFkZHMgUlNTIHN1cHBvcnQgZm9yIFJUTDgxMjcgb25seS4gSXMgdGhpcyBn
ZW5lcmljIGVub3VnaCB0byByZXRyb2ZpdCBSU1MNCj5zdXBwb3J0IGZvciBvdGhlciBjaGlwIHZl
cnNpb25zIGxpa2UgUlRMODEyNiB3L28gYmlnZ2VyIHJlZmFjdG9yaW5nPw0KPg0KWWVzLiBUaGUg
Y3VycmVudCBpbXBsZW1lbnRhdGlvbiBpcyBnZW5lcmljIGVub3VnaC4gQWxtb3N0IGFsbCB0aGUg
cmVnaXN0ZXJzIGFyZSBzaGFyZWQgYW5kIGNhbiBiZSByZXVzZWQuIElmIHdlIHdhbnQgdG8gZW5h
YmxlIHJzcyBmb3IgODEyNS84MTI2IGxhdGVyLCB0aGUgb25seSBuZWNlc3NhcnkgY2hhbmdlIHdv
dWxkIGJlIHNldHRpbmcgdHAtPmluaXRfcnhfZGVzY190eXBlIHRvIGEgbmV3IHZhbHVlLiBBbmQg
YWRkIGEgbmV3IHN0cnVjdCByeF9kZXNjIGZvciA4MTI1IG9yIDgxMjYuIEZvciBleGFtcGxlLCB0
aGlzIGlzIGEgZGVzYyB0eXBlIGZvciA4MTI1Lg0Kc3RydWN0IFJ4RGVzY1YzIHsNCiAgICAgICAg
dW5pb24gew0KICAgICAgICAgICAgICAgIHN0cnVjdCB7DQogICAgICAgICAgICAgICAgICAgICAg
ICB1MzIgcnN2MTsNCiAgICAgICAgICAgICAgICAgICAgICAgIHUzMiByc3YyOw0KICAgICAgICAg
ICAgICAgIH0gUnhEZXNjRERXb3JkMTsNCiAgICAgICAgfTsNCiAgICAgICAgdW5pb24gew0KICAg
ICAgICAgICAgICAgIHN0cnVjdCB7DQogICAgICAgICAgICAgICAgICAgICAgICB1MzIgUlNTUmVz
dWx0Ow0KICAgICAgICAgICAgICAgICAgICAgICAgdTE2IEhlYWRlckJ1ZmZlckxlbjsNCiAgICAg
ICAgICAgICAgICAgICAgICAgIHUxNiBIZWFkZXJJbmZvOw0KICAgICAgICAgICAgICAgIH0gUnhE
ZXNjTm9ybWFsRERXb3JkMjsNCg0KICAgICAgICAgICAgICAgIHN0cnVjdCB7DQogICAgICAgICAg
ICAgICAgICAgICAgICB1MzIgcnN2NTsNCiAgICAgICAgICAgICAgICAgICAgICAgIHUzMiByc3Y2
Ow0KICAgICAgICAgICAgICAgIH0gUnhEZXNjRERXb3JkMjsNCiAgICAgICAgfTsNCiAgICAgICAg
dW5pb24gew0KICAgICAgICAgICAgICAgIHU2NCAgIGFkZHI7DQoNCiAgICAgICAgICAgICAgICBz
dHJ1Y3Qgew0KICAgICAgICAgICAgICAgICAgICAgICAgdTMyIFRpbWVTdGFtcExvdzsNCiAgICAg
ICAgICAgICAgICAgICAgICAgIHUzMiBUaW1lU3RhbXBIaWdoOw0KICAgICAgICAgICAgICAgIH0g
UnhEZXNjVGltZVN0YW1wOw0KDQogICAgICAgICAgICAgICAgc3RydWN0IHsNCiAgICAgICAgICAg
ICAgICAgICAgICAgIHUzMiByc3Y4Ow0KICAgICAgICAgICAgICAgICAgICAgICAgdTMyIHJzdjk7
DQogICAgICAgICAgICAgICAgfSBSeERlc2NERFdvcmQzOw0KICAgICAgICB9Ow0KICAgICAgICB1
bmlvbiB7DQogICAgICAgICAgICAgICAgc3RydWN0IHsNCiAgICAgICAgICAgICAgICAgICAgICAg
IHUzMiBvcHRzMjsNCiAgICAgICAgICAgICAgICAgICAgICAgIHUzMiBvcHRzMTsNCiAgICAgICAg
ICAgICAgICB9IFJ4RGVzY05vcm1hbEREV29yZDQ7DQoNCiAgICAgICAgICAgICAgICBzdHJ1Y3Qg
ew0KICAgICAgICAgICAgICAgICAgICAgICAgdTE2IFRpbWVTdGFtcEhIaWdoOw0KICAgICAgICAg
ICAgICAgICAgICAgICAgdTE2IHJzdjExOw0KICAgICAgICAgICAgICAgICAgICAgICAgdTMyIG9w
dHMxOw0KICAgICAgICAgICAgICAgIH0gUnhEZXNjUFRQRERXb3JkNDsNCiAgICAgICAgfTsNCn07
DQpUaGlzIGlzIGNvbXBsZXggYmVjYXVzZSBpdCByZXNlcnZlcyBzb21lIHdvcmRzIGZvciBQVFAu
DQoNClRoYW5rcywNCkJScywNCkphdmVuDQoNCj4+DQo+PiBSU1MgZW5hYmxlcyBwYWNrZXQgZGlz
dHJpYnV0aW9uIGFjcm9zcyBtdWx0aXBsZSByZWNlaXZlIHF1ZXVlcywgd2hpY2gNCj4+IGNhbiBz
aWduaWZpY2FudGx5IGltcHJvdmUgbmV0d29yayB0aHJvdWdocHV0IG9uIG11bHRpLWNvcmUgc3lz
dGVtcyBieQ0KPj4gYWxsb3dpbmcgcGFyYWxsZWwgcHJvY2Vzc2luZyBvZiBpbmNvbWluZyBwYWNr
ZXRzLg0KPj4NCj4+IEtleSBmZWF0dXJlczoNCj4+IC0gTXVsdGktcXVldWUgUlggc3VwcG9ydCAo
dXAgdG8gOCBxdWV1ZXMpDQo+PiAtIE1TSS1YIGludGVycnVwdCB3aXRoIHZlY3RvciBtYXBwaW5n
DQo+PiAtIER5bmFtaWMgcXVldWUgY29uZmlndXJhdGlvbiB2aWEgZXRodG9vbCAoLUwpDQo+PiAt
IFJTUyBoYXNoIGNvbXB1dGF0aW9uIGZvciBmbG93IGNsYXNzaWZpY2F0aW9uDQo+Pg0KPj4gRXhw
ZXJpbWVudHM6DQo+PiBQbGF0Zm9ybTogQU1EIFJ5emVuIEVtYmVkZGVkIFIyNTE0IHdpdGggUmFk
ZW9uIEdyYXBoaWNzKDQgQ29yZXMvOA0KPj4gVGhyZWFkcykNCj4+IEFyY2g6IHg4Nl82NA0KPj4g
VGVzdCBjb21tYW5kOg0KPj4gICBTZXJ2ZXI6IGlwZXJmMyAtcw0KPj4gICBDbGllbnQ6IGlwZXJm
MyAtYyAxOTIuMTY4LjIuMSAtUCAyMCAtdCAzNjAwDQo+PiBNb25pdG9yOiBtcHN0YXQgLVAgQUxM
IDENCj4+DQo+PiBCZWZvcmUgdGhpcyBwYXRjaCAoV2l0aG91dCBSU1MpOg0KPj4gICBUaHJvdWdo
cHV0OiBVbnN0YWJsZSwgZmx1Y3R1YXRpbmcgYmV0d2VlbiAzLjc2IEdiaXRzL3NlYyBhbmQNCj4+
ICAgOC4yIEdiaXRzL3NlYy4NCj4+ICAgQ1BVIFVzYWdlOiBBIHNpbmdsZSBDUFUgY29yZSBpcyBm
dWxseSBvY2N1cGllZCB3aXRoIHNvZnRpcnEgcmVhY2hpbmcNCj4+ICAgdXAgdG8gOTYlLg0KPj4N
Cj4+IEFmdGVyIHRoaXMgcGF0Y2ggKFdpdGggUlNTIGVuYWJsZWQpOg0KPj4gICBUaHJvdWdocHV0
OiBTdGFibGUgYXQgOS40MiBHYml0cy9zZWMuDQo+PiAgIENQVSBVc2FnZTogVGhlIHRyYWZmaWMg
bG9hZCBpcyBldmVubHkgZGlzdHJpYnV0ZWQgYWNyb3NzIG11bHRpcGxlIENQVQ0KPj4gICBjb3Jl
cy4gVGhlIG1heGltdW0gc29mdGlycSBvbiBhIHNpbmdsZSBjb3JlIGRyb3BwZWQgdG8gNjMlLg0K
Pj4NCj4+IE90aGVyIEV4cGVyaW1lbnRzOg0KPj4gTGluazoNCj4+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL25ldGRldi8wQTUyNzk5NTNEODFCQjlDK2Y1MGM5YjQ5LTNlNWQtNDY3Zi0NCj5iNjkN
Cj4+IGEtN2U0OWVkMjIzMzgzQHJhZHhhLmNvbS8NCj4+DQo+PiBKYXZlbiBYdSAoNyk6DQo+PiAg
IHI4MTY5OiBhZGQgc3VwcG9ydCBmb3IgbXVsdGkgaXJxcw0KPj4gICByODE2OTogYWRkIHN1cHBv
cnQgZm9yIG11bHRpIHJ4IHF1ZXVlcw0KPj4gICByODE2OTogYWRkIHN1cHBvcnQgZm9yIG5ldyBp
bnRlcnJ1cHQgbWFwcGluZw0KPj4gICByODE2OTogZW5hYmxlIG5ldyBpbnRlcnJ1cHQgbWFwcGlu
Zw0KPj4gICByODE2OTogYWRkIHN1cHBvcnQgYW5kIGVuYWJsZSByc3MNCj4+ICAgcjgxNjk6IG1v
dmUgc3RydWN0IGV0aHRvb2xfb3BzDQo+PiAgIHI4MTY5OiBhZGQgc3VwcG9ydCBmb3IgZXRodG9v
bA0KPj4NCj4+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5X21haW4uYyB8IDEy
MDINCj4+ICsrKysrKysrKysrKysrKysrKy0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxMDgwIGlu
c2VydGlvbnMoKyksIDEyMiBkZWxldGlvbnMoLSkNCj4+DQoNCg==
