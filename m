Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776C93A59A2
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 06:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305246; cv=pass; b=D0KE+FdUcW17r0P1sx+TnVjkVQdpNMFrmB2FqooErvnL+YAqpKsvmuqgXSvKwTbtcgP0ZWkQvQsyup2qJdfSOwFMNKRi5aK1jaocpBJ9FGd5x6pf6KfG0vy6St3uOWxcYGoxbdBjonqu9pqSfowQFn9dIpLhBJ2cTRG7PzmKkQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305246; c=relaxed/simple;
	bh=fLe2oYCyUgAs7hQTvIDF0cIRtEZS0lZj7wZ5q0BdP7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpc1+wVu5rVZOnD/Myeat7V8hz/x2Pl06zI1NqLAEbWtPJ3GG0gfCon45iJwNwbyomXwvDkFaR3It2niGXHDMFljDhXENCsXW0fc5g8Ih3MQSFW/E5l9kpcFqmuNo9YYJ0LnwhESVK9y27DLgKuh4qHMXazL/hIU/mmKEVdR000=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdIfsJxo; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdIfsJxo"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-80cebd41372so9377857b3.3
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 23:07:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785305244; cv=none;
        d=google.com; s=arc-20260327;
        b=JqoO1i0NrzdFpwe78lRXvM9unBVY6YgiE3lGD/vj+zczccVxHjZXaj7vRTaI6hT/9E
         TP9H5tM/qsP5znJrt0+DiE53J+6WyemsMXxbcenxINIu4DMThl5mcn2k6yFSwcvXwlZq
         8OGsI/75atSxTmglnOuw9ENNaxPhUZz9htNgEyn52GIENu7iFn9hVNHYVjTrZMeruLtd
         fPp1x6fb+3myjSU+nzjv8t0IquMKkfHbMSAX3A5UD0ehMqOPvKMI3pGPlDUivItH9PPV
         d1utChm6DwjELUHwg80nluVQRJzUG74ue+GFqZWcAzkZib+56UMu9dSvy3j7YSPsVuMG
         Wx+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iScxJJqL6aRxzDugADjE+N0GIV5NkGLe6YmtBInYTFU=;
        fh=HYXkdbmIawqnw9+WSpRMRY9adV6N6q67gfQl/a4dqeE=;
        b=gNVf3Jzk9IL+roWlxEdg4FKL4l1wcDudG0Po+N4l/cd5ncxWaT9aEXC8pyLzFKWiPY
         sPL3bXUXjir/Eoh24Tlwpa6tXoNkLdfZET8Pn74p3npCRG69rL30yPukz1UEcX0xRUYg
         cuowmoYNELGcod1bDsK3Zfsdm7oQ5ooDFGFkyEZku3DCblyqQejupiyp8kRdvurM3k0T
         Zlj2uOFVBmBs0ws35GIJQFkswQjR4D2VONthTjTfA2xFiOYA2jbiTSd0RSD9R4VwmyIi
         8hxtnmagBKbHfo8a4Y0xGw1mh1pSIy/aLXBvXts6uzwotQWj1U1+f80kyZ5mG1FfsO2Q
         98KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785305244; x=1785910044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iScxJJqL6aRxzDugADjE+N0GIV5NkGLe6YmtBInYTFU=;
        b=XdIfsJxoaiGYNYNX1hYRQuDkgKY4+pTujCQZ7B8lADpqp4UfJQSpQ6+C93ezJCt0Pq
         finIrpmqe8ZJzToD+k6CsMEaM1DDB4o4N2CuMqg+3fy96iEBXCmDyjTjXH+wcWwJSKFy
         NDdImeTvc3Fiv5loDIv/FULUSbPHArQ9XWOFIDB+ZOUkDixjq9KFEa/yZ5j00MYI4cot
         I2XUZZxHp5qstDl9j3ZHZ4Tv2Y8hXLnBOVsvJ60AdjHCpZDZrgSOb8M2Jdy46MDovgwB
         2fiibX69l2JnfuiHGPGkvcDw9PMIrlaBMuM3k1iLUtFPiTE6BxeVqq7ra+1j95cGVvbt
         ZR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785305244; x=1785910044;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iScxJJqL6aRxzDugADjE+N0GIV5NkGLe6YmtBInYTFU=;
        b=Dnor8DVBvhMg2o4ZaYMUDnchlOpDhx89JmIDuDIALn5fpLsHNtbeudaRuPR6ojaE/5
         IMl3A0vIn92tG8TlzKHomOo4q29XcJGoRZsJvGubTiZZUkvw+XbPH+vaEPT5+mR5Q6Mk
         4DYB4yxZKLH0ILhHrmeAVKkNs3BiBHSVaXAU4QaIMMj4FWz57grOKbbiWlRpAJdB+KQw
         D4bhoierrYQ0VI9iKeokRFPd4OUdvCvIQ2wQaBjoIZfYWf2A2j6nk3fJZobVmhhEoRXk
         hTdLYjbeBJysfEXTMyv8VGsPyKJ0ew3N60kTKt2gAuD1dwgI/I5wbSMgYdFugNvnt4U4
         AQ9Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp9fqGGtDeWLtbL7MuqKBxD+ipfdCfO4BaEO4X99wtAq8Z+GL3OBFv/hMOrkWTl9y71TmFbHRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YypAoujY/HZon7Ps5c/g04WUweXvecY6ssBvlzw7Wo8v6ZFoUPT
	WhqPVBVI8V4sH7c/chLbzjzsZwPXui82wdJo/SCQ2CnbOA6MsS/DyvERdFq1FFuZ6BVdpOgjXs4
	GQ/Sg+m+Kfs51Kw47JIHPoRVtmh2ec38=
