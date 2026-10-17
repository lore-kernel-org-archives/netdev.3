Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39096356751
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200073; cv=none; b=qXlt220pZmwiOM+wxbzI3NPERG6ghke8SiDGLXEQ9ZJMiR6El8ibSUDCHJ8el+ZklqOHyQlt2DXEqXxXWW04xnr5nlmPU2WKM9N7xEo6MxPZY4AKLuJrHtjperWSJeO9fUMFORU0kloSNtVRgItdGcswUZYpQyzNDoPxMDVG0E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200073; c=relaxed/simple;
	bh=k1zvhGigGSPLpGn7I1t+Ecg+NgN2CKsqg5w0eDmK1Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLKEUTr3ZyxTuuE/300F6GiKk5W2iSpBn0T7ek0LKjftdk2Or8e9Y0ck8ArzpwsPPl85qrOW1x8aTr1jmq9J1wnOWvuXxBg01QhTfAqmm8BfIAQLMZpwvFaxxVesYzwfyAOf4fHBDB9iQChLAOWAoJGdscEFHKQM8uyQgvedyvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjwkqDun; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjwkqDun"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so333562a91.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 18:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200070; x=1792804870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XAh01Cpw5RBFWDmpEo9RzWyBEVqwYJhyHp2rXB7kBDg=;
        b=IjwkqDun5eJK5IhgMg/zSNoJizi3cxprs4LModvaz/X1Fre8Ogh6Vw4OpPJB+ffTfF
         +CDqGAHbeqpT2Wb9hCcm15f3HSBospXlXjkSJ7HRajnmHBL9uBzHH8x6fxypi84lxvB1
         gwl9ZuaELiO61wbdy7EafPQ2CQP0GgrXUSTWMx1LJfok4ETqkIxWQi2cD0u5tS6Rmhiq
         uCisBjLyqssY8FpPGiHQQ9COyNGh2jgV7EYCJKx9+gVpIaD5f9h05E0ljlKEbzeYJuHC
         TR/sL9YYdga0W4PX2WHxHnmTIJJu6wMwhyF1eEMwq/y3/wSy1ybOCP3YC7m3auOn6/GX
         0T3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200070; x=1792804870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XAh01Cpw5RBFWDmpEo9RzWyBEVqwYJhyHp2rXB7kBDg=;
        b=L3h6xQnLLz9ty5qU6ruSzHwVbtM3p5NlG3qKbCTOvRpZx5WXg5zPk5HdiOUV6PupIb
         dNbpqie9CEhBXdkAoILPR+gbM4yUrRCkEu8fGYbW86cm0taEvK7AU1cmJ15IPQqVxQ3f
         4OsAbQkGD6BezB11m3EcSsVvNekqetRZeGUVXyxRekNnbtRk3VhElgmAl7EvGcoK4FN9
         t5yxvs+sfsJw802aYJ+svAot3RUrubiVMJq6EkWO4JJpgbkl9vA8ggVQ4wJ5yzMyBsxR
         PoItYQ/zjw2waLXwZMtFbapj87X8/JwmCcfFl9O2kiPYpEfSZcOlvDuqrZaZY2JpQHJu
         Cx3A==
X-Forwarded-Encrypted: i=1; AKwUvBw1JFWvQZmk9p2/pV2o5LhRwQkHPh/RcLjrx+BvdBW5i7orkmLEofvjmANd9mitQEpo+xl7lt4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2aIC/FhFPiHdfY0A1YrN+5+xmo7gTL6nMr1w9j0FRxspRCckE
	QO6WrNH8B8IJMNCxFmvrtibesiLgx9VW5Inr/c0vFXdp3mwLCiRHFt11
X-Gm-Gg: AYBFou0nrxZ/8yh9eKove5LGlopaJyP4jUtKzUp00yaWADo75k28MkphJ8MFroyUTU0
	4m5zkAr4sk4vivmV7g8T9yL+ldp0DPqnbPAEboKjzCFf3SI+f8WJhUIJ5gUDizJOlyfOAJqLSKh
	hFdUyNcFihpYLNVUbxrIz+hUntZMG9ucyquz6YTKCqn77Ufl8osMdk2q9o+t7xbhhVEOkd01yD5
	i+0TGiRate2SfDK61/z+M7CeCtwkFM3iYTy8dudaxpYThSPNEATyIkPo0Ex7/hpS+Uk2qr2/vnd
	xb1BQQBWcsZNcLt3iL1U0h4Nf/hQnDGckVtKesdXzj+R4C2t2RO58EjOlIM+VGgf+r5PQXzyN3D
	j7Cf34+zENvWVZWGryX7+l6lD6Va1FuwYifrlskKOVNBf7v1UDxa0iEkyZHUcogO5x6wn+qefeP
	ADt5a5e3+6Fww5TjewAmPPVylleACMkWIsIVvlUMCnZb30+IKSVZiAWCcalmc044sdi9iKe/IIc
	74udhCj4LYvY2NYjvPYfixob5AI81e0F1Ic+kvUkXpwYTqBzjuS2+7vLkRktpV7Yl6zJ2mcYb92
	Oxxid0sqRLwkdDAs5sA2NjWRgMT33mzhEKu7QXWxCug=
X-Received: by 2002:a17:90b:164b:b0:3a7:a6bc:9d58 with SMTP id 98e67ed59e1d1-3acef179290mr1109011a91.54.1792200070336;
        Fri, 16 Oct 2026 18:21:10 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc98139ccsm3407339a91.0.2026.10.16.18.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:21:09 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 03/38] bpf: don't leak the inode when token creation fails
Date: Sat, 17 Oct 2026 01:20:23 +0000
Message-ID: <20261017012058.355787-4-alexei.starovoitov@gmail.com>
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

