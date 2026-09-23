Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BE830596F;
	Wed, 23 Sep 2026 00:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790123908; cv=none; b=tsVBK9W6UVStyzTPmCytWwZE7VH9tCNOuQ5PsBCYhRMIoZtTXXECbJYVh5XkpvKIusu5GZAog5zq9drXOO0dAxtujdEUTaQ9+fHprX1UVUVx7dMgs7uBpaV3CMNAHQll8WzLmKOpryylbtjf9GSU8P8gQY1xXrymK6Y/oj1eH/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790123908; c=relaxed/simple;
	bh=6m4/tYLSMtUE6xWiidgdYspvG6h4ajBWYFz7anU1mNk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kNa8VrSEIGLmlaKMzmvTFA6bQ82wFUolCA+JJIjMCYOUD4JpyzytsJ2MOFNaDyDke3u9FbZapaDa9NPNIc187K4EY4dPYERXSJLko2wy57RfeluBNOnaKmEoqKgpnC7wU2LqhbO7OImbLsOjxYbyZUdp6MY3Uo3gOxGFPwKs8kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3cmHzTa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3cmHzTa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002621F00898;
	Wed, 23 Sep 2026 00:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790123897;
	bh=hLkG++QHTjJ7Oh3UWYNhSMr7R1fjqA5mOa80uTuUV5I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=O3cmHzTaytc0C0QtuXS5xcKfM4jxoM2EP6+sGMEf7eEF8EFUoy6pFAgBP9vqc62Kw
	 wwMW/l7Lp9jj+5dKblXEllQFUAj3WHbsHwq6M+eEiXRkn6LjT3pXbqRABRw+LedKUY
	 FoJ2NQGQ17plopvEoCok+gkmxj5QPeeiyyjEXT7W8LXS7+QdUoDPpG76W/2ZEfwy+5
	 e8QUF/9YL5QGyRNOIg9pcE5ubx9S339DfGiv2mZpXCKEBFAFSP84uKhfJWaJ+13Yiq
	 CPpP2WZJQXawB2O8ZAjWdZRtVwDMMYWVKf/WmzH5eOWFJtlIZ4DVSe4a7gmHVw1los
	 3UWoNgaU3+7/Q==
Subject: Re: [PATCH net-next v4 7/7] net: dsa: motorcomm: Use safe 64-bit
 counter reader
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 00:38:16 +0000
Message-ID: <179012389655.2160803.8520948236825859185@kernel.org>
In-Reply-To: <20260921203040.1203911-8-mmyangfl@gmail.com>
References: <20260921203040.1203911-8-mmyangfl@gmail.com>
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

- [Low] The commit fixes a real, user-visible statistics bug (spurious ~4
  GiB jumps in the 64-bit MIB byte counters…
- [Low] The new exported helper yt921x_counter_read() (declared in
  smi.h:38) documents nothing beyond "/* Reliably read a 64bit counter…

Pre-existing issues:
- [Medium] yt921x_mib_read() publishes a mixed stats snapshot on
  register-read failure.
- [Medium] The software MIB shadow buffer pm->data[] is zeroed only once,
  at devm_kzalloc() time in yt921x_dsa_port_setup() (chip.c:3781), while…

--

net: dsa: motorcomm: Use safe 64-bit counter reader

This adds yt921x_counter_read() to smi.c and switches the 64-bit MIB
descriptors in yt921x_mib_read() over to it, so the low word is re-read
after the high word and retried until it no longer goes backwards.  The
previous code read low then high once and recombined them.

A few questions below.

> net: dsa: motorcomm: Use safe 64-bit counter reader
>
> 64-bit counter registers are read as two separate 32-bit transactions.
> If the low word wraps from about 0xffffffff to a small value while the
> high word increments between the two transactions, the recombined value
> becomes ((new_high << 32) | old_low), producing a spurious ~4 GiB jump.
>
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

[Severity: Low]
The changelog describes a user-visible defect: the 64-bit byte counters
(rx_good_bytes, rx_bad_bytes, tx_good_bytes) reported through
.get_stats64, .get_eth_mac_stats and ethtool -S can jump by about 4 GiB.

The unsafe two-transaction read being replaced here came in with
186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x"),
which is in released kernels.  At the baseline the pre-series form was:

drivers/net/dsa/motorcomm/chip.c:
	res = yt921x_reg_read(priv, reg + 4, &val1);
	...
	val = ((u64)val1 << 32) | val0;

Should this carry a Fixes: 186623f4aa72 tag so it gets picked up for
stable?  As written, the subject reads as a cleanup rather than a
correctness fix.  Other fixes in this driver already use the tag, for
example cc2d273893db carries Fixes: 9af9a8168213.

> diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
> index f5197c1d2d7f1..2786d9ec29320 100644
> --- a/drivers/net/dsa/motorcomm/mib.c
> +++ b/drivers/net/dsa/motorcomm/mib.c
> @@ -105,29 +105,26 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
>  	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
>  		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
>  		u32 reg = YT921X_MIBn_DATA0(port) + desc->offset;
> -		u32 val0;
> -		u64 val;
> -
> -		res = yt921x_reg_read(priv, reg, &val0);
> -		if (res)
> -			break;
>  
>  		if (desc->size <= 1) {
>  			u64 old_val = buf[i];
> +			u32 val0;
> +			u64 val;
> +
> +			res = yt921x_reg_read(priv, reg, &val0);
> +			if (res)
> +				break;
>  
>  			val = (old_val & ~(u64)U32_MAX) | val0;
>  			if (val < old_val)
>  				val += 1ull << 32;

[Severity: Medium]
This isn't a bug introduced by this patch, but while the ~4 GiB jump
class is being addressed, does the same artifact remain reachable here
through the shadow buffer?

The wrap extension above assumes pm->data[] still mirrors the hardware
counters.  pm->data[] is zeroed exactly once, at devm_kzalloc() time in
yt921x_dsa_port_setup(), but the hardware MIB block is cleared on every
ds->setup, in yt921x_chip_setup():

	/* Clear MIB */
	ctrl = YT921X_MIB_CTRL_CLEAN | YT921X_MIB_CTRL_ALL_PORT;
	res = yt921x_reg_write(priv, YT921X_MIB_CTRL, ctrl);

ds->setup can run twice for one device.  Unbinding another switch in the
same tree goes through dsa_switch_remove() -> dsa_tree_teardown(dst),
and a later dsa_switch_probe() -> dsa_tree_setup() calls
yt921x_dsa_setup() again on the surviving chip.  yt921x_dsa_port_setup()
already anticipates that path:

	if (pm) {
		enable_delayed_work(&pm->work);
	} else if (...) {
		pm = devm_kzalloc(dev, sizeof(*pm), GFP_KERNEL);

Nothing on that path re-zeroes pm->data[], which seems to contradict the
"MIB buffer must be zeroed before" contract comment.  On the first poll
after re-setup, val0 is small while old_val is large, so
"if (val < old_val) val += 1ull << 32" credits a phantom 2^32 to every
32-bit MIB of every port, and the 64-bit counters read through
yt921x_counter_read() go backwards.  Would zeroing pm->data[] on the
re-setup path close that?

> -		} else {
> -			u32 val1;
>  
> -			res = yt921x_reg_read(priv, reg + 4, &val1);
> +			buf[i] = val;
> +		} else {
> +			res = yt921x_counter_read(priv, reg, &buf[i]);
>  			if (res)
>  				break;
> -			val = ((u64)val1 << 32) | val0;
>  		}
> -
> -		buf[i] = val;
>  	}
>  
>  	flags = u64_stats_update_begin_irqsave(&pm->syncp);

[Severity: Medium]
This is a pre-existing issue, but the new helper interacts with it, so
it may be worth a look: what is published when the loop breaks early?

On error the loop does break, so buf[i..N-1] keep their previous values.
yt921x_counter_read() only assigns *valp in the success branch:

		if (lo >= old_lo) {
			*valp = ((u64)hi << 32) | lo;
			return 0;
		}

The publication block right after the loop runs unconditionally, with no
"if (res)" bail-out:

	flags = u64_stats_update_begin_irqsave(&pm->syncp);
	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++)
		u64_stats_set(&((u64_stats_t *)mib)[i], buf[i]);

