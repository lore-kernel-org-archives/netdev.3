Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DE73624BA
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777013833; cv=none; b=VkGVqNgjDKBLQzORAM/xQZc0xGpUmVBevvmCA32zwQPL2fzBDPlFD/ehgi8zCXTWa4958skF5dMF81MUdCbz43l7WISlYCBXY/0WFa6R8Gq2FbgReZSr/zlZuJg+dRSLpZOmz7kL4VG02X/3VeovX+O8aBTdGXKlK6egdMkrwcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777013833; c=relaxed/simple;
	bh=SEr+WlmiWTO1JycrL0J1sw04K4DOCygSPT/tWDUVm/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYkpR6N4+iu9aIMyzz9SFZkhX1uRSuGAdcoXDoDMzBwMoUWvcP1ra3uop4IbEwlsfx4UV7T3nc10R9EN3IY+8PnX5/MQ0avxjKJhDfD2hbBVYIKUGON1vnksWACuJLCLNWpI5K4VPogYmg7EzVTN8RrrhG5WsRC5aZi7GnkbSi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjYWA03p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjYWA03p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35083C2BCC4
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 06:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777013833;
	bh=SEr+WlmiWTO1JycrL0J1sw04K4DOCygSPT/tWDUVm/c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IjYWA03pWY1gpD6BqRC2PF0uWz1T9wIBft+Tacmzv/+oes08+XmxX2nhVIiu47+qI
	 OIOdtEnIWZ6D7EW5GqnkLS56vtU80ohCA1sca6MgmCFi1b7qJxgvdj4K98hGIcIuJd
	 qIbhGCd+CSjbyyFc/ystRkrdi+hqYC0OEZjFZO+2xtAgGKDH8qLwpBKxoHuR1OKuOg
	 o179q8kPysBwLyZsFD7DVzW2ln0jeIUHRf7cWCqpGfm86kFFATYNWq5wmrWiUfQgUd
	 L9aL1xdEdJMMacAjYQY2JgNswuuLGb2LW3s/sEbkjRphfAQgVfJNuj7Guk5JTH0Jst
	 vUy8rLjGehBrA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a2c9c5ff87so8205066e87.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 23:57:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9DXRGaqQaOgOjLov8hRIfOHykdZX1fsOEARxcAbNznS9+qUjkkRDzjV6cDZpWmlzw4Mx4Fe8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4jFfGbxmUm7A7gD5W83dDi3Afw4jikB3Uk+gOv7UFWB7V+87x
	bvnzFi5CzG/dzupY4MKmeqtDMiPZDQ2MAbxN975SJQQuTBVxXVnfAsYNO0WPBXWJ1NjGfMoO5+Y
	yvClNpGXxBkdWgc5Lb2YPEQMfcih4T1M=
X-Received: by 2002:a05:6512:2248:b0:5a4:992:e8b2 with SMTP id
 2adb3069b0e04-5a4172e1c8bmr11414362e87.21.1777013831845; Thu, 23 Apr 2026
 23:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412-defconfig-v1-0-a46918286451@oss.qualcomm.com> <20260412-defconfig-v1-6-a46918286451@oss.qualcomm.com>
In-Reply-To: <20260412-defconfig-v1-6-a46918286451@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 24 Apr 2026 08:56:59 +0200
X-Gmail-Original-Message-ID: <CAD++jLkSTNbFwo7gwx+0e_ZwgXG0q0NS=L5-4fZ+k2kKEp6Fwg@mail.gmail.com>
X-Gm-Features: AQROBzADNxzrQDzMGVp1H4a-vD6pm520ZnRTwIt0L-Jg8slJtjbP66Ix_lrXjwg
Message-ID: <CAD++jLkSTNbFwo7gwx+0e_ZwgXG0q0NS=L5-4fZ+k2kKEp6Fwg@mail.gmail.com>
Subject: Re: [PATCH 6/6] arm64: defconfig: Switch Ethernet drivers to modules
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, netdev@vger.kernel.org, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Drew Fustini <fustini@kernel.org>, soc@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 12, 2026 at 6:21=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:

> Development of Linux kernel progressed over last 10 years and it is easy
> to generate now initramfs for building own kernel, e.g. with Yocto or
> mkosi.  Therefore for a few years of reviews on mailing lists, all new
> options enabled in arm64 defconfig were with assumption of having
> initramfs which can load bare minimum of modules to mount filesystem
> from network or disk.  Basically network driver as built-in is not
> anymore essential to boot the system, so switch almost all Ethernet
> drivers to modules to save on kernel image size.
>
> Similarly 9P network filesystem for QEMU, especially that testing kernel
> unuder QEMU does not have any size or build process constraints and can
> use initramfs with -initrd argument.
>
> Notable exceptions / diff explanations:
>
> 1. Intel CONFIG_IGB stays as built-in, because of dependency on I2C
>    which is also built-in.
>
> 2. CONFIG_BCM4908_ENET and CONFIG_BCMASP appear in the diff, because
>    they were default=3Dy (via ARCH_BCMBCA or ARCH_BCM_IPROC).
>
> 3. CONFIG_HNS3_HCLGE and CONFIG_HNS3_ENET are removed, because they are
>    default=3Dm.
>
> Moving code to modules has positive impact on kernel image size, thus
> boot time of all users not using above drivers and ability to flash
> fixed-size boot partitions.
>
> Old Image size: 41.11 MiB (Image.gz: 14.69 MiB)
> New Image size: 39.14 MiB (Image.gz: 13.82 MiB)
>
> bloat-o-meter of vmlinux:
> add/remove: 4/6139 grow/shrink: 3/51 up/down: 34547/-2046619 (-2012072)
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

In principle I think this is a sound change.

But looping in netdev and Rafal to touch  base on how this might affect
deployed systems. We've had issues with ethernet drivers that don't
really like deferred probe for example.

Yours,
Linus Walleij
