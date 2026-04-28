Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A8437F733
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 08:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777363731; cv=none; b=MM61UqmTj+rZ2c+1DT1vGFUf2sKdKvUAl/GZor5Z1Kiqc+mbp5yCiZymjSsz2Yr9lN9raN+5V+2EQrf/8U6bacJ42B6ChO6eemMQvi9aA4XRXUIoYyNNMyDsZdY+6kdqS9uGK0wdkIFmL4zyQhpQT8GBsUipVdhAX+yiqYgrHek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777363731; c=relaxed/simple;
	bh=8WckjIGBpN8uweObFU6ZpNlrFPmJCuLAesHgfKGWP8Y=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o6hXHD0ChOuNmEFi/6TJCAaJH0nN+8qBUxs89PTheV6CXNUWnwhX6MYfkotncSodjc+en83geqtkmhSxwd93gPzb2+c9ADvM1H2JHqBVFEtUemskOfVHuU4EZSQVn/LVSlzDWYNvdZSRYVFRtSbbbb/GMQMo9q/3DwfPwiRgdgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jepGfRi6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jepGfRi6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE55C2BCB5
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 08:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777363730;
	bh=8WckjIGBpN8uweObFU6ZpNlrFPmJCuLAesHgfKGWP8Y=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=jepGfRi6IhY/3zGLVb6usMUwKJVv4r9hjApXRjyHUIXNJansjuRWFWqu/ROuE47HK
	 ufasfbci967aYKTzs8AGA7P6h658HfbYjX9ZOGG8axLRha8hLhGkpzAQ2Z5uBf+spC
	 gXqxQg7tzvOB3PP+dPY8Aiev2n0eTcULr7T/SvoZLJK6WgrftXAAQJUbsnn8M6FLLY
	 b/jcZDxmUPtLaVbOQzykoLVpzK07zboSD/0DtUrDu90vImr/Q/SVOQ2U2hq+ynu+xq
	 sb+WmRaueS0UjmPesExixfG8DgePDvfB+LnETIpIt1DC+Ir37WiMQIG59HlysAaFz6
	 a6aRjMMbpU/dw==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38c620f1699so97513371fa.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 01:08:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+k1AMoL6sXa+aone/iiXiYSHn2KoTDtMFtSLuNXNOknMW6lYIOuKAI400CNG6qWdSq5iGZfmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo9ksMstBXSBK2jeVhZPDzMm1LIiJMEfg0P6a0RRZFrWE3LE4z
	cJ4KHdMw7AVK7bY1YLP2//V42D+AtYm3zPACpj8dirdoRPRlhqwer9UwlPYItb6G3k7A0Z34ih2
	kF3+rSRxNasPSxQZUdw9En6wAez5M2ypyIdJAsq7H+g==
X-Received: by 2002:a2e:a590:0:b0:38d:fca1:4a6c with SMTP id
 38308e7fff4ca-39240fc94e0mr7301931fa.17.1777363729159; Tue, 28 Apr 2026
 01:08:49 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Apr 2026 01:08:47 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Apr 2026 01:08:47 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260427143020.2800317-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427143020.2800317-1-arnd@kernel.org>
Date: Tue, 28 Apr 2026 01:08:47 -0700
X-Gmail-Original-Message-ID: <CAMRc=Med9Uph384ULUyyU+CDFGm6MfLdv5RU_wirr12p8=pPkQ@mail.gmail.com>
X-Gm-Features: AVHnY4LY46ocRRPnvuEcEfnfO-MExxALHfh8FrBE1LiHDloCjMtkmNNOXHQEo-M
Message-ID: <CAMRc=Med9Uph384ULUyyU+CDFGm6MfLdv5RU_wirr12p8=pPkQ@mail.gmail.com>
Subject: Re: [PATCH] dsa: b53: hide legacy gpiolib usage on non-mips
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>, 
	Kyle Hendry <kylehendrydev@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jonas Gorski <jonas.gorski@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 16:30:08 +0200, Arnd Bergmann <arnd@kernel.org> said:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The MIPS bcm53xx platform still uses the legacy gpiolib interfaces based
> on gpio numbers, but other platforms do not.
>
> Hide these interfaces inside of the existing #ifdef block and use the
> modern interfaces in the common parts of the driver to allow building
> it when the gpio_set_value() is left out of the kernel.
>
> Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
