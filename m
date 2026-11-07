Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794063071;
	b=yoNuY9T4Kpch+/vk2jI1kqG18bntyZKQ3UYI4AweLPfOZuhFp+m9jxwaVQfxnPJTGmxa
	 NQ3TWAWcgafr2w5L3UA5yHTgOAeMMpy5geQE9y1uLKk4ZtgfN2adTqD+DnFs6N+iNa0MA
	 4XteRQDnx6s8hrUoQW0KRB3jpbr3v9AbtABF1DI7ZUwqyJXe9HOQD9jKdkIENE5KK2T7S
	 sAt6F1n8yzyYt1kSV0NUNhWp7vZqbiD1OpF937AoeQUCObbFH1CapyAg2ETiN+F6soYbF
	 53iprxXO9n+KgP6Cj8f5QoBNMvRr62K6Emzlzv3jeBYzC1wyiXi8cUrO+NZjddWfOxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794063071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TiUGdurgArXkHoJfkLsRhbw1Pz03rQ/EVAWVD4W2NTI=;
	b=4khl2NbzUeH1GwvdNMPvo9QBApG2oW7ieAjxZGcwePrMHVpjcJxBiD1g5RXBz0njlecp
	 aRtSMdEYS4EcvvzrBhLPgqfi9215ixI5EtZ9aofVHjTHzlIN25FfkC/5RT4rVwBLNmwhT
	 e+8ckej1y8GVMOZLck1z+4oOcJ7MM5YFEyQES4fibTPCq2NAJyPOt1MTBdPxh93lUlljB
	 NXHxkGU6481fE0EsfxHAEr5b8aj2ayVtuB2toOLZ2s0xVw/wFXffRmeEFKY8sShP+N43G
	 lSpRRLTfg0t1oSV5Zm9xXoT5Pz8DIhdO7bEjao3lSFIFYTQwiTKVawGg2tq/qeeQMdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GMmnpEp8;
	arc=none smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A7F606D80F
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 14:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7A7F606D80F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GMmnpEp8
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7d2ca055399so55634137.3
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 06:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794063070; x=1794667870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TiUGdurgArXkHoJfkLsRhbw1Pz03rQ/EVAWVD4W2NTI=;
        b=GMmnpEp8of2xPaPuVAQPWKFigGoxcgA2aR9nmMX8ZNpJmmZa9wenRFjcQYhqzF+O4f
         awBenfwbtU48GdXYiFGvMF05ZuPd2YRwUd/bKYVmg2+fpVvWyXk3/cOqljzGB7EFuehQ
         jSFMjTS1HImQQbpOAIch75CU0lfTskRBtkH/rJuM0AjpjE/P3P8J+DQI87qBktK8nXt/
         aSxf7BEmuWBin/5d4x52nfaZrhJOPIOJV6hOYMw3nmjeLfBW19C/l5v/LtsaIoX84Xvv
         xUVgNd0DsgIXX3J/pesSgSTgnV0kJtmqYWA9OozHAL2Ef726Xk7KoMfu60bGOWnp30qP
         G0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794063070; x=1794667870;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TiUGdurgArXkHoJfkLsRhbw1Pz03rQ/EVAWVD4W2NTI=;
        b=UqZxgJr67NFOg38LAnrRSYDRVzQO3z2oe5HqMoLz2Tx7HgqF/ZVWq2giQpDc6BPLxW
         ufqIm1y8XMq91b+XLrvN8w9HRvU6+3w2Y8tadqVXgqaUNl2R9E9jnqXGD406cqZKwigw
         EMJb3h88hhl811g5iLAF5b+McllowGFQFcWVWCs5LIOOGUIg2gpZ7Rg+WXnd8y7ex2Rb
         gye8csU6SsnbKwwOJgA3ONJ0HEnUtIrhSe0Cj4SkvmiuKge+P4TiYZcj18GDy2PonTrM
         QzLwknUAL6sZgKPh/AztfSVPyG98uXHI38vmniVEnB283PIe1x6lSsFruwfMXXOVtuhw
         k+9A==
X-Forwarded-Encrypted: i=1; AL+hErHM13AbORg3104UBq2qr/SSaY695/UjNuI9t7D1Gd6xe29SZlXHFTJ6miJNhdToLyWwkNP7vqE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8oZJXxMymqjeDsQVFquv52/XGEyano40HzN07skpsIYFR1K1kt
	rfpH/fBzLJZYyohbC8iEYGVauN/lYWg8x4sKEbtWY57fKiEEMfgSMePg
