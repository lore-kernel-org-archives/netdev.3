Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB49E477E58;
	Thu, 24 Sep 2026 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790251106; cv=none; b=sav0V8GluIoMN4+TW9M0GSKwqqxXnMppL6aE8mCEv6DOvunurZ6/dMTV7crwLrfhRTpN3bLGpBZiuoLMLLPpUta42YGjsCu6YEXzXl/UGn19yMvBV3ogi4h8gJVdzU1KSMllq9TZdxF1F9bnTul2TJ9IDTVPvQzNxd5BAqAjsHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790251106; c=relaxed/simple;
	bh=6tgmo0miNRme0kSKVn7Zb1m81CEHI84TxlmbNx8FNMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjHTPlKOar2jP3XZ4nrIgC/Hz3tiUXhP8pBv4TT8n0m81FId0RJU1/LK9mhYW3MTmNQ3qX7C9U8TYM8xvy9jhro9/+1mEBUWYuNsfyiGlRzPJarGjuixQG2AlU2J0A7gs5RjzgjvP6+FlMZWcKYNtIlu5S8yuvVD2+aL9ZpL33U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=hdq4hVYC; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="hdq4hVYC"
Received: from L30177.local (unknown [213.36.7.12])
	(Authenticated sender: vjardin@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 2A35B78034D;
	Thu, 24 Sep 2026 13:58:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1790251096;
	bh=6tgmo0miNRme0kSKVn7Zb1m81CEHI84TxlmbNx8FNMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hdq4hVYCl+YxoONl4RWgrp/qM/BLdgnGbgkPaD+scxEfLLI2EeYtNFf1jpBO9ezma
	 7XzoJ2Az+3vvPWdMGL/D4BCQvwpD8YMUK1JZw82yA/N/YER9WIiEz4uXrBFdUfcXlO
	 hRXH8IGj+EBt5NTfjlALPMWxaigK9IfMy/IISrksoppqQwl7bPpTi0wfOcJMrppYsA
	 tS1x28SRtAK4KJp36HMyzwl/bNBfB+iwdWohgeQax3/iF8NoUsxTccLgd/KiH8vsrl
	 2xkArDfAaKFeqdRO7zfmt9fQFoUth0zu4twjmTs0GZv5lvK8/BDKe4+dpydSzB7yEc
	 +E5OlyYxTzNcw==
Date: Thu, 24 Sep 2026 13:58:04 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] dpaa2-eth: devlink port number from the
 DPMAC
Message-ID: <arUQTO5NVZvljvu5@L30177.local>
References: <20260923-for-upstream-dpaa2_ports-v1-0-b59c865edd00@free.fr>
 <rljgvjn3gbyq6ixikhnrwe6z6rlmfd3pepns4u2dujzjo6q6uv@kb7uozq52ozm>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rljgvjn3gbyq6ixikhnrwe6z6rlmfd3pepns4u2dujzjo6q6uv@kb7uozq52ozm>

Hi Ioana,

> Is consistent naming the end goal? Because renaming can already be done
> for DPAA2 network interfaces based on the of_node. I usually have
> something like below in my udev rules file:
> 
> SUBSYSTEM=="net", ACTION=="add", DRIVERS=="fsl_dpaa2_eth", \
> 	ENV{OF_FULLNAME}=="/soc/fsl-mc@80c000000/dpmacs/ethernet@1", NAME="endpmac1"

It was the root of my initial investigation, but I need more:
  - I need to have an attribute that I can use from the userland to name and
    rename many times, so in between it I would need something to rely with
  - cosmetic: just have a propver devlink

> Anyhow, I will give the series a spin tomorrow.

Thanks: it should not hurt, and devlink should be more coherent then.

best regards,
  Vincent
