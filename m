Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E3A38399E
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200881; cv=none; b=dXBwdNQQpqWNTdgJbjPMaPwdd/CbSMIN82yk4NxitKb8WeFSd9TRlrkKV6TZ3MCWxpYgTiesS9w97hyavLV9af41UigAup0sj7Yguux7UzJ3zX/TSilIi0CvWa9039/pdQz1GJD99qJRAksqm1X0EdZZGcFa9urkMAj/FWIEZjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200881; c=relaxed/simple;
	bh=BBFj6uGrCCWa2wnNUf9OZnXlooSA4nwIym3PBWpXpZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUs0g1Pjqbq+cRvnh+79XU1Sphtf5g/Qf1mOp1kWbcm/KKv5fl7TFnXR3M7ntoxKD6eVPTB18znhdPCI9gq8VR+IqQ/wLfNZ8drAAw90FcsBBYoj3WECwzyHqK1vurlrsSs1vZS6XgqNtrS7Lx20JjAYcCFab8fZifRrpY9TpV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pxh6He16; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxh6He16"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc4ca696de6so360765a12.2
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 18:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200878; x=1792805678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cs42Cg7pRUAaqxHt8fGk/dCScz1o4+6AnXssLG5JKeg=;
        b=pxh6He16bCZE4H3ANZK1ypve8E5GlzmISc9eKq/mCgMJv7ASHyRt8qLJVKDNOLt2Hh
         hPnzXpbxUesQGkXbtM2slgAl0fvfpZFngRVMZS5iePfIhh6DNsy88B2VWNpdbTY/dV98
         ueeJ1/HG4L+9MW/gTTa3isImQMTiOszh+MVJsuyru78wUw1ZIZMvT6cwiOfNR7FgNs1K
         mkuRA8KU4KRaHoBzDwrARDYlRi4ObWtT5i1yCFlL3wM4r5I/KNeYEO57FUlPmFMHua5r
         Na8R+z+4yBqnDRhgSDFR3brOIkmGI9aOGG167Khqo/JspIEdDRFdZ0Su43Z/SfXJbL4W
         nhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200878; x=1792805678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cs42Cg7pRUAaqxHt8fGk/dCScz1o4+6AnXssLG5JKeg=;
        b=Lp3enY2aoJpZ9z4/bKh5UHc5DCTlt/a284psoCBUn/xBgQMSTeNSgI6SjNrspH5gLh
         GzVGsWtdAGhhMWU+uvbBD8un1d3AV8JPpLzssKXQB4oqShPFi8CRqf73iwU6DSpyusiL
         Par5YMAYuSMEXogelgaNoEnh0GfGW4fCHNkWGGNadGIQx2GcBC4v+tv7peRdwEjW5pQ+
         qFNaSM6rZcZHQJ94EYI4wVtWz3akuyMkELT3tS/ydPvu5vcOYOrn4cYkPKqng0PAJWJk
         Rlc+V4LotlNy0kJ6I8rP/kTPYR8TurmKPr6A5qVppokhe8W3UUEOyuUVK4D3YucXN0Fi
         nMlQ==
X-Forwarded-Encrypted: i=1; AKwUvByPIBZLMfNGDOHo7uU+w/zijs5+8dJh/FxCs1NT5V0liRWotVHXL5eFFPh+99p/E1E6Sweqy0w=@vger.kernel.org
X-Gm-Message-State: AFq9FYItu0pr6LFPoeN2M0Y66H8/Pt4nKi45dws1pZrIlnVSbQciBy00
	NZD8hb8UrX8XhT1xAcbO0K5rtk2gJkUYT9xlIwpmG57U4gLLoBBwMqVT1fDH0k+x
