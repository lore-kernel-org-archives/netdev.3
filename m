Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5E64A2E3C
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785334027; cv=pass; b=PyOGOPbMrGkPpQm6TEu3vmmQTTTn8JaUFQwgYegnZHYXdA3g/5p0guL9jDrvDmEOaSgeBQrGX8bhnqQ985mBLM/yJUQdJhwBcnsX+OfE3bZZK75oaXa2zedVvI05Wb20261ZZaIuDbBV1gGZbp/wyXJVA+Z8FH9hJQaier38joU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785334027; c=relaxed/simple;
	bh=C1llfHVHfzSitIiqq4wwH/QjzGhDpayF+l6RWibbVBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qXRHchPd11rfenQsc8byjgUqW9GnqmaS4pEDy7K9+EiA5BQVW5BHpAkWkJ/NnQVY/ScZq8gU0xAPusnXNy4uUITzPOAOCz8BWVZk+l4X0QYxBaWMFG76y1W6MaY518Cd/bBtS4u5nLA+VfP+gCSphVHMQOjGk/OQtlhGd3opmXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1e1UV8k; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1e1UV8k"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-43e8018f1d1so100533fac.0
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 07:07:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785334025; cv=none;
        d=google.com; s=arc-20260327;
        b=N8msVnlknzfKiqqwPHxwnytQvjmNtzRQQx9ffAMPStgyQdpkx9P3t9HX3Ax95jbeBl
         V9D/qp/3L+BPp4lzqjm+x77NAXtulwqRo4Yv3cz1z/fJE1dR/zI6Zl5pWRlRBbxfVo8R
         +waePwXPYsGowLkaLStnScTL8XITfP42yIxPmoy144dMjdHqX/YbdU1LETm9CFOvQnyO
         mh4jXbZqlzqoVzm1P8zuvY2xFtX619i9FjY8PyMTfJUaUXoXvK1Z+FjGYmfbQFJfyURa
         ge8YhzNuAVfBcC8ZRDAwn8xY9duEzB5zPlDk5j3sMfVA2hQ1ze9jxPksNPHp5vpXa3ls
         al6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C1llfHVHfzSitIiqq4wwH/QjzGhDpayF+l6RWibbVBk=;
        fh=1oeE+QDO0Xt3b1ovnMYd8BKyKPkvdCDp3gTS8Kj3vZw=;
        b=NXD9PB9tUkRsHRL9+gt7YnRqPdN6ncp/oQyaqWwrE2Tu9QROb0IJ1Nudpu86dzmu9f
         kYE2QK731GAtIccb/wXLpWuWlwAwhUxVKFG6D9l16gptQLX/A975VW07b1R8txjrrmJK
         Qd/DUb6wW9S+Jw7S9+7FcQ8cxEZnJQnf2krMmvToUHadVHUE2Kj9H1uohOcp37AEpH7x
         ucEHtr2tUrlLnb+Z9K4RRBbdU+Jy5dh1ln7b6QU08W1WjUh8beUmwDPlMk7CnJGbnQaH
         q4n+oioaA4QZbdoYCyEq46k80A7tDPAXKEqzjEWzOM7XTe3bqgIRSb4qMjbhiK+YLCe3
         Vi3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785334025; x=1785938825; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C1llfHVHfzSitIiqq4wwH/QjzGhDpayF+l6RWibbVBk=;
        b=Y1e1UV8k0wamv7DDmSMkB/j4BQmG59c0odCY2TSRdnxnhGpoOiYmp9oR18VYVt//AT
         Qhss74j03zNSoIz9IzD/gGBTTiLsYPSYa9qYKYnsrXRhvZmKbgZl2Odhb72xTRyCBY1z
         fao1aWk8NuBjlJ5Jd30vhwYj6or3qb7lm6kEhQd/fkWdgD7zTgfhN1SSyEP2h7dYJKRw
         0X5gOgBlpV8OKx9hSu+mE8kgqO9UZDNmgGD29lCswCrP7b0ketB0pUO423d44KDSPHIE
         DE5fBYwccGWQ0xaTUBXDkMSIt39YyY7arLaUzAAtygzKKqm1GEr0drv8iSa+zMltLSHP
         GUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785334025; x=1785938825;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C1llfHVHfzSitIiqq4wwH/QjzGhDpayF+l6RWibbVBk=;
        b=PoP+tlwCaX/TSJdNqzPawNsNGE7KRhfcNW4SPfvSb+UaB+GZ/p/wm6oYeJ2Xpq6T08
         7SgMZkh5/jR3OddKVf3hTG/HD1TrKrRvUydsj03rBqu7eogFHtdWm1ELlSGKQmhVQbv3
         gAUCZJz+C1pBsWuUJhDuEZ65f8i8jNCpH8/u892XhyBCQnzwfH5Mxug3KbKO7R/Nub7N
         vm2rCdHTUiPMYCrqPfq67ExhLZAiuixUIe56zomDt98HodVxv2+9ZPdLF1u+/rNqSPeh
         /LZz3TYeV23oL/HflZz7pTTmwOFswJK0y+rUCOQyicbcet+9GWvrQdko4ssGxH28neQ7
         mJNA==
