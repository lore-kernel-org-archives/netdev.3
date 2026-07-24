Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40E0341AD6
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784887936; cv=none; b=jQciUucX6C3xj32MfmpiNHfCD2LDi1YtrbZ712UQMYPXB7ZE5t1a0geXisyaiM4Ew2XamQIgSrcJYfHCwZ9FYhCCtkB9t9P/14QbodDAX69HEn/NYBRP6Wpi2QGF8aF8QIc4YjD6tGIHT7bM8o5hCg9MmlKHO5EsS5RWBapVGBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784887936; c=relaxed/simple;
	bh=5OWuLjLID1MA5FwpyhhkwgjekPoWzjv6KOGLm7lA00Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tAbu8DmdOBH13XY24jFYDwccUf+3MmoTy/Vx3M+Vo1gc7QFbgqPcHk1Atg0FQUV/xJxvKGOarxXuIC29h7R9CNWF9QK6P8GJoUGug8Ba1OQArMDAtGrS6tkTS2/Y6bLx4J3q6Hl/hWraUTul4xcdKzNQfHsB4GBQbYIqJkOYKOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LRNDiTwd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FBCP2tYp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LRNDiTwd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBCP2tYp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784887933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWYPONpuqHmnmbQbURHtS6wdQMJ+mQ4r4BW66tq4TfQ=;
	b=LRNDiTwdvbVPGPCptWs43beQmNsPLM/8GNaoHBWNDC01dYkwctUX2aDIqpqsK0P7Y+HxiN
	18b2RtZpr2d0vWw1Mxeelol8kDqUjOYtrInkIabYD26bk6zsYqW6f6j7qkBKK/AAQLBO3R
	vhkAJzP5dUl1NIOkLbznrhvIxZu+Soc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-x7BnMzNyPWWfKpszS5XiyQ-1; Fri, 24 Jul 2026 06:12:12 -0400
X-MC-Unique: x7BnMzNyPWWfKpszS5XiyQ-1
X-Mimecast-MFC-AGG-ID: x7BnMzNyPWWfKpszS5XiyQ_1784887931
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c160b9c0676so28088766b.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 03:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784887931; x=1785492731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qWYPONpuqHmnmbQbURHtS6wdQMJ+mQ4r4BW66tq4TfQ=;
        b=FBCP2tYpobKCpR433V6ENS6XYrBBSceIGtSdP2RLplRbBmZuqcJ9+dzsB2jmiG7col
         7pfyqjMFqD0LTJXgFuBvMv1yPGFplJmX5SRkV90nBjx9V8ktjB+3qln8FnFhIQTkI6xn
         EhVxk6V6wXvk7krEMZXxF3WYR2oYyXV8n3w8+lxSEDrTMIfx/K66OCv6jMEg8QzwAvlT
         Rl1AaV8rJQPET2HybR1a1l1imL1fK2NagrQpkaPRkdVXT+pE7PIPluzNImuu+IZQiXC1
         M/ivZc8tQHfWZ3NVjIRJ1XBIc1GjJwyXmPd8/Olf84m1PPS7EtyvJOOH/DKSuVatwvg2
         VGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784887931; x=1785492731;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qWYPONpuqHmnmbQbURHtS6wdQMJ+mQ4r4BW66tq4TfQ=;
        b=qBfVwtsDYRHXixDqluatdEW/qfwpS/2ClVDsW0VChCH1JQf0k7M1CH+oo1pt5uErrG
         J92wH6g4m+O/FY8S3GM+QDBvpfz8CjnncOeENShnaKwWHzVS6npA1S8IX6kRUfUyN7bm
         du863zRBgeQiwYsChGXy7FxidTtIXDt5hL+B5lQmUC8wJr6piWZ1iPRxThZxcneus9Za
         CycMSymx3ABYL5QVhgEIQLmLFHjStId74fmVLfryj3QwAc+OYn/tBapIKNpGP1sA7I06
         vGoHGTE9KL+A7xs2lWvghskRvcABwgklf6hKhtITVptK3qUQqAQHA2rux0PZtpcBdgcW
         7qjw==
X-Forwarded-Encrypted: i=1; AHgh+RopFr/sLbLJ/6hGdvkObbjM44a9DavNSoEwVVCNzOitG8js+VuujRDpkvCsE/bd8Ah+XpvMC+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz786Kl9AKmyXoiJ7+rDn5FKkyeE1jD3EFLgowTlIUZYrNzszxH
	revUDzUBYlT4MAtGSf3PMcU+avvi3jnHMMS0XzRX8DwRDBzIB5+FtiaAwcxVQAd5grnDgDZWoQp
	sSKhC5zEefn9ZvlFrN1ycJ7N01I0L020piC4JwAGgtSyOCdauUCUtrszyAg==
