Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52403348C52
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 18:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785178448; cv=none; b=dnchjw6qbZoIM15vc4T+LJ9dv5P7NUgHJY4x21rjT1yij7C3GBq8yFWK46DhaKkjCnQ0Gn1wQVq55XxJE6vuwh57uGTFBbPiY1HCBsNvbXG87wi0v3/U9QB2Xuurb9177tcDfvkZPbqK258T1lz0fM2HhxIzj4YXt4ba36KIX00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785178448; c=relaxed/simple;
	bh=l2EdSttkWpc3qQTU50+lYA9ABF1SEFVin3hbuyG+jBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PgZwoQVSDghjxgLdU/j6Yu8pjbqzwD9EZuTgo4RD6D+DUMn7G/4SXG6iIKhEYIcENyDQjwB2QTa+z/X5inQFTYTqeEbuzRbPQFSSWXwNsKNfFzcWVNSJmflp/8DdNgqhd8cVjlQVlnISpfbhJ6pYTUOOq5ybKaiEin5NpG34X9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cn0659vy; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cn0659vy"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e602d2c0fso17864085a.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 11:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785178446; x=1785783246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P921xe+yNa0YG1jk1UjJjAuWqD1bwW4XIx58MotUwKQ=;
        b=Cn0659vydiyxkPhxqT6o6D4ToyzP20BJSapKx50C1O5PHjWuC4ixqG3s8G0VTq34A8
         /0sAh34I1r/p+iilDH2Gs187RJr3YxGMxpsAsdfK4Ceru2ZbTgvg5F5li27KYbp96PFn
         T1yNt0a6phw6cr4YepuDqqfDrqaIQlktPj8MaAh8m4C2eQBbvRFbCWAf5BXK22LSGZZC
         c5pIqfZ5eYMB5xHjkGAfUpI130Z0gGnX3JUrJQ46PpMsTFTf9caB8OG133wFFti49VNR
         tpxnvRjshsH5HX87gAK/GqWgHGpBXeVvOVu8mb6JWm2rm7hBcPGmfF97CUcJRuCMBmRB
         1qqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785178446; x=1785783246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P921xe+yNa0YG1jk1UjJjAuWqD1bwW4XIx58MotUwKQ=;
        b=ZI5EPzmSuRQYbAEBZIHfLxkJ0y43yojhFch2tQebtKZ0uydnFkjg5KCLo0rNUBLXZs
         Q2ZHR7v3ii4fvE0xY5zGOhxBZiqybBU9bT3NSVgkQWzAWzYisg0PRxMcaEgz2t4pXJHl
         XeTKq6osKnOXgqGoHS12Qm3YDNDoUgdJr6LHvE2laUHK35IR4k6aul/0zBN1TsSsKHfB
         +vUJ5ZwutJA5j/HLDkiRcPoBEwHnmrSXP4hP4FK8efV/HcQi66KEuZNC2pm8ri8iNpcN
         NOq8ySyWHU6nRG4Kj3CyzY5SeBhWNk+NcTg+mGf36/ckadz9J5c4RfaXMlqDUYROYFps
         rrEg==
X-Gm-Message-State: AOJu0YyWwVHtd+2JwjhQ5QgYJD2UYsVaK+1BvZkKTXG7o04Zk2vTJzfn
	U6nQaX4vuUmUfkC73ABORvau3TMKvVv+hiv+7pbOKHIrOs6/iwMTFdkARKT74rOm
X-Gm-Gg: AR+sD12fQl3gZq2tn8PAzHF/bOx9yqefuGH4X9T/zo+IwIP+9kxz88cIYM4DLVJKNyI
	lun89FyHgYpP8mVA/T9KmOtUqJpb6mfWo5fHhe3ZKvxSwfa86hmQAhOE+TDvHtzEDnpdyAFGw7K
	YnfL7/b4wJYJDeuYcNa+Isvjny/2isWXh2phH8Fq7ZYoDadSsk4iuB+kDuraqL6Ny224ikrfoK7
	WuE0CkOhUEaGfsqzmfKx8ZOruxpmU4KQQfLQ1UL32h+HVk5i2d1tp1D9sAFs0brs7Fwuy005qaZ
	zXU63MKOoVSURH+BPQTG2ZLFLLZna+URGFARHnq0HyrJe+5T47EdMW/6Rq/XQd8CGVdaoo9+0g+
	J/xHvtNmFlxDTGvC12sMRTY231FzhJkj05j+vqyToD2JICX+ARUZfXbdOEKRLZOkCUaLaq+E7U+
	Fq37ReMngAtElUKGO53v12tI6GZUtUXlo=
X-Received: by 2002:a05:620a:198c:b0:930:e544:69bf with SMTP id af79cd13be357-932fdbefa6cmr74684085a.36.1785178446106;
        Mon, 27 Jul 2026 11:54:06 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de54e09esm694185385a.17.2026.07.27.11.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 11:54:05 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: [PATCH net] ipv6: release fib6_null_entry on subtree failure
Date: Mon, 27 Jul 2026 14:53:39 -0400
Message-ID: <20260727185339.1545169-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When adding a source-specific route creates a new subtree, fib6_add()
installs fib6_null_entry as the temporary leaf of the new subtree root
and takes a fib6_info reference for that holder.

If adding the first source leaf fails, the code frees the just allocated
subtree root but leaves that hold behind. fib6_null_entry is a per-netns
sentinel and is freed directly at netns teardown, so this does not keep
the object alive. However, it leaves its visible refcount permanently
elevated and can eventually saturate the refcount on repeated failures.

Drop the null-entry reference before freeing the unlinked subtree root.

Fixes: 5ea715289af6 ("ipv6: broadly use fib6_info_hold() helper")
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 net/ipv6/ip6_fib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index a130cdfaebfb..e9fc692d4f3b 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1494,6 +1494,7 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
 				   root, and then (in failure) stale node
 				   in main tree.
 				 */
+				fib6_info_release(info->nl_net->ipv6.fib6_null_entry);
 				node_free_immediate(info->nl_net, sfn);
 				err = PTR_ERR(sn);
 				goto failure;
-- 
2.43.0

