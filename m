Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792544879;
	b=q0la6XuZgPBouTepSJDkyFcyNI6zTUGqUvzTv87WB89a5gBYKtV4wfM8h/l53FabHPox
	 hrTJ/j9fDDplIPmNBy/r0o0Si3kUwiF+F+DWnIJ7vjZl2T5lfSV7U6A3svvIy+WjFV5YI
	 GxWHaDTEx51Bf9Nz2u9bmd8EroCGtIai3rUojG1OhPgPwl43trRKd45dOsKRICqR1u+aK
	 S7ZBz9Va9vv61+BnGl4Q2wDS1cfg0gmaGJy7NTvpUSbcz/danPaAx7TCVJSo4Dq0k4Ljb
	 GL0TSW0CCK05GwXv/E/mx45Km2KCxDIVC60yV6EM7vo26XH3nMTlqonISuZAyOU8sAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792544879;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=t4LKaL8Ien7yGVH6xc4o374Vo9dTWdEv/FjzWmbK0BE=;
	b=pWSlySo9Qdg4d+q8cN/b6w90jPVwWTQMgBPLGM2u1kgFTtORkgkW/XRfo0bETJJ5DW9d
	 A9oM9Z8I/dsTMKGjZttylwd33jl+nO9ZjPHw2a6t20CH3aPWAc0OLYB0rBjmTZ99oU+U+
	 w/ngu5VBKqlBIyXLZIjneiL60XPb76QyVKn/RQQzJwVcCoeQz/PX1LAgyEffg/U66XMCW
	 fPlM/WA54XkkjOCqnCRDne7k+9ZgWAOzdTHlTmlEAmQoGJ9RuM0Hliqthfo3h0sJqGNEF
	 KcJgTsseylKtafy/AqmlYHFuu0aY+6+COAyxGckcgWLtwjPZdavVqHyJAPYHn0FAm6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XaNkdXL2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4148E606A31B;
	Wed, 21 Oct 2026 01:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XaNkdXL2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6408A1F000CB;
	Wed, 21 Oct 2026 01:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792544878;
	bh=t4LKaL8Ien7yGVH6xc4o374Vo9dTWdEv/FjzWmbK0BE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XaNkdXL2063LzwUVE2DjCAHwoCcN2NafSjU1oWpfxln2kWTJVwIwiXUswk2gmP21i
	 9WrvkwEeUeLpxwnebSxh2kobKeua717GTDlPp+FnMBUGZu0UcIFII2Esss8+cP/4xy
	 AijikP7Pvz9vz1kpqNT12QcjfZokjZwcYtP/K3rjTj9dAkmb6iZKTDu36Y8+zcSSlj
	 ku9c0y1v2H/jgrVhpbpNDy7ptoMDgZB4MdFfw63GCG7yTAzdPnirbN6K6SVJCYhNW8
	 d5mj/+pEFVxAf7fMdki653cLY5EkKkSzxOj8mIm0KbeyTLXOJkQV+r5GUzenQjs9LP
	 Tssfp5NoNFD9A==
Date: Tue, 20 Oct 2026 18:07:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chris Babroski <cbabroski@nvidia.com>
Cc: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
 <linux@armlinux.org.uk>, <maxime.chevallier@bootlin.com>,
 <Raju.Lakkaraju@microchip.com>, <davthompson@nvidia.com>
Subject: Re: [PATCH net-next v1 0/5] net: lan743x: automatically recover
 from TX hang
Message-ID: <20261020180757.0d08b6cb@kernel.org>
In-Reply-To: <cover.1792008404.git.cbabroski@nvidia.com>
References: <cover.1792008404.git.cbabroski@nvidia.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 11:00:39 -0400 Chris Babroski wrote:
>   net: lan743x: reset DMA channels that fail to stop
>   net: lan743x: start phylink last and stop it first
>   net: lan743x: quiesce TX before freeing the rings

first 3 patches are sort-of fixes so they can be resent
during the merge window. The rest will have to wait for 
net-next to reopen

>   net: lan743x: reset the device on TX timeout
>   net: lan743x: add byte queue limits support
-- 
pw-bot: cr
