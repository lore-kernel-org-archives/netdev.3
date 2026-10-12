Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B9936C9D9
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 18:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830744; cv=none; b=LXD7MA18426TdmThfzuK0BLrj30KngwAoDtTNZ3e3VcJNRYKxkRo2+qG9C8kRnuJRVJ5qFH0YtWGz77u0yAr2VWtXGLWRfCQmDtOkGj2VHMflffozh0OAxAPnrcwQdFl4SZAFyRfadCR0ELbGSICWoaaDDhWY22ZhI2Vtmh19PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830744; c=relaxed/simple;
	bh=F3eggRCCeZtxYWc1Qz3GJAb998vU6TD21ZHTXLCH/tc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qeH+RWKTOZzBR3p+dRZLSbLplmK8ZCliasNd2IHst54PWZd4KnDzHT4P7i7JuenIk6g4GyTG+Btu1gt3pDCLKWtknbK3TzRnXBgqsyQr/7raFffjDwRsWJ27eO2UstopAnoMwFJzvMHZ9JrmTCF/vBQbCsp/cavycwksggW8vB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+hoE6qv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+hoE6qv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771FA1F0089B;
	Mon, 12 Oct 2026 18:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830741;
	bh=v+vzzdfmTOWfMqWad9AYLDyQwJtgXFnIlxDxAsRXJ04=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=C+hoE6qv82F4T9fh0p68P+mDQJuh28Yle0E0L+Xq9OWJ5EkTdnNNfK4S0o6oDONg+
	 PMtsPfRKid3N2fyNQVJlErbA+drHvVjqhCa/T2rEdvNHbVLqQaNcs7Q3GEM+w5RF2M
	 KKGensLavxhZWFTE/gWmrIb2pX5gJZQymSD4tbIezKuoyaEGBcTd19fUO8RWEw0smu
	 CF2w+3r4Wxkf+75a0gjjv0L5MNbj+uUn74OSXirkLGbusI+7bCtVu/iJnqvtLy0CRT
	 OZ+Jc6/ceI+Z588ieipgFDfCMY3k+ZdHNoRdit4v4iWHpO/kxjvQV1gYpsTPgKWB65
	 EuZuVohItfAdw==
Subject: Re: [PATCH net-next v4 15/15] net: ethernet: cortina: Scope RX
 statistics updates
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Mon, 12 Oct 2026 18:45:40 +0000
Message-ID: <179183074006.434549.8890024295857427052@kernel.org>
In-Reply-To: <20261011-gemini-ethernet-fixes-3-v4-15-4b1631b08f5d@kernel.org>
References: <20261011-gemini-ethernet-fixes-3-v4-15-4b1631b08f5d@kernel.org>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This commit fixes a real runtime bug but has no Fixes: trailer
  and no statement of how the bug was found, how it was confirmed, or…
- [Low] The commit message starts with "On 32-bit systems
  u64_stats_update_begin() disables preemption." That is wrong for…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but none of
  port->rx_stats_syncp, tx_stats_syncp or ir_stats_syncp is ever…

--

net: ethernet: cortina: Scope RX statistics updates

This commit narrows the rx_stats_syncp writer sections in the Gemini RX
path so they cover only the counter updates. Before this, one writer
section in gmac_napi_poll() spanned all of gmac_rx(). The stated reason is
that on 32-bit PREEMPT_RT the writer section disables preemption while
gmac_rx() takes spinlock_t locks and calls into GRO.

> On 32-bit systems u64_stats_update_begin() disables preemption. The RX
> poll currently holds that writer section across gmac_rx(), which takes
> spinlock_t locks and calls into GRO and fragment handling. On PREEMPT_RT,
> spinlock_t can sleep and must not be acquired with preemption disabled.

[Severity: Low]
Is the first sentence accurate for non-RT kernels? On 32-bit,
__u64_stats_update_begin() calls preempt_disable_nested(). That helper
only disables preemption when PREEMPT_RT is enabled:

