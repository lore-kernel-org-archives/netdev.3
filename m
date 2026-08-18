Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A95E477283
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787061761; cv=pass; b=aaWrf8KyKuJLy4C7DxZbgFeAIg8HH5aUVUzJ8mjcFjQdJiXjuRilGu7TDJeGVNcqL/ktmyo9nucYphgUtrZsUagyy5hQ1i4p1eQZ8R7LKY6co7pCI6/YnzzqhEfsSzpu10eQqOULpHZZpsr97dmH00yLMbbv++G9U5EqZjnfvu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787061761; c=relaxed/simple;
	bh=UTv5iKcz7kfcY3WQo8grBxKS0khaeif0r4KiIQ2d1NQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OLrz7Hco1os9BPFXaUg5IufeFjasWji1ilYnu3ZtBasz0ilxko8Mp8142v2JwUuFa96I89Oz3xfPeGALXrjZr31RjP/nmRddSjt3bbU1od7JJyDl5g+AnS/Y+6MGXbfAknkB3d1i8NCbK/yz0Q4Q+6HleKOSKGX7THkvRIzCweo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBnsNR53; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBnsNR53"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aec6360133so3879105e87.1
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 07:02:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787061758; cv=none;
        d=google.com; s=arc-20260327;
        b=c+JAxZQWWq+XN1hPAQvU7Dflm4Ya78rS+WzNp3c1mTGVMqQ7cd+gmwXy79N0HTX3vH
         gp+JMnavyU9Gryleq7WVeRqgy6alFlRa+WtFtvUeSMv/O1wiombjt4JjgEHbZeT/KfgY
         CS2KXNQaESVHwz1OT3FwZnVIANjiJF2St1vt40joRnMJmIDXI0Itqcqym6PqXF+Dhv0M
         oDg3MzXBmzOap9QRtPPA7iv1XBaIqLJfSh1UGvl0ExIiG32aLaT/xqaDRqK4tjswcGeW
         kiOi6209SN/jRHQQUFLOcUeuuEmWvCedlkWkgmn7cWWJCSJXo9lhk+75zsGLvkCba+R+
         NYJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SyYLwZDkHAy+N7E1Yf97yW3d9A55gZNRqH5/hl/NyOE=;
        fh=qBuN+IT523tNR/244csNLajsty3zxZxoT6U8MtM7CuI=;
        b=q31hgXnGQjq/9v4Koy0aM30RKWpnY7VOsInTKemJHIzLOIKj/wA0x/7UvzBK+P52av
         GWvRDRBCE+Tnhs0ZiP8qWPAIRc8bOfShWe9mdrX1Tudb2W/fVvegB7cXjQvsvYn8R9xP
         L0F+73Iyh1rZADewEfIEpArZUvdpx9hYyT64XzMix7bD0d9G/pALgH2Ev4hDiV6niKFD
         xuo76bpZtSOcs2wgWVh/o+sM6z8ggD+fjad4cbcFh5II4yrU6BLv579QscaNJN9MAf7F
         cx9LbiQ+B+YuG+P3rbR+UbcftzGQ7gXHPbUOm+zg25neAXgit5DkhjOaI+gAVhq52Ryw
         HbGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787061758; x=1787666558; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SyYLwZDkHAy+N7E1Yf97yW3d9A55gZNRqH5/hl/NyOE=;
        b=WBnsNR53SLLb1zdbMEZ0zS5c9TdF2lECNtXwUWI/BYt/JF+w+rcLHSfoPLuO2FLxXd
         jg04/TIYEQ4ElNSve1aETYaXWAkgC0C0iJSK8df7FEvuv4SxFVlObacbz62WyQDSIeyR
         4Ns4MXqwwgjA3qoL4LrVkRtsZwKROmIeLBGPvoJyR5JOV54yNuP4Ubhe3YxrSTy+wHOK
         fREUZxE4iNJrIUl14sPWgmOXPfl4v2DDvDaO0YtfGghVNCw4G/Lbew8E123Xyfwrv8j+
         QaQ9aNM179jb0Hv2KoShmQ8MtueJCkCb1oX/PQ5CBH7CkmwXivnUs57wR7rsFpMF/hGK
         T4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787061758; x=1787666558;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SyYLwZDkHAy+N7E1Yf97yW3d9A55gZNRqH5/hl/NyOE=;
        b=qUEETTiculgHo/M4MINuDr5Wp8iT2LBhT+87tpxRU9latd37a3zICDXDAhvbes3D5O
         az0GHYia5au2THc6RxxQid2elozCsVWXzFD1M6MQetPsyxZTz8KUfpitqP6AR+ZofahD
         DR/Q6oH5kyxrwM82ah0Ku2582DUQdywJ066rxbN0KgmFGfkjKVFIQQrt0D0PD3VYYm2y
         fm++je6QQjbcUvYg9HBKxsYIqjw+ClceownuaXlnm2y0HUqp3dxUFvl648HGyi9YNtdH
         8TVN+SbKiCW440nx+Tkk9OvcClG9qAxuBQfbDCyicIsHJhHE+s2CdFNElAdDwEzT83aq
         2n9g==
