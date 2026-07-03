Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157B72C9D
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 21:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783113468; cv=none; b=G6pvRbhR3ZApRAQuiO2j//fp3ya4UOc+NJapQDhrl4Yz0EjGVJBtYw6JJ6TTjce7agzBBfHDxxVffSMeCCqdJfE+Gk/cyPxQOGOCuhMwQR4CgS0kAhZlS0sw08caOCXiY8lwMdp4Z8u9SjV90F6/5hj33lLauhQv+BdztP+QpGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783113468; c=relaxed/simple;
	bh=cxH+BTBTRmQuUneq6tqcGHlgzBxLbzGrkbD/WpVSQVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RaOHmOiHvKvejUbY3SLdNnpwsXvuDDXppMMDtuJpLD1S59kFtrDU7thcJK7JbvG2wNUnEIb41pF3LWxCbEXWfE/pEZQWwdbeSfB9cixaZFKOojCHKjLCkMOnlWi3rUmbek+ino33Jpz8+zBFB84dvmOR8WsAT/8J+B1uEknudNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEpQEVt0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEpQEVt0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0CB1F00ACF
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 21:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783113466;
	bh=+Lait6gbz/FbEdb+mYKNtx+v8Sn1QYR1kRy6k7AV5sI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SEpQEVt0hNr3Ej1rbSb3nnTQhA60ZGczgUvrXainyeW5E/P0AqgwHkb1xsLReDaq6
	 mnrygGhB7ZY3K8Qfyn6insn0d+GogSwa5DTStmNK5YYraSs4znq4poLzX0m8TM6qzy
	 Mc7zofTziI+XR3TUhfNrofJqTKCv3rSM381nADJwuBSWT4bir3qiRa8dezyDzQpEmy
	 IFy9znx69Djq4U8wBi7CTU0sbvlWw3YDsKy2eC6xiZf73SSfYoOpI0IW84+SHwMKAl
	 Q9tvsR3AxHwD6oU4kFH0N2rozANOzI6549o+OkSLcwSIq2B1aP3sjh9jAowG1wcN6I
	 6xRTD376wtG1w==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aeb36ed873so720500e87.0
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 14:17:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrwz4k9FiTfaa9gGEyEnkfvbV8bCP7PmVBB7/aAxJfDzFARreBlTnwYcBpvSvr2M0fqlYK3Zvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjLtYmVB5oqdHJe3mwgbt9RolSmVAOI16TwNUUCOMUTH9EUOl7
	8m1zIJmjA92eri1ZOA6tNHArAclJjlHf4fyy8CPDjVgu7M/X43EvIwmPt3irMNp0s6SVYQv1I8w
	k5ycMaBl82bAD71lthVoK59pDUZUnwVI=
X-Received: by 2002:a05:6512:1394:b0:5ae:b78c:da1 with SMTP id
 2adb3069b0e04-5aed5096946mr157240e87.28.1783113465400; Fri, 03 Jul 2026
 14:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630-rtl8366rb-improvements-v2-0-05eb9d6a37f5@kernel.org>
 <20260630-rtl8366rb-improvements-v2-2-05eb9d6a37f5@kernel.org> <CAJq09z77GUn+wksbHNjHpPsrLLgU_yqo7V=M+XY-h1AKQE+WAQ@mail.gmail.com>
In-Reply-To: <CAJq09z77GUn+wksbHNjHpPsrLLgU_yqo7V=M+XY-h1AKQE+WAQ@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 3 Jul 2026 23:17:32 +0200
X-Gmail-Original-Message-ID: <CAD++jLk_OP+sv7NU5D+b639WZp=zHFmLRifUzpTa_9yC0bGtQQ@mail.gmail.com>
X-Gm-Features: AVVi8Cdn4nZ8jIK4SgsXMZFumqQQWnmMpWVf7b8jK6RHQqcTAI5wFQ8eILy9oQ8
Message-ID: <CAD++jLk_OP+sv7NU5D+b639WZp=zHFmLRifUzpTa_9yC0bGtQQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/5] net: dsa: realtek: rtl8366rb: Switch to
 generic port_bridge* handlers
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 3:24=E2=80=AFPM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> > +static int rtl8366rb_port_set_isolation(struct realtek_priv *priv, int=
 port,
> > +                                       u32 mask)
> > +{
> > +       /* Bit 0 enables isolation so set this if we enable isolation
> > +        * any of the ports an clear it if we disable on all of them.
> > +        */
> > +       if (mask)
> > +               mask =3D RTL8366RB_PORT_ISO_PORTS(mask) | RTL8366RB_POR=
T_ISO_EN;
> > +
> > +       return regmap_write(priv->map, RTL8366RB_PORT_ISO(port),
> > +                           mask);
> > +}
>
> As sashiko pointed out, set_insolation(...,0) actually disables it
> instead of completely isolating it.
> I would unconditionally isolate the ports as we will never need to disabl=
e it.

Yeah, I'm working on a follow-up patch to fix this!

Thanks,
Linus Walleij
