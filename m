Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857283ACF1B;
	Mon, 28 Sep 2026 07:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790580270; cv=none; b=q6WC2Yh3aI5R/TlAZ+gdoRO1olEG4snhijFghe+/ael1RhQOg+J6mkdIPJpZIN0B3dmJFkDbXIkrF1WW1qPry1f/VeJ+zPWu2vx55Ikehv674Ran1UQeST1h8uDLCDQViYK9piauZmXFdV9lOV+C8agOqB5e/Q8Oq7V0EPX4CpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790580270; c=relaxed/simple;
	bh=13MWWB5FsD5BeUz9Yuiyr+vkYeGQ5edQpwcBr7Ki72o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ov+VD/gU1YxoLgMp92pYKln2dAdCMNygPfCHTKQys7qRQ9J6anz0jg3uvwalR5Q89RIhV3wzxA/jwJ3xC6rRBtm0eYYcw3Zg7Vv8vyr4o2BlxFcWMpWM3o3GBAXjJDZToeASJFVy3LZTFlpkzNtPqA8spq5lL7rl1E2QMQiFxwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=F6P0xBVp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="F6P0xBVp"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68S7NbCX2222568, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1790580217;
	bh=13MWWB5FsD5BeUz9Yuiyr+vkYeGQ5edQpwcBr7Ki72o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=F6P0xBVpvgvV7sXbZq2k6ckh6h9D3+7tdyWRrKaCFXpja1P+lrSsSsQ+o/3UL/vC3
	 Xdty/qYweWM4wCI6M03UB0s7UWxWXgNVXcQrYqUKwo2KLGLI9JzjI+lwGk+T8JVJHq
	 WAnKyv98SbpxYx2g89Wcbc85gucJukb1YKxOCaC2GZtJxS1jL1Uc8GDKvemlgb/6l/
	 5HoubuyjnGkNm157KJOYlmUwzT+u13DxlGdSZwO0ajCyBvSFClgFyUOKP2zGQL+buD
	 Zk9mkvIzuPXETu8T/ZeafjUdMOFtrwm8T68jMBaLCcMiEOyL4/iCpE8Q6u8/EpPkbW
	 HmBXInudc2hpQ==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68S7NbCX2222568
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Sep 2026 15:23:37 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 28 Sep 2026 15:23:37 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.049; Mon,
 28 Sep 2026 15:23:37 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Simon Polack <spolack+git@mailbox.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "chad@monroe.io"
	<chad@monroe.io>, "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 3/3] net: phy: realtek: add LED support for
 RTL8261C/D
Thread-Topic: [PATCH net-next 3/3] net: phy: realtek: add LED support for
 RTL8261C/D
Thread-Index: AQHdSeUW/73ivrCDRk+7H/EUOZsxNbbjnznA
Date: Mon, 28 Sep 2026 07:23:37 +0000
Message-ID: <ee6ee488e3884540a82cfab11fb36ba3@realsil.com.cn>
References: <20260921161817.565185-1-spolack+git@mailbox.org>
 <20260921161817.565185-4-spolack+git@mailbox.org>
In-Reply-To: <20260921161817.565185-4-spolack+git@mailbox.org>
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

