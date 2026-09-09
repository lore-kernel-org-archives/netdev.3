Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0EF569F39
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970747; cv=pass; b=ufoRaM2wrnIpDhMQzRY++42gbacidyeEeY1Kk7ChRUU/JnwFjzuQCYa/hYVpVWXctVsQmt+o8Cf3A+WJ1rzDWFo7/iQG437eQ4A3X7WKwCcS+kq1VH29wr9MmOclHZnMe6ftVz3DTM0j1gAr/UEuRRC8vxUGhmNlFlDR361N484=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970747; c=relaxed/simple;
	bh=jNYZ/e9tA0bZ+daU+gREuhraXiyCzcdRSOIl2qdMcWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rn8sciuRmoKB1z5HhECoWpHwWOWbBkS82eoS64ruxhkQbnrIz/W5d5KG2ghBiXPrtAoPBGytIpvsgHEUmw/wUsTlWtThVo5Hd92AjsDV4rupWc+WZab7FvLv55znQsk4b9gA5bqdKtMZL4qw9vFOErPYhwNiNa01lGzsM1d4FYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6m3Pr6V; arc=pass smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6m3Pr6V"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6b1ae716867so702792eaf.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 09:19:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788970745; cv=none;
        d=google.com; s=arc-20260327;
        b=mP8hrgiPTRkCzSXK4c0OVac/ttd4DRP8i25KbHDzOX3fFO6lqr0+XKW4+wsq66Lzhl
         0zF3YKhwgQ72A/njOimAcHo+wq1n6Lbk1wcNh/ndhUqRKyUFGigM231PuGhrPRPm4c2A
         5zWeLTqPc+vhb/1XRmO8SveYmd4nLcU3AeMTdTEV6sTW3iaQMeYF+ccus2E7NSY2hulY
         O08wRvsayq4F1sfIbZFF3INZyQ/0kTvJFvpeH6QRY24S4YTkr4GJmF7YQOFU6bDOuDAc
         1wf27j6NtmxCy6THGnmE6bBFtrsODjg7nWl8UCUV+x3Mfqnw3qXwKX2A25oTeOgshNGn
         IIJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hAUbchDH9m45dgmc18rC+fxqU5ICx7ntiYK3bF/7BEw=;
        fh=NF7/GI8XOrpWVi88wyEu90bmBGJNPqwlDUTSHVIOSb0=;
        b=HnYUBGEGMnbbZel5mJShegFHqlkxyntdG216/GcrpBqxMSzeSOGY+xQgAHb2sX2xt9
         MDjNZQn6blKpN9Vedkhz9zVOmUGY+wsQqITcllNaqQzKNY6UGxdWUE/UFJoLzSGIN8yC
         j+3hM1P8LL05Ktv1i0GThK0CUUJFVf01LGYMlydKeeEXFtX3Csg5yEUq90tX3Eo8cQLW
         3hlo6yG06ahtUS5Uoi8ER4OmdbiK/M6FEwVgVkLGZsiCgOvTCVvv6TZOx9I50PED4eqS
         T1ag/w3yLWsBT5ERI5f9K0I7P46+gauzOMSaFCylhsVRXOb+qURTsK+OXl0FdJ2n8f6k
         ZW/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788970745; x=1789575545; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hAUbchDH9m45dgmc18rC+fxqU5ICx7ntiYK3bF/7BEw=;
        b=X6m3Pr6VVhpvjgQjK1nepn79bcB1/ht3RripIDXTwx2TBUxQxS5G7l8KOqZG6nz/Zh
         FwXiJspPnxBqgbcBy25r0esh2HHyE6PsPsdEAN9noKdHODPXXHf8wYONY77oC9bW56LE
         C+n/2PuxOXREvykaeuK4KMoNDJ2BIsetvftganLOm5gcZv9M0El7JR44Ta35L2WoYHzb
         52Rx81HUPylSk0wxvYzqS7wyI35FbqcvWPitoghVZzc3/V+lCWysHuTQplqDoKMYm1I7
         NizaIIjKrA/YCMsgzq8a7SL0BOyJG5jZTPq+8UxCJzQMr9/IdFvKuPfAF6DsXUzuHveS
         IUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788970745; x=1789575545;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hAUbchDH9m45dgmc18rC+fxqU5ICx7ntiYK3bF/7BEw=;
        b=j11KeeUaODTeT89KrhOSFKTL+tAB8qsYo++c2D3mdBfrLfN6g04hevLJULFfXw5sDv
         2BBu7o+rY6nwoaCKenCJefVSzgWRI3ug0uYk86PGZ29JcGBUFzvET4ehQHj79zyYBexj
         Fmv2Dga8TVnBSU2vXjr6LGlYJOA7mB2J54L3L1U1FD5RVU3uJsjsPPRGgGG+uzAz2+j3
         zXb+ei0t2X0vur0/onANhr4TD5uEserDpGtirsdHHnX098Bv/wnHFwcFdmFZr7VX527X
         3cFzCsNPEB1dOiDa/RdDt5FWnuA+FR2SIVwtcG0trVV9U4/XH1rwjgCxeR8KsOz9GY1e
         lyKQ==
