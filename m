Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886385;
	b=RvD8t4vwbAeIBK1TjgGjtTHcfOpEvEEseQ+9O0w0mv/oWFA2D+IUv4tgWKZqI9vp8Q2O
	 oo6KRbWNFD8uLEAXMq3G29Garvf6ZJUH63lWkCfEppN/hhHWMv68YJrjVCkAuDznuaSu4
	 hF1LUwugKe6CkjfQxObl79Jx7E4dFY8J4Ez9eVXPIGeteUzCHztndGLoHCwXj8+zubzp+
	 DSnoCL4PAsArqs1H2EWKgDop48g3W+DZR4CRujtYByC/OaCJuLtqGFsBR9i97ypsbgH+K
	 wsNMOKzdQkPlJFLtjyLCkwkzN8zR3mBEkUz2WqUJg/ol1CDqu3Rd6WSqYRwIhr1a5tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=sBDq4TRDnfrVVYE/ceW1Z7RewHfol2+wgxiHxq3XLsE=;
	b=EN+apYTfl5RXXWPSTBYT4FtAm7SkdGzjWGbsVmhwX7XTbeaQXcBFJEG0pqaujmOsyDal
	 ZBsdjYRSql80s1LYg9FrXMdF54jSM+/8IUbK7+o4ZNe6INm8WJaplamvLGZ2pIbU7467D
	 yrri1vfpdTCoryMmiTRiAnikc5xke9i+M66KLoJIc+hkuYW5q8QsUWQ6cTddCGQs+CUyz
	 bJd70lHiFIGp0WN8n8pmrGzQUQj1o+sOUUhSYztBrfDAN5m0k8RY2JipdPrGdgOFzr9GB
	 5gsTYEiipdKik1ZOMrp8hLJtgcmQ13XSb8Lu4E32DEQ7Tt1KGrkxZYmN49cBPPtsN4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lflW0hba;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5A1606A329
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 13:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B5A1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lflW0hba
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-999b2b06bd7so674410241.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 05:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793886384; x=1794491184; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sBDq4TRDnfrVVYE/ceW1Z7RewHfol2+wgxiHxq3XLsE=;
        b=lflW0hbaoLI7rDVMCFMrBILrzso6kQHXL7fzsEp89MQdXWgOJXskAVAP4Y2NY2uZFR
         TJytWakEPHg+zTLapuQPh6CxZMeUYx77pQLj6ERCkO2WrPpMLrTNA+G2JIojjWgaYnBd
         bj/1BTi/sJzwmJp9jr8i2tN2Uos2Jz9Q3pOyocQbKXfRRZo4ZdCv5yJfp3DPcSHUpJB0
         abXiqtuothrBd5HydbCdQ3vudqkjFvhlAOpkkgEk8eGr5kQHOLC1H60ptD1DbbCyEHgE
         E9UfiK0ow0IBLAaavpf9zcFgrjx/P2/nplaWZiOoXU781jXzEGYiaI5UunS70wYdf+WU
         mX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793886384; x=1794491184;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sBDq4TRDnfrVVYE/ceW1Z7RewHfol2+wgxiHxq3XLsE=;
        b=UODGgHWXHhfuVIZwRDk4VZXcRTdzbjv7hA2aBEipUfs+s2WF7bKsA6in3g81xuQcmj
         yZb6K9ChRD2syLC20oUhHKuKs2YtO2P20wpk0vavQsneaVlEIyQG2oYOiEamP164N4x1
         7vuU/93TnXf7MrUO6CAKzJ4NwXRYl6P+x/akD0LPv9HEnFOk6lJ241R0/oQNLn/ViOe8
         U81fhZ3F7aprtywXk2ha0FJS+EfbXYJvk6Q25kiQJEU3peVOfoj2NGaVBpOMZQKWnOPw
         bVnIHSTndrP5E1ZUauvrZxGvuvKX+2FfGkR/4jv3/kFVfL1fRHOr7NVmj8/b9XWERicT
         qJCQ==
