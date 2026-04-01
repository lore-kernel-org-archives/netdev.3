Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D755C175A75;
	Wed,  1 Apr 2026 01:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775007998; cv=none; b=V0zQjPQEBaiFI76hGj842t0zx9GawHqX7X2JMuYM9Rmwub25D8zY02Mb64QJC+pt7BVWf0T8j4Gpwv7+DwNzxQF9BiEKs3jmDdZzD33WTmF6U9KjVK+bigYBCNROZ/NVY0UW646hTEdrHsXJbbOt/xmHL3RRwLWIP6A3qSLnFfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775007998; c=relaxed/simple;
	bh=DcVHuT3G8TNppfwhI1J5nLm0LSSzve6UVpf4pACU7+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fa0q292Kn9SE7vdaLWw8D9VeQFw0yxXAHvXXJa6hhzmTgoTY811lnkklAEzhrTVnlEjh7B90j8uWgS55ScEyTEl0XHBX3ZOrU9adP+v6cT7qWZkycbhZcbDqw+TN3ie6Mc/0LtvhE4mExMKcp1yfMFAHunNjH6NUuAyHK2DmPNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXe8o7jp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXe8o7jp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C83C19423;
	Wed,  1 Apr 2026 01:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775007998;
	bh=DcVHuT3G8TNppfwhI1J5nLm0LSSzve6UVpf4pACU7+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OXe8o7jpUC3rBkp5kRhvfgfG6WfWotT8yJ6SOc5zQyJyzPeOiiaxAbSelAHkvzFfC
	 RYbPRSpf+tMirXtaDWTTpRQzXYD/811Mk2GfdUY+42KBVt+Cp8AttYFHDXW3e9B8H1
	 6u+JHIRNAHGIeU7pPpCbE7rKNq43RjIwQO3E7O7+2uKsYci/yWRnXr6mAinOjSsX0R
	 15e9Z9TXrLyPBnukPjYAX8reDEJVQylEsrUjqbk9zJ08h+VuLxtkE9D27ijoCbTIp9
	 A013pqjRg12rANqyQ55XPs63kSWfulZmOXdgDXxm9c4NZlilw7yHWtE4ZZNPS0SBen
	 zOJPfDaXbT3Dw==
Date: Tue, 31 Mar 2026 18:46:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] ethtool: strset: check nla_len overflow
 before nla_nest_end
Message-ID: <20260331184637.58b968ef@kernel.org>
In-Reply-To: <20260331-b4-ynl_ethtool-v1-3-dda2a9b55df8@gmail.com>
References: <20260331-b4-ynl_ethtool-v1-0-dda2a9b55df8@gmail.com>
	<20260331-b4-ynl_ethtool-v1-3-dda2a9b55df8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Mar 2026 11:56:13 +0800 Hangbin Liu wrote:
> +		if (skb_tail_pointer(skb) - (unsigned char *)strings_attr > U16_MAX)
> +			goto nla_put_failure;

bit ugly, let's add a variant of nla_nest_end() which can return 
an error on overflow (without the warning from patch 4) ?

> +
>  		nla_nest_end(skb, strings_attr);
