Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389CC4A841B;
	Mon, 28 Sep 2026 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790594966; cv=none; b=uzH86gru0TBAR1n4Y0LVaGMCUGBc2fCSyCGfU2s97+BMnGozGEtsRaI+cQurooeF32zzW0lf1r5tsb5PD79qm81dXM7lg7kNiYKqrnHVVE9olTV7zbb0do3U+vXfqThAq7ckAkR3IVpvrdnIv+1ovRvsdyNlXDozcr1UxddXgd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790594966; c=relaxed/simple;
	bh=3U93ISAaqcOXYYW42x1Lctmvv8RWXxxa0d3YFyzG7Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRf/ud/ZFT5UvPj4rQvn9Bpx1QW5Llmoo9LjrJQDP0/u2g58Ea0REWT/jeflGGwLMyXOkoaN8ARQcU7CI8cxZ3V4YMWoAnSDc5yKnUVa5Hi0vzGJUEwD95U4o8WvsMB6Q5J7QUnczGiDlpE6LdhIZxcgWzMKjtNASW35Bd4dgnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=p6JCN3jj; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="p6JCN3jj"
Received: from L30177.local (unknown [78.240.193.235])
	(Authenticated sender: vjardin@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 48DFB19F5B2;
	Mon, 28 Sep 2026 13:29:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1790594962;
	bh=3U93ISAaqcOXYYW42x1Lctmvv8RWXxxa0d3YFyzG7Hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p6JCN3jjBiYXNd6tCyD2ATm/H30/DyKOxbgvUnKm0WZnx/p/pElP5IWWjdc8sZh+y
	 PSND1Qr5RM5c+xW7feOOUvmrBoQDfhV2T/qqu5Xyyhc9oSFPqETktuKLneJW6x8+Qa
	 g00NzC8YhvYTQiVtYgOtDcqjF3sTB7Cvx3VAZkhx8IiELIWdMzDeranMzNMDIlChOq
	 SXOi+ltUNfB/iivsWrZPNKDzaJPURnxoJHVN+YGDQ/Q2gskiJMXlni+XPTX7C7cOqv
	 7/l4SjpKHioaHCcb1N85Hg/niX2K1FqwrKwMWJR9aVsfg/k5MUTurwNmePO6eFkjMP
	 BkJ+NniGSE9LQ==
Date: Mon, 28 Sep 2026 13:29:09 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dpaa2-eth: use the DPMAC id as the devlink
 physical port number
Message-ID: <arpPhWmuEzR1CuOF@L30177.local>
References: <20260923-for-upstream-dpaa2_ports-v1-0-b59c865edd00@free.fr>
 <20260923-for-upstream-dpaa2_ports-v1-1-b59c865edd00@free.fr>
 <ajmz2ulwmxzwmc2qymbka6ddlhfr3hcolkvszdsnhbdzqxwbpd@raxnrv3i3xgt>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajmz2ulwmxzwmc2qymbka6ddlhfr3hcolkvszdsnhbdzqxwbpd@raxnrv3i3xgt>

Hi Ioana,

> I agree with sashiko's feedback on this warning message. I would prefer
> a simple "devlink port number %u is stable, rebind to update".

Done, see v2.

Thanks for your reviews of the patch and Sashiko's comments,
  Vincent
