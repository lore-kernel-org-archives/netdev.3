Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793818513;
	b=oHhdAj2cY/LE+j1xx8J97/sC/kaXqHvC3/6vAqzBmyDXr3HDBCgOG2+ZpGHXyETYs3Tl
	 FVcEAK+2pLI2ZVlVReEbWLgABDW6077gDGxJv5TFwKGchiyhqT1GuncrA9moCwOVusFQN
	 tm75qs5YI1sjhLipuOFqFYYkRbPXVsmEHtsMOu954GftfZgWhoSeZYsrar931WPrrGsVt
	 QBlTLPgdihcDQECPNjqMB3A3FFBIyTHxLoY19gx37xEy5C7blM+gsSs3HlWVuI3l59Rc0
	 TOxrm6iIZ7VysMtWdP8kZmwr6d/FArBhD+5Ycf1puUSQes92ihXDe6xwAmdvNtVTr0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JomHWK70VEVph5MhIX9rA/gqgQnzCIbgLr6yP8EQo1o=;
	b=EIFbk/Px4q5U8TaVDr57D9KFpEE/lyBHxkS7whv53/50L6E4sng2d+hfEoPAEeQtvnig
	 jCFQEQTmF4z7QVMNL2irUEvyALQf623YzzBNRiUtsz9kwxzIKP4Ingb6htZgOb+/UiB+N
	 YVitzah9WPymINE9tZHWX3chrTsCa54R18nG8lnX80FzBBlOBuPlc+ujeEoYeNsZjW0q9
	 mmUOld+X0PXAhf/XjyHhN79H1G9wUYU6VocR2GUcd3OmE4XYwzfFmFRGWrHLQFs0KIsqu
	 X5NniK//eVUWgLtkwAgeSV8SyyzePBBh3LxWfJ6/4uwLjfqRKmT94hXJTPXXic9FcQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FOY01Rl6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7730606EE9D
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 18:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7730606EE9D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FOY01Rl6
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-9999f21f617so218195241.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 10:55:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793818512; cv=none;
        d=google.com; s=arc-20260327;
        b=cPhFnhUjhbc6QN1Ow3/6vVh6R4RhWT2aquyGf2YpYDlUOBypRo5hYlBPHpiocwNmXL
         6HA0ykgHSjKq3fjxw4GKnfe4Lz5SSi87LPzNaYYyZ8/SCr2zDofGaeyvpXVebTNY1+NT
         WHess9dCtJza2YaibBoe9wI6OnWTM1LsqbaQneb70BC7X94URE2g3eB12tg+sTEgvFM9
         3LW2sgfwZdj0bEC4W9TUpjTC0S2t66QEvxZ33dBkSzjMk9v1LJDy6R7mpDu1+KhghiJj
         BjUsPWFeV0Xj4oGvI73Jjv7Fl/X4J7gXksOKRGlRxiYiX6vKp5oRYkLkmckCsK7LvkC8
         avAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JomHWK70VEVph5MhIX9rA/gqgQnzCIbgLr6yP8EQo1o=;
        fh=I2jzV8HL06WbCrlvTpHR0S7jQ43uYIJiBUlvrs9KFLk=;
        b=LiUSlfEhZMFbXEPIgkOLSMszAJRN66D+1T+1i4XW98ikgIN+33AZKVaEC/ceotK4nY
         LtvQfrebLnC0d6OEstTSji/0KFoaA99LkGS5vWzj+6kBQAOD1oo7iwGyMwGZxjalHKuZ
         9GB274GvqHziZhGGteQNAQPY+6bhs1ruN9EbpWswif8allqjzuNpxCHD31B/47Yw/Rkj
         TG7NfsERi9gdNbpvce7b1TEeSHR5x/vDqGy/6cG+G57+U6hY73XWIFp0AX5QlRQfiDCD
         L9Ts2QjhwryPZUKePqIJeZN1cgo6HnUBmpCRlA+J5OEAIUHHFbG+Lle6nwpIDSNICde+
         Wjgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793818512; x=1794423312; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JomHWK70VEVph5MhIX9rA/gqgQnzCIbgLr6yP8EQo1o=;
        b=FOY01Rl6IGDR5WgkOoelYjGCKwSO3TRZWGH7SjR6GWEOQwrvKAnOADQR30W6FjEnrV
         fFHSPmRK8ZKumGIRR9it27hWUiBI6mMf4itJpyvN5mf9OkZLgy6N1qzKCt5GcDV4QLKm
         AsI/bMcZu/pR1RWz7IJ1IZe0h4bJPhGAJ1ga3giXlZs/aE0wJOBnmXWuB+oV3T++G/mn
         WVvlwkAuxPTVcEct8+iH3CDAXX0D7ojxUU9eSKXJfn7IxCzBScMZMQEJew+HOKMQS7dr
         DA6MAcTR1Y6bVNqaIN8osvjxVbAJSTCbZs+iMNNr7KNnxwDoj1u/OT4eXMJma3mH8hg1
         r6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818512; x=1794423312;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JomHWK70VEVph5MhIX9rA/gqgQnzCIbgLr6yP8EQo1o=;
        b=Xu3AfY2pJ3XbXQJR5LUdcPRQUS5xQQAmti50pZ/M7l/apMwsCv1vMNwNiEOd2XU5VF
         AqxKGLMNKpw9ATUJn2CC+g8RiqAoMI8dLw3aXVKBpGMwwbEP2QSdsQoOKrf+143ZNYkK
         StjeuuN4VDQEQXh64aK0RyMrBINhKG5cboQMYrB/qRBA4OfDNQ9gV8mBm+W7s6M7AM5s
         XEyh5oP4uOWExohxgk3wwELt/bWeMVtIzckqGhb+h/IG5MWrpCGn//hiR+oQ0mk6yOg9
         +/7y3vTuFtDIAx+lf1bE444bEMHy0LHdFqud9TktEHILwnV731Jof4Vja0GqaR11Dyqy
         xngQ==
