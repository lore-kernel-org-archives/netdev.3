Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CAF19CC14
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 07:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.71.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777014156; cv=none; b=H3z+VAivpw7pCdAd4nVl+nb6K7/wPUd/0ZoR5CSdyihhHhaIgefB1KWjolZzQSarbJGyovoiXtAWbI0dZLy3h51g7ExFQAW6wJDEIBL2WxLH9gDw2rwLaWmA/trB99G3Hsf6MEJVrPi+3LHGbI+DmHyra+dE2BDP63yjdwdxjQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777014156; c=relaxed/simple;
	bh=T7W5L47yw686hcgDYMse07yCFgDsivSLsLSPUFlo2Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guswmn9UB2/YDkyDmUqAYX8Iy3q4NS7eN0nti++lSgA+jYnRhJnMPgRmvI+8vZNQ8kFqAySOolmUnJ4QX6GTvCvJKx6IDjS/thpV881ymr5kkdoEXMA3e2WyRwPtGRpSrz41AOPFJl2ubR5n1XG7BU8Er9wKoijLgRfwFSkZFPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net; spf=pass smtp.mailfrom=dominikbrodowski.net; dkim=pass (2048-bit key) header.d=dominikbrodowski.net header.i=@dominikbrodowski.net header.b=EPjP2FRb; arc=none smtp.client-ip=136.243.71.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dominikbrodowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dominikbrodowski.net header.i=@dominikbrodowski.net header.b="EPjP2FRb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dominikbrodowski.net;
	s=k27.isilmar-4; t=1777014145;
	bh=T7W5L47yw686hcgDYMse07yCFgDsivSLsLSPUFlo2Cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EPjP2FRbEEI0Mu65Ya18Hd8YMEPgsmYlUqqhBhbVMedPMQDba6+N3HvFG4Eu84ojC
	 XFKETOyZR7FvjVkjG8U53mVjqnM9Kep7N//U3VjytL+UPE5VkKHOVNqllD/bLr2Duq
	 1Rc4DCZTCaXvLQWMSncQHiIa78PUog2PTkG10Z528L2mjB13O4qV47GBQWu5bBd+Ts
	 XKSHUZfs3ijj2ZyU6/weRm5ZrpYqWoqw39jMwUB61WU/8pyI0+boPB5gXqSlxOZuMc
	 xgBmfvQxmEGkzoG2vpxRTJ33HO/WfMVYmFuYl1AMYUuct8U2xDJi6GyaD1cyxlL7TZ
	 +CnclPCPdlAVw==
Received: from scops.dominikbrodowski.net (scops.brodo.linta [10.2.0.113])
	by isilmar-4.linta.de (Postfix) with ESMTPSA id 2BA9520070A;
	Fri, 24 Apr 2026 07:02:25 +0000 (UTC)
Received: by scops.dominikbrodowski.net (Postfix, from userid 1000)
	id 3AA8380076; Fri, 24 Apr 2026 09:00:17 +0200 (CEST)
Date: Fri, 24 Apr 2026 09:00:17 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net] MAINTAINERS: add pcnet_cs to PCMCIA
Message-ID: <aesVATasVOq2ikD-@scops.dominikbrodowski.net>
References: <20260423220857.3490118-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423220857.3490118-1-kuba@kernel.org>


Am Thu, Apr 23, 2026 at 03:08:57PM -0700 schrieb Jakub Kicinski:
> Per discussion under the Link make sure Dominik can help
> with the patches to drivers/net/ethernet/8390/pcnet_cs.c
> 
> cc: linux@dominikbrodowski.net
> Link: https://lore.kernel.org/aeomUh5JqFvkLTH7@scops.dominikbrodowski.net
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>

You may also add the other PCMCIA networking drivers there where users
mentioned that they are still in use.
