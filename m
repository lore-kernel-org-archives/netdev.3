Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794362592;
	b=Qkb7ggQgpbzmhMJ/YAXflMCXEtkbx7GYgfyu7eC+Sq5e+zEKsqtQbZsdkrLz7ZFqlyYl
	 5edaBUgmwbFV3rBwXtsDJkelaxMr+jUacFs0EQPR+XCRurZWs4i6HDQudQvOY3XdKaiXC
	 AHjc/ZHlzl2cbrPJ8W2ee+UU9LS1NVdA74Z9VJ8y97rCjt0CglBRTJSjpyqTM8/qnj4/b
	 Ze0bwMkqft8VJvzQgQnCWhjzwcghxgEVgQDYwVqBdTD1PIyALS/oonCKWefl9FYRgUxAo
	 gXeS9wRYX1LM0UHJVXLQxOmvHGBv9Gt0FYSwmBWpMxKLUg55JBTY2Q8d//N03dh/sRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=VBnxo1cyrBP9eH26ieZ3qEE4H0EMBAPCxXo+MXkFYS0=;
	b=bm8Y1Z0/8YrogFCFtszrhfNX71tP5vnQy00opFEnK/Ofg82MGfmnREjJ5sLKm2yGsm7w
	 joZgo1mWudf7op12EbmyHPzeS+5rqpcx82E0EuZSJXjf/ji8vMtsJ+iiJpP9OsoJDyxeh
	 vquBtsDTnqGUelU0Rjk8WJ4T9JKn96OSmXbqHaHTyp8+Q7fAjS9vnMSazT3aAMgUxP2re
	 LQIYqX2Qo8n1Nor7KlJ/ctqDS7OS3OqAZmczUc3rRnIL+TsU9SIqj03IDcQDYWdMLIYIi
	 0jW59p3dHSNw87/p+79KrTyY5E/6RvEGI2T4gE3gVzZJAmX1qrKHasnFu4ZywhHGUVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tc2mvNEV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371B4606A326
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 02:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 371B4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tc2mvNEV
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33fb4680717so2312952eec.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 18:03:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794362591; cv=none;
        d=google.com; s=arc-20260327;
        b=SnSrlICqkF30MPziT5Rull0lhjJdNeiTXCRwlBRIIO/ZONwhkPLZWJMnTanSMM1VCC
         az6i+NUl6ZMq7f9wtd0oSIN9fJ09APMwfaKLKo9kXvXMRzL9vQDVJi+uCGSSy3v0szpj
         jy/1whFsu2Ot0XniI7LGNXDOrBPqtPWSFSH2rAtsiNoHkCptX2cWHI1K1CRuWXjgiEE1
         EIZfX3w1MifNjcr2O8agj+4d8MG5OqRaVpR8aDZ360tPOEen+oU65HAOVqXW99L3BaRU
         hWBYPV4N6iV0Yy4a+WB6TPy2EWvFm1QFZbgJBrQd8YtqvZNLlPcrw6t/Y1KiQwN3I1Uk
         dDrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VBnxo1cyrBP9eH26ieZ3qEE4H0EMBAPCxXo+MXkFYS0=;
        fh=jBb97q4RtPmF1NqMnSsZ9Q3x0ztDN1R04t7L3GWocW4=;
        b=cRvII+MKsBcqt8TebTmSGCZNo0nvRM1ATT6E0c1rrfARssrRuU4XbbHt32XVB2BWGI
         iUcxGZ3dq+60F1MbQIcp651fRQfjjqkPSR4HZ4w5+Goz0rvf22GFNOSJ8LeYua7MlbKJ
         75aJSeEIwbIwtXkTv5eiCLl2L54Q7tY2rxolRXVVz8T58+jacCpQyauUwVmAKo+1v1Pw
         hvJDSepCBl8ud78ic+0MT9S2m9k53lM3Pj0yDy2HBV9CsJyonyvneDlL1lxqqSnjZRv+
         /OBbXgCIsLhh0UaYTqCRnbptjOq/XZ5Y6wuIcXyfmmH7ccW2cNvyQUyXPnlgabWxybgM
         +FWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794362591; x=1794967391; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VBnxo1cyrBP9eH26ieZ3qEE4H0EMBAPCxXo+MXkFYS0=;
        b=tc2mvNEVIdm8B2xyfNM9PSN/LYEqHpd+CNNM5+GFrAjNJAEVehCOmZfouiWm6H033P
         Hv2o/4hJq854Uf3xuG809NW5W5Szou42PXkOPvSdJSA/g1ZA4ZvDpu84vKZA+EEp3I85
         2wnCUDAz6A9gdQ5KOyu9GEnlWDpj7eoednBRT62k6BWDuisKRR0EyAkd3HO9+61lpKMs
         1FEJlUZu1M63H2XTMlBtjVu/g8o3bsx/bOjWUHDf8hM9W3KUgYEbWZA8gWcGn2ldO6AQ
         xn3bexjLcOGgmwgeFiW3Fo0aYcsvuJwu9Ts/JCL1WSO/k6Pt/SL9RWzwZtVOpDkDOx06
         J3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794362591; x=1794967391;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VBnxo1cyrBP9eH26ieZ3qEE4H0EMBAPCxXo+MXkFYS0=;
        b=26XAV82AveI0KMPKaw+DrX9Y3DN9dd6u38KWfiuJKXVBFZtLM0xuJcJsKJhfsMKfWH
         pQtaUh9X2ViqiCm3KpWrxxE0HtMY29Uhu62PZm6x6QTU+ZJ6WmHBzY3rNCvxDzuLxpQX
         P28Ckniz9WAdknvCGC8TJe8QWHVKXAhlym4gDP4D5OXTVTxTWWPdF5lcBpbmDaS47/V9
         bUK4uIV2ttUdb6+YSrdBRzlZqzYKAjhOtcTMOm5v8KiyUHZooiIDb670hzGiy1Y3aG7T
         o6msym7j2NFEE8jsEi9j6X2cESV+WM82iu3WkRuCNVJY9SKqrVQxilxwfgaswXBn7Dwg
         dfTg==
