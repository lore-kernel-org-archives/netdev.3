Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABF5569F22;
	Wed,  9 Sep 2026 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966980; cv=none; b=BNhsNQ0fVV6fjYzSffdnUmC/mtTpy0DMEo4p8YKsjdYitcLL2iio9AsKfNUkQuxsQ6aGoUR4VvYgCwBaj3ogCU72xi1pqZO15aYHAi6eDs48VJtBFquZgM0Lodu+sT7Ikx2Bn4y1HVHHy1c5Ix5pejWHi3HXBXMcRepLenrG15A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966980; c=relaxed/simple;
	bh=dJ2Le3PydN84/3BZe999fi5knUegRyP+1nNxaDkeioA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gGLVgpnHPAgT+PGkBBwPnjiOuodDPOvuXD6ffb3FqNHrU/S/HkJWM2vncqWSOXKS4RZ7jGodKjbL6zBscYOSzE3LpjRQJG+7onLjyK6mfBKD0w8/wjhQJnJjTZmHsp+9E7u2qWwUo5X2/iZ3poDJncsnRO+ZN9cFBTSotLQNNjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mi5Pr10b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mi5Pr10b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871D41F00A3D;
	Wed,  9 Sep 2026 15:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966979;
	bh=kaBOWFbypfEUUVt3HXOgSqAn7URPHV8QcTSyF/H4c9U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mi5Pr10bwdUAGnRr+TZCG1Y9UbmpBIZF26Cs1cc29lweH9+K6o0zQ3cJWlmU/+JpU
	 RLk06eLg0GIIXAEXUp+L1CEnPPytrch3g0yEocgA7ZzriMBKucacyUiaIAsXcSib4T
	 R4bMIXQxmpRi4ddYm0mL2mn7qK94/BrhRuTdICTLmsRNmGTlE8y4iYiXpREi88Rfv9
	 aCZJ7BDIKMjglYYkh5hPBCjYYDEe9/DaVWj1pt6XN3MayKei+Rywg6oXUwZ29G343G
	 5NQFUsgYImIFK4tQi0fPBYihQgKwTPMf+B62wxB2bHmXeCu2SzZmqMXfOf732XzhnC
	 3rnIzzQY7pu0g==
Subject: Re: [PATCH net-next v3 6/6] net: dsa: motorcomm: Use safe 64-bit
 counter reader
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Date: Wed, 09 Sep 2026 15:16:18 +0000
Message-ID: <178896697810.219967.14368913869844106724@kernel.org>
In-Reply-To: <20260906131414.2683362-7-mmyangfl@gmail.com>
References: <20260906131414.2683362-7-mmyangfl@gmail.com>
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

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] The patch is a functional bug fix (it removes spurious ~4 GiB
  jumps in the 64-bit MIB byte counters that are exported to userspace)…

--

net: dsa: motorcomm: Use safe 64-bit counter reader

This switches the multi-word MIB counters in yt921x_mib_read() over to a
new helper, yt921x_counter_read(), which re-reads the low word after the
high word and retries until the pair is consistent. The single-word path
keeps its existing software wrap extension.

> diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
> index 8601d25fe9887..cfae2977a77b9 100644
> --- a/drivers/net/dsa/motorcomm/mib.c
> +++ b/drivers/net/dsa/motorcomm/mib.c
> @@ -102,29 +102,26 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
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

[Severity: Low]
Should this hunk carry a Fixes: tag and a stable Cc?

The commit message describes a concrete user-visible misbehaviour
("producing a spurious ~4 GiB jump"), and the racy sequence it replaces is
already in a released kernel. At the baseline the same code lives in
drivers/net/dsa/motorcomm/chip.c:yt921x_mib_read():

	res = yt921x_reg_read(priv, reg, &val0);
	...
		res = yt921x_reg_read(priv, reg + 4, &val1);
		if (res)
			break;
		val = ((u64)val1 << 32) | val0;

git blame attributes that two-transaction read to 186623f4aa724c ("net:
dsa: Add Motorcomm YT921x DSA switch support"), and the earlier patches in
this series only moved it from chip.c into mib.c:yt921x_mib_read().

The affected entries are the desc->size > 1 counters, i.e. rx_good_bytes,
rx_bad_bytes and tx_good_bytes in struct yt921x_mib_stats, which are
reported through the periodic MIB poll and the DSA get_stats64()/ethtool
paths.

Without a Fixes: tag pointing at 186623f4aa724c, would this hunk be
distinguishable from the surrounding refactor for backporting purposes?

[ ... smi.c and smi.h hunks snipped, no comments ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906131414.2683362-1-mmyangfl%40gmail.com
