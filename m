Received: from mailhub16-fb.kaspersky-labs.com (mailhub16-fb.kaspersky-labs.com [5.79.125.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA6D323416
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.79.125.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785153404; cv=none; b=So7KCCgruBXX+2P5/X43sSOyB9F3y8/hMH6eFWrDNK/3Rs+tvaVHkOt+L2jweAogAbX7T5ENFimhMbQsmKFL5iV4y38RrjIWjREdD2B6kO72/ci0dWrFsle+8Ncb27SYoimSJSADc3mwUSy68ersSN7qEgHFAmTpoVmdtp4a1/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785153404; c=relaxed/simple;
	bh=aCRjKsoUvhAH8ed2G/SDT/uPX5xKPyyUIenUtluJ/bk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VRqUHbiQdngiaBQR2PVcbbXmgUDsY7cVzb33rPCE3LflHNe6yNxwqNCUc1TD6e997j4YWGUjXhgKeN1xybqAl3zuzIDmsxNHM7sO9VRu5B1eJ/+5ypqJbI+CLdvdZSm67VFTqtI9DNbWCvL3vZVLQpWbnBheI3B3fd/M3MaCMss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=mCfDjYXO; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=OAlV1WKa; arc=none smtp.client-ip=5.79.125.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="mCfDjYXO";
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="OAlV1WKa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1785152794;
	bh=aCRjKsoUvhAH8ed2G/SDT/uPX5xKPyyUIenUtluJ/bk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	b=mCfDjYXOwHM5KE36i2DhLWZWpY04D/z0nQx6yWfam0jVO2kya03kgKNffPBxjjN2I
	 gVd3FD5RUiYtLFYmMbUXzP1K7imteHOkZgEMJA+bB7KL/fEnrtHGMPlDxcPl6/buge
	 LzMjkCacdLMGDXaEnulzLBuC8xJmvavUAS3Ym8+xIsjuhTDBqJsDCDqRQT4211IN33
	 SKG8A8JZpVCs+0YPaV9QVTmB+VS+KygJq5HQDBhj0cU/Sxieg93BkOiMZfmBZqCqwW
	 KmYbzDr5Z39FhEg6IgVlRXZISCBMvJQUTEE0K6On+3hr/VVkvdROxiZAH65gAi07JZ
	 QEUUqWtKcwVmw==
Received: from mailhub16-fb.kaspersky-labs.com (localhost [127.0.0.1])
	by mailhub16-fb.kaspersky-labs.com (Postfix) with ESMTP id DDF9FC08F15
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 14:46:34 +0300 (MSK)
Received: from mx16.kaspersky-labs.com (mx16.kaspersky-labs.com [5.79.125.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "mx16.kaspersky-labs.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub16-fb.kaspersky-labs.com (Postfix) with ESMTPS id BAE42C08DC6
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 14:46:34 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1785152786;
	bh=aCRjKsoUvhAH8ed2G/SDT/uPX5xKPyyUIenUtluJ/bk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	b=OAlV1WKaLxIDng7F1OKTDY3xhM858IuigJJynaE/njgQV/bcHsbMZNdJVySGzYSXm
	 FGumyKUvQbzym7EEYCoT67U1YAhAtT0RVuZY8+d5y2bphLuiZ7wE+YXSvC6Z4MWD9D
	 7tyi8fpR/6yOmsLxvdn12X6Ig1DESlEeqweexxrXJKIS1AKyiTRc5k/I8fy3NKT+z/
	 0AWoXA8zilztQMzwyO/26rjvaou9rO+3PRyHQl6SC7S3otBbB+L2p9kZMqvmsM8U/U
	 YWMM4e0v+b/8qI+pEcUH1C5lj7aWYU2YXj0W0dh/21R0dMd26+7ZaBy1dp2cA6M1zL
	 SFlP3IBtnUCtQ==
Received: from relay16.kaspersky-labs.com (localhost [127.0.0.1])
	by relay16.kaspersky-labs.com (Postfix) with ESMTP id BD386C07A8A;
	Mon, 27 Jul 2026 14:46:26 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub16.kaspersky-labs.com (Postfix) with ESMTPS id 9711BC078CF;
	Mon, 27 Jul 2026 14:46:25 +0300 (MSK)
Received: from HQMAILSRV1.avp.ru (10.64.57.51) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 27 Jul
 2026 14:46:24 +0300
Received: from HQMAILSRV1.avp.ru ([fe80::487c:531c:bded:f724]) by
 HQMAILSRV1.avp.ru ([fe80::487c:531c:bded:f724%2]) with mapi id
 15.02.2562.045; Mon, 27 Jul 2026 14:46:24 +0300
From: "Sergey V. Frolov" <Sergey.V.Frolov@kaspersky.com>
To: "rkannoth@marvell.com" <rkannoth@marvell.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "sbhatta@marvell.com"
	<sbhatta@marvell.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"bbhushan2@marvell.com" <bbhushan2@marvell.com>, "gakula@marvell.com"
	<gakula@marvell.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"sgoutham@marvell.com" <sgoutham@marvell.com>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: octeontx2-pf: Fix UB in shift operation
Thread-Topic: [PATCH net] net: octeontx2-pf: Fix UB in shift operation
Thread-Index: AQHdG2cbGfNQf8WH/02d6/mTYwc6LraAhrYAgACLSgA=
Date: Mon, 27 Jul 2026 11:46:24 +0000
Message-ID: <159a6806dd1ea12bbd559f664ce30d306cdf1178.camel@kaspersky.com>
References: <20260724121941.2637908-1-Sergey.V.Frolov@kaspersky.com>
	 <ambQOBLp5yYDbRSr@rkannoth-OptiPlex-7090>
In-Reply-To: <ambQOBLp5yYDbRSr@rkannoth-OptiPlex-7090>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-kse-serverinfo: HQMAILSRV2.avp.ru, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 7/27/2026 9:10:00 AM
x-kse-bulkmessagesfiltering-scan-result: InTheLimit
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE71A4BF6ABC7C45BFA31E83F6811E9E@kaspersky.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/07/27 01:08:00 #28548458
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52

T24gTW9uLCAyMDI2LTA3LTI3IGF0IDA4OjU3ICswNTMwLCBSYXRoZWVzaCBLYW5ub3RoIHdyb3Rl
Og0KPiANCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBTZXJnZXkuVi5Gcm9sb3YgPFNlcmdleS5W
LkZyb2xvdkBrYXNwZXJza3kuY29tPg0KPiA+IC0tLQ0KPiA+IMKgZHJpdmVycy9uZXQvZXRoZXJu
ZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfdGMuYyB8IDExDQo+ID4gKysrKysrKystLS0N
Cj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+
ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9u
dHgyL25pYy9vdHgyX3RjLmMNCj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0
ZW9udHgyL25pYy9vdHgyX3RjLmMNCj4gPiBpbmRleCA0MDE2MmIwODAxNGQuLjM5YmQ3M2EyMTRh
ZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4
Mi9uaWMvb3R4Ml90Yy5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9v
Y3Rlb250eDIvbmljL290eDJfdGMuYw0KPiA+IEBAIC01MywxMCArNTMsMTUgQEAgc3RhdGljIHZv
aWQgb3R4Ml9nZXRfZWdyZXNzX2J1cnN0X2NmZyhzdHJ1Y3QNCj4gPiBvdHgyX25pYyAqbmljLCB1
MzIgYnVyc3QsDQo+ID4gwqDCoMKgwqDCoCBpZiAoYnVyc3QpIHsNCj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAqYnVyc3RfZXhwID0gaWxvZzIoYnVyc3QpID8gaWxvZzIoYnVyc3QpIC0g
MSA6IDA7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdG1wID0gYnVyc3QgLSByb3Vu
ZGRvd25fcG93X29mX3R3byhidXJzdCk7DQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAoYnVyc3QgPCBtYXhfbWFudGlzc2EpDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAoYnVyc3QgPD0gbWF4X21hbnRpc3NhKSB7DQo+IA0KPiBUaGFua3MuDQo+IGNhbiB3ZSBoYW5k
bGUgMjU1IGNhc2Ugd2l0aCA8PSA/IGl0IGxvb2tzIHNpbXBsZSB0byBtZS4NCg0KVGhhbmsgeW91
IGZvciByZXZpZXdpbmcgdGhlIHBhdGNoLiBJIHNlZSB0aGF0IHlvdXIgc2ltcGxpZmljYXRpb24g
d29ya3MNCndpdGggdGhlIGN1cnJlbnQgdmFsdWUgb2YgbWF4X21hbnRpc3NhICh3aGljaCBpcyAy
NTUpLg0KDQpIb3dldmVyLCBteSBjb25jZXJuIGlzIHRoYXQgdGhpcyBhcHByb2FjaCBpbnRyb2R1
Y2VzIGFuIGltcGxpY2l0DQpkZXBlbmRlbmN5IG9uIHRoZSBmYWN0IHRoYXQgbWF4X21hbnRpc3Nh
IG5ldmVyIGJlaW5nIGNoYW5nZWQuIElmIGluIHRoZQ0KZnV0dXJlIHNvbWVvbmUgdXBkYXRlcyB0
aGlzIGNvbnN0YW50IChlLmcuIHRvIHN1cHBvcnQgbmV3IGhhcmR3YXJlKSwNCnRoZSBzaGlmdCBv
cGVyYXRpb24gY291bGQgYmVjb21lIGludmFsaWQgYWdhaW4sIGFuZCB0aGUgVUIgd291bGQNCnJl
dHVybi4gaWYgbWF4X21hbnRpc3NhIGJlY29tZXMgMTI3LCB0aGVuIFVCIHdvdWxkIHJlYXBwZWFy
IGZvciBidXJzdA0KdmFsdWVzIGluIHRoZSByYW5nZSAxMjgtMjU1ICh3aGVyZSBidXJzdF9leHAg
d291bGQgYmUgNiwgbWFraW5nDQoqYnVyc3RfZXhwIC0gNyA9IC0xKS4NCg0KTXkgb3JpZ2luYWwg
cGF0Y2ggZXhwbGljaXRseSBoYW5kbGVzIGJvdGggY2FzZXMgKCpidXJzdF9leHAgPj0gNyBhbmQg
PA0KNyksIHNvIGl0J3Mgcm9idXN0IHJlZ2FyZGxlc3Mgb2YgbWF4X21hbnRpc3NhIHZhbHVlLiBJ
J2QgcHJlZmVyIHRvIGtlZXANCnRoZSBleHBsaWNpdCBjaGVjayB0byBhdm9pZCBpbnRyb2R1Y2lu
ZyBhIGhpZGRlbiBkZXBlbmRlbmN5IHRoYXQgbWlnaHQNCmFmZmVjdCBmdXR1cmUgbWFpbnRhaW5h
YmlsaXR5Lg0KDQpXaGF0IGRvIHlvdSB0aGluaz8NCg==
