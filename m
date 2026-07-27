Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9692641F7CF
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173024; cv=none; b=EqRzHxLQ3gNWsNcSC+OhwfPuubv7+Io1UnRt2kMmv2mmPzpDSlvPlXXA5bnfQjXg0iwCB6kADprLkaL4lFCaYJwA0bPMvusL7pCpANvIDJz76aCEVMFspLNVEvoDGwHwdhdu8hhD2T2r/k3BJ5OC0yXbU5LXZlj/pKSiwW4yczQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173024; c=relaxed/simple;
	bh=s363LUl92uQZgCoYdhuDsaYK4IelCiVDlHVt468omQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6AtLCxnJUlDqtIIaDpkihPnNu8/bKB7WXHimYZsGBAtqNs2BoHX59kBZPtRU+GhogdkWjZ8wnH5DyA5/XQLdXPpKCM4uRIlDmhajg3IgBEN2RMsPEvrt79cpxBA3AP3/6T0JV6/28uDzFf/dwBIR7KdlXjPf/v+SCpKj87o/1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/seq10J; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/seq10J"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2caed617615so30621975ad.3
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 10:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785173020; x=1785777820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8zwzwMImzPsVxAZCkajigW3782ZG1PdJgTUyjP/MvF8=;
        b=E/seq10JHmX0JWoRbR076jAnGs/ZSP1owtUbdN1S+PxRH1QYMhaefEZlcn+zh9vFxE
         cq4rVN7lsj+P4rC66EGJH5agp0HhLLXUJ8w+7mVDWHrAGlOEh0mY83yofyVHuSprIK1f
         HhhLztzMqAmP1jx2ciYW7IctUsZ+MO1uevdDoK7rhdAr+HehZ5pwVJApHueRd7m2O9gs
         jHLxmhcnHm/6cbYk40etZ8q6BhTInPXpSRgUdSjUIIz/9enn6kAHwb9PnoMI53s2SZdW
         BvCFYPm3kB9nhrsRg6kxvQtkTK1mwUBCBP2Th5jdQ6zMS9OxXYTk3YzRNgXQ4zzK6Yoj
         70+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785173020; x=1785777820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8zwzwMImzPsVxAZCkajigW3782ZG1PdJgTUyjP/MvF8=;
        b=VcyVdaetF4mNi1W3UduPQjdMK5+GrEVhRdhJy54sZl2eMh1DGHuksQpqTAVQ58BN4I
         6RC6RsIFmnmjXVvADhfOqnkHAWdyAKTkGlBcwGhkHCP6+Ji1GcEatBX99HLwBqVBWEr6
         taAyhE6e8UaIF4d1gGoCM8mnwILST0KUw87v7XKgrmbAqdQOaW9T2s5hrB6UU98Pb/RK
         19kEiwjPJfV6/McBMzhMTSvSOe4tXzQWKYqlh/UhL7ZPFVI5rpevdEemPy1UFZeT1bql
         xmgnZZAiuhPAvRXlGCjCwLCHWb48hLvztOQueeGvOc/U1FaEeITY1rOMgMVdnO9o1a4K
         i/4Q==
X-Gm-Message-State: AOJu0YwfLQVCyuNSENFEGYQ08iP5MEv405KYIQB7C1ao7WZU04EjY5sJ
	BIxTQKQTCMIyurkAfoO6sPjS+hjQzXUwhBoUM6gZnakQQdhoT9zHbAvDZItDrisJ6Hc=
X-Gm-Gg: AR+sD12pH6EOB+O/Paac1QnXi6UpTTgVv5olpIWgHHZNMye3U+5FmForMPwddfYcb4i
	VTCYPZ12lftIxGqLT7BatBVRcK6wN6YKkSi07nzc23eDCdMx+7RzihxkcgNdfZAKic3j+/g3fd+
	L7QBQBeF4w4tPGkRIgtlI+6K+h3h27tfCUG3o8pDQc9oGALxcocO4KpQsjlGcz5IfkhpIULw03S
	qmeYRmwlkVM8B1fliQMJwpmdTvkDBPR5JKaUrvRnFQhcrLaLT68BYZXhUsNb+Txp6DuPKBGANAW
	otmkH7FghvejK5XQCTaLCdmAGhizC0YKkpOqXlabOta5MQvUf6Zy3+q7yD5LBJ442izby3lZDeq
	zdFtcrZh1fu4ochZMv0dRT6GekRleFzw2JQEph7CAP4nlseOATB4tBJzBHgeIkfHLrKUL9qW8JM
	dXaDW5WjhWNLfLWLtBuZcU
X-Received: by 2002:a17:902:e5c5:b0:2ca:d818:61e5 with SMTP id d9443c01a7336-2d00f3ebe0bmr1847175ad.26.1785173019929;
        Mon, 27 Jul 2026 10:23:39 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([219.141.235.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e2a78sm39719795ad.26.2026.07.27.10.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 10:23:39 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net 1/1] inet: frags: publish queues before arming timer
Date: Tue, 28 Jul 2026 01:23:29 +0800
Message-ID: <bf66785e7c0c139d7a1900e2f01faeeab344b960.1784948849.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784948849.git.zhilinz@nebusec.ai>
References: <cover.1784948849.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

inet_frag_create() arms the fragment queue timer before inserting the
queue into the fqdir rhashtable. If the namespace fragment timeout is
zero or negative, the timer can run before the queue is published.

The timer callback then marks the queue complete, tries to remove a node
that is not in the hash table yet, and drops the anticipated hash
reference. Creation can subsequently publish the completed queue without
restoring that reference, leaving a stale hash node after the caller drops
the remaining reference.

Publish the queue first and arm the timer while holding the queue lock.
This makes timer expiry wait until the queue is visible in the hash table,
so inet_frag_kill() can remove the node and balance the hash reference.

Fixes: 648700f76b03 ("inet: frags: use rhashtables for reassembly units")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 net/ipv4/inet_fragment.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 848c0f0c2ed91..fc0cb993959f9 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -393,8 +393,8 @@ static struct inet_frag_queue *inet_frag_create(struct fqdir *fqdir,
 		*prev = ERR_PTR(-ENOMEM);
 		return NULL;
 	}
-	mod_timer(&q->timer, jiffies + fqdir->timeout);
 
+	spin_lock_bh(&q->lock);
 	*prev = rhashtable_lookup_get_insert_key(&fqdir->rhashtable, &q->key,
 						 &q->node, f->rhash_params);
 	if (*prev) {
@@ -402,13 +402,13 @@ static struct inet_frag_queue *inet_frag_create(struct fqdir *fqdir,
 		 * we need to cancel what inet_frag_alloc()
 		 * anticipated.
 		 */
-		int refs = 1;
-
 		q->flags |= INET_FRAG_COMPLETE;
-		inet_frag_kill(q, &refs);
-		inet_frag_putn(q, refs);
+		spin_unlock_bh(&q->lock);
+		inet_frag_putn(q, 2);
 		return NULL;
 	}
+	mod_timer(&q->timer, jiffies + fqdir->timeout);
+	spin_unlock_bh(&q->lock);
 	return q;
 }
 
-- 
2.43.0
