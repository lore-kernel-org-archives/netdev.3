Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD983BC697
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773416340; cv=none; b=J77IKdOa8MxmVcHt/kWt9tWcVaM2UZRqqYkjCAz+GeE0rVy7O6kiZJGPl3/GILBpsAyouDfrett5g/+Toi+Whz7lDkmzs9CBqgfyiAC3rgE3t5t4gNuCYSe0uPR2nCAZa43EX4tyNIceZuAblPH3Kriys1qcSggqOKBdnpY2r/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773416340; c=relaxed/simple;
	bh=6taFHZkgytK9Z293AzNZaJurmYT1xovlqM4MPRifUIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSjyre0AYN6TLVnXRAJSrH5rMRyKbi7LLJA7n3YdaiN1c6iDpgN/6iPe6a5pLVtnra9b8prj++as0qjyhmeU5tHOQH7wzdtfjm13A3yvLEg3h4LuEzL+pWfZSriEoYbuW5rNR3vmjDQVzW4vh0ps7dwxp2uzmR6jGcK7TR/GbDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiernwCI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiernwCI"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-483ad568d68so3396215e9.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 08:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773416334; x=1774021134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6taFHZkgytK9Z293AzNZaJurmYT1xovlqM4MPRifUIw=;
        b=aiernwCIMKRduwDPIzZVYrl9nnodvl0mnL5ibRHNeWEiBVZRn2+NqftDtDW+TYtg/4
         u2veDvcT3S8RloSY90AdWA4cz9tHX5xph03B8LQBhgAe0VRgCmu0j7MVRyXQM6cNwQ5w
         s6qiyXIbER6ZeBKKrjvFuS+pSUjsonNMpmQi/aHuItT3fwKnlVAsJLZSmEdIGqkCbgAO
         KbWy9TJjWpEU7LIlecFGyV4Ids4gJmBQt7xINygjGBZNZoP+bLDavOgMyeoDEjhny+HE
         zbf5UYY6vl/LfauGkoVjCx6WUSA1T0V6cDpMATdHhLT3hnR9mlY1ieUVWMDhF+mJjDhE
         eDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773416334; x=1774021134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6taFHZkgytK9Z293AzNZaJurmYT1xovlqM4MPRifUIw=;
        b=m3EdQPtKNM540FVKwk+1diMdjAM1Nw5jfW3uVTd5FBxFM6ICI3T6zsM+h3Pa37TsOh
         mTQ8ktRMaSYv/vNLq9gU5Ar1K4aR7AvRAo36SU2LxJwPeGF5dj6aP8ZJQlwuMNmsW8qu
         KdYT5KMt18Od85/x9l1vHkYsGtHVnoCyW2wxEZXKn09Xjn92FnuSprUBwhVwJg6hWSQO
         pg6bJwIsc8LzStpLa7rQe+XIQ881eXdS43U8t2XRLL7FqTeXWorhG6ra7sg0D5Vj3uuq
         rOv49FTU5s3fEJnOBmzctHndsdZOh0n6hnIaI10XyOssSuqzGSj1deaK4lrb5H4+i6r1
         gYKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9hHaHcPlB4VzL9grjGeOLE51215U+po/0IC7wRvVtEQzIsyTDefw/H18uygUBF7QJ1zv789s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHzzAoQFNo+GsLEnIC6jNEIC9gNpMn8Zz0ONF5xxWY0QNEVh0W
	AKTAbPz/eTy+V9uCIW52y/qWOUQG3V5M/8cWCtD17Wx8LyHs/CSgAhJv
