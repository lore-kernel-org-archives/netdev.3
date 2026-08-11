Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2166296BBC;
	Tue, 11 Aug 2026 13:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454501; cv=none; b=lAeQV844/hXCOlF1OZrupGiKMqMWzJP5OpRw61T137AheZKnx3FHS+bUCZGVtE5wcLiitOUlyAHZBz+q/Cx4FR3Umr7rSyrBBQ72qqU/6F8e1kPXeN9wuSXa10SoqHHEzUDUHRpgb2K7KBvFyslThe5mVxZQvkmLKm2AIHg2u9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454501; c=relaxed/simple;
	bh=iUL5T8TIiIyJ47HVvZpVXrOXhoqEfC3oN6JufiNSJH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPD65+tPp6zlo4ppY35ipi5S+IolxOLJZOUZ7BYU4bLcTX4ts38WEiF6ObAFGnDm57HVAgJ3ktJTWMPHUbFXIRROLE5xxGxFJgyC+U2D+2UB0pXYRYfN7BFvO7QyDk8ytpE47+ULwHQJIif9nQbdHs/dB4aixtddu/YZ4OXDe+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ql9iNRVG; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ql9iNRVG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F0JeCqhCVST+H5HlZBzOWbt7QLzW5LHlgaVdjeyTCWo=; b=ql9iNRVGvPyxlu19San3d6pptA
	mSP10nwkf/xL/OZJnVIGAckyinGwn4tLV+mwxkRfdDRnmN6W/8IUZlqsyAX3I1T+XBisfT4XX9vga
	t2HkWoOp2S+2UPAEfgQefFQQ6lVZH3nnSjF2jpGw0kmpjnxDwV9Jf/F8DLAjqhAH35BR7/933SbVU
	dI0AQPLk1vYoLUgXtN7qEeOhkz6pd2gAW66ngiUfLR02sdopLyhRhzzIyKjz7U1xnI00Om1iXckU1
	Y+3+96zp2HCuw9URARqVSxG9BMd+Sf+8fuiqZzKgC8Mu4F326IDgfnIGbGQquBPicOsv5nPU7tRa8
	wtn+c9Yg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wtmQ9-003agz-2F;
	Tue, 11 Aug 2026 13:21:33 +0000
Date: Tue, 11 Aug 2026 06:21:29 -0700
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] netconsole: show empty string for an
 unset IP address
Message-ID: <anshqWm04umxzebT@gmail.com>
References: <20260810-netcons_ipv6-v2-0-3d4fc987a90f@gmail.com>
 <20260810-netcons_ipv6-v2-5-3d4fc987a90f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-netcons_ipv6-v2-5-3d4fc987a90f@gmail.com>
X-Debian-User: leitao

On Mon, Aug 10, 2026 at 05:47:29PM +0100, Gustavo Luiz Duarte wrote:
> An unset address (local_ip/remote_ip), now denoted by AF_UNSPEC,
> currently shows "0.0.0.0" in configfs. Print an empty string instead,
> which is more clear.

Ack. Now 0.0.0.0 is different than an empty string (AF_UNSPEC).

> In netconsole_print_banner() we can be even more explicit about it, as
> we don't have the risk of userspace trying to parse it.
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>
