Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9F8395D86
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787556696; cv=none; b=NMY325MGSfx4KdyQgzOi1U22gOvYXvuHlSSGXrdfO+bFiuqIcqPPVlcqQmI51nH77CxhCBZ0NMoDEWMVqPuGKtrI8U9vT3b53r113m2pHmdHuTvLgQzPPlQKESHPrzOl9QGHW+dW2JW5AD+jRFPpdGTclPvmXrxjjPfEJ51uRzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787556696; c=relaxed/simple;
	bh=PveI3powooGQqU85bnZ0Z1EeX9FyZE3ak0omOVQUrTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ye0IagB3YzBbPCsTcMVa1oAeGIJruEOC686y2F3JNSG3mb6lnhIqLK9fEsNFSj9SvNa/EuV2kXg2DdhYacZCZj8LGYWCImrpfGow4VCKMlKsioaSy+SMF+dRuRHODrvXRpYpLhuxmTczIMLAXhIwqjNoSdXbHv99yfOcBmkCfHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aronleigh.au; spf=fail smtp.mailfrom=aronleigh.au; dkim=pass (2048-bit key) header.d=aronleigh.au header.i=@aronleigh.au header.b=HIlH8TJ0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aronleigh.au
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=aronleigh.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aronleigh.au header.i=@aronleigh.au header.b="HIlH8TJ0"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d032846c95so38090935ad.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 00:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aronleigh.au; s=google; t=1787556692; x=1788161492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uLb5oidJqIEh95Ts+9Y1LRvCSg2t1mOJW2d3dmW0KHI=;
        b=HIlH8TJ0GGKwvSzeEALLYtnXZMQaQ1xZMJalClEBHa4c0660bpJFkLVCpax4NOcPzw
         T7YRsxaJH1s+7OFcZ4JyQz6WuuBHb9cWW/datcnMLLB1HhG5LIw/voAtOHMwqMNejBV9
         gU83sGFeR+WD1SlAGFq4HEGLn7f6QqoXa5CwyHhuN9GiEdg0ZS6cea0Z9Me3X+AZDv8M
         Ksp+NBWu7Gq/Vj0wuB2xfLqTGzQ4xmfbI1ziz/ao2D83VT7l1TBlsAzSK14EDoMMwFHk
         gPSugZw4qGIwy9gGyFv3adQTanwaf53pFvCxk7o5wWd/ah48fjPtAb6U23vflPWDvdtB
         uc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787556692; x=1788161492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uLb5oidJqIEh95Ts+9Y1LRvCSg2t1mOJW2d3dmW0KHI=;
        b=sJzsP7WvGFHPavq6AtmH2x9sLq1IKetQ+YTyYUIvd/qzMl1//kdd3j5FHmv+X3Ywgo
         UzZxIynMHWvM0/5SSC2jOdSxWQmG+59TFJ7aGX8atjh2E6VLZHa7LaR3etw1b0QfWp01
         /2KQ4OpZMl4BT1DBe1EJpvxmEEXyaXvK1RKTv5KEIEwLGHhCtsxAGcTg34hCAVEjxTMO
         UtS94mvgGs83qxpKuU4IdHHkC8RZ/LGCnRCB4hoWmGlgYjdIWqvatwPChOA8m5SVOu74
         zyl8th25MpCOZugIaYPVfbKcI9r4IC5leXtvIMvoAEhreuKVzJd6vRvCkSMCMphaSMGZ
         ZK3Q==
X-Forwarded-Encrypted: i=1; AHgh+RqKc5om67cPPyBEcVOeUljF6KXymz6AAEHhxYVNhnJtvUdgj/KJyResPdI6vw4GnSdMl2JWuYo=@vger.kernel.org
X-Gm-Message-State: AFuF++lOb0i1hgKlVdMIYTIXl9Npw39pGkkU3mVyCppcgE+Yt7smvxmv
	JWfYH6mDfsu7PRi2S7jUhNmCw6ibdWxjR0928EnemWnwOSaz+4Olon6kjHbPLe6uDF+3
