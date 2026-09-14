Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23A23B27F3
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 07:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789370170; cv=none; b=RJBPilTM+4GZQt7FANm0RwsZnaiN9WFosloSQwFTL/00VPo0XcrRpd75tfiqyEOss5LtSbz6lV5Y9E/d4NpbNtv+F1Vt78nQAPtNUPu7uCq/Vu7AhCYigkAv5hLlp0Fp7M+CqMPESYTuTkbHUg/zXDfCcMIO5DH7pglLUtPY5FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789370170; c=relaxed/simple;
	bh=jSJaAsJ9GUyAudepjyD7M4Zr0u8277gmamjboG8joAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZONM4IZE75ccTBGbdtnHnwxZPVF/iWVzLhi2xLx2JV6NDSfawuhpVC62yMHFzdnG5grkirer4AMwbdppbciKlENFWyJTj1tEf0R34BeF8DDELRr13acsssKkzsc8xV0y5CJvUGm8TPV7kU1o6SZh7gDqrlIflPr4AJjnazlG0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpGMclOI; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpGMclOI"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-485aca32ab7so376631f8f.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 00:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789370166; x=1789974966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CK5GX+kDbjRMghqOTfEiEdFRpT8/kc5WErzxR+yMM5U=;
        b=FpGMclOI19dPPZv1kWaTpRxsS5VBFWflm8+HHxcXvQcZpAbWvPtF5m4k6UtKfjuxQf
         azw+kTgb1ig1kL5hZMhmNhiH6WCCMbwA4Yep6h+pXqBM5WFEe/dTmLkuhC35mRtDJD76
         V2ok9/BdUdkgu685BhxMwqCkrwOUTcdKgHiLneW1w347HptgWgJalTXt70hP/CziDOUr
         7Y1sXxwQIGN0jm1UsrPwclAbGKX3+pZyDMKAWqhWJM5F2riZciDl9aYcXNI1M60OgjK1
         Cx75BO8KJ2v8srgKIICFFJtNJLxt2sDZ7ptCKsb48YWWZKVl3nVwCAVhAxG8W9ZtRNEf
         cnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789370166; x=1789974966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CK5GX+kDbjRMghqOTfEiEdFRpT8/kc5WErzxR+yMM5U=;
        b=IL/jojNPyd8Eyi5rlSZ5uN+nGQugJ4p4lhuwS1TCrkbRU1m/4ZidUpSNEbwZl94umh
         wJp+rUsUYOyrHb6MFAx+a7U9W7XNpXW0bsuizQjAkw3omQRhOMDKLoeEwBkONKvSbHA4
         MYA4czDJG9ealytVBAvMOI+3ZQHIWkJxWIyibOBv3S4qN3Agsl+b5zXAckXGyTo1E05t
         AMXHba4evVQKmSehjazSA31n4fYGbjunlUg77IjTJx93Kl5Vh/Y2LdAbP1sPE2fFOVeW
         CdQzN+s7ZJd3poo0LvMpqGPchq4nTYPDUujr6urEfkNGw34VnfF2bydgPUT2AMZE+D+i
         Ft8Q==
X-Forwarded-Encrypted: i=1; AKwUvBzJ1fkkK1Rh7uZFJIpEmvg8K7yhFkn3Ja++pmEaECwD/RSOCK8I22dS3u3oqTnjNrEX9aAaPN4=@vger.kernel.org
X-Gm-Message-State: AFuF++kA6LaO3domMo2Q5BVzNtSKc4bJApKnU22oaaBL3kLqDkkEM6Dc
	jhqu1GrtkaJbitHH/F070DZ9pCS064tw4PX+06ByGsc0Qgz+X6zHUOiC
X-Gm-Gg: AYBFou0f1Xvr54Uv0UlTQVf0JvLdcw6BHMQdxeagokU04vn8T6drZra4y2TymZJgr0B
	trStktN8OQOxVQ0zzBWqYXDN8bsDPfB8wnbkLOMX1x4YOwSfgSQDQXQNG1XKIyY9sfh/mkayeiz
	+woy64GL4w/PL4Ymlsi9PFoQD3F6+3lk590r+hjb4LcZTbeYyQ4egcqafNd5/YOcPe8DU6JekeA
	OQ8GevdD9bnoIgsCflx32a025SOORna6sdqq5LFKzcJoSZczRFX5XYNhdPVUWr/LcxUEZF+NTkF
	xZeeZaGGMSUH0kOgHHGFQiuzoIw1TMsofnQDuLY5mJM+gceEEau6uy+poiR+XfzHpllsH5LxiDZ
	tdOLCM6ZvrgBdDmc1PGzW69+diCJNc7JjxJEnrP9Mqw+nhvQ2gJB6ccR6B7YPaQHUE4vY0H+BHp
	Kt89+Vth6QGEmm8Ad5WW7mmd1dgA1looroECuYkSzeXfMSsCnROspdWLiR+upbw7zC+X1YJxOC/
	XpFTUj+TebIxpeHRIdATzMU4B0YrsywrB0l68u4WFa/FrfflnM=
X-Received: by 2002:a05:6000:288f:b0:487:402:6cfc with SMTP id ffacd0b85a97d-48704026de1mr23621f8f.4.1789370166042;
        Mon, 14 Sep 2026 00:16:06 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb357288sm25161082f8f.29.2026.09.14.00.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 00:16:04 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	netdev@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH net-next v14 2/4] ptp: ocp: fix dpll cleanup on probe error
Date: Mon, 14 Sep 2026 10:15:53 +0300
Message-ID: <20260914071555.11684-3-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260914071555.11684-1-maimon.sagi@gmail.com>
References: <20260914071555.11684-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two problems on the dpll error paths in ptp_ocp_probe().

dpll_device_register() takes a second reference and stores bp as the
registration private data, and only dpll_device_unregister() drops it.
out_dpll dropped bp->tracker but never unregistered, so a dpll_pin_get()
or dpll_pin_register() failure left the device registered and visible to
userspace with a priv pointer into the storage devlink_free() releases a
few lines later, as well as leaking the registration object.

A failing dpll_device_register() jumped to the same label as the failing
dpll_device_get(), so the reference taken by dpll_device_get() was never
dropped either.  Give that case its own label.

Fixes: 09eeb3aecc6c ("ptp_ocp: implement DPLL ops")
Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 drivers/ptp/ptp_ocp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 401b04f12d2b..f4299878c27c 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -5124,7 +5124,7 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	err = dpll_device_register(bp->dpll, DPLL_TYPE_PPS, &dpll_ops, bp);
 	if (err)
-		goto out_devlink;
+		goto out_dpll_put;
 
 	for (i = 0; i < OCP_SMA_NUM; i++) {
 		bp->sma[i].dpll_pin = dpll_pin_get(clkid, i, THIS_MODULE,
@@ -5150,6 +5150,12 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin, &dpll_pins_ops, &bp->sma[i]);
 		dpll_pin_put(bp->sma[i].dpll_pin, &bp->sma[i].tracker);
 	}
+	/* dpll_device_register() takes a second reference and stores bp; only
+	 * dpll_device_unregister() drops it.  Without this the device stays
+	 * visible with a priv pointer into storage devlink_free() will release.
+	 */
+	dpll_device_unregister(bp->dpll, &dpll_ops, bp);
+out_dpll_put:
 	dpll_device_put(bp->dpll, &bp->tracker);
 out_devlink:
 	devlink_unregister(devlink);
-- 
2.47.0

