Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792664397;
	b=Hs1ooeDfMLBv9jB9ZyJ0ZyswOtLPkf0cfrlhoVrgdR9LIQxTMNyATUe5bMh3ofH6VD/j
	 dokAgVV1FUp75idOLuOauPp0K9qQuP5bgC17CWRwp/XxIV7ef3Z6EEPhyFxGDKwmDbN4P
	 TZzAtQPo0UxEYkb5HDfYGVT1QReh9CdbZqyV4+6uAHnIvzAN5qbPy5iUILgy+A02ZMygf
	 ZMuwuOABQzj/dOWjcMyuY+JNp3vOADz0zXHp6ZXI3Q2p7IPU7uD7Xx36hKqYqHPn6OiZu
	 o5DfUU8Ml0Mh5jFHC6PcbwLIwQWbu0S9PnidmPr/wIiRnYF1QLn4sJpXImbBoNkSGRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=8RseLjNm8lG/7UmlycVln9er/NWi2dNp7MDnl6ITlr8=;
	b=ieb4A51EFNz5JjDclZlTu8aR6EvNzNJDKbyCeVcuCQJwjlVFBW9eDea2NA9cX/HrZwUt
	 A63VUf2Fm6jXSJkqbhLx0WW9cuNBZdQnXHEECK1DNP5c0dnhcD5JmLmALQp9nsUmd7Jv0
	 FBn9FPP28yBZHkboq33auBjQKg/TKFQ5+iegEs1BGLtIDDuLu+5JmtasmoXKe7oUPyaBl
	 gQARZ7VMR8v7qk6B3kRrt+O3ibp0YOyaTBm/1xS4W5jdNcBuANOVtl2UQht0UddWFCtmP
	 jO5hmoMMGu2eoVSfIJxvM5KPrecVYicgpWWDpcBLtIZoQpP/V9TMYXUBNdeIggj5i8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aUJzr1v9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29380606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29380606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aUJzr1v9
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53512cd2f85so18613331cf.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 03:19:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792664396; cv=none;
        d=google.com; s=arc-20260327;
        b=CsF2cg1oimvidp01gVem5np5edgYqUoLK4Oy/uiW1pH1B/9qJP/x7aVSPUCPxBiOt9
         ODusx3B932E5b+sh3oaBeHINQ46PMfbu8AkFywUJqqTrf8AwPOD78B8IcP6Ogk9i50VK
         eFyIc503cv2fVPj82TQf6nqJjhvwcRPDx9I4sutxY9daRHBMrVcEiOrLGoZwQahe3ZRo
         RlFgGhm6iLWVjxgwSec21vvBtEdSZcp31fscgrskk/vN2bTur6Aaj/ClZiBYtpNRKIOG
         ruZYf12wNu4zcIr3MAqID9vag1fah1P1raCZU9SP9B3C8xCk5jbsrNWNUdx8JZcCa2EJ
         57GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8RseLjNm8lG/7UmlycVln9er/NWi2dNp7MDnl6ITlr8=;
        fh=+GTl32xhB0PQyfLkznza3cGvOGpdz8qXOUq4ugwNBWk=;
        b=VbjMBtr8lq4pG5F4byol5Ayy+57894kZmNyA7rNWRKnP+yQHug6oKIYEq2F7KkQwE6
         ukL4Zf+53C/BDWNWlXxvnAZAMVhmrKPxnS/jiXB5us12MKrIgXCZDnbi0fK1XFsZ3h6q
         ZU4ztHX/wjs35OwiV7kKOsd2xldD4wBWmdFt/mGoHwqVDGKrV0a46dQtxY+fecmi0BVs
         0EvVMxNVSqT5tTm+24PtOgvfFkxjtme+F6SzeWyMrLO61xyEgH5gAsFAai0b5R6XB7oR
         zVofAr6Fbc2ncMNobHFykfK0GC8lLj1envd82/fn6TRV1aeYYhZDJRvmqTHSz1jcja8f
         XT7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792664396; x=1793269196; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8RseLjNm8lG/7UmlycVln9er/NWi2dNp7MDnl6ITlr8=;
        b=aUJzr1v9HCvAKgJ2UTSl8mUeU+wQVplCGtZ0YUMOEGg5oZysXD+REwtONRHf2+MJaZ
         TwbRR8NGkA5aslgmvc+A3rI2NLGykz2FM0Y235FgmMy2pN6yoonoSjsMkmV2qHLsrzrS
         ArykiZlvdF6zdtSVaQuQdjwN0UYexGcAi4UAXOwm2Rq7EYHU6ABZDFMkZb+dXNcPUJbj
         I1ZRscTqYWKBiZM5BvMddh0R4SUTA/SazjdbXcWkdOpBVSA+escj8OFMeCdv2lKxXlsB
         kAhaw/CBDr14ZkanQZgTp0YPRdGdSF7aqYsnAceXTbiW8azyhku13EGgH6W3WZJP3d3e
         dBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792664396; x=1793269196;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8RseLjNm8lG/7UmlycVln9er/NWi2dNp7MDnl6ITlr8=;
        b=Pnij/2MqrjkxgKYS2b42zMgaBO+QpTXLLAQQUNoSrfv6jAhNwJSuNv6rIv4EjpUzal
         NOHEcTO8THh/wkyG/uYWym2QHdTCVMXHpoj4Yh6Ac7QzU2FDqaLd6PyrX3NgCEClB7Ve
         ZIgVpQaF/s4/sip51X39Cp+X3tuT/iJtZpP4oh2Ihb6RrsfEYEDj4vUC/BzohkqNkJAO
         TQrmYla0Ca5FfT/6GelGI2gEQfTEo6vaBUIAaYDWqQd1gdoF7UI05RbcdmtANQ+RivvP
         znGaAqeff7YzVw9nMh9lkb1PwBxo5pTVhdzkwkU3XS46XY737Hu6/AlkktVuuZ9NlxFL
         J+8Q==
