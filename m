Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730BB3A2E25
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255077; cv=none; b=cG0yMBpI+iOEsk05JB6ee0NczHO8TTzJxVYeT70Brfp485YSQ46L2tB7rqsrx3paweet0WS3DAOh2lFFvhL+Ph0nydo8ib7AjTjFFGbTU5JuNjyCdEmtZq4xUPB7FZ1hh4M7W4JXAYmlz+/uvZk/v6CGU+4NfI28gTmbXTMdv0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255077; c=relaxed/simple;
	bh=xr/G1io/jcMfHrR984t0P/qxqDapvYkztkruKBNwPW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=seNWJCx6C0x0tUud0r3QdM0Va9emtuqeW6WnoYeXViijdSyxLeKGgGm9smP/d1IH5/9gJzD9mqew9ORdrGp+degQ8BnYsHolrkF6IGBYqZceWN65A5vi5uxi8oszSa50Xw4kz2/6NiLXunbAHsBfSdkjuyVXNVacKx+12NnuazI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZnPEn4b; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZnPEn4b"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so861583a91.3
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255076; x=1792859876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dvPXxhxftG/h1Xzj+1bIi+SrjJdEQHzmOQDpnqTY+d4=;
        b=VZnPEn4bCnNhr0vsN3/I1x463jTLDz0k2dczl9I/3URUTe4XdmY5PQk2j7KkcEuUJj
         fuXm9dVdSmzIrPZj4MZwd0Bnu/Gl1d/mhIv4ef57Pfkgl82/AkpSn89e/jXLQLra6E3W
         ISWxwYhfuoDR3OHvQ4C+tUNzSwBDkLirRzgNivD4Zoj3OyffhItgHAxHPp6DVQRmM3lQ
         KQmZZjKfeevQLxn82sgUJTOUY5BGm4e0hI8DxVClhSbgllFs/RYBF1A1u1Fy2EeKofOG
         0kKa4rEhZ86eeH47njsSsAXRN7OJASD/IaibBsaZXzCDKva7kJPaNmw+4/k6LAkq4+VN
         bdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255076; x=1792859876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dvPXxhxftG/h1Xzj+1bIi+SrjJdEQHzmOQDpnqTY+d4=;
        b=h/Qfnu+SXK8VQok8e0Aobng01TR/OrCNc8O1mrH0vQRTlyjTfnqCfXvGPHFFh+Q8x5
         ohZKSANkL7QohesefCO7z0CnsitACrk4RIUTKHWC6d9hOHNHbmlw61l5fj32sfeiAyf7
         Wkot5jR+9Bb3RXeblWTgQqUYEGiPMjhoNx7LA5twX4j1HQu0J+RvzhrNnBaJlBC8wkWt
         JMkVvSTqBWiDjrsd3VXcondgov3+12obWcAlGqspYnE2USV6IE653SYPnIcGO+OzbkWi
         qC32WI7egWpzOHqp4CvC3tjdRDtazlxBkhKvHxEpkPzrQY6vCSTG5osHl+2FxNIud2p8
         U48w==
X-Forwarded-Encrypted: i=1; AKwUvBylwDdNaQVqxZ5Jboq6YuJPlAnNGl3J5Zi3bwjjtlLYgZfaXLq4MS7KHVOkiJkdO1xPo3DMMFU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkFtxYfkopSzuH9XlDw2DyubFYB3s5fRKIE0ckgTlqg7glrWuD
	3MoO8vxoMm1eeMBvQ8Lub/0vI3bTvZ7jxIBsgxqNmJ3kFtfa6ALwybkoJ/cl1Q==