X-Forwarded-Encrypted: i=1; AKwUvBz0RyZh6stsA2z1lWWeQGpovjX5xanhZDw4jEkLMLCqbKp6teCMyyDa2v8x0G13kA+Ljet1+tA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9r7/3L494eh2lzltpzYA9Z2BEHzyJFOn79dswqfynwDWbmQcue
	ZJk9TLQUsn/bm6rbVm7ulwclB6g9Td1BL7vc12BNTMk4VhKqEMMFVHhXXgLpN28taOGOO4VsnGE
	wzPnIlNkvYqNSoQKuvvYwBFgRpyAOus8=
X-Gm-Gg: AYBFou0txWCtw9tYx57yqfYwUrIkDucOXKn7W67+/xWyxy3O+FzDbxOd74ViACdOAsE
	3msDPv3eoPqAWE25FgfObV0Hp2CAYgY24oyIWuOoYVyDIpkAM8WZSTehetfCKZLiYmfMWxl+OvF
	tFBY9g1cGDOW/tA4O8Cb3VrDEAEdlkqVTgWN3GOOB/N2pXPorLn0tw4YCCvwfPVREGItdg3+vKg
	88CdtdOHipW6mFR9XzTB1hUyIFiG8PjG9sJYy6VWWYURjKQ1GNsOdNSSTLVgdBcr7BB0TTH/dYR
	VbwTI569hcrqaGYwWhKaz8GUHYXrtkZqC61AburIJQgfjLXDfbcxI8vOtkSqyGWtid2g/rwzfJj
	b+TaU5yfG9caWkK5Jme6lbKzLNHv2NYWGfJjlPLIf9rj1kKiq6QMOJ0dUUQ5naLkFlpkEtXAJFR
	r9qxfadTxGRny2t7zyPi10PX/wXRXfji1deIQxYYMj9lO2sGsppYfKCAxcBbLORqdI41kQpAuYI
	gucoRaM3+HECZ8joxQKxDYWJDNnZg==
X-Received: by 2002:a05:6102:3c83:b0:7b3:6079:1900 with SMTP id
 ada2fe7eead31-7d0726a03bemr6260355137.37.1793818511776; Wed, 04 Nov 2026
 10:55:11 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-submit-stmmac-vlan-prio-v1-v2-1-6cfc71e636ad@gmail.com> <179381842538.488859.11490770653999769834@kernel.org>
In-Reply-To: <179381842538.488859.11490770653999769834@kernel.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 4 Nov 2026 11:55:00 -0700
X-Gm-Features: AclHuK--X9CuBUmjc3vuMAmJzOpEI1xjQqSDf0syF668uw7WASBz7nJRNkp7F_4
Message-ID: <CADvTj4rwKjHXgxUR3XPob0_78POnTin_uaBUnm-9r7JyCfNAXw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: stmmac: rebuild VLAN priority steering when
 filters change
To: netdev-bot+sinfo@kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Piotr Wejman <piotrwejman90@gmail.com>, Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 11:53=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

As the commit message states:
No hardware testing was performed.

>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
