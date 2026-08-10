Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C6C21CC5A
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368780; cv=pass; b=pMGJxEPNfdY6oSXFsmA7pEt35y2ylQ4zYD+VjpXIM262p28iAKfNFLttbgfohSl8uFhjG6h0HjXMFt/lnctpCqGsMXANEMvs3aXMc9TrgSEw+wt9IaMIzo2ZuDiS1qGnbDq9RZfi5XCSzQfIQDysp1eeub2VoiaRWqnnyjcaVBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368780; c=relaxed/simple;
	bh=j4fdJB83OgkfpDFpn8eOXag7cSqCJ6o/mUw8wWH5rc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NiZpNVWehafiLa8mAgRLgyIixe2nPCeJWIbQXvCKRycL+FVyNxzpdXHZPZKwfZ7K5RaJCwdx+pWS8EewRl5wgkr5of8MjK5gV9TUdwXvBR4ELVC5vyK99nClL8nu9ukhbflK0nTZdqYYjxTcxZxvwUV8vFnyfbtK842AtzwX5uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apTmBob4; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apTmBob4"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4a483a552efso431366b6e.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 06:32:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786368777; cv=none;
        d=google.com; s=arc-20260327;
        b=jhIAh9oefKCjcP/Myx3iYaFjJeFSXLoo9nj5tZ5cz6kw7QbXzVpkc/s4NAcsJorJkE
         Yr0KxkQLtwVLUb3rytTxRFDV8KDPHngYyjPlybj3aH7FKDc/SMDjfamnWc3lqGgN5cXt
         tYJZR1lKQxwehABw1UlDq1JJ27sl1VDeq9IvrY8iWaAjM7uqLbfQb4em2FvBwl2Tg7Nq
         3REOeGJQL7KQpfI7gL9WTfz09T5Dcr+2e5/dnyGenbgeE9aSbqbzWo+f3tfKwIIJkOuH
         GZQbggzFNt5iGFUyPQvdHW3Ttf/Vm0U7iUSWJPK4QZPwAcoX94raK+m2TYluy/yA31XO
         aQlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=roc9S1a5x2gvGrqXEh82i6BdFvHALhfABuncZ0V+eZg=;
        fh=3h3L/vP8OOaB6KNMTuNKghmNL7aU7VFlRAHhpUj7aoE=;
        b=VooY3zOGOf37COcd2k/iwBETEoGZEx5xLD94SL+gJ4h+9TxWMPw0s50D7jGqKdC6r/
         nEkKNcr4wS6zj2Ov2gNdzru+Co9t0DUXLsoXS6JafWsWavMXUoHgMLUw9nJURvdT9Txt
         UfwgjdKmoP+SnkNasmHhzifVIMIHTa/6DcS6Ye7IVP58Ytw0LgRgrSpvCUGl5sXXJiV8
         w3G1FceDq4yBD9N+/1p/SVBeZ9GmTGJT+jqDFJdpNnoWQ8KhWKmwEH0RswAhV56pp8pk
         yBjCxb9qlHy0Fvnjb7K2WB6uj/m4R7IWf88pMlnaGMzSroObMHDXa0ENUjA6z/rDHBN0
         pHMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786368777; x=1786973577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=roc9S1a5x2gvGrqXEh82i6BdFvHALhfABuncZ0V+eZg=;
        b=apTmBob4QIr3twF45Vgg+rTrZD0GB0olkQzlq+ySNkICwvn5TjNTPZc6fiVqwpO0cl
         UfUj03HmEsA+tujX/3hZqhT7Smgcbqvbmr2YrcfFMIDyXRYG4xkqth+EW7/tNZXTWTn8
         99krUXsIMfnDAHn37g6itmmcdxU1jtmzxVFt+JwD2CB6WkurOS3cW1cu0hHaLxQLK+u4
         5JJwYnohVlNVq0yHGz9GU+/wTEAvUMTaqywA2mPW7o7oBkNf/O0KuK90x/LAEigl7MAq
         WICl4vYhI5WeI1guwhW/DI55mwRDQ1k1j6m4c5483jlYPaAkcIAy9nNlk2fDqvxfkssV
         tdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786368777; x=1786973577;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=roc9S1a5x2gvGrqXEh82i6BdFvHALhfABuncZ0V+eZg=;
        b=kshKG50Ch810NvVpV471pvUTKCirOc4XOSGS8OV/7oFYzR01Onv/aJ/RzCd1RXttqP
         IiA5kZELRyTNDNMeyZnOgwsOu4VfQI+lwfmTBghvmJngDZ8zRtFKhz0++WiB+p8D8MUE
         NibI1n6MScaJESLnFYYIy7HE6JtofSMOcnfhyiXBwY/uFDGEqQwSJEPwi+DN1mdCeMqH
         6Y24Lu7xld1EwmjECKgSSKUPvCzL7KUsjT++U3NSMk2vVguhsm7b85d8lUio1nudWU4X
         f+NisKsO+ZzSYR7C3ASKIj5DVVqFeFYE3pJ6cDjHOrhcDfEAcHyUnSQOxxWZZmTqQOO4
         I3XA==
