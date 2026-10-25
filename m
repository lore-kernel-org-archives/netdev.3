Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792928454;
	b=kEeJmYr8i+yn6YFanbAX7/Kn/Kw4tJ+uuGhyucvTUGxJBw1kk7MfgSK5eUAkZHXwm6dx
	 3KO6JRDKgWLgps0Os/zGceJFWw0cpBbpAKuPSids2BJzFvsl8FQon3b2z9sjtSVdUUUFF
	 K0V9QhO1UWRkPFxCsUQDYPUF0g87onLO+ftmAgqmyIlirYQ7EdQGhV86mqRYHNg3Vd0n7
	 xgt1pm3CJOeDw2Z1bCVahRqS7qf0gdNurIj0Uz6pNzqH1X8EKL797Bjst1Q39U2shBPbF
	 E0ytkXmOctj/xEP48nhs/mLdI+HBHIVZR+VFYuSljeuXscDAGa2WdX7psAUan2CkR7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792928454;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1r2HAJnurvTfhiE6pv1KD8iHRlUXOHrLlO2pQEz5JBA=;
	b=2RvCCxvGtWoa0jDyHSTW4qdd2pTQ4+4LPH6+SYR4NLq9cXBd4V15plp++quFTFM8C7lE
	 +vmt6fUk2wX3+64qCm/OHlO9IPt3JJlGXrqT5WZOZvnZHD+tU8sk8k/BuGVB5Somy8Wkn
	 wMoZfoSxV6MwXuPsmJoxW5+DFLkSggtWdL1ppNZj/rvLnUwTPegBXR1DJFiymkkHgq7MV
	 XFA4RSZPWecBQ70kcz2xWdH3/Ass59ZXmjh+1LgwiHIITJT5Q2Fq0bfE0LCY3+olnKIMj
	 oLzRvSFMGc/bTStRgdvmk9nWE+rsEhUwUDBD/IdgbXnAd1EBwCvbuPiRwsB1roSAFRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cO6fVNeT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2874A606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cO6fVNeT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D1D1F01825;
	Sun, 25 Oct 2026 11:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792928453;
	bh=1r2HAJnurvTfhiE6pv1KD8iHRlUXOHrLlO2pQEz5JBA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cO6fVNeTHcuiluDt/9p1WBskyf54hlW49jS5DrOjE8V0cYEeIvkc+OOdHLUuva7ps
	 vmXGhnVTa2n5ohsVbYBuaSYEaaKHTVsLibmizAG2lnSQK8mmSlcT0J1uREuBU0Bj1F
	 kktJJU43JBePOUyOTnVzFsqYwNcD3a+oLuXaPppThQo9Xq58xzfwNg+G+ZQlli8hoU
	 p/jl+PRd3wC72CkvtEZRuf90pI8Zk/KA7wsdL4ySuFJBi3I0g55O/verh26TbgMArj
	 tXqnE2uws4/pFiUlLrGSrdY6AT8NwQA5NitzEI34ND+lvRaa8n4V1uca79mAZ+xaK9
	 LI8eP7fmBgZcg==
Subject:
 Re: [PATCH net v4] net: airoha: keep PPE offload when NPU refuses flow stats
From: netdev-bot+sashiko@kernel.org
To: sayantann11@gmail.com
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, andrew@lunn.ch, chad@monroe.io,
 kuba@kernel.org
