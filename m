Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B09495AD4;
	Fri,  2 Oct 2026 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950215; cv=none; b=iYvYD6ZqmKk7JIKr91CpmDpgxv3HmVxPgMRqiGYRcAj20bvSlyjcOV8ilz88pKtTD7tBchedscDCuO8RNVGk++vVu+0ex4/voaLwfT4bEqSkoiiwYyhB5/op80biHWICJ5PTXoUYkbwDRvUPpWTYBiJr+RCSFAXpRdFjtQHNl0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950215; c=relaxed/simple;
	bh=eN64Jtm0RyiqhEnVkaBACJmJI5hbpst180W4w5c450I=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:MIME-Version; b=Ej2bLX8Xl09XFrf3KY70bKqhOAneV2JWNi58zZhvT7mopX+k/18xtvHL6zXgypos+Pi4AOYjYmQbSoM8PpwYauWHNB1WWMbSNK7zTfDMhqr0CuNCmlqa9J4k43ivtW5lWoiGLQw9V1v52W+uGpoh2MLZu7DEdOod/rwrTNdo/i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=qb/xA+qx; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="qb/xA+qx"
Content-Language: ru-RU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1790950212; h=from:to:date:message-id:subject;
	bh=eN64Jtm0RyiqhEnVkaBACJmJI5hbpst180W4w5c450I=;
	b=qb/xA+qxxB2dswVzWyIx1IQqZlUidI8s5ltJ0GC2dWpHfxrGRiTmsc9Uv9Ho6SRvP+DxUuWYXYL
	Je3CqBP78Z4glpiuZRzR8KRof30Zs1K8tDBnuzVzkY8+yEqN02FseeF8GxQkV09MJW9LNmRsayTzB
	m0nl5uEkATK5DfDGBQrpSp9mT3eqHSD0zS/FnpAQOfWhDHL298MiCT1wnboJnMxlrNFLdSu9aWmLS
	NFD9H2vnDPVl5xPkq3J4kJwChdPCydNoBc0etEqZnmnFXzQylL0YXPJpZ33QcLt2csjqOF2Ax+U7r
	yeJCfKMKC+6gqZVH06e248pyhl4StcAcmF1A==
Received: from ECHO-3.prosoft.ural.ru (172.25.100.229) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Fri, 2 Oct
 2026 19:10:11 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 ECHO-3.prosoft.ural.ru (172.25.100.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 2 Oct 2026 19:10:07 +0500
Received: from echo-2.prosoft.ural.ru ([::1]) by echo-2.prosoft.ural.ru
 ([fe80::c1a2:90f7:8820:c669%17]) with mapi id 15.02.1748.039; Fri, 2 Oct 2026
 19:10:07 +0500
From: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
 =?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>
To: Andrew Lunn <andrew+netdev@lunn.ch>
CC: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
 =?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Michael
 Grzeschik" <mgr@kernel.org>, Jijie Shao <shaojijie@huawei.com>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>, Denis Benato
	<benato.denis96@gmail.com>,
	=?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
	<u.kleine-koenig@baylibre.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: [PATCH net v2 0/3] net: fealnx: fix card-index overflow and PCI
 device teardown
Thread-Topic: [PATCH net v2 0/3] net: fealnx: fix card-index overflow and PCI
 device teardown
Thread-Index: AQHdUne62MTefemLtkmJUzgYZc/gMA==
Date: Fri, 2 Oct 2026 14:10:07 +0000
Message-ID: <20261002140954.261779-1-r.zhambakiev@prosoftsystems.ru>
Accept-Language: ru-RU, en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

RnJvbTogUmFkaXkgWmhhbWJha2lldiA8ci56aGFtYmFraWV2QHByb3NvZnRzeXN0ZW1zLnJ1Pg0K
DQpDaGFuZ2VzIHNpbmNlIHYxOg0KICAtIERyb3BwZWQgdGhlIHJlZmFjdG9yaW5nIHBhcnQgZnJv
bSB0aGUgcGF0Y2hlcy4NCg0KTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYw
OTMwMjIzNzIwLkdBOTM5NzZAZWxlY3RyaWMtZXllLmZyLnpvcmVpbC5jb20vDQoNClJhZGl5IFpo
YW1iYWtpZXYgKDMpOg0KICBuZXQ6IGZlYWxueDogZml4IHRlYXJkb3duIG9yZGVyIGluIHJlbW92
ZQ0KICBuZXQ6IGZlYWxueDogZGlzYWJsZSB0aGUgUENJIGRldmljZSBvbiByZW1vdmUgYW5kIHBy
b2JlIGZhaWx1cmUNCiAgbmV0OiBmZWFsbng6IGFsbG9jYXRlIHRoZSBjYXJkIGluZGV4IGZyb20g
YW4gSURBDQoNCiBkcml2ZXJzL25ldC9ldGhlcm5ldC9mZWFsbnguYyB8IDM5ICsrKysrKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMo
KyksIDExIGRlbGV0aW9ucygtKQ0KDQotLSANCjIuNTMuMA0K
