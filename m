Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800B03750C4
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784221071; cv=pass; b=fRF8aJr6x0EmHoBYm+fhYDxIraWOXYrg8mzrbnok81Qd8cveHp5bn2RdttYGgPM3cwdYtYa0wMDOK5bidypNE8K459xde3nKV4t78ebahBo55hdpDvj1wEELKNjOef7/V84w06OAYk37Nwdiylqcnc4+26M+LIaAR545ysDkq6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784221071; c=relaxed/simple;
	bh=6NjwaITTGuhWi/vVoexbJKDWMfDFVpQDEqQvDlyCRPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7qwobPvRp+QudAEA6XUYfUZ25YcptJzwFR7oDs7/3sWCPxIIpLSuQSepWQLzB/h7VoU/IR6DxV62By7rqGJdE1jT+vps5HdFW0gg5ePk+vRkbE1OQ1oB0DG8cdvuuCYzS48WnhrpgWdbRgEG8fJTtrKQcQgiUp9oBialmu8n80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsF1BETS; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsF1BETS"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6983f20a8bfso11003693a12.1
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 09:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784221066; cv=none;
        d=google.com; s=arc-20260327;
        b=CW+sxwxV8eACYLWp6iqjwRegLj3emXvuBiP4BKf/TOhiBVSwgQzU6ly7XPa+z8/3bK
         6vmnXOFgCDYwpgf6W+bt06rtQWIlXlaYYRPZ45R6EJ90ob/Xc95eEvGVhDFtaKg5Dcna
         C2tmWGd/Y5QY70S8i++C90CX7vOwNUcBG1V8C1Oto7abFSRbS09eW4roa55Uj0mCoUw4
         2Q6gBPZC0k1mhuYXRwJWTmgoq481LN3bafTXVclMTdaHSzP+SP0rPR3sEnSg20KZNZve
         DEg+TXGNmnjBA+Lh1o8E2oHZO//t3fuxK8lEeJWYtmuSS9yNWsLl37eL76PYtZkNvjx/
         G5YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6NjwaITTGuhWi/vVoexbJKDWMfDFVpQDEqQvDlyCRPc=;
        fh=fV0cNUjK1vVuh6VbgAtRzSH7kJsMZRkZrYkkFMtDAnk=;
        b=gtQhwwO6BTCpE2rvZ354652WUbnob5S3dUstWillhvIdyCaou68/E6bdlOWNov1NOb
         AAVK+i8n53VPm7IP1Oa4bP4i6RTfzrBTf3ADnze4UkMDvNwpOSAJT5mrRxsaHQWtGIql
         02Vaz2Ev429bpgFy0MZs5tPFj6jMHQ9/4mB8rIQ/ogk6rUdLyV3qsI4HOnSLGg+P+C9w
         EoPcnaeIJR2It0LvWxg1YqF4jiFLoTLFWQ0BG8pWks48dMYELbAxs9mRrPPy7lA8IUQl
         7nf82DaiRv2xvrz2iC6H8Fex8RDvuZ86lLM36N+daVqsD3y65gcQdHFaimAJaSMHlV/t
         +ZwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784221066; x=1784825866; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6NjwaITTGuhWi/vVoexbJKDWMfDFVpQDEqQvDlyCRPc=;
        b=bsF1BETSaTdbedgyX3UDFYyaKIQWeRWJMYw7AJE2dif1gJOWK9zbi8mFZ9ZoLWPr3n
         W2jK2wpl38f5oR0uYZvHZBZ38gisU2zcR55MVQul9YqQDezU3ZV/DwNcpaWrTbHy0OzJ
         dOINSWQ8FvdhuFrqmZejX/n8oYSryUzZ1hMFvzRrf/VXRGIlOPud/RF34TzbEsfXGBVs
         d05Pu4LH1M/Ls9akgpxqLo0VMfI86qzk+taOYkiiWXNq4s5LOhZ/lJvD3T0hxPC6VOhL
         68sFVstoOD+rqU472MKrzw2vg2M//i8m1pkm2+Q3fzVakv6+OPBOJxp+gtByqWLPQNoq
         9u+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784221066; x=1784825866;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6NjwaITTGuhWi/vVoexbJKDWMfDFVpQDEqQvDlyCRPc=;
        b=O7nmR9h8OcYXmOmR3FXuF7jQ/pCJ2mIhkibb7UIAVU5AjmykBE/+waCCIiMus+vtAt
         neva500PROYDfGUv2YyIaG9Z+1CCfhsf1KsjHskqTKy2/yYRvWFyzFkidlMLDZvYdsph
         j/m5Gny8tRZAfbrNhmedx9wLKvj38J8CBDgQWl0OeInnh57hHMCmK6jezoL+5k8SGWTh
         Cy3fdKWdYGm2u9HentF5qm/+wlx42dvINg/rPuO8grtc+UPxo2YMG9qtKn48Oy0voL36
         1EUu+QCbGoKNC9b3KqMrqeyGVlOK3HjwaUp+1Iaesxc4Mmn6ypmslk4thDxdb8NLYKxu
         JG9Q==
