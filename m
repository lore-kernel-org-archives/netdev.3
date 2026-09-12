Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6932AEF5;
	Sat, 12 Sep 2026 00:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789171678; cv=none; b=PBRGkYbhTy6lRur6P8hIsXuiTiiwY5DDiJ9yoUsxShca4aBcxD9c8650zg2TBEbLTbiP3sTSJJOW+vD/5+EOzDZexa2F71RkwNHB54TCboFe2iMq5IB5ou4lotSPmqPG1imzY/IHlt+G5KJS0azRiEldRi9UO5yz10UEtJh1mXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789171678; c=relaxed/simple;
	bh=Nelty/uRh/CjT4JU6dZonrFBaPegpBcE/x5fbLrHfyw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EoTA9YsbRCPBCLLvI4lDTWRHl9w3SVp7bZ++Oy1jyjJouPGqyWCW0sUn8OFue4IQx1x+/8H30xDgF72d6kLpU96Tir/4ge9XaenN+iQSNVtk/8u8nunH1JRB3qGxr5ogGzhpAFfX0mjslwZpoC62wIGGyeBuceUls2BzAY+nFOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASUPZw2l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASUPZw2l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5231F000FF;
	Sat, 12 Sep 2026 00:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789171677;
	bh=6tnQj8PZOglxwDmgQi4YM2ygZw/9bEqnwd5bUGAk9Mo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ASUPZw2lQ6fj+djME4kKysv6SGDLGVG7Bk9KtfHYw+3gzlvVxvRFAOIxMGUZK0382
	 UXPg6Jrdq3eInUkCvGFBC9o0UrhRWUdhbzfKfLDSwwKmrz1PIoQug210lldokV7Mes
	 hqOIUmu/O/zMDTMyb/9g5czsOYNH3FmOGaYGPxOjMyw/wraBbDHjxPOGwmHoWtz0qr
	 Qj+SzfRxuHmKD7IALhE1isX9L5wkmytHaopdiPUFoVtI7JYTLFhSU7i9pMHa1uDmyf
	 sdyjLy3eKeQ/srbhXY0gfLggfw+ihWMqg+TDtIcbsrKwOgRKP8kZIygstARaQms6IQ
	 kBfFdaSP2ahww==
Date: Fri, 11 Sep 2026 17:07:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 vadim.fedorenko@linux.dev, maxime.chevallier@bootlin.com,
 dong100@mucse.com, wangruikang@iscas.ac.cn, 25181214217@stu.xidian.edu.cn,
 hkallweit1@gmail.com, han.junyang@zte.com.cn, xuanzhuo@linux.alibaba.com,
 enelsonmoore@gmail.com, jes@trained-monkey.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, naseefkm@gmail.com, b.larsson@gmx.com
Subject: Re: [PATCH net-next 2/2] net: econet: add EcoNet EN751221 ethernet
 driver
Message-ID: <20260911170756.39f10138@kernel.org>
In-Reply-To: <20260909212146.3184077-3-cjd@cjdns.fr>
References: <20260909212146.3184077-1-cjd@cjdns.fr>
	<20260909212146.3184077-3-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Sep 2026 21:21:46 +0000 Caleb James DeLisle wrote:
> The EcoNet ethernet driver is somewhat similar to both the Airoha
> and the MediaTek drivers, but still unique enough that attempts at
> code reuse did not prove fruitful.

Please split this up into multiple patches.
Each patch has to build cleanly with W=1 path/to/your/driver/
Please also use ./scripts/kernel-doc -Wall to validate your kdoc 
is correct.

Please don't repost patches less than 24h after previous posting
Please don't repost patches in reply to previous posting, always
start a new thread.
-- 
pw-bot: cr
