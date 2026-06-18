Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470BF285CAD
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781783009; cv=pass; b=kcnu1jtHQVP8hfLH1car+/9UTPMcYDcelyggwblYYhE9ZlcivbOt+owTS4f0ZRqnTgO2o7R65TK5MbM91dWMscOmYOQYr9ZZGV9Ck1e4bKPDvf8KZ7e8q/tUjHvtcIlTHOMoX/kbCzS1AEkcL8+uGyluDZkFlDZjDjAt7wP0qIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781783009; c=relaxed/simple;
	bh=aiBMmDxUbkczn/Vb9JP5UZM5Zl61RSgtXrA/0C46Sgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skyjwmIebmef5hjpIu7GWKFCbxsRPD9Ylij6tyaKv/y4R4QtU+yQQAhiZNUoeFatcuEnXVXJu+d5dyd4G8GvRLhJg4i4Qb8YK3PtQWG/s7QFXeOv/wrETLVFmSuU6CBQUlFn3/ytYUYbXBb9vh0YrV5Fb1Ohlx0kZqAzKAOQ/CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ownrisk.dk; spf=none smtp.mailfrom=ownrisk.dk; dkim=pass (2048-bit key) header.d=ownrisk-dk.20251104.gappssmtp.com header.i=@ownrisk-dk.20251104.gappssmtp.com header.b=GD6oKj5U; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ownrisk.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ownrisk.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownrisk-dk.20251104.gappssmtp.com header.i=@ownrisk-dk.20251104.gappssmtp.com header.b="GD6oKj5U"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8db35680d0cso20008416d6.1
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 04:43:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781783006; cv=none;
        d=google.com; s=arc-20240605;
        b=e0d61fuJit2qoNbZzfdOtKoL6YNBxON1GgWUm/TV1RuZy4r9RkSEYyzeqtNM9hicQv
         cwSZ4Vf2r+9OwNJD+YT33gOZlGuLjh6W3c7CTNVq3kGWEP9F5OrhKblfBDJOSYYoJXLS
         1jMDFUVTAQ/hgLPYwgf2+8XE9E0D8mnOybUAbzsRvlpGfjNML9u1dixb4EA9f+taYoIf
         0SBs8ePyhe2Z9Zde1SgEChaVgQCxoIb2nmz2uKg52lIAN7L2HHi/8jpi0AKXW5jkiXYC
         QtOk4JtJaL8ERdCIf1jP2O7aHJEL2iOAR4syeoHLDaNmjCe1RO2KeD85ZXvV8PkgXGWE
         avfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fGm6AcqnI1+bNBW3QZHl+Bh51II3lcjM0XYTu8SKeS0=;
        fh=DmKPpRNOeQ7u47XqJ2kepLpxxQIR93iIPhkvTe3Vzcs=;
        b=YGt6Q65PSR1X2Im7qZRrdJnfg3k94EmyE/L73K2TUnLQC2js82nC8Xya0luO44S0Hb
         vDOfpXB6zrfSKvyPeqPXwqQritHjc5IaoOEfg5S4zrfCb3Vqc39iceVVuCluJpnMZjJJ
         IJtzJor3BHk+nHYMVdImk+FKgWWhlug4ao49t9Rud1/WuCgZgi6ZTBa3cHpxW3S2nLca
         xC4GWVMFGQCKsyieLpgYOhOYFSyrq402w0iwUwnOLQZEMbPelatL4zUtQS4IXkMa/WZM
         gmFZXNfjAtgj2RqiruOn6IXdPbczeAUzbiNvBb/fDnAerQfCWNH4W7OBv2CDcT9DUNe3
         1nMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ownrisk-dk.20251104.gappssmtp.com; s=20251104; t=1781783006; x=1782387806; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fGm6AcqnI1+bNBW3QZHl+Bh51II3lcjM0XYTu8SKeS0=;
        b=GD6oKj5UGQz0/vISJW4N8ZfulM+f/VNtIgZ04kem/D58fVFCTUAbD2XUG0ffd5ly2O
         +9U7KhtOyXohKD/6zYtmzyeciC/I0B8HXsjxEM0TBzDEIj4cS99M7f6NFeBW7uxdzfSg
         DBo4HLCBwg4KyHWjTgyZ5OrH7/NcMGebHnbUdGC0biu9vxID0Xh9xkWYL/yq/ujyvfkN
         rQIG4MTMt9bk4M3x9AHuRPEmPsJoHqiPhECcVVgc46GW7zayf1o4Q+060Jfb2EagClrh
         tXdVZxQGGjGTQZ0dh51lXWJYkx7e1zlVutNuWT1vLmT14WYKLvVF7g+MEbSISeWB7mdf
         BgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781783006; x=1782387806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGm6AcqnI1+bNBW3QZHl+Bh51II3lcjM0XYTu8SKeS0=;
        b=lf6SPL65GtNDgfEr/iAqrE1dxbmQB5INyXPQVhAAlrtNstpAEnF25KyB7ZCSBh4G0d
         MG3NJbkGNVZNydZ7Z+V+YShg82L/N7Wie31UB/0Yb0iOScIonxxClT+djOAW3M4D+Xuv
         pPnURdfK7l25zXnFgeGiqJ9cQByFcM6h7HwskkEeSo0D3RX1BqYrxgoZWshMXvNspEiz
         jiUwwwk3CTdG4wxjJTZcDNkK2UE1VcWwEZHRrXx3Wzw2W+djzHGEHSwPl6CNsqPeZJgC
         ueaAUQiVS8/KbeczyaZAmWKpZEh0hTbO1sVtEbHySWbgv8yhCmITSAHK9KURrqvR6X8E
         u8sQ==
