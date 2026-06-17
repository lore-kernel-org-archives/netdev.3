Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5E83D6689
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781688999; cv=none; b=hjKIuVLwJ++sfY7r8x6t8kpjTz/ELapna89hwjXyEcFR9X986iUidfJ8oFsllVfEHqFNABDnzaPc6YMAb2wQtolceWCy44rrYXSNonJaiU/XsD2O/9mfC3KOJwLIZjs4OmAjGAeX+dj0UuD+P8vtoUF75OcqGRlwSrYLMeKcBHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781688999; c=relaxed/simple;
	bh=BbRNm8y1FBfHKpqoxnBw1aeXkgIorAY91Vn4evfRR3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2v2M1zDgWRbP7Z7PDwrVKyDpJYFC6z4/U4l+He8eurToT6uPHdeNWfgMrEr1O6OFTer3PDPV8JPT3/uhcQHDf0yzFlFoTbidji4ynbwU3xTPIywb1tTRl0x4G7boYoIvIf8XplwaZQlr7bDLNqcKV2B4RojnIL3AT8gD2sdr3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Fu3w2ist; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Fu3w2ist"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=P5Ye1io3XhSOO12mUAAOsL6uDGe3iMJtPtuI1oR8/Ls=; b=Fu3w2istTw6znCSJ0H0WXPzEIn
	0NeUUxAQYjJUcLBHl4sAj0WPrFSUbx4ObFu+OHIM70xgnn+II024+0a9mFgPjv4zX6RLmWsm/R8V5
	GB0mgInUVhcWu+OrIc7G7sOKBuYzHDsGeer+nMeKGZy22FOIjU4PI9L2mBOxTJFYcr/k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZmhD-0089qN-CL; Wed, 17 Jun 2026 11:36:31 +0200
Date: Wed, 17 Jun 2026 11:36:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH] e1000: Remove redundant else after return
Message-ID: <5350b174-13f0-41c1-9d8e-2996d6e21d75@lunn.ch>
References: <ead7bfc9-3978-4442-9cd1-23c2182b36b3@lunn.ch>
 <20260617075855.113719-1-lovekeshsolanki00@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617075855.113719-1-lovekeshsolanki00@gmail.com>

On Wed, Jun 17, 2026 at 01:28:55PM +0530, Lovekesh Solanki wrote:
> Hi Andrew,
> 
> I read the documentation you linked and understand simple standalone
> cleanups are discouraged.

You also said in the commit message it reduced the indentation level,
but you did not actually reduce the indentation!

    Andrew
