Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794356481;
	b=GOsNRsUjK+2UaUPphebOGsXUoVafFgCMrZodo1l0UecewsQhpS3/LGtaJ/cLbH2GqpXw
	 ohnytVHkf0VIgBfk/5LaGu+RAyvBHE270t4vGBOY9WngvDZYW3MVwDwvu8i21bnxhGIQ9
	 UBEWZgYp9mdsmjBi9scslmUbJu0IxtpTGxu7JN4fAEY8ACUC7nq7jDlDTPhnPgtD0Gm7z
	 pAXyxLkU2WJXQUTA2WKRSxepwU9TykME5OoKGC9aHgtfbcsGToOLdGRqCkONEBYepCYgh
	 VlXwPv9hCb6KyUuOE8rxWzFAEJZkcu1mJfs0ZKDIAdovea8PTIm5xizlnKFLYBniS7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=SysW/vQ+azlcGHbBaov0axn5KXBdAfDFDbIyK3iaAdo=;
	b=VL2Dh1kph2oKIQHBmnLB/VW7qFVBYt6QwZ4O7f+NgaSelp7xKRyAZRg453rDnf25Ke94
	 j8W1Nd1efamsq8FWUMrGp04Zw0VDx1CDiK9E0QbY5HNXuyDjce4Up38Vt1jsSczc73zlL
	 Xq8rIYxkgWndU+7UoiXDzuV942DX3VYXgpu3Gysomf10UcZqP3feveJwyTYl9r7mhuiKS
	 QkM+8ooWAwBxOkJX0SMRZ16o+qylxk4bbG8VkfQSOjugCr/XOFxIwEXkhpseNNz0RGvHk
	 CAQoJRjn/8H6cyt8JW0XlLmGvTP1EmMZjUWzXH61700nrH85hs334UlY0UWaercC94Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=GJdzDBsE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE206606A320
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 00:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE206606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=GJdzDBsE
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5ec20398b05so1506717e0c.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:21:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794356480; cv=none;
        d=google.com; s=arc-20260327;
        b=HmYuXjCQckQqm/1M2iqqYRa8iS5ioaPczEeWtN96sdhoubU9rtbtuhjEBlnvdLcqEj
         /pMUcc4BKhhXbV19Vc5cWrgbG8RF2W/sKgkAX4NF/lFodWPXWGjtga3lSznkAXhGnrAd
         VzncpSYWCyC88od2rZRlaB1bvBgWq8IxLXRXpQwL8jGpIZD7J/oBATcYuqqYRImkAF0i
         woqBQOPBG25uNo6pVx+tJe6t/KXen/nUP0ZUtuGYFgXSB++CTv0W2NZwF5jmX079Ybxn
         DjyF4vhpKA1l91pkm4GjwI9hNXAN8SqINdRwReI0YsMBOgyT02KhyqOFFR41mPdx4uuI
         qyfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SysW/vQ+azlcGHbBaov0axn5KXBdAfDFDbIyK3iaAdo=;
        fh=fYFZwOVkPa9CW//DEb/Vsykp/0FTSPnrFp0enOkyvzM=;
        b=Ka7kqCZhxOl2bNGqx8YWeCSiWeqIu1j1HGGDgcKqQfIgi8LiMAKUoscf1lOGP0WDxX
         zEUtZWLVHp6TjOMF1bbUAzrov6drSg/dL5LmruT5AjjFg95D9L688XgFZx63bZn4ZJwa
         R0rQ+58vCrDRROaSC6Bm8XzAmxb1EUFWeP5qATud08C3HGywqxHpGM2TOWgg80D0lY4H
         7e1dUyBjIYqvwiVnsoPGeL04YE8NFJxXDGZep7jUYerIlOHRILNtCK3+UAFW7t7AlCIi
         qbv6bbRqIdqXcQtI0Vp1GwC5RmCWYoZV32vkfosSfAGeofAfKGiBKF4nT+hqqhIUPr0c
         LJWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1794356480; x=1794961280; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SysW/vQ+azlcGHbBaov0axn5KXBdAfDFDbIyK3iaAdo=;
        b=GJdzDBsEM1lpGVcRdXSzDuWUl+s8lH9nvOzIYKP/EnoMQ3IMC4fYNgx8gbAF7cpcPw
         N4HfjnhAm+bJa9k6RrZx0H6Z8DrOwSY4TFM/k+qIIimk2tSStYvOru3ppa6pXmT9S675
         BWH/bhRZFj0IVGHzcLzwftqRPlt1D2t/3DE9DFy9HIUScUzpNLg+2OdJBQCQsyKhu+B6
         J0sBgZ19b70FnvUCPaRN/aM/hCLtlTV5WGt/Ppyx/L2vv8phnH9N1flb1cfbD7Qbrom8
         TioGs+9UFck27hoz1MbLLcP7v45WuuF7TDqvGoYLTEHTPf5PiiTjLpeGfNslpDF0qv7n
         08vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794356480; x=1794961280;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SysW/vQ+azlcGHbBaov0axn5KXBdAfDFDbIyK3iaAdo=;
        b=TuMkq90kfp6Yvr2wQ2Ja71snMQM5TZHkGJ5ZDQGiuoT8EeLFFL3Ro9lRVErnCn1G7X
         jywQ7KLNgkGvzZPX+C6vQFmwm+1jVY6PaQMlWuym28JgJur2juYhOdIMoD8xlDcyngiF
         K78+VExAav92JIj9l0TeaxlWd9rBPTtDTWSqIOXSlqNQA/amp9fGyHFhyJVvPZss+IDW
         4miMtXdXVeYDzgfWXGLM/emiV1mgKXkibiGRJGpNdt5WhVtpHQMrnNoB89u0COlam3hX
         VhaXc1CuayOy2zxPVMpOvuZnllqHO7mAoeM/LKxKiNY4V00eUJi+YyCKTOheEBnUo47C
         JxXw==
