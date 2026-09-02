Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84B540B106;
	Wed,  2 Sep 2026 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338857; cv=none; b=OJxy4FycTCZ9kp07oeRKayaxpwpEnBM5wTZ4ihvBpulZlSKMODmp+NG+6KMakPSHlWEdgyxM5Z2xCMEL/6Y4iRMZBIjsXKhr4Q8mLaRVWfpMlKlSA9eju1rLz7tsDSKqTgacKQb/vFtOCJonPYHAFUh+sleGS3omL8ht3vafk5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338857; c=relaxed/simple;
	bh=BYOoefOY1Ss5bR+zyH5BntQLG5ESy2lLKk+1d1Jxxys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nh5KudidQcC3DFxoBxqWXCIqjEs4BZ5ggI+MZJu71plppxKvYpah06uDmjaF4d6KnM/thOtigENzU7HwQd1XWifFpsC83CSHYwVa9WFrR3F2FI5d8Ohyl3/wL6LWqOZP7VIavujVg+qOJLvLsjqbyvMhSqqBserOHDWEwKEhFj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=e0rwiIHN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g+7rOvfx; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="e0rwiIHN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g+7rOvfx"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 24377EC008D;
	Wed,  2 Sep 2026 04:47:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 02 Sep 2026 04:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788338855;
	 x=1788425255; bh=6ym77WKk5tY5em5okXPlTgSnoAhaAhd7lX3C89CRtJI=; b=
	e0rwiIHNM6WO/EVqT+x0MNqgl4Klw/o8gQkNnT3mHmp6HWflyX5LwBSCmMu9kF+0
	8+YEuVsFZ4UdOg/zMd5DQLv7/wapOmJas6UhtPGUtRHyTeXZy6B8SY1uCsO6QT9X
	ECm9EAv9xJib7VZUuOjSWR2ebJbF9TP+m+dzq/3sPFC+wJOUgOvW6XYPRdS/vj4f
	DT+RUq3aauM0lBqCqVMGhCvsEztyeebwm3NEFZqfMijszmnAVI9+vDUAJsBuQF3+
	Yk4z1pTwRpaP8F1GeZr/rnblYadLJqA5TKqSTzlAEu2qFYVryGM819YxnuDg3S8W
	BXtxY/rV1toUBcmnHUlahA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788338855; x=
	1788425255; bh=6ym77WKk5tY5em5okXPlTgSnoAhaAhd7lX3C89CRtJI=; b=g
	+7rOvfxSSmcR0PS14c0oj40JYAqLSnSe4tyaz/yqhAe/qXQY2IokRu/vCYde9UXT
	X8EZb3dSFDcLW/XCi5ru/1/h00Av8EltpSKIdQZnLXESoL4Pqq5AEYv56tWCf+VG
	AyNkzwgqbUVWQGEstpkhernHAVHPdQ5uYP60HpmnSmDieEOTaYD6TULfqVA9XNNe
	6MJO9+6Iwl66j7MqDfo4BTFr3EL+ueXoDy3B4t6NiA5B3zBIwPPCA8kTuP0GXDRF
	R1GnZMNvE3n6ALt8n7PMvPDEPAniNIwT9d8iVwPaXdcCArFG0Hb4A3dGQGgBtYNU
	8VWLxAxLj3ZEyTyUzU/rA==
X-ME-Sender: <xms:p-KXauJUIMKgxzsspCtZAdSufgbArViwBLdm78t4oZqruC7NnvMJuw>
    <xme:p-KXau7Lh403dOaopAq-s71dCCAAaKd8Dlwh70c_EA5NbnJyyhj0OV9jvg-D93IxJ
    E38j2Vn7F-saggMS0xEnL0oeBSEYZpnbyaGzpvVm-8_U9aOmlF-uH-F>
