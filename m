Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777FA2848AA
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 21:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783805616; cv=none; b=hZEWr/5qXNlGK5cqhz6jLmJqLqMjUReN4UFn5peC8KH6Ba7Wra9jPXCo7wy489vsIGPDP2Aazpaqol+dqp5Jxz9cvM1EIS+OAw37hMKYpng3JhgkiiO9xT5zNKQJCOmgOgPYjb+ZBIY2EUa8EbW8wQJ0FsOVufQAMygIZkZRtC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783805616; c=relaxed/simple;
	bh=LP35FKI8HO2MgMPKNrrxv5nXoO7Hrs59CwDSPXYI+gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lB0nMfdRCQXqEceTqCk/g0gBAPQh3VbjF9nPY41ejQiFj/ooaFYrQc+ja2O53Qyl9z9/eLkpXwKTCfI34uPAvWi2pE6sRZhRLPiBHNGev3gpqDZ0HZVmBZKxeAyVHH77uhOVs/byPl6N3jYxBaXVJYmDdkAsvW4ltZHwvEslIks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQZ8Steg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQZ8Steg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4EB1F000E9
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 21:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783805615;
	bh=Fxt5Kv6wtzwWWG7aOXJMN6ClRUQS1H+k6Gsv/nkbDwc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hQZ8StegHT58gwL9HTVj24cITj6mQsepsSM6fTx2ksAqu/OBl+2cvO0xn6JFB9r0F
	 KkhuYnqpKX4ShXzIqo8K+LGbkYqkTwb1ZBI5LQF9pVRTRKAMaOHFlpn6exgfxhnMxY
	 0jXaZ2s0a+3mxHa+LlhZSi0N5YsMlUklois6B6KlN79GtdQ6Jx5SdLooF89x35tV5Z
	 OFW4ibEwugG1q/W4NYBmCvdZe02OtbFz0+gRAochG0aIaBotvgyC7R6ZfqsR/GA8Xz
	 4hErc2J4TBGDoIqvKP/3EESYF8E62U22SmG/y05pbMi9HZxwZGgkW1ihOkwS5wy1dv
	 EJCmGwErwtqYQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39b51882d71so15711861fa.2
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 14:33:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqPTacaunHB4EYPsyaK4VxUDaaSsNhmX0NV3OoVS8OyhiThgkugFeeYYFAXd5O+zBegn0dy/hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3C1AacIgjZtGC540CGuFF6rduN9/qsK2KTLbY6iyjdMU/jgzW
	P4PWWMGvB2oknLckUh4q1u9+2gmhS/+/f/WQYs52DmY2wzMc29qd1a1kg2kysSltBJwYwTbFe0P
	dulK6a1bxbN3XGFfKPLdkFAaxrGcGbYw=
X-Received: by 2002:a19:f008:0:b0:5b0:12cf:ae42 with SMTP id
 2adb3069b0e04-5b02369d80emr609392e87.35.1783805613854; Sat, 11 Jul 2026
 14:33:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711-rtl8366rb-fixes-v1-1-12b9210b0cce@kernel.org> <CAJq09z5s39bg34cPZpheBQWyZHROR-ja1nvrD9E-w9Ya45t0vw@mail.gmail.com>
In-Reply-To: <CAJq09z5s39bg34cPZpheBQWyZHROR-ja1nvrD9E-w9Ya45t0vw@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 11 Jul 2026 23:33:21 +0200
X-Gmail-Original-Message-ID: <CAD++jLkS67rEytYFhb6057Q1QyKhaK+fU+iJ7cebRT7gHw=LKQ@mail.gmail.com>
X-Gm-Features: AUfX_mwQ2FGWI0C79jojQE_PrYPBUxpLhqvZV0omYDRw-Y01HT1v9UxtgSnQ3SU
Message-ID: <CAD++jLkS67rEytYFhb6057Q1QyKhaK+fU+iJ7cebRT7gHw=LKQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: realtek: rtl8366rb: Fix up port isolation
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 11, 2026 at 8:03=E2=80=AFPM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> > -               /* Start with all ports completely isolated */
> > -               ret =3D rtl8366rb_port_set_isolation(priv, dp->index, 0=
);
> > -               if (ret)
> > -                       return ret;
>
> If you don't isolate the ports, what is the default port status?

Hm as I wrote in the commit message:

"the next loop in the setup code, over the
user ports, isolate all the ports from each other, so only the CPU
port can see them."

It looks like this:

        /* Configure user ports */
        dsa_switch_for_each_port(dp, ds) {
                if (!dsa_port_is_user(dp))
                        continue;

                /* Forward only to the CPU, isolate from all other ports */
                ret =3D rtl8366rb_port_set_isolation(priv, dp->index,
upports_mask);
                if (ret)
                        return ret;

                /* If we support cascade switches, it should also include t=
he
                 * downstream DSA ports.
                 */
                downports_mask |=3D BIT(dp->index);
        }

upports_mask is the bitmask for all CPU ports, so that should do what is
expected?

Yours,
Linus Walleij
