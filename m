Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9544052A7
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 12:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760537; cv=none; b=VGiCmffZPJskUQJVzCrj5lVEBChlO+g1+eZoVZdDkrcgZ7psQlWMaHROwQN+AVXz/puFk3glP2S6hEWTLQF6teE7ZBE1igC6TBKhhhu39w7BxsRv3GU6xERBCvoHyXpq2Slw5QSTY4+hYHqbdPlj+0U6CjoFC2sj47qlIs+MJzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760537; c=relaxed/simple;
	bh=8gGIn01gR773dFKlIdP74COBEr4nha3Wkf1dJLsC2YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrbZ2hMSxE+g/lIRxiVnl+ddXMt67WpO5ued1Oj5jK/qdbBv/4mGWGWh8LqfsV0WhlvyM9u09dIYFAPC72rA+DYXZgXQ2P4NFfPwceFu1uDcXQOeyFiszUz7iOuR1NZJBhmktEY/verGNDkbidpRkOa55yTf57+xxDojxKjQyDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=tCfrFOt0; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="tCfrFOt0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EgdXmQR4agnZf7cnMsJaw7c1SvrSMEZqHkeCmuXKUkU=; b=tCfrFOt0L0vHaBEPV7AzKTNOGn
	Z8DRlG2bu20mpf3hbRj5h73eSURRIcrkQMcYQKZijgXmcHOFGyBB9QfUJFR0lbM64bfivFERpWGr5
	Aj5ZvxZaWFxhEpDyjiCVLEfSsoorx9GknSB9lXMDi8tKr8u15C00xYZQ5dA80aBW2yu/K3f3KHqzP
	cHISuE9zqIURuoEGuc06BuB4LK/McZXTiSO58ByeM8JNNZ9ltooReqRgVOxHvE57BetC0qIYTBJ0c
	5eSKbjCNiyljsKyPw/+Y09h7pUpt77jsSKECeKU98owh+mhX6707gNDCzXIz6F+YxG31hKj2DGyY9
	gAFX81Ew==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wqrt8-00CMSx-0D;
	Mon, 03 Aug 2026 12:35:26 +0000
Date: Mon, 3 Aug 2026 05:35:20 -0700
From: Breno Leitao <leitao@debian.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Joe Damato <joe@dama.to>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, Rongguang Wei <weirongguang@kylinos.cn>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2] net: ngbe: fix NULL pointer dereference in
 non-MSI-X interrupt enabling
Message-ID: <anCK_soDKEdnVHbh@gmail.com>
References: <5FE44222ED3FAC4B+20260803072022.377406-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5FE44222ED3FAC4B+20260803072022.377406-1-jiawenwu@trustnetic.com>
X-Debian-User: leitao

On Mon, Aug 03, 2026 at 03:20:21PM +0800, Jiawen Wu wrote:
> In non-MSI-X mode (such as legacy INTx or single MSI), wx->msix_entry is
> not allocated or initialized. Calling NGBE_INTR_MISC(wx) dereferences
> wx->msix_entry->entry, leading to a NULL pointer dereference crash.
> 
> This issue was introduced by fixing the IRQ vector when the number of
> VFs is 7. Fix the issue by explicitly checking `pdev->msix_enabled` to
> determine the correct vector index.
> 
> Fixes: 4174c0c331a2 ("net: ngbe: specify IRQ vector when the number of VFs is 7")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Breno Leitao <leitao@debian.org>
