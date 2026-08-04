Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9483F9F47
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785858652; cv=pass; b=Xtj9p/+QAkffAgE9sIu8QTbAJSC7ThvCQ4VPSTf7H1TolP2s0b06Vxfl/pC2Ump5etoi85xCYQj22ZMneRXX+InhwnuEOWEUr00RR/Dov5RvBd3PdF3r7snGJh5MkNMa0bQVO5KO90IQ2Le5v80ivYyy0kdrVPm1v9kEHDUOxu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785858652; c=relaxed/simple;
	bh=YLHqCI0apmxy/Gg0PzDYwmz45KsvUZw4eACWKX1AbPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzFPoixtVKW2kEdNavEHc/2O8MAkei2LpRvx/4Jx+clEzw9wQxQ4qRKlgKOt7q1RyiYT97AGlVmAgsWkPOrX6RPNzr+PSpaUnUlffcd0xWvN3Cj9VN7W8LkQBTy8qb8O9ktKF5iFYEXi/o5HRptjIpYFLqwBy74NevTYwftQFCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rEN27Ph3; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEN27Ph3"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49545ba3d4eso16867845e9.3
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 08:50:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785858649; cv=none;
        d=google.com; s=arc-20260327;
        b=sxUWiHnsv/+SONUyvOPNwxCNAubX3i5cXwpvMKB+3BvtQX5WUVJaYXhbMUfs8a/K7R
         7/rkTGQhGJ0BryFGrVGknnUf6LvJXXiTP6uKuBxiGa0670crQkIGbkM/3utP47oc+J0g
         56NtpGvkAvWF6BVjG8rfvrMiZJFly9XTSkfiRPAJn+hKjNZfFvzk6t7Eg6pPBO4D0qSc
         Ra9WBLCjD/Uf2TBSyelv3Z7eDVA3vQETe//SUKcpOdqvbDx2vjepqE85DJoAqKNyLsZq
         xUwWcqbxsRs+mSMhtbMZQqWTE1E1ZsO4KllNoEg6lAe+mfxfRzEDZi/extqlomRMs5y7
         KM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YLHqCI0apmxy/Gg0PzDYwmz45KsvUZw4eACWKX1AbPw=;
        fh=f8ZFmXTW8FixmnK3t+4uVrx+KnaPz2fIeTtMstGLmSA=;
        b=lHI7Hw2whpEpNpVnThhHxP90qprGjQMhhZu0VTEuFsa9xHRVglsF/GhDo6mTarfSng
         OxK49k5/Gs432D36dfPWXWkhnjEuw1SQbUr8lgo2S2AA3LBOwWhIvD/9frHXemBUe3jD
         4XcNRTWSmbJz4B1doyJcwOEQ0qdm7sIFXZ/X92f004nW/Z18LQrMEtAE30Nqp89nqMZN
         QIiDgjTUhPEZ2o1OgVVq3+UbHGtdqfoBVr2Hg5uNqcWELT6xGP/JSJfOpNb1SzyJc6uq
         t0gdhGcO7Fr3F5eTvZohKmDiOCfp3r+w6pseXk/koJ2xfXY3VdveSJWA5dxBDcZXzhLO
         jq2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785858649; x=1786463449; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YLHqCI0apmxy/Gg0PzDYwmz45KsvUZw4eACWKX1AbPw=;
        b=rEN27Ph3j36t3Kja0pLPOA+PZ1d4SrcP+5lRWHcq0USv+5G+h1JqhTP7d1DA/0agMp
         FuDkwHGhi5SoAY/GABa/LwEd1Z+/3Ilu74KJ/XggoqenvuayDgm7zOwiwp3ZYL5XSoT2
         6VMuHkM3YbjtztNwMSpz3Rxv6fSzanznDFX0bJ2TCb5p+3/akzsrzaak8E8t1v/AumJA
         wwUuDYxJEdKeWU/WsdzcYP/Si09abpCYM99rBfiLYKTBL5A/V65PsZeK/Yg2LuVhpWMH
         f8UQoVFzUHlMDTHszz7/IqMqPAhBs6GF5OSsqG5QfjVU7HVaiEZFGBCL1VwABkDOFWYn
         Iyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785858649; x=1786463449;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YLHqCI0apmxy/Gg0PzDYwmz45KsvUZw4eACWKX1AbPw=;
        b=F3m4z5b6snOGEZfF25REoD5s2Q6eVfrZ44kQxpTgVSeD7Jy3pA5PAofotc3JSacyrF
         ROaCP0JEuiVs98tZbBqdB7IQDihao5EIklGoAhIE5LlVlGM3VM9b3P+OFjruEa55e1Te
         Uxli2ijfMFWGAXn7WmgiCm1GE6tSsKzl7yircNFPMICGSPrJ5QVa7Ldcx/d31haF0X7l
         IbKhs7cVCQVgT0ZreBi1AeMLZPfVaMd7F5JPyAOa5eqF9E3t6CVYLVU6LVpqIIgr3TtV
         GA/150yPZqnHIhcdXwiK70rDYsWHymK8iv0uW8fLLwZ1jXpcCVUsOvpboKW3l9gUzwrt
         a0JQ==
