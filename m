Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887006;
	b=AEGInG+Sa5WtNjFtcLb13iKKFLi66m/4ygCM+avWyHz+91OheZ7wO/4klCdIN+UPBHUj
	 5DKBA2v0BYQD+NZgfhclYXIkoqrI4VUqVf3xc4fBKk9BCWv1P0JjMpk6CN6lC/ypGi/Y5
	 GdQcp+cv1rkHmJDVsuMIS2nSAMoIVbiPf+JOCmUepUpusDdfJUXP608yQGhMpM51mIPW/
	 JqtjzdsKU72SF7EQ4jFNnCL5Rn43yCZQOp3FPIR+OudbXJLYbvxLTo8/aYMekGzsByLEv
	 fhnY3YFbYvELtP/PAOfkyr8G4b26DYXkz/RsfaWpg7v0nK057BGUGlX3f53Qx1PHKyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=8TiKAvJXB1NGH1N8fdTjOIOAtKyqlHUX1XLSobFGMdc=;
	b=LYgQUokJZyncjGghFhFya3sfh5NvJ7M5J4GK+TGDo1IC9DzhMfVmqjwAQrZjm91vuget
	 SV4uvhvcJBkSeBZLi0HkrG22ByoPx4H8vs3qWfgZx/g5qYjgf0OPz7zsszarliEzh7Wbz
	 /2adOB1Hu8NyEJ0xKk/Ywxg3No5BmdAjPi7sWr+JmsF8dqneoXSNx9phntJvXV0mZiRoY
	 wLA1HUInpffH7KOT4asjF1zUBUG78mm2uAdjgckiaEvaVMl4TZHsU6LYhu05cHxHE5tJL
	 xHJPyghhDK+7z+EeWXe7v2Lg9RfdcZuxBqcdet7HVcjS++kXbeB0jZ3N7s7WWq6eK8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=iNVA6ioi;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E739606A328
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 13:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E739606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=iNVA6ioi
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48dee593f18so1527431f8f.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 05:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793887004; x=1794491804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8TiKAvJXB1NGH1N8fdTjOIOAtKyqlHUX1XLSobFGMdc=;
        b=iNVA6ioiu8eO+9tzpQL3oNb86QKDrzMRHGj57cea2rDeLio/Y1s/ECZPeuA/uZ3iA+
         gLGKJgGVi1Yp5zVrLk2D43+m2iffO+kvPjNBtBP7sQ/WeIJma4EwdzZPyQk57IWfjwy+
         NIQjFQu2oxZXHZ1Irrq38vHb77m48IA2KvwA1f06AmeoI4Ax+hRkDVqKZ6Dx255K/2vf
         ZKsHj1aLBrYl87FR3WSLF/XnVFg5MJ1mJ0U5nOKafZ6eiglpNikiKms5JZMBjMjAX7zW
         ggX843EjJdH2OMcJQQ3KhZeAxGRz19kqjz/InMwpf/mW7rM1MdZblXXanMdFRKwnb59M
         YxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793887004; x=1794491804;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8TiKAvJXB1NGH1N8fdTjOIOAtKyqlHUX1XLSobFGMdc=;
        b=ijq8vQC7EkBGn1L1lco89nEeg3LMAUhSt2neJK6Bqnidk7ntmAQR+v8qfvnIxy1TZF
         HCRBdcFuWQwQztz29Heu2g9LFbxa+vrylbxhRBMcOXXP95K9N1wXsQjHXLj6xMgOESqb
         yUmHYABSI+nmC64FPpYVKxCZqfzhi5jBH9iDJPjcqI7ENw8uXya+vh0LnSddb9+B02IV
         zNIJ4zzVo20Oy6nM/K5g3I8VmnhoYPObRu4PWfttrp3anZ/+oUTF4XofTUEE5rdXYMou
         91BNA8jm/VDQX7KHg5dMBhwKE/In9MGLEYrYRw0J9JMtPvtum5bbO3ko6G85oLoXbbp9
         XSsA==
X-Forwarded-Encrypted: i=1; AKwUvBxXGgRBhgbaF1K6ZKlQNjl5KcD2v5a/88BgnIQqtcIk3C+ERBCKSlvLbQcEITBUcAUfMsFCZ+o=@vger.kernel.org
X-Gm-Message-State: APuU4Z/j9RuQyXLAlMKyMQqdTRAqAoanTgTzSuQdEB8jinTiku9OhnMz
	NsWH7lEXAob1stfu8UjVWkdG2sSjCZgPYx2wd7m5TUHe1+HdX4lvKoEnBF3wjFbN+Ic=
