Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1946923D7FB
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602872; cv=none; b=nTpw2o2KgKQKnQlMKEvLVk2arl28EosU1tE6/nelbHsHIKFg8sCMGfWY9scAzlW6xSsAYgsEptY5EXncMzFVkzK2nmXK2OQ56EpTpTmiFfXN66soAJPh+PYsELkiY1TAQzwRumMWMOi1ohxnU7X7uZh2yTVITzsJxLyyzOAInpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602872; c=relaxed/simple;
	bh=3CyFaAQ/EKPDryldJzmogM3PMRVRzL/uf6q3K8zHTa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+0ppWCriOBK7ZAwrk8kxBcrgXLk615GIvWFeT6MGhjNgG1+vSZw8u3Iflf/XOnnLCWdwLzjEE5ZfSvQO1+CfrnuWUIJbvi7GGi8FHmuWEerPROhfHS1Yrtu+Dyl1KpfwZkWkPX0AYItI3Gk0WQfhy9E7tXN3QhemxLa2+kNPVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOBeV6Nm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOBeV6Nm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66571F00ACF
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 13:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783602870;
	bh=G5ss7vtgFZzZH7j5PPKNgnRxv3EGS+90GapGuoUV2n0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hOBeV6NmI2/VWwdkKKCzhTr9V70OgiAzV6e+danD/PAs1pFdtoOapcND61wJePEab
	 hb5TGVOkfYD30VrpcjGoWFvVzuMMbitc92qU3yas4Xe46xPlO0DnSzCi3nWbZ1joUy
	 P2TRFPUHlNe6Akh09MvOurF9DWUAGuaskq2ZdT9dPigAi5VHYB1D/L7zAQRfEdUxu1
	 QxhaQja0OvmDonAr9lYsDsjVhVvPKdOtS9+A47zLPsQWGgi1Hoy6DUf8x87tkfxANC
	 B9aZavCk2B+P7VcRYD293mU9GMEZ0MbRPF5PS9NnWv089taHyXTp8+ejfkHH72+uaa
	 FPg5KCkjzB7bA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aebd52488cso2032282e87.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 06:14:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoTBVul79osTg382NREaPyD+6NS4ohU3JABAHxZYzE49DItvQsO3AIzsq7cnjEUhS+R5HS2AH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2CUupOJzAYYoN8lwjirpDQu9qdh/GT93W8nV/6eDo67HLj2S8
	qSHAB5inxrUl2HbcT9rcj1xa/L4wUSPy+9duzbL8meheioZLmS+muD6RlSbwV8oq2HXC4EUzyum
	zwC5Y/jIx5mlgUI9AvJbekeMFGTzPNnM=
X-Received: by 2002:a05:6512:10cf:b0:5ae:b130:1e1 with SMTP id
 2adb3069b0e04-5b011444080mr1822805e87.28.1783602869579; Thu, 09 Jul 2026
 06:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705001931.74149-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260705001931.74149-1-pengpeng@iscas.ac.cn>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 9 Jul 2026 15:14:16 +0200
X-Gmail-Original-Message-ID: <CAD++jLndZn-4Rgfm9S3ZB47D1eX7cGDbtKkc6mNFMxHErrqt7Q@mail.gmail.com>
X-Gm-Features: AUfX_myRqVpIkgJPekvGUSUV1D_ZMRcchbDmPbnIZZ_0Vm28P0syyO4R0Fvlacc
Message-ID: <CAD++jLndZn-4Rgfm9S3ZB47D1eX7cGDbtKkc6mNFMxHErrqt7Q@mail.gmail.com>
Subject: Re: [PATCH] net: xscale: ixp4xx: add missing MODULE_DEVICE_TABLE()
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Imre Kaloz <kaloz@openwrt.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 5, 2026 at 2:19=E2=80=AFAM Pengpeng Hou <pengpeng@iscas.ac.cn> =
wrote:

> The driver has a match table for the of bus wired into its driver
> structure, but the table is not exported with MODULE_DEVICE_TABLE().
>
> Add the missing MODULE_DEVICE_TABLE() entry so module alias information
> is generated for automatic module loading.
>
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the driver registration structure, and the missing module alias
> publication.
>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
