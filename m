Received: from mail.crpt.ru (mail.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6543D7D82;
	Tue, 20 Jan 2026 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768910199; cv=none; b=uNe/EjO6tIMN9xpngqLTXqvNHco15aTUSuFc1oFhs26lEHzWT1Pbpz97v3CfAy1sEV5kvKzaFco/QPGE9qM6M7wO31/SkQ8qY3E4XHFbMnk4JTfkn+qzHF1srm7QUbiEiu6MJz8PJmWK9BM8HS0/B6VYewU7LN3Gq0UxnHKQSyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768910199; c=relaxed/simple;
	bh=AjUCQV+0ZNvzAYQsI4QBJ/Md9bip2Rrlr1UdMs91flA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Mrx4Uueu0tt6Yryaw+2UyeNsfZoGcRyW05vmAJez6+X/Frjw1wMb1fOmiSDWfQ37dcN+mQFgoMGFB6lEvA2+A84QNDZeBBMq5osgumQfIEidYJFo0AdH2FS8l87oH9DXAIlqvfysV3tUAuYWLzg5eAQaBl68ocZVbXjxvfUSbgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=YdfQ1Jkb; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="YdfQ1Jkb"
Received: from mail.crpt.ru ([192.168.60.3])
	by mail.crpt.ru  with ESMTPS id 60KBbmqQ019502-60KBbmqS019502
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Tue, 20 Jan 2026 14:37:48 +0300
Received: from EX2.crpt.local (192.168.60.4) by ex1.crpt.local (192.168.60.3)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 20 Jan
 2026 14:37:47 +0300
Received: from EX2.crpt.local ([192.168.60.4]) by EX2.crpt.local
 ([192.168.60.4]) with mapi id 15.01.2507.044; Tue, 20 Jan 2026 14:37:47 +0300
From: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>
To: Ajit Khaparde <ajit.khaparde@broadcom.com>
CC: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>, "Sriharsha
 Basavapatna" <sriharsha.basavapatna@broadcom.com>, Somnath Kotur
	<somnath.kotur@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sathya Perla
	<sathya.perla@emulex.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH net v2] be2net: Fix NULL pointer dereference in
 be_cmd_get_mac_from_list
Thread-Topic: [PATCH net v2] be2net: Fix NULL pointer dereference in
 be_cmd_get_mac_from_list
Thread-Index: AQHcigEzAO8KpSmFtkemZ9umV+yTZQ==
Date: Tue, 20 Jan 2026 11:37:47 +0000
Message-ID: <20260120113734.20193-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX1.crpt.local, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 1/19/2026 10:43:00 PM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLVxYWC48UVlRWFhYWVxaSFlRSAlGHgkcBxoHGAEGKAsaGBxGGh1IWUhaXkgJAgEcRgMACRgJGgwNKAoaBwkMCwcFRgsHBUhYSFpIWVpIWVFaRlleUEZeWEZbSFBIWEhYSFFIWEhYSFhIWl5ICQIBHEYDAAkYCRoMDSgKGgcJDAsHBUYLBwVIWEhaWUgJBgwaDR9DBg0cDA0eKAQdBgZGCwBIWEhZUUgMCR4NBSgMCR4NBQQHDhxGBg0cSFhIWVFIDQwdBQkSDRwoDwcHDwQNRgsHBUhYSFldSAMdCgkoAw0aBg0ERgcaD0hYSFpQSAQBBh0QRQMNGgYNBCgeDw0aRgMNGgYNBEYHGg9IWEhaUEgEHgtFGBoHAg0LHCgEAQYdEBwNGxwBBg9GBxoPSFhIWV9IGAkKDQYBKBoNDAAJHEYLBwVIWEhaW0gbCRwAEQlGGA0aBAkoDQUdBA0QRgsHBUhY
X-FEAS-Client-IP: 192.168.60.3
X-FE-Policy-ID: 2:4:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:content-type:mime-version;
 bh=Coe3+UgHVobMkDtE4KIfnGaSYyOVRLXavLpJDyQRF4w=;
 b=YdfQ1JkbS/gW3/68riQTm5ob9PN+h7Li0wdvbIKh3WFtM1a1JQPsR/O9v951Qtgg+N6o1OsR6IjZ
	N65sRfF21BsO/N+0Hia4EfN+2WDskuEXfdCrgOvSegnbXgGIU/y8vxctzqPqxZ2OQK1STnsqq3pY
	FgPJb5KqyWi4ceY6eFTax9c04pqa0fv4IVItJxJvd/XbJp54n0Xn/vTuU1MVkeucos6oDJZIlxyw
	mO5ghP9LKLWkqAowft50BWTfNsCwB/0/GtYhSiJUNFH2eA/b7Mfs/m9tZK8h+KvO8cNv7chDd80r
	3deQoxgXq8RffcLBSz9OHpRjDn++ZVdBxS/Zbw==

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

When the parameter pmac_id_valid argument of be_cmd_get_mac_from_list() is
set to false, the driver may request the PMAC_ID from the firmware of the
network card, and this function will store that PMAC_ID at the provided
address pmac_id. This is the contract of this function.

However, there is a location within the driver where both
pmac_id_valid =3D=3D false and pmac_id =3D=3D NULL are being passed. This c=
ould
result in dereferencing a NULL pointer.

To resolve this issue, it is necessary to pass the address of a stub
variable to the function.

Found by Linux Verification Center (linuxtesting.org) with SVACE.
      =20
Fixes: 95046b927a54 ("be2net: refactor MAC-addr setup code")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
---
v1->v2: fix the problem by passing an address of a stub variable.

Link to v1: https://lore.kernel.org/netdev/20250416105542.118371-1-a.vatoro=
pin@crpt.ru/

 drivers/net/ethernet/emulex/benet/be_cmds.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/ethe=
rnet/emulex/benet/be_cmds.c
index bb5d2fa15736..8ed45bceb537 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.c
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
@@ -3801,6 +3801,7 @@ int be_cmd_get_perm_mac(struct be_adapter *adapter, u=
8 *mac)
 {
 	int status;
 	bool pmac_valid =3D false;
+	u32 pmac_id;
=20
 	eth_zero_addr(mac);
=20
@@ -3813,7 +3814,7 @@ int be_cmd_get_perm_mac(struct be_adapter *adapter, u=
8 *mac)
 						       adapter->if_handle, 0);
 	} else {
 		status =3D be_cmd_get_mac_from_list(adapter, mac, &pmac_valid,
-						  NULL, adapter->if_handle, 0);
+						  &pmac_id, adapter->if_handle, 0);
 	}
=20
 	return status;
--=20
2.43.0
