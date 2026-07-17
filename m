Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257DF301719;
	Fri, 17 Jul 2026 08:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784277900; cv=none; b=N+qX3ThxZDMMijOiPbRad/yotfqPLfaVUeAfIYHb7oEiTbbgWCJzER6ybmNa3pOhpeLwkHtpAc8QcQDx0BOFeoRIfd9fFTa2OkA9lz3FCCphGPQBgva9cqznc1prqSXTZ6ejMlU4tj47p31jpAGn6UQyDkx8mc3pyxQn/AcM+24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784277900; c=relaxed/simple;
	bh=k9moxxAlmKUL+AOLfCjKJWdmTixXW6mvWZ3R25dM9OY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=fC6nBXT+81vY5mwwm43yLQwJi9Su6fPfbZa95+48YSfTRsmjqwWk9tjtNz1FOogbDEL/OoLQyqzSKIIw21Cybb0lvHRRSzMs8XAweMBYf0FmtCd+pI9WNsQRCrx/c53jye9sJdrsYK14mW41FlxMSs9xy6ZaL4rNzrPStjn2OkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Ef0VG249; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Ef0VG249"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784277890; x=1784882690; i=markus.elfring@web.de;
	bh=MQnV09/tKsz79dOOae7VOx64ZFsBqDWVjLz1NIYqmm4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ef0VG249vhn4z/Cs5QgiuFnFgOLj+nMHaHVoHfeDz9YWitRI8Vx9hr3hfpeL4Kpl
	 PeNngQvvKN7yLOaxf3OFnETFqKPTPiuiSJXkRWccZUfA49mSVnhoGJt7TpqiGAC2I
	 4ECDNVfesArvGKnsiHNHyd17+1emg9Ds3M7cYj9yEhUb4yn/MIFDqeqjHB73KkOGE
	 hujinpyZjWUFkviRh0qQbcsbP0Bm0m2ynR0/zExL+/HSgsVI0qv6p+NXWHsLaWTdB
	 OWxdyRX2ZpbvkjBb/NzoS5nMMW8ST6tmooJo1nMr3dEHNbn5vhUbG6tgDnh4PmJDe
	 an+PoXDRb1p8U3swGA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFs1t-1woCKi2XiZ-005eNb; Fri, 17
 Jul 2026 10:38:51 +0200
Message-ID: <7a9ea765-2c75-4a16-aaf9-510f2450beb3@web.de>
Date: Fri, 17 Jul 2026 10:38:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Julia Lawall <julia.lawall@inria.fr>,
 MD Danish Anwar <danishanwar@ti.com>, Michael Grzeschik <mgr@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Yibo Dong <dong100@mucse.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Dan Carpenter <error27@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v3 net-next] net: rnpgbe: Delete a null pointer check in
 rnpgbe_rm_adapter()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x+UV0m+eWOO1XhO60Lpz45AHQ4nJ+NNBCd2onjBtAtrYES1ekqE
 xMpQnMQpqnPEnA5Hf/B9VQTX5FewtzTSda7YqTX7azV/V08YDzqFjyMQRgNW9TL96q6DH3J
 X45CkB98N0UeeDwrQE6zEisnaDMTBvaW68jKdRpnxTmsLTBJyRmrPdU3mFvhrjU3TDARGCn
 ZP60yo+xgw0EypE7m5ydg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9cXsSGLgUog=;tPqINoeK4JKikTtv0InUZgJxCDC
 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
 LPoC6ideVJ4/

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 17 Jul 2026 10:20:15 +0200

The check for the pointer =E2=80=9Cmucse=E2=80=9D was identified as redund=
ant because
the relevant address information was preserved according to calls of
the functions =E2=80=9Cpci_set_drvdata=E2=80=9D and =E2=80=9Cpci_get_drvda=
ta=E2=80=9D.
Thus remove it.

This issue was detected by using the Coccinelle software.

See also:
Reconsidering pointer dereferences before null pointer checks (with SmPL)
2023-04-09
https://lore.kernel.org/cocci/1a11455f-ab57-dce0-1677-6beb8492a257@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-04/msg00021.html

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

v3:
Andrew Lunn and Julia Lawall requested an extended change description.

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

