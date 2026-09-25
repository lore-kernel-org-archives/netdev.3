Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64A5353EC0
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 02:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790301823; cv=pass; b=MJkYzayM2EsxA3NHLy7MO7QoDmJVnc0NC/8CFrUCVstiABgN0/NLSDzZa39Dz0wdtwvJmdeeIs2akjsN+pxDzMhb0KT02c8Cwcvn/nxVTWrJJPEBKXkpEnVoDGPriiiEj22+OdyYWeA5Iht8P3mrtWe/0o7sX0U8Hp94Mr7VCBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790301823; c=relaxed/simple;
	bh=I74p1TPOpyMN5eN8javYXxz6OzoRysS3odlBNtVBa6U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Sh0xkFryzKwxfRzoNwwadIsTl1iMbNkA6tercth0ajntJQD/npOyCwe9u62aNo0gbzZs2YUT4/A8uSFxYCWY7I4+1ONmNFISirD15CiUm+ab/Nloxl2wLbGSwGXGrZwshgWN3TKg2DgLkDxRGrw4xIiLMZhVANqlatWDJNDdkY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oPgegzDz; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPgegzDz"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29d50b7cf9so62522566b.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 19:03:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790301820; cv=none;
        d=google.com; s=arc-20260327;
        b=UIwZDZxCyrzSuor3hYwp+fANv+yMAarkQB6joHBqHk+sbhh70qP+uxvs/oHvOcqzfM
         ZzhTn5PVBtOZPaohCV01wPBQOZnd8te19c+eucvwgr/48XXrcRs9dqWs5eNLrXRHSLuZ
         1Gmdx4F4/P2BCSRhtRlFIEaUrywi/fgtSgkfskaViPYBoDmMl9GXqgEFGj1bUg26/eRK
         a4fkU2nUwA3jNqhtuYfurrzxcmiAHIHkhgAa6mSGDWmIS78InOKwfepz8o2f+KKEWLJz
         kCAMsKm+xcNOBiT/o7iuCHx5W+o59AlXstGdr7snDkL21Qf4kW+aj4XuyPCbwUvzCSGO
         KpTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=JXqpBsOJVxozVwjvJVgqPsuZqPEgDFWhK/I0MbzqS08=;
        fh=48VFFVQFeEq0qbWMji+97kgAcFQxsAu3iDTmYQ9oFwg=;
        b=mbCaOxXTp72wJGPV44Ri1FCD4/NnHG0lRCQFIZtMld4PH+3aRKva+dJeN3drdZBSxU
         J2mcd8xTzH/9v0ksy/mUTYPdssm90USrvnSb5BKzda655SWQdm2DZbqGpM9RAMxu2eNo
         hbeZGie24cRn+XRSwCTaeyUVYzO9OZJZo5lPASREOMhHptZapAsJYCw6Zba4SjM4Jwh0
         iRxjl6y+E+2JChB9WzUVRkQs7YRKaAqJul5UCFEFM46ZbFc0DD4npk7oHTvLFwVVHzuN
         DqXFHvAxkQJ8ZSl6nQuMmWm6/m6zxJZ1YmKIwlsHDYMkWPIds+uXYxQ2I0B+Amji/BSh
         /Akg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790301820; x=1790906620; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JXqpBsOJVxozVwjvJVgqPsuZqPEgDFWhK/I0MbzqS08=;
        b=oPgegzDzSUCZSzj6Nfgv03BNdvjmDVDcpmKMhczT6jJZXwpL+bLPMOjxW1rHGe/I4e
         GF7k4gFHk5TOzi9WIliW5y+PhssT+e18XW/7DDZOpZvniaGTi3Cpliw2ua2rSUUuJfnc
         Hl3+DB2hpsg9/xRBdCQLBZEO7Btvhktdvd1s9z+W490A3eX9vvJenJH/CXx4Q5mHgURh
         puv4Hg1XI3U6yak+aIZL10Q3ijwZbnvMQ5F9bPjGgE9rTEvF6KitvgtD4J+u/rKHxNZr
         QQJuVz3Xk1k5tWVGkxT8aTwBvbs4u6iGUIlcppxnkVUW6ZWB2+m1zNO3WGRNt5vpE2Tz
         trug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790301820; x=1790906620;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JXqpBsOJVxozVwjvJVgqPsuZqPEgDFWhK/I0MbzqS08=;
        b=hu8knAwVlDnfyO9DyscRQeG7XYbPB5cK7d8lFR3uV/wTGDLyRp2DE8r2X+VVcEfnX5
         Y1GXLvGscSY3srKewETgbuS1glW0Lwuee9hMF42nr8y2MZYxWSroSOw/48d/sonVN85a
         i22I0Qka92QPTA72dWai2Zav4a32lxPOS8T1lSJagwFx5N6Iiw3t8b6CgJOCERnOl021
         vt2XQ8MyZMDviLv2dNCzNUkr1Y8JQPVI/LbD0SucY/ucOcFOMssmmVspLVbF6YXS13sw
         IUEOnqJGeP14Z5uE3MXeG805ve77bUFRhpnf+UJzpRH9mmlQJL+0lWA3WEphY9T0H+iu
         U7lQ==