PlRoZSBSVEw4MjYxQy9EIHVzZSB0aGUgc2FtZSBMRUQgcmVnaXN0ZXIgYmxvY2sgYXMgdGhlIFJU
TDgyMjFCOiBvbmUgY29udHJvbA0KPnJlZ2lzdGVyIHBlciBMRUQgYXQgVkVORDIgMHhkMDMyICsg
MiAqIGluZGV4IHNlbGVjdGluZyB0aGUgbGluayBzcGVlZHMgdGhhdCBsaWdodA0KPml0LCBhY3Rp
dml0eSBibGluayBiaXRzIGluIExDUjYgYW5kIHBlci1MRUQgcG9sYXJpdHkgYW5kIGVuYWJsZSBi
aXRzIGluIExDUjcuDQo+Q29tcGFyZWQgdG8gdGhlIFJUTDgyMjFCIHRoZXJlIGFyZSBmb3VyIExF
RHMgaW5zdGVhZCBvZiB0aHJlZSwgYW5kIHR3byBtb3JlDQo+c3BlZWQgYml0cyBmb3IgNUcgYW5k
IDEwRy4NCj4NCj5SZXVzZSB0aGUgZXhpc3RpbmcgUlRMODIyWF9WTkQyXyogZGVmaW5pdGlvbnMg
YW5kIGFkZCB0aGUgdHdvIHNwZWVkIGJpdHMNCj5hbmQgdGhlIGVuYWJsZSBiaXQuIFRoZSBjYWxs
YmFja3MgZm9sbG93IHJ0bDgyMnhiX2xlZF8qKCkgY2xvc2VseSwgd2l0aCB0d28NCj5hZGRpdGlv
bnM6DQo+DQo+IC0gbGVkX3BvbGFyaXR5X3NldCgpIGhvbm91cnMgYWN0aXZlLWxvdyBMRURzLiBU
aGUgcG9sYXJpdHkgYml0IGluIExDUjcNCj4gICBkb3VibGVzIGFzIHRoZSBtYW51YWwgb24vb2Zm
IGxldmVsIGluIGxlZF9icmlnaHRuZXNzX3NldCgpLCBzbyB0aGUNCj4gICBjb25maWd1cmVkIHBv
bGFyaXR5IGlzIGNhY2hlZCBpbiB0aGUgcHJpdmF0ZSBkYXRhIGFuZCByZXN0b3JlZCBieQ0KPiAg
IGxlZF9od19jb250cm9sX3NldCgpLg0KPg0KPiAtIGxlZF9od19jb250cm9sX3NldCgpIGFuZCBs
ZWRfYnJpZ2h0bmVzc19zZXQoKSBzZXQgdGhlIG91dHB1dCBlbmFibGUNCj4gICBiaXQsIHdoaWNo
IGZpcm13YXJlIG5vcm1hbGx5IGxlYXZlcyBzZXQgYWxyZWFkeS4NCj4NCj5UaGUgY2FsbGJhY2tz
IGR1cGxpY2F0ZSBtb3N0IG9mIHJ0bDgyMnhiX2xlZF8qKCksIGRpZmZlcmluZyBvbmx5IGluIHRo
ZSBMRUQNCj5jb3VudCwgdGhlIHNwZWVkIG1hc2sgYW5kIHRoZSBMQ1I3IGhhbmRsaW5nLiBNYWtp
bmcgdGhlIFJUTDgyMjFCIGNvZGUNCj50YWJsZS1kcml2ZW4gYW5kIHNoYXJpbmcgaXQgd291bGQg
YmUgdGhlIHJpZ2h0IGVuZCBzdGF0ZSwgYnV0IHRoYXQgdG91Y2hlcyBhDQo+d29ya2luZyBkcml2
ZXIgYW5kIHdhbnRzIHRlc3Rpbmcgb24gYW4gUlRMODIyMUIsIHNvIGl0IGlzIGxlZnQgZm9yIGEg
Zm9sbG93LXVwDQo+c2VyaWVzLg0KPg0KPlRoZSBjYWxsYmFja3MgYXJlIHdpcmVkIHRvIHRoZSBS
VEw4MjYxQ19DRyBhbmQgUlRMODI2MUNFX0NHIGVudHJpZXMsIHdoaWNoDQo+YmV0d2VlbiB0aGVt
IGNvdmVyIHRoZSBwYXJ0cyB0aGlzIHdhcyB0ZXN0ZWQgb24uIFJUTDgyNjFEX1ZNIGlzIGxlZnQg
b3V0IGZvcg0KPmxhY2sgb2YgaGFyZHdhcmUuDQo+DQo+VGVzdGVkIG9uIGEgR2VtdGVrIFcxNzAw
SyAoQWlyb2hhIEFONzU4MSkgd2l0aCBhbiBSVEw4MjYxQ0U6IGluZGV4IDINCj5kcml2ZXMgYSB5
ZWxsb3cgYW5kIGluZGV4IDMgYSBncmVlbiBMRUQgb24gZWFjaCAxMEcgcG9ydC4gVW5kZXIgaGFy
ZHdhcmUNCj5jb250cm9sIHRoZSBsaW5rIHNwZWVkIGJpdHMsIHRoZSBhY3Rpdml0eSBibGluayBh
bmQgdGhlIGNvbWJpbmVkDQo+VFJJR0dFUl9ORVRERVZfTElOSyBhbGwgdGFrZSBlZmZlY3QgYW5k
IG9mZmxvYWRpbmcgaXMgY29uZmlybWVkIHRocm91Z2ggdGhlDQo+bmV0ZGV2IHRyaWdnZXIuIFRo
ZSBwb2xhcml0eSBiaXQgd2FzIHZlcmlmaWVkIHRvIGJlIGFjdGl2ZS1oaWdoIHdoZW4gY2xlYXIg
b24gdGhhdA0KPmJvYXJkLiBBbHNvIHRlc3RlZCBvbiBBTjc1ODEgYW5kIE1UNzk4OEEgYm9hcmRz
IHdpdGggYW4gUlRMODI2MUMgYW5kDQo+UlRMODI2MUQuDQo+DQo+U2lnbmVkLW9mZi1ieTogQ2hh
ZCBNb25yb2UgPGNoYWRAbW9ucm9lLmlvPg0KPkNvLWRldmVsb3BlZC1ieTogU2ltb24gUG9sYWNr
IDxzcG9sYWNrK2dpdEBtYWlsYm94Lm9yZz4NCj5TaWduZWQtb2ZmLWJ5OiBTaW1vbiBQb2xhY2sg
PHNwb2xhY2srZ2l0QG1haWxib3gub3JnPg0KPkFzc2lzdGVkLWJ5OiBMTE0NCj4tLS0NCj4gZHJp
dmVycy9uZXQvcGh5L3JlYWx0ZWsvcmVhbHRla19tYWluLmMgfCAyMjgNCj4rKysrKysrKysrKysr
KysrKysrKysrKysrDQo+IDEgZmlsZSBjaGFuZ2VkLCAyMjggaW5zZXJ0aW9ucygrKQ0KPg0KPmRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC9waHkvcmVhbHRlay9yZWFsdGVrX21haW4uYw0KPmIvZHJp
dmVycy9uZXQvcGh5L3JlYWx0ZWsvcmVhbHRla19tYWluLmMNCj5pbmRleCAwNGQzOTdmMGEyZDgu
LmIxZjAyMGFhNzc2MCAxMDA2NDQNCj4tLS0gYS9kcml2ZXJzL25ldC9waHkvcmVhbHRlay9yZWFs
dGVrX21haW4uYw0KPisrKyBiL2RyaXZlcnMvbmV0L3BoeS9yZWFsdGVrL3JlYWx0ZWtfbWFpbi5j
DQo+QEAgLTE4MywxMiArMTgzLDE1IEBADQo+ICNkZWZpbmUgUlRMODIyWF9WTkQyX0xDUl9MSU5L
XzEwMCAgICAgICAgICAgICAgQklUKDEpDQo+ICNkZWZpbmUgUlRMODIyWF9WTkQyX0xDUl9MSU5L
XzEwMDAgICAgICAgICAgICAgQklUKDIpDQo+ICNkZWZpbmUgUlRMODIyWF9WTkQyX0xDUl9MSU5L
XzI1MDAgICAgICAgICAgICAgQklUKDUpDQo+KyNkZWZpbmUgUlRMODIyWF9WTkQyX0xDUl9MSU5L
XzUwMDAgICAgICAgICAgICAgQklUKDYpDQo+KyNkZWZpbmUgUlRMODIyWF9WTkQyX0xDUl9MSU5L
XzEwMDAwICAgICAgICAgICAgQklUKDQpDQo+DQo+ICNkZWZpbmUgUlRMODIyWF9WTkQyX0xDUjYg
ICAgICAgICAgICAgICAgICAgICAgMHhkMDQwDQo+ICNkZWZpbmUgUlRMODIyWF9WTkQyX0xFRF9B
Q1QoeCkgICAgICAgICAgICAgICAgICAgICAgICBCSVQoeCkNCj4NCj4gI2RlZmluZSBSVEw4MjJY
X1ZORDJfTENSNyAgICAgICAgICAgICAgICAgICAgICAweGQwNDQNCj4gI2RlZmluZSBSVEw4MjJY
X1ZORDJfTEVEX1BPTEFSKHgpICAgICAgICAgICAgICBCSVQoeCkNCj4rI2RlZmluZSBSVEw4MjJY
X1ZORDJfTEVEX0VOKHgpICAgICAgICAgICAgICAgICBCSVQoKHgpICsgNCkNCj4NCj4gI2RlZmlu
ZSBSVEw4MjI0X01JSV9SVENUICAgICAgICAgICAgICAgICAgICAgICAweDExDQo+ICNkZWZpbmUg
UlRMODIyNF9NSUlfUlRDVF9FTkFCTEUgICAgICAgICAgICAgICAgICAgICAgICBCSVQoMCkNCj5A
QCAtMzA1LDYgKzMwOCw3IEBADQo+ICNkZWZpbmUgRldfU1VCX01BR0lDXzgyNjFEICAgICAgICAg
ICAgIDB4MzIzNjMxNDQNCj4gI2RlZmluZSBSVEw4MjYxWF9QT0xMX1RJTUVPVVRfTVMgICAgICAg
MTAwDQo+ICNkZWZpbmUgUlRMODI2MVhfTUFYX01NRF9ERVYgICAgICAgICAgIDMxDQo+KyNkZWZp
bmUgUlRMODI2MVhfTEVEX0NPVU5UICAgICAgICAgICAgIDQNCg0KSGksDQoNCldlIGtpbmRseSBz
dWdnZXN0IGRyb3BwaW5nIHRoaXMgcGF0Y2ggZm9yIHRoZSBzYW1lIHJlYXNvbiBhcyBpbiBQYXRj
aCAyLzMuDQoNCkxFRCBjb25maWcgaXMgcmVsYXRlZCB0byBIVyBjb25maWcgYW5kIHdpbGwgYmUg
Y29uZmlndXJlZCB2aWEgZmlybXdhcmUuDQoNCkJScywNCkphdmVuDQo=
