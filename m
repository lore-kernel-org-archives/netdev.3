Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE353403E9
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787154966; cv=pass; b=awjnHiViHTkWJA+OTfYrCAkFtLSry7VO8wNEqAL9XfMY/Pv0iKsT554a+kVuM+UI8ffbtrX9eTOYdbuC3vCYwGkdSjOdpdN6SqC6mW8i3vbnJwPMVEfC3bQlc8CCflQyrCSC7KL3q68P6qiTzQX039+pM1diu1uTQKihVW+Y1p0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787154966; c=relaxed/simple;
	bh=QCNVGM6JXF/7JnLS+3lu6Q1utffymbytyo9HJaN2nbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3pQkRCiNepEBxJSY9fYcU5tTSvB9cYPWQr5gVZjXHqyCxx/wH4SiGHFCkFd23tncc+MT4qmHOQFIiDaNRJbbvUo6mnPMdfECa6ioK3TRC58T1U54sH83mGz0K8aJBvdsRCg53kebKODtXo6/YeAQQ3jrCX/9fR05buDTUZX6ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lv+e8mad; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lv+e8mad"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8f0e5e36912so8919206d6.2
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 08:56:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787154964; cv=none;
        d=google.com; s=arc-20260327;
        b=EciWZIAPxHb9YIjHJpLgCFoBRSHVX+ociuWMC5n59P6Zk8OFiKO5QoqtwT6cBbVrfJ
         kDfg1Yy8VxjFP/0VaZRfN2q7sKw99WTo02V+els2KrbsmZxkQp77RpXhN0j8NsNE6KKE
         mlwp5lLY8ZSVEQbSnnWK0Iq8G9PG9cuzCfmTZqYXa9uF1kqA6B1+A6m+FkQxeMWhNB1J
         33N+0zK5+D7C/yMpCpFhVorZxDDwnR8DppFJ11IPfS4cr9GAp+hp+9PdgECFbpTDYXf8
         dFkN44Xvmw2Vu/KduzpQkP/Byvpjpz5kAsuXU+x84WdBjBTfqQLDmMsx+JHtVywqGi8t
         SBJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=luqgKeY9BCSFP8cqU5Wk0SA2ZSLwx1JOWvC8sMgRww4=;
        fh=atJ6I4s2rHOgkn7IaRuaJbjbk+2c8FiBR2m1ts2QPQk=;
        b=egarnOK2iMgBkTWQFBYo3H30vFy+8eYb7CGXFyKoBi7O2hjcs0I/uM0Ft+ai2bW16d
         mpmbo9Mcw/RplSoaEAJL5PTTrLc5edBwDS9NrRTL/UEFfznpi9Is1cmAjMpX5pq+z5TV
         VKyrBd4ogGpBnlmZHMEDKNvBvQ05aLXvO7avHIBgTUMFVFVcNhTcF7cru1tOmKZH/t5p
         QDsWUPOplnuhAL1J3zBWEuFT4sixmPTzVTWb6bz5qe4dI0wzs7TI83q0Xun8KX3aeszK
         gFHqx7XsGQUph7tFJrxRUI9Fi1Qb2qq56b/3ZdG7OyuFBR+XySKfaurOHy9trspqh6u7
         CmjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787154964; x=1787759764; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=luqgKeY9BCSFP8cqU5Wk0SA2ZSLwx1JOWvC8sMgRww4=;
        b=lv+e8mad5MWSEjrTzWsKk/HZAA0mbiEAqSjPU+5ufxbq928r8nclgbeRPNvB5AQb/W
         QPuIGxRRFdgoHCDvdHJVUbzAyIliQ3OT6Wq5d8WG4ZvwLBMO0zgsf0Q3noZkKTr3jsZ1
         VQeiC7TrZfZX5mrJiQ3OIdTnHWJ6RGHVXqwEWgtFANFda4myx1rt6HQDp4kpO1siXQch
         rihnLum95OdgFLdbUilkPCNnhFD/UP6keOUbD89zpclHhUZruEbW7KFQHQ2EgCvnAtqx
         IeM0mfAR+npWvA2XcyS8rVZhlgVkT298sbyYHMi6d1FmMSofSTjRDneupoCdVWRo+dQh
         Tbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787154964; x=1787759764;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=luqgKeY9BCSFP8cqU5Wk0SA2ZSLwx1JOWvC8sMgRww4=;
        b=PFveN+/AC98MuRzyvWD1mTV1iFShCuqrL5tnHCI58jzYhyCP0XZaFm6WOLauXh7FmS
         q/C7L9u9zRlOx/+YyOIwhZxHsoE6gpfGHsm2W6VeAxHoGgy0iIZQKcGlqB0cgm6st/XK
         hY5auWKJQZrgbvBKOzLkGZlKQQUGdZl50oI2OhhaganLn5xGKzWAuYttLfEUeAdu3akQ
         hrFsqmcsCAmIWvZAGT7SEQwN6yK4TgjcamqcdcOktAgo7hTUVnuemy9n8RD0c5LtYhN0
         2IXS7eupskJordJzFF4meRH5N6fyCT32If27AWuJljWSkOUGIi9ko+I2qjH9sJgh+5NF
         zmHw==
