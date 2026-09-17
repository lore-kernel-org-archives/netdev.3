Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AAA46C4DD
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789683748; cv=none; b=D+8TJeClHFlfS/zyi6DPUBxqQyHNorBEI1ww6tDyp3l6MHQCaBnXzQ0FQjcxyXTLE7qFSaSMlE3C6QyaOI+FrCKwKE3TxpRaAxk/90U6pJUoSBxP79n29O3AKidvx3jGB+g92GNb0YSswVyrM2Z/NFa7MP6PNFSJqeE5WnPHO3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789683748; c=relaxed/simple;
	bh=9o1EWy3p6EhXJfc74bTuOh3PFxjT8ee5exqwfJnsyOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJEB60cJKnY95UUoSxPxxvZmqbjthaKFhLEvKJ87KoxyHdkJhojw2LKkB8hKmnQ3U2zGBkzlPU0+thfQ7lcvCwv0iCLNptnpC49OV+5Q/sG9YtbGMb8zkEWhx8geDMcMtV9cZUu5A4BO9R2c0f/is8P0V2GpM33/+MUI4Uxgt8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXldGrU9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXldGrU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58A61F008A1
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789683745;
	bh=9o1EWy3p6EhXJfc74bTuOh3PFxjT8ee5exqwfJnsyOI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kXldGrU9TIdlgTNX7r0CSqUt9F3GamdUXXmVbuomj6OkpzMxlKi8fu4zK7mOiHk5G
	 aMzrbdElZhWDj0CAXfLIXQmduKvvkSEdT28ncI0OCsY1Q3ONNLxVIkgHEByoepSlXF
	 XhtihDH4fbrlkKJQ9QoYePdClc71uzVRSwBETjRWiEd95yfWJtO7eXMof37IQuNReT
	 FnqsN+N/A/ApBMis50rTPzhK2QksqnjgzaTj2wvmB+s7IEHqQZ2+H5Lq3aErwQ35ef
	 13bCENnoX/g3YpCv5H3zmwYhy5M8pBjVfCHUl1e7nBaC6Dxc8xDjVYcvATmg3mNqAX
	 RZ/j5oUo0wfvQ==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1801fso124430e87.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:22:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxWtxyrQtuwmq8HVaMq9Gw2m6rTqM7NeJ0wF209qywb3Q2stDbeIM/gY05tVxfu9SMT3plJ4Gs=@vger.kernel.org
X-Gm-Message-State: AFuF++nVXoI8H0kgriiwX7h1nfU683WW7mfHt2QfZiq0K29lQ5Yk7b9X
	/j5Kn6Ezf5PtEccoVNDrwg/3OzmZ3XEq6hYK5YPfIBb1OalZrz1CiXRePq7R0d3DzLrqazlt2IX
	oQU2h9VpK1Md2ScGq9A+D03gERobyc5Y=
X-Received: by 2002:a05:6512:3c94:b0:5b1:5a31:86b2 with SMTP id
 2adb3069b0e04-5b8c17ffccfmr103340e87.16.1789683744541; Thu, 17 Sep 2026
 15:22:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917104920.2147568-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917104920.2147568-1-vulab@iscas.ac.cn>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 18 Sep 2026 00:22:12 +0200
X-Gmail-Original-Message-ID: <CAD++jLn8zuuBQKXTp_-Z9An2Qb-axBet5jwtyp+iecyUR_c0Og@mail.gmail.com>
X-Gm-Features: AcwNN1Vugsl6EYyA5YZR_TiINZ4OJKT5TpyjtLwdC1N8TlAJySegdEm3DnltlaY
Message-ID: <CAD++jLn8zuuBQKXTp_-Z9An2Qb-axBet5jwtyp+iecyUR_c0Og@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: vitesse-vsc73xx: Fix SPI device reference leak
 in vsc73xx_spi_probe()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	f.fainelli@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, olteanv@gmail.com, pabeni@redhat.com, 
	paweldembicki@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 12:49=E2=80=AFPM Wentao Liang <vulab@iscas.ac.cn> w=
rote:

> spi_dev_get() takes a reference on the SPI device, but neither the
> probe error paths nor vsc73xx_spi_remove() ever release it, so the
> spi_device can never be freed after the driver has been unbound.
>
> Release the reference on both probe error paths and in remove().
>
> Fixes: 95711cd5f0b4 ("net: dsa: vsc73xx: Split vsc73xx driver")
> Cc: stable@vger.kernel.org

I think we don't set this on networking patches, the network maintainer
decides himself what is stable material.

> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