X-Forwarded-Encrypted: i=1; AKwUvBxmxmrH0//2DJUEMtLUDtYGo88rcXEksLYkeVDU8BjZqcJucHR2fZpFnNq//riIAO1EhtMoEU4=@vger.kernel.org
X-Gm-Message-State: AFuF++lyj8yZrVQaNqJIpFI468pREyCQL5QJJUafaUJOs15r74XgVgZH
	H8jMhsjKaPuac5dXwdoqNwd+bTasp3w2eRYi6o3ix2WMrvPCr/AE7bdWyf8ign/IJfmUWb+tzuT
	sfS7Ol1ZN5uiLl7ypStVDjD88MYGXxRM=
X-Gm-Gg: AYBFou2iP8g5YBvM+LSHpKxsSOIPQqsYIzNuz+tCT7yzSAJOnFmq+CTxLHChsWGX4vS
	+U1p+jNtevasQ7TI0rUsfvcZLWwxoRi8wNbg3pM7EvTI4U54iN7Ug0FdcdtLkwH0nitTmrkjFk+
	w5Q3nqkC+ajOeyX3FuBQhKJ3sRqh/bC9cHFtCm2WWuqWqevWb4A1xe939CeQ3E5qy2JiObTMvs8
	wrgIsTtALRf8ZiJVVJ/767y8aai+LJsTal4NaonywSI7HzAkI+VQgsgP1rLmOTxhQnnGdU+vS8w
	QZma8BFSm7eZL+vpoQajLI9HRI3l6gRjDc5uWgFTEZUiCHNQBXJvzxQj6wwqNChrtOjwSMLpIYT
	epXwjqSUGDwDTkARwhEadqs0=
X-Received: by 2002:a05:6820:4c10:b0:6b1:62fd:3b4d with SMTP id
 006d021491bc7-6bdcc1a4333mr7206501eaf.21.1788970745040; Wed, 09 Sep 2026
 09:19:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908083614.2210505-1-kyle.switch@motor-comm.com> <20260908083614.2210505-2-kyle.switch@motor-comm.com>
In-Reply-To: <20260908083614.2210505-2-kyle.switch@motor-comm.com>
From: David Yang <mmyangfl@gmail.com>
Date: Thu, 10 Sep 2026 00:18:28 +0800
X-Gm-Features: AcwNN1WNDNfMVmBhvlW6uZJv5v4eYnI30Ge-2mYnVT8Vfeo53MpIQ6A1zZKhmlE
Message-ID: <CAAXyoMNkvyVN435bUwWuN+q8UmKbwnWbn+=uWt-nC2omBk94Lg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/6] net: dsa: motorcomm: initialize
 dsa_switch based on chipid
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com, 
	jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 4:36=E2=80=AFPM Kyle Switch <kyle.switch@motor-comm.=
com> wrote:
> +       if (major =3D=3D YT9215_MAJOR || major =3D=3D YT9218_MAJOR)
> +               mode =3D YT92XX_MODE_YT921X;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(yt92xx_series_table); ++i)
> +               if (yt92xx_series_table[i].mode =3D=3D mode)
> +                       return &yt92xx_series_table[i];

Still redundant lookups here.

> -       ds->priv =3D priv;

ds->priv is gone in the new register.

>  static const struct of_device_id yt921x_of_match[] =3D {
> -       { .compatible =3D "motorcomm,yt9215" },
> -       {}
> +       {
> +               .compatible =3D "motorcomm,yt9215",
> +       },
> +       { /* sentinel */ }

Leftovers.
