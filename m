Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259043AAF43
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255090; cv=none; b=jDpw76iWerZcKnpRQsOXAPNrEPjDuosoWxnHj2va03Lli6ChSy5kFFSPEp5CvGQVFkN2UPK0JY8pLpSkt17kV0ncNDxPGu6iRaTz5wVOqhVLrXPyxh9UohhPiTxH4NI4KqYkxHpXjmlVowogorvPSQS7nHaY8coZMrOlZTbf2tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255090; c=relaxed/simple;
	bh=k1zvhGigGSPLpGn7I1t+Ecg+NgN2CKsqg5w0eDmK1Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qwJ6wLWGYTG+tNqCQJDaLl/mMPIuTgeiPnMXMdKpzldcPYDJKKMyv6fYLPjFGG7uBjdjzZUCYXbICgF44B3Rm4KGnbKm+tGWzM8BEmXBlU/biFLbrnF31SXjNtl4q/DXE5ZOvVeT9YyEMmd4rPdKnwEUthVv31a6hKbosvt8KWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVlMdutf; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVlMdutf"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ccce6d9abfeso642583a12.1
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255087; x=1792859887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XAh01Cpw5RBFWDmpEo9RzWyBEVqwYJhyHp2rXB7kBDg=;
        b=eVlMdutf9BmRhjcL560lsYceBj9YDEUaaCvRIBrPqv0V11TXmTFFNbSalWi/OaLS+y
         zg4iguh7VOnK8KCiWMABclJRmz4mb4mBwxgvU9G5qISE4lKYKwtVggsDpob1L96GNsLk
         XjnefQFmXKhqzlyiy3JiubjFayUmmqHtQD6xAr8XB9ztmw5z4I1bbVKbi/wuDS/Hdevv
         Rw1cPI7n8yKVjApb5arDGvfLhr5b6g605LShiYqSPqYnblronGlVCARwZ0hiIIwLolix
         3yBHcG7yPBqDqc01ZMm1qN+GUeK+NXtMU5m8OBsTFLxnwjbhoY4y/zNzs5r+s38sam5l
         xHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255087; x=1792859887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XAh01Cpw5RBFWDmpEo9RzWyBEVqwYJhyHp2rXB7kBDg=;
        b=QWsty5z0XEtC0iB3USPDbWAUmV7ezKGcoVmSVWHPcdWysB4+XtZqBt1skk/d8oN8Y0
         WxITP6H6ulvcca0hEw5nJYEkUt/WKgliJcpGayjZ6gboLXVaWyuqrvVUUSPUKG/rblqF
         RpM1yxRSwCeYzCbhV3ml3SB1SxhijfeheIUR6rQMVbILr2zO4VYvJ/GkySpY3bAE0hAo
         wknkBPWrxxtgw+PP0brjbftfGVVYM7nCAQfQS+8ylB7SsEyhld+3GhZ/hE+yPpiyYc8y
         rXiiOx5tR39P0UeDLIElhJ/l9KW7gsy/l8cM2dcKnm1LyBxHPuEJSKUHHtf3WaRPH5cX
         Au2g==
X-Forwarded-Encrypted: i=1; AKwUvBzc4r2uL/2Ptljd5TkZcROF8TmaceV3QTMtNcUctDNrX9fSfs9ViuWwCFPkdnAHT2Kg/8A6nM8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIYvecPoQXALT+NFxjxaAF+N9C9gFFx+pTY2zFrXXcmy+Fo2myN
	NfWGs+kcnkkmZlaqeWuO7pUpuak76JUSMKLPE0st8lZX2Rd+R1rNhPmLDPI6hA==
X-Gm-Gg: AYBFou0IKJIDCQ0mPA6KuM+ON292EIr1OiZKX3vnWCXyw+0+qvCWB5FgdKrRTrqLWEC
	GJ1ep0uGTFov1h7Myg4t4IYjo5iCpr/iyyB2eKxZwqc10UPiizn7R29X8qfATxLSuOVPacZVZvr
	vr0CV1NI6LZtSSHLHo6Ma4b5lPE01LsnbOQWEbsyuRpW/gTB6JFBUii4mIoPSwF0xHWScbWgfN/
	QgkB/7mxvW9fJifnNOf3HSYnMn6wKxTYN9sAZCODazwWJ7daLBMEafTifyCyrVrl3sbyRMJ4uNN
	nRp/92yVujMKrXp05xwlnlyp5QeVc0rAXlqxwhlbCSfrbqFbGtbfH4NHdSsLlg5Am4O4IoHrfSE
	NOEf8fcDophQsrpDE6ELtkVC8zGFnTXViUz8v7RO2rGCH+FZw4UlvM5KgGeZCXo/DdxWJbqSuAx
	AWi+PYeJiq6BvlXZ2IdK8AZa/1ePasANZ9JGn8R+0GMJ5FlJ1RkhfQTeTNfYWW/2//nmQ2SpL/o
	3X2zrhcBQDRTiRCPgoV6s/qROtfPyMJk9WvfoBm6j/g+QYYXpeWTnHSZ8R0EV9AnT3fjeuZSSsV
	6CeWE7+IgVVI3rP73V6JaBXY2JC6XTo50xYNeqO/lec62INmbP0jgg==
X-Received: by 2002:a05:6a21:174b:b0:3de:60e0:5c9f with SMTP id adf61e73a8af0-3e226114a5cmr2548372637.65.1792255087416;
        Sat, 17 Oct 2026 09:38:07 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89fd010b47fsm1981842b3a.31.2026.10.17.09.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:38:07 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 03/43] bpf: don't leak the inode when token creation fails
Date: Sat, 17 Oct 2026 16:37:05 +0000
Message-ID: <20261017163745.3341787-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

bpf_token_create() allocates a bpffs inode and hands it to
alloc_file_pseudo().  The inode reference only moves to the new file when
that call succeeds: alloc_file_pseudo() leaves the caller's reference alone
on failure, and FD_PREPARE() does not even evaluate the file expression
when it cannot get a descriptor.

Before the conversion to FD_PREPARE() the error path did iput(inode).  The
conversion dropped it, so each BPF_TOKEN_CREATE that fails with -EMFILE,
-ENFILE or -ENOMEM at this point leaks an inode.  A task that is allowed to
create tokens can hit this at will by lowering RLIMIT_NOFILE, and the
leaked inodes make umount of that bpffs instance complain about busy
inodes.

Put the inode again if no file was created.

Fixes: 981bec8f698b ("bpf: convert bpf_token_create() to FD_PREPARE()")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/token.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index e85a179523f0..19660ef95ddb 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -169,8 +169,11 @@ int bpf_token_create(union bpf_attr *attr)
 	FD_PREPARE(fdf, O_CLOEXEC,
 		   alloc_file_pseudo(inode, path.mnt, BPF_TOKEN_INODE_NAME,
 				     O_RDWR, &bpf_token_fops));
-	if (fdf.err)
+	if (fdf.err) {
+		/* no file took over the inode reference */
+		iput(inode);
 		return fdf.err;
+	}
 
 	token = kzalloc_obj(*token, GFP_USER);
 	if (!token)
-- 
2.55.0

