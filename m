Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DAE349AF5;
	Sat, 13 Jun 2026 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781355193; cv=none; b=WtJB4DUwfqJAocgmFN0o61VsORVF+7+cLxwXeC61YRwAW+ygEdGzMocCYIFBib9S64aJdife+K84Ai07T9TizODgqavMgOUt73Xy1yI6/VUlR5L2D2lHsjFaeGvwUNXA6OxQ9JkddwSzasNj2IkkCKGB8dD833uuTIO4l7SMBGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781355193; c=relaxed/simple;
	bh=cxKfC9snL49gXUy17OKFUc8YMtLsTwKpDOlrIhprr7E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=UwF6do3ilK8voEtP0hr9EcL4kfC8OmIW/JdYJGkh2ENv9Rgbfw5UpMz+sh3Jbb3dZbvxmi4OOxPRj/pS6gQiqTxPqGcGqqUu1Yw/fSL8gjO/c4VBeUqrfq4n2RoBEiwRNGL5TgFa0mEfNWKAePUJJ7ygNFeNF7izy2STBhGy5E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=no74L8Qb; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="no74L8Qb"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B5626A4F79;
	Sat, 13 Jun 2026 14:52:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1781355181; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=R+nPwJ4H5sUA7Oukz/pwRyd5f6wGgFWM06j2tHnXVIY=;
	b=no74L8QbGKcz8oOJyqJtfqCXk/4LCMCRdCFG8gsSf+gQJGaKKVNyhbDs0BhnoSHfD7a3JX
	5iVraW9eexaJ2B9QM0yeMuZtDjelGL5aULkOZ03s9PFvge13dxKYvVBdvEnKasnTIhKovL
	4XKKVOa6zURqQPT+5hP0wRdMceHEecviUalgxXwVmDRLcLRRONRHdmaE4uaGPFI9EFTc95
	B4blo8J952tX0/3+RAXoBIPSi+sd0kiFlZNe+yUupl8WnbY4QxeyetggJTPWchLlgW0pgD
	7DoERonQ7is3O6tKh2JtgyqQ9a8oR3SNgIdTQob2RmUB+PzLFzHbgDKLGSxoHA==
Date: Sat, 13 Jun 2026 14:52:55 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: zjzhao@edatec.cn, hayeswang@realtek.com
CC: andrew+netdev@lunn.ch, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, zjzhao-eda <zjzhao@edatec.cn>
Subject: Re: [PATCH] r8152: add vendor/device ID for CoreChips SR9900
User-Agent: Thunderbird for Android
In-Reply-To: <20260613090154.1975753-1-zjzhao@edatec.cn>
References: <20260613090154.1975753-1-zjzhao@edatec.cn>
Message-ID: <608DCB83-037E-4613-A58E-AE76AEA3FCDC@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi

On June 13, 2026 11:01:54 AM GMT+02:00, zjzhao@edatec=2Ecn wrote:
>From: zjzhao-eda <zjzhao@edatec=2Ecn>
>
>The CoreChips SR9900 (0x0fe6:0x9900) is a USB 2=2E0 10/100
>Ethernet adapter=2E Testing shows it works correctly with the
>r8152 driver, reaching wire speed (94 Mbps) with zero packet
>loss on both TCP and UDP=2E
>
>Tested on Raspberry Pi, including hotplug and extended data
>transfer=2E
>
>Signed-off-by: zjzhao-eda <zjzhao@edatec=2Ecn>

AFAIK the DCO must contain a full name and not just an alias

>---
> drivers/net/usb/r8152=2Ec | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/net/usb/r8152=2Ec b/drivers/net/usb/r8152=2Ec
>index d61074178279=2E=2Eea1733e3619c 100644
>--- a/drivers/net/usb/r8152=2Ec
>+++ b/drivers/net/usb/r8152=2Ec
>@@ -10062,6 +10062,7 @@ static const struct usb_device_id rtl8152_table[]=
 =3D {
> 	{ USB_DEVICE(VENDOR_ID_DELL,    0xb097) },
> 	{ USB_DEVICE(VENDOR_ID_ASUS,    0x1976) },
> 	{ USB_DEVICE(VENDOR_ID_TRENDNET, 0xe02b) },
>+	{ USB_DEVICE(0x0fe6, 0x9900) },
> 	{}
> };
>=20

Also please indicate the target tree for your patch in the subject (eg=2E =
net-next)=2E For furher details, have a look at the netdev FAQ=2E

[1] https://www=2Ekernel=2Eorg/doc/html/v6=2E1/process/maintainer-netdev=
=2Ehtml

Thanks=20
Nicolai
