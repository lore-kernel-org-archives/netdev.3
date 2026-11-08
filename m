Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794147748;
	b=1WzG1oJTrPy0ozDlzpLK5sV1s2OGrFN+uexrKohIfTSWXrl4/SYrIE9W+yxZ6VHHCJ02
	 BMb2CjCvay9As1ydts6brIdsTmekRKgbcNv6wDVdxoW/+A6K8efJ+wDi6N5GwqqMKdZJv
	 RXfCDcK0D7Zztx43ERXtJiuV4OVPrkM82wn3Dwo70LdKkme0f0ryE7Bb4F1WZN6wPLJj1
	 3AY5aFLwH0MVglzqUpEhLFSw9WiUrlgXNrbazRfrkwZwj6Q+6AzixIxE73flZNbQQ+WCc
	 YUNVnDMf3zWwEqBd8qQ9zzW7wcS8uLR7i+T+2HyH/Re+56Rp3ZZDAJcqTgkgWXWMhkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794147748;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=eDN1XV5sAMvfKPM6blkAGifJPoKZQVmVWde94+gPZzI=;
	b=XmorjDN96nLsqJfBM5ThU0t+0ZljvcP6Gq4qaScJGg6jmrrltnOtvK15TpeZzvRxuLVh
	 DMNBhhbkMbAxeP3hK0lw5KdO9Em9wvprsY8jYoEfKK8pueTY1umV68I3Ycgl27beWD713
	 CE8rhj6DjLWKUzFc1jJjygE87YINpiEI4anr5VMH34oas3qJhaNMeK7ac0i3IDfGRiwlt
	 Xseu3O9+x/EJ6AgPgoNc85TxEpXZD5X7yzYS3nDFe4+kqNGgnd+vgU+OPSPICJLffxE7Y
	 zcD9MnZflG/i0fXtNoGX931ZV56QE/jJBiG1Lh6Vz0K3IK4h4Jycq3El1haBb3l79iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LPCxpjV9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DB1606A31C;
	Sun,  8 Nov 2026 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LPCxpjV9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FB01F0089F;
	Sun,  8 Nov 2026 14:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794147747;
	bh=eDN1XV5sAMvfKPM6blkAGifJPoKZQVmVWde94+gPZzI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LPCxpjV9Nnqw47Jv7F3R5X7lhWecevD9bVKnOzxayfjbpIC4XMcVMnF4GHQpH5qUt
	 35keBR8G//8B4uJHpe+as2rwwGn9pSo/gGVqdefuFOpUFk5XohJdl8PSP+O0nEAqg+
	 +zh+9KsrIstfDwIluWw7Wa+GDdasZg7P8gToZq5NdxSWwL5xbqNCLsBfJvOvM9Hz/3
	 denItmhqLYPL1o3EsY9Cp8F3t9i+eeFNoS5L1vzmtbzK9kmG1mPbP+/owj3Y1fa3Ot
	 JX6Tysscp5x9gM33Fm5aDAnDioBL7Yi92L9KgZE1p3nqTIbRnsmm1RLZI64bLEFEl5
	 KvpqTQJNv8mmQ==
Subject: Re: [PATCH net-next 1/4] net: dsa: motorcomm: Fix stats64 error
 counter mapping
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Sun, 08 Nov 2026 14:22:26 +0000
Message-ID: <179414774671.994134.1756882573318817305@kernel.org>
In-Reply-To: <20261107132040.1066996-2-mmyangfl@gmail.com>
References: <20261107132040.1066996-2-mmyangfl@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In yt921x_dsa_get_stats64(), this patch removes the
  `tx_fifo_errors = tx_undersize_errors` mapping and changes the…
- [Low] The commit "net: dsa: motorcomm: Fix stats64 error counter
  mapping" corrects counters that users see in rtnl_link_stats64 (`ip -s…

