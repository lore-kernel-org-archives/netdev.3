Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE4E339364
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792119088; cv=none; b=lH1D1987GFX/oOqpXBcXETktxO20xhnHzeQXA67IVnASe37EY7U/iGI8e9raQkaTh3mhdRBNwcSPcmlvWJGbB2MiPR+cI8firhkDFKjpDfjD+K/SWxfa6lSk9TslxEbKbqrp4z4RYVkv2B4C3jLGnBrZZkM/zZRI9Zs7SfceaPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792119088; c=relaxed/simple;
	bh=27vTbKVtuAU57+rb13vcKbL2Z0lPHfh0MvIHD/GPnA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTvRsVzVAI+SC8gS4ptHgYzPoIf7189MsYU8a8flg/ueNAjCWCPvfOXDXEQzGykk67Jdhf7HgrS7uFpGkoILJR2ZmWOBgv+bc0zp1PDrutANqk4R6A8VMt+nj+FMEOfltHUlzgIolC5gwbvUB9TV61M/6bYfo1RhO3gjgvUQwI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Tl+cFZA1; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Tl+cFZA1"
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-91b834592afso50893626d6.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 19:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792119084; x=1792723884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2TyQLFh48hzkKE2YgP3OET3TwwPLZkG2Ufvt3pn/5dw=;
        b=Tl+cFZA1nbFH0+qlwN22BSvaIuf8heKYG/2oJ3KklZhQxLEUdibDLrZAntp52LHxUI
         R+lai4Urqs0/BaHN7q0/tGj84/bQ0B8VQ/57GRwGYJBmoHayzi5RbRxYjyXxe1vurLls
         hYSJy649E+uD4A+XG1+Er+7Z8EHnOg4gAwvSObhehls9sDG1pEiVzyvqMdsVas/rsIFP
         TUNeGdBlWqzzXyJmwPA8bLCHa6Fl1p7WR7gdiP6N+kmhQ5Yd+Ssir6PdkMM3BKTSFiZZ
         SGJyBSSW2pjuWoPsMGrQqnh52fOS/xMsPWteHpVVa92NuD/m3WihLSFLjncH1GXevBBJ
         yxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792119084; x=1792723884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2TyQLFh48hzkKE2YgP3OET3TwwPLZkG2Ufvt3pn/5dw=;
        b=DDv3/wjuZ8RiXBjvFA9hYIYscOuo/3j36SBLj41FT6c5UhZcEWGV3bMmKDG2Zd2jmh
         2UiD3ozp1i/skE/QUP8F2mZBFVV1yvJBRqNz2x11hbtX7yOjvmrpB1fePUkmdw6behsu
         GYC9w12dEIq17e5UiFFx+ZA3uqJwD6DPqmeJdcDNhloylt3ICcLz50Bxtz90aqWV5q0e
         mJorz7JKFRCsvPAYZ7KqtQPkOtd32ieYJaNBxfn34JaTencV7goGoVUxwcwmsqs29Fkk
         PWks2VcJe9RyzM1cUVBjs63A1YDM29GjXzrKor3QuezuRtRj1vhsJFEBX07EaxsYYHGT
         uSjw==
X-Gm-Message-State: AFq9FYIbUDesuVCN2GZLrmDYQJbjA2Opo9Co1RwcaA9HJwCnJm8ZB3xa
	F/iJCv1WtZ1W2e24Q/nzd4eEZcK1ix47g/tlM9Y8JoimuJJ4qUwr+GyQzHNGa3cOCyhpbySDfq9
	eGT+FgqvNxbYpJdvknJE0937p4mX8zbswyW6o3gT1RhruL85/XUUP
