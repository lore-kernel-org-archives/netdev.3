Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB762AD03;
	Mon, 12 Oct 2026 09:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791797115; cv=none; b=O4xerkMkTefocydu+k/aZ6w43v5DTlI00DPRq+4HQ8RW3zBuS8dNiXKcqbqSrU/eYoWphccim1Dl3kbm4A+YnNRqRWDXQH2PMdiSgcKzR/7cEV6vMY87K9tOFLqF+qhY/3BAHclE51j0OJdgLO0/vO4m6TsNnZBPXbIKi0oYo24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791797115; c=relaxed/simple;
	bh=IQpHB5+tqQEypajGabUCg71V1OUvDtXBIEiXuV4XzJA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ONhf7cw4M5Z61Ml7KYIBYy2oKuec92FKeu382w5Tn6oGH53rY1AqxZjajEZ5/6vJVBhAIyYuv1Fv/uMJ225r1iL5zdMhbC5mx94L/NdKK46U+M0FEnGlefobGhNN+eQ8iasCEXZ1IYubXQQo6EJbgY0Zbf46Kq/zBIycioeLv8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=iXX7VGaz; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="iXX7VGaz"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69C9OTTo83670355, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791797069; bh=IQpHB5+tqQEypajGabUCg71V1OUvDtXBIEiXuV4XzJA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=iXX7VGazYiCKqO0o0Ouv8JPZS1PMpJRk3OHCb2mfphoUm97t2RaLO4QYCVqepiYBi
	 xdCmc0Vh/hD4vaN+adZpSroNWFBNfmwLTBcPPwtw4+n8X/cEQmknNPYtrYGbOF2slb
	 DboRv7hf9slP3pmmmX8RFe4nBqBGGpFgfVNvFSkJpH8wSo7r2M/bocwDyvbUqx8z7K
	 dEna/H9qp4XuJnF9sZS/lSNpFymaefOAYG5di+HnJup66YlL5M/SKR8Qn3Kfzwqqnv
	 f6Mn/k5xTXuxIQ2ctgX1kuhgp3rKC0IEyccWD644TCFSs85bdkoezpePDeQJfg3KWM
	 YmZPjfndx6ZBw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69C9OTTo83670355
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Oct 2026 17:24:29 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 17:24:36 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Mon, 12 Oct 2026 17:24:36 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: Birger Koblitz <mail@birger-koblitz.de>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, nic_swsd
	<nic_swsd@realtek.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"bjorn@mork.no" <bjorn@mork.no>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>
Subject: RE: [PATCH net-next v6 01/10] r8152: split r8156_init per chip and
 factor out wait_autoload_done
Thread-Topic: [PATCH net-next v6 01/10] r8152: split r8156_init per chip and
 factor out wait_autoload_done
Thread-Index: AQHdVv1AdBx9zD4lckuTWpQnvZF0MLbzCemAgAadrcA=
Date: Mon, 12 Oct 2026 09:24:36 +0000
Message-ID: <816bbc26531f411283f43e24c6156b5c@realtek.com>
References: <20261008081556.47901-1-nic_swsd@realtek.com>
 <20261008081556.47901-2-nic_swsd@realtek.com>
 <633a0f2b-67b3-4896-8464-6a4d0c05498f@birger-koblitz.de>
