Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794147750;
	b=t6nBxBCSHaI5mywXb/QjTqqEPVl3gZItVqS57FosR61Mr2J5fBuMgiiwJ2qpGMEov9ol
	 BffYBROCX6PpkLLE2xHb52pf5uabTc+wukbMCdvVeiNh6meBckh5V65PjqOw1k+RnFP8+
	 DQiaI0zFEg1FuhtR/2eIwb2IRYrVOTw4DrMVRuSGOVI0O+52b48Q2lXpX4TJxgnjCbg2O
	 DY0pIFrrvfktdkVea4/EQSRWTprP19Ll2e1uGV0r36/PBMDz1pTafEoREWyoq1Ky+YZNE
	 V8W11Eu8OuSThFiV9Tny7qI3XBkESexXOIvPluURX+iB8DXnS/3w34YLmoQLA0otIYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794147750;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=8nSnyp4qIY+eMxZ+jWwWlVQJaqb6UKomcauQ+sOlv74=;
	b=mz9VcawaIUXe4NQUKbvI1KY/vpNN4rYaxqCMKRdwHkWBhPDtnhygiIIf/PhwSz1QcJN1
	 QVJ69REEGshLDFe2ZST3kMhCPvHEkjcpli8OgHy8waTfNQ/YAJYcnh3QspM8ZvqhhPcn5
	 Buc44CnaL040bhaYO5JvwUh/2JG2FuTPvKkRVC9psxpLrNZORfLX7hOJhj2tUGuZD/iN2
	 DkEoNwi3uU9yqBtIbMeUrEN0PRQ1SbQVbeE0d24x3Hv4SrrBe5TuT5sF+O0IQNL/E7bQL
	 1B7YDvfRTr7PwOQqQG0jJG6or8SUX2lhOXYMEYu/4YWI654DJdodclmqOVZ6yH0hekg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BR6d+siC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F965606A331;
	Sun,  8 Nov 2026 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BR6d+siC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6720C1F0089F;
	Sun,  8 Nov 2026 14:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794147749;
	bh=8nSnyp4qIY+eMxZ+jWwWlVQJaqb6UKomcauQ+sOlv74=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BR6d+siCVXoHe+4BaQgvXxUzZKyolUL4fCaEOmHQuNmqygG+idw61mbvLKmiyxX9A
	 5iyZg9dRKtZTo3J6mV9F9zhEsvysqNOvQwveT1o2nSqmUzI6pbOe6Ta6Rf5v5nZeMc
	 mfWsgb0wcJt/0HPbEf4K5YptCnnWeEriaSBgzcIGxd7i8adg0RgzrJkqd9VxUkNNsy
	 LdJVPw2n72R9d0whtwE8Yyv8/fo9r4NZxfVciO8ck/S2WaAtMz5ICSj6vZHx1E2xIC
	 IB59w4T/7aIQMIMESwAr1VrMRNJx512GnptBeEjnufF1R26lH35jirI7klk7aw15h9
	 IMFZ41N1FIW7Q==
Subject:
 Re: [PATCH net-next 3/4] net: dsa: motorcomm: Use safe 64-bit counter reader
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Sun, 08 Nov 2026 14:22:29 +0000
Message-ID: <179414774900.994134.836318177639068785@kernel.org>
In-Reply-To: <20261107132040.1066996-4-mmyangfl@gmail.com>
References: <20261107132040.1066996-4-mmyangfl@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] yt921x_counter_read() in drivers/net/dsa/motorcomm/smi.c
  returns a false -EIO for half of the low-word wraps that race with a…
- [Low] "net: dsa: motorcomm: Use safe 64-bit counter reader" fixes a
  user-visible bug, a transient ~4 GiB jump in the 64-bit RX/TX good-…

--

net: dsa: motorcomm: Use safe 64-bit counter reader

This commit changes how yt921x_mib_read() reads the 64-bit MIB counters.
The old code read the low word and then the high word. That is replaced
with a new helper, yt921x_counter_read(), which reads the low word again
and reads the high word again if the low word wrapped. The aim is to
avoid a spurious ~4 GiB jump when the low word wraps between the two
reads.

> diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
> index 90b0ef670aa31..b45bc82117412 100644
> --- a/drivers/net/dsa/motorcomm/mib.c
> +++ b/drivers/net/dsa/motorcomm/mib.c
> @@ -102,29 +102,26 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)

[ ... ]

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

[Severity: Low]
The commit fixes a user-visible problem: a transient ~4 GiB jump in the
64-bit good-bytes and bad-bytes counters. That jump shows up in ethtool -S
and rtnl_link_stats64. Should it carry a Fixes: tag?

The read removed here, which takes the low word and then the high word in
two separate transactions, has been in the driver since it was added in
drivers/net/dsa/yt921x.c. It was later moved into
drivers/net/dsa/motorcomm/mib.c by 25265e7ccdb51b. That would suggest:

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")

> diff --git a/drivers/net/dsa/motorcomm/smi.c b/drivers/net/dsa/motorcomm/smi.c
> index bf3adfd64165a..16f62409422d5 100644
> --- a/drivers/net/dsa/motorcomm/smi.c
> +++ b/drivers/net/dsa/motorcomm/smi.c
> @@ -63,6 +63,41 @@ int yt921x_reg_update_bits(struct yt921x_priv *priv, u32 reg, u32 mask, u32 val)
>  	return yt921x_reg_write(priv, reg, u);
>  }
>  
> +/* Reliably read a 64-bit counter, assuming the counter isn't that "fast" */
> +int yt921x_counter_read(struct yt921x_priv *priv, u32 reg, u64 *valp)
> +{
> +	u32 old_lo;
> +	int res;
> +	u32 hi;
> +	u32 lo;
> +
> +	res = yt921x_reg_read(priv, reg, &old_lo);
> +	if (res)
> +		return res;
> +
> +	res = yt921x_reg_read(priv, reg + 4, &hi);
> +	if (res)
> +		return res;
> +
> +	res = yt921x_reg_read(priv, reg, &lo);
> +	if (res)
> +		return res;
> +
> +	if (lo < old_lo) {
> +		u32 new_hi;
> +
> +		res = yt921x_reg_read(priv, reg + 4, &new_hi);
> +		if (res)
> +			return res;
> +		if (new_hi != hi + 1)
> +			return -EIO;

[Severity: Medium]
Can this return -EIO for a read that is actually consistent?

The reads happen in this order:

  t0: old_lo = [reg]
  t1: hi     = [reg + 4]
  t2: lo     = [reg]
  t3: new_hi = [reg + 4]   (only if lo < old_lo)

lo < old_lo only shows that the low word wrapped somewhere between t0 and
t2.

If the wrap happens between t1 and t2, then hi == H and new_hi == H + 1,
so the check passes.

If the wrap happens between t0 and t1, the carry is already in the high
word when hi is read. Then hi == H + 1 and new_hi == H + 1 == hi. The
(hi, lo) pair is a valid snapshot, but new_hi != hi + 1 rejects it with
-EIO.

The t0..t1 window is one SMI transaction, the same size as the t1..t2
window. So roughly half of the wraps that race with a read would take
this path. At 1 Gb/s the low words of the good-bytes and bad-bytes
counters wrap about every 34 seconds.

When it happens, yt921x_mib_read() breaks out of its descriptor loop, so
the remaining counters for that port are not refreshed. The partially
refreshed buffer is still published, and this message is logged:

  Failed to read stats for port N: -5

In addition, yt921x_mib_poll() backs off:

	if (res)
		delay *= 4;

That moves the poll interval from 3 seconds to 12 seconds, for a bus
error that never occurred.

The later "net: dsa: motorcomm: Prevent rx_bytes/tx_bytes underflow"
change drops the whole sample for that cycle instead. It does not touch
yt921x_counter_read(), so the false -EIO is still present after it.

Would it work to accept new_hi when it equals either hi or hi + 1 and
pair it with lo? Another option is a hi/lo/hi read that retries while
the two hi values differ.

> +		hi = new_hi;
> +	}
> +
> +	*valp = ((u64)hi << 32) | lo;
> +	return 0;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107132040.1066996-1-mmyangfl%40gmail.com