X-Gm-Gg: AYBFou1CPVB2g3s62Crwsij7nYL8TkwCxzGshLd+SJUa19uQfUxpWtX2IS699+3VvkC
	tY5UmtQ1vcMQUr1Acm1MfO5UUQmR1Q4yCEhwqCfh9ZhY/PxjBncHpfsXLqzDElcdzc2/4/GutD7
	9lweXoma3vXCNGboO1/8RN0MLVU9BIduT2paVpSQc3clpkxnZBC9QDSgYRpy32/tU/8tmtpZkAi
	2ykZMB6kcePZ1Yt3yWcnUAIDEl8c5QF/90A2JF5MA5N+Pcd3G5mwGfzeNbFNWCSOqThcU3h2/td
	DdOz2Y4SDDYKJ348J2uHK27TqliHJkCC8IFD620rQEn9F0WI9KKjCJgSYrN3irYBbsR5wac42Xc
	GhW5/sXYHhrYqL5JVT7osDaTDes6CpNPhVHjoOxU/t/7MOoelNRAC+st0rrhPIG9uRhfw37xI3i
	/XpkZCsnGuLSalSmk5nAzXhqhwKLaKiu51ujIEai0hroy7llUaD2VxBt54kpRIs/DVIGxGQinGn
	cQ9+k0Au8yucg+9lSM5sAM3pu6Na3GpmITkzNzfqyD5lZmjBXSe0F0vSXj0gkC6uu2kSmrjqxh7
	be4XeVCf6iFCH89+qjfyGplaB4elLe9jYjp9X+z7P/ak
X-Received: by 2002:a17:90b:2d86:b0:3ab:2236:6b3d with SMTP id 98e67ed59e1d1-3acef17b4e9mr1437192a91.27.1792200877406;
        Fri, 16 Oct 2026 18:34:37 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94748c6csm11484456a91.10.2026.10.16.18.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:34:36 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 36/38] bpf: Follow the head if an skb is written from a slice
Date: Sat, 17 Oct 2026 01:24:49 +0000
Message-ID: <20261017012451.364800-28-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

The source of bpf_dynptr_write() may be a slice of the skb which is
written to, that is a pointer into its head. bpf_dynptr_copy() does it by
itself for a copy inside of one skb, if the source is linear and the
destination is not.

__bpf_skb_store_bytes() and __bpf_skb_meta_store_bytes() make the skb
writable first. If that reallocates the head, the source points to the old
one, and freed memory is copied into the packet.

The offsets in the head do not change when it is reallocated here. Make
the skb writable up front and move the source along with the head.

Fixes: 2012c867c800 ("bpf: verifier: Accept dynptr mem as mem in helpers")
Fixes: f38499ff45f5 ("bpf: Unclone skb head on bpf_dynptr_write to skb metadata")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index bf01152d0cf9..54e9084b9263 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1752,9 +1752,32 @@ static const struct bpf_func_proto bpf_skb_store_bytes_proto = {
 	.arg5_type	= ARG_ANYTHING,
 };
 
+/*
+ * The source of a write through a dynptr may be a slice of the same skb.
+ * Making the skb writable can move its head: follow the move.
+ */
+static int bpf_try_make_writable_from(struct sk_buff *skb, u32 write_len,
+				      const void **from)
+{
+	const void *head = skb->head;
+	bool in_head = *from >= head &&
+		       *from < (const void *)skb_end_pointer(skb);
+	int err;
+
+	err = bpf_try_make_writable(skb, write_len);
+	if (!err && in_head)
+		*from = skb->head + (*from - head);
+	return err;
+}
+
 int __bpf_skb_store_bytes(struct sk_buff *skb, u32 offset, const void *from,
 			  u32 len, u64 flags)
 {
+	if (unlikely(offset > INT_MAX))
+		return -EFAULT;
+	if (unlikely(bpf_try_make_writable_from(skb, offset + len, &from)))
+		return -EFAULT;
+
 	return ____bpf_skb_store_bytes(skb, offset, from, len, flags);
 }
 
@@ -12424,7 +12447,7 @@ int __bpf_skb_meta_store_bytes(struct sk_buff *skb, u32 offset,
 {
 	if (unlikely(flags))
 		return -EINVAL;
-	if (unlikely(bpf_try_make_writable(skb, 0)))
+	if (unlikely(bpf_try_make_writable_from(skb, 0, &from)))
 		return -EFAULT;
 
 	memmove(bpf_skb_meta_pointer(skb, offset), from, len);
-- 
2.55.0

