Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2C730C361;
	Wed, 23 Sep 2026 00:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790123896; cv=none; b=qMxBaS1uBFZ1zEMuDDvr/8gROipuscPTvJS9R887Q/sZmVvjdGaygHsLQ7+dTpemiZ/T2L4xZ6oAf17o4+sN+eN4veBtfqLzeNDUIHlRIdUfHmKw9czRrED3VoaBQcY6sG050GBlv+UvdGSHyL8LkGZhdSWsW5mYkye4xUlyhWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790123896; c=relaxed/simple;
	bh=D11Qa1XaclAb0X0kER9UnkHort1OytlBs9Dn6eiJMaI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PBkQDmYJTLu+wOjqahq18kFOaF/BUZhsZHEc7VVmRo4YXvWuKEVmy3npWuCPfiR0mZCJeLSvI9vWx41OLNkcsqqGJ9rc6aEwJpE3D5Kf5v7QGljymXN5+Yk70nAnf/N78TQ6Kpb5ShZbUid23rtp3pLnNiC95D/+39VzMJ4o6xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CH/b1TdK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CH/b1TdK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD4C1F000FF;
	Wed, 23 Sep 2026 00:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790123895;
	bh=uOE5Ch/Skan/ro5NYmClGjYRXxtlNtSRV7xoDY6rMlA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CH/b1TdKVHgUwg9/YSsOFfilBW/nXRTTllFur57NKDzotDLLBpF9nBzt6cpvfNWsl
	 jy0s4Pzgri97rm6GvkluOv/JCfq4FFTvUO3VIcp7iUe72ZM90W5KLWK3xzQu+jWJAN
	 h2eaDV+lLbaNWMFsm8bf64z0qIkT2SGhXYjq6fE+725zv1oopMV98pdOjc+gumluWg
	 XJ+vAJt0SJc0VEx+Zwy3CGhiLoRwo4uzezqr/nKFv3d7kBFDsWXCmk+garkHcJGIim
	 jyjQvg+u3aLGIyF0P69wKlV4jbgJbWUFnTo/RqqeQaSWcJM4AiXkTrgB3dZHJWeqIJ
	 ZWriFHY55BGsQ==
Subject: Re: [PATCH net-next v4 5/7] net: dsa: motorcomm: Use u64_stats_t for
 MIB stats
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 00:38:14 +0000
Message-ID: <179012389416.2160803.482320997990066474@kernel.org>
In-Reply-To: <20260921203040.1203911-6-mmyangfl@gmail.com>
References: <20260921203040.1203911-6-mmyangfl@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Interim 32-bit tearing window: this commit retypes all MIB
  counters to `u64_stats_t` and replaces the publication store…

