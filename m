Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406A03C3C0F;
	Thu, 16 Jul 2026 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784222809; cv=none; b=TN0i8lPQQexLisgUzoGhCDTzud2CvLDBq1dyTE7WZlkfR+co12Zncs6hyUYCH1kSKoX7vHC5uRRypK7z9gVa3ntYk6AqUqdvzfYwO0V8kXzIyrHJyC9XyX8WdMx77Z50vIH68ciDjtxz848ejHgkTRdRVewefAY0ZBunXACSvuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784222809; c=relaxed/simple;
	bh=L9h5wu20ohecEiH1WXkDx9IdCbCtMD9lZ96pqTXHAUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JUPt393EB2SZ3+fczOrZc3A+z6AKf3wVdWcqQkS7LHyVTFQNgiHs+FrGFljk5rL+9F2MBRwzb05iv4puG2HHizQW8kbp4T1QqpHVJMEyk+jo4yEvIyU3WO9ZqLZBiP4AitMAcuZ29kpGuGyzDgL/LDn1FARlEnIK0fgVl7domfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=qAWgi3Ts; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="qAWgi3Ts"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784222784; x=1784827584; i=markus.elfring@web.de;
	bh=L6gwJqLqxaoGhg0oY8Kt/34kaJKBJ68NiKcLDHnnk9Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qAWgi3TsIKHSxWU1iQOy+zSgTj+4TuEwHoctuaxXlHYbe0N8LPGDYHbHlGKEmWHL
	 2v8f9NFwXg119GQCECVXyzKXBIU8LxUqE7Xvakrz1fcAV5qRd7mxqkjuFAXm38uPs
	 +EZN+3UPRJkyTe2jJohRiNrFZ6mADHsQwo0qt59uDlnItkiLoQYirMyzZZ+WSeruO
	 Tw3tG9HFCpti25iVLVdqHcfQrmvpV5YxmS4ug1Wz3rhoXPKpwxcOqBJp535SBaNpY
	 dbdXVDg2b8zQGz/hAhpn82I9uYA0M9QfzOooqkDVpUYk0uoOomI3OgvLiLmvGbuU/
	 R9QmrY+bjk4uEywsVw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MxYXF-1wvL6P2r8b-011Hcg; Thu, 16
 Jul 2026 19:26:24 +0200
Message-ID: <a4fe0527-6302-45dc-b4be-40282c2673b6@web.de>
Date: Thu, 16 Jul 2026 19:26:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 net-next] net: rnpgbe: Delete a null pointer check in
 rnpgbe_rm_adapter()
To: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
 Michael Grzeschik <mgr@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Yibo Dong <dong100@mucse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Dan Carpenter <error27@gmail.com>
References: <7958e26e-a4f9-48ee-8d79-3797016944c5@web.de>
 <alScHkiC3EmGzOlI@stanley.mountain>
 <8110bb3f-70d9-4f0f-82f2-ffe1262b2962@web.de> <aleFN4Z2XT3NP3od@monoceros>
 <85ad473e-b2f5-4458-8973-a643f90eda5e@web.de>
 <alikx3W3NX7r9o99@stanley.mountain>
 <95abcefe-2211-4abb-9af2-7e8d7f4a9b76@web.de>
 <062f9181-e494-4576-bedb-36de488c11ca@lunn.ch>
 <aljdzTZ_f5v6ckVg@stanley.mountain>
 <d70814de-30b3-4315-9455-db58477ab085@lunn.ch>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d70814de-30b3-4315-9455-db58477ab085@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sbYLv/DTHcS1o0cOl2abhPdSacET5M7C1nYx8dZysxHVsmvKvD7
 978sTh32ZpjHIKWdKqJyVl4qm2x6tJxg5Qicl98mJfH/abH+Izn+jmgRk7xJOF7pQebT2TJ
 BVKeVYDkojxUuN9zKTPJJhBkKfih83eczvXl1obCsK3HO7JduLhmYQap1BPhz2uK+z+jjXS
 YC0w+t6pfBssfFYctaLxw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:G3/pHwe39GI=;qP1uTjenT+RiER6+glxvlrWUaSz
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 16 Jul 2026 19:15:06 +0200

The check for the pointer =E2=80=9Cmucse=E2=80=9D was finally identified a=
s undesirable.
Thus remove it.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

v2:
Andrew Lunn requested the removal of a null pointer check.


 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net=
/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 70a2b0082ba8..82a3fbfb3c0a 100644
=2D-- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -249,8 +249,6 @@ static void rnpgbe_rm_adapter(struct pci_dev *pdev)
 	struct net_device *netdev;
 	int err;
=20
-	if (!mucse)
-		return;
 	netdev =3D mucse->netdev;
 	unregister_netdev(netdev);
 	err =3D rnpgbe_send_notify(hw, false, mucse_fw_powerup);
=2D-=20
2.55.0

