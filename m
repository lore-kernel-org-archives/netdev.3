Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792537525;
	b=h8CCY5BQJXWjDjPkanTLS2KFy2Cx4IFlnwm1Bpp3QCO8MLNjdWva/U+QujxzobQkIAGG
	 XK5FTGrY19KPqfI2HR4pZZlnlxx2SpzwLT5ZNiscfZggEMfyaBCGpezmrztTudp73Ehxe
	 x1FmJG9QCBlBRbQULndMtwbb7CZXnDHWr65zE3J6SQHoDz+hT5EnYxQzF3hfazNgBGxGN
	 QvbAIY32LMQO4JVXHJQhxvMQZUlfi6e0LQS2Gjc0jrVY89Wa26Jm+V/NV8hxkoX4fGquN
	 HmOHBTaNjduc1C1Lc9I2DbAXsAyMMfOGq+Q0J7/htdWNOvLnMQePU/FX+5ZDFZrSvrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792537525;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=JQ9TD9Qu+QGHMOnlJYIPPYw7mW4frIX5SWRPHWeJBJw=;
	b=ugXalo0q+NlSNIB+SXvlpGXGr94tlvAqCFPNpd8F4zeayKbvvs77DZ3dELokX7jgqNch
	 M/v9OXNuTzE1WwAoDHhbEI42ImYpZkRd5CTv3iDHGl+OIckQIJlh5CIM/NsFABw/doNu/
	 8i47P9wffRzoT1e6//YGSK27jCkbyAL4Wnp4sPAuNBx9Gs5CsLbmYzhcl83dVOQoyjlPA
	 2RZyplwe+fblGx6aPbzi+ctKhnScea9fu3MC3oYxAC1Dn5W7nfXyvkRLTjH/JCLeOYXNq
	 5Xd3ziPcqT+uPzHmY97bIR+Cz5Ewxdn6hNgl205/LExxYtKc7VM6+ZA9/6a1zofvD5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=E8xksGfv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDE9606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 23:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BDE9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=E8xksGfv
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5ea969fafeeso28355e0c.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 16:05:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792537518; cv=none;
        d=google.com; s=arc-20260327;
        b=bBe8esEuF3S7gdkQkD+c9daoFRkeMIBMVVAK75RoX2/e5kjSzw89JEVK+Kp+pnnmN+
         n9yNG2kwt/9vH3bTkTd9am2bpXaah3QaeLQ4PRn75apVaHugnCL57K0rrTF1FoBoToz2
         in7kcvjwMUOTHHnzG9OJvsHBf/k4VtQJlyIBSmxPjjunivEQWWfpE7QIrItwHDNT6QHl
         W3w///V/1Pd+K0u+oDR3ti3a0o9VY4Az/k3MKAlSnpNwUrNaWU3yhm87hbW6rjChd3Qp
         FwyLCTUrokEjmC+hfac7nGY9OF/65xPjYSd55fHT8XJfT1PXqJB1mm8G4YAsIOLT9260
         Fxtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JQ9TD9Qu+QGHMOnlJYIPPYw7mW4frIX5SWRPHWeJBJw=;
        fh=2QgmjSRjfSA93ZbI9+diRQ9xSGe1WeGKDvMp3xyOUz0=;
        b=Z+RzdTqvik2aPdjYph549NM+Utkut0NlgMMRJn7nyacue9sOvjOkhl9rkVCLDObBdY
         R/vY551hzCal4MiO1FHmUudq501sBtbyPH3+OL8+G7IXQFO0BnImE0w5iM6EPc8jagbm
         BTXW6bgYpgTBAIvynZTzqAJAAfl8D9odkn6RuyPQBDOtYprwv80YC6S3h9LinnbljfLs
         D7Gjwfjn3QtQJN1FbciTo3V7459A0RBVAyEHgBgtKhF7Cw401Kl81/kDklY7NpoW7/Yj
         CWH2wZVNMyNXTxSh9jC1VG3s/6gHoQqaJCiLzJ0ygTGeAVPAWX2scrKEGeSr9QYxq2q6
         EE/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1792537518; x=1793142318; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JQ9TD9Qu+QGHMOnlJYIPPYw7mW4frIX5SWRPHWeJBJw=;
        b=E8xksGfvKfvFTRye9elVYecKnDUpUjJAsu4chhAWoigdfkZhiKYBnU3KTE9yUj+3gt
         K2PaQpnLcbwveCc6jiJnsoAoWjQqlR9vEN1xEIYP+AmjIdOWbGGUM7yjXOvptk+C6yJd
         WEAe/Xh+Rms5H4D7wdwC9ogykuqLj8FI/gcFXAjcRDDBeFn3tF0JRpp6J/5UTbRFEEgF
         VE4BTBmDKtv+5nJRxsl1xkVrQiKcAxZSnFSUhfHWa8pMniJJNkUyRydaFKgEKrj6QX7A
         qgnk7XnjUeqCenaiAyMlnvYir978qQhVztY/yLRMwQdtIM3spB2n78PkFH14VyLYwzks
         WANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792537518; x=1793142318;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JQ9TD9Qu+QGHMOnlJYIPPYw7mW4frIX5SWRPHWeJBJw=;
        b=n1FZtZiGmj3ZdsdnQxoajj6XqMPm+0YaQ5PrODvGZy1WX37oZXyprTcgr9jLzlkLtQ
         9FRXerFXUivdHjTOVaUcme+KyS4Pzitds9EuBKKfbpdgetfHSf3zQ4igRsQS0pYNkYK+
         +8LXQrt5WkfhuKZhtPohZWWEHbdJIs1Xt95pV1H/F0fJ0/iLMDvupaT0iFjqHVchVAWY
         5DBMCMBxtnOEDEkeX6jxhWYSjYXIrNPoiiOOZSom/IoDCSH/IgF2FtS+4nNqONvdBa6I
         QhSNwL0WuI+i5WUwKg+pXid77Zsk+aor0DwSti6/hTg8t11V4zZQRMUhg7vfGHddJeeI
         aA8g==
