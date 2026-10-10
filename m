Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CE030E828
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 05:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791610419; cv=none; b=RMVQRQdSqNXlDfsEQPZbOOYjc2xQljo6wCYHSCxngoyqfUMDiWNcpC/WSrNFu3R6Lflq4glyy+Q7PSdeM9YsTsjgo5q9z5u5PJ4DFQtNZ3nCULEtMhjQGpuRtlvUN0UXTVM4H3ZHVWBiwGHAOcC4+gZgqElzW7rwikbZeXVFWbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791610419; c=relaxed/simple;
	bh=Ec4o9U5vPmpz32v3HSVC3bHJ2cDXpI9Z/H11WwhplvE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lDpvJh7EfMHzKm6F2xN60pU9UiYeg6g7sanzbC/63z1jut8G7y06fnQmuh0prm3g+KTx4CGPd1Hg9zahnUCj8NoOSi/MoFV7g3x8z8J2AQXUlo7DujJ17vDkRuJX/aajZpEtDD2uWQqSYCEILLz70/B2dlHgUWAzYJevgwndRSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yvi1VX5f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yvi1VX5f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED5A1F000FF;
	Sat, 10 Oct 2026 05:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791610418;
	bh=ezlF0Xgn0ovcnr5QHVCWVve1aSdkeHaJOGXX2JmGseI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Yvi1VX5ffzPlh632ONR69e+gnig6iOes0XEXawTf2MYpJb2vwGRbjn2Umq+CAyyQq
	 +gbfreljITXYvyPA0E6NAcKjEIypLZ7VUJhciMYCYmzTb+10etufXTkBwy6jQG3mAP
	 yhYaSEZjz6KJMzrOyREueO3iWc3RyAG6GsDYsq/5NtNOMu20TtVFZkHoYOT/vhUqIQ
	 kHfJdvxAoXd2YNhHZji90Y1AlwpceLGtJo7Et++N5ZByhuX7j5ixd+Vq2AxNfhyxiP
	 9AJ3YwqbICN9yIT+AqLU3EMSc7h1zKIvLFcGt791XRkCdojtt1Yv/lpBIOv7Snnsfr
	 vyqldFYNMhP3A==
Subject:
 Re: [PATCH net v2] net: airoha: keep PPE offload when NPU refuses flow stats
From: netdev-bot+sashiko@kernel.org
To: sayantann11@gmail.com
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, andrew+netdev@lunn.ch,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 bread.hsu@airoha.com, sayantan.nandy@airoha.com, kuba@kernel.org
Date: Sat, 10 Oct 2026 05:33:37 +0000
Message-ID: <179161041702.434549.16966823821916973097@kernel.org>
In-Reply-To: <20261009050322.39060-1-sayantann11@gmail.com>
References: <20261009050322.39060-1-sayantann11@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch makes flow_stats_cap a plain bool that can change
  at runtime.
- [Low] In airoha_regs.h, the new PSE_FC_CFG (0x0098) and
  PSE_PORT6_SHARE_DIS defines are placed between PSE_FQ_CFG (0x008c) and…

--

net: airoha: keep PPE offload when NPU refuses flow stats

This patch makes NPU flow statistics an optional capability, tracked in
ppe->flow_stats_cap, so PPE offload keeps going when ppe_init_stats()
fails. It also treats a zero npu_stats_addr from the firmware as a
refusal. When flow stats are available, it clears PSE_PORT6_SHARE_DIS.

> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
> index 92611802801ea..0957f331478a6 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c

[ ... ]

> @@ -1456,8 +1456,11 @@ static int airoha_ppe_offload_setup(struct airoha_eth *eth)
>  	if (ppe_num_stats_entries > 0) {
>  		err = npu->ops.ppe_init_stats(npu, ppe->foe_stats_dma,
>  					      ppe_num_stats_entries);
> -		if (err)
> -			goto error_npu_put;
> +		if (err) {
> +			dev_warn(eth->dev, "NPU refused flow stats (%d)\n",
> +				 err);
> +			ppe->flow_stats_cap = false;
> +		}
>  	}
>  
>  	airoha_ppe_hw_init(ppe);

[Severity: Medium]
If ppe_init_stats() fails here, for example through the new -ENOSPC path
in airoha_npu_ppe_stats_setup(), npu->stats is never ioremapped and stays
NULL. This path then clears flow_stats_cap and continues on to:

	airoha_ppe_hw_init(ppe);
	airoha_ppe_foe_flow_stats_reset(ppe, npu);

	rcu_assign_pointer(eth->npu, npu);

That publishes eth->npu while npu->stats is still NULL. Before this patch
that could not happen, because any failure jumped to error_npu_put.

Can this race with the debugfs reader? airoha_ppe_debugfs_foe_show()
calls airoha_ppe_foe_entry_get_stats() without taking flow_offload_mutex.
The entries and bind files are created in airoha_ppe_init(), before
offload setup runs.

airoha_ppe_foe_entry_get_stats() reads the plain flow_stats_cap before it
takes rcu_read_lock():

drivers/net/ethernet/airoha/airoha_ppe.c:airoha_ppe_foe_entry_get_stats() {
	ppe_num_stats_entries = airoha_ppe_get_total_num_stats_entries(ppe);
	if (ppe_num_stats_entries < 0)
		return;
	...
	rcu_read_lock();

	npu = rcu_dereference(eth->npu);
	if (npu) {
		...
		memcpy_fromio(&npu_stats, &npu->stats[index],
			      sizeof(*npu->stats));
	...
}

Here is one interleaving:

1. The reader sees flow_stats_cap == true while setup is still waiting in
   the stats mailbox.
2. The reader is preempted.
3. Setup clears the flag and publishes eth->npu.

Would the reader then resume, see a non-NULL npu, and call
memcpy_fromio() through a NULL-based iomem pointer?

Would it be safer to check npu->stats after rcu_dereference(eth->npu)?
Another option is to settle the capability before any reader can see it.

[ ... ]

> diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
> index 442b48c9b991e..aee06c0585867 100644
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
field mask PSE_FQ_LIMIT_MASK. As a result, PSE_FQ_LIMIT_MASK now reads as
a field of PSE_FC_CFG. Its only user is
airoha_fe_set_pse_queue_rsv_pages():

	fq_limit = airoha_fe_get(eth, PSE_FQ_CFG, PSE_FQ_LIMIT_MASK);

The 0x0098 offset also now comes before REG_FE_PSE_BUF_SET (0x0090) and
REG_PSE_SHARE_USED_THD (0x0094).

Could these defines go after REG_PSE_SHARE_USED_THD and its masks, so the
offsets stay in ascending order?

>  
>  #define REG_FE_PSE_BUF_SET		0x0090

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009050322.39060-1-sayantann11%40gmail.com
