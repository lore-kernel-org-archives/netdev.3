Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE093812F2
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255911; cv=none; b=VSQ5y7SyHlcK1nONLceOIUoBfgCl7ifj5yZez4omXC92vRJiDaU6hou/cG3Vgs9qMXf2azHA+/FhgkS1yys1QTwc1VvU10dtaA+DCcjqMRtTzpkW/mbZTDPIO3sVlzyFD+qDQFzEjpOJ66pRjWpleZtVm+s2InpsJrsXp603oug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255911; c=relaxed/simple;
	bh=Zd3AZIDL7if/qF12oMBTJz11JgR87TNdx4PQbs5fhlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U15geTcfmzpLzkMvCnpJFO8YY8o5L6hAoh47HCM9EECUUGpkq1y1nFR2IdTtbvKcZsw5/IJ730sEkaS6AK4ZdPTQ8fetPyNnVZq8ISDNyRTqq4JWHxe3IaqBEFaL/YL7e/u+JQmwiVbq97JcmN9UQfE4j3+RBkwvWOdcczT67aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClOk1Op3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClOk1Op3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A1D1F000E9;
	Fri, 12 Jun 2026 09:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781255910;
	bh=Zd3AZIDL7if/qF12oMBTJz11JgR87TNdx4PQbs5fhlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ClOk1Op3tv4OcRm3eXszKt+gFZaQzBqvwgYQwdBcNuIcOBalZfMIunVSQ7zyjOIDz
	 r5dLNZN7A9ccOgufmZokd5rI6mHGLaoPVrg4RtM4aZebMdlaAHIQ1xOme8bZi4FIaw
	 9CgvZJNlxI9uduieRVyFyXZVgK58bY3MLK5mHweXB1tYAtWzCH+c9zoE8+0Ls7Vw28
	 S4a1Kt5dBRZpfXmLr5MFnmB4fDUs33bF1N27OKFTvIFs1OL6xJwcexeHs776lc7/+L
	 gCO6cVsnMWAwex6qquOh6HPfhO3fugU//ld+wweCW4BVZF4w7K+FmMB4GGlSuOhP3p
	 kMfCaXI7EbDjA==
Date: Fri, 12 Jun 2026 10:18:25 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Joyner <eric.joyner@amd.com>
Cc: netdev@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v4 0/5] ionic: Expose more port stats to ethtool
Message-ID: <20260612091825.GB625020@horms.kernel.org>
References: <20260610061830.51037-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610061830.51037-1-eric.joyner@amd.com>

On Tue, Jun 09, 2026 at 11:18:25PM -0700, Eric Joyner wrote:
> The primary aim of this patchset is to support the reporting of new port
> statistics (and one old one) that firmware sends to the driver; these
> include general FEC codeword stats and the FEC histogram. A scheme for
> these extra stats is introduced in order to prevent devices that don't
> support these new statistics from unconditionally setting them or
> reporting them in ethtool.

...

Hi Eric,

There is AI-generated review of this patch-set available on both
https://sashiko.dev and https://netdev-ai.bots.linux.dev/sashiko/
I would appreciate it if you could look over that with a view
to addressing any issues that directly affect this patch.