In-Reply-To: <633a0f2b-67b3-4896-8464-6a4d0c05498f@birger-koblitz.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgQmlyZ2VyLA0KSSdtIHNvcnJ5IGZvciBtYWtpbmcgdGhlIHByZXZpb3VzIHJlcGx5IGhhcmQg
dG8gcmVhZCwgc28gSSByZXNlbnQgdGhpcy4NCg0KT24gVGh1cnNkYXksIE9jdG9iZXIgOCwgMjAy
NiwgODoxOCBQTSwgQmlyZ2VyIHdyb3RlOg0KPiBIaSBDaGloIEthaSwNCj4gDQo+IE9uIDA4LzEw
LzIwMjYgMTA6MTUgYW0sIENoaWggS2FpIEhzdSB3cm90ZToNCj4gPiBSVEw4MTU2LCBSVEw4MTU2
QiwgUlRMODE1NyBhbmQgUlRMODE1OSBzaGFyZWQgYSBzaW5nbGUgcjgxNTZfaW5pdCgpLA0KPiA+
IGdhdGVkIGJ5IGEgZGVuc2Ugc2V0IG9mIHRwLT52ZXJzaW9uIHJhbmdlIGNoZWNrcy4gVGhhdCBt
YWRlIHRoZSBpbml0DQo+ID4gc2VxdWVuY2UgaGFyZCB0byBmb2xsb3cuDQo+ID4NCj4gPiBTcGxp
dCByODE1Nl9pbml0KCkgaW50byBvbmUgZnVuY3Rpb24gcGVyIGNoaXAgZmFtaWx5Og0KPiA+IC0g
cjgxNTZfaW5pdCAgKFZFUl8xMC8xMSkNCj4gPiAtIHI4MTU2Yl9pbml0IChWRVJfMTIvMTMvMTUp
DQo+ID4gLSByODE1N19pbml0ICAoVkVSXzE2KQ0KPiA+IC0gcjgxNTlfaW5pdCAgKFZFUl8xNykN
Cj4gSSBoYXZlIGEgaGFyZCB0aW1lIHRvIHVuZGVyc3RhbmQgd2h5IHlvdSB3YW50IHRvIHNlcGFy
YXRlIG91dCBvbmUgaW5pdA0KPiBmdW5jdGlvbiBpbnRvIDQgZGlmZmVyZW50IG9uZXMsIGZvciBl
YWNoIGNoaXAgb25lLiBFc3BlY2lhbGx5LCBpZiwgYXMgeW91IHNheSBubw0KPiBmdW5jdGlvbmFs
IGNoYW5nZXMgYXJlIGludGVuZGVkLCB3aGljaCBtaWdodCBqdXN0aWZ5IHRoZSByZS1mYWN0b3Jp
bmcgaW4gdGhpcw0KPiBtYW5uZXIuIEJ5IG11bHRpcGx5aW5nIHRoZSBmdW5jdGlvbnMsIGl0IHdp
bGwgYmVjb21lIG1vcmUgZGlmZmljdWx0IHRvIG1haW50YWluDQo+IHRoZSBjb2RlOiBpZiBhbiBp
c3N1ZSBpcyBmb3VuZCBpbiB0aGUgaW5pdC1zZXF1ZW5jZSwgaXQgbWF5IG5vdyBiZSBuZWNlc3Nh
cnkgdG8NCj4gZml4IGl0IDQtdGltZXMgYW5kIGZ1dHVyZSBkZXZlbG9wbWVudHMgdG91Y2hpbmcg
dGhlIGluaXQtc2VxdWVuY2Ugd2lsbCBhbHNvDQo+IG5lZWQgdG8gYmUgcmVwbGljYXRlZCBtdWx0
aXBsZSB0aW1lcy4gSW4gdG90YWwsIHRoZXJlIHdvdWxkIGFmdGVyd2FyZHMgYmUgOCghKQ0KPiBk
aWZmZXJlbnQgaW5pdCBzZXF1ZW5jZXMgaW5jbHVkaW5nIHRoZSBvdGhlciBvbmVzIGZvciB0aGUg
UlRMODE1MiBhbmQgZGlmZmVyZW50DQo+IHZlcnNpb25zIG9mIHRoZSBSVEw4MTUzLiBUaGUgc2Ft
ZSBwYXR0ZXJuIHJlcGVhdHMgd2l0aCBfdXAoKSwgX2Rvd24oKSBhbmQNCj4gb3RoZXIgY29uZmln
dXJhdGlvbiBmdW5jdGlvbnMuDQoNClRoZSBzcGxpdCBpcyBtZWFudCB0byBtYWtlIGVhY2ggZnVu
Y3Rpb24gcmVhZGFibGUgb24gaXRzIG93bi4gSW4gYSBzaW5nbGUgc2hhcmVkDQpmdW5jdGlvbiwg
ZXZlcnkgY2hpcCBkaWZmZXJlbmNlIGlzIGEgdHAtPnZlcnNpb24gcmFuZ2UgY2hlY2ssIGFuZCB0
aGUgZnVuY3Rpb24gaXMNCmhhcmQgdG8gZm9sbG93LiBZb3VyIGNvbmNlcm4gaXMgdmFsaWQ6IGlm
IGEgZml4IG5lZWRzIHRvIGJlIGFwcGxpZWQgdG8gdGhlIGZvdXIgY2hpcHMsDQppdCB3aWxsIG5l
ZWQgdG8gYmUgYXBwbGllZCBmb3VyIHRpbWVzLiBCdXQgaWYgYSBjaGlwIGdldHMgY2hpcC1zcGVj
aWZpYyBmaXhlcywgdGhlIGluaXQgDQpvciBvdGhlciBmdW5jdGlvbnMgd2lsbCBiZSBtb3JlIGNv
bXBsZXggd2l0aCBzZXZlcmFsIHRwLT52ZXJzaW9uIGNoZWNrcy4NCg0KT24gdGhlIG90aGVyIGhh
bmQsIHVzaW5nIGEgc2luZ2xlIHNoYXJlZCBmdW5jdGlvbiB3aWxsIG1ha2UgdGhlIGZ1bmN0aW9u
IHZlcnkgDQpjb21wbGV4IHdoZW4gbmV3IElDcyBhcmUgYWRkZWQuDQoNCj4gDQo+IFdvdWxkIGl0
IG5vdCBtYWtlIG1vcmUgc2Vuc2UgdG8gdHJ5IHRvIGZ1cnRoZXIgY29tYmluZSB0aGUgaW5pdCBz
ZXF1ZW5jZXMgb3INCj4gdHJ5IHRvIGRpc2VudGFuZ2xlIHRoZSBjb2RlIGJ5IGVzdGFibGlzaGlu
ZyBjb21tb24gbGlicmFyeSByb3V0aW5lcyBwdXQgaW50byBhDQo+IF9saWIuYyBmaWxlIGFuZCBw
b3NzaWJseSBkaWZmZXJlbnQgLmMgZmlsZXMgZm9yIHRoZSBkaWZmZXJlbnQgZ2VuZXJhdGlvbnMg
b2YgdGhlIGNoaXBzPw0KPiBGb3IgZXhhbXBsZSwgaXQgYXBwZWFycyB0aGF0IHRoZQ0KPiBydGw4
MTU3LzkgYmVsb25nIHRvIG9uZSBnZW5lcmF0aW9uIG9mIGNoaXBzLCBiYXNlZCBvbiB0aGUgcnRs
ODE1NiBkZXNpZ24uIE9uDQo+IHRoZSBvdGhlciBoYW5kLCBydGw4MTUyLzMgYXBwZWFyIHRvIGJl
IGEgZGlmZmVyZW50IGdlbmVyYXRpb24gd2l0aCB2YXJpb3VzDQo+IGZhbWlseSBtZW1iZXJzLiBU
aGF0IHdvdWxkIGFsbG93IHRvIGJ1aWxkIGEgYmFzaXMgZm9yIGZ1dHVyZSBkZXZlbG9wbWVudCBs
aWtlDQo+IHRvIHJlbHkgb24gdXNpbmcgcGh5bGluayB0byBoYW5kbGUgdGhlIFBIWXMgaW50ZWdy
YXRlZCBpbiB0aGUgY2hpcHMsIHdoaWNoIGFsbA0KPiBhcHBlYXIgdG8gYmUgYWxyZWFkeSBzdXBw
b3J0ZWQgYnkgdGhlIFJlYWx0ZWstUEhZIGRyaXZlci4NCg0KSSBhZ3JlZSB0aGF0IGNoaXBzIHdp
dGggdGhlIHNhbWUgZ2VuZXJhdGlvbiBvciB2ZXJ5IHNpbWlsYXIgc2VxdWVuY2VzIHNob3VsZCBi
ZSBjb21iaW5lZC4NCg0KSSBwcmVmZXIgdG8gY29tYmluZSB0aGUgY2FsbGJhY2tzLCBpbmNsdWRp
bmcgaW5pdCwgdXAsIGRvd24sIGFuZCBlbmFibGUuIA0KLSBGb3IgaW5pdCwgSSBjYW4gbWVyZ2Ug
cjgxNTZiX2luaXQgaW50byByODE1Nl9pbml0IGFuZCByODE1OV9pbml0IGludG8gcjgxNTdfaW5p
dC4gDQotIEZvciB1cC9kb3duLCBJIGNhbiBtb3ZlIHRoZSBzZXF1ZW5jZSBzaGFyZWQgYnkgcnRs
ODE1Nl91cC9ydGw4MTU3X3VwIGFuZCBieSB0aGUgZG93biANCiBmdW5jdGlvbnMgaW50byBjb21t
b24gaGVscGVycywgYXMgcnRsODE1MmIvMyBkbyB3aXRoIGV4aXRfb29iL2VudGVyX29vYi4gDQot
IEZvciBlbmFibGUsIEkgY2FuIGNvbWJpbmUgcnRsODE1Nl9lbmFibGUgYW5kIHJ0bDgxNTZiX2Vu
YWJsZS4NCg0KPiANCj4gWy4uLl0NCj4gPg0KPiA+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlIGludGVu
ZGVkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hpaCBLYWkgSHN1IDxoc3UuY2hpaC5rYWlA
cmVhbHRlay5jb20+DQo+IEJlc3QsDQo+ICAgIEJpcmdlcg0KDQpCZXN0LA0KQ2hpaC1LYWkNCg==
