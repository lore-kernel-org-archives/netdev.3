Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890609;
	b=uc8tQTGuds4ah65Bu2irLe02xX1agvq6u/glv/BRiMFUanYmovk0Yg7eyKanzxPjKsg4
	 sW51pfRAgG3y8oybjqKXtK8iGufmrywhHCz6L6ryFlhVLB6siNksEw9QD1oeBt4VNyfnG
	 1pIWkdacCPNCZyb8DbP6f647jak2VeAWlPYgk91OxDxXfekPzTbHKIrO5OtISkJZe78Zx
	 6aGz41Iq9wXlG67D9thy8P7rWxukdIMc4Gxcw5NgyRGjb3rCp+4gTpb6OACHVy9bYEZo/
	 AmY1o5w3UxFzcKwKLAcdW1+uT8AD8qjsu/Ysuj8txQghaSWEw9aRrCocw/PllLGyr6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890609;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XdIGjSypKUaCNpXtgJvDoI2MzXbGDdXv7M653onSpWM=;
	b=3pwHTPJNgLbewhX3PDtBPrd/z3827cAPG/m79giadbW0R3h5sqds3dz7hnw3GHHtnatl
	 zqqIiRRlfyAknCSvLUUmXz1l5jt86Ia/mRlkBjL/JFBRO0AIzFF/xdp0v+nfLv5VUw4u+
	 lF88VjcB5QhNZwGzhgAXCWTN2SARr3hAXnH56CQ3ASfq1+yPMbXl/i99xXSHB4n3sYNbX
	 PqbrylauBH4X8H7cDA0+FV+2TlndgC63biJKDO2fLCHCy27s74NpDlNCsHc+ujsnBbRgb
	 uTWzvwHkNCx11kyu1bwyWypR1ykvzNswkPiEyXdgdIAI8+P4MYOrHGkcR2m4hO8OCiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Iw3o4sxl;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25C6606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 14:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C25C6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Iw3o4sxl
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5eac319a6c2so735177e0c.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 06:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793890608; x=1794495408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XdIGjSypKUaCNpXtgJvDoI2MzXbGDdXv7M653onSpWM=;
        b=Iw3o4sxlhm+moLG+aWbh3F5bLzfTYJo29Wwgj+PWL3gtGOa3bF9YHXs/ByMsrm5avV
         XQZRtXkikmf9IhrNGlqQOg2WM5LlJu8k2HeoEZsS+f/0oyebZKGE5Wqr9Vs4ct6XVLBf
         r27X+4Af0hvwxE+0RvtcJwtNXiB8LxOCS2r8ANhoDKqDCA3FIgfH1aEuLdp5apI6oHiY
         hgSWCqx8f2Al/GaaenmCGOTyFFL8Z7iPBt3g/NJEKoWGbaE0ooG/5TMDeiw1ZEZLkOTI
         FDjS5VAkQwDcZCxZ1QvEHEOPpB2asrwJnBz94ojPKmg5FxPar3LS2aOjQ0Dbq8mc0rRi
         km3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890608; x=1794495408;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XdIGjSypKUaCNpXtgJvDoI2MzXbGDdXv7M653onSpWM=;
        b=CSV78JKnbXXEJvDTFPruwfmr8XysNuC1crvWFr04RI8PIdfc8YlsKxUaLKk8vNkJzF
         3AXgD/F1KQinLDj/Ku/tHTT4NCDuDAvgSBcdmaIvi6stOOj/HrEBvGgO3ugNtemkcYXe
         5HS2gNOk273NZEAOAkL1w7QwspjoXfWcfXrd5a1qavD3VLGnhVAqECmQMb4o4rKgusV6
         aFT2KSFJ55tSztM/XUKkmsMX2EfBhAkdThgncUZbgNk3JSQgOz06dZo93IHRVMv96wik
         1MvgPEfPLoYoN/qqHfvnHxTud+3SzXNbLhThja0FPED9wpxhVJL6ohR+g7FJr5jdkIkA
         bQDA==
X-Gm-Message-State: APuU4Z/YTiPhjux7i51QZhgvIhRCs6+hakOUUoay3BCUU+jpM+Taivb3
	XoAi8K8cMnxIagVDqmqKVGh6NRtqbUeccyrMvBB7M/oc5yLCrC/YMQwg
