Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D821151C057
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909013; cv=none; b=WYUFoa+DNH5wzQ/wv3YI7D25L/MgLSmfGjP9wVQrEJWuwBgGnkt8j793S1hUcluy48156nVCaQnDV0+/yjUY9ebSO/CI+KGKCfPQFsoADjlplrbLc3T8KprbhNwz7xGPCyxEVvWNdik9bECXqpWEgjcJousTs8pfNKl61ACTJUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909013; c=relaxed/simple;
	bh=+HGJ91G3vE8I+hjbAj7JZo7VbwjxkPRsRJSUwJ2/ZT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D3aT0W+cnhblsmaMFkIa7ZbsUVmNdvhlfEzYqI8mLqAeI++YwppRaWqsqdXJal1YD73O2C03ugWQdklhDc2iIvE+Wfd7BqcEIyUy3jKozqhXvbGiHgJDgksRlBe1CLVt3nVDir+1z4rS0e49xtcp6j0Mqe/U3P7G/B/B5BcLLqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q4WnDvVY; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4WnDvVY"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3a47d4fb7feso181219a91.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 09:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791909011; x=1792513811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T42dDgF1G2T5CFLnp1NKvSC8C3hiWB9MunCO19ie1Ug=;
        b=q4WnDvVY9KFvleeUiwYCCnDKHr0HfGtB5+souZNmraxCa8/O/JXWVXY2DRetFRmxyv
         kXgDTp5pMq2yglZLJspYA6FObraIuVGSv3Zb6+qomYZrkTZ95lStW+ohZOSW/9LoYkMk
         0LDqmAl1Orw3kriRlCmBTvC0VGQcwwG/8AXOfUVVWpu7N9BsjUuSBNlInAJKMbpJQklK
         BddxUQnvz2e0ky42lEHzNQ6AlhDDAFH7LfStAkl5Fgon36ARuAmrVAMdHvkPyIrCQmtH
         YxC163qCa2qJIlDAzMQnFZIYbLKwEcz5u2s2ONP/AxoAvhLGMdSQW35fjdmRNReWCLFH
         2cwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791909011; x=1792513811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T42dDgF1G2T5CFLnp1NKvSC8C3hiWB9MunCO19ie1Ug=;
        b=fJXZBmOwWfkPduDp0viJo2GIyMytZBxouJ/BKHoOa5xVPUcxbzN5INgqo6jQoWnR8p
         x1lU+3WXeAspbvc5YvmbQcpQyRV4i7P40V8J53heqvuK4IyzCP8r662BC7Xoo5dEiH31
         /mDnshEwYyi40FXFhvoMDXz8PodGvYT1zla5EVEeJd4uaz1FxWf+8qPWnsN2AUi0z9ES
         MR+QuuYcdnf1fDlp7yUq35PJQ3NttYRjkZQwxGJlnLFBprDABSngnGrx+E/uUsDZzzwr
         kPR7PimEyTnAYgi6/RDwB6oVdaw8cPgmeiDD16Xnq3YwTvZfU8Tq/RiuDFtcEWd9Blwx
         gENQ==
X-Gm-Message-State: AFq9FYLwgLuMMHI97XI84jKT40H6gie/dh9B2ocNT52YLFw6Bsuska7I
	Ha19CK2x73DJKAODA7wfPfkhksP7vbjXC3JAA+Xlo6B8jalX2z3ZQYVP/hSpwg==
X-Gm-Gg: AYBFou3LmD8aB8fsot7eo2B3cSvZl4HAnQHQ+8M0aubI99mfiStRnZ2qcBZiz0gHNXc
	SaSDdWX8yWV/WkGJhQA9wjF+kNj1fmg2vj/7vpAgR/F+hhuPZOdTMY2DUW6hh29FaPTZ7VmuI6p
	3u6ssY7IS9mz5Dhni9TLt1D5aS6/XDCoaajFnJ9sI2X5aZQi+n+K0uak+puSLcUf8f27IaKuUPm
	bjCQ20L0Gq8vU8R7Os6BHqKOZddmcecUG9NSHqnSqq9pk8DIIxK/EIsIxkQcoIV4n85irchDThq
	+T9EuWBtpM+5/lDYyHNJSx8yFg0paqxj0+dWKFuRSL8od6VdOTO5r9/hr68/35UHYVSHY7AdeYz
	XTepfb8PqXyVoDTTCO5A28QXCuXohkNXjunn5dE4uhuvZbS5Oq7XzSDGg6+Bl0uXHK2/KFykV/V
	aCKABgRKBUXekVF0zTS2MTz524k7M0EuKHDf83QfLJxsUw5K6Xa+lfk9tKOXLWY+T+a3b8xcffJ
	5ozJhq8WkrmTRrIA6eyAYMom3HAEime+QCqB7GoDNGrTl44Fx7sgnEbRSahLRTD0dbf
