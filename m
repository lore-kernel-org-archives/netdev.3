Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287D73385A1
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 10:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890419; cv=pass; b=Eqt0IBe3CaJPNanX2h/bhuJPyAIH/YrXstaizCDoV8rbfOVSa+xWPxewTj9grW9RolXbbCx385HXFOft5zWqhKXyXd83xYULOzEvXRF2jUG17pdppUtHmGXzNj0NiNvO7OkH4hWvtg6Ottvv2Vgs6u5935JzIbtGD1qxEaFCtdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890419; c=relaxed/simple;
	bh=yTt+PmUwBEh9/4jJzvMi6zpllsE4FD4FcrBiIE8ExBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gI6BCLg2X4rV5+qXGkVXW/VhKjy5Qdf0ArJrxv8ASnM5c75ajlOD14HwsxvUkKLY8vaVjKEeLXeTYk5rQAzfAnqbCA7c0OD1QZ9hgEfOsMQu+0T4wfMCMBxp40pulddV6o+8B72uWZCv3ewp4nYwLoHKeY6Bzgu7scmcUICIQJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dkroA+sB; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dkroA+sB"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ff88549786so2819006d6.3
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 03:53:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784890417; cv=none;
        d=google.com; s=arc-20260327;
        b=CQ9Zncctae27AC3JvLjbiK2umhG5LGhnzMmKiOqOxGSgZ5bVfekpMVEzRGgS6IcRyq
         X0aUc6zJ12PZQfxjqMuXKSEHetLmGYajrOqg9JDdOzRu3IyMADdWX+wxNhjy14oGw8Mz
         +0okxbZbRB6OXit+hhY6K3lC1LsUJ73drKNO6EGcBb+SPFlSwze40D1FjvJ1kdmNN4wr
         jAT8fEFadwmBVT+R5GP6B8kXBnRwzubh8WgLYLAUz8g7AasjQZiATpyu7DgCG95rX4yh
         kIKwiZSCXfvy/jNENDtOJH3pY4QmpRq3jMPGoVPDYw/NVX1ty04/nBEBu1Mp+pvViP+6
         JQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wyl4rnst1YMR179kbNPJ2Yg8IA54XBj3NvX7CD4CeZ0=;
        fh=2cdzr9cZUS/XJeLVOVZAy0QW1C+5GSwNOKrJ7LeHejE=;
        b=YJDDwizbAF27R5Zs2NiahMFI7vh7NGd8bX1uQ9S6sqOGuCWu642Qo1fQJAHHc0fK4f
         abbs1UBfMG/jskF5AGVFdF1su6ImOisI0CYcXDgHDWNcwvA/GOYDrk1CoV2JTlO2IuFE
         eBsL9zyBXmGclrnPsByZMiFt4Gt3w9vK9WB+ovUzahl2u0/uHnk6a1MNNlSTFSsCZD/6
         ZyL2Wu/zgCWosao8ZIYFeAzf14B6v/5TmGa0aiG/zYbQeuTvhpn2T+TdX0LKxCYUO2g8
         jNs24jM+PXT5JXxehaooMuc3o6QoO+IZKlj8ADLKkCUKLoK4Dk0DJDJAPO+KeQHpNqv4
         SSyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784890417; x=1785495217; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wyl4rnst1YMR179kbNPJ2Yg8IA54XBj3NvX7CD4CeZ0=;
        b=dkroA+sBkJjWkXLTiLidOpTGb+CfQoQD1Gy+oEGLRSB0Y+fr+MroeMTUnDzN/my0sx
         Q3M71QO2sOATfnMyOpfENqSkIa5YDi3L6BcusDAyq3OsvsWz65QeYt4TJE2upWNDGu0e
         68fznCrzdmY7wPWlWm6H3aRXBHjR8Plp/2gNgqyWl81iEJ4JgmuqM4mW6nBw/aVv/95Z
         u2VoUt3Td4xe2GzqErU71qnLUl3ZROIqPvU1xUtv2ABzWl2h7dWtHk9xpCHrcn8P/btM
         di4xQFnI7pzRSl2zVMrSVkKfDgPyQnlMKWB+CuyInXJgAM671xc9BDUkt7VZA975qUAO
         zywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784890417; x=1785495217;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wyl4rnst1YMR179kbNPJ2Yg8IA54XBj3NvX7CD4CeZ0=;
        b=LFe2gjQJS4/XZdfE9BAqWkHP7MoXwk9ofWX9gUgTwwT0EvgrZL/xe2yJWEOay8keAX
         bThy7MEMHyDbS4J6R1FLBxV/nLE7XDTBwldb6TWJKxjtUvS4SBf/44prSBYpDSgNejJu
         yPCl3m9Qk3VKsX0vtKOOi2+2wWKK0EItjmdThHCo6cCA+rOc63VWBsEqA19NwXAo4PMH
         4CDiYN5ZuTyhvPi876FJZBYJ0dsZZot90UicNAxLnV6kweWelBPEkfpuWnw4+AzpeoVI
         cW3PVfI6P72heXWpJyN2d8v2NKCwhxbHbceJYWoMsW+wERdJ4L5MUDmuJlj8uz4uBETe
         w76w==
