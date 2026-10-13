Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C890051A135
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914058; cv=none; b=FYggUt4JsW040HfsBmUzCbPePsXaI5JBoyyCFc3atMSY0VMrrNSBCZk7uS/FHMGX0lu3p4deuwjxfB0iXDekt0UeSeemndrHcnoG0C42fQPlm8WZdLtQictZzYw9/Tt/aiwQnrhpPhjeRJU+biF6D+ZM9Q88/hCzRxJze13Zb6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914058; c=relaxed/simple;
	bh=0E6bGmEo1GwhFi1se4trHegbmcoiealEmKFcFtFcwB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hrYl7utTMJZ8xPpahPqSbZq+BlS3Wn7HHiWKMfremjMfJuVkRk9Y51KjZo0Lkml1iIapsM198mHMOFjLdhNzP3IpLraHzaLNYudfZw6l4RN1mqgoOTpxxoDU06g3SBLL+kA1nbmI5NYMbG7qlbXrFI6WN32OeDhpiuX9oM7WwI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZJQpuVm; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZJQpuVm"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6dcf573c429so2119874eaf.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791914055; x=1792518855; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AoNTFArShrIuErsfoUzGL9W/LuOVl703X8/dX7lKLJs=;
        b=nZJQpuVmLIblfd0MZMstN6RSp/LPMXj+IlHWCEmIYjKpfbEmjNTwt+JhMSVccHpMqf
         ab/qL4ATwbTkf+50Bv74dgSv/hoWNEgNrECasxaUCdnK+3Wqnn1Lwh08UAA543w2vIJU
         sx3CF78z28e9zYs9QhC78OshFMUSEHY1CcCzbbbftYEN44yORFyC5NV7Z5o4aaSYTULF
         51+a5wYhj50wPloxApLrQx1kLmE+OfvZG/bUtbBOETos/ACuQ3JPggSS+/b5SfFeg96l
         H7OxrVASQ1tId14jy29K1t7/QAIOFYonye9RGXpBZuGtwERbrckckF1rh+wPlGB8vZMK
         /mmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791914055; x=1792518855;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AoNTFArShrIuErsfoUzGL9W/LuOVl703X8/dX7lKLJs=;
        b=cU//odyLeSEe71PLxXnHdyFJDu9FyAiu1MIJl2QitDjHqPlWtblE7j0A5/jcRkO6Yf
         9gizw1arZdnts5c/tiWykG6H7Ipynd4ciDz7ZTMUpVC/eDQw2Hj8NKixKJVDjjNRi8IC
         QC2Kf6caAIDOO0b/f7U+5GX+4SyU8Vz983It7mTjr6g9X+w6I1kDexm1mD6HQ52nxS9a
         WftDCSG2vBzLRrGsBOMjd2VIOoOLXFGNHx+BkAvoFPkEjoZYpxar6KK0lk5/zo48XGTQ
         dP5F8PR3QIQbE1zYTfuTWESit63dg9Y9iCepGl4S9Q2W4Se3ny5TqP1PPYzb4gn5g0B8
         FFNQ==
X-Gm-Message-State: AFq9FYIjHQGy4k5V+Vl+DQsCGfBCRWp4XWvNyOmLvo7ODaCkOei7tb5E
	D87FfYjrqIviIplMtEx5EFe+upFRYzd76ZrvGNUVECrqg39Gzt4UIzKe