X-Gm-Message-State: AOJu0YxP0P6yDirAPo7B1K2lokqYb3kW0qu6HMA43PM0Oyq87gIwYmr6
	6mjQ91tNvpO2TyifIaVgBm9UZ742/ZlNr08ps5ljDijbeIrxQ+vmqU0323ecQX15nHGd12FQEqc
	d1YBFgUzFL8I+XfHZhioGeE+dKA9cxtY=
X-Gm-Gg: AfdE7cn93YmbaiQhVeURRIst/tgSqOfkSbiPzUbdwoza2nPpVL9yAROE0nSnDHMDLES
	rlYSvUKB+vg4e2IINMIjnScCe0WxoS4Ay2RkgY96DlIzp2ftVxf7NXk+EelrXe1CjocdKhO0w7t
	3DAsfsyoXGmaB6O3XCGZXyp40QJlyrPSsyOG8W1I6py6vMxnHblBOeaaSGXg425v1MAMgiSzqMe
	4m8+drLKnRsMggH46/7cjIRU5cVWTp7OlW0aOfKtYLOib374USWpCffs3mXkvBFF7eJwIvRbg==
X-Received: by 2002:a17:906:4fcf:b0:c15:be34:4f3b with SMTP id
 a640c23a62f3a-c1667a4d06fmr686600166b.36.1784221065517; Thu, 16 Jul 2026
 09:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716113805.593215-1-a.shimko.dev@gmail.com>
 <20260716113805.593215-3-a.shimko.dev@gmail.com> <c7193123-72e1-4bf5-85f7-eb68a4000c44@bootlin.com>
In-Reply-To: <c7193123-72e1-4bf5-85f7-eb68a4000c44@bootlin.com>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Thu, 16 Jul 2026 19:57:34 +0300
X-Gm-Features: AUfX_myt8K-MKOiNCBXLzaayoMJWqu1RPqM-4-pyGDeT_aEZM_2BqC_iHc4p4CM
Message-ID: <CAOPX746oV1E2pH0Y_9j0JvoDkxeLxv3nRO5T10o_r2=vJ7JMGA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: phy: add DAPU Telecom DAP8210R(I)
 Gigabit Ethernet PHY driver
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On Thu, Jul 16, 2026 at 4:02=E2=80=AFPM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
> You can simplify the whole delay parsing a log by using phy_get_internal_=
delay().
> It will give you the index of the delay from the delay table you have :)
>
> https://elixir.bootlin.com/linux/v7.1.3/source/drivers/net/phy/phy_device=
.c#L3085
>
> You can take a look at the few drivers that use it (mscc, dp83869) for re=
ference
Oh, great =3D) Thank you!
--
Best Regards,
Artem
