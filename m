Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7AC4F7CAB;
	Mon, 21 Sep 2026 17:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013088; cv=none; b=KJlM0IjPtDHLF8wkYs7uKdlwu/mvoK0StEzF6/zyh+joMtaJ9wJrhi2bBDw1EaK3ZkRWLeGSxkWWuEC/7ihEOJLN4JNqGlaulPmDgRDzLc/tBQLSZ5mNYmi4e4EiQI6KCvnm88q/sze05gr7xw2A/3schrGLJk2onpY7T4PMoBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013088; c=relaxed/simple;
	bh=oAQT8va7y41DUuDdgvbf6NvxjRN2XamC1NCFHyjCBtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0cQnQjRQbZom6pmHVRf0DP//sCOllaCsuJQQfmN4jbWSsqDUE5vpn/UKMt0Hzwwxz47jps6dwnAx/l5CBFQ9IQ62k46z5HWjWCz9w4aAGoFiwBHV3B+VC7scCQCpfBEn6KT3XP6YeQ1BcGIgbV4MyaqJVgjNc4A5No2pDFJuuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=SpK7a1wQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R3vDzsNm; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="SpK7a1wQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R3vDzsNm"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C2FF67A00BA;
	Mon, 21 Sep 2026 13:51:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 21 Sep 2026 13:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790013084;
	 x=1790099484; bh=DzbstqLUQPRmED+g/cWawWvIDYgeFfAxDbES9Q2/vwA=; b=
	SpK7a1wQehCLZSlUcTZpJydsvmGhfxY23hBbQBvqsVJjPX6OH5JR/h+LrVzijyQh
	lxi0xzoKn3NXxf8RsnkDcu5PhZUHR1yOrw2nUtFWUVBlrmXZirXeQk1sA9XxC2dI
	DFH7mn4BTgpc2JXJGmNfNsGPIglSK4c5QZf58Iu+n9R+km9xgCenwIf/HaN+fwUa
	lYdvPEXWSLREQTKTCrFH04YwETt/5EbVCukwxq5BSsETwzZWt+u3ViWByZ3Jj5Dt
	fGDXLCAhWfdncOwPwgVvtqhiyBT+mO45J7/mXNazMU3gabxso0nspSpwy1AfALPc
	EzTmwrcBl6NEPKG73uRb+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790013084; x=
	1790099484; bh=DzbstqLUQPRmED+g/cWawWvIDYgeFfAxDbES9Q2/vwA=; b=R
	3vDzsNmk1LveMsSukKOJ65Kp4253jPbaPGAK4PA7+sQQbtiHzqM7gSL4y97U/4Y1
	ygd7kT/gM3QeUc6Ey0TzlildfGYP6tKJL/H6sCEU8n73QzGBx3eVAvo+TaLQUGlY
	dnEtyhmUN/nlySmgoCuleco2LXH2L3A0MI1nt07G2WlKEJ5fMlL4XVW7ugchJJa5
	biPiBsKBb4iawStT9UWLin4m7oTyoPxf/FflToyb/hR7iB7v74P65Fr3gK3t5cQc
	sw+bggSS/plLm9Pt9r4YhkrpOjs7lc2XDTmjmpnGIyDP+EIKHJElwFiSNTqXxI25
	NjnDyMb65aiuOA74F55zA==
X-ME-Sender: <xms:nG6xaoAiUOjOhmv519feuqUF2dMkO3uy6lMNhzicOlFiw4zwXjY1ag>
    <xme:nG6xahcOAcyVn5EUTKOjnTbVUvPoqlu0_hZUsIizZHhspeBf0UavRcGh6dRYu2U5u
    2Hjm4-ujeTal22mpxy-4GzAFqUUA4zgKYrSseP0AaxgyZz8xCzW7DY>
X-ME-Received: <xmr:nG6xagr8PnAxONDJNJsDCF6Q1LDoNzytoqhdgoKuaaJcBEHfn3Mi7KF6GL5Z2aEQOFS3rK1500sjw4qddrRmsYLAZrKCe6g>
X-ME-Proxy-Cause: dmFkZTERb8iWuOaCoZl7Bdy7ms8LtfxU+xjK78I80yyQZdvSwOOOfv5Eh589Pe9RlM06WU
    dDnU8HOY0XEZCSLotd4wkziCSyOMbfYp7QQMcpxqxHGnE0sN+h/hwRsMQX/TPzjkM+eutR
    EyTNwAM1tWMwrq7QvnP58hqr16hBRsM/xWQjxvzbUj3rLPulCyCubKGS8/OfnPdml28WZP
    11HBM2ETQKxQIL8VV/A/GNA6vlfx97xrmJ0/jihnD6jQBVLDZo9wvlSWgasgNowAQLofbi
    uJp5/Pi8DlT51OEeXr8hn2lIL64WOU6L6jZxXkbUv9MeKffjxF51gA/7UnWz5uX+sq6JVv
    wbIRVVyqxihrRHw8l4GwzpytQ2JTjeIc1bVT3Mo1CWrPQotlQEYeGLrkaf44MlmBXcpn2b
    CX9PtPS1YV2maSE+mAjQW64jN7PZEYL6YX5/uZ7xjJMhuCqHoY9MlE7OlD8mT10NB7ZJ2q
    web9q4IoUXCSysmYKoZ/0Llw2cvdB7vNNdZAE+4iE6koPmhX2M5b0TOw3BAdXjICG2l0zw
    w7DzZgIZmuAF+HrFVevIHGcvPzGQExDRkoibDMGzkU81+Y/WnXTvKuq7/KUimf/BvOR292
    EN3OEFK23lIWiNVxDPnxv5PaMpzbjFPqeCrDWSrG2xF6H6Eunpxk0mqqr51w