X-Gm-Gg: AYBFou0i5vQik6g367SDO5wNdu6F3yCTBpNYmt2AjCRLhDQawXPOphLAHmVu/F2I0zt
	teAywY1EXrrNbxVwdcxthTpgVt328Fdmr2LRz7JN0/qhxDPcE2TYnkSVToQqd0VsEeA/l76Ak27
	UCvh4aEAe/a7OwE8WA6mRN0X9cFrJTdDNfHBLyeM8mgk7/Jz49KMuGwR+91t/pnuoZ8rDCrqH9N
	x0hDRW4C+4OeYhw/nPDHSd7QLcHDyUvuNpgk3GpXeBh+pO5sOlCI+Jys5HhaPyLequ0FSUtMb2X
	S8AoNSz5Kv0WMrYvT0TmUc8vcLY1GWUib48/rHPbT7X09LcC2ls1XuSPUnYqKGApW26783bMICn
	r/rXsW9X8dRPxuISYV8B/8uyIfNOoUnvw0wRShNRlPjgQhOQJOMT4H1BRvcxZ2jf53w1OcQwpAx
	UhTZ/4AWOmateKJovx92TXuXU2FeXkB0Z4XboK0w2iF9YoGuU7khl0saKCJxWi3QUVVbHmOMVM0
	86Cy/0yIJOEPc5esVxZHsuqCEXWfiefUcDmJ7a4DiocvkBXhFiOG5Qp3IkC/OKOoITn8SzJJB7N
	UQjQgWDDhMfS/IB1Hh38XyP1MGKs
X-Received: by 2002:a05:6000:25f0:b0:48e:4f1e:5e24 with SMTP id ffacd0b85a97d-48e6e2e75b0mr38836163f8f.14.1793887003590;
        Thu, 05 Nov 2026 05:56:43 -0800 (PST)
Received: from localhost ([194.213.108.7])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48feda20567sm10969363f8f.51.2026.11.05.05.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 05:56:42 -0800 (PST)
Date: Thu, 5 Nov 2026 14:56:39 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Akhila Kavi <akavi@axiado.com>
Cc: Sammai Chakravarthy <schakravarthy@axiado.com>, 
	Prasad Bolisetty <pbolisetty@axiado.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Tzu-Hao Wei <twei@axiado.com>, Karthikeyan Mitran <kmitran@axiado.com>, 
	Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH net-next 2/2] net: mctp: Add Axiado AX3005 IRoT MCTP
 transport driver
Message-ID: <auyKnmpiL7ZSJkgs@monoceros>
References: <20261101-mctp-transport-irot-ax3005-v1-0-36ceb822f01e@axiado.com>
 <20261101-mctp-transport-irot-ax3005-v1-2-36ceb822f01e@axiado.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2v5unmaqs7i3rrwd"
Content-Disposition: inline
In-Reply-To: <20261101-mctp-transport-irot-ax3005-v1-2-36ceb822f01e@axiado.com>


--2v5unmaqs7i3rrwd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH net-next 2/2] net: mctp: Add Axiado AX3005 IRoT MCTP
 transport driver
MIME-Version: 1.0

On Sun, Nov 01, 2026 at 06:00:58AM -0800, Akhila Kavi wrote:
> +#include <linux/mod_devicetable.h>
> [...]
> +#include <linux/platform_device.h>

Please don't include <linux/mod_devicetable.h> as it pulls in a lot of
unneeded dependencies.
<linux/platform_device.h> already provides of_device_id so you can just
drop it. Alternatively if you want to go full iwyu, include
<linux/device-id/of.h> instead.

Best regards
Uwe

--2v5unmaqs7i3rrwd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrsixQACgkQj4D7WH0S
/k68lAf/S7Au5tx54BaHhFIyr9rnWPJhc+OMWG/KaFglaxrdG2WQeAImkDXsQr88
Akm6VVPKYQBh50KUi2muuoNafteiCwHcq9JtSo2+R9q/d75TDEKggJICOxF7DYzs
wTbn+hGwOmxGwHjpR0nNW8uQWUyIhk0irXV3NsQkMhikal9x5T8XOesQJnoZA3bT
UEzoa1NXgZD0o4T+sQSLjMueCbC8OkC7GrhuMqiNG6OzWo42mecP4cY4li4MxjqP
rFj3ymSSJzaGlEtZoe9+m0986qi8/JUOkyh26I1QR8xsjKpq194Y55T4uLnlklID
EsuWtThrtvbozh5Kxnz8O9aFUEb1xw==
=onVy
-----END PGP SIGNATURE-----

--2v5unmaqs7i3rrwd--
