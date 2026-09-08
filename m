Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8063B56B850
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882621; cv=pass; b=MZDcc9exCgmpRVe/3enG2DXslp1oygZ/qFaSTp34JrrVDxMTaI9Fo03wEmz+RElhdWOqg3frlrW/FK1TdrFBKBGOgJpyxlmIqYe60irlkcjfGqg+Ntx7sD/RFlTEzfPRa6bOiYfH0jMPCr+9hCSqB/q95ZmRo+2g/CeScYrE6jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882621; c=relaxed/simple;
	bh=Uy7d6cWsWhUqP4Er/V0wrHkot2OhlG/j1NYjesuetsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VdXVbZwSs2A8ATx0oyko5yspQ4WzgSc3r2G4eV7EUIgG/eL0M8Sn2ynE+Er83PtRJUMPxcopEl/hlfPKsNb3TOXNkNU86y1qPvKJ1EBqLJlid5WAfz3nyBo+QM3fctUXRL6g0fU3zbs3FJOZlDFL+tdliU9Un7yYSDuYLJR8UOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1iNWXGt; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1iNWXGt"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-86d43cdee51so58550887b3.2
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 08:50:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788882617; cv=none;
        d=google.com; s=arc-20260327;
        b=mOHGkaALxVOXtdXTVY9/puTczPwqjjpaRV3sxQXZ/IIxAIoCqjPqcinrD3XbGk7k8x
         pmmPKCKtaC3CINiNckjio1izuXvnqnrvcV9GVyioT1U0JJZlQB13mqhOt3rNFwyhXjt2
         0cyFVMl9iAVmOgKTMRjXuqDQ/9G8HPJEj++Izs3i15+qEZAfviAB/1G5CNRPRGwSvaaB
         cileKI2UbEhdgdm/DtsLvLdXSZ9Z5esp6bsVVhMCilrAnRSxhsiaWC3CSvZT4j12mj+c
         jQ9LJN6sx6B29SkZZFzI5XbjV2W+g13zT+nNDXuv89WhcmUYrbaKvBXqbsMM10s+IPag
         nLBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=27jc5aCnOb5lF6q1kPnA+hKgGFclE1wOxMyKQuZNOVs=;
        fh=4Q9tx/A1jVBObJZM/oU31Y77qQHJlTyq/JwbmAvvBS8=;
        b=fedhGUrr3fZfpzal/GRHW92SKyY0BxaKX5j8JzffdefbUD30eq+ZrRefzW+1Ify/GS
         78e7wgYLc3oGDCO0Ra4epI0CjK8u9hFBxXkJAU8shpex202fjuG0loihj9gn5gEbX43h
         AgNkmmW6WyRof+KjU9VrLG3dwjyCBI473QpM2cn1K8XSEnLFMY35Afn6zvszuIoPj+18
         4k4yIlC14gR7/VoYCV7h1+x11dAKsVz3fwnOl9AsBcy0oab6kmwklfZ4WNlXAvBJYc6P
         maGjeLxmL9l09vlkyf7UEy8TtaqOSwcP9tbQSLPp3MG94ANDTcwxP8WH0ByW84eFpbQD
         rSZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788882617; x=1789487417; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=27jc5aCnOb5lF6q1kPnA+hKgGFclE1wOxMyKQuZNOVs=;
        b=E1iNWXGtMPv51J939MjU7abiUREiKNwccdHMtBXqv8bnTOe4UyKByoSvLVlBpFRHCQ
         mrIInukZamf/3F1tPUrJgjknES8+JfLiOMiYrBkX4R5zx2BedIKk3zBcoIdu28vJA6uZ
         h3ctBuvHH2C4qYuE27bJxOy5lCA8P39W3TnqeNeTzWDjGQgzws+R4l19zWArIkGxdXWH
         i3hN62eATD57ELvLgCB0bUaAjxJuwjbg/HHQrSrQZLxTVehBTCdnHsiCplMCL8+RgXuR
         QqtDWjGki2+Tiy5DOOJ0fRbvjswZPu4RDkwOrlZDNMWlWzeziprQ82nhlAo6grMXmAnG
         1Asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788882617; x=1789487417;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=27jc5aCnOb5lF6q1kPnA+hKgGFclE1wOxMyKQuZNOVs=;
        b=qjqKFNvMcsoPHil5u1Na9TumsGkpbnpCsLcN7gCl6u/4CS2Cgz2+sxlBb0zgK0V/u3
         Z4bzXcryxowrhIrRDSNJlT6Mm8HfbvNMYEYuzDD3PXKUG+UoQxRlhAoFdMel53+aJ6m4
         h50rsq9OmawR7/Em8V0a+AsYxJ35ITfLXgwCJeHTgWrU3VK6SIrZ8CK64H21/1up4c9z
         Y2k8NkNOln1//CEzJWx2hwFRSob3brL+YoIRIIEyZkUa1rKGI36M6P9YYUMs7bZcdEz3
         XSlZcWP/aG9PVC6LUvDeSjS1hUS+qcufi1fOfth+oUORbclTNZTiVhVhlfDeiVUEWfsB
         5iww==
