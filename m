Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585C649E5FC
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791307157; cv=none; b=dVNnr9JriUodnJnrB0ALYedWLC5tFaa/qkfC2ASyBtbiUXCR5VGuzRMJiCWLNgZCYxRbvtLbN8JUx752QjSyfV7HfNXw4yi20FfXg6+hVLB9hOZwokq0iQCX5hvc+Sj3JF4HyEyA0QVpWu8IVjr1RJsICLh4jq4VM1jnF63XeRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791307157; c=relaxed/simple;
	bh=p+FP1NW3GusR5t8ei9gTcYIbjCYxqtrdcLa3DNzHbUY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jp7H32OBk0ojQwEuvvzsqgAkNEZAoqY42BSW9PfUrqQA3MxREsR6QgVpMt2ZCloirjeo/v2wRtvtbpWYM4aKuUNKkTY1k5LT3ABPlAg4P+VvQfoRjBDeyoj5FoLN/RwG3AnLJOQuETfivA5Y1y9eBC9kN5WL80bMwao0li5DVFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlqBD4rW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlqBD4rW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663691F0089E;
	Tue,  6 Oct 2026 17:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791307154;
	bh=yb5DmGp80Vdz2Z13Om1I3Tb857ycqJQiYIfM5a6StK4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MlqBD4rWPpyB1UFUF5+BZSPD2EYovgrIMSwChixTUAt35jUmfxwyN2rtpAoplNn5+
	 cFgAkW1fEF7UdayQq0/2cYEZTWYcevtu8erT5/NhA0QJ2ERdNBv1E0WhXqaKTsuo0H
	 AEaWdSYUdBX/RZ+ikCVdzvKkcDnvt/VH8ChhQWaAtRRmqRmrAnRtXHKXZM60Jrhlf1
	 Lycwy6mMBE+dFtgG/2c6r5P2NfGVAhW8H4lFoL9N3b42Okn4bSLZWmLLNqye0wwuCy
	 k9OyOytcm9Op+YOr5k6XlEhXQSH2vFBSrnIfsn5SMXw8qQKkK9YjfLkyRpVQqPhgUD
	 X7Qf+Jntsd2tA==
Subject: Re: [PATCH net-next v3 11/12] net: ethernet: cortina: Release partial
 RX frames on stop
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Tue, 06 Oct 2026 17:19:13 +0000
Message-ID: <179130715399.434549.3103296397733616991@kernel.org>
In-Reply-To: <20261002-gemini-ethernet-fixes-3-v3-11-3e1f25890ae8@kernel.org>
References: <20261002-gemini-ethernet-fixes-3-v3-11-3e1f25890ae8@kernel.org>
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

- [Medium] The u64_stats writer added to gmac_stop()
  (drivers/net/ethernet/cortina/gemini.c) runs in preemptible process…
- [Low] The commit message has no statement of how the bug was found, how
  it was confirmed, or how the fix was tested.

--

net: ethernet: cortina: Release partial RX frames on stop

This patch frees a partially assembled RX frag skb in gmac_stop() after
napi_disable(). The pages already attached to port->rx_skb are then no
longer leaked when the interface goes down. The discarded frame is
counted in rx_dropped under rx_stats_syncp.

> net: ethernet: cortina: Release partial RX frames on stop
>
> A NAPI poll can retain a partially assembled frame across invocations. The
> stop path clears that pointer without releasing its fragment references,
> leaking every page already attached to the frame.

[ ... ]

> Fixes: 06937db21ee3 ("net: ethernet: cortina: Make RX SKB per-port")
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>

[Severity: Low]
This isn't a bug, but could the commit message say how the leak was found
and confirmed, and how the fix was tested?

The bug fixes section of Documentation/process/maintainer-netdev.rst
asks for this:

    All bug fixes must state how the issue was discovered and validated,
    and how the fix was tested.

For hardware drivers, it also asks for the hardware the fix was tested on.

For example, was an ifdown during a partly received multi-descriptor
(jumbo) frame reproduced on Gemini hardware?

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 6b333eb81f9c4..2ebfbbe84ebaf 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -2173,6 +2173,12 @@ static int gmac_stop(struct net_device *netdev)
>  	gmac_disable_tx_rx(netdev);
>  	gmac_stop_dma(port);
>  	napi_disable(&port->napi);
> +	if (port->rx_skb) {
> +		napi_free_frags(&port->napi);
> +		u64_stats_update_begin(&port->rx_stats_syncp);
> +		port->stats.rx_dropped++;
> +		u64_stats_update_end(&port->rx_stats_syncp);

[Severity: Medium]
Is it safe to call u64_stats_update_begin() here with preemption enabled?

gmac_stop() is the ndo_stop callback. It runs in process context and
holds only RTNL. Gemini is a 32-bit ARM SoC, so rx_stats_syncp contains a
real seqcount.

On !PREEMPT_RT, __u64_stats_update_begin() calls
preempt_disable_nested(), which only runs
lockdep_assert_preemption_disabled(). The write_seqcount_begin() that
follows on a plain seqcount_t also only asserts. Neither one disables
preemption.

With CONFIG_PROVE_LOCKING, would this hit the WARN_ON_ONCE() in
lockdep_assert_preemption_disabled() on every ifdown that finds a pending
partial frame?

On a preemptible kernel the writer could also be preempted while the
sequence count is odd. Could a reader on the same CPU then spin in the
retry loop in gmac_get_stats64() or gmac_get_ethtool_stats()?

gmac_get_stats64() {
    ...
	do {
		start = u64_stats_fetch_begin(&port->rx_stats_syncp);
		...
	} while (u64_stats_fetch_retry(&port->rx_stats_syncp, start));
    ...
}

Before this patch, the only writer to rx_stats_syncp was gmac_napi_poll()
in softirq context. The other process-context writer on this stop path,
gmac_update_hw_stats(), disables interrupts first:

gmac_update_hw_stats() {
    ...
	spin_lock_irqsave(&geth->irq_lock, flags);
	u64_stats_update_begin(&port->ir_stats_syncp);
    ...
}

Does this block need similar protection, for example
u64_stats_update_begin_irqsave() or a local_bh_disable() section?

gmac_stop() still contains the same block at the end of the series, in
"net: ethernet: cortina: Scale Gemini RX queues to system memory".

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-gemini-ethernet-fixes-3-v3-0-3e1f25890ae8%40kernel.org