X-Gm-Message-State: AFq9FYJVs+xlPlccZohpQXNsmgciJkd5UNSJV14R8G8GazBvGL26U8hR
	clQ9lHBaHPf38NGTiINedZqeHO1B9l61jZZ2s0+N8D/4I1hMjM5rofK7Cwen9Ryc/TFlonuTma5
	bF9KbMwA63k/iQ9wQmrDdyfV+ksKLliUicTONTeI/lRGV11erVU7FsjYYCw==
X-Gm-Gg: AYBFou0SR7j3bIUyoqK14CLGBVBWAS4/uJrUVfiCbUvio4vt03jbrskpUhy/1W09tx9
	Bnrr+ArTTxFTai1lX/Vh4ncFwGZ6HWaHVzoeN+RmjGjo5ZbjFKRKfz8vfhsMulxZqHcntgtUuNN
	rVdno3ctLvHNqhAjzYenu3juVdmuHSWaAlD2eWxFvjgd/mIFvede34OeLjZ8UXO0++JCWvY/e+j
	VOqSChLuKaaoCyzplpKM2kdEiYNRQiVOKhal8fUfVjekim6aHDNlGl2k1CQ+vqv/lwTz9LIJpbg
	GUz25OxHTBiRJU6BxjzVJ/qgPBFlytvgxAewgyxbcOS6dGOcncRObo9WNhEC/N0ehtogxAz9gzp
	eS5Rr7pNaKMP/eif4cj4GpmXxtv9joXELLgXhTQs1pd7/o/vc3gQi0qJl3f798AvnV967mj4ecv
	QljYb/+62PcYZucm6pyhJ2hE3wSFaxRUhS3qLupg2+
X-Received: by 2002:a05:6102:2c81:b0:7cc:26e4:1943 with SMTP id
 ada2fe7eead31-7cc92764345mr231039137.28.1792537517960; Tue, 20 Oct 2026
 16:05:17 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261013202647.2206263-1-rjethwani@purestorage.com>
 <20261020133601.2081ab1f@kernel.org> <CAKaoeS2WHQ6QH5XJ+T0RLuxVDJAOtzdfVz0V6gSoZ7n5GJkFdA@mail.gmail.com>
 <20261020151924.41e22eac@kernel.org>
In-Reply-To: <20261020151924.41e22eac@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Tue, 20 Oct 2026 16:05:06 -0700
X-Gm-Features: AclHuK9A-chmt7AxQxaQlPmX1Htqw5B8m7SDR5AqQA1_FRtzNo_4_q-qDuJ3TEw
Message-ID: <CAKaoeS1ZYkdJn7ih=RnPYjfYV9MO3k1Lo43+uKrEuLMMN4U21Q@mail.gmail.com>
Subject: Re: [PATCH] tls: keep TX and RX hardware offload on the same device
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 3:19=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 20 Oct 2026 14:01:23 -0700 Rishikesh Jethwani wrote:
> > On Tue, Oct 20, 2026 at 1:36=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Tue, 13 Oct 2026 14:26:47 -0600 Rishikesh Jethwani wrote:
> > > > +            rcu_dereference_protected(ctx->netdev,
> > > > +                                      lockdep_is_held(&device_offl=
oad_lock)) =3D=3D netdev;
> > >
> > > Too ugly, add temp variable, pls
> >
> > Thanks, I'll use a ctx_netdev temporary and send v2.
>
> Is that a name you've seen anywhere else in this file? :/

Yes, tls_device_down() already uses ctx_netdev for the same
rcu_dereference_protected(ctx->netdev, ...) lookup,
so the name is consistent with existing code.
