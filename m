Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725A43D891F
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748502; cv=none; b=kcHjt0LJ6np2atWvJNZb0JkXTpneVJ1JmODvMxKX3Qb8bClRCsvP3fzZGhX0e6uhlZ8y82ilsyZeEgOUhLUY/XZK6whc/qx6RVZKWyMVM6HSnJc6Gi9kV29Z57gzbSsVfKvMGsekWVXNB8uuEC8mBAOvHj7Ti7etFyL7lvjTo8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748502; c=relaxed/simple;
	bh=zcETIkLM8Cmdv8MV4Tk1OnRX5GmudwzCo/xVqqn0IWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLARpe6RGVCO3511xLvbOqM2W75TXO2KdCc8/HgiTkZ/aOIUt4aWDG6L2Pq+OTizc/NTVM7CAtTm3yQOIQ6PyYSLfyUEpbynQk5nlR0maYdeSbTQEA3uNnL2l2kOLoHopyGIgT96dZ5UmbCxhDH64tWEHlDZ/rvVcKNFm5Vukx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exFtZPS1; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exFtZPS1"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cea3004256so33390715ad.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 02:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785748500; x=1786353300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kvun/rb+CpTslltyPoabb5PRPEjc9oqIPsRzwfjh80Q=;
        b=exFtZPS1A8VyfqtbwdRaWaKJyRK35e3j6u/JuekVuVRgdPziOngRl91E0ivfkOBZ6p
         yjcNcmvHByaRpYZDdMN5m8yZ3klf5u+y27xg7elSAxZKFujEbn8PAl0Q2MK1O3E9zDLg
         fcYhqylaK+fQdmQPzuQeRsN97yTPWeUnNrJuzvhvAJ3M0VV7ila9D+JoTj/ShSj8GSTD
         eCpdmAozPP3XtTcPOFF9q0Z8Jagb038wshU2Kkvj4NRGuZLejmOAJ8Dz6X+o0e10D0cX
         jtL5km7H1HEEFQUGCiZVBHhAisrgzfBZsBxDgxhH7/KO3FUbaj25LOpsqseh+XD2oRz2
         d8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785748500; x=1786353300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kvun/rb+CpTslltyPoabb5PRPEjc9oqIPsRzwfjh80Q=;
        b=YIplnCMbBchWxwPlO0jMy01j6xGBrKWtIDF/nu4ff+bfddJ4fGThKFrserJ1UcszSP
         ocL0jGQ1qhv45us8W4T0dFhm8WfAatoxHhnyH5aAVNSy2mK7S+97xGTMhZkh7rA4A0qd
         4OVuWKsuZ5+Yk0MDKbJ7UJWGf/lk3gPl6DLbE7Qkhp+JsXYt17/KhVXSFgSdC30CIAOH
         TMWfuslnk8FR1IgXGRD6Q/WGr17cjNc641IvoypTj4ekFJx76AI4VtzsPO6CIAqVLD70
         w7z7EV4Ze9Mt81UWUv/MswdPuY3uwTyZ1EDd1hh8UonRybEqUD3Q7w3fOK9Tk/tDGmJ1
         enpQ==
X-Forwarded-Encrypted: i=1; AHgh+RpHWxXgvJVz4nJ4xW1hEK5hTkPChq1f+xMLEE4xIJz8LObawKiSuQTSQdZeOU6/tKEnjlZ0gHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkGylq47XheuZK1inhZhTpuC9rAGoADRFzz9VIXXyJxaTnrRqx
	5N+6vN4+NJy9/pVOEsldSIpOyYrBtUyEedFIJ+cik9n329CHPms0jjpB
X-Gm-Gg: AR+sD12dkW+XqqoBRbSi8Rep1HWXw+pbvzjvC1fzAjvSjfIqPFXcn1YmHyLBzV7H67q
	DRlHtbm4u1zXcrKB/zKC1kOT+LFmNlfUlMVq3k8tXn2MKR9S1sPbdFNRoYt4ftwN3QN8Z2fhTCQ
	nrTodFDaNhhQWWMU1WOlpc3ach6vRYui+wM2RsZj+TOfh2pa89BwyzXOZsB6nONynVJ1ipSLbPr
	nHBsGi0imtBMciB3EWAGvvmXkn/CYH2lP05/EGOjqHGf9VqdjZxS4xff5FEFXqOuHL4iiwWoiit
	Bc9p3XO23FuaIcBzuq11V0euRaLzDyggFNwDcZJ4CPvyE9XAW2bCFD4LfsxPqwL1o/krtOLfz9d
	cWZgDUH/nc0DB1gYkn7X/+ka2iNqrdTo2EdeyhdIvBFB09EyoV4AtPuGDGkaMMPmTtnJXq4n4sG
	eA7oeJFC0O7B4cPihQhkB3+0pquC5iQzwPtZozRYAxbQtHO0LGPwsAZAG5is/kncwYSGelBf9t+
	5AP/anyUXN0cL1NAZZHQ87ujWrxAe0lFG5i3+6JyC/QbO1Z8DQ38w==
X-Received: by 2002:a17:902:da90:b0:2ca:9d5a:8b6c with SMTP id d9443c01a7336-2d0521e8b31mr82117175ad.5.1785748499595;
        Mon, 03 Aug 2026 02:14:59 -0700 (PDT)
Received: from C-PF5A3Z8J.nsn-intra.net ([167.103.78.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0eb7b7sm34546515ad.39.2026.08.03.02.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:14:59 -0700 (PDT)
From: Sureshkumar S <ssureshmsd7@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sureshkumar S <ssureshmsd7@gmail.com>
Subject: [PATCH net 2/2] can: bittiming: fix bitrate error calculation on unsigned operands
Date: Mon,  3 Aug 2026 09:14:26 +0000
Message-ID: <20260803091426.29050-3-ssureshmsd7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803091426.29050-1-ssureshmsd7@gmail.com>
References: <20260803091426.29050-1-ssureshmsd7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

can_calc_bittiming() rates each candidate against the requested bitrate
with:

	bitrate_error = abs(bt->bitrate - bitrate);

Both operands are unsigned int, so the subtraction wraps instead of
becoming negative, and abs() resolves an unsigned int argument to its
int branch. A wrapped difference is therefore reinterpreted as a small
positive value instead of the large error it actually represents.

A requested bitrate far above anything the controller can reach then
passes the CAN_CALC_MAX_ERROR gate. On a dummy_can device with a 160 MHz
clock, requesting 4294967294 bps reports an error of 0.01%, configures
415584 bps and returns success to userspace, where -EINVAL is expected.

Use abs_diff(), which subtracts the smaller operand from the larger one
and keeps the whole comparison unsigned.

Fixes: 7da29f97d6c8 ("can: dev: can-calc-bit-timing(): better sample point calculation")
Signed-off-by: Sureshkumar S <ssureshmsd7@gmail.com>
---
 drivers/net/can/dev/calc_bittiming.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index 4809f5e0c96e..2789b99ab6a8 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -132,7 +132,7 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 			continue;
 
 		bitrate = priv->clock.freq / (brp * tsegall);
-		bitrate_error = abs(bt->bitrate - bitrate);
+		bitrate_error = abs_diff(bt->bitrate, bitrate);
 
 		/* tseg brp biterror */
 		if (bitrate_error > best_bitrate_error)
-- 
2.43.0

