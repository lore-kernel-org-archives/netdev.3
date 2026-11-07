Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794028724;
	b=BpK/qbnoIMjzdy9alwixotMnbMp2gBnFSAaaCikX56pUx5MGE0wiPOczrNp3RsSPy2w+
	 Kq5y22n2MLDks+LmSWtKTVkMsdCJ56nUD8/pyeL7rNdFW33CheiCac6UTN4DrwDnHa9QS
	 zLw2t7UeydIi8rjWoKrrWh8bZAjVj6DhUYS7rNOhNuQM8GbR1NC703novjgoGKc4C7mSI
	 0chzuv3GMmc1GF+3jEbPchLcRjMoCCx6NMy+ejSGQA0EGK/bD+RFyeA1lSr4Im4t2O8xj
	 D4Q1BYuN4g8/g6CrttRVgt4De8N+d/geP0dXxtBDH/aNqgH/HpJoX7S0r6jksqGMhQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794028724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=69iwLbdEo82R3C2faWyiFypCoPu1ycnBrcOnH1bGBkg=;
	b=ssbGnFAqkaMDSbiBp2LaHGt9cUIg8kSoS2yg1j58pOfqPZvUG4Y4odXKc+Z+yAcAfnWw
	 q6OBV3GVULqBZczyY0ULSeI2IzeWNgcKFgHSgbf4Clv09H2l9r6rXQCBPRGJTwuSOsccO
	 JArSHKgvgAV2nLmvJC7FVlOj3HSuyEcAnlCBCzOXEYJ4tXkga5BW6dYy4hlwGV8T8DpSf
	 rzatNdGFPu8JWVNC1jdpxywUJEQa0iIc/bLbUtk8Dhka2P1ofaAbTUUUYxapMOH4/zQfX
	 JnZlNcGH6VVWkPsTF8CmvZ3MewV0M3juvOYGwDukBj2hHIyqrVfpygKsWDnqkfMigfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h5v5llPK;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1470606A32C
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 05:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1470606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h5v5llPK
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2eb18f4da15so4002585ad.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 21:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794028723; x=1794633523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=69iwLbdEo82R3C2faWyiFypCoPu1ycnBrcOnH1bGBkg=;
        b=h5v5llPKaFu3fMlhcSWhfngsLZGQd1TsUbhsX3QVDmc9B0roRkq/BB1xhC+cbZGT71
         gsoeU7oTfZsWAi4FaTjTShYUrrfBzMX2KNC8ZJG07iUr4Fc2Q7R8TiPEUchyrNx19LrB
         sqwcarkOC6aKMXpV/Cp0Cw1B2HWHmiFYt4rtur/gJiliNQXYcZSfKXqT4G8HJvCRHVwy
         ZFFKVW3bcubzPMKQD1u3aaLOPHRNoiN8P/lUJC5+aikahIHxco7AzjfW8tPNWgXcsfvq
         MOFVqI4ZGCxigpeA26DC4+gyp1BBT5m4egxv23UMlbSeskvfXVY06IrKv6VgBQ+vd8UA
         +lZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794028723; x=1794633523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=69iwLbdEo82R3C2faWyiFypCoPu1ycnBrcOnH1bGBkg=;
        b=tX1BCs1DP5bz6KM+jrAS9/cU7zqtUu2UBCDJZCkUyt8ylReOiPHAkq/p5Bt5Q5Tlni
         Lo6stPZDaYMRIwZwxLLeNg9rLD8nDlrd1LxZkpPH6Z+/XDtxqlAKYxeAwoqDk2luSf7E
         vuuWWE5Sy7KUuUzrCbsK+8V6UhR8fVRnwRnMtVZsYZ5iHXW8RUyYZyU75sP4n1xSCujW
         v2shqxFAingVp9IE7FHoFCHg9ZqqQmw0ur2a0rYijTLzDpwcrEby8AUNlopZEkVikYcI
         6CRm3YTdFJUN5Q1xTZI0/yf87Dsrkm2SHUWKXq4VOCcwhiHkpKlXhYkQGsMeAiHEXqSA
         r0ig==
X-Forwarded-Encrypted: i=1; AL+hErFxCbiC0lwRvyQI21e74c9zMQPo6ILMUsM/XBJhCnr3XjWewi5+U+7K1YF3/2by2Yyfla6IDQs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8sc39LNaEpMSwIu4qiRWO/wPnkTSdEjuGhblt0eJPHJB0zPt90
	sLnBVC15wyJYIArw+Y4qHm3xnE1mGfIsAfA5ZRG1W/yOHti0GkeZrctc