Pre-existing issues:
- [Low] yt921x_dsa_get_rmon_stats() sets RMON etherStatsFragments from
  the alignment-error counter (`rmon_stats->fragments =…

--

net: dsa: motorcomm: Fix stats64 error counter mapping

This commit changes yt921x_dsa_get_stats64() to report the RX oversize
counter in rx_length_errors instead of rx_over_errors. It also drops the
mapping of TX undersize to tx_fifo_errors and exposes that counter as a
driver-private TxUndersize ethtool stat instead.

> diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
> index 6b170fc6e1875..5c027edb71e3e 100644
> --- a/drivers/net/dsa/motorcomm/mib.c
> +++ b/drivers/net/dsa/motorcomm/mib.c

[ ... ]

> @@ -376,8 +376,9 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
>  		start = u64_stats_fetch_begin(&pm->syncp);
>  
>  		stats->rx_length_errors = u64_stats_read(&mib->rx_undersize_errors) +
> -					  u64_stats_read(&mib->rx_fragment_errors);
> -		stats->rx_over_errors = u64_stats_read(&mib->rx_oversize_errors);
> +					  u64_stats_read(&mib->rx_fragment_errors) +
> +					  u64_stats_read(&mib->rx_oversize_errors);
> +		/* stats->rx_over_errors */

[Severity: Low]
Should this patch have a Fixes: tag?

The mapping it corrects came in with the original driver. At that
commit, yt921x_dsa_get_stats64() in drivers/net/dsa/yt921x.c had:

	stats->rx_over_errors = mib->rx_oversize_errors;
	...
	stats->tx_fifo_errors = mib->tx_undersize_errors;

Both values were also summed into rx_errors and tx_errors.

Commit 25265e7ccdb5 later moved this code to
drivers/net/dsa/motorcomm/mib.c, and commit ed4453587dc0 wrapped the
reads in u64_stats_read(). Neither commit changed the mapping.

Would something like this be appropriate?

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")

>  		stats->rx_crc_errors = u64_stats_read(&mib->rx_crc_errors);
>  		stats->rx_frame_errors = u64_stats_read(&mib->rx_alignment_errors);

[Severity: Low]
This is a pre-existing issue, not one introduced by this patch. Since
this function uses rx_fragment_errors as the fragment count, does
yt921x_dsa_get_rmon_stats() read the wrong counter for RMON fragments?

drivers/net/dsa/motorcomm/mib.c:yt921x_dsa_get_rmon_stats() {
    ...
	rmon_stats->fragments = u64_stats_read(&mib->rx_alignment_errors);
    ...
}

rx_alignment_errors is already reported as AlignmentErrors in
yt921x_dsa_get_eth_mac_stats() and as rx_frame_errors here. That means
the hardware fragment counter (YT921X_MIB_DATA_RX_FRAG_ERR) can't be
seen through the standard RMON stats.

A later patch in this series, "net: dsa: motorcomm: Fix RMON fragments
stat", changes that line to read rx_fragment_errors. Nothing is left to
fix by the end of the series.

>  		/* stats->rx_fifo_errors */
> @@ -385,7 +386,7 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
>  
>  		stats->tx_aborted_errors = u64_stats_read(&mib->tx_aborted_errors);
>  		/* stats->tx_carrier_errors */
> -		stats->tx_fifo_errors = u64_stats_read(&mib->tx_undersize_errors);
> +		/* stats->tx_fifo_errors */
>  		/* stats->tx_heartbeat_errors */
>  		stats->tx_window_errors = u64_stats_read(&mib->tx_late_collisions);
>  
> @@ -401,10 +402,9 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
>  		stats->collisions = u64_stats_read(&mib->tx_collisions);
>  	} while (u64_stats_fetch_retry(&pm->syncp, start));
>  
> -	stats->rx_errors = stats->rx_length_errors + stats->rx_over_errors +
> -			   stats->rx_crc_errors + stats->rx_frame_errors;
> -	stats->tx_errors = stats->tx_aborted_errors + stats->tx_fifo_errors +
> -			   stats->tx_window_errors;
> +	stats->rx_errors = stats->rx_length_errors + stats->rx_crc_errors +
> +			   stats->rx_frame_errors;
> +	stats->tx_errors = stats->tx_aborted_errors + stats->tx_window_errors;

[Severity: Medium]
With the tx_fifo_errors mapping removed, TX undersize events are no
longer counted in any rtnl_link_stats64 field, and that includes
tx_errors. Is this intended?

The tx_errors kernel-doc in include/uapi/linux/if_link.h says:

 * @tx_errors: Total number of transmit problems.
 *   This counter must include events counter by @tx_aborted_errors,
 *   @tx_carrier_errors, @tx_fifo_errors, @tx_heartbeat_errors,
 *   @tx_window_errors and other errors not otherwise counted.

A runt frame may not be a FIFO underrun. Could tx_undersize_errors still
be added to tx_errors as an error not otherwise counted?

As written, a port that sends runt frames now shows a lower tx_errors in
ip -s link and /proc/net/dev than before this patch. The only place these
events still appear is the driver-private TxUndersize ethtool -S string.

The commit message also doesn't mention the change to tx_errors. The
later patches in this series don't change this calculation.

>  }
>  
>  void

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107132040.1066996-1-mmyangfl%40gmail.com
