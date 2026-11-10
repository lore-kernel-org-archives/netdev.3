Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319704;
	b=NK5BcBOgxb4/wxdXdcgCiiFPsYaahk2zaCOe7ckKqCOz/vHhnq+nJI6w5XHZNpZ+Lep3
	 b7FH1p829gaYCmUdXNJp6Tdj8ryTE98VacFSeY7rA5cGUi5DHvZHVVokT2FPY40hCyA10
	 71Joue3tTdF174TgJXAHBoelvUgKOKvgAFX5f7S+RPStqeN81nQ6qeKUlIp8P+JAWDMuV
	 8ls8XgQPnbM5gBnOGRFhjFiyp8BVReYKUwqJK3qpZGeDd7B9Hmx4wKTZlD48XhAn8sNwQ
	 kusG71wmsfQNOsQ0o3cLWYYT38zHw6huJ/H7CnoLJnrSZbivn3q/qfU8l948Fj8N6Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319704;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=eQXUSO3tD6FtpjY8mUmkDBmF4Xb2KD8HDk5m4EfpuVE=;
	b=bI8UtWA3If6a5HM3dkoTBWG64eHSzKXeqJiU+Q3BILCjh20K0iObzIHY9ZaUqUdUxzOR
	 Wo5KMGWzKJEiCSVHBgblvku8MrvbDVXMDH0p7H36/uXicTLWeEqrLuJTaq2Jr9Q0teEC2
	 qAjId6UyreI2MxwBFCKFJXTL9O4p8Z7ai+mhegdgsIQw9QTzDLl/7gMBNbN+XUks06uNw
	 d40AMsnZ0fDpSPbu5U0rg0FKf3GPMZp8nKovLvRpjCHHuk/YodCK6cMabBo7U7Q+qL76J
	 jIfwimUghTpjlCLIunjl9DNVevRW/B4m8W7p4pXKuVarXdeSnVHGTCm4Bu1+ydWv40w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yb1xDJcs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B94606A325;
	Tue, 10 Nov 2026 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yb1xDJcs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059901F008A1;
	Tue, 10 Nov 2026 14:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319704;
	bh=eQXUSO3tD6FtpjY8mUmkDBmF4Xb2KD8HDk5m4EfpuVE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Yb1xDJcsK9Cl7ZQCpnEm0uHJBNRwtHA/gffqwy/wgBCZKzOKqErGfxVlNHUxrXK2/
	 aLySzy2YuJptpHv+RvTvBtyZbWZ8y++bRxgpLOie73W8iKCEgSTHzS0rB015dUEvYO
	 mHW56QZxr+1UeOJWS6gwkNPQA93nuEwut+o82MYgCK+xWHm1mk16cX7JmQJ5v+8NPU
	 0AIQjNYLXynzeluygPZK4jrArzar1JwNiT8vrmY+1LKx25C6nbeZ5sNN7OBzD1U5iJ
	 XRPbzvs0jbxnEV5h3nhbzkXBNVo5KE0BARotvkZNsucmK6mOzf+sa98qXDjIn1+eGI
	 oqjUQ7ZkXemSA==
Subject: Re: [PATCH net-next v01 2/4] Fixes: Avoid concurrent updates on
 32-bit systems.
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
Date: Tue, 10 Nov 2026 14:08:22 +0000
Message-ID: <179431970260.994134.17324633020016556437@kernel.org>
In-Reply-To: <bebc65bd3d1af9d6f3cb0c8dcf9421bd6a432c58.1793946318.git.gongfan1@huawei.com>
References: <bebc65bd3d1af9d6f3cb0c8dcf9421bd6a432c58.1793946318.git.gongfan1@huawei.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The subject and body of commit "Fixes: Avoid concurrent
  updates on 32-bit systems." do not match the change.
- [Medium] hinic3_get_stats64()
  (drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c) quietly…
- [Low] The patch fixes a double-counting bug that cannot happen at this
  tree state, or at the end of the series.
- [Low] hinic3: dead counter initializations in hinic3_get_stats64()

