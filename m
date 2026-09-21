Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2283AE718;
	Mon, 21 Sep 2026 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790024380; cv=none; b=VEXzgKf46KbPU/RPESMYelejF58MpMdi2xnh4lPG/6lgeDWRGh6fvVNL/OjnktC/yoGF1HyTK45ENj6D29wNAoTd2EGVSuehQe4zPUvSyliu1nWI5482+XPBJfU2boLNPiaSKtvpCfcimr2K++z3mmKoTbiiPsWcq4xXnB6vPIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790024380; c=relaxed/simple;
	bh=CT80C5+J03YyK7P0iVASb0EbEZ0qIExKnV6MVdreV74=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZkR+UrOO9jP6WoYZoQeOzvL2yIlFh10895Bagg2RG5BDs1LxtN2M2mKqNebC178FJgiiN9YYBqbVmBLVLj1xC+GkzcB2iPb3z78AtmkpOfiF0gNuPzZcBIgE8UPZMCFgkfrcQVRBpfv3XIZYjSTb+tYLsDtdZgDfKrpmMoHCew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oa8RQ9a7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oa8RQ9a7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5056D1F000FF;
	Mon, 21 Sep 2026 20:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790024375;
	bh=yPlV0TdnCTuH8vfvhnR/rAYRlqQVlX7OjVUEqZ0RXs4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Oa8RQ9a7JeDDYSLc9Gu6ElBfI55EIEWZCl0XXhIvLnkx/PsbHR8FUA7cbI4+JMOlo
	 BCXpIxl+mgv2W6OOw/MjR3dcAQkoEj5pHbX5ozf8bFB4ASlt9brFAfwrQ7HvCeJg1i
	 H6gU7R5+l9l8foq8FWwNQ+Fq7EOTq/9/KJbt2pPTz8yt+x7ekWsTpEtM3CGZSRmgtM
	 NR34unzMDglHo4oaSzutRTkCfekeJ4e8k8sQEKlOOcaFKNJlAynAgaKDayG7gBPqhN
	 ESVQ8NaZWqlqNNM7hfC1Zj/EYWSMrMI5UDxUyCXRuNzXr1dqDvt4tqPPEisVGLNF1P
	 /DrimOFamdqHw==
Date: Mon, 21 Sep 2026 13:59:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
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
Message-ID: <20260921135933.7e8857ba@kernel.org>
In-Reply-To: <20260916235200.20712-1-ansuelsmth@gmail.com>
References: <20260916235200.20712-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 01:51:26 +0200 Christian Marangi wrote:
> This series introduce a most awaited feature that is correctly
> provide PCS with fwnode without having to use specific export symbol
> and additional handling of PCS in phylink.
> 
> At times there were 2 different implementation (this and the one
> from Sean) but Sean agreed that this can be picked and used in favor
> of his implementation as long as his case with race condition is
> correctly handled.

Looks like the review for one of the patches failed so it won't be
emailed out:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916235200.20712-2-ansuelsmth@gmail.com

Are all of the issues invalid?

Once the AI review is cleared, some human will have to review this 
and vouch for you as a maintainer. Better still be your co-maintainer.