X-Gm-Gg: AYBFou1RgBYjxZDbGVDRmZIP4scMQ1fN/WTj4qrOiFhmC0ZUd/gCNZtGG2/cvGtzGz6
	J20LVdFRMVOotG01EMh6Dpt4ZELec/0r8u8zWmqaNjrBRS+uA8KeZtiv1gngLJh/QFxpVBesZ5I
	0YA7z1uhL6QolDSu2cDnsjq9MVGioRsYX9w1V+e+xf4ZcwucZZMVQq8eFDJL6kydUACRZcUMXFy
	gvQOWL/wTfVvP82Ena4ApmZj61VuB++s9zLIlQicq0Fb1OtE77OOHApmTchiPnVtU5txlwI4eQW
	YQr5jo92qbrsnBu3Jhq5nX43LIjDI6Es4W0NzfxmREIbiHwY0kq9o2OMg+tis35wMC9V3Ug2N2n
	keDk1tJ+a99Fn6kDf6JwdSL60qCN81ZQJLYz8Fzpf6jK8sQ2YrnmNzl7rlwAQoX8C1N8NzS6+X3
	//uJOGoj3BobAd95+YWg+gQy3/0DZK7/PHXoI2Pjf3Hrpqg5+iHAAt5I1K5oE3EAPtmZJtcXy1r
	NTosmlxawxd4OibRVH8P+oij9qoAGtASjhrCP08lYLrrrqCbi+cs43Mja1g80AGLIdtTQzCuuUL
	rSF0lecVaqU0/lEI5FR1HP1BMzx7tKXXVJUL0J5bYR7DPsoLbQJInKeayk8yBd8ClE8a5sdVQIR
	DAcGynQL5NnqHZXI5SxVt5lLveN/F1iRCeS3mgks0rfRY3Jy99X77K86ULT87CVxW9LqRg9qT75
	yvOUGGNRPgsLVK97Zt
X-Received: by 2002:a05:6102:4bca:b0:7c3:8150:83e7 with SMTP id ada2fe7eead31-7d2a154169emr2304378137.9.1794063068607;
        Sat, 07 Nov 2026 06:51:08 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99badbceebdsm4199060241.3.2026.11.07.06.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 06:51:07 -0800 (PST)
Date: Sat, 07 Nov 2026 09:51:07 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tianyi Gao <tianyi@cloudflare.com>, 
 netdev@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Simon Horman <horms@kernel.org>, 
 David Keogh <dkeogh@amazon.com>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 David Woodhouse <dwmw2@infradead.org>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Nimrod Oren <noren@nvidia.com>, 
 Alasdair McWilliam <alasdair@mcwilliam.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Breno Leitao <leitao@debian.org>, 
 =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>, 
 Danielle Ratson <danieller@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 bpf@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 kernel-team@cloudflare.com, 
 nh-open-source@amazon.com, 
 Tianyi Gao <tianyi@cloudflare.com>
Message-ID: <willemdebruijn.kernel.1d64e7848503b@gmail.com>
In-Reply-To: <e90e748e0aefa7cbe1c2b31b8c7902ccf135c3f2.1794020868.git.tianyi@cloudflare.com>
References: <cover.1794020868.git.tianyi@cloudflare.com>
 <e90e748e0aefa7cbe1c2b31b8c7902ccf135c3f2.1794020868.git.tianyi@cloudflare.com>
Subject: Re: [PATCH net-next 1/8] net: add tx_extra_headroom and
 LL_ALLOC_SPACE()
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Tianyi Gao wrote:
> From: David Keogh <dkeogh@amazon.com>
> 
> Programs attached at TC egress commonly push additional headers onto a
> packet, for example to encapsulate it. When the packet does not carry
> enough headroom the BPF helpers reallocate the head, which costs an
> allocation and a copy per packet.
> 
> Locally generated UDP, raw and AF_PACKET traffic is allocated with
> exactly LL_RESERVED_SPACE() of headroom, which only covers the
> link-layer header and the driver's needed_headroom. An administrator can
> only ask for more headroom at allocation time if the driver supports it,
> as netkit does with IFLA_NETKIT_HEADROOM. veth does not.
> 
> Add a tx_extra_headroom field to struct net_device for that purpose,

Main high level concern is just adding an extra field. What's next,
do we need to add a field extra_extra_headroom?

> together with LL_ALLOC_SPACE() and LL_ALLOC_SPACE_EX(). These add the

Since this already changes callers from LL_RESERVED_SPACE to
LL_ALLOC_SPACE, could this additional use case be integrated more in
the struct fields and helpers that are already there?

