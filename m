Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422787;
	b=4oH4EQL2OfmtI4dAzFPAvG5iodc0egAiqFAgYnFQ/YyAzhP17r8o4dQyT37klFThJWw+
	 B5AnICnZ2pfe04yBuSItyZKjuMCRFXhQEbp73aW9NJs6OBM5ShJdsyp18JCTw94ZyQabh
	 MyWU81y3CRllF1T6zgeCcTO2vwkpPKsY7MzD4XTvA4RrX7s548cP0IHKvoqhiHSNHhgDE
	 THinXEuCLmAYy6ETCWwx4+hoyeMCsyKsvXAtMr9hTYF2PzS4OhtxEabaLwmW91LQmfVua
	 JwVHBQZ4uSoHGSHfgdPysw07fg0Vn62nGYvWtdQvom6HJs6xHtn5k9ekS0ptyc9RvFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422787;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/p9kG3mVIwDhglO8V3Ucme+ROyhYkCFN2qn2+pS+V4w=;
	b=oDT6ifCiJqb8Nh/BbYRGdFyfuj+STZxCLWCrlpOENU8QOCk38X3nW33pU0DAWfTejT4B
	 MGxhP9mF4uXcTslWmTZ+U1Nt8bvg0+soleyNR7r0O4Lv9Y1+JnK8beXfZuUjRYSUNRr7+
	 JBgcR0uVraVTXb3HSVUIv42S7oPuRWvm27wXp8gGXFFwLCdfizln+ICrsGJgdMhfGBbSC
	 5BYyt3iOI75cvDrgv+IkbhlpUcB38yAYNbOIJwBTPR6VATZ0QnXZhIpWjN26uDDsKfQUF
	 csoS36UNqfrcyIFCrdHQaO/DIEXavSbSJ+JIrTDsPOUySwVg6PXCXT/QPt5UatkIecw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=qPDd2RZD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C481609A554
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 15:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C481609A554
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=qPDd2RZD
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso17971a12.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 08:13:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792422786; cv=none;
        d=google.com; s=arc-20260327;
        b=AZ/fMLde2F/fLesdtchjckBeD33TtOBslRaDCrhzSREFblV87/UD7xTs4yqaSbxNlH
         GFn4wSzHqeEDn7UOXIF4RmaIhirBl7486doS1n4cSvIOm2JV3B23N8VRkYXiOJjtbu4r
         f/ZQOv2NTfSf22/Oe8wegiZn3jsxcnuVjOg8/3oP5J59/3Jqfbj1dF+/dnSRzHlv9Y7f
         wjegTMvzBxEh0QmaNlWZxtoYNJqojNN7Zutjj/n9ixysoypgepcaocO6OQrCfcJeSS8J
         JwdqK05m92tqjRSoDBQc1iB6elxnr7mC8m7SzF2u3LB7duSpR+6MpGyE50SKA+IDoyr0
         6r1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/p9kG3mVIwDhglO8V3Ucme+ROyhYkCFN2qn2+pS+V4w=;
        fh=5Mnw2toJ3/LIxQlt1RsPYMZJhrJ/xmoqXPDs0ohCm+c=;
        b=Mh5nQA5sykrlRKjN1ROS2xXmiGCzZYUWf6+FNFNtRzxS6Pexc6/hLlAugm1m6IZVPY
         y9sLkMcTwLI2DBHO95u5k/4N8dcCeNC91rIw5p7A0QSmqkgIAW6JCPtyejAF6EqkmOpY
         cmegdLZeheuPX6sdvK3/FQZirGv8h71b5HuCB8F0rlaovd3m7FP9XYpr55p13w2qHnkO
         JBQQl8k14X52feSAm++D99N7zaHyzI3odvGsVndndS37Nugeo6C8QuxHJFDHC6YsxUae
         YnT/QjDLO8yGJSRnU2TNfYTTq0hsUSyHYbWdP+Uxa5xDdqzDStZ76MjRnVsfbApFXRN1
         4Kow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792422786; x=1793027586; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/p9kG3mVIwDhglO8V3Ucme+ROyhYkCFN2qn2+pS+V4w=;
        b=qPDd2RZDvFQk6oZRHmZfvLiix91d+CJzWtcHJOc85JeM6ZN5HnYZ3EJWJnqaX9Sjda
         ZWvlTH2xB+a6zydaYiPdBXdYgQyuPJvmwxgvParRiHweSXMJMcbQWViXrcjGIsMCxvXe
         8fRCFP/QRPOQze6rJZHVqi3YjRru0olbkKzDOpZeRxJETQbb2hg1ir/9JXGpMft9thTn
         kqbzgtZaF+Nm3i6YGRwQ2dqhejsObLbByS9bSnt1Ixl8zVzGhK9xZ7bABBVDsUwaLXd3
         uN52waw5nySGpBut3yw/yH7kacWDqrbgn5Tw51xSamQPoT5o2c/UiQZvhD73EtjLdDqg
         2aVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792422786; x=1793027586;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/p9kG3mVIwDhglO8V3Ucme+ROyhYkCFN2qn2+pS+V4w=;
        b=Naf5j9whlsLS3G99KgEnUMOkcYla5xocC2yQwP1N7U4/C0nky0ATURFpE6GLYu0E1A
         r+d/Oi0GTDZgQ/OCF0GBbEs7RLNAeVqqXK/3x+TLKlYhf/AQwn44QaA4ogFJNHSgayNK
         oPTtUSBVD0Yv+5sbA6Yea3uB3KSLz4eVkT5HWuzmsktEevmQukmZoH5rPP7PVsTJtA/9
         aovYhqh+BYKK2X2EG+fXPFl74qjqNp43+wyp2iz9B2qq5LxTVedzbQJX2hrh+Tt6JsL3
         fBTQ8vRDPhmr7IXSPKPl0swxDmWSVnqonAA+L79GBXytRD6p5HylUQmRJJFAEeJnhv2V
         Cj7g==
