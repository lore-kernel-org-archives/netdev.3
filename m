Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B4E3D331D
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 11:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409750; cv=none; b=Gy1CXHCfZsSXyVsh82Sk79K1Q+OZ1w6Oh/AZbz3I53/DR96P4rbpjIYn0ZHv6vOXJjUofArFiQUDj7j2hhBN3XwLS+ipSA2HiMvkickJp470YYntBXl02Rwrtr87Re3+PCcqJXrJogtn7WzOeI4iFRzCNitdDgiCoBIDuMgUCFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409750; c=relaxed/simple;
	bh=8cfzRbtoqrJN9dOIOSF6x41DP1GhDqIoM4qDGEqk/aY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=r3Yd0IaIIXhqvJApp67aeQvlpOBOThm3nABv8FXK7a6aig0RUipb/J65e7Mkuzwu+/rwJJQH607hQ5wz6lzSLv41nx0glALm91cER6OsLGAlGOoGJnZX3OzrHEonbewyXkvVXL4Cxvy4GngJeFSXb023hdszjcjFrmhH16scETw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=cpmG/2PA; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="cpmG/2PA"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 2BCB020743
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:35:45 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qSHPKy_BOO4J for <netdev@vger.kernel.org>;
 Mon, 19 Oct 2026 13:35:44 +0200 (CEST)
