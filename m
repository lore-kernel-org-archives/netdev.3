Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC94292B44
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 20:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776027392; cv=pass; b=Hvnj8h/rKKBJb5BYClELzils5wbcymxuL//gqnaBRgJMvwuYzQw+Z0N8l5ybaf5/p9Y0e9LHJCJ40zHoX/kED3dxBa+ww00j/x/jbnTtDt/khIl2grSCW2LAFfnYDr/ut76J7m0Xm7wLfjyTRzWk1WmGD0haY6Sfp30PnGjmWjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776027392; c=relaxed/simple;
	bh=lDgaRQ2NY9c/8S7it0mOrBtzZ/N4rL8lfzh+pJuXLcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bzsk3k7meMDCqdS3dj0lIqbOQsQkhmWVtehhq30ieIMzfLoP80NWCVsioRm6uLyLAI5IDeULiCfdyUV+v3BvnNkSBcOhdJr8TuOhcLps2ouQJty3dKHLqrBNQF6olV2BAuk0cidZCc1/XEUqw3YdCDUc1WlbGvY/vZPYI7cOAgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kzNUH1uI; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kzNUH1uI"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-128b9b7e3edso4674589c88.0
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 13:56:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776027390; cv=none;
        d=google.com; s=arc-20240605;
        b=cwaK3/n/lvCSzImzmdrJEN/cP/kET5ATKg4H49nxq4Vo+pX4hcpJ8aZtwJbQaD+3ml
         hcqVp398xRT7sj6X0JjTKRMnEOhUickSOHnFJgV4swje9NHw4Yc9yD+MNEEVgHgglCu3
         5MU4TIlau7xtIhg5VWmUc3Ar/sM6Jmtp8os9jRlNgyi8OFEFJTGuS7zzJZUTgaW62q2J
         t0+MohB0TjvvS9dPYkjyg6EJxUe/E79LKhfpWyZEDEewI6i3jHdYll4tS16+wRtL0ONQ
         XiLmdj+9ZCs+D2aNr45OkMReAtLpIntK4GOU/xMx7V+P40dpa9ddvi+y7k3t0RpGrfhv
         XlLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j5I36LIW0AYktzTVKzn/Oq98egCD5eGjYUi6LX9rDJk=;
        fh=RlTZMmnXqgHDcEsbV+YnPKUPruDGam60NA76u5M2dRM=;
        b=aucsarBVjphaXuu4cbystw0fcf4ff2/dDEtppEIYECOysVXzaoRiAegmCTX+uIKUES
         tG3l6x7a561G1zNb9gsyYUtar9mStps2WaqPOb+tlfuGDaVPiaqmq9MQQKtzB7WVCp0g
         +jtQz9brf0Ua2QhZICRacO0JOzcpnWbpu8CAfl5mfe2wCZW++M5h+DMqCwbg9mbvqzAl
         HPqI1A6+FoF8IsW/KjiLPv8nPOfcjVX5RY1XHuxcNKr8CG+2BQvgdKVxlW5n8qzjgC9M
         nFkUPXrQ6a90Qsx6WBBiTwzKppe8CL+kD3c6FLSClb/++QS5NQ3Q+/8ZzAFog5AyAliH
         q8Iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776027390; x=1776632190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5I36LIW0AYktzTVKzn/Oq98egCD5eGjYUi6LX9rDJk=;
        b=kzNUH1uIzX3v/U0ftfv2XRvz1WR6IUQh9e63AcBP0su/vdxZJ1ApNNrpYSppWZwREE
         9ei4b42jD+q/6aZDt52qgA/PQ+sDgQ0eBDuhfJfJ0u5t9b0EcSe3o/VlSm1tXGG5vLmI
         JPdBCpvJ4p3fZQU7sHnv82+cR8MT5bvdWYJcF0/oMSnrZ0JIxNAjW8m+8oXJhHBQyHUC
         +fEfvls079ptQKU7piZmpdszv+415G2oQjSaX9lP0fYXLWxX+aEEFuC12F44FmqC/DuR
         eaydBA83i74jgd4i1M+18AtsRzSOp7m6GkblTn59f4Tcc7jArdEV7yzURALk+UHoiZxp
         9f7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776027390; x=1776632190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j5I36LIW0AYktzTVKzn/Oq98egCD5eGjYUi6LX9rDJk=;
        b=F8rtTkmoHJZjjSup6CAYx5TTmzEJ7JZJV/utDAfBg7n1l9MOfSV4mLEjEqAiYVOerW
         dxKY6AGIGtbVFn5J1tURrhty0UaARsEsy2111B9n5Qjy5UWTRxh0lpoZagJA2+lOef54
         VGPd1ALzjVOGpkU74venqpe5Kl6PaAHMgqvqvybNf8sQeHTf9W/vc0YjlbHl86K5Gxyw
         fFq4Uh4umR6RuwfgIkbTBeCi2t90T3VJawxrvuxMs4VJjw8srXNbU+vQIXakhbg6b+mH
         xG7a+nEDJhLJ3M4PpD1JKT3LGJWi2pD7NARoXkQcHbbvQQGqFfFdCTOROYacZfhpA5Ld
         ik0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRFKKwqS+NSbNYTrTerQz7ut5U9r9mFodaZ5vGWB3ksjzEltC4i8JvQ4M8dVuTLkAXsDRvg7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJO+hoGuS0opngrlmaGM4N9PjygOFZwaQlCDQ99nT9UlKPR/bs
	UEA+qHizmebI8W0EfxCtOuOLsOCJS6QBpLO1l6+LBzKArzkevv12PUGzJAH0gVK6zEb2cmwzEqz
	TZJSZR5QCiaQzkUesMmSlkYNNtHy2Thz6D0DcME0G
