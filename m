Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49D6311C1B;
	Wed, 23 Sep 2026 00:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790123898; cv=none; b=sCGmRK/Fvnnui83Fm6BbOkN0oexZkvQS/EpEd3T0jOropzfQ4mHwlAwWAtvz8BE8BoZNvT9ElCvYSSNgJPtVgMovJ48O7YH2NmU8tk6hRhfWn+HDAX9zJkMuL3Ia86sasJ4Ogc7eI3f5R2N1+J9WXS6rqMlbt+W4Csa+i7golrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790123898; c=relaxed/simple;
	bh=jfdd69KiI2eKf/lRSFNqSmJoZjVg/5z+T4MWVAu2o24=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EwTo7VbVkdEtZMJnvTs3tRCFaRF13Lp+JSS1lxPlCPgymEHNhvppyVzalcyXrPdY1HeHFen0QYKlOxdoqdr9Gou5aU9Zzej+VB5hvaaNDRArw9N1PgTS0EwknBfb6rFH0Qjfjbap+bIa21YwizjnEDk1IDjNpgmKbrrXe2gRnFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTzHzApY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTzHzApY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05771F00893;
	Wed, 23 Sep 2026 00:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790123896;
	bh=x05fQuSwFjrC/omUwUVnszlyXxNA8F27syDsnkikDrk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LTzHzApY4xKPoJ5T17+YhjobaVZdwG3aF09ClgMTInr0jojpO2k4GKEbZS0rD/vis
	 02M+6pzheQ6OiyVu2NydcjO5oUzaHvNrR7SK3t5ct/pxW5LXfiYkZbA6RojKfkNnKv
	 X+aBZv1SM0K1Ad6Y33rBG9u/Q99JkMy3YSJjylMq9A/NVOYJSiNhw3XUWArT0ZWCTA
	 +u6lBr7MLmbfSk3fo7hdmE3agnfDu0E2kzTw2u8KXTImxzvlmx+seRHIZdptxdkfKA
	 CEvMd814c/E1lCYaINBis9veNaszkL51IPDQdNh49MZWUlTYoB8o5gvSmo4CHudICl
	 Azxl/IO5t/VGA==
Subject:
 Re: [PATCH net-next v4 6/7] net: dsa: motorcomm: Fix MIB synchronization
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 00:38:15 +0000
Message-ID: <179012389539.2160803.11576793357655961336@kernel.org>
In-Reply-To: <20260921203040.1203911-7-mmyangfl@gmail.com>
References: <20260921203040.1203911-7-mmyangfl@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit is titled "net: dsa: motorcomm: Fix MIB
  synchronization" and fixes a real defect in already-merged code (the…
- [Low] The new lock annotation in struct yt921x_mib (mib.h) says
  stats/rx_frames/tx_frames are "protected by syncp OR priv->reg_lock".

Pre-existing issues:
- [Medium] The driver's standard statistics interfaces disagree about
  frame-too-long errors.
- [Medium] yt921x_mib_read() publishes a partially refreshed snapshot
  when a register read fails.

--

net: dsa: motorcomm: Fix MIB synchronization

This converts the yt921x MIB accounting to u64_stats_sync, with
.get_stats64() using a seqcount retry loop and the other statistics
callbacks holding priv->reg_lock across both the register read and the
copy-out.  A new per-port u64 buffer collects the values from the bus
before they are published to the u64_stats_t counters in one short
write-side section.

> The previous MIB sync was based on the false assumption that 64-bit
> variables are always atomic. To fix that:

[Severity: Low]
The changelog describes a functional fix to already merged code, but the
trailer block only carries Signed-off-by and Reviewed-by.  Should there be
a Fixes: tag here?

The torn-counter behaviour being fixed comes from the initial driver
submission (drivers/net/dsa/motorcomm was added by 9c472a0d7c38), and the
phrase "The previous MIB sync" does not name a commit, so the fix cannot
be traced back or picked up for stable by tooling.

Related to that, the patch is not self-contained against the merged
driver: it relies on the u64_stats_t conversion from "net: dsa: motorcomm:
Use u64_stats_t for MIB stats" and on mib.c/mib.h created by "net: dsa:
motorcomm: Split MIB module" earlier in the series.  Could the changelog
mention that dependency?

> diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
> index 69b9eb7e52086..f5197c1d2d7f1 100644
> --- a/drivers/net/dsa/motorcomm/mib.c
> +++ b/drivers/net/dsa/motorcomm/mib.c

[ ... ]

