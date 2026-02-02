Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0A0AD2C
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 12:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770035822; cv=none; b=nvGqXWzt8byw7HjrvgzWWyixZq9fuHm/Tuvop54RBqHsCbPnow0Yin+d2A88DOnZu03SFsARgW56JvH2tajOXo/8XDZj8/yiwrg5qE7cWIykL2dwI7jnMJyrRC4vBRn31ALldSuItTJo8t8ULFO1X8e/xKpD16Ev78AKuTf0fE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770035822; c=relaxed/simple;
	bh=oZM3IUrXABHK6B393fnQrD2/r7SS5uZL0vfWqa+Ebao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4nCce8/WVvoycLMQeWm1lr4yL3XujFkOQkmHhwnAL/P5muS8C/9Rb/dFl1ouijBcbzCJKBA3zqjokeRJA84ZgXtPRjMGw7PPmsOQme0iWYzbj76duVf38gUvjHtyHXG0BdcfKW6iVfwPmQ1NKK0XTEy76FlDaL2rnWzN0PY/hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DL7VxExb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DL7VxExb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B447C116C6;
	Mon,  2 Feb 2026 12:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770035821;
	bh=oZM3IUrXABHK6B393fnQrD2/r7SS5uZL0vfWqa+Ebao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DL7VxExb/injE/53Ry0Cui4AoUWQGI+vJQdmeRgeYmpYz7d/fZWSPQw2Did6UWnGg
	 VRArHCYHcwFp/yiPFbjI49bN/ANEvZCKnxGk7d1Js6ddBv6EyXD/jbGrq+uAR3aXUc
	 qwcBlB0s4mUXk+vjKuSF8ZSIqeGXv5RwkC6nuZ9+IaDAnzSZESDgPJc1PHIH7kuPaB
	 P9mHRwHt3JFevE8KDPTz2SfxVIpkLDi2nvV+Kbcj0gvqOyRz+T+X/QARtMvK3rpAqH
	 6YCW142asSKg8SNobizWqx51a33/uLZifUf+OZB2kB38O2TQyzb6JSe1q5evZ5UObP
	 DrNyYi+WZDhIg==
Date: Mon, 2 Feb 2026 14:36:55 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Ilan Tayari <ilant@mellanox.com>,
	Guy Shapiro <guysh@mellanox.com>,
	Yossi Kuperman <yossiku@mellanox.com>,
	Network Development <netdev@vger.kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net v2] xfrm: always flush state and policy upon
 NETDEV_UNREGISTER event
Message-ID: <20260202123655.GK34749@unreal>
References: <cea4b855-fe94-4b4e-9c2d-3cef7aac1be3@I-love.SAKURA.ne.jp>
 <20260201141739.GE34749@unreal>
 <aYB1-MtqQgPnjJjg@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYB1-MtqQgPnjJjg@secunet.com>

On Mon, Feb 02, 2026 at 11:01:28AM +0100, Steffen Klassert wrote:
> On Sun, Feb 01, 2026 at 04:17:39PM +0200, Leon Romanovsky wrote:
> > 
> > Steffen,
> > 
> > If you decide to take it, please queue it in your -next branch, so we will have enough
> > time to test in our regression. It seems too risky for -rc8.
> 
> I plan to take the patch as is. It is a fix, so I'll
> take it into the ipsec tree, not ipsec-next. But
> I can hold it off until after the release if that
> will help regression testing.

Let's wait until the end of the week. We will include this fix in tonight's
nightly regression, and I will need a couple of runs to reduce the risk of a
statistical error.

Thanks