X-Forwarded-Encrypted: i=1; AKwUvBw6AxdHv5HVn+mJ6A1SlseZssFaSwVjwGoY+6z6AWHfuxobU9BnVTeKB1tpOYJJaGNV0x4R8DI=@vger.kernel.org
X-Gm-Message-State: AFuF++naVz4pkZbgg6cqxDVRkMVb10orNk7YebU814ToDni1J8vxoQxq
	MzS6OPcvuoByrbuw4TRM/o8CeQiJt3k2wyBI+QnTQLMb4AHHYbqx1s8ahePkeLKaLNz4wcB0qZ+
	K31tuMIF/le0r0cG+VZhFPD6osnC4Lg==
X-Gm-Gg: AYBFou2MTmdgMxx2UcG6e0rk657RzI+eIqeIrFL97x0EQ+SG3+l9KT/Tn/87YWEIb8S
	MSgVptuqpq/oEBVU4u0YREPVCR2LQwnSOWXnrFmr7jnyXymsjyzTma+NykqF3u5TeOETc9IEh7Z
	nqexobjFmE0ztTGeo35rI4UcqIQOdxH+29bgmuISUGaZUKyTA/F5YAkNK+2AA6w915Cinb26qKi
	8xcaD8Wb+XZWPJIMZE+kDqWk63gatmmXuLQfNTDtQNgH+rzBRyPNUTqCVK1m2tA2J0S8zygh7Eq
	Pekr1yOE3Ha/BXFth0xrMVyyP4eLJCYrw0X6r37m5GeExqElnTtKizHNPAu0SaNugCLIb0939zn
	XFtcOzolvBeyQ0w41O8qiQ+TgifzumEwg6yHFvprH6aXnR9/gtfEvp3oMPyxzeTfyAw==
X-Received: by 2002:a17:907:e918:b0:c26:19de:913a with SMTP id
 a640c23a62f3a-c2ac2674c23mr365071766b.45.1790301819967; Thu, 24 Sep 2026
 19:03:39 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 24 Sep 2026 21:03:39 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 24 Sep 2026 21:03:39 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: mhun512@gmail.com
Date: Thu, 24 Sep 2026 21:03:39 -0500
X-Gm-Features: AclHuK-CLL4CN-iwpmzU09ZJTyaHPdgpyfiVO316kD74pCcGmQ449hidnQgH-fE
Message-ID: <CAGEsz8EYe=gBFr_hEYFLUeiJMRtau=eV3cDUUmHJOQkC0qvfqw@mail.gmail.com>
Subject: [PATCH net] net: fec: drain PEROUT requests before canceling the timer
To: Wei Fang <wei.fang@nxp.com>, netdev@vger.kernel.org
Cc: Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

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
 drivers/net/ethernet/freescale/fec_ptp.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c
b/drivers/net/ethernet/freescale/fec_ptp.c
index 56801c2009d5..67901e036ac3 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -506,10 +506,13 @@ static int fec_ptp_pps_disable(struct
fec_enet_private *fep, uint channel)

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
