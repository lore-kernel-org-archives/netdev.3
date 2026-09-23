Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FE338D01B
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 08:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790152327; cv=pass; b=fI6TDtNvHVPvFkyGPABPncJJHSllEorLfsuFHWFuNXoc6a8o23fcJSS6HrPX0wPtizdhCkIjYJtnPsTYmp206LfYUDDVZewpUidjntLwuD+Vbt7Z6CWvj/4rzapSurPI/y9+R4n8heX4nAg8OXoQ88wtbVrFZnWIDcQ5Z0qr09I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790152327; c=relaxed/simple;
	bh=hLbf5wdEcfSfArgGglezKU7/4be8aZs+31yfBhWP598=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMaWIqIbpR0Sm+PuL6Lclv5eBdei09khOrX+EkOxWBdqK7JMbOB9BPZgdEOxSmyE5+MEHq7LQ5wtH16re3jhkgkz8ns4yUvOiG1fuOXwHZ1XvhdS+PASTaHwVmnPngZyM90vUMu1qbQbmzkQM7LMNOEKb/OZUUxGKlPfVmE0GJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NttemEvV; arc=pass smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NttemEvV"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc9b6eeso6314266d6.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 01:32:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790152321; cv=none;
        d=google.com; s=arc-20260327;
        b=YZdESfjw+0hkyuM72BCEFlVzK/7EMpFywbBoYXP/6NJLLO8nKpsf0uPQg0RxpSTSVO
         FbS5wIaPnrqIfqOtuMKpME8rasd8BAMkJDYPMtiV2721cJuLuwVzfYgS8CrOz1PzRvAx
         EW7cxAVSR9InzTRgf9CdKJxNItt7u7uVkUtmosUz0ks6b+rSmJXOx973cdDRWXoKZu4O
         q9fuK5Nfun2T5ZCaSO8/gl6sxGxViDYVphgxwx7+8dy3fkIzq2/H2xp/l/BSzAsy+Voh
         rT5E12Nx9m0BoaKPb6JRdaO6UWmiy3d17JZ+VE062x2ca6Od5tMyGsdBdkGI2KM0GZya
         2QlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hLbf5wdEcfSfArgGglezKU7/4be8aZs+31yfBhWP598=;
        fh=ECk0fFWSHzWIpmWGVTWspG/iojPCDgNp5u9LuwDKkjQ=;
        b=mq6fSU3lxbKgJG0CaBl862Eb+6x2aL8EitNXeJBFQs0D/QZh/vYaZa9i9pD7gKlics
         wnL09r8LXPzJkRnqOIipCmE+LcSKrsezghkAvLk6nvrmSShNkjzrkKS85SHSCPEo24ut
         bnXyXDYj7Yti2Hsj5A6FMsJ/EewRIEIQLeL1VSSEZMZVy8tcg+mTW4nTbAGAbLEzUGkq
         atmBYB4e8s5ghSnbEyBObBgc/SRzstCx+t29CyQmFFcYSHHRO+azyJ1lDXSVfAsRiy+m
         HkBbcaimNF0eayRbdYMIMcdbDCsY0ctMgtMNUmRNM9r6IXxCnztr47Txtw0hhXszPuna
         Xs0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790152321; x=1790757121; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hLbf5wdEcfSfArgGglezKU7/4be8aZs+31yfBhWP598=;
        b=NttemEvVe7HFiC0/n/2XEDffB6Gz9Bwgh2IQ+eKH8YlZfzHQDCt97R0Pf0SBqu7J+B
         x5TAnZ2nbcGlg5c0V8jzgCQ941hX/sSI0Fcq+hf76CdHB2R8f0ghVDmUecGAYgN+G5KO
         ZKEEX86kmYGOxsXxn3cXgCwZAT/Vmw/BurKFRF8EdBV1qaw+UZVzYi5uFyUTcs83u4re
         cqobkZO51m2W0kNcd5dWweVPDxm9Peqc98eG+dPHQB8MPGsIIrNJillu25v5nsarat3U
         sjnWGQfyJKfCOj78G2xLuE+o7Uo0+OD8HxiyUUFok0zmvmcKNsERfHF8/jM15bBzsZWv
         O1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790152321; x=1790757121;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hLbf5wdEcfSfArgGglezKU7/4be8aZs+31yfBhWP598=;
        b=PXafaEZ4Dt9xFLivwLB8AOeG+ruwvktVSrdGidkxm2nuhSXNkar8bAHh9ruraYvodn
         CCnqxbJst1Py7IfvLL1LtSmMXaUqKGetDf1IpLNNwgPHhAwrbJqaQwl/nSDAtyBa8VNn
         qdmmg6ECIQxp+t2g4TKAJ7KOHB7kpp7Tx9xY8zCO6PCCeRpdjNiH3Z6i3QRuRxjKO32m
         C6LvkDeOp2suYgwmcHqTtVRqvTHGiITRF/qplVeElhGnjqSKcRVPJ1scJkHAgy+zM046
         RgiV1zdLVj9NgeC/Rz9+fvguceekTmf9+p9yxzceUCllpt5EQnW05CRR1bYvjpW9190t
         etbQ==