Received: from EXCH-03.secunet.de (r13.secunet.de [10.32.0.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 7199420841
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:35:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 7199420841
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1792409744;
	bh=8cfzRbtoqrJN9dOIOSF6x41DP1GhDqIoM4qDGEqk/aY=;
	h=From:To:Subject:Date:From;
	b=cpmG/2PAj35ThsxGYpF+4HsSccIUa4sYhcQuCrz8C/FTOmPKrXSebydiWYEDpTeB1
	 1q0FdLwUKC+WQ10IyUaZJx4sG5gVNn/myzF+RtRtnJGAYq6m7kJMfMTRx3xO+xZ+ZE
	 gn3Q54a9sxv010w24Kkq+Q+rFZCFzwI55+sNb48vGWzs7zbVZACTbpJGAY/nyIeCrc
	 GYoOo+eD2IsJAgAQAirS0Yl5/LUb9s82dKpY07xvV+wBSDgNw3ueokBv7751s6zwed
	 BdXpZWCSYbDRz+Zmy39UqAAs8kWuzfDcoUMBNW25FeercF+yBzbGo3q5d+l4aME5P6
	 FPYBh3kCtIBlg==
Received: from EXCH-01.secunet.de (10.32.0.171) by EXCH-03.secunet.de
 (10.32.0.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 19 Oct
 2026 13:35:43 +0200
Received: from EXCH-01.secunet.de ([fe80::1c90:c91c:1edc:d47]) by
 EXCH-01.secunet.de ([fe80::1c90:c91c:1edc:d47%19]) with mapi id
 15.02.2562.049; Mon, 19 Oct 2026 13:35:43 +0200
From: "Girlich, Franz" <franz.girlich@secunet.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: IPv6: wrong routing from local socket with multiple routing tables
Thread-Topic: IPv6: wrong routing from local socket with multiple routing
 tables
Thread-Index: AQHdX735Ly1YaUG33k+u/F5J/gz9mg==
Date: Mon, 19 Oct 2026 11:35:43 +0000
Message-ID: <84e3ec2178897680e510842e4282d691984bf20f.camel@secunet.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F4244E25049E64A883F5D183A8F2380@secunet.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkhDQoNCklQdjYgcm91dGluZyBmcm9tIGEgbG9jYWwgc29ja2V0IGJyZWFrcyB3aGVuIHVzaW5n
IG11bHRpcGxlIHJvdXRpbmcNCnRhYmxlcyBhbmQgY2hhbmdpbmcgdGhlbSB3aGlsZSB0aGUgc29j
a2V0IGlzIGluIHVzZS4gV2hlbiBhIGRpZmZlcmVudA0Kcm91dGluZyB0YWJsZSBpcyBjaGFuZ2Vk
LCBpLmUuLCBvbmUgbm90ICJ1c2VkIiBieSB0aGUgbG9jYWwgc29ja2V0LCBzbw0KdGhhdCB0aGUg
YmVzdCBwYXRoIGZvciB0aGUgc29ja2V0IGNoYW5nZXMsIHBhY2tldHMgZnJvbSB0aGUgc29ja2V0
DQpzdGlsbCB1c2UgdGhlIG9sZCBwYXRoLg0KDQpUaGUgYmVoYXZpb3IgZml4ZXMgaXRzZWxmLCB3
aGVuIHRoZSByb3V0aW5nIHJ1bGVzIGFyZSB0b3VjaGVkLCB0aGUNCnRhYmxlIGN1cnJlbnRseSBp
biB1c2UgaXMgdG91Y2hlZCwgb3IgdGhlIHNvY2tldCBpcyByZS1vcGVuZWQuDQoNCkkgd2FzIGFi
bGUgdG8gcmVwcm9kdWNlIHRoaXMgYnVnIHdpdGggbXVsdGlwbGUga2VybmVsIHZlcnNpb25zLA0K
aW5jbHVkaW5nIGN1cnJlbnQgbWFzdGVyIDcuMy4wLXJjNyBhbmQgNi4xMi4xMTMgTFRTOiANCg0K
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIyBhZGQgMiBkdW1teSBpbnRlcmZhY2VzDQpp
cCBsaW5rIGFkZCBkMCB0eXBlIGR1bW15DQppcCBsaW5rIHNldCBkMCB1cA0KaXAgbGluayBhZGQg
ZDEgdHlwZSBkdW1teQ0KaXAgbGluayBzZXQgZDEgdXANCg0KIyBzZXR1cCAyIHRhYmxlLCBhZGQg
ZGVmYXVsdCByb3V0ZSB0byBsb3dlciBwcmlvIG9uZQ0KaXAgLTYgcnVsZSBhZGQgcHJpbyAxMCBs
b29rdXAgMTANCmlwIC02IHJ1bGUgYWRkIHByaW8gMjAgbG9va3VwIDIwDQppcCAtNiByb3V0ZSBh
ZGQgdGFibGUgMjAgZGVmYXVsdCBkZXYgZDENCg0KIyBzdGFydCB0cmFmZmljIGZyb20gYSBsb2Nh
bCBzb2NrZXQNCmlwZXJmIC11IC1jIGZjOjoxIC10MCAmDQoNCiMgcGFja2V0cyBhcmUgcm91dGVk
IGNvcnJlY3RseSB0byBkMQ0KdGNwZHVtcCAtbmkgYW55IC1jIDEwDQoNCiMgYWRkIHJvdXRlIHRv
IGhpZ2hlciBwcmlvIHRhYmxlDQppcCAtNiByb3V0ZSBhZGQgdGFibGUgMTAgZGVmYXVsdCBkZXYg
ZDANCg0KIyByb3V0aW5nIGxvb2t1cCBjb3JyZWN0bHkgcHJvZHVjZXMgcm91dGUgdG8gZDANCmlw
IC02IHJvdXRlIGdldCBmYzo6MQ0KDQojIEJVRzogdHJhZmZpYyBmcm9tIG9sZCBzb2NrZXQgaXMg
c3RpbGwgcm91dGVkIHRvIGQxIGluc3RlYWQgb2YgZDANCnRjcGR1bXAgLW5pIGFueSAtYyAxMA0K
DQojIGNsZWFudXANCnBraWxsIGlwZXJmDQppcCAtNiBydWxlIGRlbCBwcmlvIDEwDQppcCAtNiBy
dWxlIGRlbCBwcmlvIDIwDQppcCAtNiByb3V0ZSBmbHVzaCB0YWJsZSAyMA0KaXAgLTYgcm91dGUg
Zmx1c2ggdGFibGUgMTANCmlwIGxpbmsgZGVsIGQwDQppcCBsaW5rIGRlbCBkMQ0KLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpJIHVzZWQgZGVlcHNlZWstdjQuMS1mbGFzaCB0byBhdHRl
bXB0IGEgZml4IGZvciB0aGlzIGlzc3VlLiBUaGUgZml4DQpkb2VzIHdvcmsgZm9yIHRoZSByZXBy
b2R1Y3Rpb24gYWJvdmUsIGJ1dCBJIGFtIG5vdCBjb25maWRlbnQgdGhhdCBpdCBpcw0KcmVncmVz
c2lvbiBmcmVlLiBTbyBJIGFtIGF0dGFjaGluZyBpdCBmb3IgcmVmZXJlbmNlIG9ubHkuDQoNCi0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCmRpZmYgLS1naXQgYS9uZXQvaXB2Ni9pcDZfZmli
LmMgYi9uZXQvaXB2Ni9pcDZfZmliLmMNCmluZGV4IDlmZjc2MTk2Mi4uNTE2MTc2NTk5IDEwMDY0
NA0KLS0tIGEvbmV0L2lwdjYvaXA2X2ZpYi5jDQorKysgYi9uZXQvaXB2Ni9pcDZfZmliLmMNCkBA
IC0yMDU5LDYgKzIwNTksOCBAQCBzdGF0aWMgdm9pZCBmaWI2X2RlbF9yb3V0ZShzdHJ1Y3QgZmli
Nl90YWJsZQ0KKnRhYmxlLCBzdHJ1Y3QgZmliNl9ub2RlICpmbiwNCiAgICAgICAgaWYgKCFpbmZv
LT5za2lwX25vdGlmeSkNCiAgICAgICAgICAgICAgICBpbmV0Nl9ydF9kZWxfbm90aWZ5KHJ0LCBp
bmZvLCBkZWxfcmVhc29uKTsNCg0KKyAgICAgICBmaWI2X25ld19zZXJudW0obmV0KTsNCisNCiAg
ICAgICAgZmliNl9pbmZvX3JlbGVhc2UocnQpOw0KIH0NCg0KZGlmZiAtLWdpdCBhL25ldC9pcHY2
L3JvdXRlLmMgYi9uZXQvaXB2Ni9yb3V0ZS5jDQppbmRleCBhNWU5NTVlNTYuLmIyMWVmNzBmMSAx
MDA2NDQNCi0tLSBhL25ldC9pcHY2L3JvdXRlLmMNCisrKyBiL25ldC9pcHY2L3JvdXRlLmMNCkBA
IC0xNDMwLDggKzE0MzAsNyBAQCBzdGF0aWMgc3RydWN0IHJ0Nl9pbmZvICppcDZfcnRfcGNwdV9h
bGxvYyhjb25zdA0Kc3RydWN0IGZpYjZfcmVzdWx0ICpyZXMpDQogICAgICAgIGlwNl9ydF9jb3B5
X2luaXQocGNwdV9ydCwgcmVzKTsNCiAgICAgICAgcGNwdV9ydC0+cnQ2aV9mbGFncyB8PSBSVEZf
UENQVTsNCg0KLSAgICAgICBpZiAoZjZpLT5uaCkNCi0gICAgICAgICAgICAgICBwY3B1X3J0LT5z
ZXJudW0gPSBydF9nZW5pZF9pcHY2KGRldl9uZXQoZGV2KSk7DQorICAgICAgIHBjcHVfcnQtPnNl
cm51bSA9IHJ0X2dlbmlkX2lwdjYoZGV2X25ldChkZXYpKTsNCg0KICAgICAgICByZXR1cm4gcGNw
dV9ydDsNCiB9DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCg0KLS0gDQpGcmFueiBH
aXJsaWNoDQpTZW5pb3IgU29mdHdhcmUgRGV2ZWxvcGVyDQpQQSBQRCBOZXR3b3JrDQpEaXZpc2lv
biBQdWJsaWMgQXV0aG9yaXRpZXMNCnNlY3VuZXQgU2VjdXJpdHkgTmV0d29ya3MgQUcNCg0KVGVs
LjogKzQ5IDIwMSA1NDU0IDEwOTkNCkUtTWFpbDogZnJhbnouZ2lybGljaEBzZWN1bmV0LmNvbQ0K
V2VybmVyLXZvbi1TaWVtZW5zLVN0cmHDn2UgNiwgOTg2OTMgSWxtZW5hdQ0Kd3d3LnNlY3VuZXQu
Y29tDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18NCg0Kc2VjdW5ldCBTZWN1cml0eSBOZXR3b3JrcyBBRw0KU2l0
ejogS3VyZsO8cnN0ZW5zdHJhw59lIDU4LCA0NTEzOCBFc3NlbiwgRGV1dHNjaGxhbmQNCkFtdHNn
ZXJpY2h0IEVzc2VuIEhSQiAxMzYxNQ0KVm9yc3RhbmQ6IE1hcmMtSnVsaWFuIFNpZXdlcnQgKFZv
cnMuKSwgVG9yc3RlbiBIZW5uLCBEci4gS2FpIE1hcnRpdXMsDQpBdWZzaWNodHNyYXRzdm9yc2l0
emVuZGVyOiBEci4gUmFsZiBXaW50ZXJnZXJzdA0KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KDQo=
