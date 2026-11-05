Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887774;
	b=dRMAiLzDoM/6nin9+StGu5aeHU0HTQYA5VdzvavhD3q1ofo950zCgPzthpn14mG9Eykc
	 /LuSQl45ygl2OlXODxBjedaEHK9O+WLOsBxu8RBjTh25qxNHvbJFZ2XpyrmkmTwf71CJj
	 4aXedfmQHrwI9VDvVO9hlCGmpFHuwkRK3N5puectDt7kzmQ3TJ5E8xrUN4R2Mcv4NFxhx
	 5c3P8vsrq9Sr7ek/FW0/JOiWy89axmHongLbNPakV98wxY3YntTbrMVR9/p41iNEgjeLi
	 TzRO03wT+RA23XQ26fbFMLM//GcnGIyn6x0A7nX6OErRZ/1I6f6Ruq8VM0SeENXorIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887774;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=jzTzN1xi3wWq3rkQo05baaXe4YaAa7XUzbwyEbAc0TE=;
	b=HU3VIKjOsfKD6enD8M77Y6oSG1So0yRckxLjsfVOlT7tPdbwrIid5H0vpYRMSyIsBW2J
	 +WqCmXvzG4RPGRxruwUVYErozo5tU9ZIsnAgsu7h57fNOZI6dBKs7/+7BJzuJKwXQ2wYJ
	 EScEmLOmN7g3q1BenTF5WLzvZ+F5+f4lfLM8mhZ4wOzoyiy2UGtsrLSj6XPfDbTPLgodA
	 adv12MoOFJgzJIfVMoQq7bgxf0nKsrwDf6ZFvhx3xZfbvJxI7pornvuQvqE68TIEexcwK
	 wYQnctr3z9TLtvcs1QwTftaMdntUnMumFy+6AQOZz7Ry1FDAaJcrUM/L2HpTZ1n+eew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0cDOXOJ7;
	arc=none smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E748606A32D
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 14:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E748606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0cDOXOJ7
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b2d14968c9so21322387b3.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 06:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793887773; x=1794492573; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jzTzN1xi3wWq3rkQo05baaXe4YaAa7XUzbwyEbAc0TE=;
        b=0cDOXOJ7kU44pN3CSsJC7LBttdhxXbKwXqvZzda7pHXStgvvBzFoKR4rfQ6uRpzano
         LqGpNPg3W+CWu4WnyQkkbdSjRVXu+jvbvdx7LlzpaLxR3UBCncfBpxp7F1bVC1zR+7KP
         tOpqvK21hn3041JvnCXOIHZ1DQ5S6efh+xzD106W6QtWm527wUoE+KbI3Pdx4pboCUeH
         J7c0+EJi+hdBXYKg14ZCJ4Ab8oTgUC5Gw4DUJ4Tani6wz1FCcrxCBb2CybU5Tt8NB3w9
         r7i4x3Fi0TP87AzY+Xgmvr0Itmnv4T5QoEgJdD1/ShixhE8u4yftXQKAkHFGDsmbERx0
         3s4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793887773; x=1794492573;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jzTzN1xi3wWq3rkQo05baaXe4YaAa7XUzbwyEbAc0TE=;
        b=Uk1iCea8P0KWoaeSzKSp6NzLA368zjdzdSppftdzAwgUDt8bAN4zNsHbbMn05oiJ5K
         ddOFyKDCfdopfOEJ0xFU9jokroTKtdjBJwO2We2YI9/HSQWSllp4KwGEe5hBcLnTPTL6
         viG8ksWacZ+bG4ERGFlFf22h6lgyWCF+Xr3WL3Pw2XdbV62Pp+pwqTqIIRFVQQfqsPyL
         feGpwwrHbUdRBvqF0PdMiSx6NdHi2kXbYIMsMix8RNBBlm4L01TMgJarCRc1N5hSTV4u
         nCAy84/VN6iODE7IDBS48AmJfcgEZPdTJiZB7Jh4iYPDFSckqEHQ20LfITAoblx4aUGK
         xaNw==
