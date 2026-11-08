Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794147751;
	b=CwNKDQCgOHJpvGwzepSYh4Gl+jEMOuUPG+g4TNZtqzG2YNZtFDGf1ka5WlGEPnHR/a/k
	 qMuaruYNnPRnDbc1LvRtAjLeEiy4czqEW7j3tA9FRosQsmFB6p9gkMD9URbciY1VhMH5Q
	 uk0Ew6yFHnKLnCYvdOMGzytjep+8wB3ntp99x4I3rF7WcrnfY3JOZvV+ozs2GdKtLSsSe
	 D5fI47QQQ8oBUNE3TmAmUAlbzjhRxOOevmbIIhOl2G36o0m+9ZkwWYjPKf/UdfhoR+QrZ
	 CdrWJfUe65+hQrK+71s9L4rPAswr0+IE6nLi/qBipo6leQrt4LJHsoEcCNcRVjiQIQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794147751;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fUywiKXXN/V3F+l82UiHx52+o3PjfSdqOH9DT5EWWTI=;
	b=QSvM2cVTOJhzDoIwBg3b87q8naOfI2NOztVw5Hj7nHy/PPXrr4AnKVutRgJxSAzdnH9u
	 k17UkIsxqt2Wl9vXP68AOpducpz72m2Y+ufRMXd0ZZJ9XrkLNaRWFBqIRhoYogKgHmMjl
	 KAyIHBbc1YylG5EkSWnKQsJ8fCYwEpVy4A67/BrfhycbuKxlby75TgHqDH29COG1LJEb+
	 9hi9/k4oUEZCEA+UWMu0/+kgkyd0D4NYLc9h+a9hmbQ8gKzNirH5CHazRMnXd4ujgNo2k
	 zvWHUfRZ3nF5CHj7JaXbMg32xgQFw2XNwe3SUY5LCB9HwdKAwH2S+zD0cBYarZyepIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="h/8LRd4+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA1A606A33B;
	Sun,  8 Nov 2026 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h/8LRd4+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC8D1F008A2;
	Sun,  8 Nov 2026 14:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794147751;
	bh=fUywiKXXN/V3F+l82UiHx52+o3PjfSdqOH9DT5EWWTI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h/8LRd4+CUZDoAdlV6u3kX8f0bUGvFi7CFrlOgNZFrsGtjrQcbkoZSozka35o9E6J
	 1hAJ1MC7nIruxj8AOfSX+gRXDTuKxqpcY0ZgDqi6ZolrkUCfPnTtJRtJidm0vYxfKa
	 mrB6EZkSpKTavxXUnX9A7hTXv8xFBpXcO4DqMv634pEjxf9x0o8+aya4ouRypNf8Qk
	 cBQLipXv+c6C/L8YiY9383q25YUITXCNVumRgix3PsrhJ/oJY9a3C2OIBj0vmlE3kp
	 v+z/fEXDNsOZlrMmtmiL+P8HDn5QbI2hbeXVGbhc6Kuh5RjWbgFfBBnHpv0/FJkJND
	 RnonzompQVG9Q==
Subject: Re: [PATCH net-next 4/4] net: dsa: motorcomm: Prevent
 rx_bytes/tx_bytes underflow
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Sun, 08 Nov 2026 14:22:30 +0000
Message-ID: <179414775002.994134.7455494233393510720@kernel.org>
In-Reply-To: <20261107132040.1066996-5-mmyangfl@gmail.com>
References: <20261107132040.1066996-5-mmyangfl@gmail.com>
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

- [Medium] yt921x_counter_read() (drivers/net/dsa/motorcomm/smi.c)
  returns a false -EIO for a valid read.
- [Low] The commit fixes a user-visible bug: rtnl_link_stats64
  rx_bytes/tx_bytes (as shown by `ip -s link`) can read as about 2^64…

--

net: dsa: motorcomm: Prevent rx_bytes/tx_bytes underflow

