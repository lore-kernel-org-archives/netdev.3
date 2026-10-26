Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793043040;
	b=l8EISybV7zA1z4qp6FB58vYwz86CAfg4ZFqgIuzSgRU+9yZCj3ZbmgBlomNJlMZxoo+j
	 zzSI/MyoEZWfYb7MsZorcTNDT+YBz7eSVFqBzvzU3U2iHs7pOuPf3IA30JX3XgKQyzido
	 a2oB9GNJEdAaSCSIHEU2DHPFf2gloUuzbO12q69nVThbsulDM3pbw87eLf0DBvtQtTd5t
	 MZjjP26frpEZ4xFHj3d8++N8yG1kzMjTRiEcgXfzGD6GT46+/PCKQIia/LtyHKyQmhlnA
	 E9uH15/H+QyPdT6UQFQGo4evYCLxmMdTVVTaOQBkf52KFLbnN7Wo7/jFMOWUoURgVCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793043040;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=TkS/MDhcc9W4QvmOndxa9rv/boBJ5xl+cYCYIIZ9ZRs=;
	b=CGa7olovL1T6x3EuAHEd674IhKKSqEmaVplDuSpqkjx0iaI7drx7ZfH7UJqOotHz4VGr
	 0UazF9i6XSjIjeb2xMdeUqtxFOb4Fjw6WbIjCdX98D06Ee8u7D9u5uRSik10Jkue7Qp7l
	 /MZ3cKR55exJ4xtvuH4UeIXCvH6RqE7QCwSBK2w47wIGv8Vmyk2vKCEnmmZ880Gsty9PJ
	 /9xg8fHk7QcJdOaq2LbNowE73Zit+VU59ssicGtQLZWaya6UZ3kqHh4/TMYT03F9kztPZ
	 u6sc3PaiSmv0qUDjXFAXb31A/K384PLiAxubVMltbTR7/qJ5n1CeKiBCfupNWjQvH5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OlzyaHyD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D08606A31A;
	Mon, 26 Oct 2026 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OlzyaHyD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C480A1F01825;
	Mon, 26 Oct 2026 19:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793043039;
	bh=TkS/MDhcc9W4QvmOndxa9rv/boBJ5xl+cYCYIIZ9ZRs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OlzyaHyDy6rm0G3WUpbztqrmO7Xe3hyW9vt6i51bE1aiADLC9BZHj/5mAJ1fNw+Q7
	 kZewc2BuKtS5miZ6iSxVpFPPgpun71DGTSc/8MU8dLOMa0T8WzshyWUF6erKMcQl2j
	 WL+zewgrDUwN4pZLpr0s74GxFmWfGrdj3sC+SmAmyik/hUtZMrt0nJcZzUGqZ3jb+u
	 FsBMoJ2DPM2KgqhwcUI9GkecbnSbovXJ4BhuBkyp8kZoRljYvOItgXsBF3xs6wdzAy
	 evmVgrq3x2EwTmVynbOxqyDDvMcWpKiuqUwCjrdpambiMRtlTse8UWnSSdjaRZgyO/
	 Rz7NKLQoe4NNQ==
Subject: Re: [PATCH net 2/3] net: dsa: qca8k: drop MIB autocast frames once
 the request is over
From: netdev-bot+sashiko@kernel.org
To: kuncy7@gmail.com
Cc: ansuelsmth@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 19:30:38 +0000
Message-ID: <179304303832.3134.328719975361344250@kernel.org>
In-Reply-To: <20261022192933.384898-3-kuncy7@gmail.com>
References: <20261022192933.384898-3-kuncy7@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch tells a late autocast frame from a live one only by
  checking whether mib_eth_data->data is NULL.

Pre-existing issues:
- [High] At this commit, qca8k_mib_autocast_handler() sets data2 =
  (__le32 *)skb->data and reads counters 3..mib_count-1 from it.

--

net: dsa: qca8k: drop MIB autocast frames once the request is over

This patch adds a spinlock to qca8k_mib_eth_data, taken by both
qca8k_mib_autocast_handler() and qca8k_get_ethtool_stats_eth(). The
request's data pointer is cleared when the request finishes or times out,
and the handler drops any frame that arrives while data is NULL. This is
meant to stop late frames from writing into a freed ethtool buffer and
from underflowing port_parsed.

> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index 49be53b7fb61f..56796df14bf5a 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> @@ -1663,6 +1663,12 @@ static void qca8k_mib_autocast_handler(struct dsa_switch *ds, struct sk_buff *sk
>  	mib_ethhdr = (struct mib_ethhdr *)skb_mac_header(skb);
>  	mib_eth_data = &priv->mib_eth_data;
>  
> +	spin_lock(&mib_eth_data->lock);
> +
> +	/* A late frame of a request that has already returned */
> +	if (!mib_eth_data->data)
> +		goto unlock;

[Severity: Medium]

Can this check tell a late frame from a frame of the current request?
struct mib_ethhdr has only the three counters and the QCA tag, so nothing
ties a frame to a particular MIB_CAST.

Also, qca8k_get_ethtool_stats_eth() does not poll QCA8K_MIB_BUSY before
sending a new cast. qca8k_mib_init() does poll it for the flush.

Consider this sequence:

request N, qca8k_get_ethtool_stats_eth()
    wait_for_completion_timeout() times out, frames still in flight
    mib_eth_data->data = NULL;

request N+1, qca8k_get_ethtool_stats_eth()
    reinit_completion(&mib_eth_data->rw_done);
    spin_lock_bh(&mib_eth_data->lock);
    mib_eth_data->req_port = dp->index;
    mib_eth_data->data = data;
    refcount_set(&mib_eth_data->port_parsed, QCA8K_NUM_PORTS);
    spin_unlock_bh(&mib_eth_data->lock);

qca8k_mib_autocast_handler(), leftover frames of request N
    data is not NULL, so the frames pass this check
    each one decrements request N+1's port_parsed
    one whose source port matches req_port writes N's counters into
    the new buffer

When port_parsed reaches zero on a mix of old and new frames, the handler
runs:

	if (refcount_dec_and_test(&mib_eth_data->port_parsed)) {
		mib_eth_data->data = NULL;
		complete(&mib_eth_data->rw_done);
	}

Request N+1's own remaining frames, possibly including its req_port frame,
are then dropped by this NULL check.

wait_for_completion_timeout() returns a positive value, so
qca8k_get_ethtool_stats() takes the early return:

	if (priv->mgmt_conduit && priv->info->ops->autocast_mib &&
	    priv->info->ops->autocast_mib(ds, port, data) > 0)
		return;

That skips the register-read fallback. Could userspace then get zeros from
the vzalloc'd buffer, or request N's old counters, reported as a
successful read?

QCA8K_ETHERNET_TIMEOUT is msecs_to_jiffies(5), which is only one or two
jiffies at low HZ. A timeout with frames still queued in the conduit RX
path seems plausible.

The commit message says:

    so that frames arriving after that are dropped without
    touching data or port_parsed.

The new comments also say "A late frame of a request that has already
returned", "retire the request so that the handler drops them" and "NULL
with no request pending". These claims seem to hold only until the next
request publishes data again. The later patch "net: dsa: qca8k: check the
length of MIB autocast frames" does not change this logic either.

Would it be possible to resync with the hardware after a timeout, for
example by polling for QCA8K_MIB_BUSY to clear before the next cast? Or
could the code check that the req_port frame was actually parsed before
reporting success? Failing that, could the commit message and comments be
corrected?

> +
>  	/* The switch autocast every port. Ignore other packet and
>  	 * parse only the requested one.
>  	 */

[Severity: High]

This is a pre-existing issue, not one introduced by this patch. A little
further down in qca8k_mib_autocast_handler(), the remaining counters are
read from skb->data with no length check:

	data2 = (__le32 *)skb->data;
	...
		if (mib->size == 2)
			mib_eth_data->data[i] = get_unaligned_le64((__le64 *)data2);
		else
			mib_eth_data->data[i] = get_unaligned_le32(data2);

That is 156 bytes on QCA832x and 164 bytes on QCA833x. Before calling the
handler, qca_tag_rcv() only guarantees the 2-byte tag:

	if (unlikely(!pskb_may_pull(skb, QCA_HDR_LEN))) {
	...
	if (pk_type == QCA_HDR_RECV_TYPE_MIB) {
		if (likely(tagger_data->mib_autocast_handler))
			tagger_data->mib_autocast_handler(ds, skb);

Can a short or non-linear MIB frame make this loop read past
skb_headlen()? The bytes would land in the buffer that ethtool_get_stats()
copies to an unprivileged caller.

The next patch in the series, "net: dsa: qca8k: check the length of MIB
autocast frames", fixes this. It adds pskb_may_pull(skb, len) before data2
is used and reloads mib_ethhdr afterwards.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022192933.384898-1-kuncy7%40gmail.com
