Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794147651;
	b=fws8Y1qTbkg5gKKvCb6IaHnut6aY7zMU6axallBoqV6TrF5yi0Kx+aLZ32Qh0y8nO/pS
	 hKC9spzLo4N9D8KHvODW0zs3SfuDGkji2Gj3C4BQpJunTBoy82Oep6LWS2Xp7R6/yVOiU
	 kM6JjCt0pEhBuHx1pUCbBCZsoXJLAEoJKMAgOhqd2iuE9FXv19H8RQSxooCkaPtgJ9MSE
	 GmVAcnXim6qntQNoDTRvrpByYmX6U22ZE+MRocz8cTHoMeZ5sAVNK3Kvt1e4CJd1oaS8n
	 frzLC3GxCWw58WKm1EllbYQu+pzYDZhcIlT7AXN+hQkADJstHz3l/siO94FjAmEQlHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794147651;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=En5T3Q1CBZFMdMfVfUK6/74xR4rxJK4EOOMSyfT1adA=;
	b=dA9arjTnguXZ9G/jM8XSmL8cVZy5TF12tiA1AUxrd2fqEjHisnj2+n/lfNTK8z1gZfMO
	 T0zTyxUhN2RiJCX+j1A6xyApLaT9oltqaiv6X18Yk+E/FIRcNClHhZSYSfjiaU82MYxiI
	 eclb0EwORSrY+DkEh6XvBNDk5Fj3qCME7i3CY1YbcKfwXKJ+X0tKkRHlmH8YcbfNW4yFj
	 CTA7cMuGyqIrNKcc3k5AkBodRUXvKG6HUCM5jbKOeSIvLcubNMU6ly9uCi/jjHduPvYTR
	 lguCYUcOfa4dPjXTx6L76BFDc2C4xLPLw7MdQmkXtXP8rziStZ57Cf2nDGObFxR1wCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bb7HVq0j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D508606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bb7HVq0j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFB11F008BF
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 14:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794147650;
	bh=En5T3Q1CBZFMdMfVfUK6/74xR4rxJK4EOOMSyfT1adA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Bb7HVq0jXXx4LHzMyO12CNb/ZdLIh0V9o69IULdu0SLt/AJDcQZx9pa9iAnxiFOGG
	 0Lyk941HUQS2HKmHR30zE6kSh8skfXCx7TEhmv/9tK39phuhv4K4hXAXfbRfRYZLic
	 vFGdDOEOiAUa31O8XVsSU7ik6uNw84yyJY1DAy6ZOTgucZhTVwgQ/fCEqA7glyODJi
	 EyjXRvGSvaR7rTT6WM6xHXitWDN3OCRdrpr0xzGcBx7NkOExCezBeB+QGNh86pmqhu
	 uDJv2XsI36knymamEgajl+C/lwivLGA0AkMFKS/wCCfug6Y9wj0vANsbOX4YJH2LSg
	 oTw8ZSlezaYgg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5bfbc67991cso42818e87.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 06:20:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHyxpKlf7ysvWZfQBqS6HNbUVqTR7BOXShCcO+twmgeNwlHJS4a9NyJtbRUMQM/2KgJ5Ao4MG8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TKhyYCpLUmFU5WabzUAFZOkmN7j1q4b/AYVU6/exJdZmoM1JA
	HEIOp6T5Xx+mXszlUqdP9A59ITxLdrTL+/sH1XJ+8L1pVbEDCkn89krB6IY0wTD21/mwDDn7KZ4
	eGcrhz5os0lwfyms2X0BVfGaH6LMwqJY=
X-Received: by 2002:a05:6512:12c7:b0:5bf:c700:3c3a with SMTP id
 2adb3069b0e04-5c14c022ce4mr403666e87.32.1794147648467; Sun, 08 Nov 2026
 06:20:48 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <9b73858d-fc09-4988-8bab-fd7b88db9412@yahoo.com> <310bca10-e082-4d0a-a645-42fd4e58d2a6@yahoo.com>
In-Reply-To: <310bca10-e082-4d0a-a645-42fd4e58d2a6@yahoo.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 8 Nov 2026 15:20:35 +0100
X-Gmail-Original-Message-ID: <CAD++jLnsyZkxkmhnU_a5pXCwZg8=7N+Ui2YhQ61aLx3hdW39AQ@mail.gmail.com>
X-Gm-Features: AclHuK9cjF2StbZgIZnAHn9GNvPkXApcSfZXvvHMgKx0AC7y2IkMPjxniHEACpE
Message-ID: <CAD++jLnsyZkxkmhnU_a5pXCwZg8=7N+Ui2YhQ61aLx3hdW39AQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 02/11] net: dsa: realtek: rtl8365mb: add chip
 family infrastructure
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk, 
	luizluca@gmail.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alvin.sipraga@analog.com, gusfmora@gmail.com, 
	kuncy7@gmail.com, fabianotassotti@gmail.com, gabonpivovich@gmail.com, 
	contact@c127.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 9:07=E2=80=AFAM Mieczyslaw Nalewaj <namiltd@yahoo.co=
m> wrote:

> Add enum rtl8365mb_family and struct rtl8365mb_family_info, which holds
> the data shared by all chips of one family: the family id, the port
> count and the init jam table. struct rtl8365mb_chip_info now points to
> it through a family_info member, and all existing chips use the
> RTL8365MB_FAMILY_C instance. rtl8365mb_get_family_info() and
> rtl8365mb_is_d() are declared in a new rtl8365mb.h so that the VLAN
> code can use them too.
>
> Use num_ports from the family info in rtl8365mb_detect() instead of a
> fixed constant, so that a family with a different port count can be
> described by its own entry.
>
> RTL8365MB_FAMILY_D is defined here but no chip uses it yet; it is
> needed by the following patches, which add family D handling for chips
> whose register layout differs from the existing ones.
>
> No functional change.
>
> Tested-by: Gustavo Foletto Mora <gusfmora@gmail.com>
> Tested-by: Stanislaw Pal <kuncy7@gmail.com>
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

OK that is prettier than the prior solution for sure.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
