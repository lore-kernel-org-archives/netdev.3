Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486779;
	b=bEKUis1LqxZcD9Cm0//l/Rpd877mRoAV1/6hBWGuTa1kZ892SujtJYXxoW+mLVxIOpAB
	 gp9yGew+RehOhJHFBZvqHfvr9d2wZMWZ7NJ9oi+xys/VgP/uwuk/F0H/7Egh3wsBxNj5Z
	 Tar9JumVTMiPEatew3zPPX27mhOFb7jQoZAkR1GgvGrponRpRXDeh7WHNl309IN50lmGK
	 8uKkM5v7aDqcKRMfWizwCj4OsaXNyrswcZNp7nAXaPplH4U8TnRBVUpIyNdudOYpQQWFp
	 zinAIQHrpXLtLnwhpnIMYi4e+Ks+6h0yItLDEpSdert4X40npgB+/OOSgg07f4p1cDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486779;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer;
	bh=/3Wq3q5zJibO+/ypQKvyVSj+5oRUgcCIqCtsRgxRLW0=;
	b=viMspqbKPXC6d6Xev/EFeQoLsjP0DkR3SPVqX8YpGBaCXC48WGqFR+ma8LhDpbcK7alj
	 3jFtjq4rNC/K98dkAl2hrDdJjjpQezdCcD4tbCtxTcwvd5VhLZXNAKPlW+Lw7BH/HFuqi
	 O+L9ADMm3PO1He9O3UdoI0/DAZRrFjnAnX+JukVIuHKjRG8IQU0i06dgolUxGy5DQU5Cu
	 9UQzVvRirNcjkyH6/bjxh5Uhr+BmilZhZksG2F2QcxQgKgQEolBMTVZWAqxUuGwUmxtzj
	 i1d449LXxMfQgJ+7pjaVEX0MwpVIPlaxSqHoAeyEO8Lw/mvaeG1fW13yhSbiX9Oaztw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=db1Q3yN4;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F311D606A31A;
	Tue, 20 Oct 2026 08:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F311D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=db1Q3yN4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792486778; x=1824022778;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=PqqolydTHxuVAc5gOeVz22tU0KJ0OwLnMV9tvA+bGuU=;
  b=db1Q3yN4b+9HIq9mjFjQ/d/XJGUdxrOtlznbX7p3bI1d39TImZVsoW25
   l4jSD+aMBO0PBTaREZOwjX747YVaKdMWG3H7LP/7WjUfTWHD02JQ/sBfC
   JSLKbWuRT/PcD5JJI5/khgIn0LZnGBQM3ecOS3Q++xiXM/DAHISukTE19
   3432rYl+MzRSiSwQ+5d/zCucTC68y2dCQIBTKc2DlruvI3yyXs9/L2H9s
   hfT4ICUJSb/30jOHbYE1/9z7ztVR7GjNO2PUJQ/pkzsv49A8Vhm29MkxT
   LT4fDkFyYxBAxFQiLOiRNlVGx3q5Jfh8xC8FV3OCrOmaFOCczcUGiAvNH
   g==;
X-CSE-ConnectionGUID: mf+Nmy+dQleBqoTYdmd+ZQ==
X-CSE-MsgGUID: XdUIh4SQQRK1L1Hc3PtmAw==
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="232382489"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 01:59:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Tue, 20 Oct 2026 01:59:37 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 20 Oct 2026 01:59:35 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Tue, 20 Oct 2026 10:59:32 +0200
Subject: [PATCH net] net: sparx5: don't reuse the last DCB in fdma xmit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261020-sparx5-fdma-last-dcb-v1-1-fb9a956196dd@microchip.com>
X-B4-Tracking: v=1; b=H4sIAHMt12oC/x3MSwqAMAwA0atI1gZs0fq5irioNmpAqzQiQvHuF
 pdvMRNBKDAJdFmEQDcLHz5B5RlMq/ULIbtk0IU2qlAtymnDU+HsdoublQvdNCJpaspWjbVrDKT
 0DDTz82978HTB8L4fdiu4cWsAAAA=
X-Change-ID: 20261019-sparx5-fdma-last-dcb-e2e8491b7d86
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3

sparx5_fdma_xmit() advances dcb_index to the next tx DCB and, if the
FDMA is done with it, adds it to the end of the chain, which makes it
the new fdma->last_dcb.

Before this patch, sparx5_fdma_xmit() can pick last_dcb itself. A
failed transmit advances dcb_index without adding a DCB, so dcb_index
no longer follows last_dcb, and after a burst of failures it can land
on it. Re-adding last_dcb loses the frame, because the FDMA has already
passed the tail of the chain.

Also reject the DCB when it is the last one in the chain, using the
same !fdma_is_last() guard that lan966x and lan969x use to pick their
next tx DCB, so the tail is never re-added.

Found by an AI code review agent and confirmed by code inspection; not
reproduced. Tested on sparx5 that traffic still passes, with ping floods
in both directions.

Fixes: f4aa7e361ae2 ("net: sparx5: use FDMA library for adding DCB's in the tx path")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
index dbe86f937b21..221b2f1932f6 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
@@ -218,7 +218,8 @@ int sparx5_fdma_xmit(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb,
 	void *virt_addr;
 
 	fdma_dcb_advance(fdma);
-	if (!fdma_db_is_done(fdma_db_get(fdma, fdma->dcb_index, 0)))
+	if (!fdma_db_is_done(fdma_db_get(fdma, fdma->dcb_index, 0)) ||
+	    fdma_is_last(fdma, fdma_dcb_next_get(fdma)))
 		return -EINVAL;
 
 	/* Get the virtual address of the dataptr for the next DB */

---
base-commit: 07bd391eb9572e74f073c49acef327611234f9bb
change-id: 20261019-sparx5-fdma-last-dcb-e2e8491b7d86

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>