X-Gm-Gg: AYBFou38uTheRzxWktkaGl7uy+SZyqx7YxtrbzucjI9vlNhVChs0kQtPdS4mky26mwN
	Z35/HO/mkOVfUjub6AEyYtxpTm3TaJYWs9gcAgfxLYhgspn1N+ngXufY344TIjQ/jhPJNMUEGG5
	/Ms2Pmeniby6fB8INIq16GCa19sSbO9xbjTP2YQn/79pYoMPGMabRBvO3COmgy25vetAspd19gc
	bwImELq3YzpTkp1Vq828mKFIkREpJAJdnx/p9+8C2pFya1mNTVQDbDMOydhOLPSraYQSARWBmov
	Vd4XpEu0EQHh038Px3I7sXFcTo2epsbw/FhsVS5wWPWLx1g42pSH7WVaZkThcclV/lJyYNUiAgK
	Kc3mKGGDUgWsxhFqoEHbb
X-Received: by 2002:a05:620a:601b:b0:93b:ebd8:9147 with SMTP id af79cd13be357-93ebd1dc752mr3261106185a.18.1792119083701;
        Thu, 15 Oct 2026 19:51:23 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93f1a15e97asm19659485a.11.2026.10.15.19.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:51:23 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [IPv6:2620:125:9025:23::2ea])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id EDA10400B8;
	Thu, 15 Oct 2026 20:51:22 -0600 (MDT)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id EB8F8DC12FA; Thu, 15 Oct 2026 20:51:22 -0600 (MDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH net v2 2/2] strparser: don't serialize all parser work on one ordered workqueue
Date: Thu, 15 Oct 2026 20:44:54 -0600
Message-ID: <20261016025059.289202-3-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261016025059.289202-1-rjethwani@purestorage.com>
References: <20261016025059.289202-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strp_wq has been created with create_singlethread_workqueue() since
strparser was introduced, which makes it an ordered workqueue: at most
one strparser work item runs at a time, system-wide. Every strparser
user shares it: KCM, sockmap, espintcp and ovpn's TCP transport, and
every instance's msg_timer_work.

strp_work() takes cb.lock before reading, and every in-tree user leaves
cb.lock at its default, lock_sock(). The single kstrp worker therefore
already stalls for as long as any process holds the socket lock of any
strparser-attached socket, delaying parsing and message timeouts for
every other socket using strparser. The same applies to work that is
slow for other reasons, such as a lower socket's read_sock() doing
software decryption, which is what KCM over kTLS does now that the
previous patch moves its parsing to kstrp.

Nothing relies on the ordering:

 - The workqueue core never runs one work item on two workers at
   once, so a given strparser's work stays serialized with itself.
 - strp_work() and strp_msg_timeout() both run under cb.lock, so they
   are serialized against each other per socket by the socket lock,
   and strp_abort_strp() is idempotent through strp->stopped.
 - strp_done() cancels both with the _sync variants, which work on any
   workqueue.
 - Different strparsers were never ordered against each other: the
   common strp_data_ready() path runs inline in softirq on whichever
   CPU received the data, bypassing the workqueue entirely.

Allocate kstrp as a per-CPU, WQ_MEM_RECLAIM workqueue instead. kTLS's
tls-strp workqueue has the same flags, via create_workqueue(), but
caps max_active at 1 per CPU; kstrp uses the default limit (1024 per
CPU), so a work item blocked on a socket lock does not hold up others
queued on the same CPU. A per-CPU workqueue keeps the work local to
the CPU that received the data, like tls-strp; work that stays
CPU-bound for long is excluded from concurrency management by the
workqueue core's CPU-intensive detection.

This lets strparser work for different sockets run concurrently for
every user of strparser, not only KCM. Without it, the previous patch
would let one KCM psock doing software kTLS decryption on kstrp delay
parsing and message timeouts for every other strparser socket.

Tested with test_sockmap and the ovpn TCP selftests; strparser work now
runs concurrently across sockets with no dmesg warnings.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/strparser/strparser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index d5b17d099a0e..32fe96ba10d6 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -542,7 +542,7 @@ static int __init strp_dev_init(void)
 	BUILD_BUG_ON(sizeof(struct sk_skb_cb) >
 		     sizeof_field(struct sk_buff, cb));
 
-	strp_wq = create_singlethread_workqueue("kstrp");
+	strp_wq = alloc_workqueue("kstrp", WQ_PERCPU | WQ_MEM_RECLAIM, 0);
 	if (unlikely(!strp_wq))
 		return -ENOMEM;
 
-- 
2.50.1

