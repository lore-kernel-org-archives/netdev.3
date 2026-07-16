Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29883AFD04;
	Thu, 16 Jul 2026 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218820; cv=none; b=XnWAUxOJnqQ6gj3oDtU1PizoWBpaZQqLlWq+2CYC5ESmf3iK82FSH2Z1VNoX06pnUfYFpWxV+TkTWfDNjuJnFl2zTPHQ9oz0LTR76Ox/j/8aFZkdGJVxuy2r80/Os0Mwtlv2zH2FKw9rUUvgP45LY617lWay1zKwYX9aMkcUNLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218820; c=relaxed/simple;
	bh=bEqw4HKPIvTQRqlPNpp15BWpGj7YivoiTbNBk3n8QmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZV2IzS5GXPYY/+rkAfcJM9fQ3bVKxQ3/qKXiEtR+EJke1rlzMWbQ5TnFho++ao/Mnf+aYTmyZ22jdHZWDYWGgggN6qtCL16CFNv4TzFn4Mw3c2TIBxA7xSYcdYfKPYUI0TNK1cjW1jB3emDNYq5limYxpM9pFSYIgveoCD8mQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=pDpUOUFA; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="pDpUOUFA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784218781; x=1784823581; i=markus.elfring@web.de;
	bh=pdzYb+Kjbm9CPO5Tttsq9hFomVEgkSVy31hd9aaQGmY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pDpUOUFAV4H+0hLN5nvnztyYxKTzHDIqAw9EztSoyRGh08XI+CSanBMn/XH3jEpy
	 Xz1/sRag9pz5/dZpHKu8hZGFrVsmxJIfR9Ys3moFNfxU3Ci1Wx28dnx+a2e4uC2DV
	 Q5pycXX/DGnAQzSrr/CO+d/oUep/Uwyu9u89s1EGlRu23XY4gF8VkBV/pA1b4RxRr
	 3Y2r+F1484besvvUm6UXDfh3XkKLZRKi71VLbeGVxvMObDVZU1jkVdi0vp0TtGZpM
	 r4hKOzaU+ELFuLgZAKRHdLXbJmJjT/x6ZcqaMVaUgS1Jq11KSXAfkTWJtjcv4HvOH
	 O6smDX0Ah11b8mhfIQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVJNT-1wd4qA1Fg7-00OMeT; Thu, 16
 Jul 2026 18:19:41 +0200
Message-ID: <29007f74-7b42-4ffc-b313-61f2b971be64@web.de>
Date: Thu, 16 Jul 2026 18:19:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: net: rnpgbe: Pass an expression directly in rnpgbe_rm_adapter()
To: Dan Carpenter <error27@gmail.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
 Michael Grzeschik <mgr@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Yibo Dong <dong100@mucse.com>,
 LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
References: <7958e26e-a4f9-48ee-8d79-3797016944c5@web.de>
 <alScHkiC3EmGzOlI@stanley.mountain>
 <8110bb3f-70d9-4f0f-82f2-ffe1262b2962@web.de>
 <aliA1EIIrX82jGR-@stanley.mountain>
 <320cb00c-28f8-4871-9ec5-d9b86cca8bc9@web.de>
 <aljc8RRt8OuYz90H@stanley.mountain>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aljc8RRt8OuYz90H@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mPrJx4uf5QS0vS4qn3prQALNRaF0x3ZL+XBvdjPLf/ZFo7NjJUK
 qzvBKfr6ue4Gap6425hMCpSo6PcFFqq++ojgA4PBNEuMz4PKzD3BPuhkTkzmlYNqXbYF5tb
 G/dulQ9EG1/xWkSL19ID+gC0BMl5udWV7zOkYCpgpxId8CXvIoNgNhi2RuNGxNNvt8MWM4m
 z5A4bJ5CRJR+y360VqpbQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V5C0mrU6OMw=;L1MUcjiJSh2wYe4LoxjFVskunO+
 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
 =

> Jonathan Corbet's article talks about dereferences.
>=20
> 	p =3D tun->sk;
>             ^^^^^^^
> This is a dereference.
>=20
> 	p =3D &tun->sk;
>             ^
> This is pointer math.  It's not a dereference.
Can such a development view be confusing?

Is the operator =E2=80=9Caddress of=E2=80=9D applied only after a pointer =
dereference attempt in this case?
https://en.cppreference.com/c/language/operator_member_access

Regards,
Markus