X-Gm-Gg: ATEYQzxlc35Mw1aC1v4X4lAUEeVP8i+3l92xZBa4MxbVFowdbOf6bJunqS8Mpbu+bDu
	O+8VNEP/1BWQDB5ithuExtjXuxSoiQCG7lDcimW5DHP7KSHnzF0OjIMtADTcYDQTetaijC+U4dL
	XfDObE+ymfDV8NmzCMadAd+NVYzRtAo5QrKu+FwvC7/tPH0TtQwgYmPH00faqgscL/T784VV8eU
	hn+jjWupVJokBVMVhVzHN+Mp/b++IgHCd9R5Kk28gjmVYRM6oqvHzDwNlv+uFIm1IE75ThCRr8b
	EM0aBCEobfVpkcqa/3n0f/T9C8p0Nn5WQGzUInkV+RYuFB2oI0vcPL02yQJmJF4hSTDnHFgc5/Y
	C65mlhutCwv5CADJg7R/zPlqCt7JliyTR1SzwHIxkwXWu/qU5OKwh3SIHkRXb2q5HoogAJiGzdW
	WuGJ8rmVfWXc3GAOtXgL1jfjAl
X-Received: by 2002:a05:600c:c4a5:b0:47a:94fc:d063 with SMTP id 5b1f17b1804b1-485566e820dmr29502515e9.1.1773416333527;
        Fri, 13 Mar 2026 08:38:53 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d00a:e00:9fd6:8180:3fc5:2b85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557a738easm29417565e9.16.2026.03.13.08.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 08:38:52 -0700 (PDT)
Date: Fri, 13 Mar 2026 17:38:49 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: bastien.curutchet@bootlin.com, Tristram.Ha@microchip.com
Cc: Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, horms@kernel.org,
	pascal.eberhard@se.com, miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com
Subject: Re: [PATCH net-next v6 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
Message-ID: <20260313153849.qkfzv5c2u6fepjku@skbuf>
References: <DM3PR11MB87364DB5439A20F44AEB690DEC7AA@DM3PR11MB8736.namprd11.prod.outlook.com>
 <0658868d-671c-46a2-8daa-26420cdd2975@bootlin.com>
 <20260309205401.bk5fpw6kqnmlktbu@skbuf>
 <dde60639-af13-4653-9a34-38c4bd98b149@bootlin.com>
 <20260311115356.windefb3j4kkuslg@skbuf>
 <c3812b1f-50b7-4663-92f5-14c5c6b483a2@bootlin.com>
 <20260311135610.oox5ahxcyvxkuegw@skbuf>
 <c9c990b2-0fe3-4329-9a1a-e29aa0c9a6a6@bootlin.com>
 <DM3PR11MB87361761E911D6EAA0311DF2EC44A@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20260312134526.3lnifstvb5dpghrg@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312134526.3lnifstvb5dpghrg@skbuf>

On Thu, Mar 12, 2026 at 03:45:26PM +0200, Vladimir Oltean wrote:
> Thanks for the comment. I took a deeper look at the ksz_switch common
> driver and I've started working on some patches. I'll return when
> they're more or less ready.

So if the common ksz_switch were to remain preferable, we still have the
problem that it's very cluttered/abstract and impossible to follow and
ensure correctness/lack of regressions for other hardware.

Bastien, Tristram, I've tried to address that very particular issue by
giving KSZ8463 its very own dsa_switch_ops structure, which it doesn't
have to share with anyone else.

I have no hardware to test, but some patches are here:
https://github.com/vladimiroltean/linux/tree/ksz_separate_dsa_switch_ops

Do you think this would be useful? For now I've created a common ksz8_setup(),
but it can be further split into whatever granularity is required for
ksz8463 to have its own IRQ domain operations.

One could conceivable walk this alternative route of having independent
per-family dsa_switch_ops and only call ksz_common.c when something is
truly common ad infinitum. We could use it to get rid of dev->info->regs[],
dev->info->xmii_ctrl1, etc. We could further give ksz8463 a separate
ksz_ptp_clock_register() implementation with different PTP operations,
to address Bastien's concern. I stopped at only 19 patches though :-/

What do you think, is this direction something worth exploring? Does it
help with the PTP IRQ differences here?
