Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319706;
	b=toJz1xX48lh4vGk8qJi4E563TpYjFHg9IdPMUOi59Fn0TusKuYLbI5vpkJHMfy1jFd/t
	 isIcyuyj5z+nd6mHkhcjCYglK7n+0tyxUqMtiwVQ8INY8hWXjDgImq4KOI0CKPX24bCG/
	 wMkIZy006BbyF4C0dptl/FaHpqBq2svtdlXaEjuPUBJcNgretLS5tFNnyU29D11yQ26/2
	 nrOw44bxn1xLLCD2mGRrx6rB4xK3B6UxsCdWLKM4OL67uTgGFnMISl1P1jOFc/HJjkILJ
	 96eCoq5YsqMtPZwUH/Bp1XrDET0BSu2gUNVJpYdc8wUjxoCX0fULsVkYJ/biiatgmLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319706;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=l/hkdUu0jQxuIceoGCSduUqWvBUZAuvUYb5qya3kN7k=;
	b=i5s7McIAIL1tYHnbwr9ZdCYTCaOic1AmZNHRWVzOWVaq6G6gcDca+9MEE3izjuM8JIt9
	 Ek6iVhOBufTRqF4gOVYKEzD+0h7yemzjgxIrhvpa52JRG2XDyucOcu5LLZddfl5KiuSiv
	 sQ4NljgBSTABrCI/zdarmpBFqw+CIrXaNOchw7XkytjKZOoemKVU4Xkoe3xxHDY7a7EBP
	 cdh44otF0kxAPFnKRIZhxBNDHElVsA+rXKYQTgHnAdOdcQ/6ddDbT1bdGxMV69LYWMkPm
	 F0Gvref5rNCyq36gax4A1MwDcGmocsb7VkjuL5QZ1SOiSd30F7tWAvEqBvSZQOZT3dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OwaB75pv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1244E606A33D;
	Tue, 10 Nov 2026 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OwaB75pv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFD71F0089F;
	Tue, 10 Nov 2026 14:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319705;
	bh=l/hkdUu0jQxuIceoGCSduUqWvBUZAuvUYb5qya3kN7k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OwaB75pvo2fyIIYLYndRGb2pt35bLOE7DV918RyYSl6MhjZi8PWUzkSGZ4tDPCqlq
	 oa4ynCGsFERMLV9WPUHHb402j1GMgKwVmN1cMBpqEuysWPKvX2lAp3nkNyc4ADO92k
	 wXciZq2+Su4xiUusryrP+Kzyfy31RLIL2YdUlmGVon3mag/tfpnziqJzFkVUA6VUEH
	 j/a7t44jxVyUdb0szjQFNObNaHl+lC7c1PPLU19D4tUI9vav650SIflqw/OyssK1Ch
	 XhsaPHcgQKzZwmUD++zOg0FtLiAn8US8KG+t+wrV3wp925Id96YDWLb9WFTBfibqYp
	 otfXBvwUkTXhQ==
Subject: Re: [PATCH net-next v01 3/4] Fixes: Ensure secure concurrent access
 to adaptive_rx_coal.
From: netdev-bot+sashiko@kernel.org
To: gongfan1@huawei.com
Cc: wudi234@huawei.com, tengpeisen@huawei.com, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, andrew+netdev@lunn.ch, ioana.ciornei@nxp.com,
 maxime.chevallier@bootlin.com, mohsin.bashr@gmail.com,
 dimitri.daskalakis1@gmail.com, hramamurthy@google.com,
 larysa.zaremba@intel.com, vadim.fedorenko@linux.dev,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 zhoushuai28@huawei.com, wulike1@huawei.com
Date: Tue, 10 Nov 2026 14:08:24 +0000
Message-ID: <179431970422.994134.5359832182077776184@kernel.org>
In-Reply-To: <8e91de49c919cb2cd105bcb33ff54e8e1c5754be.1793946318.git.gongfan1@huawei.com>
References: <8e91de49c919cb2cd105bcb33ff54e8e1c5754be.1793946318.git.gongfan1@huawei.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix does not close the race its commit message describes.
- [Medium] The commit message describes a bug that cannot happen in this
  tree, and the code change does not touch that behaviour.
- [Low] The commit subject and body are malformed.

--

Fixes: Ensure secure concurrent access to adaptive_rx_coal.

This patch wraps the write of nic_dev->adaptive_rx_coal in
init_intr_coal_param() in WRITE_ONCE(), and the read in hinic3_net_dim()
in READ_ONCE(). The commit message says this fixes a race where an
already-scheduled DIM work item overwrites static coalescing settings
after adaptive RX coalescing is disabled via ethtool.

