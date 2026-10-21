Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792592392;
	b=nZ8yMIToOH6QVDQWm09g6YVeXOMfklBvoxTo0oOHNXmcNv8ZXXMvftrWNN97L7I2A5vK
	 LvnoF+x5wkamFeXy33ljPjnj4ZxahulZIKcI51wvRbsqX23atneZP9wEQ4XEb3JWN0Szd
	 c+SqbUBcuNEVuutNd+wLi6EnUU85J15xjf1BvczeZIfwNh9cmOWo3HZyrk+TwgMHP+408
	 K34pHZX/pJHJaUqB28G3A/0NfP2Rte94RyR87w+NV0Z4105ocMyL7zYxEGDFAUmBgcCjy
	 mpc73SqENQc7vO6TjSLSmA6RkyWtQa7eNOe1ynN16KN2L8zF4F70pYF8bl341kwglvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=BWkLz0gjL56F9JTm4S/uyWsKYfVy6LiPMU9KWMExSVw=;
	b=zoPpPJiJ7j0epI6EH2SwRKEkGUzh6+p8z738tIVcJxS2zWFxxTbQ1qIrMT1ziXY+Dqnr
	 YQzbJD3HtDC5uY11frJrBPXj/7NtrNkxobjDCVDMZYWeiRA0t9N9XgonnRg4mvlmcpVi7
	 rZbJp7ibvWLEDU89uLg0XKP+koxFyItSYckY1UTsKncbovglc14aoogSqJiITTXntmZvs
	 XvGPa7xP9tCe8FuRYWj6uTGpsWPY/GPt2wkNWsXSE8FhWrOCvGogBsUycssABxdigrWxP
	 8J2HtFBuAjKnE48kPOWwjzmCd/iT/O6RWZ1WvXliyUhaaC7LizUiJWhP1CqmOVNZuHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JhuwrpEw;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D4160A261F
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 14:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3D4160A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JhuwrpEw
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a018485638so1246505e9.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 07:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792592390; x=1793197190; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BWkLz0gjL56F9JTm4S/uyWsKYfVy6LiPMU9KWMExSVw=;
        b=JhuwrpEw2+tGiMAAw2g7/r3V1YLxLrKiTMctX0+x2twyc1hJ/5oqA42G9s0RE9mi9r
         TrC8EFo9Gowcyhdl4UYX3EMYtXQLKBROVfVwTAV/BoW8Lo+KDuQSGO7ukUk4cPv9mcqW
         JGWhvfPHaxZ0biROqvCVl1Dfjyk7oDdC/g4MBhshWGq86gLy4sH35NgaY/faw5MjV5HM
         xeivE+H7WFc5GtnS2SkGLxNqjf69GM0LGjNiqZzmm8MCIls4weQedHY80K8DCFppDbeg
         8gt6OcadgCdXXYTWNeujOfWBcRvHrkRQxlNDyFomMUTMMZpQpHrWnnt8cDtuPjOsR8L5
         i/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792592390; x=1793197190;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BWkLz0gjL56F9JTm4S/uyWsKYfVy6LiPMU9KWMExSVw=;
        b=EJvrOgqXTaQbjW272zD+GzUz4FSGSgRB3+b8796nwAI9lwjr4GAyDJAiar+xqkWBD0
         HvKS91o028J1o7dRLCt2Xdv80n7vdsjiCQybkQgXB6qXp+/T7fx+ka6FM+ZwVOfIneId
         oqFYTpGJeT4D0X59kEk4KIFxILnIfTikaP0XeFZa+izFHp+RxGNGFb/xyMZRUBgI00jR
         vM5KDZPjTI57NvZ2tJAhSVIwIknPl1bQ4Y3VaMwOdfCC2GJDuGoCu/m5+8JkKK4KJBcB
         1KWB02K2P6dxNzYDjJc+Cp5rqrbEv0rlvwjrgI71pZibcm0Ty/6dEkncTug2o6Bp6eDd
         0EOg==
