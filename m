Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D92242E8C8
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 15:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788275218; cv=pass; b=jMwTM4UtBNuqp85rqmZeSUwIw20Q4SA1vivZxVk6lp1/KBTNoaB+car0HnBEUdV7MnDEOBYbTlEA/pTl3Vfy/KM09XbO40iXhpQPXt+J3WBqiAbFgdaNEOeZRKT0u/wbpfggSryiUb3WWQKa8Tfp4HvYHdXaD1SqELmvHJ9O2qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788275218; c=relaxed/simple;
	bh=ev9J0QWqNH5ZNHX3bqbieZbsXQx80CERSjNDLUr7qTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ls4X3evymJNHGNIuSITvTp8ElpSW6HmVURvT9D0RRRc7axbCMFpJPLeq2mZI+78vS1ZLbD4FnG84B7p9p7ERKYV80ytElLCYhZxGRKSFdsXqPRU6L9b1QHxWcZhkgqScpxt2YOgxnpOk11N2hXh92CR+nrYzo5UskGgRPK3Veig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ojFYTptO; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojFYTptO"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b477cb1f0fso568073e87.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 08:06:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788275215; cv=none;
        d=google.com; s=arc-20260327;
        b=nPMztXpGhFIcOWPpIzgAfRKhVocOs1MkJXR916fgqPQGjGfToBKN0JnwD3CxxVhqjS
         493b0YGaEVLkO6pl84ztrViG1DhDpbjKSfk6i9/kFJpp9sjX+jhu0xmeSFrHAwUcw+Y+
         aASkLVKk8APEdxHQg0xImURDGZJmOo5UXd+CFrtzPImM3QHpmUjKnphHCmbb++79ieyb
         R8czWE47nsBOhkVX6ZyuLO6YCX/2Q929qTJtijS5A+Ti1RthMc+FU0T12Y65sq8fcuA4
         /HsCszYSfx90GadzgbTRmRAYLsb3Xy9nsEhTjqfo5Izx1djgO1NRi5z1PUjIQBii6Oa6
         MZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ev9J0QWqNH5ZNHX3bqbieZbsXQx80CERSjNDLUr7qTI=;
        fh=0ZYIzaVrcLcXfg/4QEe5H+laB0ATtKBrpMzfLkOr0Xo=;
        b=jUER+E8UqREO1ot/HFUm0Qx1S0zR2IZC5qrm0O+IcleSWKOmV0pVydeiqdq8DuJzBE
         TyIs8jM7ReeN5Xkps3CJbRPqnldWJ3t/v7fHOth4tUtz7c72Y3ekcH4O/nAxdyMSzP6C
         Wij6R2IteWV6dobXreWqsl7RWjPkVQj5zo6Khios3u1kiM2wdIxJ8o98vHg3STzKzD4B
         E/sNzGGUaC8Ok9gLARHUBPiec1uWxlkkikbtTtgFB2OKbZMK9hCYUFzKO67d0UFL7I+F
         xZwm4dNmREzWHua4A5fCaj4LTieSV1WBOMgR3sYto2f131qzg3EMRf+wHZux7d+b82fn
         OJHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788275215; x=1788880015; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ev9J0QWqNH5ZNHX3bqbieZbsXQx80CERSjNDLUr7qTI=;
        b=ojFYTptOg093KItwGTDsniED485kph4jpgjn1GUwnvzDkH6V3Z3cy+IEfS9Msl+JW1
         aIkYVkGjg74G/23gX6Mlez/RhorJafvpWcOZOvhcU488+nn37jUlym0Ye56gMC3e6nSn
         g5P7HxhlUw8x5DMKb7KS1mSaASIgVTVKtBy3up9jqSTbCLeuw7xrDUALf9yYFdUesU3n
         XFCM/VaqQYaQVv8fQkcye3ANxBIozpNF5g1AcVxOtr0LrPHlgLATJCPR+gRr5e/X0oa0
         5ibOPsldK1gt4lDnIBV+oc7+JEHskyGmiRqcaeuBh4FoEOBM2kWFV1soff5ZZlgnKbz4
         6Xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788275215; x=1788880015;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ev9J0QWqNH5ZNHX3bqbieZbsXQx80CERSjNDLUr7qTI=;
        b=pRBTXzZeYSpxNTtzBVC7ZGFKcdULoHRjhPvv1eqY5tGtwWFGPlOitJzVMvwND5tcFQ
         P9of1rYfNLRM1pWINXGC/0wYMBe47jUpTfziuc5byF7Dnu9/iDf39huuG0pTlyIMX3sA
         97pSafjYCjOlCGouqMmx6wFu4EH6OfsSZs/5bYQFI//cLRAQU/thaUqw4EQPgzllkx7i
         MIBJ9vngWKZLCN9nOPBweUnmVQKxELNc/EvIfVuyMndld09RJHoLqar2PsIg7bCrSqbn
         TlbDDlTGl/XiYma2UztrljNVbouxljYs5Y7NakzevX/2i8nolL1ZijnFoxR3bnzdYPW4
         L4aA==