This commit stops yt921x_mib_read() from publishing a partially refreshed
MIB buffer when a register read fails. It moves the rx_bytes/tx_bytes
derivation (good_bytes - ETH_FCS_LEN * frames) into the writer under
priv->reg_lock, and publishes the result only when check_sub_overflow()
reports no underflow. yt921x_dsa_get_stats64() then copies the published
values.

> diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
> index b45bc82117412..cb3912493cfb1 100644
> --- a/drivers/net/dsa/motorcomm/mib.c
> +++ b/drivers/net/dsa/motorcomm/mib.c

[ ... ]

> @@ -124,6 +126,12 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
>  		}
>  	}
>  
> +	if (res) {
> +		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
> +			port, res);
> +		return res;
> +	}
> +

[Severity: Medium]
With this early return, any error from yt921x_counter_read() now throws
away the whole sample. Can yt921x_counter_read() return -EIO for a read
that is actually consistent?

drivers/net/dsa/motorcomm/smi.c:yt921x_counter_read() {
	...
	res = yt921x_reg_read(priv, reg, &old_lo);
	...
	res = yt921x_reg_read(priv, reg + 4, &hi);
	...
	res = yt921x_reg_read(priv, reg, &lo);
	...
	if (lo < old_lo) {
		u32 new_hi;

		res = yt921x_reg_read(priv, reg + 4, &new_hi);
		...
		if (new_hi != hi + 1)
			return -EIO;
		hi = new_hi;
	}
	...
}

Suppose the low word wraps after old_lo is read but before hi is read.
Then hi and lo are both post-wrap values and already form a valid 64-bit
counter. For example:

  old_lo = 0xfffffff0, hi = H + 1, lo = 0x10, new_hi = H + 1

In this case new_hi == hi, so the check fails and -EIO is returned.

The affected counters are the 64-bit rx_good_bytes, rx_bad_bytes and
tx_good_bytes. Their low words wrap about every 34 seconds at 1 Gb/s
line rate.

When this happens, yt921x_mib_read() logs "Failed to read stats for port
N: -5" and discards the sample. yt921x_mib_poll() then pushes the next
poll back from 3 to 12 seconds:

	if (res)
		delay *= 4;

The ethtool callbacks that ignore the return value would quietly report
the previous sample.

The reader came in with the earlier "net: dsa: motorcomm: Use safe 64-bit
counter reader" commit in this series, but the error only becomes visible
through this patch's discard path.

Could yt921x_counter_read() also accept new_hi == hi? Another option is a
hi/lo/hi2 sequence that re-reads lo when hi changes.

[ ... ]

> @@ -389,10 +400,8 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
>  
>  		stats->rx_packets = u64_stats_read(&pm->rx_frames);
>  		stats->tx_packets = u64_stats_read(&pm->tx_frames);
> -		stats->rx_bytes = u64_stats_read(&mib->rx_good_bytes) -
> -				  ETH_FCS_LEN * stats->rx_packets;
> -		stats->tx_bytes = u64_stats_read(&mib->tx_good_bytes) -
> -				  ETH_FCS_LEN * stats->tx_packets;
> +		stats->rx_bytes = u64_stats_read(&pm->rx_bytes);
> +		stats->tx_bytes = u64_stats_read(&pm->tx_bytes);

[Severity: Low]
This fixes rx_bytes/tx_bytes in rtnl_link_stats64 reading as about 2^64,
which users can see with ip -s link. Should the commit carry a Fixes: tag?

The unchecked subtraction dates back to the initial driver commit:

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")

Later, 25265e7ccdb5 ("net: dsa: motorcomm: Split MIB module") moved it,
and e7b23688d0d3 and ed4453587dc0 rewrote it, but none of them guarded
it against underflow. The driver has been in released kernels since late
2025.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107132040.1066996-1-mmyangfl%40gmail.com
