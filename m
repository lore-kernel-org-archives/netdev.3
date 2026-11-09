Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.59.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794245563;
	b=luwf36s5hHffBrP26kh7uY3soikqejDUsuvtb7Yoaaxo5Or+0sYshc9zxlXmFfRS7yao
	 WDbnZVMH1dcPCIDAaqs7xTA4MfmvS35d42XIigGRafXjIGhR9HlEMkuC1oBgymmUf9KlZ
	 PX5gM+LoqSQqMGYCftqAi3LOqfHaE1miwcG3vpMarY6v018a3b8GiqjUKO3EDK9Qmprt7
	 8nUoOtpFVp911B49a+jXcR3mkGNoYKV3dWP2LhftVERY3fG68Fb7geNSzTntETQ7d2OTp
	 jwWzeqc9OfsQ9WypMbWmeknVcXkSKGF1L2nJq8yxdlrPhz3+Vx4y35Xp2gVxM6qNbDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794245563;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=mKe7ARg30ugtmOMY2pGpxnyKNaS+xGD77ucYorxS5c8=;
	b=XvmRW8JuxuMEc1wZo3nNJkJFjdnaAhkjotVRTz+toJ4WDmAARN9a2aGo72blVzGdA2UK
	 8XFoesQwPahQTwa4wmutuvxKfwL7VXBKDljz4vjL+Ku29R81CaLwD5Us5l6DhkIDEvWhs
	 SqznUV28TX51A/Tw4ux8i9gcY0wUkaFbg8PP6JnibMv1VkSc5cBvsCxlKdhjnRwgp4JlY
	 7ZJ7x1j1ApiyKW/eR+u3iT48u1xHOkXZDeuOiJvkxAYKJbQ+bZ9aRr9SJZDVJQFgXB3Sa
	 686Wvaoym/A4QCAJvW3GfVz+DAHkS92gJ4WTc8GqjCH3ZH27/SbGUUnpRgp/wucBKsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1wt.eu;
	spf=pass smtp.mailfrom=1wt.eu;
	dkim=pass header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=OL9R1eTt;
	arc=none smtp.remote-ip=51.159.59.229
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CF4606EE94;
	Mon,  9 Nov 2026 17:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70CF4606EE94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=OL9R1eTt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1794245558; bh=mKe7ARg30ugtmOMY2pGpxnyKNaS+xGD77ucYorxS5c8=;
	h=From:Message-ID:From;
	b=OL9R1eTt34vZnwyH1a3m7c4+5h2Q8RhaLoe2FXPFjZ3eCFZ/XqunBISKpqbDu9Vax
	 lbPzt/XF/ybGYLwSNVyhn86lcUTScZts1fFdBWHoYGw/dQBwTcN4m7IAnv8Es3cBiQ
	 BfxNFAnPyYY217jCsNg/5fAWuZ0sr7bSWgxcdLFA=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 8D94BC0954;
	Mon, 09 Nov 2026 18:32:38 +0100 (CET)
Date: Mon, 9 Nov 2026 18:32:38 +0100
From: Willy Tarreau <w@1wt.eu>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org,
        Randy Dunlap <rdunlap@infradead.org>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, gregkh@linuxfoundation.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>
Subject: Re: [PATCH 14/14] docs: netdev: align the security fixes section
 with security-bugs.rst
Message-ID: <avIDtoA-w1UQEatq@1wt.eu>
References: <20261109080240.29444-1-w@1wt.eu>
 <20261109080240.29444-15-w@1wt.eu>
 <20261109080036.11bf06c6@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109080036.11bf06c6@kernel.org>

Hi Jakub,

On Mon, Nov 09, 2026 at 08:00:36AM -0800, Jakub Kicinski wrote:
> On Mon,  9 Nov 2026 09:02:40 +0100 Willy Tarreau wrote:
> > -people use the mailing lists and not reach out directly.  If you aren't
> > -OK with that, then perhaps consider mailing security@kernel.org or
> > -reading about http://oss-security.openwall.org/wiki/mailing-lists/distros
> > -as possible alternative mechanisms.
> > +people use the mailing lists and not reach out directly. Fixes for such
> > +bugs are posted to the lists like any other fix, with a commit message
> > +that does not detail how to exploit the bug. Never post reproducers or
> > +exploits publicly: maintainers will ask for them privately if needed.
> 
> Please don't insert the wording about not sharing details.
> Vast majority of the bugs have no real life security impact
> and we have to keep asking people to share the repro.

OK.

> Can we instead add a brief "please follow the standard process
> described in the $security doc" ? Or, maybe even better, can we
> delete the "security fixes" section completely? it is very old.

Oh yes that would be even better indeed! I'll send a v2 of this one
ASAP.

thanks!
Willy