Admittedly, I did not spend much time looking at that deeply, and you
likely did, so the answer is no. But I want to poke a little at that
before we add yet another optional length field.

> extra reservation to the header length before the HH_DATA_MOD alignment,
> so the alignment of the link-layer header does not change.
> 
> The new macros are intended only for sites that allocate new packets.
> LL_RESERVED_SPACE() keeps its current meaning and remains the threshold
> used when checking whether an existing packet must be expanded, so the
> extra reservation never forces a reallocation on its own: packets that
> already have enough room for the headers being pushed, such as TCP
> segments built with MAX_TCP_HEADER, are left alone.
> 
> Keep the extra reservation separate from needed_headroom so that driver
> updates of their own requirement do not clobber it and so that it can
> be cleared independently. Place the field in the padding that follows
> needed_headroom, which keeps it in the TX read-mostly cacheline group.
> 
> The field is not set anywhere yet. A later patch exposes it through
> rtnetlink.
> 
> Also remove LL_RESERVED_SPACE_EXTRA(). It has had no user since
> commit 6d5431555de0 ("caif: remove CAIF NETWORK LAYER"). It could add
> the extra headroom, but it reads dev->hard_header_len itself. AF_PACKET
> must use the value that it read once, see commit 03390aa32e66 ("packet:
> use consistent hard_header_len in non-ring send paths").
> LL_ALLOC_SPACE_EX() takes the header length as an argument instead.
> 
> Signed-off-by: David Keogh <dkeogh@amazon.com>
> [tianyi: remove LL_RESERVED_SPACE_EXTRA()]
> Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
> ---
> checkpatch --strict reports "Macro argument reuse 'dev'" for
> LL_ALLOC_SPACE_EX() and LL_ALLOC_SPACE(). It reports the same for
> LL_RESERVED_SPACE().
> ---
>  .../networking/net_cachelines/net_device.rst  |  1 +
>  include/linux/netdevice.h                     | 36 +++++++++++++++++--
>  net/core/dev.c                                |  2 ++
>  3 files changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
> index 8eceaa80b686..a7e311fb7875 100644
> --- a/Documentation/networking/net_cachelines/net_device.rst
> +++ b/Documentation/networking/net_cachelines/net_device.rst
> @@ -35,6 +35,7 @@ unsigned_short                      gflags
>  unsigned_short                      hard_header_len             read_mostly         read_mostly         ip6_xmit(tx);gro_list_prepare(rx)
>  unsigned_int                        mtu                         read_mostly                             ip_finish_output2
>  unsigned_short                      needed_headroom             read_mostly                             LL_RESERVED_SPACE/ip_finish_output2
> +unsigned_short                      tx_extra_headroom           read_mostly                             LL_ALLOC_SPACE/__ip_append_data
>  unsigned_short                      needed_tailroom
>  netdev_features_t                   features                    read_mostly         read_mostly         HARD_TX_LOCK,netif_skb_features,sk_setup_caps(tx);netif_elide_gro(rx)
>  netdev_features_t                   hw_features
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 435be7880d7e..98d1501d6fee 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -311,9 +311,24 @@ struct hh_cache {
>  	  & ~(HH_DATA_MOD - 1)) + HH_DATA_MOD)
>  #define LL_RESERVED_SPACE(dev) \
>  	LL_RESERVED_SPACE_EX(dev, (dev)->hard_header_len)
> -#define LL_RESERVED_SPACE_EXTRA(dev,extra) \
> -	((((dev)->hard_header_len + READ_ONCE((dev)->needed_headroom) + (extra)) \
> -	  & ~(HH_DATA_MOD - 1)) + HH_DATA_MOD)
> +
> +/*
> + * Headroom to reserve when allocating a locally generated packet for
> + * transmission through a device. On top of LL_RESERVED_SPACE() this adds
> + * the administrator-configured tx_extra_headroom, folded in before the
> + * alignment so that the link-layer header placement does not change.
> + *
> + * Only use this for new allocations. Code that checks whether an existing
> + * packet has enough headroom must keep using LL_RESERVED_SPACE(), so that
> + * the extra reservation can never force a reallocation by itself.
> + */
> +#define LL_ALLOC_SPACE_EX(dev, hlen) \
> +	LL_RESERVED_SPACE_EX(dev, (hlen) + READ_ONCE((dev)->tx_extra_headroom))
> +#define LL_ALLOC_SPACE(dev) \
> +	LL_ALLOC_SPACE_EX(dev, (dev)->hard_header_len)
> +

If having to modify/add these helpers, it's probably a good time to
switch to actual, type safe and readable, functions instead.