X-ME-Proxy: <xmx:nG6xal6EMIvidE62K1IyqzqBIs9eEPuh1FwVwopatSFJUoA61t0gLQ>
    <xmx:nG6xaoDEm39NWKLKoBRXPW70P7DM6DjTKU0zC0xDImxMNYrQxvZytg>
    <xmx:nG6xavaBr-oyKLpxhUi6AHzyyzUhkJFGxZwdYNI5KaxoYkkwVAGSPA>
    <xmx:nG6xakKikfH3IzHFBTABoybP-ykdby1tQiqUBEnY7XnzSyLALfsIvQ>
    <xmx:nG6xaozHs1JylzCsEeZTRtcB9ETFN1uCeFLcRhiB2u3XvTIcorrLiW3n>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 13:51:23 -0400 (EDT)
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
Subject: [PATCH net-next v5 08/10] net: ethernet: ravb: Add callback for gPTP clock index
Date: Mon, 21 Sep 2026 19:50:35 +0200
Message-ID: <20260921175037.4084310-9-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921175037.4084310-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260921175037.4084310-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Prepare for adding Gen4 support which have an optional external gPTP
clock. Add a callback to get the clock index and use it to determine if
the device shall report gPTP support.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>
---
* Changes since v3
- Add check to feed sashiko.
---
 drivers/net/ethernet/renesas/ravb.h      |  2 ++
 drivers/net/ethernet/renesas/ravb_main.c | 22 ++++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index b788e8f5260d..27e2b31955ba 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1042,6 +1042,7 @@ struct ravb_ptp {
  * critical points in the RAVB driver.
  *
  * @probe:		Probe the gPTP clock
+ * @clock_index:	Get the PTP clock index, if any
  * @set_config_mode:	Enter config mode
  * @dmac_start:		Called when the DMAC starts
  * @dmac_stop:		Called when the DMAC stops
@@ -1050,6 +1051,7 @@ struct ravb_ptp {
  */
 struct ravb_gptp_info {
 	int (*probe)(struct net_device *ndev);
+	int (*clock_index)(struct net_device *ndev);
 	int (*set_config_mode)(struct net_device *ndev);
 	int (*dmac_start)(struct net_device *ndev);
 	void (*dmac_stop)(struct net_device *ndev);
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 77e66a9870ab..2dff47c2a125 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1773,8 +1773,13 @@ static int ravb_get_ts_info(struct net_device *ndev,
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *hw_info = priv->info;
+	int index = -1;
 
-	if (priv->ptp.clock && hw_info->ptp) {
+	if (hw_info->ptp && hw_info->ptp->clock_index)
+		index = hw_info->ptp->clock_index(ndev);
+
+	/* Only advertise ptp clock if present. */
+	if (index >= 0) {
 		info->so_timestamping =
 			SOF_TIMESTAMPING_TX_SOFTWARE |
 			SOF_TIMESTAMPING_TX_HARDWARE |
@@ -1785,7 +1790,7 @@ static int ravb_get_ts_info(struct net_device *ndev,
 			(1 << HWTSTAMP_FILTER_NONE) |
 			(1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
 			(1 << HWTSTAMP_FILTER_ALL);
-		info->phc_index = ptp_clock_index(priv->ptp.clock);
+		info->phc_index = index;
 	}
 
 	return 0;
@@ -2656,6 +2661,16 @@ static int ravb_gen2_ptp_probe(struct net_device *ndev)
 	return ravb_compute_gti(ndev, priv->clk);
 }
 
+static int ravb_gen2_ptp_clock_index(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+
+	if (!priv->ptp.clock)
+		return -ENODEV;
+
+	return ptp_clock_index(priv->ptp.clock);
+}
+
 static int ravb_gen2_ptp_set_config_mode(struct net_device *ndev)
 {
 	int ret;
@@ -2672,6 +2687,7 @@ static int ravb_gen2_ptp_set_config_mode(struct net_device *ndev)
 
 static const struct ravb_gptp_info ravb_gen2_ptp_info = {
 	.probe = ravb_gen2_ptp_probe,
+	.clock_index = ravb_gen2_ptp_clock_index,
 	.set_config_mode = ravb_gen2_ptp_set_config_mode,
 	.dmac_start = ravb_ptp_init,
 	.dmac_stop = ravb_ptp_stop,
@@ -2709,6 +2725,7 @@ static int ravb_gen3_ptp_set_config_mode(struct net_device *ndev)
 
 static const struct ravb_gptp_info ravb_gen3_ptp_info = {
 	.probe = ravb_gen2_ptp_probe,
+	.clock_index = ravb_gen2_ptp_clock_index,
 	.set_config_mode = ravb_gen3_ptp_set_config_mode,
 	.ndev_open = ravb_ptp_init,
 	.ndev_close = ravb_ptp_stop,
@@ -2781,6 +2798,7 @@ static int ravb_rzv2m_ptp_probe(struct net_device *ndev)
 
 static const struct ravb_gptp_info ravb_rzv2m_ptp_info = {
 	.probe = ravb_rzv2m_ptp_probe,
+	.clock_index = ravb_gen2_ptp_clock_index,
 	.set_config_mode = ravb_gen2_ptp_set_config_mode,
 	.dmac_start = ravb_ptp_init,
 	.dmac_stop = ravb_ptp_stop,
-- 
2.55.0

