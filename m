Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FEF25F99F;
	Fri, 11 Sep 2026 01:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789088855; cv=none; b=HjiN10lFXsQqBqLAGmVBYCHJeGc2M+2tkKizKL479I7aeh5n0dq5nIEOqvZaD3K2jlvDOnsqhdkQ9NAlgOX4G+K+9nQwKs2Ew/sKctAoYM7kEO0y8sXX0zPiLMihmQX5D9hS0RotDDOi8M8KS/Kr9Vtr3dGgQx9Wvp2b3P7ByF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789088855; c=relaxed/simple;
	bh=17PGq8eT/NgvGQvctNMEQ3b7gUavlH2nrvUmvaXojTI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=it6O+eLUa2xAVOYGwxeKaQ57gmlnKNxpIk3PLvry/6av4NC0Hdin7/Q0Yvja/LmlmWVIP2h+IueR/JNlfuCz1wBKBMZuXn61mD4ITeHU08cWE1vanlISv8hpelAfOeby3y+6wIpeszj3I5UdD1+KxIuvN4LsmmXapIRFGVIg3LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+zn93mz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+zn93mz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A1E1F000FF;
	Fri, 11 Sep 2026 01:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789088854;
	bh=kFUGxS6sw9dU5MHuKgkXOn3J123RGldZfofUywGCtdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=I+zn93mzWM6YlfDxtIx/gsd1pHDPhQ1yzr4U+5JjxynbIRzjqbQLpUG+koey74Bil
	 Szwm3jQviYXA9w81B3gLLLYc/mOF2ER/WSdbxT7hD1jBy9nHtFNwf2Q0uPV1P0Y4/i
	 SXD8YIguSMIjMK+MHM8zQtAQcYZmKgeA++qgrRPlWCC29sFOGR27pr2jTlkvxCobSA
	 jcEEFhoeCaJRZCKuiVxXNyqbsBCM+Tr+QmFKi9JaHf7BOmwJPI1PebRqNb4Ao6KIVi
	 WEsngcGbkK9RH2RxH3Mqk+ThRAzrpSU1YxsNltexJ1HnA1lLsEqLqRE4kXnaBDSORo
	 w26j7ePzgkZDg==
Date: Thu, 10 Sep 2026 18:07:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: phucduc.bui@gmail.com
Cc: Wei Fang <wei.fang@nxp.com>, Frank Li <frank.li@nxp.com>, Shenwei Wang
 <shenwei.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Stephen Boyd <swboyd@chromium.org>,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v5 1/2] net: fec: Propagate PTP initialization
 errors
Message-ID: <20260910180733.2d4d48e9@kernel.org>
In-Reply-To: <20260909064712.22539-1-phucduc.bui@gmail.com>
References: <20260909064712.22539-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Sep 2026 13:47:11 +0700 phucduc.bui@gmail.com wrote:
>   * cyclecounter init routine and exits.
>   */
>  
> -void fec_ptp_init(struct platform_device *pdev, int irq_idx)
> +int fec_ptp_init(struct platform_device *pdev, int irq_idx)

This function has a kdoc, you need to document the return value now.

Please repost this for net-next without the Fixes tags.