X-Forwarded-Encrypted: i=1; AKwUvBxx36bEOO2gFGt0dMA0o7cJwb66p8W+Eebdj5qKSC5dzk4tRB0HXN8Yd7LRV+shWMSho4yohas=@vger.kernel.org
X-Gm-Message-State: APuU4Z+fCBAtKZwIm24kv0tuhdnG5LLzbSmKBjFhTryip8qyYN0zoLzn
	q+0HNahBPe22sbpD5YviEN57YAYSHGvgmgtk2J+kuEP4PlDDiuYNRx/G
X-Gm-Gg: AYBFou1Njy41Q8uFnWcJxMoOgP/gml3cTdHJ3JVn3QNmzVN1mOFUzFhOxURC22JLyA8
	asRVa7nvjfzJXV4MaSl5u9BpSuF4dUe7tvb80H72oKuO2rUjX6S2oNrW/E213+wFoiYaNsU2xDt
	UqKCYEMLCjQZWzOsOYZAQ1+JC8TT7OjH21ex/nGDYU6zjDUHYp18i4QL2gNjS0M/rsBeXQMzl6U
	eB9AVfBgufYcfVNfK7DF9wBAMUba6lx+dhtUa1wBWjvKEQcd/IYwxTT99mF4hlEmKim70e1buvR
	j1sSsEI5qeGitDk3c/0KUJ665BOwaBLzStdYiu7lT0pROeADgoNL61gOt2wjD/RdD8T/7n5aXkh
	FaoCynd3VTBWC1AMSmOOUpOFRZ2u1/QcqoATLoJdE67SzPjw4eW6gpfy9rI8tG2HcOdcjTLjclP
	YqqGSEDJsHDbFTBeft3XySOEijzsWhcY2pnpbgBLostb02usaz3pJmpzvPFTjTb5ts3l0R99ghm
	egVy3fbw2AQafWYHDePq/nGJc6yXFbaEfbbLrjMVhJ54eD3HTeWU8RqKfC9NYBomMFotkhRfLrx
	3dM8mB82snTeZ5w2SBLF3j6djAu5gfKKUQ==
X-Received: by 2002:a05:690e:1444:b0:679:b98d:9b7f with SMTP id 956f58d0204a3-67ba4c82e34mr11758102d50.11.1793887773314;
        Thu, 05 Nov 2026 06:09:33 -0800 (PST)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b309712e33sm40372397b3.4.2026.11.05.06.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 06:09:32 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Nov 2026 09:09:26 -0500
Message-Id: <DMNC538FF7AS.2JZQJXNEZG6P6@gmail.com>
Cc: "Simon Horman" <horms@kernel.org>, "Jakub Sitnicki"
 <jakub@cloudflare.com>, "Daniel Zahka" <daniel.zahka@gmail.com>, "Willem de
 Bruijn" <willemb@google.com>, <netdev@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net v2 1/2] net: Make PSP skb extension survive packet
 scrubbing
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Wei Wang" <weiwan@google.com>, "David S . Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "Shuah Khan"
 <shuah@kernel.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261030043145.2185700-1-weiwan@google.com>
 <20261030043145.2185700-2-weiwan@google.com>
In-Reply-To: <20261030043145.2185700-2-weiwan@google.com>

