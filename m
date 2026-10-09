Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2154FDA64
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 22:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791584844; cv=pass; b=FCZpCJUYCm1eRXb+QPAb5aNXpdS6YDKwO32ddPAu/bBhE7EoB98AJs+AIzwisoM7YET2TksNFVkWLRnran1Vfqu9N/V/n46Dx/HgnixCONlyIPmnABQowPUE06MmUVusfDhlf01hM8KRD0ocfpBCDN2SOvgcSz8GM+y0YtP6u0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791584844; c=relaxed/simple;
	bh=nvZAxM1uTFf6vqYXeKGDUerVMz9C1MteMmjjs+5GFBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+C/rM5Y0PbXR4+ryF4lOUEOuvjdozGLH/TxA/36esHacS4nAH9Ra0wn0e7FmGpBCU+sNmd4dEVvnnlw/n4enMaZfsHdBzeLCDZHZyoaP+G62EIGhS33BoJ0yDXMEn46t1nRDkP2j88f3rqPSmZKl6Buuwc7iHf5qwLgHXglnVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfNxO3Fx; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfNxO3Fx"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6acba4bf65eso252907a12.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 15:27:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791584841; cv=none;
        d=google.com; s=arc-20260327;
        b=Etx1OQ1AardzB9DYu+pgfywCfbcNxKWIuThyHnuZ04/QaobZtpKOTUuvABulmqE6C3
         lCRab5rvNMjC5dFw3ULWCx2DPRUUJny603ZK3s+yOIRhSSTu4IOnD+ArkrkVOn/FF+vs
         QPsQy/XRj+PSYm6vnav6yPvj9SgngOZOckAR3x/rER2MONDxq+bSDAzscVmGPVdyDFn5
         MeLKyLTkTAYk+uCioy5Hcl1VKp4i33j0hecP56sxKCdEKiD6eJwvGuS9kavF+SYTHvM8
         Wx8k3yn8ngrz3rGMk/lJ8KfBspynK2vLqf82XVjpRSIqhTL1fW30FBPQ3OQNztPX34Ov
         BZzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Uiiw0pSBFiqDyg4Oqrw5tZefMD0LZeMyg0eFusxD5zQ=;
        fh=uA/gQDxeH5EXosqVQ99q9VpcrtUYliT6RHyDBlZM7J8=;
        b=sOcBRerwOpc4WtGFrRH/Zs8Np6ikFA1fSTRaGIU6CBcGvgYVoLS03bcqUac7CggMGa
         8FtLDjHRrsWt1SDsmhsigLVJQPQlzjXQVm0v0IktiIcsrLNAKtQnPOHrTb+JW7E6gBsm
         20V97M5d4ZALCdUIa9qr+BmCqOgUkPTgLDB+E8hqjUMsEQtPi+gAOIkNuIgyBIgEW1y5
         XBb8VRMnKBoTKKRQ2LnhmKX2rF3RWNxgxLzpwlYcggkozaX4svNKr4fCwrHfh8we1Cj5
         BfywtJQr6WbN1VUvkpukN65DkU9DLMb4UTHAoF8t4QaKNFPmuqra2stPUyln84ZpEBm2
         /44A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791584841; x=1792189641; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Uiiw0pSBFiqDyg4Oqrw5tZefMD0LZeMyg0eFusxD5zQ=;
        b=OfNxO3FxSMNHbDRZHri/Rxk6+3oT9GsmxGt6lpkyjWfJsTp2pSfFPHaoZ/FpiPyRVT
         +0OI3qcwfmr/foQMDxow0SldLHCtMrFR61aAttpHl1iVgRAW7q/vfklsX/8XfPlQdJ+Q
         LFMix9pbndGbc6JaSIH6KUBkaocfgm6XfgheQ6JFKOI9O3xU1dq4wAQlviOlzB9lQWP1
         MoEQaUBj6GCxdFotaN/YwgUdaPBrTSbOGtcPRRWmr88zdEGcKwfRv6jRPWxWCrr/W6N6
         fbXh39/LkgXjVl5qfbNv8K1Kg4P66wgShjNrXOHsJzennVHL98miM6kGL5PngttfCdo+
         dm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791584841; x=1792189641;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uiiw0pSBFiqDyg4Oqrw5tZefMD0LZeMyg0eFusxD5zQ=;
        b=FdsV4TzCDuXLopxDW119M6aDISW7h+TlXt4aIJXFBfOVpRwEhthUJcm/OASUc+pNuj
         VqNP5TR46eme8YGi3bKbhHRSFIBAhOJXLpyb8vxUxJEqUZke+MNyZOVMPfNSVUv/Hnk8
         lYm9TyPa6AdpQsDWJsxGKTpCeYqfhGENeRU1QERhow2S4W9F8eRBV2WG2JUfxV5ySBnQ
         dKmLmcazJxXG6VBkK+GfUSV0qdagQOl6vpKgdVGoa7IRC7mf54DKNdTM/7AWQlwEZe5U
         4/7A/GsyqOvVoXSUk8allEH9koXehZfYYN4E/bLOKgrYJ1/rbZyaUfWiCWDqZjc5JeGI
         OO7A==
