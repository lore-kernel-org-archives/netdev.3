Received: from m101-out-mua-6.websupport.se (m101-out-mua-6.websupport.se [109.235.175.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761E741687A;
	Mon,  3 Aug 2026 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.235.175.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769957; cv=none; b=KFldtvdrifziEKXOTJPSt/tE6pZI9PWxy66nGtDoVmDtJ/wXFPNF68OlDFLGwiZTD30iSowE/AqGTVvaQdMvWxmiGBlHDzqpBL0k42AVhulTchb0m9fL4npE4un0GmfY1y0yaqCAD9L9g/XFyaAPJxbN6dmcGTbX7rcu0c3jtLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769957; c=relaxed/simple;
	bh=aYwJ8HtrLL65VrBrsw17zSdY/TL9yfZhIiCAwiCUSI4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k3RINcDqqlEHAnwy8OlNU+Co7iwSAMJ6E1CKJ5ZsGJwYqFMaqB4HIH7/x0ALbyXYxZ1JdjE3NRZCgokN84jaQCoZc3OLiavErbVbgeekewoD13cF5tcbHaZ0TovsZX6AH9USj/cIU0UV2pG1eIBBb1QNGJdPEoa55awAKDg8rpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=palvencia.se; spf=pass smtp.mailfrom=palvencia.se; dkim=pass (2048-bit key) header.d=palvencia.se header.i=@palvencia.se header.b=sElV9+Ff; arc=none smtp.client-ip=109.235.175.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=palvencia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=palvencia.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=palvencia.se header.i=@palvencia.se header.b="sElV9+Ff"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=palvencia.se;
	s=mail; t=1785769181;
	bh=R1vOM/+20o3TMKvY0hJ6CpvJxctkLVGrkvrEwrllBi0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sElV9+Ff5U+DkJvNLLH5uuIwQEo0WczVLH2dcT2MNhqdYclOsIcC7NvkZa/qQcvcz
	 xefN9yvVNdfXaNUF01XbuRB2SkVRC252vvJ1zCEKdESUX8zhgSaJxwaxq5do3NXHeE
	 cX37p41bMeB09BVaVh9+HxKp80Osp7z61OxvpxCPzwOYG3JsfgWyTb02ED6KSgf6tb
	 9A6y3bI1X8Pdgu9yfyICV55h0UAd6Lwez9UYO3hn0xWQP+fDRQH25i43qWEVayQghg
	 QNJDvNJiM3L4YRKAL+uJ08Ab6ACK7UhFGgUvv+SkEFQML22Fe+FUIB6hrSYyROYrSi
	 y15dTjkUUx6wA==
Received: from m101-u7-ing.websupport.se (unknown [10.30.7.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by m101-out-mua-6.websupport.se (Postfix) with ESMTPS id 4hDKb12YX3z1xN7;
	Mon,  3 Aug 2026 16:59:41 +0200 (CEST)
X-Authenticated-Sender: per@palvencia.se
Authentication-Results: m101-u7-ing.websupport.se;
	auth=pass smtp.auth=per@palvencia.se smtp.mailfrom=per@palvencia.se
Received: from rpi (unknown [213.204.219.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: per@palvencia.se)
	by m101-u7-ing.websupport.se (Postfix) with ESMTPSA id 4hDKZx39MJz306w;
	Mon,  3 Aug 2026 16:59:37 +0200 (CEST)
Date: Mon, 3 Aug 2026 16:59:32 +0200
From: Per Larsson <per@palvencia.se>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Liu
 Changjie <liucj1228@outlook.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/6] net: phy: maxio: extend PHY ID matching
Message-ID: <20260803165932.725dd669@rpi>
In-Reply-To: <20260803101452.2993721-5-andre.przywara@arm.com>
References: <20260803101452.2993721-1-andre.przywara@arm.com>
	<20260803101452.2993721-5-andre.przywara@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Out-Spamd-Result: default: False [1.90 / 1000.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.com];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:35790, ipnet:213.204.219.0/24, country:SE];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_ZERO(0.00)[0];
	ALIAS_RESOLVED(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	HAS_X_AS(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	LOCAL_OUTBOUND(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,sholland.org,armlinux.org.uk,outlook.com,vger.kernel.org,lists.linux.dev,lists.infradead.org]
X-Out-Rspamd-Queue-Id: 4hDKZx39MJz306w
X-Out-Rspamd-Server: m101-rspamd-out-4
X-Rspamd-Action: no action
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 506
X-purgate-ID: 155908::1785769181-3CF061C6-6612C796/0/0

On Mon,  3 Aug 2026 12:14:50 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> Currently the maxio Ethernet PHY driver expects a PHY matching
> exactly the one ID provided: 0x7b744412. The Maxio MAE0621A-Q3C model
> used on the Allwinner based X96QPro+ TV box uses a slightly different
> PHY ID: 0x7b744411.

A somewhat unfortunate typo here claims that the TV box has the -Q3C
variant when it in reality has the -Q2C variant (Cover letter and other
pathches in the series gets it right).
