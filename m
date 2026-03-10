Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C933876D5
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 11:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142719; cv=none; b=pl9wC2wISNPaUa0uqz6OUzRdVLkWOIP3epwUYR1wngW3BparuorW1QOsG+PYFNSzMy/+nN7oaWch8SMdSCFQ3NwjSWqcOtdeoRUkdX7IP24D5Dn657tyZAGcCtWaGmhL9Yz2s5TTMMPVVJxnNOSg3I4frh5Kgdz80CCzsxwk0zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142719; c=relaxed/simple;
	bh=0965uAW9b64M4B4DUHduS1n7eI5f4wo102f2YxO1EuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tqs8XgEhxz5k6Yv2yaHvvleag1fnhD2rC34521k47rE/1ZNokE6/21o05UBVPs6kS150ZIPGnnbUYyrQhmEGyVEIlKWnnF2eRLrpwjEaMc0QyLHgYGtwtAn/c8kg/wkq7U9sPLFrw7Zsq2SPzNsUDp1ykhhmuAJpCLUpEQ31yts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6ELPgnf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6ELPgnf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6335C2BCB2
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 11:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142719;
	bh=0965uAW9b64M4B4DUHduS1n7eI5f4wo102f2YxO1EuQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N6ELPgnfOBNTckpmwcEgq6YWExb4VNtB+W8qxtB0PTfMqjTHbUv0/kI/kJ3sc9wTg
	 YOFY+8M40KNvAAsF27bEZ/e88fhCqbbWWiznX9FZO8d7zZUPGUbqzejeRn2ZL/zc6L
	 vpmL8TNkMKxzRHyMyAKtsgbzKtNB5IzMydjxGN2g6Fy6MVDVcMdTDV1HUwDx7HhGZ7
	 2Ft0YyGOZOPBdxLhMnkOo3pAk5kBzbvCkSNTS/bY53U0mRiGh2UOR4on2GbWzyiSk2
	 QGh4WSTVTmLwMDv+AcKXtFYiH78Dcf7LdOsgaf7VQsvL6+1rzOWcrbJyAv5GT5CKcb
	 tdqJ7paAkg9nQ==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79801df3e42so166071287b3.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 04:38:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVihlT7Jm16unmS9WcsmpsJ8Azq4MMd/zL/KGZLTdK0p4MMr17I16u5aj1Re3G2+NDIBcTnLh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhCNDlq7goWnKzoVqiB3iCI8E8w0in41HhZPnEUfTdip8F5vvy
	uD71HkdQN9oPSGwJ0042cGvJDactVH3idGVPPnf7SeRcf3g7jpKnfqINSvqCQdQIbBtCPkbsVcy
	tSJhsNF7AeF3pMuVfRPLVxH/PMPUXSm8=
X-Received: by 2002:a05:690c:6804:b0:792:7745:72fc with SMTP id
 00721157ae682-7990a86ab10mr26598157b3.21.1773142719110; Tue, 10 Mar 2026
 04:38:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <D5F95320CE72E20A+20260306035539.2443355-2-xujialu@vimux.org>
 <7131965EF4C8E8BD+20260307030255.3490715-1-xujialu@vimux.org> <177313382930.5248.1395703981822013627.b4-ty@oss.qualcomm.com>
In-Reply-To: <177313382930.5248.1395703981822013627.b4-ty@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 10 Mar 2026 12:38:28 +0100
X-Gmail-Original-Message-ID: <CAD++jLmixL6hPx6F7ZMTay-9vwJEgqrNE2nfBskK-Qosg7eTDA@mail.gmail.com>
X-Gm-Features: AaiRm53QcfNjslAgvLv4-kWULVHxFj-Pyz_6-UaEnM0MbOXJ9ry40BwLYT_yrjs
Message-ID: <CAD++jLmixL6hPx6F7ZMTay-9vwJEgqrNE2nfBskK-Qosg7eTDA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Remove <linux/of_gpio.h>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Jialu Xu <xujialu@vimux.org>, brgl@kernel.org, kees@kernel.org, krzk@kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 10:10=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
> On Sat, 07 Mar 2026 11:00:56 +0800, Jialu Xu wrote:
> > Convert the last three NFC consumers of <linux/of_gpio.h> to the
> > GPIO descriptor API, then remove the deprecated header entirely.
> >
> > Changes in v4:
> > - Fix uninitialized reset_gpio in I2C/SPI paths by initializing it
> >   to NULL in nfcmrvl_parse_dt(). (Jakub Kicinski)
> > - Fix GPIO polarity for nfcmrvl: use GPIOD_OUT_HIGH and invert
> >   gpiod_set_value() arguments to match active-low reset line
> >   documented in marvell,nci.yaml. (Jakub Kicinski)
> > - Fix continuation line alignment in s3fwrn5. (Jakub Kicinski)
> >
> > [...]
>
> Applied, thanks!
>
> [1/3] nfc: s3fwrn5: convert to gpio descriptors
>       https://git.kernel.org/brgl/c/b544927d75574330b0a8a33c113556b67df56=
f39
> [2/3] nfc: nfcmrvl: convert to gpio descriptors
>       https://git.kernel.org/brgl/c/253350dbf3e7fbd136905c98bd9f800fddb4f=
ead
> [3/3] gpio: remove of_get_named_gpio() and <linux/of_gpio.h>
>       https://git.kernel.org/brgl/c/b6420bd5aa0c374331bad6c0fa2eb5f0f87cf=
5a0

Did you put that on an immutable branch based on v7.0-rc1 so that
Jakub can pull it in?

Yours,
Linus Walleij