X-Received: by 2002:a17:90a:d49:b0:3ab:be66:ddc5 with SMTP id 98e67ed59e1d1-3abbe66df3bmr7123391a91.6.1791909008669;
        Tue, 13 Oct 2026 09:30:08 -0700 (PDT)
Received: from localhost.localdomain ([119.127.198.225])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e26ddfsm5672992a12.17.2026.10.13.09.29.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 09:30:07 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	pablo@netfilter.org,
	stable@vger.kernel.org,
	Qihang <q.h.hack.winter@gmail.com>
Subject: [PATCH net] net/sched: cls_api: unlink indr cb on a failed bind
Date: Wed, 14 Oct 2026 00:29:49 +0800
Message-ID: <20261013162949.25622-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Binding a device without ndo_setup_tc() to a shared block goes through the
indirect path, and when that bind fails tcf_block_bind()'s error path
frees the driver callback while it is still linked on the global
flow_block_indr_list.  The next flow_indr_dev_unregister() of that driver
walks the freed node:

  tcf_block_get_ext()
    -> tcf_block_offload_cmd()
       -> flow_indr_dev_setup_offload()  [ allocates block_cb and links it
                                            on flow_block_indr_list ]
       -> tcf_block_setup() -> tcf_block_bind()
          -> err_unroll: list_del(&block_cb->driver_list);
                         flow_block_cb_free(block_cb);   [ kfree() ]
    -> err_block_offload_bind            [ no tcf_block_offload_unbind() ]

The only unlink is flow_indr_block_cb_remove(), which a driver calls while
handling FLOW_BLOCK_UNBIND, and a failed bind never delivers that command,
so nothing removes the node before the callback is freed.

commit da94a7781fc3 ("net/sched: cls_api: remove block_cb from driver_list
before freeing") fixed this loop for driver_list; indr.list is the link
that change still misses.

Fix by unlinking the callback before it is freed, and by initialising
indr.list in flow_block_cb_alloc(), so an unlinked callback carries an
empty list instead of an all-NULL one.  That is what makes the
list_empty() test exact for the direct and the indirect path alike.

Fixes: 1fac52da5942c ("net: flow_offload: consolidate indirect flow_block infrastructure")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 net/core/flow_offload.c | 2 ++
 net/sched/cls_api.c     | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/net/core/flow_offload.c b/net/core/flow_offload.c
index 5071d7fe6ce2..64451129a230 100644
--- a/net/core/flow_offload.c
+++ b/net/core/flow_offload.c
@@ -266,6 +266,8 @@ struct flow_block_cb *flow_block_cb_alloc(flow_setup_cb_t *cb,
 	if (!block_cb)
 		return ERR_PTR(-ENOMEM);
 
+	INIT_LIST_HEAD(&block_cb->indr.list);
+
 	block_cb->cb = cb;
 	block_cb->cb_ident = cb_ident;
 	block_cb->cb_priv = cb_priv;
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index a9f54988561f..ffbb8353251b 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1665,6 +1665,9 @@ static int tcf_block_bind(struct tcf_block *block,
 err_unroll:
 	list_for_each_entry_safe(block_cb, next, &bo->cb_list, list) {
 		list_del(&block_cb->driver_list);
+		/* linked only for an indirect bind */
+		if (!list_empty(&block_cb->indr.list))
+			list_del_init(&block_cb->indr.list);
 		if (i-- > 0) {
 			list_del(&block_cb->list);
 			tcf_block_playback_offloads(block, block_cb->cb,
-- 
2.54.0 (Apple Git-157)