X-Gm-Message-State: AOJu0Yy/4oGyTFDVzDlCCXSxWB0ADUNUNH7uFYB3szdXVgjP8+9xcj1p
	k7xSdkEhYBp/hMmitqss4iVaXW5LFK/z0X2/oDK/Ix62ynSSIPL1vTRxmIdk/C2KZFWyXN567Rb
	vO6d4dwBJOI5L7n6eFlP434XqH/KdMzQ=
X-Gm-Gg: AR+sD12JvWeBOZfn+0RS6+ybW8mOvDkmh/d3RJRtf6QVIa790NckZ62FpPmR7fzMyzv
	aA0O+b8dWXCEXkGoVfveYmSyz74sUR0q4xpN7i4NcpYb3qafuYIbYOQZ0BiJfHbUymbyEcvnLug
	Jr1Q3JLJir13wDM/dYdDudVg65xRPsDUQP2JmqTmpMtMh3Oja8rOT/n6iY1eJeSA2qp0d+tVLxs
	uYq+4/JGyKeSeD11Ar+TakHriixmAbED375WB8gAFNciKf+gkIyoII/c30+VVO9RsUPNHINlm1w
	jJr9QoBX9o4b1pU023eNYAy1CTUFuLSTegW9EmFvVSb639RaKR+xMvh60rI1q6jUbKkBfvjqrF3
	g1xaqlmfoMb9zsrfsWSgY/hYll/CSg2BiJMDiLDoO2uRQ5JzslTt3REprZYQ=
X-Received: by 2002:a05:6512:a34e:b0:5ae:b0aa:8f07 with SMTP id
 2adb3069b0e04-5b470670602mr2119668e87.16.1787061757880; Tue, 18 Aug 2026
 07:02:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817153957.3177627-1-poros@redhat.com>
In-Reply-To: <20260817153957.3177627-1-poros@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 18 Aug 2026 22:02:00 +0800
X-Gm-Features: AcwNN1UG_1pwdTjBdcWV7mH5yBQ6g2Q9r0pVO6574S7baK_7e2jyDoLFtMFtCU4
Message-ID: <CAL+tcoBVxsjPXzfSHorXFMLMcsh_ibRmLFBwaQQYZQBjx8RBiw@mail.gmail.com>
Subject: Re: [PATCH net] xsk: reset the mac header in the generic Tx path
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Vladimir Oltean <olteanv@gmail.com>, Doruk Tan Ozturk <doruk@0sec.ai>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 1:12=E2=80=AFAM Petr Oros <poros@redhat.com> wrote:
>
> __dev_queue_xmit() resets skb->mac_header, __dev_direct_xmit() does not,
> so a frame taking the qdisc bypass path reaches ndo_start_xmit() with
> the sentinel left by __finalize_skb_around() and skb_mac_header() points
> 65535 bytes past skb->head.
>
> The packet socket reaches it through packet_direct_xmit(), and
> packet_parse_headers() was taught to anchor the header by
> commit c2707480cfbf ("net/packet: reset the MAC header on the
> packet-socket transmit path"). AF_XDP reaches it through
> __xsk_generic_xmit(), and net/xdp/xsk.c never sets the mac header.
>
> ice reads eth->h_proto through skb_mac_header() on its ordinary Tx path.
> On an E810 every one of 2817224 AF_XDP frames reached the driver with the
> sentinel still in place, so the ethertype never came from the frame. With
> this patch all 5757920 frames of the same test carried the correct 0x88b5=
.
> An AF_PACKET sender on the same port read 0x88b5 in both runs.
>
> On a KFENCE kernel that read lands inside the pool and gets reported as a
> use after free of an unrelated object, 387 times in a 180 s run:
>
>         BUG: KFENCE: use-after-free read in ice_xmit_frame_ring+0xddb/0x1=
650 [ice]
>          ice_xmit_frame_ring+0xddb/0x1650 [ice]
>          __dev_direct_xmit+0x347/0x4d0
>          __xsk_generic_xmit+0xc13/0x1e70
>          __xsk_sendmsg.constprop.0.isra.0+0x519/0x640
>          xsk_sendmsg+0x6c/0x90
>
> Rerunning the same reproducer on the same E810 with this patch applied
> produced no reports and no bad reads.
>
> Anchor the header in xsk_skb_init_misc(), which runs once per skb for
> both build paths. With IFF_TX_SKB_NO_LINEAR the offset still is not a
> real header, but it stays in bounds and no such driver reads it.
>
> Fixes: 35fcde7f8deb ("xsk: support for Tx")
> Signed-off-by: Petr Oros <poros@redhat.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

> ---
>  net/xdp/xsk.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7855ee09c4b640..885427392cb6b3 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -931,6 +931,7 @@ static int xsk_skb_init_misc(struct sk_buff *skb, str=
uct xdp_sock *xs,
>         skb->priority =3D READ_ONCE(xs->sk.sk_priority);
>         skb->mark =3D READ_ONCE(xs->sk.sk_mark);
>         skb->destructor =3D xsk_destruct_skb;
> +       skb_reset_mac_header(skb);

That's a good place to do the reset process. I will cook a follow-up
patch to reset the network header.

Thanks,
Jason
