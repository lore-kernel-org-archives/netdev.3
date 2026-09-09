Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428F0563FC2;
	Wed,  9 Sep 2026 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966978; cv=none; b=Z3eT43LXPFh6gpyr+6RPjekcvWcltwKjS6qVFx/Gbl3zmCsypq3PMAMqOdwRv7EvNtetGwS2kT37gtDf8KV7JxYsSvtcHzu1TB8/e8VUPh0oa5rVFAx0t8Veo7YX8DA9AuuaMYHQ2sIXtLLgYxDfstViuM7QhlnBwbywZqNDq3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966978; c=relaxed/simple;
	bh=PlIIwNHA0v7X9g9ft1MO22gZgAkJnvS+0osWG+oR3Cw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uz5WKGerOb1h9p/cOL6onbu+WvblHU8mEhqmYkw1Y3JVkSLm3qCp9QgHYDZQnE11b9xtJLBeCwzql2ZY5oaedUPRagB5KZvu0d5XHcgxPzl30ZUI57EVzN3rlAhPkOescCuarlMHN4WR+DM/jp5RR6D2U6c3IN3cWIAT3K74Rvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUZu8zxp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUZu8zxp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCE51F00AC4;
	Wed,  9 Sep 2026 15:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966976;
	bh=I3sXLMfT37qvCEqbB2PXEkbVgC+jiZJoqyCvOaxW0WI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lUZu8zxp1GHjJUR4bon+EJrfJoIo1syg8/2cBHu2c7pHp4aAlyhzKK10a1TuedtgW
	 d79qNylhbsKzkIXpvOCxxwPVbqCuQAVDpPzEIVy2S1EGumj/twK4ZkgbiMQdFHAJcW
	 lLXvpLMoX7bcfpD1J567ngWQsSnBrs+5VdWaU/9QTlGx3qo00AlIOfC2tvuECqGVVg
	 RFQZHppfnqDK1LymPtm8t8ybxaXgv+XVljmVxIF+AqPneFqehrGE4QQ/an29fwuTf/
	 XUGe8gUNxfPR5sQ8OJhXdxno+vFsY6vzL04muWksNjsKxGBSDWK2vnWqemwNwekWYh
	 gF2OOS1GQPLuA==
Subject: Re: [PATCH net-next v3 4/6] net: dsa: motorcomm: Use u64_stats_t for
 MIB stats
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Date: Wed, 09 Sep 2026 15:16:15 +0000
Message-ID: <178896697595.219967.18264990236877680061@kernel.org>
In-Reply-To: <20260906131414.2683362-5-mmyangfl@gmail.com>
References: <20260906131414.2683362-5-mmyangfl@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 (1) · Low: 1 (1)

