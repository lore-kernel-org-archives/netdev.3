Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BB9471D10
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 22:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788300123; cv=none; b=m2XlEIlL2MdK1JiK49s/nLmQHA6J6r5ijybEZQxWoB9N8n/mSl6168cFtqoCASFcuefRjqZYNB2fKf+upf+lodNv/qHVrVWTRaATWr6Z4aPfzHKcThODsX47EKr44wcLkXnv1YCvnXhV1laCFFr+4oh+uIGukWac709crOuu0Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788300123; c=relaxed/simple;
	bh=0fyh7yBfduzNVfBZYqVniVlwywuNqEUlzXmAIh2kRug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EabVi7YnoM84bS80ZWiyWvLrKXqMIErqs1njTl7Ca0E9mdv03PiCJJ6KMj3UIsf6diUtKHF2Z8VPnvBhReimn0jXZhTNH56VV1aVKi4P8BB7cW1111h40fwWEuJKhXSzcOcr/casEk12lt1oTZDpnc1hD2LKLWElIfiWN5Wv5Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1r8//dDq; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1r8//dDq"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A5FBE4E4149C;
	Tue,  1 Sep 2026 22:01:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 68A9E6053C;
	Tue,  1 Sep 2026 22:01:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5ECD711C792A8;
	Wed,  2 Sep 2026 00:01:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788300111; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=4fB9v4VKpH4wMxrUa4I5QQUpNx8xBBoJdlftbjrWSbY=;
	b=1r8//dDq4raqvJx7uqyJfRX3ho1PuwlKIS8ip/w/3pHEXBGdhlQCMjdegmz6PiIUCuIHhQ
	eC0O3A3i2ZvMKvkUdU53aRprIv6E8pl95nq+kvRkICG32eMHQLLvo0Tm2mfY52zdpMYmd3
	Aj6ZLd2nPcAvb2xzpLz8w0pqIdTO8jueR/HqhGhIEKSRsLclIx3Bt+XrVx2Ke33lEuNrIM
	gBgDH/T2+OKRoQsu5J4MbqKW/pbFQFYD/FjLif66fanXUT0IfHBEPU542wUQvxFEqUgZgi
	aEHMF50rLb7iBaxHIQtybwAqMJJr43OW8XoHIpuPGO2149lOh5j0YeW7kKaZ6A==
Message-ID: <0b4ebf62-868d-4a43-8f20-790157bedfd5@bootlin.com>
Date: Wed, 2 Sep 2026 00:01:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: pcs: lynx: add support for 25GBASE-R
To: vjardin@free.fr, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260922-for-upstream-lynx-25gbaser-v1-v2-1-1e6cf79c7b52@free.fr>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260922-for-upstream-lynx-25gbaser-v1-v2-1-1e6cf79c7b52@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Vincent,

On 9/22/26 21:40, Vincent Jardin via B4 Relay wrote:
> From: Vincent Jardin <vjardin@free.fr>
> 
> The Lynx PCS never supported 25GBASE-R. Add it, so that a 25G DPMAC on
> LX2160A can be driven by phylink.
> 
> The SerDes side had the mode since the commit
>   1cab8fba5073 ("phy: lynx-28g: add support for 25GBASER")
> and dpaa2-mac maps DPMAC_ETH_IF_CAUI to PHY_INTERFACE_MODE_25GBASER,
> but the PCS never handled it, so phylink_validate() failed with the
> interface.
> 
> 25GBASE-R is a serial mode without clause-37 in-band autonegotiation,
> exactly like 10GBASE-R: it does not needs any configuration, its state
> is read with phylink_mii_c45_pcs_get_state(), and it reports
> LINK_INBAND_DISABLE.
> 
> phylink_mii_c45_pcs_get_state() is extended in the same patch because
> without it the link comes up reporting Unknown/Unknown.
> 
> Suggested-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> Co-developed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

