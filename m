Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4723F38BF97;
	Wed,  9 Sep 2026 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975062; cv=none; b=WlYvdmWZT+AiRqEuShsWyTLJtSNWCcbdf0PN7G3ZdJA5n/1L1TijWN1r3jeSVhGvx3O5y/G+r1Memc+DXMD98ZlSZyeM6irqlm+vaHQTYMGmGKp/Wt6pt5rK5BpZMcjK4hdr6bGJlQfhuEhmTQrN7Ceg8QMNgDWb1cBSBCqNmJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975062; c=relaxed/simple;
	bh=hSAdOWtlVWhEw5isQol0W5FJllngNHJ4Hq5nmctpjro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pMXvMAQXSJXPjplCpll4ZtwMiEHs1MEtRZVbvkVwPgrWCeyatioMnpGYGLxmBy4iCjUqujuP3UEKty953jf/yTWEOCUgBZVcy7Q8Rz97wBbbmyDWeBhsIB+qmH6zgqY2Sy7UZtPNXUu8aGH5d7GFqdKpS5AuTpWG/mmn2APUzc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=PwteYLGJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x/gs61UN; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="PwteYLGJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x/gs61UN"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id CFE6E1D0010B;
	Wed,  9 Sep 2026 13:30:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 09 Sep 2026 13:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788975058;
	 x=1789061458; bh=T8k+avs8lR3xZvvDuzR3e4makBnhsvUEK4t2dzJBoIE=; b=
	PwteYLGJ4JSPKyGeS1MqdFC8GkxmyqhwvOMJmycNqLeWR5RWu9BEvl6dYhcxBFTF
	gwd13HF0iHGkIXps3DgzGT9ZZxdYXbxGrQOBrVpeARYtehR59/swViN24dKATK+t
	QzyyLiSN/gTjOBc++EOe3V4eiawSErpVShnqR2Ll9tE0PWwFwGkXucP9HIpXM1dn
	ueu8z4q3lXn1qkgoC+cU26oMSlKxSqCgPHC7c5eNDQQb6lcV90JuSdjfZ/jreS/c
	MxFFx/O0TZ3WnVEPRhxi9fHY4GXCUy65Uk1oGoa20h6ww4GY61UyaiQMcBefNKm3
	7u9GZKO8+2NM0f8wwLH+Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788975058; x=
	1789061458; bh=T8k+avs8lR3xZvvDuzR3e4makBnhsvUEK4t2dzJBoIE=; b=x
	/gs61UNSMh9aineH5PMGz9mKC3P4usWCar1wmYaTJMpRxp2i/v2ngvg439qcL2+7
	xsAtPTP6WtSQpHZQKXE03FV9cjNFyklTkhNYwE77s9uBm8EUeK7NJIZ/nGJVpDAe
	ZnC6b36Ped/FW4aH9n3kMswmRJTs/eUQQ+V0xRzOQEJZzefnW/H16z/9igHibolp
	w6hz7osRO45zuspZQPAnOnUbqu5i2CR6gI4BMkMbC0qzsWWrSHGvtzEd9iY56vlr
	/jW8lhnb5G3uG709Tyw+WNRwqJPJzovX/JJ495p5QTmEt6dbRdnBLDygAFNxulC2
	h2tdS7jDzaFAjUt9vSYyQ==
X-ME-Sender: <xms:0pehanJGrAMt5iQ4JHVj_ak4SvpsnEQ23RyCsqXZHYlyz55IuWc9zg>
    <xme:0pehaiHInzk9EqWwNSdYbFGbr4sD8eKbxDXVOaDml-1WLL6rSWB4awSJJ44MTZ7aT
    PZcb8DWLo-mcbHUKBTmhOBnEZa4vla11IL2NBd8dBeuvTT92YMF9njk>
