Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65422D781B
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 10:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172563; cv=pass; b=hVwRk2my3Hk+LZ+JzRv2gGwJ6mR4t5Rn6pnEl/umx9Aw4jb8+5VEkn/37sNmgVwNxN2reoWodKzV/43SLVvJrqFzTajpg3URXDWOyhM32krbx0jMKD6WcHjmH5e7eDO1fF2qXkk7s9DcPSG68MfG3xvIn7X6DboF6gn0LWlOLBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172563; c=relaxed/simple;
	bh=17Uuc3zfGpTlIOpd4zndbkf7riqcWXLmLpdagq3nZF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFSg3V8ZiilBvflE3K8OPkbroUuoDKvlIUgDZ4+qpP+WBm0OknleFp+tpat357FDOpiHoss0msBFkyQSerjoeE2X7ShLYgCGE4MQT5mUDHMG1O6e7Z4wkD+OooKotgyER76bTpWdOn9ebQxEYNC1cMSPiqWWZ5AgHvVjAjKXQzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOlHi2Sk; arc=pass smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOlHi2Sk"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-902e4af2d9dso39844386d6.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 03:36:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788172561; cv=none;
        d=google.com; s=arc-20260327;
        b=s8wfMOOMDmYOoAZ5zHR+/7X2iLP+AaUaeKIoqgTNs7fmUfvUeS400eqfo3nSKA77uw
         q2R1Y42wfXmRzeq16can9xZqtBlxVLLbeTVA7I1k2OJ2dSkt0ejKWlmOQb3lgCP9Y0DO
         OJMfUZIyN4tSADNME082spqSisJt4usaYXw5ccjLSJ36F1aY3iagosb8qRONYAUjxswX
         tIpYP07PkKGc8sQvc0MdDMzD1QhKChT3O8z+2K0b4jR53O59ETVutxDEfOZPuG/AVTJx
         XgmdKVb0ncH3/buTJDExNt80nV3CqIrQM4MpYvUBmZRrHa+BfPsbIW7xkP0oTS0xUIFz
         TS4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aZRb6ZzJARtkhDdjsBstTG/eFPsTXUA4jzflrKRt3fs=;
        fh=IVFLBzEcJCqAdE0yYPMviKUQVAcG3l6SC4L72O+UmcQ=;
        b=a2CfOiBAV6rLNz6cSZ0vuU2GlfubofyAOexlfRi3UE8fR3Bp457aODT8dgS9lVNHNG
         miR15/IO9zy4LkkDroB332KbtLUm7DU9zV3QdU6EplCvItJb4qHhQreuKTUs9De8WS+h
         2NHP8qbe0PBvn8YNGLGJXAVROVIHXRIiVIBxAxOIWDAgj5n343XlCIUAxR1NtA/XGq+H
         4ejLx9NwRoOu8PH7yHmiGcytavFoPlc+FtvUFk2YYwP0so7Iwu1JMvD58zjiAZy/Vfir
         y1l57gXB5IBKsfgnQYFPggwXMQ6RomCvQ9F7fTUniIQ6+Hmf7mTMB+F+wR/2MVvSV2Yr
         /0kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788172561; x=1788777361; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aZRb6ZzJARtkhDdjsBstTG/eFPsTXUA4jzflrKRt3fs=;
        b=EOlHi2SkBhQaMGr1iJydQnac5i8kIxFcoR0Ht8VWhGI0fEZDmGqm7DWxel1DriZk22
         HBbexj9bgWmQl4N/nbn9Pm0UgqxZNLY1gzbSfGOEOOl7YZgYYM7e5K7ZcqdErvu0UGeP
         6WGCl7N+hIq0Y4eUcYteDIwbzsx3t9M22yq8VY5m1uwlMibTMKHXcWPNHuH0p8Pl78W8
         GbiOJDwgZwrK0GAD/PDaZtIMYV2X4BwRTBbFwToQBvrYZSKnZ1xJbD+pIeIO5et+nWFo
         P3/1Fq2xZXht+JuXFLCuaA0DSqGkRvSrpB8RGWUB0No0oBVtwb+QbLZwsOe8ele73sRm
         trXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788172561; x=1788777361;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aZRb6ZzJARtkhDdjsBstTG/eFPsTXUA4jzflrKRt3fs=;
        b=hsFPj+vgfzX9Kl4+rklBHPn7w3os6T31+cSYvsznySH9I75tmGateHOZKF2nUIvpzm
         ZAy92Cr79FB3FEph0S4fZo/63TrixF0/leXNEMmN3uJLNlyybgGLC/OrSQszB0yaZ2yU
         BM2KlHxZ+isRSBghuPgK9zBghjpKNc4JpWDGiKrGDMg3HRmBu4gIGNIgdC3vrHCsn6A7
         UihrG7NNDxVsVqLJRIw2t2knxvGR7LSIdvObHH/zvrF1OTy+tgKu6pIL/2tammJheHEK
         AhhY6+xmpx1dvwrhWGh5Dt/7VRNv3JVja92SSYkRcFY7pd7vDQlm9SoohhELzqW5P+0T
         Gn/g==
X-Forwarded-Encrypted: i=1; AKwUvByta+XQhk+czkn7LHu4tvuLWGmD4CR0jS5fkfhO+cD+zu/rKW9ybXHI83A1/9xvOeyVYdern7s=@vger.kernel.org
X-Gm-Message-State: AFuF++n1yNdG8vQthA0eUJ2/2PkshIqZkpvroJSHXI+JK/oUsX3JSgnn
	80acBn9Ie9kg6oN4ihuqM6GMGyzejCUMofcNVHIBXOrWtwWcVbdANzGywcKZmbqpgTjTTXaHJZw
	rPX9W4Gkiqoyu0S/0YnV21kjFhQexa7E=
