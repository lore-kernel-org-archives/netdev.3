Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4A027816C
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560684; cv=none; b=aZRhGN64NGV0T40lL8phtB7o4pSPbCSaIxy7F3g/UJP5ozUyaPIM5R+RMRbSV7HxCSqWCs+dyceNBD6qCKM9DPApFqoJBDoBwi7IUMMUv7nFkTfmpzI3IEX3xOCkvxxzUDvcZ8TamRwx+OZD6twczIlbGgLSlfqHW47NflxQigU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560684; c=relaxed/simple;
	bh=MCQU7F17c48MMnrc38XZIsNFX8kwUVCJRzPQhkVNzBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=inBZiYT9QH+xCSkoBF/Tgig2qBYcuoMcxA4I8VTf4kLjILGTyekHaOW1vO5tXKx1tGmvYZbxC6UrjC1d3EvNt7e5+Lel2XctamTMLG0Wa+nB4U9wNiIea/4yX1q3e4q1Qaj+MkPQjN4bbh4K4ENZ3F9VzN64VzJeuQaIz/lOfUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sm89W4qe; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sm89W4qe"
Message-ID: <6ac12388-60de-45aa-a8d0-62fcfaf7bea2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784560670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rezyicakc8bTaXPqt99+WXV0sTaLlKD+nbSaGZIN9wU=;
	b=Sm89W4qeh+Bs2jMuaxXsYbrngKGfDXoKETgLFkT4Er8q5C9jrJqcDPZbP6jZ/Myw13dMMI
	HTTsOnYHqBrbR9xx6BWZ5cIvELkFmY8HHCclKa+gMyQ8l7F9og6i7JMv7Y2dr3GALayGX0
	fh1So6VdD8N5qL3yq9PTd+Rm3SHCTwo=
Date: Mon, 20 Jul 2026 16:17:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: stmmac: Simplify ioctl handling
To: Andrew Lunn <andrew@lunn.ch>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Russell King <linux@armlinux.org.uk>, thomas.petazzoni@bootlin.com,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20260718143848.677531-1-maxime.chevallier@bootlin.com>
 <ae82997f-537e-4a2d-abce-d163fcf9d868@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <ae82997f-537e-4a2d-abce-d163fcf9d868@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 19.07.2026 17:13, Andrew Lunn wrote:
>> Looking at this, I'm wondering if we can't just get rid of SIOCSHWTSTAMP
>> handling in phy_mii_ioctl(). Looks like we can ?
> 
> I'm not sure about that. We need Richards input.
> 
> The code in phy_mii_ioctl() allows the MAC to be bypassed, it goes
> straight to a PHY based stamper. It could be the MAC has no idea the
> PHY has this capability, so it has not implemented the .ndo?
> 
> It might be we need to hoist the code from phy_mii_ioctl() into
> dev_{sg}et_hwtstamp()?

Hi Andrew!

I think I've converted all phy drivers while removing support for
SIOCSHWTSTAMP/SIOCGHWTSTAMP from netdev ioctl. I believe it's impossible right
now to reach SIOCSHWTSTAMP path of phy_mii_ioctl via ioctl on net device.

Is it possible to have ioctl on phy device directly without involving netdev?
