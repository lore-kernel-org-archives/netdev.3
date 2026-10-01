Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426BB47DF95
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790877794; cv=none; b=bvVUcQzVKrfWUZ7tO0jI+OVviuidhMub8sHuyN22Pxe3MXNiSqw8BTWnTqmCZCL6L4itrstJIeZIgmgARLILhIJYd2BrSiLSkG0pDf44Atb7wTJlU62aklTQ+AUBOZmk0BETpQQT3flumbc/zb9B82ip/0bWW/G7Gycnntq/NSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790877794; c=relaxed/simple;
	bh=vuCy3XNQRwK2pAv8DV9ohIZ4yjPKBGFN3TicIXMmLpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=okOkggg9hjEwtmy8jvB9SDDz14SUWbc351LufWlfIzU64CvFM+M9tps8GxVh+jkpIQxg2X++831nMs7RqM2bYgWkulWvO7Vg/bgLwh2PYxWa348gBSlyQxYiyE14BQMIsOBAb6fKr2973++4XgHNb2yFT00c5QMHcZz4uXyizaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbJAbM5Y; arc=none smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbJAbM5Y"
Received: by mail-yx2-f38.google.com with SMTP id 956f58d0204a3-6768033d654so2218164d50.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 11:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790877785; x=1791482585; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CSRI8/Iy//RZIheBCqOOgWpv3l9S3TrqbEtSt4XD5L0=;
        b=XbJAbM5Y63BgY8f4j+eS042/clTc1G0oifIQxmqGl9ySUlPIktHx7mRIhC7yWfThs8
         q9bJwzBYOetZ256o1uxGUru5wlyBjYVCBxPEujni7fvP/GwCZ5FMYmfyakJb2dCwkjLu
         Ubtu4Bs8LTPfy8yjdYscagnsGI1cgA95o1fWKy2pK1N7NC4+P9fzd1LOTZhZQGD8vGC9
         e6d/vu+v1bHn+1pkkPwvAz3AWi8+xfz2Y1Xx+LVQCSuIhktmHslrbsbDfPFEhfWA/81y
         QML2cfw9wHmy4jSaWOlx3Bifxuo0hWhTWs0oLbqKRYSNRJZ4vvanlD5znk8vylbkCZU2
         XPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790877785; x=1791482585;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CSRI8/Iy//RZIheBCqOOgWpv3l9S3TrqbEtSt4XD5L0=;
        b=Y1xH/fncMYepM1Hrj59n8akEvE5+iET587YsA3g+9LXQlz2DcEdZfCIVfh11DRHErW
         n7w3uY2kdomsUqpX5PWw0cHog4Scxkp2adVnxV8IpQ/L/JjHpr8E4NQ8KRX9bb+83XQQ
         +xIjUUoyFAzE1N0uZmrr+Cdd3CJjlXHVfjfJku7i/TCaCnoTDYNEvnkbP+eNTCEIf0Gb
         4EemfMie3WVWawEfXXFKjDCkBGq/mycMwkR4PBLzI9PrDIrOpGg9zPFGnucOTCIF+M2L
         DG6UKyHpjrXBMMloGM0bEuw0O04B7W18gXMzJgErNna6lOykZoTP36wxp+5yXd891bbN
         CUBg==
X-Forwarded-Encrypted: i=1; AKwUvBwE2QFl4f1ac4CLE4oBcKaZ+cWrhxnBu9opdn9NfVqObZZ9e3/0oUrQvcIce/b7OXejWUocKIM=@vger.kernel.org
X-Gm-Message-State: AFuF++mK2Pbjp8L3y0ToPdbZnSmWcayBTf9tH4hTe6RF4jWprWb3JgiF
	W/82Kx59KVZJSsxq+bDB+kQ5/ZPwMFeS8WnZlltIYVXLnmLbDMx8a/w=