X-Gm-Message-State: AOJu0YzE//NIovTG2+T9IESzo5BeCfI6j4KsiRKLqTQy6hnix+LjGACd
	XoNSR6JUDehnKnmA9V7HPDt/nfM5RAWXrt/KKv02/jUmWeRJAJSMjqNGxxdrKmlkLAVafrvHAYv
	x59Ve+tv9wHeWd8n+fKMo7KdAq2k/60Gu7wema12wzA==
X-Gm-Gg: AfdE7ckOE/CsNKWzth984zB09UMqEdvUzfirUY37kdMoNcZr3JkrWdQLZjD5Me3Ql5K
	fCrvP/cfdemvKEg4q9FVwoTQ7kT6IT/hji0Wf7bZYTr+wfxyWpV2nhyAeehNRukkQznk9f2uasK
	gWWiqPXzQDV9iQCczB6qUdhSKVpX1iQS8b3xbSw+JQY1TOQVIbU2CKDn9JV7qGFHa3Wji0kj4t8
	rN2Ig2TRMNSNJTNBXdgdhdBVX0nffBP+eYmw3w3jHuteLhinfRbXvHNkK7s8E+Hw6Kzl9fuqvRT
	QClL/2eaeR4RD8tjjW1Kl6mZMDuJ
X-Received: by 2002:a05:6214:4801:b0:8db:6d7d:b587 with SMTP id
 6a1803df08f44-8dccc14dac9mr52050636d6.11.1781783005874; Thu, 18 Jun 2026
 04:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616100332.1308294-1-i.maximets@ovn.org>
In-Reply-To: <20260616100332.1308294-1-i.maximets@ovn.org>
From: Johan Thomsen <write@ownrisk.dk>
Date: Thu, 18 Jun 2026 13:43:14 +0200
X-Gm-Features: AVVi8Cf3XOkaQmP6GH0ARFvC4rsKf-fMT6mtyJYcQfTm0vSkjjtCI2heDspnweI
Message-ID: <CAKv6aAMTqSo0qSng2Kv4=i6BSvJuUy9KSfeFRYx5JsYuo9=kqQ@mail.gmail.com>
Subject: Re: [PATCH net] net: dst_metadata: fix false-positive memcpy overflow
 in tun_dst_unclone
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> Johan, if you can test this one in your setup as well, that would
> be great.  Thanks.
>
>  include/net/dst_metadata.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
> index 1fc2fb03ce3f..f45d1e3163f0 100644
> --- a/include/net/dst_metadata.h
> +++ b/include/net/dst_metadata.h
> @@ -164,8 +164,11 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
>         if (!new_md)
>                 return ERR_PTR(-ENOMEM);
>
> -       memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
> -              sizeof(struct ip_tunnel_info) + md_size);
> +       /* Copy in two stages to keep the __counted_by happy. */
> +       new_md->u.tun_info = md_dst->u.tun_info;
> +       memcpy(ip_tunnel_info_opts(&new_md->u.tun_info),
> +              ip_tunnel_info_opts(&md_dst->u.tun_info), md_size);
> +
>  #ifdef CONFIG_DST_CACHE
>         /* Unclone the dst cache if there is one */
>         if (new_md->u.tun_info.dst_cache.cache) {

Hi Ilya,

Sure. Just stressed it for 24 hours and - I cannot trigger the bug
with this patch applied.

BR
Johan
