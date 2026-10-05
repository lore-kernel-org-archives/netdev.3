Received: from mail-ed2-f5.google.com (mail-ed2-f5.google.com [74.125.228.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E75379EF7
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 22:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791237707; cv=pass; b=bOuXKkLSMLwi3kwTmNfxBy4dK0B9IkhGA6hGk0dj84tCXh+6rCTmElGEufuzoown2dJPZlokY58//jJ1T8mqcVxMTlzWyhTHeSXIQhWax11fDankpRERrTXQHS5ciAACLrj4b6fd0LvgnT0MaUdLZf4ONXIrw7Io0tXu/kTltE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791237707; c=relaxed/simple;
	bh=pU6N+LDOUo5/wsUPaDzc+C7fTsEvvOq2zd9vTznRek8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M39ZYr05P2PMPv3h+Yp9k+Bb3g0v8I6hnGnoJISawu92DyJn+YFdrJhduQ65CATRgLVTQ5JgObjHqEmjUVDAAjOdGlYk0/PdE7h83YDvF9InR79cdyCk8t7TjA2Ga3ROr+KBg1enO48P9Ex2OwlRrAE1udLvnBIcjScO/fotgqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMVISnrZ; arc=pass smtp.client-ip=74.125.228.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMVISnrZ"
Received: by mail-ed2-f5.google.com with SMTP id 4fb4d7f45d1cf-6ae1a06a347so1725977a12.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 15:01:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791237704; cv=none;
        d=google.com; s=arc-20260327;
        b=KWS1QeNAdP996E9xoNiUCyNBdDBgNPXWRQur85NIZCdSIQaoay49QhweYtQMILYyH+
         b5XfhpgtvoAIxgi2qKHVfO2eQPdkru389Y2xD7NFtZ7KmymWufENo1hPLShgC6jRXDh4
         huRF7IEHzPJ8Sq+nsbH6gHI2qAZTR4XlDt5rc6YvYUrJY8uotwLZjGCx+sgADrufR7T3
         rhgto2C94x9kS/oBw09EKWRiGoIuHDu8dBLhgL5Yydk+3tZ+omze9V7WswrPtqg+5V02
         PV8rf82COoI0FsnBAeI3DO7pvX+BIihPekmTrV6QCNfdN6aRkxT/poQ9LW9IFv0uKtjk
         RBJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pU6N+LDOUo5/wsUPaDzc+C7fTsEvvOq2zd9vTznRek8=;
        fh=H7L6hYZlMkh+xbLeoUnJEVlUEjILnSQpbWzqUGOCKlw=;
        b=TmlLKlCloiOUBVxniMJXYS33GyusY+CQjxOl2ZPW1HSXM6YX0h4Wg5GAi+t69PYxpq
         xS8q8d0JSWjL0bTd3xs2QdIyxjG5ZfG/CZqd2YVnVpciiuQ+6zxxxw+hDs8UnonYSyYB
         vVpCT1KWLh/TXFDBaWwUAUTGFvdGArxvf0TdEOy4vinXCAuxZMR1aTiSQXILaescypKk
         SfkHIih5OqUog66xEoBZpSlhtUFebCNq8IbjbSrNm3dhLquQ5yqnlxlingXUFpwmew4a
         qRlJPaH/DrMu4HZBPNyCW1u2haeelP96AALNrGRXQ6mXvwo0yxdtGiMjn0Tc0X/uNKTH
         JQew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791237704; x=1791842504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pU6N+LDOUo5/wsUPaDzc+C7fTsEvvOq2zd9vTznRek8=;
        b=VMVISnrZL1wHWumoSE1JWHa4u73KOsWbHFE3G3orTGu7+JYRVCX3S8kMHXYSvdfG9Q
         UdXDeZAVvBHi1OkxNKzhjwcpEiVtfpZoUz224dn3W3H6a7Blp8+xrBV0HTEevbD7k/MI
         b1REuqdItszSL/27/2sEGqUGao3lb3DMzUog2l3cNvXJDBlM4ZTfpr5RHWofkW7EbEET
         fQlrRKaGib4KVSUhgdDFYIo+pklFe+IYLIiawdfQN6LWtnX684xmKOgcFpQAxFtzg8EG
         I8pKC7dGLRknHQO8NX/098ZPGp/FRCeMPHim1YTTvsy6AvSMnooyAvu+sucSvk7SU9Sb
         RPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791237704; x=1791842504;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pU6N+LDOUo5/wsUPaDzc+C7fTsEvvOq2zd9vTznRek8=;
        b=qaYSBK2mwHL7CbfOZBqJ82pevAVe/C5E/dZkuVACE3XD1zaWM3NHG4+eK6Sb0tpTNv
         47MCbez1AyjWl8KNluBUqHYe3xwMXZiQ3ONrGC6LqruFsM/d29vG9NnoKVpRFGtnq7Dz
         EWPWajWjo1WIjICJQZoN08LJiqYjg7lrQK2cyCN6P07Z/3uEZ8xKbaes7ItKz41xXHxw
         n/S7klzAPeeYVsWdVhj9Eb2qv3tBkvECF+bKNP2bpYsrx/A8LyMRRK8VyfeeuqrUhKax
         LN46Rwj3LH/f1mw3EROyPXqhu3X3dVAPwMPDpAgwMU75VDrCQamfPo0yPfp9cx0xwB8H
         Wcmw==
X-Forwarded-Encrypted: i=1; AKwUvByIerCtHqDebrLrZNgtH66HDliczDkBhxRbnLSpMgL/L56A0QSZG1oAAqj18keQ+oVntdltVds=@vger.kernel.org
X-Gm-Message-State: AFuF++nsFv3YZxXqjOV2fQIBWSCByTy3+iC+gTyhFFBEgcyuZWSdkzQy
	tDyMDxRRW57k0GSYy6NFkzNVlSd3y6OC4WnGKaONGMUTnVmTEeCOgPYLS8gjPUozSyJtuLBBTcr
	QV7qRlmcf5M00xGEOUG0Ou61ebnWyMBA=
X-Gm-Gg: AYBFou2mSpHKgm7UFaBC+KuLTmyFjhItJD/ngtc2m5431bum2NZErZ0MLXdrVyj9Txk
	GTGpyMUAtjouIdns7H6FhlDcHWtiMb3WsBVPJLkP1sPMv8YipA9njo63x1/FugLWBvXi4WtI/Yr
	HeHsny3OLRdYO+VGq4sY4IVm4AXun/z1IoCP/ODbwl/UTLD6l9pXYXmR1urJWx54x7TYDXQdeML
	ukmdnBrBH1d6lrS6CTrBp+46kE9svUgN5dZK4O9mbLyRku3F4OvERC3tgFT0T/0YdjaP/njMaBM
	cJdz403IxAy0v4DwaxPWc0zue0cN6D/2NIrSSdZ9QshHQg8xImCpaMsmZg==
X-Received: by 2002:a17:907:2d92:b0:c29:f5d5:5a92 with SMTP id
 a640c23a62f3a-c2e4b007c22mr1011878966b.28.1791237703713; Mon, 05 Oct 2026
 15:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922200336.2201212-1-coiaprant@gmail.com> <20260922200336.2201212-4-coiaprant@gmail.com>
 <20261005135939.01ccde50@kernel.org> <CALj3r0h7j-4ZAiX67LmbgpmYCvK-Xmzd_qnYYgoBmniAW+eiWw@mail.gmail.com>
 <asQZ99CMsQF10-RZ@parshuram>
In-Reply-To: <asQZ99CMsQF10-RZ@parshuram>
From: Coia Prant <coiaprant@gmail.com>
Date: Tue, 6 Oct 2026 06:01:31 +0800
X-Gm-Features: AclHuK-R2LsVgHnJjNmWI_vZ1n3RwcrYHA0O30u1dyI8VYXPn7GxP9tLow2x2eg
Message-ID: <CALj3r0i+sBhefWPqzt76OX+DxEZqzxg1JOz3d3te0sHzHQTV0A@mail.gmail.com>
Subject: Re: [PATCH net-next v10 03/11] phy: rockchip: naneng-combphy: add
 SGMII MAC selection for RK3568
To: Vinod Koul <vkoul@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Romain Gantois <romain.gantois@bootlin.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Shawn Lin <shawn.lin@rock-chips.com>, David Heidelberg <david@ixit.cz>, netdev@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Vinod Koul <vkoul@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=886=E6=97=A5=
=E5=91=A8=E4=BA=8C 05:43=E5=86=99=E9=81=93=EF=BC=9A
>
> Typical order is that binding and driver goes thru subsystem (in this
> case phy tree) and dts thru the soc tree.
>
> I can review and pick these if you would like
>
> --
> ~Vinod

Hi Vinod,

Thanks, I'll resend the PHY binding and driver (02+03) as a separate
series to linux-phy right away.

Thanks,
Coia
