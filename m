Received: from mail-ej2-f0.google.com (mail-ej2-f0.google.com [74.125.228.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A683D1CB0
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 21:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151596; cv=pass; b=OgDeffGpdsYjEU3GtFQJ+Cv/OpXopDRxlV1C12DczQZDqyEy3SveI3Ub1xehfDNJA3Gekc0yjLvGKaP3CwVdtNkYmRFuwPdxw6pW2qXUlYWRMnffa2KSR2jubYimqk8AW0wymPC8u7P8vHKE68uVCZ+wCHVYcNxG5FSkPWWjwz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151596; c=relaxed/simple;
	bh=CsvwPucuw+Ke8ThpJVLG/Iaipb3NGCgmvRxgL3GovcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2G40B0n/FGcKEhL6m80gBsnoaD9I8vlrwBJquzKV141ANIqt/y/xnIZXutj9Lt6nCLCCR762lrfuga7wAmU4ofET01vIIqCZBnzPj0ct6n4e0Tw8ZTOE4FWyoltNVcQnEBzPaqSBOwAjtYhClBQf/arZppGVM5c/9Tw5lT7skQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=okhixzm1; arc=pass smtp.client-ip=74.125.228.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okhixzm1"
Received: by mail-ej2-f0.google.com with SMTP id a640c23a62f3a-c16772d888aso73041866b.1
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 14:39:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784151591; cv=none;
        d=google.com; s=arc-20260327;
        b=r4JJMw9QJmrziD5N6SyjTQ42GWEYIl8EHdmGfR8k7xqB352aABDT4LKiWtGcdEDxAU
         LvaJJiKnmSthpeLjy64M0LLg2h+cpySfBtGVEy14csTOtzbE+NiM1PBOrV2+alSRRF1B
         MROyjfCI6oxaKmiQiIIQX/v8oY80JLqqIix5aPxItjzRSBOSSZjit/f84TJ/OoIllQ8Z
         +pHjGZkOTfGl1SgevuBHIWg01zKQdSEm33ix7lgId3pFka6Q0/imOFwnBya2AR+m70ts
         HD87AbsyZhXXX+Uk/4aENOf8oNKeoWDxDP4y3P37Ni0I62ffllCyJyUdDFU9PeMNHGLt
         N1ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ocL48N0azq4XQo6lTJ0uGSQUcUQGguK7kbKdujwlOjs=;
        fh=9F9wYNA7xJb/rHwjHOqxpR+vKsmX/kcMbr1GKrTkgwg=;
        b=ASSYL7RPe12Mago8jG1C9UKuAc9+k+zyeX5Q5GZv4DOPdWFcPYKqdNkcijH2WiVkV/
         dlIJjtXKWFdzl/Sv6Tv5IowncXnpStnJCTvmLPXuc+QkVNPzbjGX8xY0oaemuEwvYyJA
         hqYtIInKTRD/06cOPcZTm4VFTdJP3DnYlZfEXUA3xQB71dP6A5CPeKfQBGye9Rg3xOGB
         SLMI6FJygE/61IUbXWLS66YmvwbZvn9gcVfdddYxgTcIaPdWHLrpYmcdLbfB1b0/jPuz
         faK1QPIKZmWozVO6jDFEcAp6yYsT3niFBYyQwUJcDVziR+GWBQNG21WRi8yz4bAMsfTb
         vaiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784151591; x=1784756391; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ocL48N0azq4XQo6lTJ0uGSQUcUQGguK7kbKdujwlOjs=;
        b=okhixzm1cL/f45isRHCKp1QMBkP2YxDR/GGV+FoOjdW6JayvVmeIaA+BWX1/bHk6UX
         g0soFqMhJdoWLq4ianFiSjm9alDpFm4ppk4P28FOz6W8TKyeq95vBySP4WC7oaE8upSJ
         8VUnZNrSB0b3P5kraBKa+xfuoBvPnHkTOESwbGC3E+9K8aEsiHfw45LDeRyOvU+SJMow
         gfM6xHM7t8WIfjBW2qJIr8aKFdy288yZOH7bMp9Zuye/o1CCwvpgGUZULXH9QQXOIvCv
         tkD9VsYE24vWFdtYGWDPCaME2pNH/V4Q2pu9JZTRPeKhiAcKIoOYqAN01xiigVGFpNiV
         bHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784151591; x=1784756391;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ocL48N0azq4XQo6lTJ0uGSQUcUQGguK7kbKdujwlOjs=;
        b=DhBwOwCABUPz3NQiu+ic1CLvGhpklM/GpS0ZXQgXVRiUV+6UVJ75YOJq4fZcs9AIlm
         uDCqSwf3BeK/RwKbiOun5r7HumcjH+RPv7rl3AQx8j+vra7gWbnhhKB6L+4a0pJpZ9EY
         BC1pkuyhgWqJobL2JVRs2cJ5xmeymF1sKEi7tgIDjPi23aGKaaj8uKx9to8J+jXwrOuS
         pRW7IibeYtsxFz/HbFGMLrsns1j0eMe/MRs42pQ1cuQcaFZfRdINj7c4zS9hDVHuu7ap
         VNpU37wXTOvzvZpIv4sl0WV8Smkc0S6B2Ya7t8fjoueEmwuFSrfWoVIcnYfMynpnCLr/
         OMFQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrh0bKmHvymZautClb3XtdKdRjD/gUi3dllAL5LNgs/vkQawMfJA59N1LEAycqxe2DD4o/sgP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWBqVj7BCxVNqBb/UYx9PLxYNiYX2BPzI3uQ9Tz936ZsoqYN1i
	CAq7K7r1biGBLBSWFyuirw6ogi7x2FlRCl5mHDJZhkGmtL7s6Ox2MD9cHG9mu4xaZ0J06iGH3Jg
	rieNehr8Ns6+0m6Rmggh6XkFT4+ApqqE=
X-Gm-Gg: AfdE7clYhD5hdSeKRR+GEP9QGLLhnvwoTJGjvJkqOczK8OMVdhWTdHgKuORxm0CvWDV
	jmICZHJrehhlZkfUbEUhbwjvU5EqQSVqyjTiiJ6Fl0BHSh1VzzguWAHrRvzMHQF6jnc5IaRFguI
	dfmtOOtdh/TrY3XMfxCfgFU2JxV0haFm2VbygiyORlWYEvUc6Vmtk6tCYy4wkwsdgZ1u1AcN0Nz
	TVPZRzCgmYzoNQYh3qR4VzRYI6or7W7eFYGA3xCz0YWq37FFrwYhY+PATatJ+OV
X-Received: by 2002:a17:907:c317:b0:c12:68f5:e083 with SMTP id
 a640c23a62f3a-c16794fbce8mr296353766b.64.1784151591115; Wed, 15 Jul 2026
 14:39:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714191341.690906-1-coiaprant@gmail.com> <20260714191341.690906-2-coiaprant@gmail.com>
 <dc21b2fc-ae11-4fde-a5b9-09e2c6bee5c9@bootlin.com> <CALj3r0gWyfHHp0S4=71M1-TjgHKcgGax4Lr0DzPi37Q69-iCwA@mail.gmail.com>
 <685d91a3-be6f-42c6-9e23-07629e21bcee@lunn.ch>
In-Reply-To: <685d91a3-be6f-42c6-9e23-07629e21bcee@lunn.ch>
From: Coia Prant <coiaprant@gmail.com>
Date: Thu, 16 Jul 2026 05:39:39 +0800
X-Gm-Features: AUfX_myJ66lYjr_Qz6cecGRXkAPSo59po4VpMAdHmLlPvDjxBLGd-D-lw51lYoE
Message-ID: <CALj3r0hrKt7T6_aZJ_cOJ=akPgShsau6-whcrrWekJE6H-z05w@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] net: stmmac: move XPCS lifetime management to
 platform drivers
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	robh@kernel.org, krzk+dt@kernel.org, heiko@sntech.de, netdev@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
	Christian Marangi <ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andrew Lunn <andrew@lunn.ch> =E4=BA=8E2026=E5=B9=B47=E6=9C=8816=E6=97=A5=E5=
=91=A8=E5=9B=9B 03:57=E5=86=99=E9=81=93=EF=BC=9A
>
> > I actually spent all night debugging call traces caused by the current
> > stmmac PCS lifetime management, and it was not a pleasant experience.
> > The code feels like accumulated technical debt that should be cleaned
> > up.
>
> Russell King will strongly agree with you, if he was around. The
> phylink integration into stmmac causes a lot of pain, and he wanted to
> rip it all out and start again. But doing that without breaking stuff
> is going to be interesting.
>
> If you feel up to it, have a go. But take a good look around first,
> make sure you understand the different variant, internal vs external
> PCS.
>
>         Andrew

Hi Andrew,

Thanks for sharing this. It's reassuring to know that I'm not alone in
finding this code painful.

I fully agree that ripping it out and starting over would be a huge
undertaking, and I'm definitely not confident enough to take that on
right now - especially given the risk of breaking existing platforms.
My current focus is on getting this RK3568 SGMII support into a
mergeable state, rather than attempting a full redesign of the
stmmac PCS layer.

That said, I'll keep this in mind. Once my current series lands and I
have a better understanding of the different PCS variants, maybe I'll
be in a better position to contribute to that long-term effort.

For now, I'll stick to the incremental fix that this series provides.

Thanks,
Coia
