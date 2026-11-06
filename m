Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940547;
	b=ghyg2nAlF+oh9iDn5vmVI+LblNrYEVhB/RR7AM50FJvx21Qt+OUtuTYq+w/+TCjzXccj
	 3T4MC/ruZa8OljT3A55BJ73UyA6W7lDOEpgAE/BI/HYpOwzQWQB9kGBq03E/pIfXNFMOp
	 s6jZ6MwhkRXrImikJ5xt9aFbzpG/17ZyDb/ipnBhdWjg4wuh2lY2wxLfiLr8bc420M2r8
	 eelp7FM/niLm92MidePzQQnnolPVtb8HmHFOlUWqVeW2jWRina5Hm3WNYjGN5Oag24qTQ
	 OCTYyGAe/7WCpt1oxS/qlim2nc4wnhR+PZnE7K6RMY8DSu4aDS8BBQx+0C2L4VeMevQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940547;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Vzq2/jHd3V7ID2OwpV6kcgif4qPDG3Zz7FiqGWqZnhI=;
	b=mMohK0Esl5baML0U4mat3yzEtm8+icA/HadghMBGuHQCQPvw64dSqCUmxZUWhmiC0SPA
	 4gHLP4q8C6ktXcEFMti1XaL/QHVH6qCr9tfj4QpNZ8OG6XgKf6WjYIywBiE4M6yVt3Iye
	 0TH01Kh7f7f4tJ0HmeIFXq1mj4fWlJI/2ylZ0nVE4rulmmQCPOFsGyMnMB56/P/8ne7NZ
	 lSBd+whnFsYo++sEL6mKGg+MhCYUV+av11PHDBIAVOfa2Yr2o3ut68oKxbiQuHCG3CzbA
	 3Hj4o/brLdQeXE8lcX/T3AZmRU0o6gVKZZnNstQ2YmB0FNiAurpyPnI6JdEcI7A1UlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yffi4axE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A15B606A32C;
	Fri,  6 Nov 2026 04:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yffi4axE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2E71F008A1;
	Fri,  6 Nov 2026 04:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793940547;
	bh=Vzq2/jHd3V7ID2OwpV6kcgif4qPDG3Zz7FiqGWqZnhI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Yffi4axE2MCSQ2nijd15ai0/VtaUYmkB/x9YZSDLGMuELiHb78XCyq4tgfoqQNYip
	 Zx9vyyYH785lJdzB8qSG/2LVXxU4FxCwMoxKk20W7lriQXKHmVdyE8ACCnhVc8rR6c
	 vOYN09sdtr/Ae1S/8x0YfrJE46iCKJVPrlCzOUm+7F6gqetLom1rKX9ay3D5zfrk2U
	 zu30AiwjSkRRdQT8fbhnpehNuecKCYv06Pjw7NrP5+uWvwY5n4eTcfnFFcK4V1Qzao
	 WFabnY1PzNS/dKNcpqzGdkpAnPRwEtNYDeNrzIuY8iKBgr8W8t3mDbI5zObRSJLs4m
	 dpQDb9LLijkFg==
Subject:
 Re: [PATCH net v2] net: dsa: motorcomm: Publish a consistent MIB sample
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Fri, 06 Nov 2026 04:49:06 +0000
Message-ID: <179394054617.994134.16932416982994953032@kernel.org>
In-Reply-To: <20261103134705.867613-1-mmyangfl@gmail.com>
References: <20261103134705.867613-1-mmyangfl@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The underflow this patch says it fixes can still happen when
  the MIB sample is fully consistent.

--

net: dsa: motorcomm: Publish a consistent MIB sample

This patch moves the "good_bytes - ETH_FCS_LEN * frames" calculation out
of yt921x_dsa_get_stats64() and into the writer, yt921x_mib_read(). The
writer then publishes the result as pm->rx_bytes and pm->tx_bytes. It
also skips publishing the sample when a register read fails.

> diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
> index 6b170fc6e1875..d47aafc468a3f 100644
> --- a/drivers/net/dsa/motorcomm/mib.c
> +++ b/drivers/net/dsa/motorcomm/mib.c

[ ... ]

> @@ -144,14 +152,15 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
>  		    u64_stats_read(&mib->tx_512_1023byte) +
>  		    u64_stats_read(&mib->tx_1024_1518byte) +
>  		    u64_stats_read(&mib->tx_jumbo);
> +	rx_bytes = u64_stats_read(&mib->rx_good_bytes) - ETH_FCS_LEN * rx_frames;
> +	tx_bytes = u64_stats_read(&mib->tx_good_bytes) - ETH_FCS_LEN * tx_frames;

[Severity: Medium]
Can this subtraction still underflow when the sample is fully consistent?

rx_frames and tx_frames are sums of the packet-length histogram buckets
(rx_64byte through rx_jumbo, and tx_64byte through tx_jumbo). The byte
term comes from a separate counter, RX_GOOD_BYTES or TX_GOOD_BYTES, which
appears to count good frames only. The hardware also has a separate
RxBadBytes counter:

	MIB_DESC(2, YT921X_MIB_DATA_RX_BAD_BYTES, "RxBadBytes"),

yt921x_dsa_get_rmon_stats() exports the same buckets as RMON histogram
counters:

	rmon_stats->hist[0] = u64_stats_read(&mib->rx_64byte);
	...
	rmon_stats->hist_tx[0] = u64_stats_read(&mib->tx_64byte);

Those are the RFC 2819 etherStatsPktsXtoYOctets counters, and RFC 2819
counts bad packets in them.

If the YT921x buckets also count CRC or alignment errored frames, a port
that receives only errored frames would see rx_64byte grow while
rx_good_bytes stays the same. rx_bytes would then wrap to about 2^64.
This is the same symptom the commit message describes.

Because the value is recomputed and published on every poll, would the
wrapped value persist? The commit message says:

    The issue is transient and abnormal values will be flushed
    by the next function call.

That claim would not hold in this case.

There also seems to be a mismatch with struct rtnl_link_stats64. It says
rx_packets counts good packets and rx_bytes corresponds to rx_packets.
For TX, the driver already reads a good-frame counter into mib->tx_good:

	MIB_DESC(1, YT921X_MIB_DATA_TX_PKT, NULL),

Would tx_good be a better match for tx_good_bytes than the histogram sum?
Alternatively, should the subtraction be clamped to avoid wrapping?

>  	u64_stats_set(&pm->rx_frames, rx_frames);
>  	u64_stats_set(&pm->tx_frames, tx_frames);
> +	u64_stats_set(&pm->rx_bytes, rx_bytes);
> +	u64_stats_set(&pm->tx_bytes, tx_bytes);
>  	u64_stats_update_end_irqrestore(&pm->syncp, flags);

[ ... ]

> @@ -391,10 +400,8 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
>  
>  		stats->rx_packets = u64_stats_read(&pm->rx_frames);
>  		stats->tx_packets = u64_stats_read(&pm->tx_frames);
> -		stats->rx_bytes = u64_stats_read(&mib->rx_good_bytes) -
> -				  ETH_FCS_LEN * stats->rx_packets;
> -		stats->tx_bytes = u64_stats_read(&mib->tx_good_bytes) -
> -				  ETH_FCS_LEN * stats->tx_packets;
> +		stats->rx_bytes = u64_stats_read(&pm->rx_bytes);
> +		stats->tx_bytes = u64_stats_read(&pm->tx_bytes);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103134705.867613-1-mmyangfl%40gmail.com
