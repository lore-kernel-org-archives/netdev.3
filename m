Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DE848096F;
	Fri, 25 Sep 2026 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342184; cv=none; b=Y0ZJIXgrjPuYLSF5KAS1VT0oPMepojQezneaPTGNuCSCoUUzKw6RSB8Rmr5nD7JNDKYf+6jxyzjwwF3I7v0oP2vVEOSOEHjJ2nqSsYs4SeWdW9QiJa7Js9zwO4vqOxw45NKOWD2kJmfoxsaN9Sm7ZaTU5KJonhO7BQx7laiQiUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342184; c=relaxed/simple;
	bh=/7HErsc+p5Hx2KfctwVWCcDlJ39ZJD0zhOpnR8SLbX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkQU4mWDnqvapgmmxQ+ZZb/4cRxdoFmTKwzj5aDS8EUtvN7zUP2qIhn2hfp6ZcTZKOwanuSzgxKc4Gmm15T2i8Nw5cNZjm+OXfN9OzHkpQHpyXzJL/f0oFQYgy1Xx2Obw2i5r+KwAoFm7ZIE10dIX1LMaCgyr/0C7m8dU8/3qfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzpaCj+K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzpaCj+K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18821F000FF;
	Fri, 25 Sep 2026 13:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790342173;
	bh=91CqShO9mYL5Pfu5igfKnWcKYdA44p1tpqlbwkqORlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gzpaCj+K8fxboHCZEfoCRA8aGkoPz4lwQhoim0weju2C4ArhbUl8ow3J0B623ewza
	 +k0hRzQ8yU20D8Ix72RJ04iHuP9B1u2lKoOXFmrKXY70dMmK/WzQZIo41aUVmZS5QB
	 GVSuywNg60vX1IpromAekQ3fn5mtr1IQB+Ff1pT+TXk8vN2gPVdyrz1IG7EJhJ7w1s
	 IdPEhcXv4HqA8+KeZFU+BYPcqiUZgerdUjOhKtvoqbK2a1T3cXZAd4rWRRuqmp/cDo
	 ahNFiNWTqoVD0A4NgJSIfBtWvQYlYxofbyM7njKoGQgWLINY8JgG5F0Dql4CWv0NPw
	 HTvCNFakrBTLQ==
Date: Fri, 25 Sep 2026 14:16:08 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: han.junyang@zte.com.cn, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	ran.ming@zte.com.cn, han.chengfei@zte.com.cn,
	zhang.yanze@zte.com.cn
Subject: Re: [PATCH net-next v3 2/3] dinghai: add MSI-X interrupt pools
Message-ID: <20260925131608.GL13925@horms.kernel.org>
References: <202609211451400236_aZ55Ox3y7NW8MQnYImM@zte.com.cn>
 <202609211459460680vBvKdpuZZ9yR4QVn3ONR@zte.com.cn>
 <20260922100913.GA13925@horms.kernel.org>
 <20260924090045.39200ced@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924090045.39200ced@kernel.org>

On Thu, Sep 24, 2026 at 09:00:45AM -0700, Jakub Kicinski wrote:
> On Tue, 22 Sep 2026 11:09:13 +0100 Simon Horman wrote:
> > W=1 builds complain about this. E.g. GCC 16.2.0 on x86_64 says:
> 
> Hi Simon!
> 
> Thanks for the work! Would you mind sprinkling pw-bot tags more
> liberally? Saves me a couple of clicks in (permanently slow)
> patchwork UI.

Sorry for not noticing this earlier.
Will do.
