Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA64F4749F9
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 23:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785453548; cv=none; b=Cj03hUOA1I92E6RMFPR5+H2w0ymHoD3XyDMyIuDQlleVvWasOGebmDQWkMXoaGIAbkSqej3hJh37CwLPhfq/QHzi5Uk+kRMOI3l2JhFionnhjEFZ+uUuQJ15QrVCFOinBnnsMzh4jlwD4MT9hCQ6lmmtECQ4PuQGrnlhCaizidE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785453548; c=relaxed/simple;
	bh=aLMBrcPWTZCdw0WfHdJOhtUC+4XxhD23zOXG0xPYfwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2gb4WxHGDpK2L7fXDTlEvhimM+P2Qbf+DHpJTH2QOa78kvJpqCrUCgwMsn8HGIifX5LAZEEaKnLr86lP3FxI/x13+HKmt3/rll9c+f1/rA4oFmIJdFzcXo6w2JMNgYlB+0vE455EpFOQQBWDBxU6V9Yk7wOmswPiJ6yS1osEEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edbliV5G; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edbliV5G"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-84847482584so150427b3a.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 16:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785453546; x=1786058346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H7ePSkr4Nohk5yi+jX5ROWCggJE59bixaFcCgsHLMHk=;
        b=edbliV5G7b/1Qrv2bl2TeMx0WztMNGLPvmr2HV96YcOwrnRpm9E+RdN6NuwVHLl434
         Ft1P6cdVGYlHPL6pFDgxPs4tHwXlDAjZegnLp8LgCJ3HG5Kn6DWFjDGCKuWLRUM2YJ07
         jFuSfhFOCqlNUMAl0TBFo6JNSDyQy7XPSPQl8QGHQyQPBjK3WGYZl1gSP/CGrTu8/meO
         iPMVRGyc+RwruDIvdcSTqFuEUm99mpvT/czcJSWakn8dxSruIC7Zpf1fNsAKd2IjKZFq
         N2uowuQYFSiA0oFcX4HsRUr1Mj+GDY8LdtMckDkKMjijajQ72SPcAIwJa+Et08RTVMYn
         8F0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785453546; x=1786058346;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H7ePSkr4Nohk5yi+jX5ROWCggJE59bixaFcCgsHLMHk=;
        b=ZP4Gx6fz9Ghh5uJEPJHNPITc/g/AI+H25qbsYQWz+HndIMj8qe/FiP141bas6c6PO3
         WqDdTU1RuBF2ZgAOFtJxiAKxYU4bZ/4958B8jl80G/sCeq3aIHWBTQSuN8e07zufwLWA
         K1z0f+Mmrce0QXZNUuQn2bwg6SZgElo0zyZB2KTYonu0gTwRtpb/Jw+9Sj3auAD5lQ79
         4ObaPruZgoDGqN+UgSo+lfBKR8iML/YHspfsWwfofWPtptPRXc/1ckFV2rifz+OtszF4
         n0Vhd13VCshfnQXn22DjpIiHnNLz4li26hvjoSNwKG3opCo8H0QNRB0IkH5Y7qAnsDQ7
         kcfQ==
X-Gm-Message-State: AOJu0YwR39I5fUD8Nl15optXZWBBinLQlepXPIOzpF0JN+wjUNlW8SbY
	ORdUrWi3+Zg/4oZ38K42/pKye4O8vsL4eQBheHWozuTczHGrJblSwHgj
X-Gm-Gg: AR+sD13K/+NimlmkJT1E+jpt35fvqz8WFbnbHBKG0bQxIgm32fqIYmzCDK0MJNEXu88
	f8o8YGRYaPqdwW/Ljxl563jTfsy3/PnJXVLDSmZVic+rcXiHk3aIVQCR0K9sbUuwaRobmKK0d3I
	0HEFgxjMu+CFrNOttt7NngSeW+GrtL/D0bDTDns57xhmMtBlb60oTUC2FCt9ghLl6ZIw59gNIx2
	I0plHRogmLFrc36Lb6Ga/NeGl9DZPds5ct4V0iWBqembM1icBPJy6GsGxTW4kFng2d9UL4zVfdM
	PuYpGFlh7EboDfV5AK4/nlx924F+6/eDbG6jJmpdML43W7b+DgBZjAayGmAwFbhtcBRK0moyzB/
	LTJH9HchDFd+VAtD33HwCyNfEsFnPcCbU9o5wRH3y5oJHciQPOWDfPXnNIzT95fiA0yfFIxYunw
	LaWaEC/JcIR+Nib4AuJMMkGw3hG8ocgPkRzyh2mlQJF5yzA4NO+EFl1w==
X-Received: by 2002:a05:6a00:b8a:b0:848:2f58:e1eb with SMTP id d2e1a72fcca58-84ec9f635d1mr1760230b3a.38.1785453546109;
        Thu, 30 Jul 2026 16:19:06 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4c::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e9fe238ffsm3773363b3a.12.2026.07.30.16.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 16:19:05 -0700 (PDT)
Date: Thu, 30 Jul 2026 16:19:01 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, vega@nebusec.ai
Subject: Re: [PATCH net v2 0/1] xsk: fix unaccounted ring allocations causing
 memory exhaustion
Message-ID: <amvaYrq3bpuT5sqQ@devvm7509.cco0.facebook.com>
References: <20260730153832.11238-1-zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260730153832.11238-1-zihanx@nebusec.ai>

On 07/30, Zihan Xi wrote:
> Hi Linux kernel maintainers,
> 
> We found and validated a issue in net/xdp/xsk_queue.c. The bug is reachable by a
> non-root user via user and net namespace.
> We've tested it, and it should not affect any other functionality.
> 
> We will provide detailed information about the bug
> in this email, along with a PoC to trigger it.
> 
> ---- details below ----
> 
> Bug details:
> 
> AF_XDP lets user space allocate RX, TX, UMEM fill and UMEM completion
> rings with setsockopt() and mmap them into the process. The shared
> xskq_create() helper allocates the ring backing memory, but unlike UMEM
> registration it does not account those pages against RLIMIT_MEMLOCK /
> user->locked_vm.
> 
> As a result, a process with CAP_NET_RAW in a user and network namespace
> can request very large rings and pin a large amount of kernel memory
> before bind or any packet I/O. In our original report the resulting OOM
> ended in a panic because that guest had panic_on_oom enabled. The panic
> was only the environment-specific end result; the bug itself is the
> missing resource boundary that lets ring allocations consume excessive
> memory in the first place.
> 
> The first version tried to bound these allocations with sysctl_optmem_max,
> but that was the wrong resource model. We also evaluated a memcg-accounted
> vmalloc path as suggested,

[..]

> but memcg attribution by itself did not impose
> a default enforcement boundary in our validation setup.

Can you expand on this? Maybe we don't pass some GFP_ACCOUNT flag or
something?

> AF_XDP already
> uses RLIMIT_MEMLOCK / user->locked_vm to bound pinned UMEM pages, and the
> ring pages are likewise user-controlled, mmapable and long-lived. This
> version therefore accounts AF_XDP ring allocations with the existing
> mm_account_pinned_pages() helper and unaccounts them when the queue is
> destroyed, so ring memory is constrained by the same default limit model
> already used for AF_XDP UMEM pages.

We get RLIMIT_MEMLOCK just because the users do mmap(), nothing af_xdp
specific. Idk, manually doing accounting seems a bit wrong, memcg/kmem seems
like the way to go. (also, panic on oom also still seems wrong)