On Fri Oct 30, 2026 at 12:31 AM EDT, Wei Wang wrote:
> skb_scrub_packet() drops all skb extensions unconditionally via
> skb_ext_reset(). It runs on tunnel encap/decap (ip_tunnel_rcv, vxlan_rcv,
> etc.) and virtual device forwarding/redirection (dev_forward_skb,
> netkit_xmit, skb_do_redirect).
>
> When a virtual device such as netkit is associated with a PSP device in
> another network namespace via PSP_CMD_DEV_ASSOC, incoming PSP packets
> decapsulated by psp_dev_rcv() lose their SKB_EXT_PSP extension when
> scrubbed during redirection into the peer netns. Without SKB_EXT_PSP,
> __psp_sk_rx_policy_check() rejects incoming TCP data segments at the
> socket layer with SKB_DROP_REASON_PSP_INPUT.
>
> Introduce a static skb_ext_scrub() helper in net/core/skbuff.c to
> preserve SKB_EXT_PSP across skb_scrub_packet() while dropping all other
> extensions. If SKB_EXT_PSP is not active, skb_ext_scrub() simply calls
> skb_ext_reset(). If SKB_EXT_PSP is the only extension in the skb_ext
> buffer, nothing needs to be scrubbed. Otherwise, save the PSP metadata,
> reset the extension block, and re-add a fresh SKB_EXT_PSP extension (or
> clear skb->decrypted if the allocation fails).
>
> Fixes: 06c2dce2d0f6 ("psp: add new netlink cmd for dev-assoc and dev-disa=
ssoc")
> Link: https://lore.kernel.org/r/20260910-bpf-meta-inside-skb-ext-v2-3-0b2=
1e42180b0@cloudflare.com
> Reported-by: Daniel Zahka <daniel.zahka@gmail.com>
> Closes: https://lore.kernel.org/netdev/DLODSKPY6ON6.1G6SP3CFFLCPJ@gmail.c=
om/
> Co-developed-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Wei Wang <weiwan@google.com>
> ---
>  net/core/skbuff.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 93c2f440b9ec..5c4a2e982ebc 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -6369,6 +6369,32 @@ bool skb_try_coalesce(struct sk_buff *to, struct s=
k_buff *from,
>  }
>  EXPORT_SYMBOL(skb_try_coalesce);
> =20
> +static void skb_ext_scrub(struct sk_buff *skb)
> +{
> +#if IS_ENABLED(CONFIG_INET_PSP)
> +	struct psp_skb_ext *pse =3D skb_ext_find(skb, SKB_EXT_PSP);
> +
> +	if (pse) {
> +		struct skb_ext *ext =3D skb->extensions;
> +		struct psp_skb_ext tmp =3D *pse;

I would move the copy just before skb_ext_reset(skb), but it probably
won't make a difference in the generated code.

> +
> +		/* Nothing else to scrub if PSP is the only extension in ext. */
> +		if (ext->chunks =3D=3D SKB_EXT_CHUNKSIZEOF(*ext) +
> +				   skb_ext_type_len[SKB_EXT_PSP])
> +			return;
> +
> +		skb_ext_reset(skb);
> +		pse =3D skb_ext_add(skb, SKB_EXT_PSP);
> +		if (pse)
> +			memcpy(pse, &tmp, sizeof(*pse));
> +		else
> +			skb->decrypted =3D 0;

Agree with sashiko not to clear decrypted. It would at least prevent the
skb from being forwarded cleartext back onto the network.

> +		return;
> +	}
> +#endif
> +	skb_ext_reset(skb);
> +}
> +
>  /**
>   * skb_scrub_packet - scrub an skb
>   *
> @@ -6380,7 +6406,8 @@ EXPORT_SYMBOL(skb_try_coalesce);
>   * operations.
>   * skb_scrub_packet can also be used to clean a skb before injecting it =
in
>   * another namespace (@xnet =3D=3D true). We have to clear all informati=
on in the
> - * skb that could impact namespace isolation.
> + * skb that could impact namespace isolation. Note that PSP skb extensio=
n is
> + * preserved across packet scrubbing by design.
>   */
>  void skb_scrub_packet(struct sk_buff *skb, bool xnet)
>  {
> @@ -6388,7 +6415,7 @@ void skb_scrub_packet(struct sk_buff *skb, bool xne=
t)
>  	skb->skb_iif =3D 0;
>  	skb->ignore_df =3D 0;
>  	skb_dst_drop(skb);
> -	skb_ext_reset(skb);
> +	skb_ext_scrub(skb);
>  	nf_reset_ct(skb);
>  	nf_reset_trace(skb);
> =20

The only thing I would say is that skb_ext_scrub() won't scale if a
second extension comes along and wants the same treatment as PSP. In
that case, either we could make a bitmap of "no scrub" extensions and
then use the same approach of allocating a new ext block and copying
them over, or the original approach of skb_ext_del() could be used after
changing the reference counting scheme for the special extensions in the
release path of __skb_ext_put(), but that is a more intrusive change.

I'm ok with the approach from a PSP perspective:

Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
