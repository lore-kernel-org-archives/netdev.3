Received: from mail-ed2-f9.google.com (mail-ed2-f9.google.com [74.125.228.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA353921E4
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 22:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791237857; cv=pass; b=ZpIR43dHnV7uWQt/gl5C/WP8JIuTKkN67+ELXJSiRKMM1IFTBGA2dVqjS6pvpHhyHu3DGsgMekGnU1FKpxQ78PYGqSJxEMZpdjrUWYVG63dggmLUgxm8bo/6DCvxQrFWtQ02LSfy/RUnlDOhAtK3HJ9zy/a8G6BQei/OcayzmIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791237857; c=relaxed/simple;
	bh=KCErEo1wEmMk+mf7jU8H4RsXealnJyQ44fgkbs7wqm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYB/EI6e8Jv5MmqM10rT80/KJpBRh0RRAfGDV8y9ZVvhWrdsD8HMGpiKNNQ31sSslqbUK+Aw0SnrhBUGdsgt9R22lfYEz4qfEaWB26fukuZBF4kjb72itjaruxUw9XzkD/gudwzGdRWDdQ31ry6yU809aB5eon+Q3cfglkO/wfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rgJQptSp; arc=pass smtp.client-ip=74.125.228.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgJQptSp"
Received: by mail-ed2-f9.google.com with SMTP id 4fb4d7f45d1cf-6aca84f7c74so1373028a12.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 15:04:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791237854; cv=none;
        d=google.com; s=arc-20260327;
        b=pgMHr6MeRbI2PzssXux447A+hhBNQ+ltg+s7UFX7r741i5PcXoctgoJDi74rJfEwTm
         jriLCPvJ8FkjrN06M7ovg1V3bpq7QiQVPgDqVER7cSln8mv4ocNw+a5sXs1NMFIVs10d
         WL3S10Aq9VRlQgNFe8a+4dBntcXPmjkYwSaG3lDzJc/IgWDWZvetsCgJEj8BjGDzJXvc
         7XRUxxAj1wIbOQPxacOwJtJDbETE3jxcH69GXVwxbdfUF8VdPFLAH+Jr32AhgYGoyn/x
         LUmOdq7ks0FX4Lm+DDCmRSMMT9BlmP8dNQKutEhzTm8pC2BG83S2gIQ877CRg1Jml7LB
         pDYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KCErEo1wEmMk+mf7jU8H4RsXealnJyQ44fgkbs7wqm4=;
        fh=q547QBpUMfPfzLyqNAY4qgEG3Al9c+P86aS1kly14lM=;
        b=KkhAy5Bqa44JM/WBrliRFeQVQd9ir0tDqOhGJs7vECO3x2BhhONH+CEVf2q/QGMKaQ
         6/UEAWT5ARhAu9urq3tD7iWmG8ka6fWSEjL1h0mEBwhzW1/2xvXDrZmTEnsFUwKsRlMK
         NacFYq0K6g/+sDsSMI2sWnw5OL0Rc69dkNzP1lr4CdAGQl/4gAr5CRLXoJP+GWmD6KMz
         aTsE8uV0m/lo7PBj/WF/E2iYHjmHvxjquG8uPiQbV5enrPvNwtgpiCf7XxIWeF7LvSLc
         lfqUchPqAWvPw4iU9XFbjPyVOLbffdIcyDMuCexXtfZbpw3BJKvg6gBit/2CxBu3qk5r
         lJHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791237854; x=1791842654; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KCErEo1wEmMk+mf7jU8H4RsXealnJyQ44fgkbs7wqm4=;
        b=rgJQptSp/5lQbMC4IAeUZp21Nq8XNL1OauJhINU/5TD2ClLBvu3L/rCA5ellOgiTes
         U/ZWx+0rfJqnHnl4L//q0nNVUwqHQHIyeTb+sdd+9LLYkRsOFuraogGW8V5wrE8c51cM
         urXTHQg8JVDjvdzBOi9Tv3PZiDQaqryCi6pA5R8sYy9DfgLx2iFe9WL4FNnZzy3PPqST
         qPx9y9tKkJkYxkyxyjE1rEX5KGWph3fbmXdlJCFQhoANfJtk8VGRYpoSIuidg99m9QuK
         F4xn1FuXwLSfbnuHpTz8Kl5488H6aVgs9ZaXI4iFXfX2mtowMsY+VVziB0TtdO42NI99
         ctaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791237854; x=1791842654;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KCErEo1wEmMk+mf7jU8H4RsXealnJyQ44fgkbs7wqm4=;
        b=du/3319cmB2F0NdbmPGQkMv4+zBxlGiAlNxNFtGmxENRGlva1rjeTWeUJPJPwfgWrN
         PxcEjtX6SsVJjcs5HmTkKGwYHJRzW3RkfzSwS8MJ+6+/a4f+MFctdg47mdO8Ukl/2SqP
         wAHD4u3CmA3LPM28nG5p9joQyJXr49RM0a2uAwnuaIfF2GRhowcINjNg/9U02fJ1YCzy
         zqPbkRJax/RhehHfpZd3NFQMNwBEIijcxXdeS30vwrF37nXCGOKLet9GoFaEaJS6OkXF
         YxleciFvn+rFAGvSoIULEBXHAcTeLiXnIY7gsmBq7ullkh+w9BoJPDTAL340Ve7UUIxO
         Bccg==
X-Forwarded-Encrypted: i=1; AKwUvBySO1QOuMcBqOY//sFQeprsngHkFmNW+U8MuXrsbq6oXaWyyHNb9KbNRa4M61ku9mPsXGVBSgs=@vger.kernel.org
X-Gm-Message-State: AFuF++nQO1QWzBUUD95fpBjJWB5vCT0VDikxnoIEdvd6PaFkCIvvOjcY
	6dWRRTs+B8frPQO3JdpKMmTmxUV/a2eyjwY5fYNZXhTkTFRlZaiD+2nKEQP7VyR/Ua2uBwKGf2x
	Jb81zrliDcW0BqCh0Gp/O81gqd//Eigc=
X-Gm-Gg: AYBFou3mAhWUnGhEgUu1VOH/XLsPfQo1Z4YE2zny8FoErz7QSUtxpKeAGOQW49WrCMH
	Yju/qCrq2Nf68F9SVNG4B0dBcZmTr9cON0iz6iL06FGpJlsYgnGrj0j6uZ0vDeqaTePJwAuzOoQ
	+O6Jww0FrOlMG9B9DYLOwjj2N8hkBXbLS/kcaF4Fuix12Qj/yVMX1TYToP1WOwX2Xyfi597su/4
	gI4dSIHuVmRh0fm3HEdaFbMy4VMbdvdye3AexqmuM5ue27HvVOwiOxLL+mH1/ZdawhtvOIcztdU
	bLbnkaR4Py60hhqWPuSyOBa09CmSlm4JONv9qvwkdeaKAT6rqwPPeYY7aA==
X-Received: by 2002:a17:907:3e29:b0:c2e:19b1:dfe2 with SMTP id
 a640c23a62f3a-c2e4ad3b1cemr1046003766b.23.1791237854529; Mon, 05 Oct 2026
 15:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922200336.2201212-1-coiaprant@gmail.com> <20260922200336.2201212-4-coiaprant@gmail.com>
 <20261005135939.01ccde50@kernel.org> <CALj3r0h7j-4ZAiX67LmbgpmYCvK-Xmzd_qnYYgoBmniAW+eiWw@mail.gmail.com>
 <20261005144432.580daa2f@kernel.org>
In-Reply-To: <20261005144432.580daa2f@kernel.org>
From: Coia Prant <coiaprant@gmail.com>
Date: Tue, 6 Oct 2026 06:04:02 +0800
X-Gm-Features: AclHuK8_KLwVxsmgUNUhSrq19BEwBKrpkwc4LlinlPX0y7uVYSSqgvZVvQtFu6E
Message-ID: <CALj3r0jNFss4RqdPjJ+NJ=yPRm7zZA0N83T2XxqLuFwoH6iN7g@mail.gmail.com>
Subject: Re: [PATCH net-next v10 03/11] phy: rockchip: naneng-combphy: add
 SGMII MAC selection for RK3568
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Romain Gantois <romain.gantois@bootlin.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Shawn Lin <shawn.lin@rock-chips.com>, David Heidelberg <david@ixit.cz>, netdev@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=886=E6=97=
=A5=E5=91=A8=E4=BA=8C 05:44=E5=86=99=E9=81=93=EF=BC=9A
>
> Well, the patch series is already getting stuck because of
> cross-subsystem acks. Do what you will, I have 700+ patches
> to look at right now :/

Hi Jakub,

Understood. I'll split it as Vinod suggested: PHY binding+driver to
linux-phy, DTS to linux-rockchip, and repost the remaining net-next
patches separately.

One request: could you prioritize picking the stmmac lifetime fix
(patch 01) if possible? I will send it separately.

Sorry for the noise.
