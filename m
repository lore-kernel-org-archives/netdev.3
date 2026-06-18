Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF5F330B22
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781787976; cv=none; b=G1ssu6IBGOc18XgC9REo9MB2jcDgjKoOKP9ZgGH/dhXLPU3dqN6t3zlXlAf4IRUBrfCEGlk7dtmINSWzPHxekBlWq/oOiO2yG1ZxIbLM8LhpYUwMgIlzhnPXMUU9OwzCuOcAm75xTMrknPHWHNNH/mVkqSNY+RgEmyke9bP0wdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781787976; c=relaxed/simple;
	bh=ygolAHvHI9p2Kj8CdrmmlSyV3xyLJh+dhIAOur9nf3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiFBCkQWAm93XuTWmFGxNEQ9XlwHRp0TTE3GVzgNsSfVOJSUvdeHb92BoD66ABiN4QDH59moo0oOycyGJ9Y3Np5GVOP5YERKY5pxULK+9/kfc2U+qsci7A6Q9L96DtdsFNbmHLzDdSXVp6FR0YLKVZuZiSf4m1IdqYdmI179FDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApQTtDdw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApQTtDdw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907F11F000E9;
	Thu, 18 Jun 2026 13:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781787975;
	bh=c+vw9YXAjFY8oEuSN57xGaYVivP6uo3obWvJQiSVeN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ApQTtDdw6b7ooXJ9ULHMBtwRv/leJthCUe7+z4/ochMLYVrwrdyx71RNQndPneHSZ
	 snmRv8433OIFxokGoHkxVfvtzO8JYF3oByTaoecXN844SYeMxvYKxSJWYEgxRXgw9u
	 Q5hcmQBFslXLpaJ9xj9ZwS00aApIcEo3EcFC79UZ2oC3J1HZng0u8QWDvDIJfG+P+E
	 uTS057oXhjHtAYk3/TvZnzX1Ru03pZzA4ZxZR16dfoiSGDf73STo4RpLjWjtv8hrkK
	 F8mmYQaw1WOB0siN4E/B69hce/baCkTunP1B80bnbAhteTRgk4IWXT7zLFS6N6ty0X
	 yqwP/sznQntXg==
Date: Thu, 18 Jun 2026 14:06:11 +0100
From: Simon Horman <horms@kernel.org>
To: Lei Zhu <zhulei_szu@163.com>
Cc: lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Make use of the helper function
 dev_err_probe()
Message-ID: <20260618130611.GO827683@horms.kernel.org>
References: <20260617090302.210933-1-zhulei_szu@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617090302.210933-1-zhulei_szu@163.com>

On Wed, Jun 17, 2026 at 05:03:02PM +0800, Lei Zhu wrote:
> From: Lei Zhu <zhulei@kylinos.cn>
> 
> Use dev_err_probe() to reduce code size and simplify the code.
> 
> Signed-off-by: Lei Zhu <zhulei@kylinos.cn>

## Form letter - net-next-closed

[adapted from text by Jakub]

A pull request for with net-next material for v7.2 has already been submitted,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after June 29th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