So a fresh rx frame-size count (which feeds pm->rx_frames) can be
committed together with a stale rx_good_bytes if the failure lands on the
rx_good_bytes descriptor.  yt921x_dsa_get_stats64() then does:

	stats->rx_bytes = u64_stats_read(&mib->rx_good_bytes) -
			  ETH_FCS_LEN * stats->rx_packets;

with no underflow guard.  On the first poll after probe, pm->data is
still zeroed, so rx_bytes reported by ip -s link would be around 1.8e19.
yt921x_reg_read() reaches __mdiobus_read() via yt921x_reg_mdio_read(),
which can return a negative errno on a transient bus error, so the path
looks reachable.  Would skipping the publish loop when res is set avoid
the mixed snapshot?

> diff --git a/drivers/net/dsa/motorcomm/smi.c b/drivers/net/dsa/motorcomm/smi.c
> index bf3adfd64165a..27086602997bb 100644
> --- a/drivers/net/dsa/motorcomm/smi.c
> +++ b/drivers/net/dsa/motorcomm/smi.c
> @@ -63,6 +63,36 @@ int yt921x_reg_update_bits(struct yt921x_priv *priv, u32 reg, u32 mask, u32 val)
>  	return yt921x_reg_write(priv, reg, u);
>  }
>  
> +/* Reliably read a 64bit counter */
> +int yt921x_counter_read(struct yt921x_priv *priv, u32 reg, u64 *valp)
> +{
[ ... ]
> +	for (int i = 0; i < 16; i++) {
> +		res = yt921x_reg_read(priv, reg + 4, &hi);
[ ... ]
> +	return -ETIMEDOUT;
> +}

[Severity: Low]
This isn't a bug, but the helper's contract is only visible from its
body.  It hardcodes low word at reg, high word at reg + 4, exactly two
32-bit words, and a counter that is free running, monotonically
non-decreasing and not cleared by reads.  Could the comment spell those
out, given the prototype is exported driver-wide in smi.h with no width
parameter?

The call site in yt921x_mib_read() routes every descriptor with
desc->size > 1 here without passing desc->size, so the descriptor table's
declared width and the helper's fixed two-word layout are two independent
sources of truth.  Today the table only contains MIB_DESC(2, ...)
entries, so nothing is misread, but a size == 3 descriptor would be
silently truncated.

Also, where does the retry bound of 16 come from?  Exhausting it returns
-ETIMEDOUT, which yt921x_mib_read() treats as a hard I/O error (it breaks
out of the descriptor loop) and yt921x_mib_poll() turns into a 4x poll
backoff:

	if (res)
		delay *= 4;

The resulting 12 s interval stays well under the ~100 s overflow bound
named in the comment in mib.c, so this looks harmless, but a word on why
16 is enough would help.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921203040.1203911-1-mmyangfl%40gmail.com