X-Gm-Gg: AYBFou3hisWQ6/ZradusQp8xdz4QynVl55/HpiF1pSw0ar3XdJkoclrs1Ubj8Bte1l4
	gOOwllk6oSB2eb2lkV2XGEybynLSsuWaqKL/4PWfJkz7CiV11QALoohnGzz+pcl6hDaFvRFii5/
	3VaznyQDVAGaLfNstCSvi8qdIqn2TxwQChmvUI6Vd//WTylUMialihg40PqJGokFW733dKQK4ci
	VNQPrIRDnWMNF+JGXJ2m+uqGtpAVWBmqK8B21gkkpgx2s2fUJqsVRzHcooszigCiU4sexkyMw4O
	eq7AVE2VaoE3xFt05w+MgXN8fwtdNK532Qf8rJ6+TZfKKEYW38KfpqxvvYm/6vjSLQxJtITxHnp
	SucKRnMz7jJocPPZnhBU8fvSwM4EESf7b4LI8MAx2c+2cdDW1RLoZTwx8xlex0NuCakX3MW8+dB
	N2/urdemObHY0QSrHyJMx+5Vr5994XUqJGdENX2v1hUAQSeqRfbN82mW8v6Ip06s567GGRaTl4w
	GDAz7pL2JeQKlMyWMWmOCJhWyvsyBBqeakWtlK2aBeIDjSRBouSTnLxuRqRjfgJxopjBpbbcjaX
	MLvLmB+r42yYvNij5DITRAu04TZ2Uw2I7XxuUdyitssM
X-Received: by 2002:a17:90b:3d8f:b0:3ab:9c73:130 with SMTP id 98e67ed59e1d1-3aceec2cf3cmr2554720a91.33.1792255075567;
        Sat, 17 Oct 2026 09:37:55 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd3f3ce5asm3280154a91.3.2026.10.17.09.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:37:55 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 01/43] bpf: use the frame mem type in devmap egress XDP
Date: Sat, 17 Oct 2026 16:37:03 +0000
Message-ID: <20261017163745.3341787-2-alexei.starovoitov@gmail.com>
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

A devmap egress program that removes a whole fragment of a redirected
xdp_frame with bpf_xdp_adjust_tail() or bpf_xdp_pull_data() frees it
with page_frag_free() whatever the frame's memory type is. For a
MEM_TYPE_PAGE_POOL frame from a page_pool based driver this drops the
page reference owned by the pool while the pool still accounts the
fragment ("page_pool leak" bad page, leaked pp reference).

kernel/bpf/devmap.c:dev_map_bpf_prog_run() points xdp.rxq at an
on-stack

    struct xdp_rxq_info rxq = { .dev = rx_dev };

whose mem.type is 0, i.e. MEM_TYPE_PAGE_SHARED, and
net/core/filter.c:bpf_xdp_shrink_data() releases frags according to
rxq->mem.type. cpumap, which runs programs on xdp_frames the same way,
already copies xdpf->mem_type into its private rxq for each frame.

With 9000 byte frames from virtio_net and an egress program that cuts the
fragments off:

  BUG: Bad page state in process swapper/3  pfn:10660b
  page dumped because: page_pool leak
   bad_page+0xbd/0x190
   __free_frozen_pages+0x5c7/0x900
   bpf_xdp_adjust_tail+0x3be/0x480
   bpf_prog_dad43f894a3faff7_egress+0x15c/0x1cd
   dev_map_bpf_prog_run+0x288/0x610

The pool waits for these pages for ever when its device is gone. That is
the harmless case. A page of the pool can hold more than one fragment
while its refcount is 1: the first page_frag_free() frees it under the
fragment which is still in use, and the second one runs into

  page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
  kernel BUG at include/linux/mm.h:1846!

veth is not affected. It takes references of its own on the pages and
redirects the frame as MEM_TYPE_PAGE_SHARED.

Fix by setting rxq.mem.type from each frame before running the devmap
program, as cpu_map_bpf_prog_run_xdp() does.

Fixes: ca9984c5f0ab ("bpf: devmap: provide rxq after redirect")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/devmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index dc7b859e8bbf..1b8f0d7f8455 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -350,6 +350,7 @@ static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
 
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 		xdp.txq = &txq;
+		rxq.mem.type = xdpf->mem_type;
 		xdp.rxq = &rxq;
 
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
-- 
2.55.0

