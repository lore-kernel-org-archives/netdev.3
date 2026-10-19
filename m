Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430935;
	b=Llb2OvT6F6l8PvZEHi9r3nyXXqLlgEe3r5lDBsz5Zui/cNEbrZCuOX8vKibrkSJ48uS5
	 VdlvRvTxeNPzV3624x+wReScAybZ/t7x0CktPvHXF4aMBwetLI4ksfJyMMMhog27n752I
	 0VSTZqOqgLTrDyJ2dcuWClDvg4XEvzJZcqQpSsGPDHaPnGktJW4bVd46u71p4CVFVL7fa
	 iXEi41Ekqjrl13A9wUY4q1cMfVARtL7zDY9Pv+FF56l5QBFFNX26FmhFVAdFIAERulkYa
	 EdVv6yrirKNsVnO2szAv6rPlDossKNmlWyfVlDv9QT5EqVkKLkij2HItKsuYQn4k9ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430935;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=7Ao8kS4gryXgP23qAl5odrssCC/zglEvYzve79Xv7qY=;
	b=Op+bBHG7i2BWKg5+zp8LP8OXmYzLbjV6sUlTOWHDshF5+bKYCKyt7lfTw28NR2AO2Oyt
	 bQ+Wi7hCQFTTT0oLhwdU24ZeFj+1wQz8DpzPhCtq0DuX5VlNm7aU1M5xA5hCj0qQiCFkR
	 m6ZRMGVuCoTjVsXm1vUkM5x0gedbjPK4k4LIrO1OH1ys4rBht8gXGObQRtrsJnrSjmGMq
	 b6UclAdF9JfISYShkTQcGuBnOVN0gV5g8xiPnee4YCoMpDIUG3zq1L40IRy5iUQooqvMp
	 R9wmPO/yWTtCKUHVqGmJGzJQh8CoikoL9GRklQDZ62JKw55yBzXhwKvDsQt/Hzk5sjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n8nuODjo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1886760A262B
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n8nuODjo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B6A1F000C4;
	Mon, 19 Oct 2026 17:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792430934;
	bh=7Ao8kS4gryXgP23qAl5odrssCC/zglEvYzve79Xv7qY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=n8nuODjobfJ0DI9CwFvyPfqYUsYdkct6Ynh7URuQG4nEuz9t52kNKPUYRoltcbJZx
	 EGSO1U1/fAJmklTZ6YpgCxzobMQ3mdh6y05izhOVe7W42tOhFnnduK/ifgu5YjA43l
	 BgFxMjoqqq9A9j6OU/3nf1TMejVYF4esiwczJdfiwbx75W4ib9y5N99imeagvEaGRX
	 OZG+mKV2LKaZmJZ6xOiqb08xX6jCqUl78w+KGcTmcy+ewuspjPHlxYv1bFIKvV+XSv
	 GblDPVoKE+97ursrFh73x45tKT7YKGBfyyiTdxBrerglBV0anPoEaKrzscMTmERxPC
	 LJpw4aN3U0StA==
Subject: Re: [PATCH net-next v5 14/14] net: ethernet: cortina: Scope RX
 statistics updates
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Mon, 19 Oct 2026 17:28:53 +0000
Message-ID: <179243093360.3135.17690101000649286927@kernel.org>
In-Reply-To: <20261015-gemini-ethernet-fixes-3-v5-14-b5c9e2f7b8a3@kernel.org>
References: <20261015-gemini-ethernet-fixes-3-v5-14-b5c9e2f7b8a3@kernel.org>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch fixes a real bug but its commit message has no Fixes:
  trailer.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  rx_stats_syncp (and tx_stats_syncp and ir_stats_syncp) in struct…

--

net: ethernet: cortina: Scope RX statistics updates

This commit narrows the rx_stats_syncp writer sections in the Gemini
ethernet driver so they cover only the counter updates. Before, the
section in gmac_napi_poll() wrapped all of gmac_rx(). On 32-bit
PREEMPT_RT, u64_stats_update_begin() disables preemption, so the old
scope took spinlock_t locks with preemption disabled.

> On 32-bit PREEMPT_RT systems u64_stats_update_begin() disables
> preemption. The RX poll currently holds that writer section across
> gmac_rx(), which takes spinlock_t locks and calls into GRO and fragment
> handling. spinlock_t can sleep on PREEMPT_RT and must not be acquired
> with preemption disabled.

[ ... ]

> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>

[Severity: Low]
Should this have a Fixes: tag?

The writer section in gmac_napi_poll() that spans gmac_rx() and
geth_fill_freeq() looks like it has been there since the driver was
added:

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")

Other patches in this series carry that tag, for example "net: ethernet:
cortina: Keep shared free queue parent-owned", "net: ethernet: cortina:
Drain free queue IRQ before resize" and "net: ethernet: cortina: Preserve
in-flight free queue pages".

arch/arm/Kconfig selects ARCH_SUPPORTS_RT. Without the tag, this fix may
not reach stable ARM PREEMPT_RT kernels.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 0c6c7c938b2eb..7ecc8db9b7d3d 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -1720,12 +1720,12 @@ static struct sk_buff *gmac_skb_if_good_frame(struct gemini_ethernet_port *port,
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
initialized with u64_stats_init()?

I couldn't find any u64_stats_init() calls in
drivers/net/ethernet/cortina/ for rx_stats_syncp, tx_stats_syncp or
ir_stats_syncp.

The port lives in the netdev private area allocated in
gemini_ethernet_port_probe():

	netdev = devm_alloc_etherdev_mqs(dev, sizeof(*port), TX_QUEUE_NUM, TX_QUEUE_NUM);

On 32-bit kernels with CONFIG_DEBUG_LOCK_ALLOC, the seqcount's dep_map
therefore has no key. The first writer goes through:

gmac_skb_if_good_frame()
  u64_stats_update_begin()
    write_seqcount_begin()
      do_write_seqcount_begin_nested()
        seqcount_acquire(&s->dep_map, ...)
          ...
            assign_lock_key()

The object is neither static nor per-CPU. Will assign_lock_key() then
print "INFO: trying to register non-static key" and call
debug_locks_off(), which turns off lockdep for the whole system?

Non-debug builds are not affected, because the zeroed sequence starts at
a valid 0.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-gemini-ethernet-fixes-3-v5-0-b5c9e2f7b8a3%40kernel.org