X-Gm-Gg: AeBDievuNKLuqC1sIA5JyexbA/m6b6xLKf1uqrQB370eAwLYdGN39RjwyihoPyknFm/
	79/f7tNfjWwjobrT+TLCB8VeBvydPYZu2YbFbzLecVWahcOgIZU3/t1x4NWIKl+fuOHXi6q65+Y
	tBDeFLC7Q5P6nF7H/hMSWd0eHhg4EtoLN7RPRGCQvdzzvTKtFe+t1tBd5CISZnE+Ceq+XvHdZIQ
	u/j+JEmanYpkuCFa8aab1ZWPoxXAIueAVUcTwCBNXd0yhzw5pacFZLWSd+SKa1pEO+9wnT0hAqK
	OdjrDMpH7auQ//SKjh+bDvyZFnCiTuxnXKsaE47Z45EQlIbAKmLdJnPQrLsOMpMOYk8kmDRVsNZ
	+UuF9Hen7+o/AOU6hzpTLVbCxO0+M9xOKRgKu2Rn9SlIEmzexTScV2yieANoRTnk=
X-Received: by 2002:a05:7022:b97:b0:128:cf5c:5352 with SMTP id
 a92af1059eb24-12c34e39633mr6733247c88.4.1776027389697; Sun, 12 Apr 2026
 13:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410215420.1698033-1-kuniyu@google.com> <willemdebruijn.kernel.15ccd7e646278@gmail.com>
 <20260412094729.334b8890@kernel.org>
In-Reply-To: <20260412094729.334b8890@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 12 Apr 2026 13:56:18 -0700
X-Gm-Features: AQROBzDCfVtJJuHAOzZBLyado5jARZNreG3QlPGqXMSFg6SO9Tw7H9aJO17HRtY
Message-ID: <CAAVpQUBUWm9nurX63VXjWg593w3qOhLYU-C7itnGokcgX_yGgw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] selftest: net: Use port outside of the
 default ip_local_ports in csum.c.
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Mahesh Bandewar <maheshb@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 12, 2026 at 9:47=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 11 Apr 2026 15:18:56 -0400 Willem de Bruijn wrote:
> > > diff --git a/tools/testing/selftests/net/lib/csum.c b/tools/testing/s=
elftests/net/lib/csum.c
> > > index e28884ce3ab3..4e044689bc37 100644
> > > --- a/tools/testing/selftests/net/lib/csum.c
> > > +++ b/tools/testing/selftests/net/lib/csum.c
> > > @@ -105,9 +105,9 @@ static char *cfg_mac_src;
> > >  static int cfg_proto =3D IPPROTO_UDP;
> > >  static int cfg_payload_char =3D 'a';
> > >  static int cfg_payload_len =3D 100;
> > > -static uint16_t cfg_port_dst =3D 34000;
> >
> > This is paired with wait_port_listen(3400, .. in
> > tools/testing/selftests/drivers/net/hw/csum.py
>
> FWIW I can confirm that this caused the HW testing in NIPA to fail
> the csum test since Friday.

Sorry, I'll cover that part and try the port option.