X-Gm-Gg: AYBFou211NdUx/rJRCxO25oOd83dzblabHLhmecFDKP4y+aoTpMYNlMjJYUE0GWoaeo
	bLipVHHUdUMPdGrW8mhbOUYWxssqe+JgfUAWSVfeiJXlnZi18qjFrKIMGV+mFx0WoKII4z1hRoQ
	miBxjB6L5kxO950myiVYAYOrPaGlKKvWEuGtneufVCBfpT3jASJSHEts4ER5b/z/EapzC3jbkTy
	Fj5hqgAEWajpjoZKzqCDPzEvvoOJ7KxETyI12ftBr6E+bEOcUHPq5d277BUS+GHb8oEYSz0lsGD
	TDXqCLcbmzU27Rn0dzI5gpCtUjCeo/umNtgVgD26APy9XPbxNuLQiHCZwOItC8krzh96hc6Q6wT
	u0xLpzAgDk4vj2OPJn4Jd95hoj6FZKK0uC3jPkLWSn/w0co0rYF9qpYpSEiV1Dl1hsueGNEJ96b
	xWVjuoHUw65km/NpVrzqlG6td5/uRMr4ObLZVoms51zwQ0zqDcj0BipHaX4nbRyxi1o/NXmjKUZ
	1pPOjAtYqS+mOr8cN10o+rPsUuUTcOVeqixYSbzY9WmP/zTaxqfC8I0bCpFlkxK+LfqJd69sqX0
	k5iZwbBgYixk3shGnJl/Nz96J+Dm58Rzq8ygkPzkAbO8p9dtLum6ExUzNPeYz2JOXKGB93d/qOP
	UzwyZZu19PAbGek7JTBB2YYZuTj1wcuxZ4eVo/1qLNDk34wHKRjDzlF78o+MlQpBMt1b/D7A=
X-Received: by 2002:a05:6122:e248:b0:5ea:d2de:eff4 with SMTP id 71dfb90a1353d-5ec689edd4emr9688175e0c.22.1793890607584;
        Thu, 05 Nov 2026 06:56:47 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8d774dcsm4395072e0c.5.2026.11.05.06.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:56:45 -0800 (PST)
Date: Thu, 05 Nov 2026 09:56:45 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 bpf@vger.kernel.org, 
 dsahern@kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.192ba63c82bdd@gmail.com>
In-Reply-To: <20261105154509.1cedd84b@stephen-xps.local>
References: <20261103033611.949104-1-willemdebruijn.kernel@gmail.com>
 <20261103092226.2e8ab229@stephen-xps.local>
 <willemdebruijn.kernel.a20ae72714a7@gmail.com>
 <20261105143049.51af15a1@stephen-xps.local>
 <willemdebruijn.kernel.213e1d84478e4@gmail.com>
 <20261105154509.1cedd84b@stephen-xps.local>
Subject: Re: [PATCH net-next] docs: netdev: fix iproute2 process documentation
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Stephen Hemminger wrote:
> On Thu, 05 Nov 2026 08:46:22 -0500
> Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> 
> > Stephen Hemminger wrote:
> > > On Tue, 03 Nov 2026 09:44:53 -0500
> > > Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> > >   
> > > > Stephen Hemminger wrote:  
> > > > > On Mon,  2 Nov 2026 22:35:56 -0500
> > > > > Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> > > > >     
> > > > > > +
> > > > > > +Patches are tracked in patchwork under the netdevbpf project and delegated
> > > > > > +to 'shemminger' for further processing:
> > > > > > +    
> > > > > 
> > > > > Minor nit. David Ahern (dsa) handles the iproute-next patches.
> > > > > I stick to only iproute.     
> > > > 
> > > > I know, but there is no separate delegation in patchwork to David.
> > > > 
> > > > I assumed all iproute2 patches would get delegated to your patchwork
> > > > component. Is this not correct?  
> > > 
> > > Right now we correct it manually. Often patches target the wrong tree.  
> > 
> > This is not about the trees, but delegate on patchwork. There is no
> > delegate dsahern in the dropdown menu.
> 
> David is dsa in patchwork

Ah. I assumed that stood for Distributed Switch Architecture.

A convenient homonym perhaps? :)

Will send a v2 with that part revised. Thanks!
