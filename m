Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF484052CA
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 08:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790064563; cv=none; b=hBFgZpxB5VirnMLQS/3HG4NcACb3x6hz7xKs7EqpqXphAVvfVhGZ8/bpbTePFuz10xrGmyp6rb3mdkK9z/uj3svRrkD9UHHGi5MyJ81zIAAkpfs4LQ3aJFwzB0iM5edburoBgsHp9tq+4aJxMBeSP8tmZQJ76tDf9U0+GUdjBV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790064563; c=relaxed/simple;
	bh=FM9sgnYHKYLQdnbQxJPIQBCYzxHbimOCpUuRPbakWmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VwhIUd3rk/dU/Y03Nd65Krg8u1GAmYsLcIv3tOhz1KnfhHoMZJ8I6WhMM/xEbBxnpuZSL/mp9PSuOF9ECXMPW/XBgyWVRJAkMCZ2Tvl6pAIIsHyo471Br8ZC0zwoItHCGGEd4Elm+Ay7fZbOxTsE3lnwBWSY/ubgC+ct+dNH/wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVpJD6uI; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVpJD6uI"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469d20963so2502982b3a.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790064555; x=1790669355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H/KZ3Zb/HHoL3F/ptWbLdF1qyOZdC4rzO0WRdzYjvaU=;
        b=IVpJD6uIedx3XfMFa9Zn6StdvFSj/X9Fk0yTqR73hGlsPGCBYISwY9ConFxUNlmyO1
         xbVlSvj3nW0Bm3CtYRPeRj7ElTZAO7W6VouUsmuYKeilxmPs1kqvWYvO9eDRQ9FHIseS
         XX111yGrMYLrrB3CfQjVPVH8sRSIxsRYgBlulfbQ4ZDZGkb1rukCuv8RVC99Jm0IALlE
         jtIi4/tjduf+YUXGQKQ+hJ9KI7E94UZ5xsq9vzTOw7Fmb8+cTzh9axcU2eAFVpj9nXd+
         tMsaOK3QE3gn3COEctzztkmtu4WJpD7wqe++zxHs1/06bDrKzkMdgspgcwtRBY11Ce7h
         4hZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790064555; x=1790669355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H/KZ3Zb/HHoL3F/ptWbLdF1qyOZdC4rzO0WRdzYjvaU=;
        b=ucUMY0UtYlqpdPs97SVKKqWFfyz7BhNa9EyNwWMIAgTZNkMh11N6bQHXpvO6s54vFc
         WMvpaJf+EaWqqXK+a/gcfBpVykBIkf6AxMDVaxFJSshUETeUhAoSwf3YUbHNH/G6ntSz
         VHzG3KNsYG+T5uFccvBlloNFlSyVtDo3mZwRRS2Utbvp+McedLR9nBSQ6tEBFvPCUACi
         nwny3bkLK9Q+CTCyCq8O6xyi11NkGirmAjDqYLFxXfTBEGlLHk6IfhJkoAqZ4S+x5HPR
         sWFrjTWMPztNxBdbb1jop9/vja17v+TG0P8a+bZVD4BS6Zi2tuRpYdGJCUdrGxilHLfT
         x0MA==
X-Gm-Message-State: AFuF++nMiD/nPWzJzDs4Q9KPrRnLXLXzxKuYKfNqDR+FFxlteZkEeb8I
	z35FsMzxq2/LaVE2wnZk6OCfl94AyGijs5Xxm4EnH8ZugLbrVDPxYyQcAFewYBsnKlpKgg==
X-Gm-Gg: AYBFou0yzUNnEWi2taNWHWWGnTiIoRM5I8WJTr2dSS7H3VKIA+5MStDaefFNTybk0lb
	qsbJi4jxgjP2F4K9dpZ6kaZBfT1o0hIXY2F87kly3hjNxmqb0guPkE1MWoUUswMqz6GttTZj4i2
	PvmZWeOKPNKjU4l0RyfUueqyNJstqQHx2fjNWQSgexXH8vjQAzATGiOTR/iJKCWHimhM4sDwoe1
	akNSASfsThIEz76/GnWJN9ZKxwoGtUoHekoqWCbjLVZjEHu4S3LuCM/GmkVJxS38cYOG+5DyFd7
	R4DBagYWJ/JI0TDsaZIT4XzGSC9KEcaTA1kxarkvVXbp9Qt3ZiUbpNF4TW/xTc4B5RcHT/szRLq
	n3OqVQjQZVUFhk9v9bhuZgk39TbWi6ldRrrTl23vyADF1p0lC5v8wI0+pe/7rYiGhwy+cijlAXO
	/OScIRwxBI7LvEdKHp5Tpjm6b+joZnksI4bItDW8mVkPlFaefYG9Z/MwN+/cR4ad4yXs9eRYCTC
	d1CGWjG2TlG11hyUn4qUE1XwQfXehFqPn7Yq2fYjUNNeAyPkLIJmjKWB+2qSrMkgA==
X-Received: by 2002:a05:6a00:23d4:b0:878:3507:8d5e with SMTP id d2e1a72fcca58-87c8432efbbmr362613b3a.37.1790064555038;
        Tue, 22 Sep 2026 01:09:15 -0700 (PDT)
Received: from localhost.localdomain (5.240.104.34.bc.googleusercontent.com. [34.104.240.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87c31ee8fc5sm458535b3a.9.2026.09.22.01.09.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 01:09:14 -0700 (PDT)
From: Ginger Li <ginger.jzllee@gmail.com>
To: jmaloy@redhat.com,
	tung.quang.nguyen@est.tech
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] tipc: Fix a data race on mon->peer_cnt in mon_timeout()
Date: Tue, 22 Sep 2026 16:09:09 +0800
Message-ID: <20260922080909.21123-1-ginger.jzllee@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mon_timeout() evaluates dom_size(mon->peer_cnt) before it takes mon->lock,
while mon->peer_cnt is updated under that lock by tipc_mon_add_peer() and
tipc_mon_remove_peer().  The value can therefore be stale, and the decision
whether the local domain has to be recomputed can be based on an outdated
member count.

Read mon->peer_cnt inside the write_lock_bh(&mon->lock) protected region.

Fixes: 35c55c9877f8 ("tipc: add neighbor monitoring framework")
Signed-off-by: Ginger Li <ginger.jzllee@gmail.com>
---
 net/tipc/monitor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c
--- a/net/tipc/monitor.c
+++ b/net/tipc/monitor.c
@@ -632,9 +632,10 @@ static void mon_timeout(struct timer_list *t)
 {
 	struct tipc_monitor *mon = timer_container_of(mon, t, timer);
 	struct tipc_peer *self;
-	int best_member_cnt = dom_size(mon->peer_cnt) - 1;
+	int best_member_cnt;
 
 	write_lock_bh(&mon->lock);
+	best_member_cnt = dom_size(mon->peer_cnt) - 1;
 	self = mon->self;
 	if (self && (best_member_cnt != self->applied)) {
 		mon_update_local_domain(mon);
-- 
2.43.0