X-Gm-Gg: AYBFou1IgoFvlndRZ5XiU+aQfHJGJk1kJcEK4aTIVD4AkKSmeogJxB/FPyOPOzWtDie
	LosltpI9JEPM3yd3Qs14LcH7kCTuaasRQpvZjELAjFLAOKZJfM8kL06k2Kl6qtQ27eL4wk0dzSq
	8JZnEbTmnxhUAAaLmFj9cqoV6sKwsjVe6TJF69QoUToVXisokqamu0eOsVvncwiKgqQGUgzHNP8
	dtR3vJz6Mqb8V/RsKbZyQTKlb50+8RsvQQsTJkkH45Qsmi4gzIMjE1K97wybPQyHX/ZkSqIcRfR
	NqcacYvWUy8tU6KqjXy9lKwHtCVPVP1AgkWibMX141aliy9mZ9F8/y2Ft9p1+N34QPhIUOnaGby
	hG0MJvuMU8xu9ej1LybUE19GiUtp7jtB0Ke102Wpu8F/z31mogGn4rdIQu14Pv2t8q6mVOzvYU6
	s0TiSOHY9koKBjwXKsJhu4y2bHQbwZHhdAk3hHj54d8dAxCU4BjDVz5rrYWWaR9yh8kQQYxI753
	i7dheilhKidtdEgvvF2t0Ya0r6dYZWdnRGuHEU1OF5VYsa32MqPqhEsvaH7a17fLxCqT2wmzYSr
	eEq7IP1Rqi1KFmMRoLwA76OtVwdAKWg74IG3ktYC1H74VEItTo3X0nNH8n1vyOPCKlzE2DoXv1G
	WlnHmn5NqWjJ8n689tkyJHf0mpb7MoQ3z
X-Received: by 2002:a05:6820:a292:10b0:6f5:467a:aed2 with SMTP id 006d021491bc7-6f5467ab923mr3853137eaf.5.1791914055335;
        Tue, 13 Oct 2026 10:54:15 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a6dfcabc34sm277356fac.15.2026.10.13.10.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:54:14 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 13 Oct 2026 11:54:13 -0600
Subject: [PATCH net-next v2] net: stmmac: leave the datapath running for
 normal-size MTU changes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-stmmac-mtu-fastpath-v2-1-1e4ce8137689@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32OwW7DIBBEf8Xac6kWg2PIqf9R5bDgJUYqdgLES
 hX534vcnnscPc2beUHhHLnAuXtB5i2WuC4t9G8d+JmWK4s4tQw99ie0CkWpKZEXqT5EoFJvVGd
 xMkYqpkk5i9Cat8whPg/rJyxcxcLPCpdfkvn+aDP1DzsqLPyaUqznDgc3oLQOZXBWa+XQEmuel
 KYgpRrIIBntzeGaY6lr/j6ub/KQ/ftyk0KKMI0qqNF4HOXHNVH8em/jcNn3/QcZJUMJDAEAAA=
 =
X-Change-ID: 20260930-stmmac-mtu-fastpath-68813ead3b90
To: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

When both MTUs are at most ETH_DATA_LEN, the receive buffer size and MAC
receive limit do not change. Update the MTU without restarting the
datapath.

This also avoids rebinding a live AF_XDP pool to a temporary RXQ. XDP
rejects jumbo MTUs, so all supported XDP MTU changes take this path.
Jumbo transitions still use the existing reopen path.

Found by source review while working on the stmmac MTU/resume recovery
series. The fast path was tested on Allwinner H616 with sun8i EMAC1 and
an AC300 PHY. The AF_XDP scenario was identified by inspection.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v2:
- Target net-next and drop the Fixes tag as requested by Jakub Kicinski.
- Clarify the standalone commit message and how the issue was found.
- Add Nicolai Buchwitz's Reviewed-by.
- No code changes.
- Link to v1: https://patch.msgid.link/20260930-stmmac-mtu-fastpath-v1-1-fd73f378c071@gmail.com
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 56d89a696272..50eaee656cfb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6257,7 +6257,12 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 	if ((txfifosz < new_mtu) || (new_mtu > BUF_SIZE_16KiB))
 		return -EINVAL;
 
-	if (netif_running(dev)) {
+	/* Normal-size frames use the same buffers and MAC receive limits.
+	 * In particular, do not disturb a live AF_XDP pool: XDP does not
+	 * support jumbo frames, so it never needs the ring replacement below.
+	 */
+	if (netif_running(dev) &&
+	    (dev->mtu > ETH_DATA_LEN || mtu > ETH_DATA_LEN)) {
 		netdev_dbg(priv->dev, "restarting interface to change its MTU\n");
 		/* Try to allocate the new DMA conf with the new mtu */
 		dma_conf = stmmac_setup_dma_desc(priv, mtu);

---
base-commit: 05b5019b01fb9443b09ae4ed34af1135a80a84c8
change-id: 20260930-stmmac-mtu-fastpath-68813ead3b90

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

