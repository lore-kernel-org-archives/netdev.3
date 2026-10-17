Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA5719B5A3
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200663; cv=none; b=tNuahxoVotRpePDcSTa0vlgUJEZ5moACjeTqZB0T6tr9+HN80eQ+C65wSrbdwNNANnOjDN2mqzwQ6xxRcpdCEUxPXHJ7LBlCdEcgmCE3EpzZQLIB7cjiFfsD9D47Lm+amFVLhkMaVikLgRf1VcqxIar4wcDCIHJMamXhs47nzAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200663; c=relaxed/simple;
	bh=4CNEN7wC8Pe/7XrtPhrG7zkTQrJox5iMYzUoLmJvEaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkJ8n7714LK6XNvSrzlywLgF3KBJoB8Hi/utXg+bSPrLSmo4ngCR0G+hoCBT+PQAK/3BURS7Rk6YWN1yIqM+LLve2u+BHko7ca/+X0iv/+/MnaJzgIH+Jmo3ujDuohGEmWKTUYviaq+onJPKlDavasL84NHnLZGaNsQX3suxNqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQwdeTSQ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQwdeTSQ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e934449bb0so3520375ad.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 18:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200662; x=1792805462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GNgrelxi6eEq7P7hlNUFtYxqdxmASU5JrfOLjioF/SE=;
        b=SQwdeTSQzRA22heA2SuxGQuMGMV+Jd66s4pBifNQbzYreWo70GJkixVzD7oc7Uycwu
         ogYmLgpu0D58vL24Q7Wi6wfZlYDfH2c0jMIRscG7do3NzAxsIixu6YHagt2x1I01G7QJ
         A5AcWlbyu2iEKXc4LnPyWhTDiLe8O8dNmNty3TttQVKFzQmrjQ33dBoSzVNxRL+qjfyD
         xmdD6KWjLotO8LCdche/8EZpckGhDohvezIazqINx42x/exTRoy9iQ8+iNe53Tn4t7/6
         k6qCF/GbW5YyHksAVr/LU3QTJi45beWcYN1fpJHYoKcTaXcbrtnLDDM4b0HMY7X6IwQr
         MxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200662; x=1792805462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GNgrelxi6eEq7P7hlNUFtYxqdxmASU5JrfOLjioF/SE=;
        b=lWxIfN7yjV7LUNKZes/gMjkHpRUY79UsVHcrCKxlKyWkCaTLHBpqgsaP9o8l29aqKD
         kWIiBuXbS3jPofccvhNAbYj6tBRMZA7WWkPXLiSuU0CGkFJgboHR++wbZXXTqQaePLl4
         5tfPR3J1qP2x9Xf3tuqbXNggp3VjF9HthlnwHJ/Gn9TRZI+301KPzvZNpfIWSVEMv9hF
         TIUDSZpItQzHRWo3VhmojbV/RQtKxWyCp32J2hB2qI4akNB16mravchAtmyoYas5H9e6
         hKRfNG3Kr9DxuqaBONyu61Wen6eWe9dOFA8+Mrk4Ptc/AoxECzKq0oij4euxwmZw6nWC
         s7Nw==
X-Forwarded-Encrypted: i=1; AKwUvBxyXpa7Z7ouMnuJXKIdN09K+4Xob4IZlTVZjbqjyF0awWMZ+eACZklxJ66HBLKJi5+j6lUT7Yw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrEFQsslgrPxj3ag9V+hm70knntIHzF7bmwuoS4QhL0nQEApr4
	RKv8OmHxPust4VWEE3BJ4SGxpwL9IxqxlagiGwTHB5Op3dxyeo5R/bvv
X-Gm-Gg: AYBFou0OGrfTzansCCBsWeK6XCKhfdMW0G0r8Fb80ykeN9usp4YMuyp8q6GzEZ6mO4j
	nGkhKeiQ0DwCPPOSPxCrN1BYw0a7bBTzTq/yneE2Ubvk3Arn4wQSmAm35K8z9eJ5+6ZMazU3z1+
	XxIpMs8WcYyHq/JD7hCfCeIQMVCLNypD78DGifGBuBAdhALVBXleW1wNKTHuG+xZ6TlQcSHRDcx
	n5y6u3dc180VunnzZ+58lu1XpTB89EDhgDKpg7vcHGe/VOgDAGwk0cZMD7GJvZxvpzya/oq6SW5
	Hx8iPx5DpIBBYYW0rXy7jXk82+N31FjkGaeiW+JSt5VLnseCQ1L3c8R4FnLaYhU/Gk3RKbd7w6J
	ef60iBHaFaZ510/8i4Jq7ny0rl0eUJFS8S17llkdWTvxzOTFRDrrCsc7qkui6e7ZhoEx4fQYlBF
	l7CazmpmT9Y+kxedt1vsBBFcPMnZ8MuuGbxetougcUh+rXka0hYe6O04f5du9VhmaDjBJWU3dKs
	1gpvA0+vo2CGu4IWa1O0bhFhzER+coqwvNtRb4M+JhYvD5OPIDfZJ2A0OuCUm+FwURNkAGROc7i
	6XE/ov7XWVorPjDfb1L78s7uDJpVEGd8XZGOGxgYOns=
X-Received: by 2002:a17:903:22c3:b0:2e9:9846:2da7 with SMTP id d9443c01a7336-2e9a68437f0mr16777425ad.5.1792200661870;
        Fri, 16 Oct 2026 18:31:01 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e87993esm17107195ad.59.2026.10.16.18.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:31:01 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 26/38] bpf: Assume no bounds for a writable tp with tail calls
Date: Sat, 17 Oct 2026 01:24:39 +0000
Message-ID: <20261017012451.364800-18-alexei.starovoitov@gmail.com>
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

A writable raw tracepoint hands a buffer to the program.  The verifier
notes how far the program reaches into it, and bpf_probe_register() refuses
a program that reaches further than the tracepoint allows.  A program that
does not touch the buffer passes, and can tail-call one of its type that
reads and writes behind it.

Take a BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE program with a tail call to
reach as far as can be, as for the stack, the packet and the buffers of
iterators.  It cannot be attached any more.  Plain raw tracepoint programs,
for which the limit is zero, cannot get at the buffer, and a tail call
stays within one type: they are left alone.

Fixes: 9df1c28bb752 ("bpf: add writable context for raw tracepoints")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/fixups.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 002c3935a8eb..fe59e3114d82 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2153,6 +2153,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			prog->aux->max_pkt_offset = MAX_PACKET_OFF;
 			prog->aux->max_rdonly_access = U32_MAX;
 			prog->aux->max_rdwr_access = U32_MAX;
+			if (prog->type == BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE)
+				prog->aux->max_tp_access = U32_MAX;
 
 			/* mark bpf_tail_call as different opcode to avoid
 			 * conditional branch in the interpreter for every normal
-- 
2.55.0