X-Gm-Message-State: AFq9FYJgGyieXr64Ea4yG2sLvamxcxwgXeFKEv0sXO+QLd4YAn9AkJ+K
	xHjh4RCqzKX/a1/8Bk71XK+C9gYnoA7hlhQfBtr2nhQBYSY+OCauoV5mcxH08vUEeS6wfpn8QDm
	Qx6UnRkzAw/VGwZLdvCt1YO6N7p26vDc=
X-Gm-Gg: AYBFou1GSitJKMa38Ri7N/EUrY2ETeg1QnfBokIgXThsmbfgPOceSAUaubAtiz21Jl7
	ffdu+Sgw6gKuwhvEhTM5Nfk4LRrLq1OEgb994KI/QMgUx7VV1CgZ4I8VIr7/z4V6gI9uoCmtJx5
	9434+jldgg0WpuU44BNElg0lltCTVoqgyBXuAOQ4jmEu4uDiim4GssAgWvXlOBrCFlVVLVYNkUb
	z2oLbd/00JwcsfK518XcUC6sJQJQwWiIdlcp549TA/BvZJ/ubOTZpiH1CpHVDAH2lxmEhvgQl2r
	zRyDz3vXUsMAW+hQUmJcfmQwH7kK13b1w/WLy1s00pOZzUcLXYj9PtW9yXFX+BAku0+d0CFzz/2
	YSJ0TdcrtDsBw2DdNHrvpDOJD+qvRhOL/iSkpi20+sQbyNvtHRTmXeIXeBWQmjLIvvExKxkCgPt
	pzl+3Xs9qmsURQ+n+JsbysXYw76PnVAW6c7PLMbT7Rd8kvt9xJy3I7r4J89/V+pD+BHA==
X-Received: by 2002:a05:6402:1ec8:b0:6ac:bd53:d29a with SMTP id
 4fb4d7f45d1cf-6b17c1de783mr2926999a12.3.1791584841118; Fri, 09 Oct 2026
 15:27:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007174449.671416-1-rosenp@gmail.com> <20261009164732.GG83879@horms.kernel.org>
In-Reply-To: <20261009164732.GG83879@horms.kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 9 Oct 2026 15:27:10 -0700
X-Gm-Features: AclHuK_prdV1ex9ara0f02v0arlilkcU-2ggnzgJ0G-N7v8b7hFnn0IO-j2lriM
Message-ID: <CAKxU2N_=H=D0p=g0XBqFtJFHDpidO-5d7P1kKZxXEDX86BGnPw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ag71xx: align the IP header behind DSA tags
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Chris Snook <chris.snook@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 9:47=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Wed, Oct 07, 2026 at 10:44:49AM -0700, Rosen Penev wrote:
> > The receive buffer offset includes NET_IP_ALIGN to get the IP header
> > aligned behind a 14 byte Ethernet header. Most ag71xx devices use DSA
> > switches whose tag sits in front of the EtherType, which moves the IP
> > header by another 2 bytes. Every access to the IP and TCP headers then
> > traps and gets emulated by the unaligned access handler, around 6 times
> > per forwarded frame.
> >
> > Take the headroom needed by the DSA tagger into account when choosing
> > the offset.
> >
> > TP-Link Archer C7 v2 (qca8k), median of 3 runs, Mbit/s:
> >
> >                        before   after
> >   routed up               743     855
> >   routed down             660     749
> >   local receive           554     572
> >
> > The unaligned instruction counter no longer moves while forwarding.
> >
> > Assisted-by: LLM
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> Unfortunately this patch did not apply cleanly to net-next at the time it
> was posted, so our CI did not run.
It appears I was careless and sent it ahead of local commits. Will resend.
>
> Please rebase and repost.
>
> --
> pw-bot: changes-requested