X-Gm-Gg: AR+sD123APom3wz6FwvK/3Q97nhmUlOOSe9zYasf34YvyKdy8g1jqvqmdGtFEE7sxh7
	fUT0mwGyA0JdvMa+9zBps5nlyuyf1ZBmyOI3S5n0KqoZbxzKqKQItjzxuYUgTn2++vs/e1kgISj
	Vp9eK7Hry6w+ovHL40gemSJHq5pYqGq6pwx+SUFs/b6GdRoKrDQYAwblfKaFBZKarfTmq05qNUk
	99wxvVn0/XQaQaxZbLPC7f+tAp9zQvyx48pDDy3AwDnUfGb0wb1x8hLM86y9yOoUFtY3ZdEzjZO
	/FysvpO3coGw9gZpQbyIflu3+ODvjs9o2VusnJfhCcM+eJxnwedgfGrtz7H9KgtsqGbByA9+ZAq
	mhbnrnFp5biwAcrGKvOksTWSTL/xcI7XK87y2Nm6kJzXdnClILuVgYotd6l/3ax23RKX5Ko9lSb
	6FfolT/O3MkIjqM0dfxmO0y2QmJpCXwQoFe6rrJ+xRnAjed31v7frzspSk0fAWZTQfH+u7bODQn
	QQy4RJJ7HZFdWox2qE0+d2Jsr+O1aTJr64=
X-Received: by 2002:a17:90b:180d:b0:38e:2524:724f with SMTP id 98e67ed59e1d1-395c3733e65mr43431160a91.12.1787556692517;
        Mon, 24 Aug 2026 00:31:32 -0700 (PDT)
Received: from ghostoverflow.. ([1.145.153.192])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90cb8e3sm33763741eec.12.2026.08.24.00.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 00:31:31 -0700 (PDT)
From: Lilly Aronleigh <lilly@aronleigh.au>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au
Cc: Lilly Aronleigh <lilly@aronleigh.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Hopps <chopps@labn.net>,
	netdev@vger.kernel.org (open list:NETWORKING [IPSEC]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3] xfrm: iptfs: avoid canceling reorder-window drop timer
Date: Mon, 24 Aug 2026 17:28:52 +1000
Message-ID: <20260824072851.301644-3-lilly@aronleigh.au>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IP-TFS uses xtfs->drop_timer for both partial inner-packet
reassembly and the reorder-window drop timeout. Reassembly completion
currently cancels the timer unconditionally.

That is only correct when the reorder window is empty. If the reorder
window already contains saved packets, the same timer belongs to the
reorder-window state and must remain armed so the missing sequence can
be considered lost and the window can advance.

Only cancel drop_timer from __iptfs_reassem_done() when the reorder
window has no saved packets. The existing drop_lock serializes this
with the reorder-window paths, and a failed cancel remains harmless.

Tested with a reproducer that completes reassembly while the reorder
window contains saved packets.

With this change, the reorder-window timeout remains active and the
window can advance correctly when the missing sequence is not received.

Fixes: 0756947654468 ("xfrm: iptfs: handle received fragmented inner packets")
Assisted-by: ChatGPT:5.5-extrahigh
Assisted-by: Claude:4.6-opus
Signed-off-by: Lilly Aronleigh <lilly@aronleigh.au>

---
v3:
 - Resubmission via git send-email to fix formatting

v2:
 - Rebased onto current net tree
 - No functional changes

Link: https://lore.kernel.org/netdev/CAFrrV-O1fesaza+5_WqH8OciXRu9KKE4UsB6RcMamDu0j2-nBA@mail.gmail.com/T/#u
---
 net/xfrm/xfrm_iptfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 6920940a35b4..23e0face2b9f 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -707,8 +707,12 @@ static void __iptfs_reassem_done(struct xfrm_iptfs_data *xtfs, bool free)
 {
 	assert_spin_locked(&xtfs->drop_lock);
 
-	/* We don't care if it works locking takes care of things */
-	hrtimer_try_to_cancel(&xtfs->drop_timer);
+        /*
+         * The drop timer also drives the reorder window timeout. Locking makes
+         * a failed cancel harmless.
+         */
+        if (!xtfs->w_savedlen)
+                hrtimer_try_to_cancel(&xtfs->drop_timer);
 	if (free)
 		kfree_skb(xtfs->ra_newskb);
 	xtfs->ra_newskb = NULL;
-- 
2.43.0