--

Fixes: Avoid concurrent updates on 32-bit systems.

This commit changes the u64_stats reader retry loops in
hinic3_get_stats64(). The per-queue values are now assigned inside the
loop and added into the rtnl_link_stats64 fields after it. It also drops
the nic_dev->txqs and nic_dev->rxqs NULL checks and stops adding
csum_errors into rx_errors.

> Fixes: Avoid concurrent updates on 32-bit systems.

[Severity: Medium]
Could the subject be reworked?

It has no subsystem prefix. Something like "net: hinic3:" would be
expected.

It also starts with "Fixes:", which is a trailer tag. That text isn't
followed by a commit reference, and the tags have no real
Fixes: <sha> ("...") trailer. Tools that grep for '^Fixes:' may also
match this subject.

The subject says the patch avoids concurrent updates, but none of the
writers are changed. The only change is on the reader side of
hinic3_get_stats64(), where '+=' becomes '=' inside the retry loop.

> As noted in the subsequent review.

The body starts with this line, then repeats a reviewer's comment about
the old code. It never says what this patch does. Could the changelog
describe the change itself?

The other patches in the series use the same layout. In "Fixes: Solve an
LRO stall issue" the body even keeps the reviewer's question "Was it
intended? ... could it go in a separate patch".

Were these review fixups meant to be folded into the patches they
address, rather than sent as standalone commits?

> If the loop retries due to concurrent updates on 32-bit systems,
> the counters are added multiple times. This was previously benign
> since the fields weren't populated by the driver, but these new
> updates will cause incorrect statistics on 32-bit platforms.

[Severity: Low]
Which new updates does this refer to?

In drivers/net/ethernet/huawei/hinic3/, the only writers of txq_stats
and rxq_stats are hinic3_txq_clean_stats() and hinic3_rxq_clean_stats().
Both only zero the counters:

hinic3_rx.c:hinic3_rxq_clean_stats() {
	u64_stats_update_begin(&rxq_stats->syncp);
	rxq_stats->bytes = 0;
	rxq_stats->packets = 0;
	...
}

The rx checksum error path in hinic3_rx_csum() doesn't count anything
either:

	if (unlikely(csum_err)) {
		/* pkt type is recognized by HW, and csum is wrong */
		skb->ip_summed = CHECKSUM_NONE;
		return;
	}

So a retry of the old '+=' loop would only add zeros. No per-packet
updates are added by this patch, by the baseline, or by any later patch
in the series.