X-Forwarded-Encrypted: i=1; AKwUvByP/459lwBAY2QIuXTumQES7zn6TSOWObO00wC0QNSNStlPUMqMUWXsEpfGoipZA2FQYHjz6T4=@vger.kernel.org
X-Gm-Message-State: AFq9FYINiX2b8VInPm66LRhbS8s5NogjSwVQD/sga13v4IZz+5rsYnhA
	OyRNfWmm1sDJ0Eu+Rv/gFCYMp/2lUSCCeyz7BF55lYXslJDL3lrtdqjHuwgsYLYC+LOYhlV+Olq
	NPAzHPsni6HHyA7P7oCeI9TmQyBOOub3zGLLtIcZx
X-Gm-Gg: AYBFou0TNtdARbWyGg5J9NKvj4zww3U2fPg0NoyH+oWsVTyngr7XAFn4bq6bz/4+g9U
	JEPdNyd9mAtCbV9PV2Z4aA5S7BQ6o3f10AGF7CJ6UhvOBS3NBPizGnoScn4uqyuAscmotwDoHec
	GjwODRhdhTHKY8RD19lauOQf5oH4uEryPVpx8r8dmq0wUrqh+UM8XCqxpFYYcmu/4vzO6+scC1u
	IVgYwlppBsdcg+mexJd4YCQC2vnbt+PSiPXGNx15NXG4x8W7i7fenRKG+2NYgM3Vtc7f2+vUrzC
	AUerWsy1Dj3+Xig0cgofioYdtCcghQXi5mrGv1Fx9Thl2jVL9XWYH70tcgnprmfxnpZycULIJZF
	rLLFN+nlgHnmrcYmGeL/n
X-Received: by 2002:a05:6402:a550:10b0:6ae:1503:5a27 with SMTP id
 4fb4d7f45d1cf-6b3ae3367f7mr84098a12.8.1792422784990; Mon, 19 Oct 2026
 08:13:04 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7@toxicpanda.com>
 <20261019-b4-skbuff-bug-on-followups-v1-14-41dbef50b9f7@toxicpanda.com>
In-Reply-To: <20261019-b4-skbuff-bug-on-followups-v1-14-41dbef50b9f7@toxicpanda.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 19 Oct 2026 08:12:53 -0700
X-Gm-Features: AclHuK9fMz77o2Ok6xnWRqmNEA6022u8uZTWFFEyJX4uvm-C0Gim7Z2E1QlIWY0
Message-ID: <CAHS8izP4qMy9MFxVrRAZR0sec-XmkuxShrPTe2XNvHSKdQh-ng@mail.gmail.com>
Subject: Re: [PATCH net-next 14/15] net/tls: don't BUG() on leftover length in __skb_nsg()
To: Josef Bacik <josef@toxicpanda.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 6:51=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> __skb_nsg() counts the scatterlist entries for a range of an skb with a
> copy of the __skb_to_sgvec() walk, including its BUG_ON(len) when the
> skb runs out before the range does.  tls_decrypt_sg() calls it on the
> same range it then passes to skb_to_sgvec(), so a bad range would BUG()
> here before it got to skb_to_sgvec()'s error return.
>
> __skb_nsg() already returns -EMSGSIZE for a frag_list nested too deep,
> and tls_decrypt_sg() fails the record on any return below 1.  Return
> -EINVAL for the leftover length too, with a DEBUG_NET_WARN_ON_ONCE() for
> debug kernels.
>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  net/tls/tls_sw.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 312e51270f29..1c578ea47a1b 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -142,7 +142,10 @@ static int __skb_nsg(struct sk_buff *skb, int offset=
, int len,
>                          start =3D end;
>                  }
>          }
> -        BUG_ON(len);
> +       if (unlikely(len)) {
> +               DEBUG_NET_WARN_ON_ONCE(1);
> +               return -EINVAL;
> +       }

Ugh, why DEBUG_NET_WARN...? Seems WARN_ON_ONCE() is more appropriate,
after all we're downgrading from a BUG_ON(). Another nice thing is
that it could have been done inline:

if (unlikely(WARN_ON_ONCE(len)))
  return -EINVAL;

But I suppose it doesn't matter much

Acked-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina
