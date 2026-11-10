Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352979;
	b=I58G50/6NFMJLSjL6E3AEGLO2cAFdZT0uf5sJL0FsomXfe1uwF7pKX78kUj/Lkj7uA+H
	 EGDTsu88HBTnkM0/R4h/DfvYUIwcEwtCO1gunU8VJy/hSDQSQ6R6clWGJNLCLPBv/Ez8Q
	 fFONmizmvMJSb61bUuuabosCwm62U+tyinwUIOllV3QymOH0xGZcbGlRvZga3ih6fkcGI
	 +jUPpvoyQnk5v8Cm44WKEdoukbycLpLKI+OSwk/glH9uX7MlNK20Pf9kX18F7/do9RQe2
	 MnHsG2j59xGYjnA9N6/xcZXHc8NMlCcUIYv9hfF5dlC0XLV+b33hP1LTg6dA50IZBWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352979;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=SjI7NsrJgkN2rWdlQmXCS56QG/w4TeeMxZflm3XpTQ0=;
	b=OA2fva/FEgeaP4R1nmAIygXoLkIQGhRINZOYXfN9Yx1Jw/IepftFMc2zlkrY1BV2/PnZ
	 25KWqjzVRqxycnHQIDeDgDog+0wmRRuCP0Zhpf+oYGeBd6LINyE+Tp6l8sdQNJ6mLK+7Y
	 DxuMPUyMgzClMAzA5OMQ4ZIJaad66OSkaHg9L0qAYV0Tq7ezrUNXIVS0gtBXf4Ckvq3pB
	 sXzfV7cjvvigHapIeDSaffx1aPps9SEbrmGJCjQfkCAwYCifdrJwj1Zx8kJPerLsInhjU
	 xipNa0XTO2sJ2hMUsyfxesV3gSkxqExT9d+1aBr8+4ichie2dTuf5JBsi2gg4WnnCag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f7qMNHo9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B2D606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 23:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f7qMNHo9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE111F0093C;
	Tue, 10 Nov 2026 23:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352978;
	bh=SjI7NsrJgkN2rWdlQmXCS56QG/w4TeeMxZflm3XpTQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f7qMNHo98NiYUvg6YGMxHPF2Y8fY6B3vDriaCwY7sgnGdYB8SExOg+n8q5LteoT62
	 apGH2/A+lziK9JfcQM8aaWvdt0abPrQWHjxBSPDcYGk1G0xyWyTdlgB8AvuTE8vryQ
	 nbqlLegqMD6hXn5cQ7onG45lcjmW9eIHBbuL6/1b2tQtgAk6n2XarBzlIl0dT/WGiW
	 jZnMyHtK416lYCG1ANItbrvzrWGz9BdcOIQ/ktdGC6LF9v6utieRbJ2RWQdLvR5QPH
	 EfJn3bQPi8Apw9llGPMo4JIJ3Nb/mK8KrPHcTCu0s2xKLUHsbWFhV7vF+Rh6nH9PuG
	 ti6o5UAHcAixg==
Date: Tue, 10 Nov 2026 15:22:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, Chris Mason <mason@kernel.org>, Kyle Zeng
 <kylebot@openai.com>, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net] net: skbuff: uncharge trimmed zerocopy frags on
 error
Message-ID: <20261110152257.0e4d51cd@kernel.org>
In-Reply-To: <willemdebruijn.kernel.1d573ca061134@gmail.com>
References: <20261105223512.3647504-1-willemdebruijn.kernel@gmail.com>
	<179391822817.488859.907054151678387708@kernel.org>
	<willemdebruijn.kernel.1d573ca061134@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 05 Nov 2026 17:39:14 -0500 Willem de Bruijn wrote:
> > This is an automated message. This series looks like a fix, but its
> > commit messages seem to be missing some information:
> > 
> >  - Whether the issue was actually triggered, or is only theoretical
> >    (e.g. found by code inspection). If it was triggered please include
> >    the symptoms, like the stack trace or error messages.  
> 
> I thought "The issue was found by an LLM." in the commit message would be
> sufficient.
> 
> This was found through analysis. A repro can be built, but its output
> only pollutes the commit message imho.

The question is whether the repro / proof was built.
Please read it again, and LMK if I should adjust the message.
