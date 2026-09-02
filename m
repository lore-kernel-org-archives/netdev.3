Received: from mta0.migadu.com (out-241.mta0.migadu.com [91.218.175.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4281A36B93B
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337124; cv=none; b=nCQmIq8RCUZIqTK4oo7bwxLjN5nvoro58vwSe8SvZRKa30R5bBgCMNcuVXtLiFnWUQYLRAO3H8Q+CllpC0kWvDJnLRqGs4e6DHsHsBFat12JnRlQer/FRjqDBJ3gdeVqnSj8kFB6imGTIlILe6cxKAXZm6wFDadFJ+ME/QQsDMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337124; c=relaxed/simple;
	bh=lCcGOOJ4TF8B7v62+faaEO42LXxRdqJhr250GerN9ZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qeSHUzBGqmklo7r/TnhEgpXpv9mQ5dlIBOl5PAcwGz5Hu/Bvw07Sf6Riii2uaA1HzYeSiOCTtEqXC0mVY2FJJoglOtSGo0EIq0tyV2YmAb/anNDR3hACRoFNlzkTvT6kLH6UtgAicdl58vMkKbcW0l6RL7Raqm0RQeF3KAcyrfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xUpBAYiN; arc=none smtp.client-ip=91.218.175.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xUpBAYiN"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lCcGOOJ4TF8B7v62+faaEO42LXxRdqJhr250GerN9ZU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788337121; v=1; x=1788941921;
 b=xUpBAYiN1yIIUABFr4tC25wIjBuy/PZ/xN2tCT53wX4Qj7Bs843atI6X467rjGX2pYttfP7n
 bNhB/wRIw8x8HSjHSlbilnV8GTSnhaCn7ZtpEPzae7/6dFKhX6qg8xW/goj7yw+PAeAJ5LLuReJ
 6HCo77JL94+T2d+6kRPe2w5A=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a37a023098758fec;
	Wed, 02 Sep 2026 08:18:41 +0000
X-Mizu-Trace-ID: a37a023098758fec
X-Migadu-Flow: FLOW_OUT
Message-ID: <581da51b-0cea-44ac-b9f3-9eb6ae78f654@linux.dev>
Date: Wed, 2 Sep 2026 16:18:36 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: dp83848: check phy_read() return value in
 config_init()
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alvaro Gamez Machado <alvaro.gamez@hazent.com>
References: <20260902065828.1031113-1-donggeunyoo.kernel@gmail.com>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <20260902065828.1031113-1-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/9/2 14:58, Donggeun Yoo 写道:
> dp83848_config_init() reads BMCR to detect whether auto-negotiation is
> enabled, but does not check the phy_read() return value. On an MDIO read
> failure phy_read() returns a negative errno, which is then used directly
> in a bitwise test; the auto-negotiation state is left undefined while
> config_init() still reports success.
>
> Check the return value and propagate the error.
>
> Fixes: b718e8c8f4f5 ("net: phy: dp83822: use BMCR_ANENABLE instead of BMSR_ANEGCAPABLE for DP83620")
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Reviewed-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Thanks,
Xuanqiang

