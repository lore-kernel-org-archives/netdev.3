Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700915;
	b=j4j8ohSXM65/TQ2uYTrS6pCk2lwfIsU8Jaxp0+naueFkpmFECtFyI0M0lgeWBSFBNb1p
	 GbvaDO6nqQJilM0+MPulvovFPZC9cPZtW4F4Fqekif62sziiDflLp34oxBCPF9I94a8at
	 FojoC/doHyjGHI2Dw620+xQR9C0oi7el8AP5PsmJvQ+a0DXZlV51OHcSyAdACQD995oHn
	 jSVIXBN31gn7k8fCy+eqZtaU1+KFO8MwB+ZjwO9sW9Yv3KwJeDBNASL04dC2eBAz+Pmk9
	 gE0SfBAoEjXqyDNQBIu/rpDqh80ijM3qHSvV4KynnKQGSgBa4nVxxAfShxbXdOnqMkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700915;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=KflOFbLY5u9mx0Muoa8qC0v11tzTAKkxWAovm53vbYg=;
	b=UCji4k3I8tJtRWCvCfk+uuJxrFwCXgZNXJs9spLtJKlT5GOL+BaZhoJNBoNB5JVuQiWY
	 z7lF4HUbSrU/0cwvGCVHiCr8RV7/L9UjKs48n+2b9t5lHXTXBCtgTqIQhSHo9R/c3Zwz4
	 G4/InD5cyDSjiSwQ3HL+n5uzLYBSh42ga1E9hFHbJFIW+q0xtFDx7vFGOP8pqhoL8IL7z
	 Z8feRCe1fpJC5Qub04yXkqobM8bZkGuoRDnfK1lbpclWYAd8fu6Bk71mpCqoLeoRYx+8D
	 IcNr/yMdu724R9mc0NU9qnv5NEHKkxZG1vNOcdXfZDUwe3lbE6VKMG+SdVRadoPEFiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hsTsu43x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B226606C563;
	Tue,  3 Nov 2026 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hsTsu43x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D3F1F000C1;
	Tue,  3 Nov 2026 10:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700914;
	bh=KflOFbLY5u9mx0Muoa8qC0v11tzTAKkxWAovm53vbYg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hsTsu43xgYhCVYi/HFHrb7jTce6hd/qxecG53zTDVkpWJNmiWAZwqSsUfeu42QqNe
	 ycwS/gpVfBo93PHe3OOurrVpgwDLOFkoZxRtufL6NQ4Y4htLrm+ulw9r6oIWONw6vT
	 QIAP4gtQbuiYuS8V0le/97OnBOVDoMbCCdvZUbQgXEMO5ogjoZBj2q3GD8tN/zexAL
	 OO5q4axH68Brh57AwL6NsEgeJPr4dtubg6eRofNpaWspmki8o5SEqNCEHGrz3ZEK+L
	 Hr5eXIgxYoCQhKw8zg/zxXhkdepaG1gufJahNbIcdZWPzu1QUnuYVuIPIDqlkZvsbH
	 4R1mc2+ebp3mA==
Subject:
 Re: [PATCH net] net: dsa: motorcomm: Do not publish partial MIB sample
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 10:15:13 +0000
Message-ID: <179370091371.488856.10191220263144152711@kernel.org>
In-Reply-To: <20261102101334.3525485-1-mmyangfl@gmail.com>
References: <20261102101334.3525485-1-mmyangfl@gmail.com>
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

- [Medium] On weakly ordered 64-bit kernels (arm64, riscv64, ppc64),
  yt921x_dsa_get_stats64() can still combine a new packet count with an…

--

net: dsa: motorcomm: Do not publish partial MIB sample

This patch changes yt921x_mib_read() so that it returns early when a
register read fails. Previously the partially refreshed buffer was copied
into the published u64_stats counters anyway. Now the last complete sample
is kept.

> diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
> index 6b170fc6e1875..bbcc418fcc871 100644
> --- a/drivers/net/dsa/motorcomm/mib.c
> +++ b/drivers/net/dsa/motorcomm/mib.c
> @@ -127,6 +127,12 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
>  		buf[i] = val;
>  	}
>  
> +	if (res) {
> +		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
> +			port, res);
> +		return res;
> +	}
> +
>  	flags = u64_stats_update_begin_irqsave(&pm->syncp);
>  	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++)
>  		u64_stats_set(&((u64_stats_t *)mib)[i], buf[i]);

[Severity: Medium]
Can yt921x_dsa_get_stats64() still pair a new packet count with an old
byte count on weakly ordered 64-bit machines, even when every register
read succeeds?

On 64-bit kernels, u64_stats_update_begin_irqsave() and
u64_stats_update_end_irqrestore() do no sequencing. u64_stats_set() is a
plain store. This loop stores rx_good_bytes and tx_good_bytes, and then
pm->rx_frames and pm->tx_frames are stored further down with no barrier
between them.

The reader does not take priv->reg_lock. On 64-bit,
u64_stats_fetch_begin() returns 0 and __u64_stats_fetch_retry() always
returns false:

drivers/net/dsa/motorcomm/mib.c:yt921x_dsa_get_stats64() {
    ...
	stats->rx_packets = u64_stats_read(&pm->rx_frames);
	stats->tx_packets = u64_stats_read(&pm->tx_frames);
	stats->rx_bytes = u64_stats_read(&mib->rx_good_bytes) -
			  ETH_FCS_LEN * stats->rx_packets;
    ...
	} while (u64_stats_fetch_retry(&pm->syncp, start));
}

On arm64, riscv64 or ppc64, the stores in yt921x_mib_read() and the loads
in yt921x_dsa_get_stats64() can both be reordered. This applies when the
read comes from yt921x_mib_poll() or from an ethtool-triggered
yt921x_mib_read(). The reader can then see the fresh rx_frames together
with the previous rx_good_bytes.

When ETH_FCS_LEN * new_frames is larger than old_good_bytes, the unsigned
subtraction wraps to about 2^64. Two cases where that holds:

  - the first publication after the per-port stats are allocated, when
    the old byte counters are still zero
  - a burst of traffic on a port that was mostly idle

This is the same symptom the commit message describes:

  "mixing fresh packet counters with stale byte counters; get_stats64 then
  subtracts ETH_FCS_LEN per packet from the stale byte counter and
  underflows on unsigned arithmetic."

The patch removes the read-failure trigger. A complete published sample
still doesn't give the reader a consistent view of several fields on
64-bit, though.

Would it make sense to clamp the subtraction in yt921x_dsa_get_stats64()?
Another option is to compute the FCS-adjusted byte counts in
yt921x_mib_read() and publish those instead.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102101334.3525485-1-mmyangfl%40gmail.com