X-Gm-Gg: AR+sD12si1yKdopIXixT4+Izbhj4JhZLpCmMAlAgALeltf3lvaWmZqHIOW1Gl8EV6sU
	0CP47d3vrTKz5vlohBGZ+sWHP3SZFcTmCWv5dV+0sq7Ur+WPxmVi4AIolTxrg4aOm6UYTcnXVqN
	NAYg4eAwVCFKL9DAIm3Ru2obBm1CVcFcNpJ7UWLvpKiUSHObOoUwYW0uEwnpxrKafth8emrXxx+
	Lr5Rk4L5Gpq4uZvPkjFLupK3gdL4e/bNvc9v9ZdZXeld2kzmBwQNvqj9JbcxU024WKYwC/5oL1I
	pzC66rgyk8dnptoybSFr6S4LTFYFBdZfZJHafcx5yGh0
X-Received: by 2002:a05:690c:6288:b0:81e:3e2c:6fea with SMTP id
 00721157ae682-81f992c052dmr26846517b3.70.1785305244310; Tue, 28 Jul 2026
 23:07:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727205602.1188008-1-gahing@gahingwoo.com>
 <CABjd4YwmznLERMx_DgfTeqXmOEZh=pcOjf+NYfkV069mETe-uQ@mail.gmail.com>
 <CAK2JjQVsJbC5wuLs1wFvose0S9ho6FDNPbhteveWOttE0prjeA@mail.gmail.com> <37c2162d-134d-48c5-92d8-3355306f15ec@lunn.ch>
In-Reply-To: <37c2162d-134d-48c5-92d8-3355306f15ec@lunn.ch>
From: Gavin Gao <attinagaoxu@gmail.com>
Date: Wed, 29 Jul 2026 14:07:12 +0800
X-Gm-Features: AUfX_mzFc5FibGLhOWxikG7Xcpuqj18wIU8NW_SBpEU5pYp2tsVN9ltxDi0C_Bc
Message-ID: <CAK2JjQVf=NMyzW5OThTnZrUGBevoL=EQW6WVLyCxkxCYWDQ6Dw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: phy: motorcomm: enable the reference
 clock for YT8521 and YT8531
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexey Charkov <alchark@gmail.com>, Jiaxing Hu <gahing@gahingwoo.com>, Frank.Sae@motor-comm.com, 
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	maxime.chevallier@bootlin.com, heiko@sntech.de, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 4:54=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> Please don't top post.
>
> Look around at other drivers. Is it generally put into a tiny helper,
> or used inline?
>
> My gut feeling from reviewing lots of drivers is that it is inline.
>
>     Andrew
>
> ---
> pw-bot: cr

Hi Alexey,

Sorry for the top posting.

Fair point. I checked a few PHY drivers and this kind of optional clock
handling is often open-coded in probe. Inline is fine with me.

--=20
Best Regards,
Gavin Gao
