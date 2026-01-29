Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D851EB5F8;
	Thu, 29 Jan 2026 23:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769728923; cv=none; b=HrvQNDjZaf7FBKMJEyxJQRAaq8xh2rUFqJJf0EvhcGoMU/Lp+Zmi7hofAhwokf09HVxOGMfSlAet6y1i5ECkO25P9azQPmMDsCMriGozfYl22Bj7nuO5TpEU+5mPvEu7HACVqIWn2GS3qkz2YVdexUdd0WkKMJez/JZdMyDmw6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769728923; c=relaxed/simple;
	bh=QyBRHl8Bki1xxY4RxOJZpwOaGHR+1sJ3FSUN7yWtY38=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=icczMvla1pX3zHvX1YVMYytH90lV6i7Q4LWy0CVURDQcqNZoUA9OWB6tHtmCG3zV4Zti5Svru6zaSSiK6oG+pNKmZ7HI5dDX/PEP4tIu8i1QTzSBsVIUxNBD4xPB5NxOEahx1pDhV/4ht0eH8MM77F6PRWlEhwb9yVwoaZehRNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHHFdJbW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHHFdJbW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26377C4CEF7;
	Thu, 29 Jan 2026 23:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769728922;
	bh=QyBRHl8Bki1xxY4RxOJZpwOaGHR+1sJ3FSUN7yWtY38=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hHHFdJbWMNv4xsK+ELqWJj2UM0Z2jg3kwOvdZ6q8pxprGmY1xhx+0JCGNK3cYM3oz
	 0p57GNIsf5I2+HRxcoB+rGMQyZ/X3wovPznREiEPKvhw00ONmX/z1smcj+uSOA+OKX
	 3sxAYekQO8aOcI+KL4myzyzL6yDPOnf32qR+4uvhB/LucZxkxE2BS2OSUMwZAwMWyh
	 cKnwY4GlCPgMXm53skCIU25tdptuQALzHs2SiEJha8CyV+Ywwo+IG+n2zbIzNaEDQ7
	 Jzujt8xulaghhW0KKIXKDJSEFC5hDhc9Q+Wf9ZCMzb1xtgfjxj4vrc20Vc0vshyWS6
	 nX40EzJqzkOqQ==
Date: Thu, 29 Jan 2026 15:22:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, UNGLinuxDriver@microchip.com, Andrew Lunn
 <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: dsa: sync dsa_mall_policer_tc_entry
 with FLOW_ACTION_POLICE
Message-ID: <20260129152201.389fac74@kernel.org>
In-Reply-To: <20260126061340.757543-2-mmyangfl@gmail.com>
References: <20260126061340.757543-1-mmyangfl@gmail.com>
	<20260126061340.757543-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Jan 2026 14:13:29 +0800 David Yang wrote:
> -	policer->rate_bytes_per_sec = act->police.rate_bytes_ps;
> -	policer->burst = act->police.burst;
> +	/* so sad, flow_offload.h did not export the type of act->police, and
> +	 * it's a nightmare to copy it field by field
> +	 */
> +	static_assert(sizeof(act->police) == sizeof(*policer));
> +	memcpy(policer, &act->police, sizeof(*policer));

This is of course an unacceptable hack. Nobody will realize that
there's a layout dependency here, not to mention struct randomization.
If someone adds fields presumably they will have to update
dsa_mall_policer_tc_entry_type() anyway, so we aren't saving much with this hack
