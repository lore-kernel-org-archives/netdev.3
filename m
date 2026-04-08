Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACB23C060C;
	Wed,  8 Apr 2026 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651226; cv=none; b=mCMgqd108A5mOTH9+L3sCJHSWyqL/L4NRS97LhRhrWN/wlfOqj716HnpLwbI5gNYISwkr6p/0icpEyKvUfsv1QODmK3X9HhS/4TP68JDHhEtBJL06ZKHhhJrUWsb057cull/ObAH/8mEFXoZ4j6mpj90MGGm8gAbjHVuPNaLSwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651226; c=relaxed/simple;
	bh=61bqf/n86evq8n4WhNpH0gOPlbEJbLlEEGG07swrrhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvCO0k3zBZQJrYM0mp95kxXoSlpP2082HapljhFwMQq1fWlhvpY2OMJMqpfCxPRh6AkJA6WgPjMi/JtpYOGB8IdSddDcwt0Rqj6r+DITiwLMvYvf6M6KPrM+fgajJWruTGVULjPkLfKTe2qccGMY82Zt7YEFbE8kkKFOhM6/eU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iGWSb0UQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iGWSb0UQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=t6/YFPq06fCCsztiaWRPp8X42VuvL8f9dUPnMAtVxqg=; b=iGWSb0UQpE6Qx2YDkEvQWZ4+se
	osLvB11UC5biO6OlQhgW/n0qJGuRgSSAaXdgpcegea1w9T6SgXuJWORKY1LcPhmeWrnFMjFMdhjt2
	jGOUuZVrcU2azfHmEqPVmPyHdDT4sWbqQ4VLHIb4NGQGXrp8OJI24t1xnQ0wX7n/5u8c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wARzX-00FHbq-0E; Wed, 08 Apr 2026 14:26:43 +0200
Date: Wed, 8 Apr 2026 14:26:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Petko Manolov <petkan@nucleusys.com>, Simon Horman <horms@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: rtl8150: avoid using uninitialized CSCR value
Message-ID: <f32a716f-2193-412c-b571-9001d5c7301d@lunn.ch>
References: <93FF85BB9F33CD2B+20260402070743.20641-1-zhangdandan@uniontech.com>
 <20260403154538.GA187715@horms.kernel.org>
 <20260405085212.GA8491@cabron.k.g>
 <76d6b341-27d5-44aa-92fb-3b8966d609df@lunn.ch>
 <20260408103343.19cf599a.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408103343.19cf599a.michal.pecio@gmail.com>

> BTW, some functions like rtl8150_reset() pre-set data to a value which
> will be safe in case of get_register() failure. But here, unhandled
> set_register() error is dodgy - the 0x10 bit may never turn on.

rtl8150_reset() is not great, it would be better to use something from
iopoll.h, and return ETIMEDOUT, but it does at least have a
timeout. And it looks like all other such loops have some form of
timeout.

Could this driver use some love? Yes. Does it mean not checking for
get_register() failure makes the driver badly broken? Probably not.

	Andrew