X-Forwarded-Encrypted: i=1; AHgh+RpUso2qza0Svtb3/QARR6GccJQuDzb2s1Z/NqufmKuqs5uZxx2P6s54cglfrVm66dSZvnuHEbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJuZsgu54HJ7h6dbI2jq+kU8l8tT8yrgDcSpI3BLKA+7H1NtcJ
	FLqevNlnb2ossVxKXhMUhpS+LhM1npvAesXaMY52bKIOWJ8DWUeEe1rQmD4WrPKfz9FTCSoyRSo
	gFJt5U9sTbingEoj1XqKmUG/mt7Z8GphbIwTisX69
X-Gm-Gg: AR+sD12K6NQdmxY6gb6ksNzwrZfZm/vDAwV7CamRXTYx/4PYEQBmteGbGFU1Uu03Gb6
	k0IBLDrLzwRoDouFDp8tpLEWHDnsE0/Nrs5aS2kn0yDw5rV86AJ4CIBxH+gNYstZgzt0yfmp2cu
	c99zo8xumFFV7RyMGHsXYeZUyO6qs+Olw9N1wLgoHBcaXXqRpQ0YwW7vLjaqkPj6XUcUG0RjW98
	VrgZX8zPx9RiAeDAxx3ONQMW05Ta0OzshccxJ/gTGNWRap7t1TOTJKJ1nl/TZD1U00tld50Makt
	9C0Y823SD7pFQKn/oOPseWa2y2Hk+lLfcSh7cpj8WUtzT+m4qqWzoDuJaSrBjM5nN7sUx+asS1g
	ibLQzx24=
X-Received: by 2002:a05:6214:5b07:b0:8f3:9586:c179 with SMTP id
 6a1803df08f44-907ca272ee6mr73480526d6.17.1784890416397; Fri, 24 Jul 2026
 03:53:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724100832.59153-1-mohammed.hashil@dicortech.com>
In-Reply-To: <20260724100832.59153-1-mohammed.hashil@dicortech.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 24 Jul 2026 12:53:25 +0200
X-Gm-Features: AUfX_mxbHRuHgNGZRa10mYcjhIbHL7XG-sbSuXQAZeEnv_17xTos_R0xRu2zkzg
Message-ID: <CANn89iJBGR76nTnM+4AujrE1oFKRa7eSYSCYnMB-9S6cXZMq7A@mail.gmail.com>
Subject: Re: [PATCH] macvlan: inherit needed_headroom/needed_tailroom from
 lower device
To: Mohammed Hashil M <mohammedhashil786@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mohammed Hashil M <mohammed.hashil@dicortech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 12:09=E2=80=AFPM Mohammed Hashil M
<mohammedhashil786@gmail.com> wrote:
>
> macvlan_init() copies several properties from the lower device onto
> the macvlan netdev (dev->features, dev->vlan_features,
> dev->hard_header_len, TSO limits) but never copies needed_headroom
> or needed_tailroom.
>
> When the lower device declares extra needed_headroom/needed_tailroom
> (e.g. because it must prepend/append its own hardware encapsulation
> before a packet reaches the wire), a macvlan built on top of it does
> not reserve that space. Depending on the lower driver, this can cause
> outgoing packets to be silently dropped instead of forwarded, since
> the driver xmit path finds insufficient headroom and has no fallback
> to reallocate.
>
> Fix this the same way vxlan already does for the same class of issue
> (commit 0a35dc41fea6 ("vxlan: Add needed_headroom for lower device")):
> copy needed_headroom and needed_tailroom from the lower device in
> macvlan_init(), alongside the existing hard_header_len copy.
>
> Signed-off-by: Mohammed Hashil M <mohammed.hashil@dicortech.com>
> ---
>  drivers/net/macvlan.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> index 9a4bc99dbf53..70219011fcb2 100644
> --- a/drivers/net/macvlan.c
> +++ b/drivers/net/macvlan.c
> @@ -954,6 +954,8 @@ static int macvlan_init(struct net_device *dev)
>         dev->lltx               =3D true;
>         netif_inherit_tso_max(dev, lowerdev);
>         dev->hard_header_len    =3D lowerdev->hard_header_len;
> +       dev->needed_headroom    =3D lowerdev->needed_headroom;
> +       dev->needed_tailroom    =3D lowerdev->needed_tailroom;
>         macvlan_set_lockdep_class(dev);
>

Is it related to my ongoing work ?

https://lore.kernel.org/netdev/CANn89iJWJD_KXpeDOne2ujeznOADV8O=3DrU5+jdqQF=
6YMEkNkJg@mail.gmail.com/T/#m6b1804430c89c778733d69441aea1b87ffe79f0e

It seems you are trying to take ownership  of the discoveries made
earlier today.

Please don't do that, especially for your first linux contribution,
this is not how things work.

--
pw-bot: cr