X-Gm-Message-State: AOJu0YzK8M6GnivzyPrmebSWAPpImUgzAjD5Gf+HfY0URgML09dZv4FU
	dYOUZL9aua+lalZclto7YIny8hVRGbsO6wB4JnzD7oiQ4Kp/R94bhAGSLVKCmr3HGt9GZBmAlUW
	L5n9mhxkOA/2EFUd0C0hRgVKnJCbjbVw=
X-Gm-Gg: AR+sD12iI00qdhAUHP2p1ZGuIaQvq1DpsGJu5Nsqu72PPLUAsGXIkAvMRa4OJLOFvEe
	mE7SNgfW/mo5H2pqiQuJrbUBQooOKWlJuEiF74Sw2dOTAdmrjrNmEVLZd1G5cdtOLyCYALpeurI
	k8sL30rg82lwfzaPuybb0j4Lh2PXeyVQQP6l4u2gkXf89OorFCFLzPQevvAAmHaPZ4pDIoeaGk7
	eetTS+z37vZ7DNjQILYxm7xfs2PrXb9iSKMgGpnLaZkqZrqjfU14abQfhE+yTygdFgQuvKTFs2B
	vrZpsTOnnn/dN7neQL7nBif3940F0gG5Dhx85Umem6RdDWuS+xQ1qki6JA7OdvN0iIySHiLH+kj
	BmmH1ySXSYpIiqu45zzkHMFppejF4
X-Received: by 2002:a05:600c:8b14:b0:493:e983:806e with SMTP id
 5b1f17b1804b1-4980c66d8e5mr377998345e9.3.1785858649157; Tue, 04 Aug 2026
 08:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178536329631.250758.9931617589255894843.stgit@ahduyck-xeon-server.home.arpa>
 <20260803184942.397a3ecb@kernel.org>
In-Reply-To: <20260803184942.397a3ecb@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 4 Aug 2026 08:50:12 -0700
X-Gm-Features: AUfX_mwA3uKuHMVueiXPTj8-JjmaCgsbe-sjAiM7UALd185fxgzpAXkUKQWliAo
Message-ID: <CAKgT0Ud+KJSU7CDM_hkioU7q8zAo2eR=J5nE=S9hAgZAeh+Smg@mail.gmail.com>
Subject: Re: [net-next PATCH v4 0/4] Add support for XPCS based RSFEC configuration
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, mike.marciniszyn@gmail.com, alexanderduyck@fb.com, 
	andrew+netdev@lunn.ch, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, hkallweit1@gmail.com, jiawenwu@trustnetic.com, 
	kees@kernel.org, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux@armlinux.org.uk, mengyuanlou@net-swift.com, mohsin.bashr@gmail.com, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 6:49=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 29 Jul 2026 15:16:25 -0700 Alexander Duyck wrote:
> > This series adds to xpcs to add the necessary configuration steps
> > for the DW PCS/rsfec for high speed interfaces.
> >
> > I picked up the set from Mike Marciniszyn who is no longer with Meta. H=
is
> > set ending with v3 can be found here:
> > https://lore.kernel.org/netdev/20260527000958.81108-1-mike.marciniszyn@=
gmail.com/
>
> Since we got no human reviews I sent out the AI comments.
> LMK if you plan to respin, please.

I think I will go through and respin. Not all the comments are really
applicable, but I think it may have pointed out a few items that can
be addressed in terms of the documentation and some of the naming.
