Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5706347BDC;
	Wed, 11 Mar 2026 22:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773269990; cv=none; b=tCja23wYyyBDpi2wLiHJrmltzRZM22E6VnCTepxY/mRyHjU2uK63VvLaoGjlmyX3a4oCL7SWHtGqoAhAbgYhE4O9x3CTVsdQVZjx0Ku786bF9yRbHp0D2M7aKX/14nws6gsixWQm64cDTFQHqH1vUzvM08BGjQxEApXMYktGv8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773269990; c=relaxed/simple;
	bh=sy9Zwi13LYATgziwqUdxkmcUUvo4YWLt3PnTjZqv2kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOVVXvQhSxHbQkEN+LNMBaL4YuaufJa0zRNMcf0eUVc2AfZPJQ0xJzwgrkZVGjwN7zt5np6uclIw2hj3RJMPyyHHdhPgO1jNL+UnaNFyfuBFOnz2zaSCVH7x+7fGp/km+CRhYVuktfU2mkivEjR2oAG4sUYQigcmhFvZuu6vwP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=iPW66n68; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iPW66n68"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D74BC4CEF7;
	Wed, 11 Mar 2026 22:59:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iPW66n68"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1773269986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sy9Zwi13LYATgziwqUdxkmcUUvo4YWLt3PnTjZqv2kU=;
	b=iPW66n681C3YfmXx7ixB8/OrfAekPxh3on8GyzOtfLEK9ERUeqP97ANsFieKJuiggi0OL/
	ZEKhcnxAr1G3bDC2FMsLccPsa5EutyzUajshYbVVJSOx7yenan38j1p6QCncIIEzREpXtl
	shQs6PHduTQNOyGqfmHnGSQbbUzW9cM=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6f2398e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Mar 2026 22:59:46 +0000 (UTC)
Date: Wed, 11 Mar 2026 23:59:43 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Valentin Spreckels <valentin@spreckels.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireguard] wireguard: prevent ipv6 addrconf via
 IFF_NO_ADDRCONF flag
Message-ID: <abHz3xcsLhIPc_Jn@zx2c4.com>
References: <20260208170545.31942-1-valentin@spreckels.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260208170545.31942-1-valentin@spreckels.dev>

Hi Valentin,

On Sun, Feb 08, 2026 at 06:05:45PM +0100, Valentin Spreckels wrote:
> Use the flag introduced in commit 8a321cf7becc6 ("net: add
> IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")
> instead of mangling the addr_gen_mode to prevent ipv6 addrconf.

Can you give some more context here? Why was IFF_NO_ADDRCONF added when
the IN6_ADDR_GEN_MODE_NONE method has been working fine? What's the
difference between these approaches? I don't doubt that your patch is
correct, but I would like to better understand this.

Jason