X-Forwarded-Encrypted: i=1; AHgh+RrrdpqFuC/IAFTkxbGUeRneOEvRY7emST1Wzq/UO3apiIxXzG6Lmvs0Lf6IxoxXAJe+QoXdRJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyZvYWUsxNItKaLZHssS7RYe2h1zuS6zaxYg5QzK3nWBwYY5Wl
	KP41dAxRXRjmcRas3rrmKo2Y+Y3RuKheNXvpTgtROPTgqN8fOheS7vIp0sKqGGwGUJtU9f3FL7g
	8lU9oYoXvNc7JYZmwJ+JS0mcxptcTkNI=
X-Gm-Gg: AR+sD12yMwN6LfQw/hz5na4ZZ6TJQ4dRFaF8pD+EJky06+yeoEvpIXjTW9nfQJbgbKP
	nw2fjbKOTKj+x6mzbPI8JGMWVD6Hbdm5HXgoMMzG14nwO2DWqzK058vVvic6aAOkGc8wr4m1Qx1
	ET08taUBFsMuiBY2V+tedAlvjlYKsA44I8bwBayD3wg/2t3fs1rcZSaAlHuT+A7wMv3SYNoJrvD
	y4DEmlvW1b7sA7PNnq1/UkC/H5pedw+xEX8ilZlkE/7/imAEavmgdarwEzNsWsO9lrT0wdM6Y7b
	7uelDfzx9eKwsMrjOLMjNfvhNvbuaRCDld4WMmvJ0l6NCnZ+tkenOuVMwUPq
X-Received: by 2002:a05:6808:1388:b0:486:7a1b:5a9a with SMTP id
 5614622812f47-4ad673669c5mr3593557b6e.2.1785334024478; Wed, 29 Jul 2026
 07:07:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724-netconsole_move_more_final-v1-0-a5f7691db81c@debian.org> <20260724-netconsole_move_more_final-v1-5-a5f7691db81c@debian.org>
In-Reply-To: <20260724-netconsole_move_more_final-v1-5-a5f7691db81c@debian.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 29 Jul 2026 15:06:52 +0100
X-Gm-Features: AUfX_mytvA0RvtAdtQ24oR2a3Oypvf1DRkvmaOWI6gSyi6fO8z91W4KUOJk5mj4
Message-ID: <CAGSyskXYJDZnokB8vC4R9ZSJ3XGQySYW5S-r4=dHvcy_h=PcoQ@mail.gmail.com>
Subject: Re: [PATCH net-next 5/9] netconsole: move netpoll_take_ipv4() as netcons_take_ipv4()
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asantostc@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 4:05=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Move netpoll_take_ipv4() to netconsole, which is the only user. Rename
> it to netcons_take_ipv4() for the netcons_ prefix. The body is
> unchanged.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Gustavo Luiz Duarte <gustavold@gmail.com>