include/linux/preempt.h:preempt_disable_nested() {
	if (IS_ENABLED(CONFIG_PREEMPT_RT))
		preempt_disable();
	else
		lockdep_assert_preemption_disabled();
}

So the affected configuration looks like 32-bit with PREEMPT_RT only.
Could the opening sentence say that?

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index a61bace61ea4b..9f7946876d585 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -1712,12 +1712,12 @@ static struct sk_buff *gmac_skb_if_good_frame(struct gemini_ethernet_port *port,
>  	unsigned int rx_status = word0.bits.status;
>  	struct sk_buff *skb = NULL;
>  
> -	port->rx_stats[rx_status]++;
> -	port->rx_csum_stats[rx_csum]++;
> -
>  	if (word0.bits.derr || word0.bits.perr ||
>  	    rx_status || frame_len < ETH_ZLEN ||
>  	    rx_csum >= RX_CHKSUM_IP_ERR_UNKNOWN) {
> +		u64_stats_update_begin(&port->rx_stats_syncp);

[Severity: Medium]
This isn't a bug introduced by this patch, but is rx_stats_syncp ever
initialized?

Nothing in drivers/net/ethernet/cortina/ calls u64_stats_init() for
rx_stats_syncp, tx_stats_syncp or ir_stats_syncp. The port struct is
zeroed memory from devm_alloc_etherdev_mqs(). gemini_ethernet_port_probe()
initializes the config lock:

	spin_lock_init(&port->config_lock);

but none of the three syncp fields.

On 32-bit kernels with CONFIG_DEBUG_LOCK_ALLOC, the seqcount's lockdep_map
has no key. The first writer would therefore go through:

gmac_skb_if_good_frame()
  u64_stats_update_begin()
    __u64_stats_update_begin()
      write_seqcount_begin()
        seqcount_acquire()
          assign_lock_key()

This prints "INFO: trying to register non-static key." and turns lockdep
off for the rest of the boot.

Would it make sense to add u64_stats_init() calls for the three syncp
fields in gemini_ethernet_port_probe(), perhaps as a separate patch?

> +		port->rx_stats[rx_status]++;
> +		port->rx_csum_stats[rx_csum]++;
>  		port->stats.rx_errors++;

[ ... ]

> @@ -1915,13 +1924,13 @@ static int gmac_napi_poll(struct napi_struct *napi, int budget)
>  	bool reschedule;
>  
>  	freeq_threshold = 1 << (geth->freeq_order - 1);
> -	u64_stats_update_begin(&port->rx_stats_syncp);
>  
>  	received = gmac_rx(napi->dev, budget, &freeq_consumed, &reschedule);

[Severity: Medium]
The u64_stats_update_begin() removed here, placed before gmac_rx(), dates
back to the original driver commit. On 32-bit PREEMPT_RT the path is:

gmac_napi_poll()
  u64_stats_update_begin()
    __u64_stats_update_begin()
      preempt_disable_nested()    <- preempt_disable() on PREEMPT_RT
  gmac_rx()
    spin_lock_irqsave(&geth->irq_lock, flags)

gmac_rx() also takes the free queue lock in geth_freeq_claim() and calls
napi_gro_frags() while preemption is disabled.

This patch fixes that "sleeping function called from invalid context"
problem. Should it carry this tag?

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")

Documentation/process/maintainer-netdev.rst also asks bug fixes to say how
the issue was found and confirmed, and how the fix was tested. For
hardware drivers it asks for the hardware the fix was tested on. The
commit message has none of these.

Other patches in this series carry Fixes: 4d5ae32f5e1e, for example "Keep
shared free queue parent-owned" and "Drain free queue IRQ before resize".
Others include a testing statement, for example "Account RX buffer size in
truesize", which mentions testing on a D-Link DIR-685. Could this patch get
the same tag and testing statement?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d%40kernel.org
