Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3AD1E86E;
	Wed,  4 Feb 2026 03:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770176689; cv=none; b=qcfp841kxkujou327fswlM7gCr4ZjcKH1SZ/9n7xtSQ9blGzTo3RSEAAb5KkVgn9kyEqHVOF+eWFp6fxTEzSd//FFJrtHABeuBuCHAjJaVTP7wEmzvsV+2tTA78bKzQQk8MvReYyGw7Bgbey8Yi4eG/LFNi1Z6yK0tbakyibtac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770176689; c=relaxed/simple;
	bh=rzVDemqJ2mFVkX2GjuswxhsrAZDZUHTgweMh7Qetmw4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jOSvHZomM+5TV6CBNloneJgXGZzKpijIukJvT8SNOVrnof6F0LAazZoA+7QnkUp0OKrpPJythNkUXDMPIxjHBqjTvoZdwGed17zRkZQ0NWRwYvF7HTX/C/gndqLv6uHFi9snMu7+UOkIzxkDI5bowLoKX24wEmST+mECaJd8kK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9L8Yej+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9L8Yej+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B96C4CEF7;
	Wed,  4 Feb 2026 03:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770176688;
	bh=rzVDemqJ2mFVkX2GjuswxhsrAZDZUHTgweMh7Qetmw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g9L8Yej+cOCbjkeAs/UMfgHUqYJ+C/JkqyaHM5LPlnlyOjgojMj6FJtkjrLLzbIKi
	 13Fg51yh4Kl38K3e85jDVK6xPlo3vne1cT+GjNnOxuaASFDcgUJzh0ey9E/HyP6G3h
	 rF8+R9+Hk21qqjoX1cNMtiWb/0GEG0LuviQ44SwGq79TR2DeZGBm9YBF8F3qRUx9dO
	 sJYiTu6sfgn4iBfj9jJRroHJnXtFv/p+ncTWwMDJrTYSWrwspAqWucJu6nUA2xAbJE
	 NbDbIVmwNflMzSeSY7EYmXH3gulfPa/4EYbGFFUnwirOtj52hAZTyhlaz82WW7sWP6
	 io2M2xu7kG/Xw==
Date: Tue, 3 Feb 2026 19:44:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Eric Biggers
 <ebiggers@google.com>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [PATCH net-next v3] net: usb: sr9700: remove code to drive
 nonexistent multicast filter
Message-ID: <20260203194447.0ce4ffd7@kernel.org>
In-Reply-To: <20260203194317.07432b29@kernel.org>
References: <20260203013924.28582-1-enelsonmoore@gmail.com>
	<20260203194317.07432b29@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Feb 2026 19:43:17 -0800 Jakub Kicinski wrote:
> Not sure these annotation on the get are useful

* annotations on the review tags

synapses misfiring over here.
