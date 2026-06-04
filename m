Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792D83FC5BA
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563715; cv=none; b=uaJTUI2oS8WIRRQQQj3XzMVmmAh9PhYOVDzZkbMGublp2vEUAeK6bDBeV3J26i7lwlPiCl31DY/qMm4c1r5Q4pZ8khEaC3slgGNpvtG7McKjrdd7BzRSpu/h82xnO22w8jGNt9lysz9X8uxaprgVX123GEuPUCuxMt1OMt6JePQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563715; c=relaxed/simple;
	bh=gwCofHGH6vZXW/4XECc2TxwWRgvTc5wmCwaHLRqs2kw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FMV/5LYLoDtOA4RcvaSnqVwBURB5JQ+SbAljEuz5iYON3VAfvtguAHgbSNCxrJycA44Rt0x4n8kahUhAugcgCjL2hVMzc7sthrjcv1iiu+/g8jJDLqNEFTXETa3I9QJ4bFHa/s1fi/z7mUVKFcyRWOFsJG0lkZz+lNVgz2kNCcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=mkjbyrCG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="mkjbyrCG"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65491cCeA241584, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780563699;
	bh=gwCofHGH6vZXW/4XECc2TxwWRgvTc5wmCwaHLRqs2kw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=mkjbyrCGX/PxBk9Z0Ayt2iDsqNA5tey9mF2RQ1Dj2+s7Fxie4/A1wxjGdwS3rb6DT
	 tUzby9y3Ux7bqXvFxOtx++asOx8n5Szj4kRrduGqlZ3/pRWDrAkfXjKMxxMQvrF3Pg
	 wp+GHcru0ILLT9oHPYFZcXJC2rZLThqo3FnoBg1Plx8py/4OxYXHqShQsSzd6Mqw5P
	 C8Futs0WH64CbdzfvQlKP+lJrqPuROid5td5uyz9r1QYEvkrSHYccaPvljE2kz8pUJ
	 5SogGPSXlTewbPqnHoRyCZ1mrvjhutuGXyUytK+9PGryd5KzPSSgFGfY2vIImR3zQy
	 usYWdDdl029AQ==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 65491cCeA241584
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jun 2026 17:01:39 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Jun 2026 17:01:38 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Thu,
 4 Jun 2026 17:01:38 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Heiner Kallweit <hkallweit1@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "lasse@lgb.dk"
	<lasse@lgb.dk>
Subject: RE: [Bug 221606] r8169: PCIe AER errors and recovery failure after
 recent driver changes
Thread-Topic: [Bug 221606] r8169: PCIe AER errors and recovery failure after
 recent driver changes
Thread-Index: AQHc85gwkGNesnqGQkCQ9QthIRv61LYuEfCw
Date: Thu, 4 Jun 2026 09:01:38 +0000
Message-ID: <9b206f58d93b48d194980374cf0da7b1@realsil.com.cn>
References: <bug-221606-201211@https.bugzilla.kernel.org/>
 <bug-221606-201211-LMiiKJhHhg@https.bugzilla.kernel.org/>
 <b1bda1da-8231-4f05-94a7-7511041ae489@gmail.com>
In-Reply-To: <b1bda1da-8231-4f05-94a7-7511041ae489@gmail.com>
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

