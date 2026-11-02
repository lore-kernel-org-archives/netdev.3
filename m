Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638598;
	b=EIiWZ6Wz9WtFi/EN7dlZUEZCuwo1UEu0STcV/5GFq1BU+ts8Q50vu8U4Gee5UMoh2ARC
	 RXJ8OxUFRrXadiOEimUQSctt5XbatkEA7JZ5FdmpOwz5ZIDoigqjmUwsErfAAmtszl8W5
	 m/mauN97y4ZjrwZ8cil3RyQEgcY8c8P/HHy9jh0iv0CXF2ZD8QY6W3MntR/iezPHUXm7g
	 /w1nZVm13dEIzx61abCv+pXRHIvisLROS6HyN6BKHZ0N61erlK9Imv2DxaQRuPrcorYml
	 0JspdBgxWvkRW1EFqZjXgR3yzxSSnMmEEvw3ZDxllZvP+eXmDgjarZbVsh8HLedoDMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=fwjIWZZN+Xku/wuznq5Djc9dY6oT6GSmRAkG+xrsrHw=;
	b=SuS3A/GE96+Ta6DZ/YKre5SeLfIo35Fc+jNhfSvgQeqSCikQuQ/KCPbkQfk3n8USoRzY
	 EzfBnxkqbRMRZdjearvPn5zUEmHaes3D0dbHONRhllOOWbpjkIcSmJqH0JOuBIII5LKlu
	 /aAZVJjqLbLTYbwsZvnd+pkRTwpI7/HcB0UzKsZYYAREABaxTVe9DVBa9NPHI5azXvj5q
	 uMgMaZJE2fnXeqsdEU5Peq/FBX0EgpvXQEp91L+JLLiXZzKXiwVKv7tbehJTi6TYdBqUk
	 PZtm2s0r5VYv7lVCbKZjvLSlo1y2jQfGUo+jWk/39OTieV/VVOqYPB2q/NUxWmeLMFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gQPBCdN0;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DB7606A331
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 16:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78DB7606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gQPBCdN0
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc758830601so1995407a12.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 08:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793638598; x=1794243398; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fwjIWZZN+Xku/wuznq5Djc9dY6oT6GSmRAkG+xrsrHw=;
        b=gQPBCdN0ky7g6NTtQ3EStf4AoqYXYe0mvkYYWBdgWkEBAAYnEd9QMLgNWRc9w4B4U0
         K3raciejRcckVb6b/RpzthiCzmLRJPgBw7TcktVk1pzWCQYoHoTFP6nE32OkMzCJ6vW/
         40PmJnMenMr3LD94LFviVg89uX0p51VSaHPXIOA9k+T7X9D+DaMg7AbPXuBp6WJDlUxx
         1YjjOmDZ9I6qjaONDe7tdvrT0hRKbXGDb+zzYzRXvjGX5swDjiMeMJULBwNkBlGdL7qi
         BHpTjztF2qgxLxOz1bO1pctvkcD/mXDaRcY9CBbEl3Kc8iSMMjDo+q7At8EfFywjycZ7
         PJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793638598; x=1794243398;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fwjIWZZN+Xku/wuznq5Djc9dY6oT6GSmRAkG+xrsrHw=;
        b=jeKA2puD+0wB8ikVthr8kxKWpQIX2JflUN8zXg9jWidImta5b2+avor1uzHsmywz1F
         69i2EDEJqMl4pkLJPYj3fB8G15r+P0N8YA8s2xlgBqsZI6CLs/u9aDVtk13OY6BvRPW7
         TgLEySSMi7M3GB8HuHxrDevAHQ11t0iNkF6XcFeyIbEvuJkqd+rLFXzAAJ+NTtWRPHbL
         Sfv5ESP5A79UkdllvLkUhWQjLjYS+l42Lw1y0+HvI9lCVmqThMYDTSpTwgIGaESN1pW/
         534nT3tpmmmtcfwYpyjtiRp9bzbUsQedxVRGqX440H7E8/CJKIcDlgUaLzPNklkgOI6x
         6L1g==