X-Forwarded-Encrypted: i=1; AHgh+Rq97+MqUmHsmMr6Zof61e55jIcxFKmJVr9q5F7/v2nbkwKKYvGcjlDyyMiQSlm2zNJug2RQaP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJrLXb7s5M3ZnWyuZM4JmQewJBx5t5AakjG+L8mYRoeotytKpl
	VBz4OrlKL/SfxAid/5hx6gNNwlIWIeLDUzfxjh8RfUu4EXXa8D3SI6iKG/yaz8+aZfxQVj9DRDp
	RL5Atc/WqS/M7uJrF6ATfK70BgXvkFPQ=
X-Gm-Gg: AR+sD112PPbhPu6g4k+PDmqbNoLQCupJk0HF2b8K2vRC4tTvFfm0RiFeYbvD8XEgCIG
	xgdbfdYPeEWfyOTXiQgkGcGAap6ESayn5l+V6vwjDOxl6Y4K/Gkb3xYjP63aKUMXnrXE0bpnuuE
	aNfuQH/JUosq2JtPjZBeNT/xCtKikoAtPZiRkWYVJ634lsUNsCWKxCRcrp7gp1N+rt+DlE8eWwd
	1vJRU+SFk2iuMzsmz7oJVR22UsIMYiA7M7JEQdpVP1tNReGK1HwqqxZXt52FDn1y4mQBWXQ7bQV
	jedwekV/FHGD/7DIKP01dTgp+iCiFlTlrHxC9qYFJVEW0Iip41TJTSgU6+gJ7SKmyP6FPzJBWoi
	iLcNy+ppI1Re5wAVUhSNlajlvjNSx9LsYae6RSczSv6LgXZsbNnlfJ2rThg==
X-Received: by 2002:a05:6808:309f:b0:4a4:744:a4ff with SMTP id
 5614622812f47-4b1e7709011mr939902b6e.4.1786368777312; Mon, 10 Aug 2026
 06:32:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810103409.133796-1-fabio.porcedda@gmail.com> <annMvEUa7sUvVIfr@gmail.com>
In-Reply-To: <annMvEUa7sUvVIfr@gmail.com>
From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Mon, 10 Aug 2026 15:32:21 +0200
X-Gm-Features: AUfX_mxVKhydZDc9mSz7qXovjZ7jMm5XgJfbsYaYFTfSaUt4W52YohxggxigRWw
Message-ID: <CAHkwnC-RM+R08MJtwNr=QFPcA-WT-P8JFaospxF9-YKe-yVsZA@mail.gmail.com>
Subject: Re: [PATCH v2] net: usb: qmi_wwan: add Telit Cinterion FE990D50 composition
To: Breno Leitao <leitao@debian.org>
Cc: =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 3:07=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Mon, Aug 10, 2026 at 12:34:09PM +0200, Fabio Porcedda wrote:
> > Add the followin Telit Cinterion FE990D50 composition:
> >
> > 0x0991: rmnet + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (AT) +
> >         tty (diag) + ADPL + adb
> > T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D06 Cnt=3D03 Dev#=3D 10 Spd=3D480=
  MxCh=3D 0
> > D:  Ver=3D 2.10 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D  =
1
> > P:  Vendor=3D1bc7 ProdID=3D0991 Rev=3D06.06
> > S:  Manufacturer=3DTelit Cinterion
> > S:  Product=3DFE990
> > S:  SerialNumber=3D2aa802d2
> > C:  #Ifs=3D 9 Cfg#=3D 1 Atr=3De0 MxPwr=3D500mA
> > I:  If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3D50 Driv=
er=3Dqmi_wwan
> > E:  Ad=3D01(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D82(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D32ms
> > I:  If#=3D 1 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3D60 Driv=
er=3Doption
> > E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D83(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D84(I) Atr=3D03(Int.) MxPS=3D  10 Ivl=3D32ms
> > I:  If#=3D 2 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3D40 Driv=
er=3Doption
> > E:  Ad=3D03(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D85(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D86(I) Atr=3D03(Int.) MxPS=3D  10 Ivl=3D32ms
> > I:  If#=3D 3 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3D40 Driv=
er=3Doption
> > E:  Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D87(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D88(I) Atr=3D03(Int.) MxPS=3D  10 Ivl=3D32ms
> > I:  If#=3D 4 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3D40 Driv=
er=3Doption
> > E:  Ad=3D05(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D89(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D  10 Ivl=3D32ms
> > I:  If#=3D 5 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3D30 Driv=
er=3Doption
> > E:  Ad=3D06(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D8b(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > I:  If#=3D 6 Alt=3D 0 #EPs=3D 1 Cls=3Dff(vend.) Sub=3Dff Prot=3D80 Driv=
er=3D(none)
> > E:  Ad=3D8c(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > I:  If#=3D 7 Alt=3D 0 #EPs=3D 1 Cls=3Dff(vend.) Sub=3Dff Prot=3D70 Driv=
er=3D(none)
> > E:  Ad=3D8d(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > I:  If#=3D 8 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D42 Prot=3D01 Driv=
er=3D(none)
> > E:  Ad=3D07(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D8e(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> > ---
> > Changes:
> > v2:
> > - Add stable@vger.kernel.org
>
> Why CCing stable?

I've added it so it can be cherry-picked into the stable and long-term rele=
ases.
It should be legit for adding a device ID.

BR
--=20
Fabio Porcedda
