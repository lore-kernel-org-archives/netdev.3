Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21783909A6;
	Mon,  3 Aug 2026 05:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785735244; cv=none; b=STJIsIVf8N34jhVFcLGbRrMFtDc6xnuXV+xZynBo95kQtXlka7CTjrsoeaw7K7hbDI5q3XLauPPdSTvCNRVb0jJxhN3ss7Q+bBGIWAlp55scjlA20WO486Y1CaCuHV4YHbItQe3S6e56jOUpNEsCI0w5KujUFo/dYi5rAtiaxFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785735244; c=relaxed/simple;
	bh=iIKND3yZEloqxnMUQYfHlxnmavKDuI24hxCESCWg3DE=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=quQEzClQT0Z0OWvXGCNVWSc49OxBSNmKzBXFVFc7V2RcBOrC4ZG/p6LYqYT4HN180824ugXP/pszkoPWmUt9XkUBJ7gPSu4va3mHToR98GT4/P/fuYO/OP8zu32c+DWNcfnIJf2mUxB9sQV2QCVu/slaA12djpfR1/qYaAfNydM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=fuyqJxxv; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="fuyqJxxv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785735213; x=1786340013;
	i=markus.stockhausen@gmx.de;
	bh=iIKND3yZEloqxnMUQYfHlxnmavKDuI24hxCESCWg3DE=;
	h=X-UI-Sender-Class:From:To:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fuyqJxxvtvjN4RcUC0VWGTbK4DNa7DflW7yxtduGTGP5l2Z36coAmnY0oREaufTH
	 0/HssGgcj4hc483zrNTYIVa0P0j2tc8DDRMo6s/z9EAKIrNoWZQsio70KKB0izGSO
	 5u3WnnbMonRrHVah0UPlXGKkz6gUnN+U/hGvWKswCVFrqGj3VQ/mS+6Eldpa/l51g
	 vgpRb8Fg9VbwaxGrYlWpQF6ihyK5E1DRRMcvxb1kSBDJiCZhmjLGE65mE2FTNIz+B
	 4sh0dmyb7K4dPEna/m/5uPMwx9/dFg+dGM/VZA5T/lxP5mRUejbe+P/VPZQF+PzPQ
	 Lreo3vYS6yPwZU0PwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgesG-1xP0j32Zbg-00fQch; Mon, 03
 Aug 2026 07:33:33 +0200
From: "Markus Stockhausen" <markus.stockhausen@gmx.de>
To: "'Jeremy Kerr'" <jk@codeconstruct.com.au>,
	<andrew@lunn.ch>,
	<hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<netdev@vger.kernel.org>,
	<chris.packham@alliedtelesis.co.nz>,
	<daniel@makrotopia.org>,
	<robh@kernel.org>,
	<krzk+dt@kernel.org>,
	<conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>
References: <20260802083528.490216-1-markus.stockhausen@gmx.de>	 <20260802083528.490216-2-markus.stockhausen@gmx.de> <7a537ca124f1b5d0b8dfbf9524f47ad5120e9dfc.camel@codeconstruct.com.au>
In-Reply-To: <7a537ca124f1b5d0b8dfbf9524f47ad5120e9dfc.camel@codeconstruct.com.au>
Subject: AW: [PATCH net-next v11 01/10] net: mctp: usb: Allow multiple urbs in flight
Date: Mon, 3 Aug 2026 07:33:28 +0200
Message-ID: <006301dd2309$a07876b0$e1696410$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI8agZxcsV+DPxUrdmNszaPhNiTjAE/LIzZAUKWx4m1uS/3oA==
Content-Language: de
X-Provags-ID: V03:K1:rRzb80k/x7Tzt9jYViir6guCxHwUHXDwH9mSP2Pi9dRyOJiqxnp
 9P2EA5D+MFzL6NRIZqCkOmbx0pRjRVuFCnm00M1XKF5HDCPi+KHMmH7a0/glK91x+0cW+Jk
 A7+po6/sdIU0yQq18AhmGYWkm4dHJGCqDOjOIAkgEFJ7DtcuVcKAWCVkvmKzMqrBcaIS+GO
 6t33oiUUAi9TT0Kn8OQtA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IEqmGW1lQSs=;wZ5bWpOYMoDjbLR6pjvopMTGi17
 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
 /o5yY4xAyNmQbswL0M6roWOkJkPRDEqAAX4PI=

Hi Jeremy,

> Von: Jeremy Kerr <jk@codeconstruct.com.au>=20
> Gesendet: Montag, 3. August 2026 03:46
> Betreff: Re: [PATCH net-next v11 01/10] net: mctp: usb: Allow multiple =
urbs in flight
>=20
> Hi Markus,
>
> > Subject: [PATCH net-next v11 01/10] net: mctp: usb: Allow multiple =
urbs in flight
> > From: Jeremy Kerr <jk@codeconstruct.com.au>
>
> I don't think you intended to include this in your series? Did it just
> get pulled in from your net-next base?

Thanks for the feedback. This patchset is part of
a much longer series. I just rebased to the wrong
last commit and therefore included an already
pulled commit.

Will fix with next version.

Markus