X-Gm-Gg: AYBFou0+qtjpEutv+pFzLZ0lA+8PZUZsuEJiuM3Ady5ugkypGdCkFKXFKCpIS6pIpjN
	APVBxgwA7pnAtWG6MTUwBRLdQZRvo68z/ziCkrc5wHhbPJYrXqZkeTbSKg0jmrOGZcIIDgWf7iT
	bwvpx0zeAWjJ6NDMFxoPw0uXrQpI4Q+FaSXVdAZDQS+26mD0v+SQeI+a3ctLds41yRcjdv7pmI8
	ak+Dy0L+LoPu5tB0vF1YteSngOAEYmARIP28CFIpvRqG7RMgxLJ4rmUkgj2AhwsmhDRTfSUStZ3
	PoL+AxK/hbkm3BJLdNCiMa+kIaIGW+HPaXXYe5UOgcDr0y/btWS4ZhgGk2AtaYCiemshGzVjk5s
	gyboICUeB1vWeAplez9b3Ml0+ujsSTSxWEAua/HFng++z0VmD2qofvTMLBCI0mZ2Uj3+/30i1F0
	y8DNxdwKuv95wh8C9fe2IEOxPRFH73/e4DzzcaWTgG4VC1f8A1T7Wr03zeX4EL8Be2/s6WV/2AV
	CHf8g5wkX4QXH/zTJgI+wd4DN4uej8YSUHekzxkD7rMgnDRj1PJVbhINbF2jQIsPI776xVEJDez
	jXYLt4m5hZ1nzQV4ygjfcixcQUZpNPTvL82tuTXKjais1ax+
X-Received: by 2002:a17:90b:4d85:b0:3ab:884b:659e with SMTP id 98e67ed59e1d1-3b0db6d7bb6mr4232399a91.9.1794028723184;
        Fri, 06 Nov 2026 21:18:43 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1057c1c2csm1785860a91.2.2026.11.06.21.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 21:18:42 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net/ncsi: disable the ncsi work before freeing channels and packages
Date: Sat,  7 Nov 2026 14:18:25 +0900
Message-ID: <20261107051825.3313019-1-hj351016@gmail.com>
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

ncsi_unregister_dev() frees all channels and packages via
ncsi_remove_package() and only afterwards calls
disable_work_sync(&ndp->work):

	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
		ncsi_remove_package(np);	/* kfree(nc), kfree(np) */
	...
	disable_work_sync(&ndp->work);
	kfree(ndp);

The state-machine work, ncsi_dev_work(), dereferences channels and
packages (it walks ndp->channel_queue with list_for_each_entry_rcu()
and operates on the per-package channel lists).  ncsi_remove_channel()
and ncsi_remove_package() free those objects with a bare kfree() right
after list_del_rcu(), without waiting for a grace period or for the
work to stop.  If ncsi_dev_work() is pending or running when
ncsi_unregister_dev() executes, it can therefore dereference a channel
or package that has already been freed -> use-after-free.

Commit a0ffa68c70b3 ("net/ncsi: Disable the ncsi work before freeing
the associated structure") added disable_work_sync() to fix the
use-after-free of the ncsi_dev_priv itself, but placed it immediately
before kfree(ndp) -- that is, after the channels and packages have
already been freed -- so the channel/package use-after-free window
remains.

Move disable_work_sync() ahead of the ncsi_remove_package() loop, so
the work is quiesced before any channel or package it may still be
touching is freed.

Found by code review; not runtime-reproduced (requires NC-SI capable
hardware and the state-machine work racing device unregister).

Fixes: a0ffa68c70b3 ("net/ncsi: Disable the ncsi work before freeing the associated structure")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 net/ncsi/ncsi-manage.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 1d63958..1c2dadf 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1960,6 +1960,15 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
 
 	dev_remove_pack(&ndp->ptype);
 
+	/*
+	 * Quiesce the state-machine work before freeing any channel or
+	 * package it may still be dereferencing (via the channel_queue /
+	 * package lists).  Commit a0ffa68c70b3 added this disable only
+	 * ahead of kfree(ndp), i.e. after the channels and packages had
+	 * already been freed below, leaving that use-after-free window.
+	 */
+	disable_work_sync(&ndp->work);
+
 	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
 		ncsi_remove_package(np);
 
@@ -1967,8 +1976,6 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
 	list_del_rcu(&ndp->node);
 	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
 
-	disable_work_sync(&ndp->work);
-
 	kfree(ndp);
 }
 EXPORT_SYMBOL_GPL(ncsi_unregister_dev);
-- 
2.43.0

