Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAB83E40F6
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 05:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792386871; cv=none; b=NHtd/PkKb+O2S8F/t53j5qBPBPVquG5ofIvYaljbpP34kSeF6pIb6TJL/X16atx4smFODq8Fc42sA55bqU0NXTVRs3HWS/UK9UgBiWhhoLWjQClTEKgigKCjXaYdh4LJCA8R2a16InosKL9R3KuckEr5OhNQkdN1+JFB7/q9L6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792386871; c=relaxed/simple;
	bh=RlN0rdvklTrRrGJFtAJYxmhoQ+K4VrHnMGFw8JWdJ+g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HZvpj98MUpwNiUMVfQIfrVusXS0D0/Xw7kdgC25i2fbPll3Rj9vU7WfmLmxkH8eIqs+607f229wvQF+UrZQkGbCtFuFva0ULZDG3v9OYNkYBmQyRyWVJNbyIAalTUTZu8oqAp2bnb8gURlnwe+dfZzJ0hHxJYm0CEWxQW4mIF/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9hm8PWQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9hm8PWQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D320C1F000C4;
	Mon, 19 Oct 2026 05:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792386866;
	bh=rGFlZ3wFjyLWmqmWq3EpaAOzjfTIXZ4s1lG3xf9hi5Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h9hm8PWQkjq6xE/2C+PxHugc39sGc380qs8T/fYEpAWbLEEUgk+IhMSfwTA/vT5Ar
	 p6XHOqYH6Cx/uqn5R2flIo+s8/BKlWglvfq8DX8StZLS6BhLyZv8xOR+GtvByUaThh
	 Lna+6AlxRY8JdYG7xdPekdcxeiulHdR4DEJiE7FNHtMARwht3wfZ5hg3ItSFQi0lqo
	 YLph8yWVEpqfSLIopxrW2nC2T0VvfZ6IKo3HNIyb/0CZvVcGZhGvGI+lcxLrQ6ySxH
	 DA42RJJRdlub2XiHkWaN5IByZ7YY7IKVVPEG+ic/9eQndiEUmXraq48Baed3EuQgvS
	 HYN273PmQIn2g==
Subject:
 Re: [PATCH net v3] net: airoha: keep PPE offload when NPU refuses flow stats
From: netdev-bot+sashiko@kernel.org
To: sayantann11@gmail.com
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, andrew+netdev@lunn.ch,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 bread.hsu@airoha.com, sayantan.nandy@airoha.com, kuba@kernel.org
Date: Mon, 19 Oct 2026 05:14:25 +0000
Message-ID: <179238686535.3135.14881213345445359478@kernel.org>
In-Reply-To: <20261015045607.12999-1-sayantann11@gmail.com>
References: <20261015045607.12999-1-sayantann11@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Kernel oops (NULL iomem dereference) on the exact refusal path
  this patch claims to handle.
- [Medium] Even apart from the NULL dereference, the 'continue without
  stats' fallback still programs the PPE as if NPU-assisted flow…
- [Medium] The failure paths in airoha_npu_ppe_stats_setup(), including
  the new zero-address -ENOSPC exit, return without resetting…
- [Low] The new PSE_FC_CFG (0x0098) and PSE_PORT6_SHARE_DIS defines sit
  between PSE_FQ_CFG (0x008c) and PSE_FQ_LIMIT_MASK…

--

net: airoha: keep PPE offload when NPU refuses flow stats

With this patch, airoha_ppe_offload_setup() logs a warning and keeps going
when the NPU refuses the flow statistics request, where it used to abort.
It also treats a zero npu_stats_addr from the firmware as a refusal. When
flow stats entries are available, it clears PSE_PORT6_SHARE_DIS in
PSE_FC_CFG.

> diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
> index 4d3195eb00f7..b32a01dbe06b 100644
> --- a/drivers/net/ethernet/airoha/airoha_npu.c
> +++ b/drivers/net/ethernet/airoha/airoha_npu.c
> @@ -450,6 +450,14 @@ static int airoha_npu_ppe_stats_setup(struct airoha_npu *npu,
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

[Severity: Medium]
Can this leave an old npu->stats mapping in use?

This exit returns without touching npu->stats, and so do the other failure
exits in airoha_npu_ppe_stats_setup(). struct airoha_npu is the NPU
platform device's drvdata, and npu->stats is a devm mapping owned by
npu->dev. Both outlive any airoha_eth instance.

airoha_ppe_deinit() does not clear npu->stats either:

airoha_ppe_deinit() {
	...
	if (npu) {
		synchronize_rcu();
		npu->ops.ppe_deinit(npu);
		airoha_npu_put(npu);
	}
	...
}

Suppose an earlier airoha_eth instance mapped the stats region. Then a
later airoha_ppe_offload_setup(), for example after an eth unbind/rebind
or a module reload, gets a refusal or a zero npu_stats_addr. In that case
npu->stats still points at the old region.

The caller now continues past the failure. So
airoha_ppe_foe_flow_stats_reset(), airoha_ppe_foe_flow_stats_update() and
airoha_ppe_foe_entry_get_stats() would read and write that region as live
counters, even though the firmware may have reassigned it after
ppe_deinit().

Separately, each successful setup adds a new devm_ioremap() that is only
released when the NPU device unbinds. That part predates this patch.

> +
>  	npu->stats = devm_ioremap(npu->dev,
>  				  ppe_data->stats_info.npu_stats_addr,
>  				  size);
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
> index 92611802801e..74ac3791cb63 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -144,6 +144,9 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
>  	sram_ppe_num_data_entries =
>  		PPE_RAM_NUM_ENTRIES_SHIFT(sram_ppe_num_data_entries);
>  
> +	if (sram_num_stats_entries > 0)
> +		airoha_fe_clear(eth, PSE_FC_CFG, PSE_PORT6_SHARE_DIS);
> +

[Severity: Medium]
When the NPU refuses flow stats, sram_num_stats_entries still comes from
the static airoha_ppe_get_num_stats_entries() check. Is the PPE then still
programmed as if NPU flow counting were active?

In that case airoha_ppe_hw_init() still takes PPE_STATS_NUM_ENTRIES out
of the SRAM data table and still clears PSE_PORT6_SHARE_DIS.

After that, airoha_ppe_foe_commit_entry() calls
airoha_ppe_foe_flow_stats_update() for every non-WLAN bound flow. That
function checks only the static count, then redirects the entry to the
NPU:

airoha_ppe_foe_flow_stats_update() {
	...
	nbq = pse_port == 1 ? 6 : 5;
	*ib2 &= ~(AIROHA_FOE_IB2_NBQ | AIROHA_FOE_IB2_PSE_PORT |
		  AIROHA_FOE_IB2_PSE_QOS);
	*ib2 |= FIELD_PREP(AIROHA_FOE_IB2_PSE_PORT, 6) |
		FIELD_PREP(AIROHA_FOE_IB2_NBQ, nbq);
}

The original CHANNEL/QID and NBQ/PSE_PORT/PSE_QOS/FAST_PATH values are
saved in ACTDP and TUNNEL_MTU, so the firmware can count the packet and
forward it on. The firmware has just refused the flow stats service. If
it does not do this for port 6 traffic, could offloaded flows be dropped
or misrouted?

That would contradict the commit message, which says PPE "continues to
operate without NPU flow counters while retaining normal offload
functionality". Even if the firmware does forward correctly, a refusal
still costs PPE_STATS_NUM_ENTRIES SRAM data entries per PPE.

Right now the NULL dereference in airoha_ppe_offload_setup() (below)
hides this. A fix for that crash would need to handle this as well.

>  	for (i = 0; i < eth->soc->num_ppe; i++) {
>  		airoha_fe_wr(eth, REG_PPE_TB_BASE(i),
>  			     ppe->foe_dma + sram_tb_size);
> @@ -1454,10 +1457,9 @@ static int airoha_ppe_offload_setup(struct airoha_eth *eth)
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
>  	}
>  
>  	airoha_ppe_hw_init(ppe);

[Severity: High]
Does this path oops in the very refusal case the patch is meant to handle?

npu is allocated with devm_kzalloc() in airoha_npu_probe().
airoha_npu_ppe_stats_setup() sets npu->stats only after devm_ioremap()
succeeds. On every failure exit npu->stats stays NULL: an
airoha_npu_send_msg() error, the new zero address -ENOSPC exit, or an
ioremap failure.

Right after airoha_ppe_hw_init(), airoha_ppe_offload_setup() calls
airoha_ppe_foe_flow_stats_reset(). Its only gate is the static
CONFIG_NET_AIROHA_FLOW_STATS/SoC entry count:

airoha_ppe_offload_setup()
  airoha_ppe_foe_flow_stats_reset()
    airoha_ppe_foe_flow_stat_entry_reset()
      memset_io(&npu->stats[index], 0, sizeof(*npu->stats));

That writes through a NULL npu->stats, starting at index 0.

Even if that call were skipped, rcu_assign_pointer() still publishes
eth->npu, and two more paths use npu->stats without checking it.

The first runs whenever a forwarded flow binds:

airoha_ppe_foe_commit_entry()
  airoha_ppe_foe_flow_stats_update()
    airoha_ppe_foe_flow_stat_entry_reset()

The second is airoha_ppe_foe_entry_get_stats(), reached from
FLOW_CLS_STATS and the debugfs FOE dump. It checks only npu:

	npu = rcu_dereference(eth->npu);
	if (npu) {
		...
		memcpy_fromio(&npu_stats, &npu->stats[index],
			      sizeof(*npu->stats));

Before this patch, a failure took goto error_npu_put and offload setup
failed cleanly. Rather than just ignoring the error, could the driver
record whether the NPU accepted the stats setup and check that before
every use of npu->stats?

> diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
> index 442b48c9b991..aee06c058586 100644
> --- a/drivers/net/ethernet/airoha/airoha_regs.h
> +++ b/drivers/net/ethernet/airoha/airoha_regs.h
> @@ -72,6 +72,8 @@
>  #define PSE_CFG_OQ_RSV_MASK		GENMASK(13, 0)
>  
>  #define PSE_FQ_CFG			0x008c
> +#define PSE_FC_CFG			0x0098
> +#define PSE_PORT6_SHARE_DIS		BIT(22)
>  #define PSE_FQ_LIMIT_MASK		GENMASK(14, 0)

[Severity: Low]
This isn't a bug, but the new defines sit between PSE_FQ_CFG and its
field mask, so PSE_FQ_LIMIT_MASK now reads as a field of PSE_FC_CFG. The
only user of the mask, in airoha_eth.c, pairs it with PSE_FQ_CFG:

	fq_limit = airoha_fe_get(eth, PSE_FQ_CFG, PSE_FQ_LIMIT_MASK);

The new block also breaks address order: 0x0098 now comes before
REG_FE_PSE_BUF_SET (0x0090) and REG_PSE_SHARE_USED_THD (0x0094). Could
PSE_FC_CFG and PSE_PORT6_SHARE_DIS go after the REG_PSE_SHARE_USED_THD
block?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015045607.12999-1-sayantann11%40gmail.com