Should this be squashed into the patch that starts populating the
counters, instead of being a standalone fix?

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> index da73811641a9d..474ea81f17508 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> @@ -795,45 +795,38 @@ static void hinic3_get_stats64(struct net_device *netdev,

[ ... ]

>  	for (i = 0; i < nic_dev->max_qps; i++) {
> -		if (!nic_dev->rxqs)
> -			break;
> -
>  		rxq = &nic_dev->rxqs[i];
>  		rxq_stats = &rxq->rxq_stats;
>  		do {
>  			start = u64_stats_fetch_begin(&rxq_stats->syncp);
> -			bytes += rxq_stats->bytes;
> -			packets += rxq_stats->packets;
> -			errors += rxq_stats->csum_errors +
> -				rxq_stats->other_errors;
> -			dropped += rxq_stats->dropped;
> +			bytes = rxq_stats->bytes;
> +			packets = rxq_stats->packets;
> +			errors = rxq_stats->other_errors;
> +			dropped = rxq_stats->dropped;

[Severity: Medium]
Is dropping csum_errors from rx_errors intended here? The old code did:

	errors += rxq_stats->csum_errors + rxq_stats->other_errors;

The new code reads only other_errors, so rtnl_link_stats64.rx_errors no
longer includes checksum errors. The retry fix didn't need this, and the
commit message doesn't mention it.

struct hinic3_rxq_stats still declares csum_errors, and
hinic3_rxq_clean_stats() still resets it under the syncp. After this
patch, nothing reads it.

The sibling hinic driver still reports errors = csum_errors +
other_errors in hinic_rxq_get_stats(), which is what hinic3 did before
this patch.

Once the rx path starts populating csum_errors, would checksum failures
drop out of rx_errors in 'ip -s link', with no other counter reporting
them? hinic3_get_stats64() is unchanged at the end of the series, so no
later patch restores it.

The same patch also removes the nic_dev->txqs and nic_dev->rxqs NULL
checks. That looks safe: hinic3_sw_init() allocates txqs and rxqs before
register_netdev(). In hinic3_nic_remove(), hinic3_sw_uninit() frees them
after unregister_netdev().

It's still unrelated to the stated fix, though. Could these two changes
be explained in the changelog or moved into separate patches?

[ ... ]

> @@ -795,45 +795,38 @@ static void hinic3_get_stats64(struct net_device *netdev,
>  	packets = 0;
>  	dropped = 0;
>  	for (i = 0; i < nic_dev->max_qps; i++) {
> -		if (!nic_dev->txqs)
> -			break;
> -
>  		txq = &nic_dev->txqs[i];
>  		txq_stats = &txq->txq_stats;
>  		do {
>  			start = u64_stats_fetch_begin(&txq_stats->syncp);
> -			bytes += txq_stats->bytes;
> -			packets += txq_stats->packets;
> -			dropped += txq_stats->dropped;
> +			bytes = txq_stats->bytes;
> +			packets = txq_stats->packets;
> +			dropped = txq_stats->dropped;
>  		} while (u64_stats_fetch_retry(&txq_stats->syncp, start));
> +		stats->tx_packets += packets;
> +		stats->tx_bytes   += bytes;
> +		stats->tx_dropped += dropped;
>  	}
> -	stats->tx_packets = packets;
> -	stats->tx_bytes   = bytes;
> -	stats->tx_dropped = dropped;
>  
>  	bytes = 0;
>  	packets = 0;
>  	errors = 0;
>  	dropped = 0;
>  	for (i = 0; i < nic_dev->max_qps; i++) {
> -		if (!nic_dev->rxqs)
> -			break;
> -
>  		rxq = &nic_dev->rxqs[i];
>  		rxq_stats = &rxq->rxq_stats;
>  		do {
>  			start = u64_stats_fetch_begin(&rxq_stats->syncp);
> -			bytes += rxq_stats->bytes;
> -			packets += rxq_stats->packets;
> -			errors += rxq_stats->csum_errors +
> -				rxq_stats->other_errors;
> -			dropped += rxq_stats->dropped;
> +			bytes = rxq_stats->bytes;
> +			packets = rxq_stats->packets;
> +			errors = rxq_stats->other_errors;
> +			dropped = rxq_stats->dropped;
>  		} while (u64_stats_fetch_retry(&rxq_stats->syncp, start));
> +		stats->rx_packets += packets;
> +		stats->rx_bytes   += bytes;
> +		stats->rx_errors  += errors;
> +		stats->rx_dropped += dropped;
>  	}
> -	stats->rx_packets = packets;
> -	stats->rx_bytes   = bytes;
> -	stats->rx_errors  = errors;
> -	stats->rx_dropped = dropped;
>  }
>  
>  static void hinic3_nic_set_rx_mode(struct net_device *netdev)

[Severity: Low]
Now that the reads inside both retry loops use '=' instead of '+=',
the resets before the loops are dead stores. That is bytes, packets and
dropped before the tx loop, and bytes, packets, errors and dropped
before the rx loop.

Every iteration of the for loop overwrites those locals in the do/while
before anything reads them. The per-queue values are then summed into
the rtnl_link_stats64 fields, which dev_get_stats() has already cleared
before it calls ndo_get_stats64. Nothing reads the zero values.

This causes no functional problem. The leftover resets still make the
locals look like accumulators, which is the pattern this patch is
removing.

Could the resets be dropped? Alternatively, the locals could be declared
inside the loop bodies, so it's clear they only hold one queue's
snapshot.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793946318.git.gongfan1%40huawei.com