X-Forwarded-Encrypted: i=1; AKwUvBxaM3OG5wMGaWKVxu+fbUqgiCgxb/aOVeLbvVZZoJMJL8g0Kwep6AKiIOVL81Xt4Qh14hNcGKU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXXIM4EognvMovHrhAR8dhkD97AWzv+By97rtcG4uvEpMgXcNG
	RHxvqpYtP4aHLm1FOaNLfrSLOU7CeS7tsMHwXzLWTsJMsJ/id9giF5Tw
X-Gm-Gg: AYBFou3df8jBR+zdB9PPvVnuxk+hdt5nVpzUPNxr5LHHdNUe/3u3kVpCBj4IGAd2Joj
	dqC1kcPahKJn0SyUC6Qzwgi7ZmMwU5lDQO/K7fbDay683+obEeiDV9NFs8cPC3PbpCvnNGLFgcn
	oKp8dYAwQbsf72rgJalj8bYrj/JQLHXJIUmyU5mypi/0/yKpvgLRiIKmZntQCAb5lIF6QJE9jDB
	AY+HjWq3hBH1GMHK2XXvwj0na40fx45YzYeTMTlwhCTyNNOEoZ0b/V482dT7cs6OnShiPTjCzUD
	vQcMrBi7AoB7r1s4xIPm6WcOSCVfHXAnN9oa7F9aOExzoyDDSBhrcaitYF3RmdgV2J9+MKFq5Tk
	Q8uiGHQ0pIX+kB9kddvNJ8T+7bN+XS3vaOaQq5ZuyZSFBDObrTZFMuqunt/qc+wF5fZUI2JSu8t
	kwyzeRwhmqr6F73iw3mBFpMm2CndhxF2FSxtrGtFjHVeWMZ6f84x0TnOfJ/UfrcVNcHSK34kIDZ
	DHaeIMDcXo9sQWc9Kdi1h6YQO3Cp7ljfc09RiozOg==
X-Received: by 2002:a05:6000:2511:b0:48a:f5c5:d067 with SMTP id ffacd0b85a97d-48e264414a0mr4436164f8f.2.1792592389826;
        Wed, 21 Oct 2026 07:19:49 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1d:5d00:1a26:c015:c64b:f840])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254f0bc2sm5692025f8f.1.2026.10.21.07.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 07:19:48 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 21 Oct 2026 15:19:07 +0100
Subject: [PATCH net v4 3/3] netconsole: recheck device registration after
 waiting for carrier
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
Message-Id: <20261021-netcons-fixes-v4-3-3857120c6340@gmail.com>
References: <20261021-netcons-fixes-v4-0-3857120c6340@gmail.com>
In-Reply-To: <20261021-netcons-fixes-v4-0-3857120c6340@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Gustavo Luiz Duarte <gustavold@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2

netcons_netpoll_setup() drops RTNL while it waits for carrier when the
device is not yet up. If the device is unregistered in that window, the
NETDEV_UNREGISTER notifier runs before np->dev is set and has nothing
to match.

We might then end up setting up netpoll on a device that is being
unregistered while holding a reference to it, stalling
unregister_netdevice() in netdev_wait_allrefs_any().

Add a check to confirm the device is still registered once we retake
RTNL. Release the device reference and return -ENODEV otherwise.

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012-netcons-fixes-v3-1-1aac85ed7665@gmail.com
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index be7eb632ee42..bd36ebd334aa 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -534,6 +534,16 @@ static int netcons_netpoll_setup(struct netconsole_target *nt)
 		rtnl_unlock();
 		netcons_wait_carrier(np, ndev);
 		rtnl_lock();
+
+		/* Check that ndev hasn't been unregistered when we released
+		 * the RTNL above.
+		 */
+		if (ndev->reg_state != NETREG_REGISTERED) {
+			np_err(np, "%s was unregistered while waiting for carrier, aborting\n",
+			       netcons_egress_dev(np, buf, sizeof(buf)));
+			err = -ENODEV;
+			goto put;
+		}
 	}
 
 	if (netcons_local_ip_unset(nt)) {

-- 
2.56.0