X-Forwarded-Encrypted: i=1; AKwUvBzG9m+XRfJdlexI471YK7EA1cgF8YSRQQ3636dBE8WK3vOWxZXSM6tf0u7qaR9hEayne89V964=@vger.kernel.org
X-Gm-Message-State: AFq9FYIahqUOi+CkFjSrzh7pbpy9nNLxdlDJbZ3Pcca193Op8LiGO8ev
	KrkcXEG5yyL5w0bhGjrJFmzvC+d3meahgfxVScF9aajWy9YnZIJZzNBZY6hT4XZAtPzaM/VltWc
	EQLMu4nj1XUhBIWZZU08CIY3/+jXHCdY=
X-Gm-Gg: AYBFou11YOxgRKQNcK0M0grrqX2N40npg4AXbkXPbLiw/yWwwtQ3HjO8e9vz75ZHBua
	BxKs9wkXSGpjDEy6Od9QmLZr6PSc488RYC5jOtv0lM35mHTW2rprfalZ/PL8YonEd/Lar8UVlwS
	u6KQwgzgkBHvxXMMfoXeq0bG1wwhqfkcpLt1m5JqSXHT1Iyjx9CdeIWnDzZSki7epa4djGU3arE
	pTYCySaLbyXy823bRtf++SgzMfQIulyrhJFJCvEzIOTynbefAq5k4JY7LY6kO8ApkBZ5fFAHS6C
	pcmG9lgXf5vvAJGQ5zt+rFP5Qt872LwH0R7L+WO7oB42tGNYdnDBfyskzlLi9/l6th1QYdocXne
	yeDdnW66GzkgEVtO/sRFZkwdwYl1s2335GaodnI8=
X-Received: by 2002:a05:620a:6504:b0:93f:277b:313d with SMTP id
 af79cd13be357-93f57e404e7mr834687385a.2.1792664395296; Thu, 22 Oct 2026
 03:19:55 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021085458.196742-1-physicalmtea@gmail.com> <d58ea6de-e17c-4426-afd1-0b67ead16b7c@oracle.com>
In-Reply-To: <d58ea6de-e17c-4426-afd1-0b67ead16b7c@oracle.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Thu, 22 Oct 2026 18:19:19 +0800
X-Gm-Features: AclHuK9FeuqH6i9COjZB1uH64DnGhDow9zmoJpb-bjLKr8MhdWEwBKDQwH0c-T0
Message-ID: <CAJwVaM+nBJ15=XwdV_wefNxd8iyxxSWjd-K8k_VAAc8yoyUZJg@mail.gmail.com>
Subject: Re: [PATCH] vhost-scsi: fix page reference leak in misaligned I/O fallback
To: Mike Christie <michael.christie@oracle.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On 10/21/26 3:54 AM, Jia Jia wrote:
> > diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> > index 4f8c0260bc9e..b7e41c0a91d4 100644
> > --- a/drivers/vhost/scsi.c
> > +++ b/drivers/vhost/scsi.c
> > @@ -883,11 +883,16 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
> >       vhost_scsi_revert_map_iov_to_sgl(iter, *sgl, sg);
> >
> >       iov_iter_revert(iter, bytes);
> > +     /*
> > +      * pages[npages] is the first page not added to the SG list.  The
>
> Just a minor nit. There's an extra space before "The" in the comment.
>

Thanks for pointing this out. I'll remove it and send a v2.

> Patch looks ok otherwise. Thanks.
>
> Reviewed-by: Mike Christie <michael.christie@oracle.com>
>
>
> > +      * remaining data starts at offset in that page.
> > +      */
> >       while (bytes) {
> > -             n = min_t(unsigned int, PAGE_SIZE, bytes);
> > +             n = min_t(unsigned int, PAGE_SIZE - offset, bytes);
> >
> >               put_page(pages[npages++]);
> >               bytes -= n;
> > +             offset = 0;
> >       }
> >
> >       return -EINVAL;
> > --
> > 2.47.0
> >
>
