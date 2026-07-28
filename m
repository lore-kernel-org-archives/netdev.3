Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F543AFCF8
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 22:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785278215; cv=pass; b=t2yhPld41enNSxqdZFVMLEDNrozlXXr9KGYQjyHBQa2//QRmAKDzX9zKn80vdBJATc1EXoF9cncQphN0pPHkGHHMWWynzDXG06luKrIbNAmiq1Cdav/YMVAY6tSYund8gpT5DWTrCACqJa7UuSSS2Fpbi6r62tUdNG9aIbsN3iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785278215; c=relaxed/simple;
	bh=M02jLnDZLppEIT0nRxyvQ22mYICb7N7bMg3FU3PevXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGRKLWANZkVE1c03c3N09+ewdh5PMwfReddMY884xYqLZk9FKqrfXv2SRTJJwbLe3Dc9I+dBgdt0xS1l9LJJdjdCIXfO83OlqUFE+rX9N2AvaSz/ho854DtJp5SP7QB4EuNGVMSH0Fout8fsHN5GTodMwxhAlpcdmJDrCwZYh9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IJwy8D6l; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IJwy8D6l"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c9e7391839cso260347a12.0
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 15:36:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785278213; cv=none;
        d=google.com; s=arc-20260327;
        b=AcvndxH+XJt/AB+iyuDDZlVIPIV0Bra0iciDuZl/shVipfzhCGYthuY+Taxexswr3b
         SfZodQcgirqYNfSIexkvktw3bROrjEPB6Q1QhfRJnyOy1tDf7r8fGuitDabntZ+w1Nl2
         Qr1AthFkAeOEXgrty9MHCKQ+qXw8LlX+hOUOkL5Ds7anOG2ucp37leIaXs6DR8fDkxz1
         L9t7fm5gOIy/S7AY/5ywZvAGSyw16EJiAFi4CN/LkzA4/5dZqj4+1BV9tEq6EPKp2+rU
         XRe0tqR2RYrmTaCI0E+F5LBqrE2rcNQWg67aEWfKr+DX8g/sf9VqYanlmPtO8Ux+bjDF
         /wBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CK0107H/XBboOND7aXv6xIaoAuH7/inIuXb8QL0cJnU=;
        fh=t7fsSUB5dPTzpf2l48To1i93b4yiIZsn6m1nB0TbE3c=;
        b=byr0WgYGswz6RcDPXTQKVQeKFeXN67d+JCNtBNLYeqI9olK2ld55IjBAvFJJFMyj9p
         I/yQI10JV9tbYFK3PmB2yPgBCSjKpkKJpBUh788sDEhzGi8Rr9OdkMH9COyasHd6gH+3
         q1CoHDKWC2JMwqKJg50qam8QV0aU8JRK8l5J2vDbmwb7bX2oHrYDNqQhuoZB5uIRru47
         YW62QfRSWoDJuyjeSj1uDl4RpFzlItfpn9JwL1DVBk6LSo2pmlaMQINbpFeqNbZEOJeK
         oQE/hukccDnCWURbypwDvU1DLYpIlPfeTjxdg6RqbTKQzVjC7ygL6jraWPp26XMfOG/N
         HxUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785278213; x=1785883013; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CK0107H/XBboOND7aXv6xIaoAuH7/inIuXb8QL0cJnU=;
        b=IJwy8D6lujjUHHh08/BDtQ5FoVOWl5ZdjiXCd44fBX+D5EokCJcVE1P/qBpIyjUviY
         HIEIrud+bRT0EZTUdh7yta1Wcdkjxv0LtcbAWE0Qxd3I5ufsl0YkzhgHcKiGITd3FLj+
         WozEuTXLtkaNEKBiCy/sMWfmVmbfdD6WYpso2FhC+JOAKSxx8l1IbQd8gfhwuuLzvNJ6
         mC0tT0iP7gJMWqHoKy0LcqtOEWP2n+GO9Mev7IarAHneZINX9tpzLObsviHFP9UZ80EA
         Bf4ityBX5zcQhFc1SxpFr41J9oAq+hxoztPYSFXHc0LkURgVqOEFVZGhxgwWJmgwze/a
         9RLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785278213; x=1785883013;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CK0107H/XBboOND7aXv6xIaoAuH7/inIuXb8QL0cJnU=;
        b=aUxo99Q1yLYYExo885zkEcmYNui7oUqnOsamihB8DSpbYv96N9utc5Kyfg/gPxnVW3
         c9O9SCf+kamwCQpSCk5CkqveMUt0iO+2VP2L4sXIzFf/oAKnFssUHeKXrv7gw3+9h6b1
         Rpz9FUb2c2DLA7PxV1+j1/seBZI9HkHe0s1nkkwWKfVVzqwKrJH+MWGxiAfIHPDrjet5
         q0sXMGkh+CLNvHwLxujmx9Ffe47zqwUcdK5QYxOdi1wm7svw15P+hf64yT1L5W7N5ajD
         MZ9bgMcq6jtyaFO01uirYLQyvG2NEQUvSXDSZumjaA40RP1kYm4CMM2/lHCuaUOjbudY
         qAvw==