X-Gm-Message-State: APuU4Z9SEk5fJDEQVrhOe4/V0cv+VHmTLCro28yVkubmw1pqghZQ1goa
	V/aMqQ0krFYyu7etLiTfinlBHPvX9bfR4b/+LZQERUaJ5x1v/oGvSijC
X-Gm-Gg: AYBFou27o4+IcmnrrLbvlubd6YX64TnqiyQzeH8juXDSqsVvlMdF9c5Rjpt49i3dztc
	j2UYL7MnGNPVi3Ds7LsTmUv6Yf2BEPOiI5IjIMG/ogVX/EgjzrdA7qOyMESeP04XE7il/xDVJsZ
	KQQs38JlbIGf5bQjP9yCYy3DMpe4Osgpy7YOzPBN3Klh8T23EXtkavfmSEbip4Lg1zVraEZRn32
	16elmsyW2i4Ws7/U2i6IxLokxLY4opqBQnGpETlIF3Aj1pxQK2Rczk3cb8RFt3w7zqp7hFhLaNB
	iSafH0td/0gEA2FAgu7ev+yRHYL4YpYtqTASCFCLBsJcjB9/RwuoY3BQRVqz29PRr9P75n1zV0D
	5wqxE1AOF6xdQeZdIe5xOIu9plsimAXMotgozmFlMLh6xuvrTCDmxk1ugi9Et2hlnpvFnQJCsYI
	jEZKvm3HYuFp0C5vW1p/pnyY6LuLQJDtIeOtesQgn2PCUTGsPQNZXwDthiQPpZaxbveDKFQ6/DT
	U5/YtAvDuR8WnMPXJzAnLydqhiJIM8F1t+oMr2UB0bDB3RCj0jnHsBwsGB7f32SwxNQnLJnOjNI
	yejl2SUCGBoign0jm8wENcV7RtsSjzA0/W0jLCt4BPd7spJBmohNecOMDDAyyHGYGo9Py+MJcqe
	Q6WrxEglEBIg9tjoF2Qkyba6zzR+xUw7oAMqHEOQObXJkgo0LW2HodN602asMyICegeH6vRs=
X-Received: by 2002:a05:6102:8092:b0:7cc:56a:58d3 with SMTP id ada2fe7eead31-7d07279cd1amr9349602137.31.1793886383896;
        Thu, 05 Nov 2026 05:46:23 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8da73e8sm4230200e0c.10.2026.11.05.05.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 05:46:23 -0800 (PST)
Date: Thu, 05 Nov 2026 08:46:22 -0500
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
Message-ID: <willemdebruijn.kernel.213e1d84478e4@gmail.com>
In-Reply-To: <20261105143049.51af15a1@stephen-xps.local>
References: <20261103033611.949104-1-willemdebruijn.kernel@gmail.com>
 <20261103092226.2e8ab229@stephen-xps.local>
 <willemdebruijn.kernel.a20ae72714a7@gmail.com>
 <20261105143049.51af15a1@stephen-xps.local>
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
> On Tue, 03 Nov 2026 09:44:53 -0500
> Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> 
> > Stephen Hemminger wrote:
> > > On Mon,  2 Nov 2026 22:35:56 -0500
> > > Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> > >   
> > > > +
> > > > +Patches are tracked in patchwork under the netdevbpf project and delegated
> > > > +to 'shemminger' for further processing:
> > > > +  
> > > 
> > > Minor nit. David Ahern (dsa) handles the iproute-next patches.
> > > I stick to only iproute.   
> > 
> > I know, but there is no separate delegation in patchwork to David.
> > 
> > I assumed all iproute2 patches would get delegated to your patchwork
> > component. Is this not correct?
> 
> Right now we correct it manually. Often patches target the wrong tree.

This is not about the trees, but delegate on patchwork. There is no
delegate dsahern in the dropdown menu.