X-Forwarded-Encrypted: i=1; AKwUvBzuMzD7ryaOyrXpbvjIw3QYy1PvlLB4YKRCEq6lJoYypomn0HuxAa2O4xeVMozoy1yQ2DnzJ+U=@vger.kernel.org
X-Gm-Message-State: AFq9FYIM1VsSVcKqBj3RbvVDTp1Mb14xX7AWuLlP2uHv6Y5Ewt2UTMUU
	+I+lc3xxpQ/6O2rzte1SqZ2qglAS0/fPEr2ZaZQbwdp01Ei1g4W/L5b9
X-Gm-Gg: AYBFou0/VnyC4RcLVU+qYOeIJBUkd0YsCSYN0ecbiYWP/uP+MbZVUkD464DWa4ftnEz
	14G9SHOMM/ZCsDUApiKiUF726Phq1jDQ1SDMbkuR1FRiXaqjuLt83cEhj5tc8N7aaQJwD+WnR+p
	upVssXR9qUlTKDR+bjlfLJCUON9VbOswqShVmYhot55DjHSldXxGYUPLSHShwfB3OZSdY7isKY3
	q6R7ickLtIBfKy2udi9OU0lPce3kqI7ZdEi0PvSZ3Y3jrGxO8kfQvZSZftwMYqDkI5ZWhlDkI4z
	8bl1QOIfwHV7umRNFp1qokgq90SM0PqoovC1UexuZPy80WFsLs+tilx2121Uy8oeecaZvSzMkjh
	uX9T5Nu1H+xbkKXclld1sNNDpt85oTst05YS5MvY+PiHqmsTrTmGtCoLtuRoWOW6rz0ba4gJWZH
	Cs0a0qHCHgjY3zW0U6T21C3sZcLNAYUD/Vdi+OIcUKYiOVJ4eNUmKIHBjV7vkyvPi7lLfePmNOI
	afGfP7XyQm0mPXj9r4UcQ3QmrZvTIHQYqxQsfnWtWzSgNI7OZ8TcRpkqRM6OpNURYS4xms4dHy9
	WoXVfgpNqvs4uOznWTb+pR026YSmPp9xu3sP0uQinikqwvwcmuNj3776+YCZ2SnZJrLYH7tqwlV
	pOwiOKSiCRMWru8vbGNpWXeKgb9u9ti6ZfcsoZMWXmVVpYLsVZHXN4DWn
X-Received: by 2002:a05:6a21:b91:b0:3e2:ea7:618 with SMTP id adf61e73a8af0-3e928c5ffd7mr9018818637.18.1793638597595;
        Mon, 02 Nov 2026 08:56:37 -0800 (PST)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada6c2c28sm2229529b3a.43.2026.11.02.08.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 08:56:34 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 16:56:33 +0000
Message-Id: <DMKVTEMTLA43.8R6RXYD1UMWN@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-next@vger.kernel.org>
Subject: Re: Fixes tags need work in the bpf-next tree
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Mark Brown" <broonie@kernel.org>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Eduard Zingerman" <eddyz87@gmail.com>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "bpf" <bpf@vger.kernel.org>,
 "Networking" <netdev@vger.kernel.org>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <auiZYnNYLEgcR6TT@sirena.org.uk>
In-Reply-To: <auiZYnNYLEgcR6TT@sirena.org.uk>

On Mon Nov 2, 2026 at 2:08 PM UTC, Mark Brown wrote:
> In commit
>
>   b73855c31c7be ("libbpf: Enforce program limit only for loaded programs"=
)
>
> Fixes tag
>
>   Fixes: c9b2a0975c39 ("libbpf: Reject excessive program counts in genera=
ted loaders")

yeah. it's wrong, but it's too far behind to fix. We don't force push to ad=
dress such mistakes.