X-Forwarded-Encrypted: i=1; AHgh+RobfCPgp9IJwU5nVwRscArXpn1M4YIJcYEUByMlrDgU/cLgDjXdIDvpkVS8jTqIolgtxeT6mxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTneig8NAJFL4A3yJj5WBhapvPqyIo65bdSrBRVmp5E/3r16+W
	0LgZbmQuvowkOciSMVaylaFx/1bjY1sLBfWaKGIU3FsQPaGfhfvYwe17eCnsy6Fk0U56rJ5tg39
	bAhq2h1YEEYQ5/IinJm9sob9llz4bmOzbS3unCB4i
X-Gm-Gg: AR+sD12WoAmSzAf7fMLE5ghoXUSdfZdCmD2PLb4i3jqpXVD3rRwlBAz+J2S0vDGNMZ8
	pFKHMhiKqbWVJ7JXKGChYz9SUAIhIHQO7ANAMhgacdZSpc0f/p0C/6u3lB67X5AtI0stgEcdvz2
	0VyD6iujeinsABp4y9tD9IQqjBQB9IBdVJKLnuSySuXji0+wmVIciyAbrAl6zkO256SgrAuT5B0
	ow3hzM4UtWtztJHwCVxFq82CjBIfT0y5e3EyYnYgqxTYNsa+sj4eGBTl8T/PPqfxEyYzey44FDU
	TCjbdKenASIvj+9mqdtqdEgKLVmRxxZPFIVb2SkpTFF4
X-Received: by 2002:a05:6a21:7014:b0:3c3:ab31:3d1e with SMTP id
 adf61e73a8af0-3c8ba615352mr5002886637.56.1785278212764; Tue, 28 Jul 2026
 15:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728031043.76586-1-heminhong@kylinos.cn>
In-Reply-To: <20260728031043.76586-1-heminhong@kylinos.cn>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Jul 2026 18:36:40 -0400
X-Gm-Features: AUfX_mwTQWe6xSVtI_LXuNihbnOpbogzumOUuSpTL26BeefKmQtgAx1E7SqTrag
Message-ID: <CAHC9VhRHGYLeq9UN256DHNWx_Hyxo47SsHSDo+bJHX9rg4hHow@mail.gmail.com>
Subject: Re: [PATCH net] netlabel: check register_netdevice_notifier() error
 in netlbl_unlabel_init()
To: Minhong He <heminhong@kylinos.cn>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 11:10=E2=80=AFPM Minhong He <heminhong@kylinos.cn> =
wrote:
>
> netlbl_unlabel_init() installs the unlabeled connection hash table and
> registers a netdevice notifier, but ignores notifier registration errors
> and always returns success.
>
> Check the error and unwind the hash table allocation on failure.
>
> Signed-off-by: Minhong He <heminhong@kylinos.cn>
> ---
>  net/netlabel/netlabel_unlabeled.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_un=
labeled.c
> index 47bae5e48db6..34704f6eb1d8 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -1397,6 +1397,7 @@ static struct notifier_block netlbl_unlhsh_netdev_n=
otifier =3D {
>   */
>  int __init netlbl_unlabel_init(u32 size)
>  {
> +       int err;
>         u32 iter;
>         struct netlbl_unlhsh_tbl *hsh_tbl;
>
> @@ -1419,7 +1420,16 @@ int __init netlbl_unlabel_init(u32 size)
>         rcu_assign_pointer(netlbl_unlhsh, hsh_tbl);
>         spin_unlock(&netlbl_unlhsh_lock);
>
> -       register_netdevice_notifier(&netlbl_unlhsh_netdev_notifier);
> +       err =3D register_netdevice_notifier(&netlbl_unlhsh_netdev_notifie=
r);
> +       if (err) {
> +               spin_lock(&netlbl_unlhsh_lock);
> +               RCU_INIT_POINTER(netlbl_unlhsh, NULL);

I'd probably just use rcu_assign_pointer() like earlier in this
function; whatever tiny performance bump you get from
RCU_INIT_POINTER() is wasted as the kernel is going to soon panic in
this case (look at netlbl_init()).  If you make this change you can
add my ACK to the v2 patch.

Acked-by: Paul Moore <paul@paul-moore.com>

> +               spin_unlock(&netlbl_unlhsh_lock);
> +               synchronize_rcu();
> +               kfree(hsh_tbl->tbl);
> +               kfree(hsh_tbl);
> +               return err;
> +       }
>
>         return 0;
>  }
> --
> 2.25.1

--=20
paul-moore.com
