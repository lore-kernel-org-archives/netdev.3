Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792537807;
	b=ZyGYce76mj8G4uYMU5/aPns/m2wNwF5CqDjeT3KFocd0lgYo098GUNRlgYF2hkcXGdGa
	 nnXpr/omgi4/r7wXevbQx7esiLT8YWgUAAsqIffHIVHbNUMB/4x7JJMbSlcT2bW/9wQDF
	 0JnXdLHqrNQKhxmzY/8OiGn1Q/k5mA0ox1vhtt+xgRZcrqOtkiD1R50TSeoLQdOlOZ2zs
	 lr0dJteOQNj5jFHHFJI6nyd+p/1LTYfhDEp6nAaD6sET7mwhNqm9YayjhOtf/4uDx5M/F
	 MkNmEngds9RMf/Snci/Egtb6WpQeC87CfP7bMAB9oc1sfwKuimob0yDhRGI/3dr39fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792537807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=P2tX6F6c1b9WPZHS6VLVV3K2kSTZMFFjbVRLrh7B9c8=;
	b=jUOBLwVv01lvMJ2UGBtqQyFWrMLfkMjfVoYeHfSVToCgBngtFZOTVC+r9nlRlZ9QtQn3
	 IVgRM1S0xysJ+ktrSnm5FcfLxHgX+SH2S7tvEWkqrqrkZQZy/v0m6vD3k2pBedKFXT11m
	 mOtna8+mLR8LJ6KqPoMcXDymJ5LkEL23/gFqEXP714g34UJ/3oapk6fVIPV9X8HdLOsti
	 /enhHS43Ex7YU7RXtP+nwM7jzWZku/qR/WLzdux29ylKhOmWshvXWn8xTPSk86++tFzir
	 LqpguoyIT6JnpW2/tr/0dzND6TxV/d6XURvTpPlONQht+AFTKcm8nrVWQe/JDSHEamQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FXQYyZ4e;
	arc=none smtp.remote-ip=74.125.82.194
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ACF606A320
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 23:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63ACF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FXQYyZ4e
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-366421dc8ebso277903eec.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 16:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792537806; x=1793142606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P2tX6F6c1b9WPZHS6VLVV3K2kSTZMFFjbVRLrh7B9c8=;
        b=FXQYyZ4ee7N+OmcvvHjgLzE5KvKF6Es0Ggd9KBeTLLtMA0G1RiUBo41egIOT1n015P
         IVGvwSb2VzpoAqNsNIobOqfmvcge5bGmdY7XCL4cTgMJ59LjhcMTUBxKz3MxIBwkxhWF
         9LZO7B9xnhh69sXtDTrMwD+yWY1IC5KJaK91+TIf1K9MtbYVOZ8Cs3lyQfCVbDOR3uZr
         gDr+7e+py6aaqRGl5cf7ahuy0F80Rpf5OfTrBpeBLXrLmR5RMaO9IIsAMd9idozWNAZZ
         8WdthJSlQaqsPh+NEuugoh/Dcg2aLqrfOnoHZdowZXrzw5L5t3qIAQajZuezLh3eK09d
         wrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792537806; x=1793142606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P2tX6F6c1b9WPZHS6VLVV3K2kSTZMFFjbVRLrh7B9c8=;
        b=l1oBJF3AzOh7BvaorZHN2bXq5/Y6TlV3v8pc8YeYU2zhHsYgYzBIg0jm80gSUtbsIU
         xO6/8X6zo4stnX6UQ8IIlOo15+4RzyRP1jaJLqpMpA3NJtrwjmbkDPyNqs7JZKjE895H
         QkkX/ss1U1K0WkYUX4kGIg+ppF2MMgVq/E55HqcQneHb7PqFVxHu2v6ZMM7bkEtZITor
         OR39JpxAmh2klWTRDX6d4jWtwRiCbeJXVR43VmZd4mvUpXlxthB2+ctThk1VmDPRhmrC
         9eKDQip3hn/RmS70q1jHxmsoYI6plN611cZZ3KRN3XTRKDOYCtr40GS/gmiyTQd7XXxf
         PCOA==
X-Gm-Message-State: AFq9FYIFbE7ggM+V20gxCGCfsufettW9p1nTu79RpXz99OcSSb6eJKN8
	22cQ1sHXb+MKPXxPkOz85davcW1ZExa67kQ/x1N8os+4qFaev1ILZbXTtZ4CZ6mF
X-Gm-Gg: AYBFou1ot7nsLFN9nqhxHzGFJysV90nySdg4uRCyVRW6g/53jX2XEL/I1CQU/6SrzgB
	lQWH8ZIhk1Zhva19o06gLgXVH5nBeb9C53XGQS6E3icspydGgZveckR5FlP9+DC8Qu31vXGRsDA
	Yi6UcJAnGV2hMLIl2cEC5E7OD6RA/INKxJbvTiWJYMyhij6HhmeGzQjHfygESqOJxbbVrM8sJls
	fKMcUH0zsmSstHNvPlgX+wSIvgTEOc6MXhGACdXISe5Cyda8iZqRqbB74Cdltkzr7s+nb3lAwXQ
	lmPiCKbAqvkAScxNkTIYF1wNJ6mvAKSdWnO7Q/PDaeYwjpzZigSUUIFg6uVv9vfCzofpFkhYtTD
	Eey4H32wRwr5jS6zKCHlENvSC70aig8z2XiK1nqWDNHrmriQHviJ7YLfxSk1sxSzj3lIlVBosB0
	2YEav+lcnU9CPGaYfpOotEwhA98EGgypLHqXv4T8WWrA5j0ag/g+9FwEF0J1ziXgM71RkbGlrz1
	rPvCCL9wyHyUEw+m7b3+CEl8sL7W+LjZEiN6BHIJJXsCv1KCzvoNIAo+Dk6+gNJ3RKgA8m+2SPO
	yy/lP44=
X-Received: by 2002:a05:7300:4fa6:b0:35d:5e81:1d87 with SMTP id 5a478bee46e88-365fac8800amr4594466eec.12.1792537806333;
        Tue, 20 Oct 2026 16:10:06 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36741f753f7sm1598433eec.27.2026.10.20.16.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 16:10:05 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH net] dql: Reset the adjusted limit when resetting the queue
Date: Tue, 20 Oct 2026 23:03:58 +0000
Message-ID: <20261020230358.6649-1-dennylin0707@gmail.com>
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

dql_reset() resets limit and clears the cumulative queue and completion
counts, but leaves adj_limit from the previous queue lifetime. Since
dql_avail() subtracts num_queued from adj_limit, BQL flow control and
qdisc bulk dequeue can use stale credit after a network queue reset,
until the next completion updates adj_limit.

Reset adj_limit to the new limit as well. With num_completed reset to
zero, this restores the documented adj_limit = limit + num_completed
relationship and makes the configured minimum effective immediately.

Fixes: 75957ba36c05 ("dql: Dynamic queue limits")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 lib/dynamic_queue_limits.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/dynamic_queue_limits.c b/lib/dynamic_queue_limits.c
index f97a752e900a..acef6a35ba3d 100644
--- a/lib/dynamic_queue_limits.c
+++ b/lib/dynamic_queue_limits.c
@@ -191,6 +191,7 @@ void dql_reset(struct dql *dql)
 {
 	/* Reset all dynamic values */
 	dql->limit = dql->min_limit;
+	dql->adj_limit = dql->limit;
 	dql->num_queued = 0;
 	dql->num_completed = 0;
 	dql->last_obj_cnt = 0;
-- 
2.43.0

