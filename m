Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFAA2D8DC4;
	Wed, 23 Sep 2026 00:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790123117; cv=none; b=phx0NtlhbQHGqbf3c/lVNbfgyPfezGB+leZVu83WphO86dUuExGuZ9guRUOlSuQmI8hdX0ttZS7WT1ZfYyBLZT3gs9T0jm2qjvM7e6grwX+tYr1bt4DgBfGkozJN1KNITVza0Q6GS/u1Sko+6m3nr23CR6xEY0V3vAP4/xhacXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790123117; c=relaxed/simple;
	bh=w+wcaL2rj5rxXOeqjbcQCWqRRGoQ/JW0lLsdYrO2WPs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B22uUExjP/EiJgsFqpGkJHRItnGLc5iMOL2pKkbmY4EMSjtIgZ+aIh09T9eZUe53j0RrMVwlX/nhAHlw1PzGVON2uTQYF2ThEMiYR125wpsAB7wlZqjLPezEYKYwrXoa/PK8jCUr34YseKjaeLDydzh/fHDBsvKLaPFTnOPYTew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xd28X2Xe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xd28X2Xe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A091F000FF;
	Wed, 23 Sep 2026 00:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790123115;
	bh=7KbqWqmQzqJ0KcYvjL3DybqekU4MQKHRA2UF8b+yGbE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Xd28X2XeSPP+Rn/cZCMrm77oAKf+Sdr+oWN4XQjNJetJjdSXcrVLA2EMQNHNzF/vC
	 YEN1rZ4QkAWRRFVbUzxSj5mES14BeichIdqMAIHeASVf12HVOf+ImWO7/+n9Q13T2c
	 lGZyHUI7DH4L2oQVKcKIifsSxcFYnDa6a2dvGpfCQLIjX9neqF1bI12IZ9vWCbBVKQ
	 T9/Mqb2aXlIvFIAh+I7SjIzEkc/gSU6Tz1LoXi7NqiwdleXHtEJxToHizU/keS1g7M
	 t43TDDSymi6bkLvRmnJnZNc1WZPix156+fOJQ5r/8i0Er6RQyUvrrJRjlXpqHT4cOP
	 nVy46neei02PQ==
Date: Tue, 22 Sep 2026 17:25:14 -0700
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
Message-ID: <20260922172514.7feb6e7c@kernel.org>
In-Reply-To: <CA+_ehUwy9RUKCCHDnqoED3AMVnErgGr9RCrCR4ceg5QONq1wOQ@mail.gmail.com>
References: <20260916235200.20712-1-ansuelsmth@gmail.com>
	<20260921135933.7e8857ba@kernel.org>
	<CA+_ehUwy9RUKCCHDnqoED3AMVnErgGr9RCrCR4ceg5QONq1wOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 12:12:56 +0200 Christian Marangi (Ansuel) wrote:
> The remark on the fwnode patch are invalid. The driver is expected
> to return those error as probe defer is not supported.
> (a notifier and late attach/detach is used to align to phylink logic)
> 
> For the specific Airoha PCS driver it's really speculation from the AI
> but HW doesn't work as described by AI.
> 
> The only real comment that is valid is about the alternative way
> to give supported interface with the .get_capabilites OP.
> 
> This is currently not supported as there isn't any user and it will
> be implemented as soon as there will be one. It's really to limit
> the patch delta of this change and to progress further.
> 
> Maybe FIXME might be suitable?

FWIW no preference here, I defer to the human reviewer.
We can treat the AI review as a hint if human reviewer thinks the code
is fine as is.
