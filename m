Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628A24A07;
	Thu, 19 Mar 2026 07:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773906851; cv=none; b=SnJ8aVbcSEsx+IK7bMUYPlAElpzTrabCzKfUC6rTKlMaRbKR8OixD5L5CETL/j0tLj3GlgjlV7BRI+wnMtQYGehT1TZXUDyCAkQ8fZdcm/YdAD+Ss/KOOnouVyVGauInJTPhikYHOh6uUr4l4q279zPNrAeE7I2vFiMCKB7ETmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773906851; c=relaxed/simple;
	bh=JnJaR+kU1qMIsy8dsktGiTGdaiRK0LGYjzXixrgPAl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/FvmKP3BcL4/XUgkT8fzezqTyfZhWXlG1T8MbPn2nspY5Q732GX/D0aOF3orSkzE5bQG/iDKqPXWkpqh3rbN0tdz/ae2d2VJoX7nLcX+JiDoS2Zgj7ZW9W82WJUKn8gh0CI6LKkFE2zcFkG0tijFvT0bSfnKSfLZvAzBn0UdS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id C7424606E1; Thu, 19 Mar 2026 08:54:06 +0100 (CET)
Date: Thu, 19 Mar 2026 08:54:06 +0100
From: Florian Westphal <fw@strlen.de>
To: bestswngs@gmail.com
Cc: security@kernel.org, edumazet@google.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xmei5@asu.edu
Subject: Re: [PATCH net] nfnetlink_osf: validate individual option lengths in
 fingerprints
Message-ID: <aburnrvtwMsRVQp5@strlen.de>
References: <20260319073243.1176330-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319073243.1176330-2-bestswngs@gmail.com>

bestswngs@gmail.com <bestswngs@gmail.com> wrote:
> From: Weiming Shi <bestswngs@gmail.com>
> 
> nfnl_osf_add_callback() validates opt_num bounds and string
> NUL-termination but does not check individual option length fields.
> A zero-length option causes nf_osf_match_one() to enter the option
> matching loop even when foptsize sums to zero, which matches packets
> with no TCP options where ctx->optp is NULL:

Applied, thanks.

How many people still use this feature?
Does this even work reliably in 2026?

I'm considering deprecation notice + eventual removal of this feature.