X-Gm-Message-State: APuU4Z/DSm0OD+g7DtHIVMN+5MSXQUjvN5SWr+00WbLh0oKRp98XSyz8
	nOTHzooIZwUb7wWKw5UU4FCGT00mWt30NQbW8N1HEZCjsRMnBjAQYZBxfiipftaWH6h6DbwfTWB
	Gchk2JWePDg3XO5MWscOZZRPmF/1N0mA2rTdl+KS1kA==
X-Gm-Gg: AYBFou2Ms8Q1WKrwLUNDgzBcKFxq5TV/BjWZxzkGDTY0cJ4gmHmtIPRyPYetI1v18IW
	A00f+leCDU5jVzH8UNe1Aqdwhjc8MJCtKFG+oT0R2hx2A60iQImH5a59AkXEJp/rdOAosE7ue3T
	5bY33/h+wf/c6lD0XMARuUfUy9RBjoFwIogW0oxxYjYqQEU9CnVhpPWev/d7AiT3O38wrgNmenH
	++xx0zJiv0LLbd6pfzgR0DHGdGBnX8RMjCxBFIGW1eLBSEBRUSIMfeROXX6j/Zh3gbadTqjVlfk
	xzftYnrGVytbFP/5k4efq9YxH/x/NTZ551DKUS4bIURmXEqC+RA71Ja+O9/kPdN7gISSnGTEDcO
	iHhkWQSLgtQ7yqWTrzJSGJ5TrHkO5Ka8sdaW/G563WjseTAO+TyByHJc+A8eKi4VHrchDLtdi7M
	Y0AaXYLtJa6nhQKcpY1GVPgc4mrNteIR+r4KYs7yweKBog0P0xzXBHZerlANRq8139KOhsWPViz
	v5gDfaIJgstHptfjLJqTYK7
X-Received: by 2002:a05:6122:4683:b0:5ec:c186:d22b with SMTP id
 71dfb90a1353d-5ee1c49c9a5mr217481e0c.22.1794356479599; Tue, 10 Nov 2026
 16:21:19 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104214853.659378-1-rjethwani@purestorage.com> <20261110133425.3bdcd98f@kernel.org>
In-Reply-To: <20261110133425.3bdcd98f@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Tue, 10 Nov 2026 16:21:08 -0800
X-Gm-Features: AclHuK-eJY-u2FWayJXgV2uNv-HfKtmR1GiOphIErFu8GsOwnCWu3b2O19z2cSU
Message-ID: <CAKaoeS1xjZuY6Ep6PFsPtM7ZcXUNYHZu8gg-z2KonTrducnW6g@mail.gmail.com>
Subject: Re: [PATCH net v3] tls: restrict device-down TX fallback to hardware
 TX sockets
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alice Mikityanska <alice.kernel@fastmail.im>, Tariq Toukan <tariqt@nvidia.com>, 
	Boris Pismenny <borisp@mellanox.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 1:34=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed,  4 Nov 2026 14:48:52 -0700 Rishikesh Jethwani wrote:
> > +             /* Stop offloaded TX and switch to the fallback.
> > +              * tls_is_skb_tx_device_offloaded will return false.
> > +              * Only HW TX sockets have the context it needs. Do it un=
der
> > +              * tls_device_lock: the reference pins ctx, not ctx->sk.
> > +              */
> > +             if (ctx->tx_conf =3D=3D TLS_HW)
> > +                     WRITE_ONCE(ctx->sk->sk_validate_xmit_skb,
> > +                                tls_validate_xmit_skb_sw);
>
> The locking in this patch looks way too coincidental.

Agreed. I'll split it in two.

Patch 1 drops tx_conf/rx_conf from tls_device_down(); they're set after
setup releases device_offload_lock. Setup instead publishes state before
up_read(): the HW validator for TX (device-down cmpxchg()es it and uses
the result for TX tls_dev_del()), and for RX it clears TLS_RX_DEV_CLOSED,
which starts set, after a successful add.

Patch 2 switches the validator under tls_device_lock. Since f08d8c1bb97c
("net/tls: Fix race in TLS device down flow") the destructor drops its
ctx reference under that lock, so a successful refcount_inc_not_zero()
there keeps ctx->sk allocated until unlock. We cannot unconditionally
use sock_hold(): sk_refcnt may already be zero while queued skbs keep
the socket allocated. TLS_TX_DEV_DOWN carries the result into cleanup
without touching ctx->sk again.

pw-bot: cr

> --
> pw-bot: cr
