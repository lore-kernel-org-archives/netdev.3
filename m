Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794033457;
	b=NIqb7Zzz11U8wRmPC6Xf1WGbK7zDMWaWks4jNAUIVEma6gaHyRVeHTQEQWDy6xTQMEnm
	 F9ba3ob07rH2IZj4XFcXwHbkB6I7cfG/rEio8h6Cdj0Tz6iERFRYSmBrV0R26oR5Ntq/i
	 gTMRZ3GnrnvAOK6MakzusX7/CCPTiz/acv0tEa3HOQ0IRBsta9a2S86YoFtYnC9x8B8/X
	 pGTLc5ZELiVFL8+k58gb86OIccBTWXoEPE4RByMfvGB+6dMHABYOQT5xJINfXgnCTIJx+
	 SmEtiJar08/SsYKbsSYVQLLKTcUOzpFsorDBT1vpZLAiyRAQmKP0DDtAr55/FsVQLig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794033457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LHL2l3rOn22wCea5M4iQzvY4HHhth4DONcB31HGYom0=;
	b=qcrRBa9xP5hHR5mNtRklyEVKchDo1AEQ2ukGxzPGfMmhyEvBH4QmckYbdn92RGolRGCd
	 sbm8O0/BS9cplHj1EJMSBdkFYZH7NO35dpSVCE7mSkXMLHJPdUrKCUbJIcducrLzgyJ1G
	 yMcdMJHVokJF2fQm7XGQ5AuQF9kK/5REgx87MoC/y28wNNP6/y3W/ze15CbL+rxFY0KfO
	 ti8IC3a8W6CUYqmM5IHac2bKJ+p4Wsm/50T0BQ4lwVVdi00MICFt82zACf8nmqqWoKBd/
	 vqB5s4bWQk2wvTpgwIOFzDAIYfXi0Axga/0eK+llNb0qdt1/8Kf3E2aFlrvQi3SRpzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fu7kgJQA;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261DB606A32D
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 06:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 261DB606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fu7kgJQA
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e98798cbddso6314355ad.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 22:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794033456; x=1794638256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LHL2l3rOn22wCea5M4iQzvY4HHhth4DONcB31HGYom0=;
        b=Fu7kgJQAT1614CBoJ/v0QNumGTnN/XUwli/MO4kPZrVn02UGb3hXhv0UJ8xGiIno5h
         VGMRKshITnOzwHw1He0nsL8KGGbk6zAuorEA2hAvA/EEyQzQWnaQ9bGh/Zos4PRJszvU
         pauSU4gZxBeZb5H9xjnRSiFhV7SBhoB4crHhtV2Am9bxSj2E96Vy1nkaAwfCgDk5RaWS
         ZcnWEJ0Rd0xVZhd81TTQvkGu2mwVAFtlXxC3QDhP0KnL3o5OQKENwpjJUH6n4/qtD0zu
         0yu7LrqB+xWnnKugjwas6+PvPI39yp5p88b3J8LeoIKVFH60Yvp14bi3LgZ/Cp6Ni84Q
         Id+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794033456; x=1794638256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LHL2l3rOn22wCea5M4iQzvY4HHhth4DONcB31HGYom0=;
        b=21rPorhabCO+0yWB59+DJRgemJFx/OnvAFzfbSuWIC3M44iK2/2whU64xhuS3NPNpX
         QGyi/aVkLsz1yXYc/v4fJ9oDKxkEb5Ci47R4vTX+c30TUQTgjgQJVhTX+8M9UkBumzqy
         mJZdlKy+TGl2UdzHNcpXkSjkR3OSbSLIVGXx2GQSrWKwPLTy+NrNLmvhdmXiTQHaQ19S
         wbh64rFFsZOzKhFxEX9JP7/HfoAKB/cWbtgTGO4gGhDSjeKvvHfV+AdpfZl/XrblOoeg
         mVQTX4Y61PfANlkqUWtsTAh+fX3+5Lm8jvOYn5w1pKfrNT32gAPdEE763ajKHGf9K9yA
         vj/Q==
X-Forwarded-Encrypted: i=1; AL+hErHk16Fa8Ujt1t1gB/FJ+sVpsS79266zb5wz/PxAoVI5f7RLfQ+p6Q6SFTymDHJ1CLH2knHcRNc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9W8owuFjBxBUubrAnfFfBgjYILFgrM1eVZcgt52vvjhuNXnY/W
	Uq74Zxjn3GH2Hz0op1dqrFjLFXj8aN1TLKwBVgy5iycqDdD6PWAJq4wi