> Fixes: Ensure secure concurrent access to adaptive_rx_coal.

[Severity: Low]
This isn't a bug, but the subject starts with "Fixes:". Tools and
maintainers read that as a trailer pointing at an earlier commit. The
subject also lacks the "net: hinic3:" prefix and ends with a period.

> As noted in the subsequent review.

The body points to a review the reader can't see. It then copies a
reviewer's question word for word, but never says what the patch changes
or why. There is also no real Fixes: <sha> ("...") trailer.

Would something like "net: hinic3: annotate adaptive_rx_coal accesses
with READ_ONCE/WRITE_ONCE" describe the change more accurately?

> When disabling adaptive RX coalescing via ethtool, does the driver
> cancel any pending Dynamic Interrupt Moderation (DIM) work items?

[Severity: Medium]
Can this sequence happen in the current driver? hinic3_ethtool_ops has no
.set_coalesce or .get_coalesce callback:

static const struct ethtool_ops hinic3_ethtool_ops = {
	.supported_coalesce_params      = ETHTOOL_COALESCE_USECS |
					  ETHTOOL_COALESCE_PKT_RATE_RX_USECS,
	.get_link_ksettings             = hinic3_get_link_ksettings,
	.get_drvinfo                    = hinic3_get_drvinfo,
	.get_msglevel                   = hinic3_get_msglevel,
	.set_msglevel                   = hinic3_set_msglevel,
	.get_link                       = ethtool_op_get_link,
};

The only writer of adaptive_rx_coal runs once at probe time, before
register_netdev():

hinic3_nic_probe()
  hinic3_sw_init()
    hinic3_alloc_txrxqs()
      hinic3_init_intr_coalesce()
        init_intr_coal_param()
          WRITE_ONCE(nic_dev->adaptive_rx_coal, 1);

The only reader is hinic3_net_dim(). The value never changes after probe,
so the READ_ONCE()/WRITE_ONCE() annotations don't change behaviour.
Nothing later in the series adds set_coalesce support either.

Could the commit message describe this as an annotation-only change,
rather than a fix for a user-visible coalescing bug? As written, it may
mislead maintainers and stable backporters.

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
> index e7d6c2033b451..b4e58d4c8ba85 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
> @@ -20,7 +20,7 @@ static void hinic3_net_dim(struct hinic3_nic_dev *nic_dev,
>  	struct dim_sample sample = {};
>  
>  	if (!test_bit(HINIC3_INTF_UP, &nic_dev->flags) ||
> -	    !nic_dev->adaptive_rx_coal)
> +	    !READ_ONCE(nic_dev->adaptive_rx_coal))
>  		return;
>  
>  	dim_update_sample(irq_cfg->total_events, rxq->rxq_stats.packets,

[Severity: High]
Does this close the race the commit message describes? Nothing cancels,
flushes or disables rxq->dim.work when the flag changes. The work handler
also never re-checks adaptive_rx_coal before it programs the hardware:

hinic3_rx_dim_work() {
	...
	cur_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);

	hinic3_update_queue_coal(rxq->netdev, rxq->q_id,
				 cur_moder.usec, cur_moder.pkts);
	...
}

That goes through
hinic3_update_queue_coal()->hinic3_set_interrupt_moder()->hinic3_set_interrupt_cfg().
It writes the DIM-derived coalesc_timer_cfg and pending_limit to the
hardware, then updates rxq->last_coalesc_timer_cfg and last_pending_limit.

The check here also happens separately from the schedule_work() inside
net_dim(), so this is a check-then-act sequence:

CPU0 (NAPI)                          CPU1 (disable path, if one existed)
hinic3_net_dim()
  READ_ONCE(adaptive_rx_coal) == 1
                                     clears adaptive_rx_coal
                                     programs static coalescing values
  net_dim()
    schedule_work(&dim->work)

hinic3_rx_dim_work()
  hinic3_update_queue_coal()   <- overwrites CPU1's static values

Work queued before the flag was cleared would still run as well.

READ_ONCE()/WRITE_ONCE() only stop the compiler from tearing or caching
the access. They don't order anything against the work item, and they
can't stop it from running.

Would the fix need one of these instead?

- The worker re-checks the flag under a lock (or with proper ordering)
  shared with the configuration path.
- The disable path clears the flag, quiesces NAPI, and cancels or
  disables each rxq->dim.work before it programs the static values.

Right now the only disable_work_sync() calls on dim.work are in the IRQ
teardown paths. Nothing later in the series adds this synchronization.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793946318.git.gongfan1%40huawei.com