> @@ -92,6 +94,8 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
>  	struct device *dev = to_device(priv);
>  	struct yt921x_mib *pm = pp->mib;
>  	struct yt921x_mib_stats *mib;
> +	u64 *buf = pm->data;
> +	unsigned long flags;
>  	u64 rx_frames;
>  	u64 tx_frames;
>  	int res = 0;
> @@ -101,7 +105,6 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
>  	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
>  		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
>  		u32 reg = YT921X_MIBn_DATA0(port) + desc->offset;
> -		u64_stats_t *valp = &((u64_stats_t *)mib)[i];
>  		u32 val0;
>  		u64 val;
>  
> @@ -110,7 +113,7 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
>  			break;
>  
>  		if (desc->size <= 1) {
> -			u64 old_val = u64_stats_read(valp);
> +			u64 old_val = buf[i];
>  
>  			val = (old_val & ~(u64)U32_MAX) | val0;
>  			if (val < old_val)
> @@ -124,9 +127,12 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
>  			val = ((u64)val1 << 32) | val0;
>  		}
>  
> -		u64_stats_set(valp, val);
> +		buf[i] = val;
>  	}
>  
> +	flags = u64_stats_update_begin_irqsave(&pm->syncp);
> +	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++)
> +		u64_stats_set(&((u64_stats_t *)mib)[i], buf[i]);

[Severity: Medium]
This isn't a bug introduced by this patch, but should the publication be
skipped when res is set?

The collection loop above leaves the loop on the first read error:

	res = yt921x_reg_read(priv, reg, &val0);
	if (res)
		break;

so pm->data[] holds a mix of freshly read entries and entries left over
from the previous poll.  The block below then copies all of buf[] into
pm->stats and recomputes pm->rx_frames/pm->tx_frames from that mixed
snapshot without checking res.

If the RX size histogram registers are read but the following
RX_GOOD_BYTES read fails, the published state has a nonzero rx_frames
with a stale (or zero) rx_good_bytes, and yt921x_dsa_get_stats64() then
computes:

	stats->rx_bytes = u64_stats_read(&mib->rx_good_bytes) -
			  ETH_FCS_LEN * stats->rx_packets;

which underflows and reports ~1.8e19 bytes to userspace until the next
successful poll.  The TX path does the same with tx_good_bytes.
yt921x_mib_poll() only lengthens the poll interval after the snapshot has
already been published.

The parent commit 84a3b42eff3c stored each value directly into pm->stats
inside the same break-on-error loop and recomputed the frame totals
unconditionally, so the mixed snapshot predates this change.

>  	rx_frames = u64_stats_read(&mib->rx_64byte) +
>  		    u64_stats_read(&mib->rx_65_127byte) +
>  		    u64_stats_read(&mib->rx_128_255byte) +
> @@ -143,6 +149,7 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
>  		    u64_stats_read(&mib->tx_jumbo);
>  	u64_stats_set(&pm->rx_frames, rx_frames);
>  	u64_stats_set(&pm->tx_frames, tx_frames);
> +	u64_stats_update_end_irqrestore(&pm->syncp, flags);
>  
>  	if (res)
>  		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",

[ ... ]

> @@ -269,6 +278,8 @@ yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
>  	/* mac_stats->InRangeLengthErrors */
>  	/* mac_stats->OutOfRangeLengthField */
>  	mac_stats->FrameTooLongErrors = u64_stats_read(&mib->rx_oversize_errors);
> +
> +	mutex_unlock(&priv->reg_lock);
>  }

[ ... ]