X-Forwarded-Encrypted: i=1; AKwUvBz5zEQifqVnGaAE9SJl++VbwZA6yuUd62JN9m3MYetDiqAq4JMuV0HLoPN6KrI4nZaKJ5hBK/w=@vger.kernel.org
X-Gm-Message-State: AFuF++mvUPjvlR97bqtFPUaone/tCsBYKgqYNgqYee9JYeJX2hfV9ESw
	jGdAiV9+sa5UNgxJxgHvczDvIg+soklthnIUgCkSi3nGJycM8i6f6ZbIPDm4agSgkcIeynoppOU
	lfqUMVcAdzx1U4RIf4AnB3AZinaB9tmw=
X-Gm-Gg: AYBFou2bU6yZx6iLlUK0O3jsVhm2zW2nbeRz8e39Hv9AzVdmVKixPcriqQQ02Fed5E9
	iIpkkJrkGABr9eLYjWC53ePv/JcUYUaF2wWv6YwEuUm174DnLNvif5srLnh9oQG/xjESRWY+W9Y
	qsIeEM+FxLrjLFYG2Vz0jyiUGWt/bXAqgVGipVcJc3+8/fupZpx0w06Jxttk40pi60g0sLQ7O+I
	SutxNDI4C/k+af+nh4ln+LMUJj4OYv6m5Ho0hH6+OUZzQRc70R46KSMxyum3plQWHnpXHf+57Tw
	V+WrHEaUs5vfL3A3bBjOZGPhOTpnGTg6OWI+wllTOG1AZFVCzlpgG4rYQCD2kL6B1WP24N8z5pF
	zdjlwA+jN/DtDxEUfVkIZTgCz5fYlFRK+ke0jpas=
X-Received: by 2002:a05:690c:3391:b0:873:5bb2:6c30 with SMTP id
 00721157ae682-8735bb26ea7mr83060557b3.55.1788882616660; Tue, 08 Sep 2026
 08:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905194725.284347-1-adrianox@gmail.com>
In-Reply-To: <20260905194725.284347-1-adrianox@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Sep 2026 11:50:05 -0400
X-Gm-Features: AcwNN1X37kIm8-OoWmTMYNL-mXG3nWBgvh6whzxNuC3s7FdK8MvcBiVvPpXbsdk
Message-ID: <CABBYNZ+_KZXEz2210xPShKy=baN2Xrd4T7YijdCn9y3h-t5V8A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: bnep: linearize skb before sending
To: Adriano Cordova <adrianox@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adriano,

On Sat, Sep 5, 2026 at 3:48=E2=80=AFPM Adriano Cordova <adrianox@gmail.com>=
 wrote:
>
> kernel_sendmsg expects contiguous data. Check the skb is linear
> before building its kvec. Should be already linearized by the
> stack, so this is defensive, but drops the dead block and the
> FIXME.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>  net/bluetooth/bnep/core.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
> index 5a6a49885ab6..497eb1d2d6ee 100644
> --- a/net/bluetooth/bnep/core.c
> +++ b/net/bluetooth/bnep/core.c
> @@ -457,13 +457,15 @@ static int bnep_tx_frame(struct bnep_session *s, st=
ruct sk_buff *skb)
>         }
>
>  send:
> +       if (skb_linearize(skb)) {
> +               kfree_skb(skb);
> +               return -ENOMEM;
> +       }

Looks like we should be linearizing earlier:

https://sashiko.dev/#/patchset/20260905194725.284347-1-adrianox%40gmail.com

>         iv[il++] =3D (struct kvec) { skb->data, skb->len };
>         len +=3D skb->len;
>
> -       /* FIXME: linearize skb */
> -       {
> -               len =3D kernel_sendmsg(sock, &s->msg, iv, il, len);
> -       }
> +       len =3D kernel_sendmsg(sock, &s->msg, iv, il, len);
>         kfree_skb(skb);
>
>         if (len > 0) {
> --
> 2.51.0
>


--=20
Luiz Augusto von Dentz
