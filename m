Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792530097;
	b=ZW8PLUQq1va0z/6903L/iXHPP2SCVX3GOwQvPjU+vitKiKlMlsWWqCZTuT1jscPl24wh
	 avQeU4URYyQFMoKpSLusqmuxmQTDdkUd7oGk5mkh/yy0wps5TmV3dreD/HIh9SeuBPUF7
	 Z0nLsgx0RgME0ZcsOEDtykBtO8XrDKZ7bhFfYSf0i3aoKMnadvPqgDGqG4Vleypoo5iN/
	 UuB+9kuoV6sZjP5O0yF4Z2xV82FGDnIVmAQDTSr6ptZC726794Cdg512aVbBEqEJVKFUr
	 uHfGQ8kkTcfVkahu5EyqInvSIsMsVwOGmfO8V1mJL/AQ2+XLq0Wsm4O4xozEfk3pQMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792530097;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=/xBaGAH+wloa6ldcCrprHr8uQD4Nwpjw3N6ZX2Y8dtk=;
	b=Yi9AmMNnNp6JUkGPQyW3EtaC4E0vVnZd6vq2s6MYxYfAkcrOv9fIchK879z1Jg63oMF9
	 Mfrzd/m9Laqbws0MoFDsgC9mkmqfSBYnC52y9HRGxEa5xlU1147LStd+oRNsMErXX1OAR
	 46rsElvEIyhRoNrXEUvUL5O/kRiasKSpuU+2IySEhpajWYEvNoPhFOBbgG96DgqaIgCo/
	 zH6llTuW51fUislUchSmrZP4l4XcnmV2WgMN6sT0CuTnVR6AA4XfM27CzmlaQO2ug9vmH
	 GpZ+nMQBwAmHSJbrFOFIbkLGIpE9HfWv+zKji6jib6Ge0URXudOlnmHPn+Anf4X18Sg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=dIkYvQVQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.48
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3579C606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 21:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3579C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=dIkYvQVQ
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7c2f48f3a96so39779137.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 14:01:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792530096; cv=none;
        d=google.com; s=arc-20260327;
        b=FqjhkQVX0MkHG4+yPWmMxZ9u7cWZkJYJrji0eM1UR7ORPa6c3JrxReVd8RI48CBABS
         K8D8x48fs99n2iOMIGQlpgjinDOCEmFtP+r8hNKHcIfj4VGE2TfNRl90r1q6x1NE+qnD
         7hvuFVCr0t4gHiTYopLFjfzBGpD/w47qqziJ1uHONrzHHfb/g3IXhuQQUJ/5cg6lMUuL
         m/GjT/sGj/Ghvj8ooHVlbVQtruaUS1ZLHGOQmm+AGz707vPBK3G3rRVjPQY/EZu1wzP4
         bANvODYY5h6HhcpuPsoqBjCCYkXUlcW9ESs7eswIGgL89H/IpOPD3Hx97U0FZ/68zwco
         LwoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/xBaGAH+wloa6ldcCrprHr8uQD4Nwpjw3N6ZX2Y8dtk=;
        fh=2QgmjSRjfSA93ZbI9+diRQ9xSGe1WeGKDvMp3xyOUz0=;
        b=g9uH3Tvd/sjCvpbdKABj+Zx+g3qCdGCB4n4qX7M5V1EHnivFNv6VW49DEzhXEhY+MF
         Xyl5NkvNPKEYwh+Yh5MpkqPgRPZrXhRdhP3QwwhPGOlFfICfe0ii75xcfZb1lhoxSjJe
         aPmx0pwwD9+TN5f6fCEVY59xN6v9esrVLylBngdAbzcDqciN+NyL9dRw006wi5DpEPPY
         R8KlQ4AKYhjjFO5O9/Zdeht2fKckTaBb+yiuLDmhkA8ddvQCEUmT1YxVYjFuUyZtn34c
         pv7fwGZ/wwsg+23wRsI2Wg4R3rEn85BYhgU1DhRSqpXNlBvjj+j1HEVT6lCspgBoym+a
         fpuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1792530096; x=1793134896; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/xBaGAH+wloa6ldcCrprHr8uQD4Nwpjw3N6ZX2Y8dtk=;
        b=dIkYvQVQcaFWJDZv3YQz3cEBAluMc9VDTsC/iQkb5G5YSs91e34ge1FVCr5h1a+hSK
         H6L5I09Q0ZR1XrzHoQ2lrKIz2MyjQc5TQiwWZEVx0kk3ueqhNSAyRa9W12zNpDbd0wUQ
         808jd2jAVnTS/fijIbovwXhFukp0GzZughleAhHoYoJhtAGYMc3yMMM7VkYPG1sefKmU
         XBMgDnPHph7MPLhlFMwb7pgy6cvv0atzitWCk8qy30vjPyTaxyF1r7eyTSghJ2dUQY6+
         PlYXkAEGBne3uJgks6wYM2zDya/6GFAMvFQtA91u17yX/KcOLXSsrfmRn5fSFtyW4eOX
         gXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792530096; x=1793134896;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/xBaGAH+wloa6ldcCrprHr8uQD4Nwpjw3N6ZX2Y8dtk=;
        b=u7gL04gTy9OLfbwTEaGNrCVgc6CEIswwhHER1eEYUnWzSgW/ablg8N30XxFTGOZGFs
         iEsluyvN3lO2oWJDtaslRrqUrK4DbEhxZ0u0WMImNDF41HEWJ+jmnHGbT9YqgRV1EHHY
         j8atKtbVxyOsMEwgxAP3lYNwjf7ZWlZLTDvbf7bYXov9lxz4QT1ALOt8BdeWcJm67PTt
         Xqoqlixj9zynEYlH2m3pB13WnZOkjMqXb/UsABulLTriKvfAsxaO9rlDtyXnhNB8+sC/
         wbE/eWcJLlJWSKdSfxJx0yhBdMFWh50CENZ0Pn7vrXFooylGzFESKsXB93c5unCLLhye
         Sy6w==