- [Low] In "net: dsa: motorcomm: Use u64_stats_t for MIB stats" the MIB
  counters are converted from u64 to u64_stats_t while no `struct…

Pre-existing issues:
- [Medium] For the 64-bit MIB counters (desc->size == 2: RX_GOOD_BYTES,
  RX_BAD_BYTES, TX_GOOD_BYTES) yt921x_mib_read() performs two…
- [Low] yt921x_dsa_get_stats64() (drivers/net/dsa/motorcomm/mib.c) reads
  the shared MIB counters with no lock and, at the reviewed commit, no…

--

net: dsa: motorcomm: Use u64_stats_t for MIB stats

This converts every MIB counter in struct yt921x_mib_stats and the derived
rx_frames/tx_frames fields from plain u64 to u64_stats_t, and updates all
readers in mib.c to use u64_stats_read().  The changelog notes that
u64_stats_sync is added in the next commit.

> diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
> index b1296f224cf69..f5d39d22215d4 100644
> --- a/drivers/net/dsa/motorcomm/mib.c
> +++ b/drivers/net/dsa/motorcomm/mib.c
> @@ -92,22 +92,16 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
>  	struct device *dev = to_device(priv);
>  	struct yt921x_mib *pm = pp->mib;
>  	struct yt921x_mib_stats *mib;
> +	u64 rx_frames;
> +	u64 tx_frames;
>  	int res = 0;
>  
>  	mib = &pm->stats;
>  
> -	/* Reading of yt921x_port::mib is not protected by a lock and it's vain
> -	 * to keep its consistency, since we have to read registers one by one
> -	 * and there is no way to make a snapshot of MIB stats.
> -	 *
> -	 * Writing (by this function only) is and should be protected by
> -	 * reg_lock.
> -	 */
> -
>  	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
>  		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
>  		u32 reg = YT921X_MIBn_DATA0(port) + desc->offset;
> -		u64 *valp = &((u64 *)mib)[i];
> +		u64_stats_t *valp = &((u64_stats_t *)mib)[i];
>  		u32 val0;
>  		u64 val;
>  
> @@ -116,7 +110,7 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
>  			break;
>  
>  		if (desc->size <= 1) {
> -			u64 old_val = *valp;
> +			u64 old_val = u64_stats_read(valp);
>  
>  			val = (old_val & ~(u64)U32_MAX) | val0;
>  			if (val < old_val)

[Severity: Low]
The changelog says the change addresses the case where "64-bit variables
might not be atomic on 32-bit architectures, and could lead to load/store
tearing".  Does this commit on its own change anything on 32-bit?

With BITS_PER_LONG == 32, u64_stats_read() and u64_stats_set() are plain
accesses:

	static inline u64 u64_stats_read(const u64_stats_t *p)
	{
		return p->v;
	}

	static inline void u64_stats_set(u64_stats_t *p, u64 val)
	{
		p->v = val;
	}

struct yt921x_mib gains no struct u64_stats_sync here, yt921x_mib_read()
has no u64_stats_update_begin()/u64_stats_update_end() region, and
yt921x_dsa_get_stats64() has no u64_stats_fetch_begin()/
u64_stats_fetch_retry() loop, so the tearing named in the changelog is
still there after this patch.

Also, the writer store goes from WRITE_ONCE(*valp, val) to
u64_stats_set(valp, val), which on 32-bit is a plain store, and the comment
documenting the "written only here under reg_lock, read locklessly" rule is
deleted with nothing replacing it.  Would it be preferable to fold this
patch together with the follow-up, or at least keep the WRITE_ONCE()
equivalent and the locking comment until the follow-up lands?

For the record, the next patch in this series, "net: dsa: motorcomm: Fix MIB
synchronization", does add struct u64_stats_sync syncp to struct yt921x_mib,
wraps the write-back in u64_stats_update_begin()/u64_stats_update_end(),
turns yt921x_dsa_get_stats64() into a fetch_begin()/fetch_retry() loop,
moves mutex_unlock(&priv->reg_lock) to after the counter reads in
yt921x_dsa_get_eth_mac_stats(), yt921x_dsa_get_eth_ctrl_stats(),
yt921x_dsa_get_rmon_stats(), yt921x_dsa_get_pause_stats() and
yt921x_dsa_get_ethtool_stats(), and restores the access documentation as
/* protected by syncp OR priv->reg_lock */ in mib.h.

> @@ -130,17 +124,25 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
>  			val = ((u64)val1 << 32) | val0;
        ^^^^

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch, but while
yt921x_mib_read() is being touched: for the desc->size == 2 counters
(RX_GOOD_BYTES, RX_BAD_BYTES, TX_GOOD_BYTES) the low word at
YT921X_MIBn_DATA0(port) + desc->offset and the high word at + 4 are fetched
in two separate SMI transactions with nothing latching the pair.  If the low
word wraps between the two reads, does the composed value end up about 4 GiB
too high, and does that then get cached as the base for the 32-bit
wraparound arithmetic above and exported as a non-monotonic rx_bytes/
tx_bytes?

The last patch of this series, "net: dsa: motorcomm: Use safe 64-bit counter
reader", replaces this with yt921x_counter_read(), which re-reads hi and lo
and accepts the pair only when lo >= old_lo, so the window is closed there.

>  		}
>  
> -		WRITE_ONCE(*valp, val);
> +		u64_stats_set(valp, val);
>  	}
>  
> -	pm->rx_frames = mib->rx_64byte + mib->rx_65_127byte +
> -			mib->rx_128_255byte + mib->rx_256_511byte +
> -			mib->rx_512_1023byte + mib->rx_1024_1518byte +
> -			mib->rx_jumbo;
> -	pm->tx_frames = mib->tx_64byte + mib->tx_65_127byte +
> -			mib->tx_128_255byte + mib->tx_256_511byte +
> -			mib->tx_512_1023byte + mib->tx_1024_1518byte +
> -			mib->tx_jumbo;
> +	rx_frames = u64_stats_read(&mib->rx_64byte) +
> +		    u64_stats_read(&mib->rx_65_127byte) +
> +		    u64_stats_read(&mib->rx_128_255byte) +
> +		    u64_stats_read(&mib->rx_256_511byte) +
> +		    u64_stats_read(&mib->rx_512_1023byte) +
> +		    u64_stats_read(&mib->rx_1024_1518byte) +
> +		    u64_stats_read(&mib->rx_jumbo);
> +	tx_frames = u64_stats_read(&mib->tx_64byte) +
> +		    u64_stats_read(&mib->tx_65_127byte) +
> +		    u64_stats_read(&mib->tx_128_255byte) +
> +		    u64_stats_read(&mib->tx_256_511byte) +
> +		    u64_stats_read(&mib->tx_512_1023byte) +
> +		    u64_stats_read(&mib->tx_1024_1518byte) +
> +		    u64_stats_read(&mib->tx_jumbo);
> +	u64_stats_set(&pm->rx_frames, rx_frames);
> +	u64_stats_set(&pm->tx_frames, tx_frames);
>  
>  	if (res)
>  		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",

[ ... ]

> @@ -246,28 +248,28 @@ yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
>  	yt921x_mib_read(priv, port);
>  	mutex_unlock(&priv->reg_lock);
>  
> -	mac_stats->FramesTransmittedOK = pm->tx_frames;
> +	mac_stats->FramesTransmittedOK = u64_stats_read(&pm->tx_frames);

[ ... ]

> @@ -358,32 +360,34 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
>  		return;
>  	mib = &pm->stats;
>  

[ ... ]

> +	stats->rx_packets = u64_stats_read(&pm->rx_frames);
> +	stats->tx_packets = u64_stats_read(&pm->tx_frames);
> +	stats->rx_bytes = u64_stats_read(&mib->rx_good_bytes) -
> +			  ETH_FCS_LEN * stats->rx_packets;
> +	stats->tx_bytes = u64_stats_read(&mib->tx_good_bytes) -
> +			  ETH_FCS_LEN * stats->tx_packets;

[Severity: Low]
This is a pre-existing issue rather than something this patch introduces,
but the derivation here mixes two independently loaded counters while
yt921x_dsa_get_stats64() holds no lock:

	CPU0 yt921x_dsa_get_stats64()
	    stats->rx_packets = u64_stats_read(&pm->rx_frames);
	    /* CPU1: yt921x_mib_poll() -> yt921x_mib_read() rewrites
	     * all counters under priv->reg_lock */
	    stats->rx_bytes = u64_stats_read(&mib->rx_good_bytes) -
			      ETH_FCS_LEN * stats->rx_packets;

If rx_packets is observed fresh and rx_good_bytes stale, can this unsigned
subtraction wrap and report an rx_bytes value close to 2^64 through
rtnl_link_stats64?

The follow-up patch "net: dsa: motorcomm: Fix MIB synchronization" wraps
this whole block in a u64_stats_fetch_begin()/u64_stats_fetch_retry() loop
and publishes all counters plus rx_frames/tx_frames in one writer section,
which gives a consistent snapshot on 32-bit.

> diff --git a/drivers/net/dsa/motorcomm/mib.h b/drivers/net/dsa/motorcomm/mib.h
> index cfad0665baaea..d84ae2f449ac8 100644
> --- a/drivers/net/dsa/motorcomm/mib.h
> +++ b/drivers/net/dsa/motorcomm/mib.h

[ ... ]

> @@ -128,8 +130,8 @@ struct yt921x_mib {
>  
>  	struct delayed_work work;
>  	struct yt921x_mib_stats stats;
> -	u64 rx_frames;
> -	u64 tx_frames;
> +	u64_stats_t rx_frames;
> +	u64_stats_t tx_frames;
>  };
>  
>  void yt921x_mib_poll(struct work_struct *work);

Would it make sense to add struct u64_stats_sync syncp to struct yt921x_mib
in this same patch, so the u64_stats_t fields are never present without
their companion seqcount?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906131414.2683362-1-mmyangfl%40gmail.com