X-Forwarded-Encrypted: i=1; AKwUvBzTGLCYw9FYpnFHXTwlFBzi+YRpqTdlAjAHnGozK1+l8L2NHBetZZs35f1axegMwD0MwJ4uupI=@vger.kernel.org
X-Gm-Message-State: AFuF++lai/qO9AZr5uNHGI7CQsaX0Upj9OPCqMRe1wccCvBdzYULP3Ho
	boPrkbwTUEaBCoDoULH1VZG4OAZccBQcb9Uvsaqgdk41alObR7RK6q1PW9YY0X9liTkOyIU5krE
	/ulzUEiguk5gjLLXWC5LV/cBC7DyU2d9PWg7u
X-Gm-Gg: AYBFou2aq8evoV6m4lFRgIQ+LiJqaXjWvIX2ydlQcx7iDb7F+MH3aKBJUpKk19VzChz
	+WwxTZkr8CWMHve9UBBMeNfWD0oqS02CkHvXJawvMQQZ8eJMDJN+r6UExAYEIHMdRi1bI+143bR
	+hzaSaEQTxsYZcpqM88I9XAA/66WH3SBqjPNWlKatUl/9Vcc0IZ3tjky3Gcf2abqpuJOlmSvxeb
	n7xpCimjHH4EMPuRlHTMmyuygZTW/r46uUjwhPa4j+CzEvqtECY2UYWvUmCxPwsfmaZFd+weuzk
	BIrGZIKK59WSY4XBTVFmPN9M7iUj42JqSf/WyJDbtuLPbn+hfEuy8s0RgXjW/g7U+HPFw4ZNNAe
	uKqUP7OL7Xt6UAVah8/BCbwJ4h0qldixesNLcVtfMssrPk3HFlBpJ0BUojcE8
X-Received: by 2002:a05:6512:696:b0:5b6:4b2:c408 with SMTP id
 2adb3069b0e04-5b604b2c89fmr564382e87.6.1788275214837; Tue, 01 Sep 2026
 08:06:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72m=CJ7ngSBrnteyt07fHNRJ63J7m+=LY7UDHLmwYKjCJg@mail.gmail.com>
 <20260901144433.143989-1-springbreeze@stu.pku.edu.cn>
In-Reply-To: <20260901144433.143989-1-springbreeze@stu.pku.edu.cn>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 1 Sep 2026 17:06:30 +0200
X-Gm-Features: AcwNN1VohMNno_4kCMf8pJYarKFOSSvTqudvhKPN9hm_3z_OOOZ5CCH_N9S5yD8
Message-ID: <CANiq72kE9CxUD7-Zyn4_T_L-ahnj=cr723MsQ61KWC-YS1p9gA@mail.gmail.com>
Subject: Re: [PATCH net v4] rust: net: phy: fix off-by-one bit positions in
 device status accessors
To: Chunfeng Song <springbreeze@stu.pku.edu.cn>
Cc: Gary Guo <gary@garyguo.net>, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	fujita.tomonori@gmail.com, ojeda@kernel.org, boqun@kernel.org, 
	hkallweit1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 4:44=E2=80=AFPM Chunfeng Song
<springbreeze@stu.pku.edu.cn> wrote:
>
> For the older stable branches that contain 2796ff1e3dca but whose
> minimum bindgen predates the raw accessors, I'll send a separate
> backport that fixes the hand-written offsets directly, once this lands
> in mainline.

That is very appreciated, thanks! :)

Cheers,
Miguel