X-Gm-Message-State: AFq9FYJxhy/T2zfy75KvOa1Y2d4LrHii5gWTCGXvegCuJb404T+wnJsW
	iZnT4SWxoXyCvI0wV28NzrZWVx6yWhW/lCwprltxGYkLr9o1RrMxx2PUSr0BPVxguOXxSmZPyNe
	8qPS+3RA+jGaKMFAcon+O/NJollPwVHNrDt39Jjl43Q==
X-Gm-Gg: AYBFou3vA9kmkRh0Poq839p2pWRy5CpvkaWmJXZWqR5lgZxvCyO+AJ1JeTdVifTcqcM
	0dId7t/BuPYcCCD2mh5ejZaFgF5SlvSJP1JIeeWRr/orhXMlHTEQeoSY3OLFlN4uRuj63IaH4NT
	VLcSKvv8tGWAntUZs3Old4lQWZAajg1a3AVMy6Ndz45Ge5Hk6xwgKiUGd0fURvCJk6HmyLJEOiz
	XMd9kbTWJO1UkyWA38X32KhurERksnGgSGKImd64g/n209bQaQ4vYvgcRYWMm12ItjxiOc3AYt+
	nC7cE+ZkqhpyOQe29S04jn54no8MKRKKMZiNjgr0qX+LsKIKxlAjuDzfysLfIE4FadsPWquQyCH
	UTSYKhf3QQhD2Gp1SRMuw7KnoYtYyVcR2uxfktAb9/spgyKaHjgMlJ1AvpNTR9zKjHJE6VIdeS7
	2o1R05vPLFclbOQzGoAs1XyA66e26wUhi3vR2FxD+S
X-Received: by 2002:a05:6102:418a:b0:7c1:b55d:373c with SMTP id
 ada2fe7eead31-7cc927a4610mr114615137.31.1792530095910; Tue, 20 Oct 2026
 14:01:35 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261013202647.2206263-1-rjethwani@purestorage.com> <20261020133601.2081ab1f@kernel.org>
In-Reply-To: <20261020133601.2081ab1f@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Tue, 20 Oct 2026 14:01:23 -0700
X-Gm-Features: AclHuK_QigUGhmprn1ml3zVfD0rGYZgdiljtuQlcsVXkC70e1X79ePdfVRhuVMo
Message-ID: <CAKaoeS2WHQ6QH5XJ+T0RLuxVDJAOtzdfVz0V6gSoZ7n5GJkFdA@mail.gmail.com>
Subject: Re: [PATCH] tls: keep TX and RX hardware offload on the same device
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 1:36=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 13 Oct 2026 14:26:47 -0600 Rishikesh Jethwani wrote:
> > +            rcu_dereference_protected(ctx->netdev,
> > +                                      lockdep_is_held(&device_offload_=
lock)) =3D=3D netdev;
>
> Too ugly, add temp variable, pls

Thanks, I'll use a ctx_netdev temporary and send v2.