X-ME-Received: <xmr:p-KXatbHEPIfdijE5ILSNPA_kQNGsa2nAzSwBKqI4gINj_cLItpZKqFFP8W8Dfut8NRa48XHjm5_Spr98-SbvQg5y9Xwz28>
X-ME-Proxy-Cause: dmFkZTFaC34AKDyyx2JWvZAyzMZPrLonj6Y+cyOD3p17c1AG7DXyqbHg0dDF7Ebt7D07IF
    3bfgT3UIfdbkPvPeVD+Yc8AR8IwBaeo1xPGZ7tVhUbz8REGwfObyy724YL1xvbxCkiSoVs
    Zr19kANjQaj/+w+iddWEU0aC1CzZHQM6yeAvRJc41D8KwaVzv1SFIAbTrsCNRf9If+K5t4
    PSZ7pSeAuSkewwU7HekFeHRwu2Sp+xkfx4AxKGocqHuIvnYqnaWzKGxKkrOU98vd8D5Cmj
    UsyB3ygea/aoCYfSx4ZC9E3wSkGCjWeq63mqLQMpNszZyuhbp9Rf0oWEqJNGraLhyCxIpd
    XG6V3tzoDZEZH/yZ8WHKkc5g1wsGg53KiHfKarKmohkYgycGJ0chfSo9juKjQD7pKk8JG5
    Zo3fi6axxLnleRT/aeTur/tBvJeQqnjGgE09W1uIvYhwpuROctJQ//gT65Y/TnWXDPAiPB
    JYm3k0BQUThNxn58IxdMDofEQIb/6+g8qXt6hKwWJ4a1PTAi6SVxUYI+fQLx6sgfDMAZyY
    rmTbf8+tB9c78DQON3X5Y7uDUKNq6PKrvw3cpKZVOn11d2rX24XrV0awbbMJd4tj17nyvs
    OPbo9F0Jq6fOikn+oCrkYMF+nWiQTBAxbuKRcdHmN2mPY+hUAmgvoY5aD8lQ
X-ME-Proxy: <xmx:p-KXalzxEVRxOPlB2-KS3cvbIGtvrM265nWBVOBp8ZWAXZ4u7qYNzg>
    <xmx:p-KXapMrA89Jn-PJzvo3DG-l5X6qm31I0gz6MCi0aCrLR4NdfnPINQ>
    <xmx:p-KXaj5W-qalNGwjEFNm3bq9xItQsliJZIlqKrh6DOjQY_gU3qDrEw>
    <xmx:p-KXavd14FwTOMtf1UAhoqDQYw2ZIMKjFuSjZPJ7EVyf7_XZtavMkA>
    <xmx:p-KXakiScWjTRy3ZuatP3in9lbvtsrdVZRp6fwOttbzaSuCBltAvJM4s>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 04:47:34 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Rob Herring <robh@kernel.org>,
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
Subject: [PATCH net-next v3 08/10] net: ethernet: ravb: Add callback for gPTP clock index
Date: Wed,  2 Sep 2026 10:47:01 +0200
Message-ID: <20260902084703.3228504-9-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902084703.3228504-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260902084703.3228504-1-niklas.soderlund+renesas@ragnatech.se>
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
 drivers/net/ethernet/renesas/ravb.h      |  2 ++
 drivers/net/ethernet/renesas/ravb_main.c | 19 +++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

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
index 7e53eca5327f..402370e1be63 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1773,8 +1773,13 @@ static int ravb_get_ts_info(struct net_device *ndev,
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *hw_info = priv->info;
+	int index = -1;
 
-	if (hw_info->ptp) {
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
@@ -2653,6 +2658,13 @@ static int ravb_gen2_ptp_probe(struct net_device *ndev)
 	return ravb_compute_gti(ndev, priv->clk);
 }
 
+static int ravb_gen2_ptp_clock_index(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+
+	return ptp_clock_index(priv->ptp.clock);
+}
+
 static int ravb_gen2_ptp_set_config_mode(struct net_device *ndev)
 {
 	int ret;
@@ -2669,6 +2681,7 @@ static int ravb_gen2_ptp_set_config_mode(struct net_device *ndev)
 
 static const struct ravb_gptp_info ravb_gen2_ptp_info = {
 	.probe = ravb_gen2_ptp_probe,
+	.clock_index = ravb_gen2_ptp_clock_index,
 	.set_config_mode = ravb_gen2_ptp_set_config_mode,
 	.dmac_start = ravb_ptp_init,
 	.dmac_stop = ravb_ptp_stop,
@@ -2706,6 +2719,7 @@ static int ravb_gen3_ptp_set_config_mode(struct net_device *ndev)
 
 static const struct ravb_gptp_info ravb_gen3_ptp_info = {
 	.probe = ravb_gen2_ptp_probe,
+	.clock_index = ravb_gen2_ptp_clock_index,
 	.set_config_mode = ravb_gen3_ptp_set_config_mode,
 	.ndev_open = ravb_ptp_init,
 	.ndev_close = ravb_ptp_stop,
@@ -2778,6 +2792,7 @@ static int ravb_rzv2m_ptp_probe(struct net_device *ndev)
 
 static const struct ravb_gptp_info ravb_rzv2m_ptp_info = {
 	.probe = ravb_rzv2m_ptp_probe,
+	.clock_index = ravb_gen2_ptp_clock_index,
 	.set_config_mode = ravb_gen2_ptp_set_config_mode,
 	.dmac_start = ravb_ptp_init,
 	.dmac_stop = ravb_ptp_stop,
-- 
2.55.0