X-ME-Received: <xmr:0pehakwuMeVEcQEQ_P48u_mgi3CJ_JTQ3-M5g0ldJznQNF4yVFauUgCPqxk5qOLwOCqGJhNy7Tj0D1-i5mFiTtbLD9Daf2k>
X-ME-Proxy-Cause: dmFkZTFpKuOoHA8K6npXM0EyPQ3B6fuJj1V92yxTkRTwTvOrGLmaogCPSGJNdxe3w3n+ts
    3Bnq9S0gANJKKK31pjNWK50OZ9a7PMq2fNO8DZXCQ+/ff2Kmc+UHBXNITlDnGREVxg/f50
    czaZu7ewfHhQ8KEOahciUDlJaktTnHuAyQxRzBwFm86u+eYYubMr2Wb9/todjLgmh5z450
    82zfjBukuoe9N1IpciNBSfLDvZO88JgjH/tASHI61YFG/pSFyNvmg0AvAJCBYM82e580+H
    IntiqdDAd7FDyLCJPHSk55kS+5m53Gxxbft8dJNI3qmcm7XJFRCQyhfwNMEehhg0cLBjJH
    z8L0KRuy0cqEh9d59UgN7I0n9KcImprG7ydF9xwUaeH5fiEu65OZZoZRH1V42CD2ZkPKie
    lWOqMXJ1sZuuXPiYzdZH2zo8BMoHOkz9/OnsEpYBoFT3NFQOoyTUH/hiG8GuUhNEN8BnNs
    3BszYg7G0/ZvmdIhU1anH37SJhiIvK5wi2sqYgvd/Br7xFqzVcbTm9QOa7m+DWHqBxvi/Q
    4lvSINnujOjidPlM98W3nz+1Pe2vTgfT7xQ8OcNkTq860An/OUrTA5KM2dMSn1m6Djvx+4
    CMgjX80sZ4TeHmRpmmzoShYbAER2Gh60CTEbUuSjV4NI8KIDbcW/3PB8DKAA
X-ME-Proxy: <xmx:0pehang2T4AW_cWlPHBozZz2gA_MAz5-tq87Re4Z4_KQUmJLVrYUgg>
    <xmx:0pehapL1qC3CBp_yCRsHSqKqtMFAmh6uZ1OwBzFamjRTJkXmGB2sHA>
    <xmx:0pehaqCS-7i4L9Jfn7l56k5IdccQr_wp6ikv9ES9yXTrx1p1c-9mcw>
    <xmx:0pehaqR2ped_EZb5vKgHLksmOKqooTBqJYbDVMi_XCh4MJrFiXkuig>
    <xmx:0pehaibdEbmhSHAw5Nyb2k3YdNIoU4EDTmlNv_Z4u_KwQr6Jw7ycLVum>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 13:30:57 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: paul@pbarker.dev,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"DavidS. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Sergey Shtylyov <sergei.shtylyov@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH net-next v4 01/10] net: ethernet: ravb: Remove gPTP control from WoL setup and restore
Date: Wed,  9 Sep 2026 19:30:18 +0200
Message-ID: <20260909173027.2201560-2-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909173027.2201560-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260909173027.2201560-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since commit a6a85ba36fd0 ("net: ravb: Move PTP initialization in the
driver's ndo_open API for ccc_gac platorms") the gPTP clock (if
supported) is stopped and started by opening and closing the ndev.

This makes the special case to stop and start it when resuming from WoL
redundant. As the ndev will always be closed and re-opened when
suspending and resuming the system.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index ea1c7e536791..36173a09e2fd 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -3182,9 +3182,6 @@ static int ravb_wol_setup(struct net_device *ndev)
 	/* Enable MagicPacket */
 	ravb_modify(ndev, ECMR, ECMR_MPDE, ECMR_MPDE);
 
-	if (priv->info->ccc_gac)
-		ravb_ptp_stop(ndev);
-
 	return enable_irq_wake(priv->emac_irq);
 }
 
@@ -3204,9 +3201,6 @@ static int ravb_wol_restore(struct net_device *ndev)
 	if (error)
 		return error;
 
-	if (priv->info->ccc_gac)
-		ravb_ptp_init(ndev, priv->pdev);
-
 	if (info->nc_queues)
 		napi_enable(&priv->napi[RAVB_NC]);
 	napi_enable(&priv->napi[RAVB_BE]);
-- 
2.55.0