X-Forwarded-Encrypted: i=1; AKwUvBx435iYnK7Z13V4pjMPQlUC27kXTkiFP0pgDuKItrmj0aSuGvAXLheAgjtNIpd/xKDozpkZRao=@vger.kernel.org
X-Gm-Message-State: AFuF++nvjEnqKCykT33AGv8IqwlmtWyrQaEow7o2+OGHRvq8i3zBFCZB
	MHAqha4P8SXndEfDeOfIn9kCX1e6uLbgZkeLEmbcqqKgASlazd0HD6uweMpHbPHHFce7h5S0MKI
	Liy9KmgCCTHCMZ+NIeF9ugcBPvgY7H7E=
X-Gm-Gg: AYBFou0ytIaWQ/SA/m3WrQP6oAwtTePu+Dq3gdZfbvlmk+MMPStDc2DTEiQfszMipzg
	p6IHicYLBmCjqrrJhrHuiC/scgC5SZmow4pcnl4JJ0r1QNVoDH3matx87r6lAlK+63uvBp4+eSK
	keM67zgL8W8+aXJBrLIQN3ezOIEvyF06+kv5lhuz8rRfItv1l9CJ8q3/88gv2BmVLCpRDC5bqXS
	VxlR4evpjoOb8kfsBiiexnUxcFXFZMPLFAHa1OketbwfjMhypaHyNG3aRxM3UfCSvc4LMuQxpab
	h0U5mWj1bOL+DL6E21t+4NX1yYv+u50jNoRy9H66oVpl6cm+sQ0VaWLhqZ0K6qJN
X-Received: by 2002:a05:620a:6017:b0:93a:2d15:f84 with SMTP id
 af79cd13be357-93c2511c2b1mr290767285a.33.1790152321118; Wed, 23 Sep 2026
 01:32:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916235200.20712-1-ansuelsmth@gmail.com> <20260921135933.7e8857ba@kernel.org>
 <CA+_ehUwy9RUKCCHDnqoED3AMVnErgGr9RCrCR4ceg5QONq1wOQ@mail.gmail.com> <20260922172514.7feb6e7c@kernel.org>
In-Reply-To: <20260922172514.7feb6e7c@kernel.org>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Wed, 23 Sep 2026 10:31:49 +0200
X-Gm-Features: AclHuK8jGec2XT5CWPXvYVvV1bFvl8hmA75zakqIakpr84shp0cAZGnoi6_G1Gs
Message-ID: <CA+_ehUyFKZzd0uP4akgZxaLLJTwcvGGKz5ppCYsB++fn92Dn9w@mail.gmail.com>
Subject: Re: [PATCH net-next v16 00/12] net: pcs: Introduce support for fwnode PCS
To: Jakub Kicinski <kuba@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Il giorno mer 23 set 2026 alle ore 02:25 Jakub Kicinski
<kuba@kernel.org> ha scritto:
>
> On Tue, 22 Sep 2026 12:12:56 +0200 Christian Marangi (Ansuel) wrote:
> > The remark on the fwnode patch are invalid. The driver is expected
> > to return those error as probe defer is not supported.
> > (a notifier and late attach/detach is used to align to phylink logic)
> >
> > For the specific Airoha PCS driver it's really speculation from the AI
> > but HW doesn't work as described by AI.
> >
> > The only real comment that is valid is about the alternative way
> > to give supported interface with the .get_capabilites OP.
> >
> > This is currently not supported as there isn't any user and it will
> > be implemented as soon as there will be one. It's really to limit
> > the patch delta of this change and to progress further.
> >
> > Maybe FIXME might be suitable?
>
> FWIW no preference here, I defer to the human reviewer.
> We can treat the AI review as a hint if human reviewer thinks the code
> is fine as is.

Soo should I send v17 to fix AI that failed review?
I think I didn't got this detail.