X-Gm-Gg: AYBFou1Npl6VILxqbfM5eGtlmlYYb5xQp4JFNakqFuYpSJWTV9xMPGd7F+RqcFfj+m4
	/7+oahUfT54TuBn++b8467aeLNveBkcVC+icDUhN7UJ4nfc/3ErggxHXt9TwHBK/y2pEmG5s8ck
	F3kVaWAWVu5MGcfauXVfR3JV/sLkaLDbJdSLikEnfl6AiBH69PIevcD2u9R4C8k0rVxoaj6IboU
	hdUOACN862woGgjPbxWZkNlWFF12EJ6mzAFGQRQ9mcXcs0OvQwrXy/1iM/FhVYCMUMKvRX4wLoh
	7H45VhaJy9ZQFwvH5BjSWJR84dHhREh9dnUF6FM+SaWjoXnJWr1Bxs8j5jh8ZNsmMdQ22HMvqde
	p2SRAEHg117/cG3DFZPiSq5EZ5Yv49PZi8LRaVbZLmBFknweV8NN2e/Vq38R9uR5oBqU6DaON6P
	KrJCV+/9mMDK0prJzc7Bv4qplJkq85Zj/ghBbBKLjY8st3euo9tVey0IgDtV5iW+zpb9VTaIJ/s
	FVfN/8IIhMfbJ0jHU+gzl3cRqIJKa9Et00cgzwWgXmZ7lcoPWMss+nn/spv+ujxTaTrGfO0feC8
	Gi98H4VyW7B4XToyk+/3CXQ/a9Nq
X-Received: by 2002:a05:690e:1513:b0:676:858d:35d1 with SMTP id 956f58d0204a3-677ac03bb85mr68872d50.36.1790877785206;
        Thu, 01 Oct 2026 11:03:05 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917b200fd90sm20983806d6.37.2026.10.01.11.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 11:03:04 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Wei Fang <wei.fang@nxp.com>,
	netdev@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Frank Li <frank.li@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net RESEND] net: fec: drain PEROUT requests before canceling the timer
Date: Thu,  1 Oct 2026 14:02:58 -0400
Message-ID: <20261001180258.4054391-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fec_ptp_stop() cancels perout_timer before unregistering the PTP clock.
A PEROUT ioctl can set perout_enable, release the driver's locks and
then be preempted before hrtimer_start(). The unregister path waits for
that ioctl, which can rearm the timer after it was canceled. Removal
then frees the netdev containing the still-armed timer.

Unregister the PTP clock first so all in-flight ioctls have returned
before canceling the timer. Clear the PEROUT state and compare channel
afterward, then disable PPS. Serialize the channel write with PTP clock
shutdown and skip it when that clock is off.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 350749b909bf ("net: fec: Add support for periodic output signal of PPS")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Resend notes:
- Send via git send-email over SMTP to preserve diff and hunk headers.
- No code changes from the previous submission.

Previous submission:
https://lore.kernel.org/netdev/CAGEsz8EYe=gBFr_hEYFLUeiJMRtau=eV3cDUUmHJOQkC0qvfqw@mail.gmail.com/

 drivers/net/ethernet/freescale/fec_ptp.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 56801c2009d5..67901e036ac3 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -506,10 +506,13 @@ static int fec_ptp_pps_disable(struct fec_enet_private *fep, uint channel)
 
 	hrtimer_cancel(&fep->perout_timer);
 
+	mutex_lock(&fep->ptp_clk_mutex);
 	spin_lock_irqsave(&fep->tmreg_lock, flags);
 	fep->perout_enable = false;
-	writel(0, fep->hwp + FEC_TCSR(channel));
+	if (fep->ptp_clk_on)
+		writel(0, fep->hwp + FEC_TCSR(channel));
 	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+	mutex_unlock(&fep->ptp_clk_mutex);
 
 	return 0;
 }
@@ -856,11 +859,12 @@ void fec_ptp_stop(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
-	if (fep->pps_enable)
-		fec_ptp_enable_pps(fep, 0);
-
 	cancel_delayed_work_sync(&fep->time_keep);
-	hrtimer_cancel(&fep->perout_timer);
 	if (fep->ptp_clock)
 		ptp_clock_unregister(fep->ptp_clock);
+
+	/* An in-flight PEROUT ioctl can arm the timer until unregister returns. */
+	fec_ptp_pps_disable(fep, fep->pps_channel);
+	if (fep->pps_enable)
+		fec_ptp_enable_pps(fep, 0);
 }
-- 
2.53.0