Pk9uIDAzLjA2LjIwMjYgMDk6NDQsIGJ1Z3ppbGxhLWRhZW1vbkBrZXJuZWwub3JnIHdyb3RlOg0K
Pj4gaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMjE2MDYNCj4+
DQo+PiAtLS0gQ29tbWVudCAjMiBmcm9tIGxhc3NlQGxnYi5kayAtLS0NCj4+IENvbW1pdCA5YWI5
NGEzMmFmNzA0ZmE5Yzg3MzA5NDI4M2FlODc0NGEwN2JhZjI1IChyODE2OTogZW5hYmxlIExUUg0K
Pj4gc3VwcG9ydCkgc2VlbXMgdG8gYmUgdGhlIGlzc3VlLiBSdW5uaW5nIHRoZSBjb21taXQgYmVm
b3JlIHRoaXMgZG9lc24ndA0KPj4gZ2l2ZSBtZSBhbnkgQUVSIGVycm9ycyBhbmQgZXZlcnl0aGlu
ZyBzZWVtcyB0byBiZWhhdmUgbm9ybWFsbHkuDQo+Pg0KPkJpc2VjdGluZyB0aGUgcmVwb3J0ZWQg
aXNzdWUgcG9pbnRzIHRvIG9uZSBvZiB5b3VyIGNvbW1pdHMuDQo+Q291bGQgeW91IHBsZWFzZSBj
aGVjayB3aXRoIHRoZSB1c2VyPw0KDQpIaSwgSGVpbmVyLCBMYXNzZQ0KDQpUaGFua3MgZm9yIHJl
cG9ydGluZyB0aGlzIGlzc3VlLg0KDQpDdXJyZW50bHksIHdlIGhhdmVuJ3QgcmVjZWl2ZWQgYW55
IHNpbWlsYXIgcmVwb3J0cyBmcm9tIG91ciBjdXN0b21lcnMsIGFuZCBJIGFtIHVuYWJsZSB0byBy
ZXByb2R1Y2UgdGhpcyBBRVIgZXJyb3Igb24gbXkgbG9jYWwgdGVzdCBwbGF0Zm9ybXMuDQoNCkNv
dWxkIHlvdSBwbGVhc2UgcHJvdmlkZSBzb21lIG1vcmUgZGV0YWlsZWQgaW5mb3JtYXRpb24/IFRo
ZSBmdWxsIGRtZXNnIGxvZyB3aWxsIGhlbHAgbWUgY2hlY2sgdGhlIGV4YWN0IEFFUiBlcnJvciBt
ZXNzYWdlcyBhbmQgdGhlIGJvb3QgY29udGV4dC4gQWxzbyB0aGUgb3V0cHV0IG9mIHN1ZG8gbHNw
Y2kgLXZ2di4gSSBuZWVkIHRoaXMgdG8gY2hlY2sgdGhlIGV4YWN0IHBsYXRmb3JtIGluZm9ybWF0
aW9uLCBQQ0llIHRvcG9sb2d5LCBhbmQgdGhlIExUUi9BU1BNIGNhcGFiaWxpdGllcyBvZiBib3Ro
IHlvdXIgUm9vdCBQb3J0IGFuZCB0aGUgUmVhbHRlayBOSUMuDQoNCldoaWxlIHJldmlld2luZyB0
aGUgaW5pdGlhbGl6YXRpb24gZmxvdywgSSBub3RpY2VkIGEgcG90ZW50aWFsIGxvZ2ljIGNvbnRy
YWRpY3Rpb24uIElmIHJ0bF9hc3BtX2lzX3NhZmUodHApIHJldHVybnMgZmFsc2UsIHRoZSBkcml2
ZXIgZGlzYWJsZXMgTDEgYXQgdGhlIFBDSWUgY29yZSBsZXZlbCwgYnV0IHRwLT5hc3BtX21hbmFn
ZWFibGUgbWlnaHQgc3RpbGwgYmUgc2V0IHRvIHRydWUuIFRoaXMgY291bGQgY2F1c2UgdGhlIGRy
aXZlciB0byBpbmNvcnJlY3RseSBlbmFibGUgQVNQTS9MVFIgaW4gdGhlIE1BQyByZWdpc3RlcnMg
bGF0ZXIsIGNyZWF0aW5nIGEgaGFyZHdhcmUgc3RhdGUgbWlzbWF0Y2ggKFBDSWUgTDEgZGlzYWJs
ZWQsIGJ1dCBNQUMgTFRSIGVuYWJsZWQpIHdoaWNoIHVzdWFsbHkgbGVhZHMgdG8gQUVSLg0KDQpD
b3VsZCB5b3UgcGxlYXNlIHRlc3QgaWYgdGhlIGZvbGxvd2luZyBwYXRjaCBmaXhlcyB0aGUgQUVS
IGVycm9yIG9uIHlvdXIgc2lkZT8NCg0KLQlpZiAoZW5hYmxlICYmIHRwLT5hc3BtX21hbmFnZWFi
bGUpIHsNCisJaWYgKGVuYWJsZSAmJiB0cC0+YXNwbV9tYW5hZ2VhYmxlICYmIHJ0bF9hc3BtX2lz
X3NhZmUodHApKSB7DQoNClRoYW5rcywNCkJScywNCkphdmVuDQo=
