Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437223D9DD8;
	Thu, 24 Sep 2026 03:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219521; cv=none; b=M7cxwUF1xRzEaFa/iWqakvcH8gmmXCXgtd1aC5EbY0NMznwfPlhPbIgs8nfKaz8dq48ea79jEm1xVWXXhRDw8yPrgvNGUFUV+JFuCQGf+PlyNNmpE2ms5fAlZTFVRhqZErWrcKMMf0t/olBObCThJxeabBxh1HsGyrCsLzb4KII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219521; c=relaxed/simple;
	bh=2Oq7zrW7DKNUfdqunlizCj7iTvZv+XeRI0aXa4sS5g0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ck6EvlkcwgCAss13mfLqSFVC08P8yg/+AXJ1XlJht1v8yC/crJjP+zzTfyrbdnFo6rXH3qvvw43+dbjTf8KYbpcoiHEzr4Wd4mbwn+c1UjzwJmP7gDofJuh7z5PtdxvkG7a3lv0F2YG6iDDbpzRA+4gP+UxuQJRTrytHqfEystc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Us9LZqfC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Us9LZqfC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64EC1F000FF;
	Thu, 24 Sep 2026 03:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790219519;
	bh=yOJh0eCTzfxNXI+TRaeMXyYRrETomL0HV5x6uXBq+2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Us9LZqfCtcMwM9yQLKsLJCqfOiy1JcstDdI6c8Hw3ut6FEMnOgUfYWARod9EI0fIS
	 JI7x62ld/o20JdRnWb22g644RThdwsuqVYbcIlQxxRzFst6qTtJFi8j4h9LPIh09dO
	 ixHBrbNRHjn7cr1XAoinktF0r0IC53cleUDkpNp5OnuR1UmPUb35z6ep9OsfTQaOLK
	 KPZa9EYl/7gdmrO7vICqjG+aFx/+48JV2cMcjuBGtdSr9aWpRA2uhIMjHzOJNCT6wo
	 1Ce3MqhA/qjE+e0QAFLn1zWIUjmK/SF2Me7LX/iyDYJuYj/fpUtSj+R4jrsIZTrN2G
	 Hnu5cSx5dfqHw==
Date: Wed, 23 Sep 2026 20:11:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Lorenzo Bianconi <lorenzo@kernel.org>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Philipp Zabel <p.zabel@pengutronix.de>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH net-next v16 00/12] net: pcs: Introduce support for
 fwnode PCS
Message-ID: <20260923201158.3552915a@kernel.org>
In-Reply-To: <CA+_ehUyFKZzd0uP4akgZxaLLJTwcvGGKz5ppCYsB++fn92Dn9w@mail.gmail.com>
References: <20260916235200.20712-1-ansuelsmth@gmail.com>
	<20260921135933.7e8857ba@kernel.org>
	<CA+_ehUwy9RUKCCHDnqoED3AMVnErgGr9RCrCR4ceg5QONq1wOQ@mail.gmail.com>
	<20260922172514.7feb6e7c@kernel.org>
	<CA+_ehUyFKZzd0uP4akgZxaLLJTwcvGGKz5ppCYsB++fn92Dn9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 10:31:49 +0200 Christian Marangi (Ansuel) wrote:
> Il giorno mer 23 set 2026 alle ore 02:25 Jakub Kicinski
> > On Tue, 22 Sep 2026 12:12:56 +0200 Christian Marangi (Ansuel) wrote:  
> > > The remark on the fwnode patch are invalid. The driver is expected
> > > to return those error as probe defer is not supported.
> > > (a notifier and late attach/detach is used to align to phylink logic)
> > >
> > > For the specific Airoha PCS driver it's really speculation from the AI
> > > but HW doesn't work as described by AI.
> > >
> > > The only real comment that is valid is about the alternative way
> > > to give supported interface with the .get_capabilites OP.
> > >
> > > This is currently not supported as there isn't any user and it will
> > > be implemented as soon as there will be one. It's really to limit
> > > the patch delta of this change and to progress further.
> > >
> > > Maybe FIXME might be suitable?  
> >
> > FWIW no preference here, I defer to the human reviewer.
> > We can treat the AI review as a hint if human reviewer thinks the code
> > is fine as is.  
> 
> Soo should I send v17 to fix AI that failed review?
> I think I didn't got this detail.

Sounded like Maxime was planning to take v16 for a spin.