X-Forwarded-Encrypted: i=1; AHgh+Ro8oTpk1LIKN/sJBkTtbjGAcZfVKOjeBnD74zxQqF/vx/xLVel/LRr7Tyw6oR1tmHf/C14wwcU=@vger.kernel.org
X-Gm-Message-State: AFuF++mOpp/jo137HCli9gkLS/YvoQYumKaT0TWT/mOmhSB0ly5MsGFz
	XclFH5fL8uHEFdH4XaVvd/6ooHrhlOp48qfi4wFV8h2IVxtyOWPGBiQmAQITOfTX5lb/eHa8SYD
	HlVlzR5vdT/khMMa4aLl8enLe9ClGdmQ=
X-Gm-Gg: AR+sD129kpNVba3sMSnh0RAcM0V0WD5RdoUCigsTHr0p3jn4IDXO//KNYojRAU6iDEp
	1lub+SXytONgm+12dI4NWS2as5kyHN2uQtf8lSsT6qO+RMNah4WnvH9hE8VpMNvH1U4EQ30V37z
	FS6yYO3tkc1Gd8P0zWRNT6kecouEAsGIoZbkglptC9HhM8PV53h7fFKj99jZW/JUzHz9BgtcTHo
	XfrwDj9f9Woswzavi+Jj+nfKxDKMrssxI7oLs3H9eB0JHdCcyfcMvPB/2T0W8RjODhTzgk4dkFi
	cpjtcNxXr/h399XAY68X5ze36MxYlYlBak6IfMPD2Q==
X-Received: by 2002:a05:6214:dc5:b0:8e7:8d53:2417 with SMTP id
 6a1803df08f44-90c5eac9942mr52592116d6.27.1787154963571; Wed, 19 Aug 2026
 08:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813083536.970196-1-ansuelsmth@gmail.com> <20260817134727.1f76d6dd@kernel.org>
 <6a8376ef.be1895d6.92f57.c9dd@mx.google.com>
In-Reply-To: <6a8376ef.be1895d6.92f57.c9dd@mx.google.com>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Wed, 19 Aug 2026 17:55:51 +0200
X-Gm-Features: AcwNN1WR7Zj_IFCR5YdVpGhfxkJspgU8SJdxW5GIgyyCDjlcNc7jn8kiW6V-vUc
Message-ID: <CA+_ehUyRKtuCtak5XD_1LUMEmLTn4JfeSDapsAEwo304uxyVqA@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] net: pcs: Introduce support for fwnode PCS
To: Jakub Kicinski <kuba@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Il giorno lun 17 ago 2026 alle ore 23:02 Christian Marangi
<ansuelsmth@gmail.com> ha scritto:
>
> On Mon, Aug 17, 2026 at 01:47:27PM -0700, Jakub Kicinski wrote:
> > On Thu, 13 Aug 2026 10:35:05 +0200 Christian Marangi wrote:
> > > This series introduce a most awaited feature that is correctly
> > > provide PCS with fwnode without having to use specific export symbol
> > > and additional handling of PCS in phylink.
> > >
> > > At times there were 2 different implementation (this and the one
> > > from Sean) but Sean agreed that this can be picked and used in favor
> > > of his implementation as long as his case with race condition is
> > > correctly handled.
> >
> > Coccicheck says:
> >
> >   drivers/net/phy/phylink.c:1039:31-34:
> >     ERROR: invalid reference to the index variable of the iterator on line 1028
> >
> >   drivers/net/phy/phylink.c:1364:26-29:
> >     ERROR: invalid reference to the index variable of the iterator on line 1346
> >
> >   drivers/net/phy/phylink.c:582:7-10:
> >     ERROR: invalid reference to the index variable of the iterator on line 569
> >
> > I vaguely recall that you're supposed to make a copy of the pointer,
> > not just add a "found" boolean. Dunno if it ever happened but Linus
> > was trying to make the list iterators override the pointer on exit.
>
> Oh! I wasn't aware of this intention... I have seen lots of pattern where
> the last value of the iterator was directly used (if detected valid)
>
> It's and easy fix... I can send a new revision right away if you want,
> I'm already on it fixing this in the meantime.
>

Sooo should I post a v15 with the fix? It would be great to have this for 7.3.
