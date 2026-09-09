Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4AC140E5F;
	Wed,  9 Sep 2026 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966975; cv=none; b=lxLwNtKQjhYMfmlDid8Sr3w/onv9BPGvBqPua19Uwkh29u9cRExuJ1FS6L+4Nykb8YF/Hjo6/DWeq5lashbpdM1zoCudYyK5Pcc4/c+2cqTMAxCsf6/yVUKa41ESaWE+ZQVeLkyl7nHQ/QTy/D45DBlBjJ6Q8/4tMhTyNXzdFXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966975; c=relaxed/simple;
	bh=d1C/K+qzAGkECgE2nmKdB/9huiH2yRLjMBqnaAqSwvI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HgqEvM05TtL//uJtZf6kKAdkId8VyNd0XWbadmGZGvWhiiC5CSyMFbTidFnGK+Jg1uLPcjh9M8HIrg/brA998Y0htB7KFkZt4O8fope2V4F7JFFVkdDaPeYcopvbsJVZvugjhL90cqhEBv0YbclogF2p8UUlsLnae/ptjXVO2ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7Z5EE3i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7Z5EE3i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F039F1F00A3A;
	Wed,  9 Sep 2026 15:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966973;
	bh=bhd3hV9Ncs4ZoE2VlMtH3ehZccDZvSN+z+UENB407Nw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=g7Z5EE3iyWaOpRoD3Z4aGLJ2QzG3YnrNUVP+s14zDiV9nw+E2wmHKDEL8PFfMoAGV
	 o8lr3N7pi6uF9v/Aa7PBFl/qo4DAolrIzA6QCCnss8VTnZgF4zUt0pDinZ23BvL6j9
	 V3FjQ2AaANsNvNQ+j2iUqsgzdoVnTqP+JDmFae7xOVsvON75QT7130E+oEaN19190I
	 W9Gjk376bgN8Oph5MZqM3AdLHyoKMjc5D82gpPclVBlJx7U4l8ugYjFkRXXiOnU0xt
	 5s245t9y8ViIhtDg9oIPqOhZURCyjKXznE2s9E9X83sd78aRGKVPz1BDvj5MwgqtOK
	 3wbXnyP6+2LPw==
Subject: Re: [PATCH net-next v3 1/6] net: dsa: motorcomm: Rename MIB stuffs
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Date: Wed, 09 Sep 2026 15:16:12 +0000
Message-ID: <178896697251.219967.12696740711142321048@kernel.org>
In-Reply-To: <20260906131414.2683362-2-mmyangfl@gmail.com>
References: <20260906131414.2683362-2-mmyangfl@gmail.com>
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

- [Low] Stale comment after the rename:
  `drivers/net/dsa/motorcomm/chip.c:41` still reads "/* Must agree with…

--

net: dsa: motorcomm: Rename MIB stuffs

This renames yt921x_read_mib() to yt921x_mib_read(), yt921x_poll_mib() to
yt921x_mib_poll(), and struct yt921x_mib to struct yt921x_mib_stats, in
preparation for a larger MIB refactor.  No functional change is intended.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index d663af010f431..ad5fe1ccb1d71 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -545,11 +545,11 @@ yt921x_mbus_ext_init(struct yt921x_priv *priv, struct device_node *mnp)
>  }
>  
>  /* Read and handle overflow of 32bit MIBs. MIB buffer must be zeroed before. */
> -static int yt921x_read_mib(struct yt921x_priv *priv, int port)
> +static int yt921x_mib_read(struct yt921x_priv *priv, int port)
>  {
>  	struct yt921x_port *pp = &priv->ports[port];
>  	struct device *dev = to_device(priv);
> -	struct yt921x_mib *mib = &pp->mib;
> +	struct yt921x_mib_stats *mib = &pp->mib;
>  	int res = 0;

[ ... ]

> diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
> index 83cd454955ddb..805febb486838 100644
> --- a/drivers/net/dsa/motorcomm/chip.h
> +++ b/drivers/net/dsa/motorcomm/chip.h
> @@ -861,7 +861,7 @@ enum yt921x_fdb_entry_status {
>  #define yt921x_port_is_internal(port) ((port) < 8)
>  #define yt921x_port_is_external(port) ((port) == 8 || (port) == 9)
>  
> -struct yt921x_mib {
> +struct yt921x_mib_stats {
>  	u64 rx_broadcast;
>  	u64 rx_pause;
>  	u64 rx_multicast;

[Severity: Low]
Should the comment above yt921x_mib_descs[] in chip.c be renamed too?  It
still points at the old type name:

drivers/net/dsa/motorcomm/chip.c
	/* Must agree with yt921x_mib
	 *
	 * Unstructured fields (name != NULL) will appear in get_ethtool_stats(),
	 * ...
	 */
	static const struct yt921x_mib_desc yt921x_mib_descs[] = {

After this commit there is no struct yt921x_mib left in the tree, so the
comment names a type that no longer exists.

This comment is also the only thing documenting the invariant that
yt921x_mib_read() relies on:

	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
		u32 reg = YT921X_MIBn_DATA0(port) + desc->offset;
		u64 *valp = &((u64 *)mib)[i];

The descriptor table order and count must match the u64 field order and
count of the (now renamed) struct, and there is no static_assert() or
BUILD_BUG_ON() tying ARRAY_SIZE(yt921x_mib_descs) to
sizeof(struct yt921x_mib_stats) / sizeof(u64).  The invariant itself still
holds here (39 descriptors, 39 u64 fields, same order), so this is only a
comment-versus-definition mismatch.

Worth noting for the rest of the series: by the end of the series the same
comment survives in drivers/net/dsa/motorcomm/mib.c, but struct yt921x_mib
has been reintroduced there as a different container type (work, syncp,
stats, data[]).  At that point the comment points at a struct that the
table must not agree with, since the table has to match
struct yt921x_mib_stats.  Would it make sense to update the comment in this
patch, and possibly add a compile-time assertion on the entry count?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906131414.2683362-1-mmyangfl%40gmail.com