X-Gm-Gg: AYBFou0gGP4gjI5OAcQ7ZA9kIR2NSRN0IO+JwzX74GVdtjPX0UwHKPCI+LOcMi8sGR8
	Q+7v26jJCKNB9IZp6mcQuUYj8IkxbtPD+E0GxFRl3nNjy1HQCtQd9pPboKTo19IMJwPHsigNok4
	6T8rz6o1Mp+rpuL+2nYGKeILEUoEaBS4L6/TKenG8K6Tkb0A7raj+AyrjNbAadQ+qU40eEUsjEH
	rn7bn6YYu+gG6NrQ1NyaG+vZlOxssUOKfI4tDC28rD4lSFpZUdSqtJcNdtD9FtL078ECbQ6B3ta
	nZhr/AMzu6rX1g1E00skup7XvhbD6MDS5edHSR8HNLt0LidugPEqt44Q88IFs7mnJ5vHDbVQXPj
	r2WP5KlD67PQckptC60GLW4R0QHPM7+DfDvJHBWCtDOjhLgeQBvi8gmrWF2/NXDVAqXA+9YcuLA
	Jva+nZi2BP/D4QThkVPcO6r8yBo2QXFayZMJNxDtnDwQPzLOwE5ZjF3bYQLxCzxHiuwX6jvbl+H
	feHgBBeMKc29CJgFfmug4jSlzFuOOErNrEgcC/PM11yfbT3P7bUOTlzOC1+aUsxR8frE4ZuyIN9
	IVfAx54Q4Qts8DoxhD2ZaMrlp9TdGsoQreJG6AIXefvBSekL
X-Received: by 2002:a17:902:c403:b0:2ed:892:584b with SMTP id d9443c01a7336-2ed40c4950cmr61777055ad.32.1794033456039;
        Fri, 06 Nov 2026 22:37:36 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed477a9301sm11315185ad.23.2026.11.06.22.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 22:37:35 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: ti: icss-iep: fix deadlock when disabling PPS
Date: Sat,  7 Nov 2026 15:37:26 +0900
Message-ID: <20261107063726.3388730-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyunjung Ko <hj351016@gmail.com>

icss_iep_pps_enable() holds iep->ptp_clk_mutex across the whole function.
When PPS is being disabled it calls cancel_work_sync(&iep->work) while that
mutex is still held.

The work handler, icss_iep_cap_cmp_work(), acquires iep->ptp_clk_mutex at
its start. The capture-compare IRQ (icss_iep_cap_cmp_irq) schedules this
work on every CMP1 event while PPS is enabled, so a handler instance can be
running when userspace disables PPS. In that case cancel_work_sync() blocks
waiting for the handler to finish while holding ptp_clk_mutex, and the
handler blocks trying to acquire the same ptp_clk_mutex -> deadlock.
lockdep reports this as a possible circular locking dependency between
the work and ptp_clk_mutex.

Unlike a teardown path, the capture-compare IRQ is not disabled here, so
the race is reachable at runtime simply by toggling PPS off while the
hardware is generating CMP events.

Drain the work only after dropping ptp_clk_mutex. The hardware compare is
already disabled by icss_iep_perout_enable_hw() before the drain, so no new
work can be scheduled once the mutex is released.

Fixes: f18ad402cd8b ("net: ti: icss-iep: Enable compare events")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
---
 drivers/net/ethernet/ti/icssg/icss_iep.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index ec08589..6264061 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -579,6 +579,7 @@ static int icss_iep_pps_enable(struct icss_iep *iep, int on)
 {
 	struct ptp_clock_request rq;
 	struct timespec64 ts;
+	bool drain_work = false;
 	int ret = 0;
 	u64 ns;
 
@@ -607,7 +608,7 @@ static int icss_iep_pps_enable(struct icss_iep *iep, int on)
 	} else {
 		ret = icss_iep_perout_enable_hw(iep, &rq.perout, on);
 		if (iep->cap_cmp_irq)
-			cancel_work_sync(&iep->work);
+			drain_work = true;
 	}
 
 	if (!ret)
@@ -616,6 +617,15 @@ static int icss_iep_pps_enable(struct icss_iep *iep, int on)
 exit:
 	mutex_unlock(&iep->ptp_clk_mutex);
 
+	/*
+	 * Drain the capture-compare work only after dropping ptp_clk_mutex.
+	 * icss_iep_cap_cmp_work() acquires ptp_clk_mutex itself, so calling
+	 * cancel_work_sync() while the mutex is held deadlocks when a handler
+	 * instance is already running and waiting for that same mutex.
+	 */
+	if (drain_work)
+		cancel_work_sync(&iep->work);
+
 	return ret;
 }
 
-- 
2.43.0