Pre-existing issues:
- [Medium] `yt921x_dsa_get_rmon_stats()` reports `rmon_stats->fragments`
  from `mib->rx_alignment_errors` (register…

--

net: dsa: motorcomm: Use u64_stats_t for MIB stats

This converts every MIB counter in the motorcomm DSA driver from plain u64
to u64_stats_t, and updates all producers and consumers to use
u64_stats_set() / u64_stats_read().  The commit message states that
u64_stats_sync will be added in the following commit.

A couple of questions below.

> diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
> index c2f7d7f83cd98..69b9eb7e52086 100644
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
> -	/* Reading of yt921x_mib_stats is not protected by a lock and it's vain
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

[ ... ]

> @@ -130,17 +124,25 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
>  			val = ((u64)val1 << 32) | val0;
>  		}
>  
> -		WRITE_ONCE(*valp, val);
> +		u64_stats_set(valp, val);
>  	}

[Severity: Medium]
Is this intermediate state a step backwards on 32-bit for one commit?

On BITS_PER_LONG == 32, u64_stats_t is a bare struct and the accessors are
plain loads and stores:

include/linux/u64_stats_sync.h:
    static inline void u64_stats_set(u64_stats_t *p, u64 val)
    {
            p->v = val;
    }

    static inline u64 u64_stats_read(const u64_stats_t *p)
    {
            return p->v;
    }

So this hunk replaces the only write-side annotation, WRITE_ONCE(*valp,
val), with an unannotated 64-bit store, while struct yt921x_mib in this
commit still has no struct u64_stats_sync to bracket it with.  The readers
in yt921x_dsa_get_stats64() run with no lock at all, and the other getters
(yt921x_dsa_get_eth_mac_stats(), _eth_ctrl_stats(), _rmon_stats(),
_pause_stats(), _ethtool_stats()) copy the counters out after
mutex_unlock(&priv->reg_lock), so they can race with the
yt921x_mib_poll() -> yt921x_mib_read() delayed work.

The commit message says "u64_stats_sync will be equipped in the next
commit", and the follow-up commit does add struct u64_stats_sync syncp to
struct yt921x_mib, wraps the publication in
u64_stats_update_begin_irqsave() / u64_stats_update_end_irqrestore(),
converts yt921x_dsa_get_stats64() to a u64_stats_fetch_begin() /
u64_stats_fetch_retry() loop, and moves the remaining getters' reads back
under priv->reg_lock, so the window only exists between the two commits.

Would it be preferable to squash the two commits, or at least keep
WRITE_ONCE() here until syncp lands, so that no single commit in the series
leaves the 32-bit tearing window wider than before?

[ ... ]

> @@ -322,26 +324,26 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
>  
>  	*ranges = yt921x_rmon_ranges;
>  
> -	rmon_stats->undersize_pkts = mib->rx_undersize_errors;
> -	rmon_stats->oversize_pkts = mib->rx_oversize_errors;
> -	rmon_stats->fragments = mib->rx_alignment_errors;
> +	rmon_stats->undersize_pkts = u64_stats_read(&mib->rx_undersize_errors);
> +	rmon_stats->oversize_pkts = u64_stats_read(&mib->rx_oversize_errors);
> +	rmon_stats->fragments = u64_stats_read(&mib->rx_alignment_errors);
>  	/* rmon_stats->jabbers */

[Severity: Medium]
This isn't a bug introduced by this patch, it is pre-existing and only the
right hand side was rewritten here, but should rmon_stats->fragments come
from mib->rx_fragment_errors instead of mib->rx_alignment_errors?

The driver reads both registers into separate fields:

drivers/net/dsa/motorcomm/mib.c:yt921x_mib_descs[] = {
    ...
    MIB_DESC(1, YT921X_MIB_DATA_RX_ALIGN_ERR, NULL),
    MIB_DESC(1, YT921X_MIB_DATA_RX_UNDERSIZE_ERR, NULL),
    MIB_DESC(1, YT921X_MIB_DATA_RX_FRAG_ERR, NULL),
    ...
}

mib->rx_alignment_errors is already exported twice, as
mac_stats->AlignmentErrors and as stats->rx_frame_errors, while
mib->rx_fragment_errors is only folded into stats->rx_length_errors and is
never reported through the RMON group.  The mapping is unchanged at the end
of this series as well.

[ ... ]

> @@ -357,32 +359,34 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
>  		return;
>  	mib = &pm->stats;
>  
> -	stats->rx_length_errors = mib->rx_undersize_errors +
> -				  mib->rx_fragment_errors;
> -	stats->rx_over_errors = mib->rx_oversize_errors;
> -	stats->rx_crc_errors = mib->rx_crc_errors;
> -	stats->rx_frame_errors = mib->rx_alignment_errors;
> +	stats->rx_length_errors = u64_stats_read(&mib->rx_undersize_errors) +
> +				  u64_stats_read(&mib->rx_fragment_errors);
> +	stats->rx_over_errors = u64_stats_read(&mib->rx_oversize_errors);
> +	stats->rx_crc_errors = u64_stats_read(&mib->rx_crc_errors);
> +	stats->rx_frame_errors = u64_stats_read(&mib->rx_alignment_errors);

[ ... ]

> -	stats->rx_packets = pm->rx_frames;
> -	stats->tx_packets = pm->tx_frames;
> -	stats->rx_bytes = mib->rx_good_bytes - ETH_FCS_LEN * stats->rx_packets;
> -	stats->tx_bytes = mib->tx_good_bytes - ETH_FCS_LEN * stats->tx_packets;
> +	stats->rx_packets = u64_stats_read(&pm->rx_frames);
> +	stats->tx_packets = u64_stats_read(&pm->tx_frames);
> +	stats->rx_bytes = u64_stats_read(&mib->rx_good_bytes) -
> +			  ETH_FCS_LEN * stats->rx_packets;
> +	stats->tx_bytes = u64_stats_read(&mib->tx_good_bytes) -
> +			  ETH_FCS_LEN * stats->tx_packets;

[ ... ]

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

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921203040.1203911-1-mmyangfl%40gmail.com
