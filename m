Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF114DEC16;
	Mon, 19 Oct 2026 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792413601; cv=none; b=uw60S6OXjtfopYuwe7EZIXtyZhHzwWcUhB5+wabgFxXbHts37yEXw00QXb/6STY7G82ftBx0QQ8VN5VfxcMmiZJ2S/FY/4pUo6luJkUL424itr8dQHuIdcokuqC7bGskQbpa9lz6P5aunpOuSPGQ3gnd3R64hgLYlQgRqbd7Gko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792413601; c=relaxed/simple;
	bh=bZ9pF06liX4tKdE9Fse0dLwASnhtZWIDydorL1pJbDc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J0jPAtgDpi/nSs1HrLvIsLuk+mDilnZQz7baHl9UMvlW0XVZ03MwrgY18rAAbpsYQVWWoSf1nOSXlzxZL/cr0moSu2he1L6LviazOmQYjgtS3v7PComvJ1hg9ZRjEotjVpq9q8Pa087t6IcpWmUaDjYFI8dahlNYwhj55UyQNrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQspWQIA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQspWQIA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291811F000C4;
	Mon, 19 Oct 2026 12:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792413591;
	bh=OInJnL8OBndhCi8qsJ1iK0rfOnGd3etOMK+eOrTqThk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jQspWQIA3V0mH+S98nf9UxVgzloM0XfnHQOkXjJGcMr9yyPo38H9Lgar/RdTdzcCX
	 B2q7WOpGgZMLAWsMAlxom2ACfxHA52OgkpuwGzGaC3KsKYc5cE/5V227/l2pnoUHw2
	 PKvVpvChwk7r6Y2raZ8iEf4EpFK5HdoycdrgeQme7WlFocSQhEqktEBlPjYN+V+d+b
	 5YEPIeQqBEwPUEXBEgjLmRuqitBaz8T/TepRa0O5iXA+tOtZfdVmebP9ZGHL7iOE46
	 WBcORQIBu5IoPILoGOVmE2inDC3UC/K1lcr04m9WPWEqgYaD96Eks4/nI5t6fMwlpH
	 YE4AN3cLltZdw==
Subject:
 Re: [PATCH net v2 2/2] bnge: fix RSS table sizing for large RX ring counts
From: netdev-bot+sashiko@kernel.org
To: vikas.gupta@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
Date: Mon, 19 Oct 2026 12:39:49 +0000
Message-ID: <179241358967.3135.12651975554831459971@kernel.org>
In-Reply-To: <20261015121847.1933308-3-vikas.gupta@broadcom.com>
References: <20261015121847.1933308-3-vikas.gupta@broadcom.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch adds a new helper, bnge_calc_nr_ring_pages()
  (drivers/net/ethernet/broadcom/bnge/bnge_resc.h:90-102), that keeps…

--

bnge: fix RSS table sizing for large RX ring counts

This commit changes bnge_adjust_pow_two() so it always adds one block
before rounding up to a power of two. With that change the RSS indirection
table covers every RX ring. Ring page sizing moves to a new
bnge_calc_nr_ring_pages() helper, which keeps the original rounding.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h b/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
> index b62a634669f62..58462524939fe 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
> @@ -81,6 +81,17 @@ bnge_adjust_pow_two(u32 total_ent, u16 ent_per_blk)
>  {
>  	u32 blks = total_ent / ent_per_blk;
>  
> +	if (!blks)
> +		return 1;
> +
> +	return roundup_pow_of_two(blks + 1);
> +}
> +
> +static inline u32
> +bnge_calc_nr_ring_pages(u32 total_ent, u16 ent_per_blk)
> +{
> +	u32 blks = total_ent / ent_per_blk;
> +
>  	if (blks == 0 || blks == 1)
>  		return ++blks;
>  

[Severity: Medium]
Can this new helper size a ring smaller than total_ent?

The rest of bnge_calc_nr_ring_pages() is:

	if (!is_power_of_2(blks))
		blks = roundup_pow_of_two(blks);

	return blks;

If the floored quotient is already a power of two of 2 or more, blks is
returned unchanged and the partial last page is lost. The ring then has
blks * ent_per_blk slots, which is never more than total_ent.

The commit message says "bnxt_calc_nr_ring_pages() always adds one, which
is correct". This helper has the same name but keeps the rounding that the
message calls wrong.

In bnge_set_ring_params(), the completion ring budget includes
max_tpa_v2. bnge_hwrm_vnic_qcaps() takes that value from the firmware's
max_aggs_supported without any cap:

	max_rx_cmpl = bn->rx_ring_size;

	if (bn->priv_flags & BNGE_NET_EN_TPA)
		max_rx_cmpl += bd->max_tpa_v2;
	ring_size = max_rx_cmpl * 2 + agg_ring_size + bn->tx_ring_size;
	bn->cp_ring_size = ring_size;

	bn->cp_nr_pages = bnge_calc_nr_ring_pages(ring_size, CP_DESC_CNT);
	...
	bn->cp_bit = bn->cp_nr_pages * CP_DESC_CNT;
	bn->cp_ring_mask = bn->cp_bit - 1;

hwrm_ring_alloc_send_msg() then sets the CMPL and NQ ring lengths from
that mask:

	req->length = cpu_to_le32(bn->cp_ring_mask + 1);

Take 4K pages, rx/tx ring size 511, agg_factor 4 (TPA is on by default)
and CP_DESC_CNT 256. Then ring_size is 3577 + 2 * max_tpa_v2.

Any max_tpa_v2 from 260 to 387 gives a ring_size of 4097 to 4351. That
means blks = 16 and a 4096-entry completion ring, while bn->cp_ring_size
keeps the larger budget. The MAX_CP_PAGES clamp cannot catch this,
because the page count has already been rounded down.

With 64K pages (agg_factor 2, CP_DESC_CNT 4096), any max_tpa_v2 from 2819
to 4866 gives blks = 2. That is 8192 slots for up to 12287 budgeted
completions.

Could the completion ring overflow if the driver reaches that worst case?
I could not confirm whether shipping firmware reports max_aggs_supported
in those ranges.

The RX, RX agg and TX ring sizing use the same helper. They are only safe
today because the ring sizes are fixed at 511 and bnge has no
set_ringparam. A tx_ring_size between 512 and 767 would give
tx_ring_mask = 511, and bnge_tx_avail() would then report more free space
than the ring has.

The helper also breaks the rule encoded in BNGE_MAX_RX_DESC_CNT and
BNGE_MAX_TX_DESC_CNT, which keep the ring size below pages * DESC_CNT.

Should ring pages use the always-add-one rounding as well, the way
bnxt_calc_nr_ring_pages() does? If dropping the remainder is safe, could a
comment or the commit message explain why?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015121847.1933308-1-vikas.gupta%40broadcom.com
