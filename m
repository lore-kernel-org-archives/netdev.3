Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CA4368D76
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 22:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790978720; cv=none; b=MurjW4a/vJxVShmyWjdAODRhlPUI+0vS0Z2zUwlFMF4hy/vKL/dqNO5eIBx6Pve0T7C04AqsbrCAxZdaCxY18TdR57BpNNI8qM8A4OnHybdKx5rx/uatAhJnC+TRCjaxNNIU6Z3qF38sJvaphbQni3K8VkKxv7C4SjSy/+xYrZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790978720; c=relaxed/simple;
	bh=Op2VE/mM0zGOShfaFW/0BW0KlBnu8F+VO2ttkd98TKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kx6RDIwCq45WQtPHAoFjsjFaDcefyj878p17vRpug9vyACrsNOSeM429G5btAYlXsMG3+3RnhWJFW0MGCifJp6ShTyT57YcstxXXFqt01zB+tKJyPexfJsZCn3uNCBM0yHhmf2iZONi03oAgECkZAXd0DfgyDD2pii7ABvs1LZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=uExVwByN; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="uExVwByN"
Received: by dvalin.narfation.org (Postfix) id 696382046C;
	Fri, 02 Oct 2026 22:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1790978716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GNvw00UCUW/0bO/7q1Yy7pulx8K0aP4KiltkrXhApqY=;
	b=uExVwByNcR78Kw5tcPlA8m5DnlP3A9/4PbXahxAGHjeX0LglxYH/UDOWCI3Fx0t2MxAuVX
	QZGu4lCd65HRBfSMLKL+VJMWr57Ub3IVmY8tEO2BbxJf0FmnAUAe/niF3kRFNCHJP4rv1x
	lVj1u83dSX9a/1zeRbZsq+5GPEoPPO4=
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sashiko-bot@kernel.org
Subject:
 Re: [PATCH net-next 8/9] batman-adv: tt: reject VLAN/TT entries before
 reaching size limit
Date: Sat, 03 Oct 2026 00:05:13 +0200
Message-ID: <2653823.Sgy9Pd6rRy@sven-desktop>
In-Reply-To: <179084943174.434549.11209044496055868169@kernel.org>
References:
 <20260930094558.3723766-9-sw@simonwunderlich.de>
 <179084943174.434549.11209044496055868169@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3881024.RUnXabflUD";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart3881024.RUnXabflUD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Date: Sat, 03 Oct 2026 00:05:13 +0200
Message-ID: <2653823.Sgy9Pd6rRy@sven-desktop>
In-Reply-To: <179084943174.434549.11209044496055868169@kernel.org>
MIME-Version: 1.0

On Thursday, 1 October 2026 12:10:31 CEST netdev-bot+sashiko@kernel.org wrote:
[...]
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> 
> [Severity: Low]
> Should this have a Fixes: tag, and maybe a Cc to stable?

No, the change is not suitable for stable backports. And since it is submitted 
for net-next, I am not allowed to add Fixes: (for old kernels) or Cc: stable@ tags.

[...]
> > diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> > index 481dc6afaaba1..3349376a9087d 100644
> > --- a/net/batman-adv/translation-table.c
> > +++ b/net/batman-adv/translation-table.c
> > @@ -234,6 +234,162 @@ batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
> 
> [ ... ]
> 
> > +static bool batadv_tt_local_reserve(struct batadv_priv *bat_priv, u16 num_vlan,
> > +				    u16 num_entries, int *table_size)
> > +{
> > +	int packet_size_max = READ_ONCE(bat_priv->packet_size_max);
> > +
> > +	scoped_guard(spinlock_bh, &bat_priv->tt.reserve_lock) {
> > +		bat_priv->tt.reserved_vlans += num_vlan;
> > +		bat_priv->tt.reserved_entries += num_entries;
> > +
> > +		*table_size = batadv_tt_local_transmit_size(bat_priv->tt.reserved_vlans,
> > +							    bat_priv->tt.reserved_entries);
> > +		if (*table_size <= packet_size_max)
> > +			return true;
> 
> [Severity: Medium]
> Can bat_priv->tt.reserved_entries wrap here?
>
> The new counters in struct batadv_priv_tt are u16. The only bound on them
> is packet_size_max, and nothing caps packet_size_max at what a single TT
> TVLV can hold. When fragmentation is disabled, batadv_hardif_min_mtu()
> skips the clamp:

This is actually a good point. I didn't think about the case of an extremely 
large MTU and used a 9000/64K MTU in my head as reason for using only u16. I 
still consider it as a corner case and will submit a follow up patch for it.


> If packet_size_max is above roughly 65535, the table can still grow past
> what batadv_tt_prepare_tvlv_local_data() can build, because tvlv_len is a
> u16:
> 
> 	if (check_add_overflow(*tt_len, change_offset, &tvlv_len)) {
> 		tvlv_len = 0;
> 		*tt_len = 0;
> 		goto out;
> 	}

Correct, so widening over u16 doesn't make any sense. It seems to be better to 
just limit the size of the packet against which it is checked:

Will be submitted later to netdev as follow up check because it is not a 
regression but just a limitation in the supported packet_size_max limits (for 
non-standard setups).

https://lore.kernel.org/r/20261003-tvlv-limited-tt-response-reservation-v1-1-82fbca929cd9@narfation.org

Regards,
	Sven

--nextPart3881024.RUnXabflUD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCasAqmQAKCRBND3cr0xT1
yzWBAP0WNBEmBd8u8mbzWIsGBUe2DLQV3yZCvFe/k5tsK1/hSgD9FW9xaMmfG1CI
Qx/yW8Lbr+K6Jlns4DDpSs+KUR0SGgU=
=ByNZ
-----END PGP SIGNATURE-----

--nextPart3881024.RUnXabflUD--