X-Gm-Gg: AYBFou0Efs5Q6MrfKAOOR4lv8TctuN4S0Cus7hsGwLcax1Egi38enSo1ulfSeAVwfE6
	7Lzbji/J6pvN4GHIz4tyw+s8IktyKo/gAIVb5dS5yRU8F1S6OCLF7GaJmlpCtaxOIpUxpYVEvGf
	g3cf7CrQvsaddKNdTtq9tRR3cE4OX8qLAAFD38lypPC/aXUE/dMeeDQ5pPyd6Y1JkhuyfOnJoqJ
	HVNlSd8x+kUmLOWGN730pNoRc6AHb0pk1uns7ctJ4IDP+qlQVv0HZI5nN7s0j4xJ5DrPnQVM4vg
	BB/dk5SH7SMit3cNUopr/nRMDSTgyuXYfetx472j0Tovew==
X-Received: by 2002:a05:6214:5403:b0:90c:e18f:3759 with SMTP id
 6a1803df08f44-90e8702b5e8mr87775236d6.3.1788172560578; Mon, 31 Aug 2026
 03:36:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787499036.git.petalzu987@gmail.com> <99ba13458fbcff6d646ee223f0b70847b790777d.1787499036.git.petalzu987@gmail.com>
 <20260830063647.GA2725797@shredder>
In-Reply-To: <20260830063647.GA2725797@shredder>
From: Zixuan Chai <petalzu987@gmail.com>
Date: Mon, 31 Aug 2026 18:35:49 +0800
X-Gm-Features: AcwNN1V74AfiRmziext4S43Wk_FVqFV0DfQQ61ksC7DgrA1ssCqfDJsI7GOm4yo
Message-ID: <CADTzadJaJ_N=chKso3R8dXiOzhQARkjNE1tGpJmi5uW6qwG4QQ@mail.gmail.com>
Subject: Re: [PATCH net v3 1/1] ip6_tunnel: snapshot encap in xmit
To: Ido Schimmel <idosch@nvidia.com>
Cc: Ren Wei <weir@nebusec.ai>, iprintercanon@gmail.com, netdev@vger.kernel.org, 
	dsahern@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, tom@herbertland.com, vega@nebusec.ai, 
	enjou1224z@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sashiko/Clashiko: the report is useful.

I will update the fix in the next version to use a consistent
encapsulation snapshot in ip6_tnl_xmit().

Thanks.

Ido Schimmel <idosch@nvidia.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=8830=E6=97=
=A5=E5=91=A8=E6=97=A5 14:37=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Aug 25, 2026 at 03:29:49PM +0800, Ren Wei wrote:
> > From: Zixuan Chai <petalzu987@gmail.com>
> >
> > ip6_tnl_changelink() can update encapsulation parameters while the
> > netdevice is transmitting packets. ip6_tnl_xmit() can calculate packet
> > headroom with t->encap_hlen and later build an encapsulation header fro=
m
> > the live t->encap. A concurrent update can change the encapsulation
> > header between these accesses and make skb_push() underflow the skb hea=
d.
> >
> > Take a local snapshot of t->encap before calculating the encapsulation
> > header length. Use that same snapshot for headroom accounting, metadata
> > validation, and build_header(). This keeps all encapsulation decisions
> > for an skb consistent even if changelink updates the live configuration=
.
> >
> > Fixes: b3a27b519b22 ("ip6_tunnel: Add support for fou/gue encapsulation=
")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: Codex:gpt-5.4
> > Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
> > Signed-off-by: Ren Wei <enjou1224z@gmail.com>
>
> The comment from Sashiko [1] (which I asked to review multiple times
> [2][3]) looks valid. We need something like the diff below. The helper
> can then be used in the IPv4 code.
>
> diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
> index 7c9aadfe8fe3..97f3e9e3ccf5 100644
> --- a/include/net/ip_tunnels.h
> +++ b/include/net/ip_tunnels.h
> @@ -522,6 +522,15 @@ skb_vlan_inet_prepare(struct sk_buff *skb, bool inne=
r_proto_inherit)
>         return SKB_NOT_DROPPED_YET;
>  }
>
> +static inline void ip_tunnel_encap_snapshot(struct ip_tunnel_encap *dst,
> +                                           const struct ip_tunnel_encap =
*src)
> +{
> +       dst->type =3D READ_ONCE(src->type);
> +       dst->flags =3D READ_ONCE(src->flags);
> +       dst->sport =3D READ_ONCE(src->sport);
> +       dst->dport =3D READ_ONCE(src->dport);
> +}
> +
>  static inline int ip_encap_hlen(struct ip_tunnel_encap *e)
>  {
>         const struct ip_tunnel_encap_ops *ops;
> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index 63c524b080dd..6ca373d6205a 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> @@ -1205,8 +1205,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_de=
vice *dev, __u8 dsfield,
>                 goto tx_err_dst_release;
>         }
>
> -       /* Can tear, but hlen and build_header() use the same snapshot. *=
/
> -       ipencap =3D data_race(t->encap);
> +       ip_tunnel_encap_snapshot(&ipencap, &t->encap);
>         encap_hlen =3D ip6_encap_hlen(&ipencap);
>         if (unlikely(encap_hlen < 0))
>                 goto tx_err_dst_release;
>
> [1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/99ba13458fbcff6d6=
46ee223f0b70847b790777d.1787499036.git.petalzu987%40gmail.com
> [2] https://lore.kernel.org/netdev/20260812120827.GA3410841@shredder/
> [3] https://lore.kernel.org/netdev/20260817064250.GA196908@shredder/