X-Gm-Gg: AR+sD10rDaFE6BwQrZXHe4QZDSksDWzKnwzs6vQbz5rF8S1gzncHc/+bk2hORE1dBD0
	o6185E0JbDuTLaE4PpwKm8cCH0Uj1zuDf250LvecB0GcaCTquP5GqRJ74g1dvpIMeJtCeiKpRmU
	OGA53lVCkp8hXRP+IjAdgf4v/r6gcw8CZPoyHYWJz1iGu29jzZz94xJ9NNJrQSMnjjNYABWQwNt
	lZlH/T4e8MfcNxXoUVOzz2x0WgFkmxKVYWnNOxojIukfxN8NtGoDTalwhqjszwKOUnEbHJPOVfl
	qrrDpUUwKP4Pg1qs5unTQr9JEmG2tu2dSmj5Bi2LYU0Qa7qG3J8nn8fjWe/sJZGWW56bRi9U1B6
	tSmMbosk4SeY3fMP/rLQSxNirMppI+HNkqgyv+lZKwwaBO0wc
X-Received: by 2002:a17:907:960e:b0:c1c:1e8d:f8e8 with SMTP id a640c23a62f3a-c1c509a3412mr340479666b.56.1784887931050;
        Fri, 24 Jul 2026 03:12:11 -0700 (PDT)
X-Received: by 2002:a17:907:960e:b0:c1c:1e8d:f8e8 with SMTP id a640c23a62f3a-c1c509a3412mr340477666b.56.1784887930552;
        Fri, 24 Jul 2026 03:12:10 -0700 (PDT)
Received: from [172.16.2.95] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ac8c4bsm339028566b.18.2026.07.24.03.12.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2026 03:12:09 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: aconole@redhat.com, i.maximets@ovn.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org,
 AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
 kys@microsoft.com
Subject: Re: [PATCH net v3] net/openvswitch: check Ethernet header length in
  key_extract()
Date: Fri, 24 Jul 2026 12:12:07 +0200
X-Mailer: MailMate (2.0r6292)
Message-ID: <8082BACD-66E4-4C6C-ADA6-92231F1ECF39@redhat.com>
In-Reply-To: <20260723233757.96356-1-blbllhy@gmail.com>
References: <20260723233757.96356-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On 24 Jul 2026, at 1:37, Cen Zhang (Microsoft) wrote:

> When a packet arrives on an ARPHRD_NONE device (e.g. TUN),
> ovs_flow_key_extract() trusts the user-provided skb->protocol field: if=

> it is ETH_P_TEB, the packet is classified as MAC_PROTO_ETHERNET and
> key_extract() is called without ensuring the skb has ETH_HLEN (14) byte=
s
> of linear data. key_extract() unconditionally pulls 2 * ETH_ALEN bytes
> for MAC addresses and parse_ethertype() pulls 2 more, either of which
> triggers a kernel BUG in __skb_pull() when the linear area is too small=
=2E
>
>   kernel BUG at include/linux/skbuff.h:2848!
>   RIP: 0010:key_extract+0xa7e/0xd90 net/openvswitch/flow.c:933
>   ovs_flow_key_extract+0x419/0xa70
>   ovs_vport_receive+0x222/0x390
>   netdev_frame_hook+0x3e0/0x630
>   tun_get_user+0x2d0c/0x38e0
>
> Fixed by adding checks in key_extract() before pulling the Ethernet
> header.
>
> Fixes: 217ac77a3c25 ("openvswitch: allow L3 netdev ports")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>

Hi Cen,

Thanks for the new revision.

The doc comment for key_extract() also needs updating.  It currently
states:

  * The caller must ensure that skb->len >=3D ETH_HLEN.

The comment should be removed or replaced with a note that the
function returns -EINVAL when the frame is too short to contain an
Ethernet header.

One more comment below.

Cheers,

Eelco

> ---
> v3: Use check_header() per review, fix format issue.
> v2: Moved the check into key_extract() per Ilya Maximets.
> Link: https://lore.kernel.org/all/20260721143602.64677-1-blbllhy@gmail.=
com
>
>  net/openvswitch/flow.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
> index 66366982f604..fc4002353e17 100644
> --- a/net/openvswitch/flow.c
> +++ b/net/openvswitch/flow.c
> @@ -911,6 +911,7 @@ static int key_extract_l3l4(struct sk_buff *skb, st=
ruct sw_flow_key *key)
>  static int key_extract(struct sk_buff *skb, struct sw_flow_key *key)
>  {
>  	struct ethhdr *eth;
> +	int err;

Since err is only used in the else block, it should be scoped there:

	} else {
		int err =3D check_header(skb, ETH_HLEN);

		if (unlikely(err))
			return err;

>
>  	/* Flags are always used as part of stats */
>  	key->tp.flags =3D 0;
> @@ -926,6 +927,10 @@ static int key_extract(struct sk_buff *skb, struct=
 sw_flow_key *key)
>  		skb_reset_network_header(skb);
>  		key->eth.type =3D skb->protocol;
>  	} else {
> +		err =3D check_header(skb, ETH_HLEN);
> +		if (unlikely(err))
> +			return err;
> +
>  		eth =3D eth_hdr(skb);
>  		ether_addr_copy(key->eth.src, eth->h_source);
>  		ether_addr_copy(key->eth.dst, eth->h_dest);
> -- =

> 2.53.0

