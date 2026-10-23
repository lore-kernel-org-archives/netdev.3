Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792753196;
	b=h33U5v4M9Ai4hwnCdgMaqLCUlCVDoJjQiP9+kYHDydGYaa+K1OJqQVrYRCwg5QkDo0+n
	 fD6akPDV0TmLvOUs6sYaF6Ds/dVoQarrjsxPEfMcp7b3fwbKEpTLJbgsZIjUy30aFDtii
	 IZopQHpgqWnaP4RhlOEMXENPtaYCOOtJzRII30Qwm9w3rfxsjJb9+XzNrZKElTuvOgEyy
	 ugUrwbtti20imlyD/oVOO3nZwfzvZlNOjCW3B9yT4kB5RTgK8bYq90vk+5Wl+8t6LavtA
	 8As0HoBJpaU60sebgk6+x0babEZZaWijJyReqkRO/zMVWc8XcSXZ70C/dljIwtEy/6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792753196;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=z+6PEEiczn9f1FdMZrbK++0waYeSUay7WeaYaFC0ND8=;
	b=AUJqUHivXGek9XHG/Ud0KNYEHTIFTUF0uQqHLSzv8D0pCeburVmv7cn7ZkET+amDBfcZ
	 RwMZC56Lr42xDHUnESu2vDUSfvAskFvb1IG1ADKSqJjBLjmkaIWazXE1rZoPoFH8v6SSr
	 tkzFLBIxV/viItz7RPDdTCWVDSGBPSNsjHTWQEMJI4D9Af5huXnSHz3v9T3DfVwWMz0GU
	 F3Qm28GYZmJOe7uijh1OVg3HFx5AN5GJLmj9CTv0kzyelHXvdDBdyE+YmWE4EpCjgkzZk
	 JsCui/MW12msXUN/PMYfXPpqtlCmA9JXIo58vi05OiG0qMdj06ZF5BzvgaEkzFCoy1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dSPSi7aG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B317606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dSPSi7aG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BF71F01828;
	Fri, 23 Oct 2026 10:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792753196;
	bh=z+6PEEiczn9f1FdMZrbK++0waYeSUay7WeaYaFC0ND8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dSPSi7aGk+4Sl3SsMZNm8eh7RUKQ4yLKF9ZYQ0h89q6gkoXxYuW6R7QjOIbcbvvh/
	 UOJoyVJe+1wpzMOQDZQ2ps4rsxqRMH70sDEgtQIXZVzgjXVVOsJW1BUCnqo4xFa2pj
	 HWewj3dbBkutTSBSdLs+bjbsNpKycHbk4/f/nhPCbs9sVy/BjPm3CboebXCp0yYeqD
	 2/eGlxrIDITUCH4eL6FX8RKwXRbXyof3sWMGrEdzlEeJyUatrEI5davg9bmRgv4/pc
	 S7gfUmSH80Wf1VxiP5aDK7tWdAuDt9/Plb9lk1hepYooNimz43CJPh/TrbHYH3YzjI
	 OLaaz3dgA5icw==
Date: Fri, 23 Oct 2026 11:59:53 +0100
From: Simon Horman <horms@kernel.org>
To: Dudu Lu <phx0fer@gmail.com>
Cc: vinicius.gomes@intel.com, jhs@mojatatu.com, jiri@resnulli.us,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net/sched: taprio: unwind the netdevice notifier if
 register_qdisc() fails
Message-ID: <20261023105953.GK708417@horms.kernel.org>
References: <20261021155417.66254-1-phx0fer@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021155417.66254-1-phx0fer@gmail.com>

On Wed, Oct 21, 2026 at 11:54:17PM +0800, Dudu Lu wrote:
> taprio_module_init() registers taprio_device_notifier and then returns
> register_qdisc()'s error directly.  When register_qdisc() fails the
> notifier stays registered, but the loader's failure path frees the module
> image without ever calling the __exit function, so netdev_chain is left
> pointing at taprio_device_notifier.notifier_call -- a function pointer
> that lives in text that has just been freed.
> 
> register_qdisc() has two failure returns: -EEXIST (duplicate .id) and
> -EINVAL (malformed cl_ops).  taprio_class_ops satisfies every checked
> implication, so -EINVAL is unreachable and -EEXIST is the only reachable
> failure; it needs a pre-existing "taprio" entry in qdisc_base.  In-tree
> that is reachable only through bpf_qdisc_reg() (CONFIG_NET_SCH_BPF); a
> module calling the exported register_qdisc() reaches it as well.
> 
> Once the notifier is left dangling, the next netdevice event that walks
> netdev_chain calls through the stale pointer:
> 
>   BUG: KASAN: vmalloc-out-of-bounds in notifier_call_chain+0x650/0xb5c
>   Read of size 8 at addr ffff80001fc5ab08 by task ip/110
>    notifier_call_chain+0x650/0xb5c
>    raw_notifier_call_chain+0x34/0x64
>    call_netdevice_notifiers_info+0xa8/0x198
>    __dev_close_many+0xe0/0x800
>    ...
>   >ffff80001fc5ab00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> 
> The shadow row is all f8 (KASAN_VMALLOC_INVALID): the read lands in
> vmalloc memory that was poisoned when the module image was freed, and the
> indirect call is unguarded because the only check, func_ptr_is_kernel_text(),
> is compiled out unless CONFIG_DEBUG_NOTIFIERS.
> 
> Mirror the sibling sch_cbs.c and act_mirred.c, which unwind the notifier
> on this failure path.
> 
> Fixes: 7b9eba7ba0c1 ("net/sched: taprio: fix picos_per_byte miscalculation")
> Assisted-by: LLM
> Signed-off-by: Dudu Lu <phx0fer@gmail.com>
> ---
> Tested base
> -----------
> Detected on Linux 7.3-rc4 (commit 93f51579e7df), arm64 QEMU guest.
> Re-checked against mainline f47d223627f8 (v7.3-341): the affected code
> is unchanged between the two, so the bug is still present there.
> Checked against linux-next next-20261021 (commit 9a482184d910): the
> affected code is unchanged there as well, so the bug is still present in
> linux-next too.
> 
> Reproducer status
> -----------------
> A reproducer was written and executed on an arm64 QEMU guest with
> CONFIG_NET_SCH_TAPRIO=m, KASAN_VMALLOC=y, CONFIG_MODULE_UNLOAD=y; it fires at the
> claimed sink.  The reproducer source is not posted here per
> Documentation/process/security-bugs.rst; it is available on request.
> 
> Triggering conditions
> ---------------------
> A pre-existing "taprio" entry in qdisc_base, so register_qdisc() returns
> -EEXIST (the only reachable failure).  In-tree this is reachable via
> bpf_qdisc_reg() (CONFIG_NET_SCH_BPF); the reproducer reaches it through the
> exported register_qdisc().  Then a NETDEV_UP event.
> 
> Notes
> -----
> Built and checkpatch-clean: this patch was applied on top of 7.3-rc4
> (commit 93f51579e7df) and a full arm64 kernel (defconfig) was built with
> it -- no new warnings or errors.  scripts/checkpatch.pl reports 0 errors,
> 0 warnings.

Reviewed-by: Simon Horman <horms@kernel.org>