X-Gm-Message-State: APuU4Z+XKvCBy9ySUrTt3NrHm+5KiYcWMz/u+X/SYuyMnPur7AwcTAaz
	o7AFILZ0w1lpCaEnaRUc/DpEvM7JmsYuvBD0YwiaTc3nfJUgywG/pqLSwKhDD6FymWP0rjZAT7W
	hAjzp37loHFFVZbcHRoSF4eFIEoiYQuM=
X-Gm-Gg: AYBFou2yb9YndqAinOYidDtE7UIR8fjBaGev2yFEU2mMdZEXS58ITPYXVKylVy0eRxu
	RIL5XcBH4BbLVIkUoqPuMDAxndJv1K6zd71yI3642k9hQhd9JRNeoFOYohKjlQD+T5ehKc1b6x8
	+LsDsH9ZY3iIqdcOz4bzaOQPX4vopkYJqGb8ox4OyG3YVfT6+LSnpsF2b01b2FpAuQO9P5zUz5M
	rjFOw9USDNUZ3569es/CGcoZxkFYijeqC+A7kOHP3J/Gn9pCpNVDszuzyUKT1TTbfje4OMmlA6+
	0eRzm4uta1iGROKollCpMu2TIhGggQVMvw1v40C0OqWN8Ol8R29OTAql89iawozO4eIfna7jWN6
	F6zVM61w5O+J4KtsRU7TvND0umMMjtXVH/vCXIBGPiKjVlqcCsGDJXj2TOKMGtrkcRDvPp53P88
	tL0xfKm8TNZXrtUDLENYkv9yOTdQ==
X-Received: by 2002:a05:7301:a0f:b0:36e:9773:84b9 with SMTP id
 5a478bee46e88-37685e6af02mr1672191eec.23.1794362591163; Tue, 10 Nov 2026
 18:03:11 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-gtp-echo-rsp-leak-v1-1-192c032f3dfa@gmail.com> <265240b9-c9d9-4dcf-aea3-b31c460a0e3a@web.de>
In-Reply-To: <265240b9-c9d9-4dcf-aea3-b31c460a0e3a@web.de>
From: Joas Antonio <joasantonio108@gmail.com>
Date: Tue, 10 Nov 2026 23:03:00 -0300
X-Gm-Features: AclHuK-wtfZcgBU4GAq4_YpIoQqfFNcIZX-I7sEBpi8z3DxPXOmg25d0xNehB-4
Message-ID: <CAOCBhwHW8=-CLB3rj=if3MQN=3En=t1eQ3eQuVJA6e9vMgLrxA@mail.gmail.com>
Subject: Re: [PATCH net] gtp: free the skb after handling an echo response
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, osmocom-net-gprs@lists.osmocom.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Harald Welte <laforge@gnumonks.org>, 
	Jakub Kicinski <kuba@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Paolo Abeni <pabeni@redhat.com>, 
	stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I suggest to reconsider the error detection a bit more.
> https://elixir.bootlin.com/linux/v7.3.1/source/drivers/net/gtp.c#L541-L57=
3
> https://cwe.mitre.org/data/definitions/252.html

Hi Markus,

thanks for looking at the patch.

Dropping the return value of genlmsg_multicast_netns() is intentional
here.  At that point the echo response has been parsed and the
notification has been handed to netlink, which owns and frees msg on
every path.  The only thing left for the handler to do is to release
the received skb, and that is the same whether the notification
reached a listener or not.

The failures that can come back are -ESRCH (nobody is subscribed to
the group) and -ENOBUFS (a listener's receive queue is full).  Neither
is a receive error for the GTP packet, and there is no recovery to
attempt.  Passing them on is what the current code does, and it is the
second problem described in the commit message: gtp_encap_recv() only
knows 1, 0 and -1, so any other negative value goes back to the UDP
stack, which treats it as a request to resubmit the packet to another
protocol.

The errors that the handler can act on, nlmsg_new() and
gtp_genl_fill_echo() failing, are still detected and now return -1 so
that the skb is dropped.

Regards,
Joas

Em ter., 10 de nov. de 2026 =C3=A0s 10:08, Markus Elfring
<Markus.Elfring@web.de> escreveu:
>
> =E2=80=A6
> > +++ b/drivers/net/gtp.c
> > @@ -561,16 +561,19 @@ static int gtp0_handle_echo_resp(struct gtp_dev *=
gtp, struct sk_buff *skb)
> =E2=80=A6
> > -     return genlmsg_multicast_netns(&gtp_genl_family, dev_net(gtp->dev=
),
> > -                                    msg, 0, GTP_GENL_MCGRP, GFP_ATOMIC=
);
> > +     genlmsg_multicast_netns(&gtp_genl_family, dev_net(gtp->dev),
> > +                             msg, 0, GTP_GENL_MCGRP, GFP_ATOMIC);
> > +     consume_skb(skb);
> > +
> > +     return 0;
> >  }
> =E2=80=A6
>
> I suggest to reconsider the error detection a bit more.
> https://elixir.bootlin.com/linux/v7.3.1/source/drivers/net/gtp.c#L541-L57=
3
> https://cwe.mitre.org/data/definitions/252.html
>
> Regards,
> Markus



--=20
Joas Antonio dos Santos
Cyber Security Specialist and Ethical Hacker
joasantonio108@gmail.com
LinkedIn