Date: Sun, 25 Oct 2026 11:40:52 +0000
Message-ID: <179292845293.3134.9835474484741547461@kernel.org>
In-Reply-To: <20261021100423.9159-1-sayantann11@gmail.com>
References: <20261021100423.9159-1-sayantann11@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In airoha_npu_ppe_stats_setup()
  (drivers/net/ethernet/airoha/airoha_npu.c), the new `npu->stats =…
- [Low] airoha_ppe_offload_setup() ignores every error from
  ppe_init_stats() and prints the same `dev_warn(eth->dev, "NPU refused…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but each
  successful airoha_npu_ppe_stats_setup() creates a new…

--

net: airoha: keep PPE offload when NPU refuses flow stats

With this patch, NPU flow statistics are optional. PPE offload setup now
continues when ppe_init_stats() fails, and a zero npu_stats_addr from the
firmware counts as a refusal. It also adds NULL checks on npu->stats,
clears npu->stats at the start of airoha_npu_ppe_stats_setup(), and clears
PSE_PORT6_SHARE_DIS when flow stats entries are configured.

> diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
> index 4d3195eb00f7a..42d48a4fab4ce 100644
> --- a/drivers/net/ethernet/airoha/airoha_npu.c
> +++ b/drivers/net/ethernet/airoha/airoha_npu.c
> @@ -441,6 +441,8 @@ static int airoha_npu_ppe_stats_setup(struct airoha_npu *npu,
>  	if (!ppe_data)
>  		return -ENOMEM;
>  
> +	npu->stats = NULL;
> +

[Severity: Medium]
Should this clear come before the kzalloc_obj() check?

If the GFP_ATOMIC allocation of ppe_data fails, the function returns
-ENOMEM before npu->stats is reset. Any mapping from an earlier bind is
left in place.

struct airoha_npu belongs to the NPU device, which stays bound when the
eth driver unbinds. airoha_ppe_deinit() does not reset npu->stats:

airoha_ppe_deinit() {
    ...
	if (npu) {
		synchronize_rcu();
		npu->ops.ppe_deinit(npu);
		airoha_npu_put(npu);
	}
    ...
}

Before this patch, any ppe_init_stats() error aborted
airoha_ppe_offload_setup(). Now it only warns and then calls
airoha_ppe_hw_init(), airoha_ppe_foe_flow_stats_reset() and
rcu_assign_pointer().

Suppose the eth driver is unbound and rebound, and this allocation then
fails. Would the stale pointer get past all the new !npu->stats checks?

If so, airoha_ppe_foe_flow_stats_reset() would memset_io() the old region.
airoha_ppe_foe_flow_stats_update() would rewrite ib2 to send bound flows
to PSE port 6. airoha_ppe_foe_entry_get_stats() would read the old
counters.

In this bind, PPE_FUNC_SET_WAIT_FLOW_STATS_SETUP would never have been sent
with ppe->foe_stats_dma. It's not clear what the firmware then does with
the port 6 traffic, or with the old foe_stats_addr from the previous bind.

The commit message says:

    Clear npu->stats at the start of airoha_npu_ppe_stats_setup() so that a
    stale mapping from a previous setup does not persist after a refusal on
    rebind.

This error path, which the patch makes non-fatal, still seems to leave the
stale mapping in place. Could the clear move above the allocation? Or
could airoha_ppe_offload_setup() clear npu->stats on any error?

> @@ -450,6 +452,14 @@ static int airoha_npu_ppe_stats_setup(struct airoha_npu *npu,
>  	if (err)
>  		goto out;
>  
> +	/* The firmware reports success with a zero address when its SRAM
> +	 * pool has no room left for the counters.
> +	 */
> +	if (!ppe_data->stats_info.npu_stats_addr) {
> +		err = -ENOSPC;
> +		goto out;
> +	}
> +
>  	npu->stats = devm_ioremap(npu->dev,
>  				  ppe_data->stats_info.npu_stats_addr,
>  				  size);

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. Does
each successful setup leak the previous devm_ioremap() mapping?

The mapping is attached to npu->dev, which outlives eth driver binds.
airoha_ppe_deinit() doesn't unmap npu->stats. The new npu->stats = NULL
only drops the pointer.

So each eth unbind/rebind that sets up stats again leaves the old mapping
on the NPU device's devres list. It stays there until the NPU device
itself unbinds.

The old code leaked in the same way when it overwrote the pointer, so
this patch doesn't add a new leak.

Should the old region be released with devm_iounmap(), either here or
during PPE teardown?

> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
> index 92611802801ea..3147655e8ecc4 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c

[ ... ]

> @@ -1454,10 +1463,9 @@ static int airoha_ppe_offload_setup(struct airoha_eth *eth)
>  
>  	ppe_num_stats_entries = airoha_ppe_get_total_num_stats_entries(ppe);
>  	if (ppe_num_stats_entries > 0) {
> -		err = npu->ops.ppe_init_stats(npu, ppe->foe_stats_dma,
> -					      ppe_num_stats_entries);
> -		if (err)
> -			goto error_npu_put;
> +		if (npu->ops.ppe_init_stats(npu, ppe->foe_stats_dma,
> +					    ppe_num_stats_entries))
> +			dev_warn(eth->dev, "NPU refused flow stats\n");

[Severity: Low]
Could this warning include the error code?

airoha_npu_ppe_stats_setup() can fail with any of these:

    -ENOMEM from kzalloc or devm_ioremap()
    an error from dma_mapping_error()
    -ETIMEDOUT from regmap_read_poll_timeout_atomic() in
    airoha_npu_send_msg()
    -EINVAL when the firmware status isn't NPU_MBOX_SUCCESS
    the new -ENOSPC

Only -EINVAL and -ENOSPC are actual firmware refusals. Allocation failures
and mailbox timeouts are also logged as "NPU refused flow stats", and the
errno is dropped. That makes it hard to tell missing firmware support
apart from an unresponsive NPU or memory pressure.

The commit message says continuing on any error is intended, so this is
only about the log message.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021100423.9159-1-sayantann11%40gmail.com