> @@ -354,39 +369,45 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
>  	struct yt921x_port *pp = &priv->ports[port];
>  	struct yt921x_mib *pm = pp->mib;
>  	struct yt921x_mib_stats *mib;
> +	unsigned int start;
>  
>  	if (!pm)
>  		return;
>  	mib = &pm->stats;
>  
> -	stats->rx_length_errors = u64_stats_read(&mib->rx_undersize_errors) +
> -				  u64_stats_read(&mib->rx_fragment_errors);
> -	stats->rx_over_errors = u64_stats_read(&mib->rx_oversize_errors);
> -	stats->rx_crc_errors = u64_stats_read(&mib->rx_crc_errors);
> -	stats->rx_frame_errors = u64_stats_read(&mib->rx_alignment_errors);
> -	/* stats->rx_fifo_errors */
> -	/* stats->rx_missed_errors */
> -
> -	stats->tx_aborted_errors = u64_stats_read(&mib->tx_aborted_errors);
> -	/* stats->tx_carrier_errors */
> -	stats->tx_fifo_errors = u64_stats_read(&mib->tx_undersize_errors);
> -	/* stats->tx_heartbeat_errors */
> -	stats->tx_window_errors = u64_stats_read(&mib->tx_late_collisions);
> -
> -	stats->rx_packets = u64_stats_read(&pm->rx_frames);
> -	stats->tx_packets = u64_stats_read(&pm->tx_frames);
> -	stats->rx_bytes = u64_stats_read(&mib->rx_good_bytes) -
> -			  ETH_FCS_LEN * stats->rx_packets;
> -	stats->tx_bytes = u64_stats_read(&mib->tx_good_bytes) -
> -			  ETH_FCS_LEN * stats->tx_packets;
> +	do {
> +		start = u64_stats_fetch_begin(&pm->syncp);
> +
> +		stats->rx_length_errors = u64_stats_read(&mib->rx_undersize_errors) +
> +					  u64_stats_read(&mib->rx_fragment_errors);
> +		stats->rx_over_errors = u64_stats_read(&mib->rx_oversize_errors);

[Severity: Medium]
This is a pre-existing mapping and not something this patch changes, but
do the two standard interfaces disagree about oversized frames?

yt921x_dsa_get_eth_mac_stats() reports the same hardware counter as the
IEEE attribute:

	mac_stats->FrameTooLongErrors = u64_stats_read(&mib->rx_oversize_errors);

while here rx_oversize_errors goes to rx_over_errors and is left out of
rx_length_errors, which only sums rx_undersize_errors and
rx_fragment_errors.

include/uapi/linux/if_link.h documents rx_length_errors as
"aInRangeLengthErrors + aOutOfRangeLengthField + aFrameTooLongErrors" and
rx_over_errors as a "Receiver FIFO overflow event counter".  With the
current mapping, oversized frames are missing from rx_length_errors and
show up as receive overruns in ip -s link.  The same assignment exists in
the parent commit 84a3b42eff3c.

> +		stats->rx_crc_errors = u64_stats_read(&mib->rx_crc_errors);
> +		stats->rx_frame_errors = u64_stats_read(&mib->rx_alignment_errors);
> +		/* stats->rx_fifo_errors */
> +		/* stats->rx_missed_errors */
> +
> +		stats->tx_aborted_errors = u64_stats_read(&mib->tx_aborted_errors);
> +		/* stats->tx_carrier_errors */
> +		stats->tx_fifo_errors = u64_stats_read(&mib->tx_undersize_errors);
> +		/* stats->tx_heartbeat_errors */
> +		stats->tx_window_errors = u64_stats_read(&mib->tx_late_collisions);
> +
> +		stats->rx_packets = u64_stats_read(&pm->rx_frames);
> +		stats->tx_packets = u64_stats_read(&pm->tx_frames);
> +		stats->rx_bytes = u64_stats_read(&mib->rx_good_bytes) -
> +				  ETH_FCS_LEN * stats->rx_packets;
> +		stats->tx_bytes = u64_stats_read(&mib->tx_good_bytes) -
> +				  ETH_FCS_LEN * stats->tx_packets;
> +		stats->rx_dropped = u64_stats_read(&mib->rx_dropped);
> +		/* stats->tx_dropped */
> +		stats->multicast = u64_stats_read(&mib->rx_multicast);
> +		stats->collisions = u64_stats_read(&mib->tx_collisions);
> +	} while (u64_stats_fetch_retry(&pm->syncp, start));

[ ... ]

> diff --git a/drivers/net/dsa/motorcomm/mib.h b/drivers/net/dsa/motorcomm/mib.h
> index d84ae2f449ac8..55719c29992ba 100644
> --- a/drivers/net/dsa/motorcomm/mib.h
> +++ b/drivers/net/dsa/motorcomm/mib.h
> @@ -125,13 +125,19 @@ struct yt921x_mib_stats {
>  	u64_stats_t tx_oam;
>  };
>  
> +#define YT921X_MIB_STAT_NUM	(sizeof(struct yt921x_mib_stats) / sizeof(u64_stats_t))
> +
>  struct yt921x_mib {
>  	struct yt921x_port *port;
>  
>  	struct delayed_work work;
> +	struct u64_stats_sync syncp;
> +	/* protected by syncp OR priv->reg_lock */

[Severity: Low]
Is the "OR" here accurate for writers?  It holds for readers, but
struct u64_stats_sync provides no mutual exclusion on its own:

include/linux/u64_stats_sync.h:
	static inline void u64_stats_init(struct u64_stats_sync *syncp) { }

and u64_stats_update_begin_irqsave()/u64_stats_update_end_irqrestore()
compile away on 64-bit, so a writer holding only syncp would be
unsynchronized.

The single writer, yt921x_mib_read(), actually needs both: its callee
yt921x_reg_read() has lockdep_assert_held_once(&priv->reg_lock), and the
publication is additionally wrapped in syncp.

Would something like "writers: priv->reg_lock + syncp; readers:
priv->reg_lock or syncp" describe the rule more precisely?

>  	struct yt921x_mib_stats stats;
>  	u64_stats_t rx_frames;
>  	u64_stats_t tx_frames;
> +	/* protected by priv->reg_lock */
> +	u64 data[YT921X_MIB_STAT_NUM];
>  };

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921203040.1203911-1-mmyangfl%40gmail.com
