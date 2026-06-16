Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644C54502F
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 01:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781571676; cv=none; b=fYufzaJz+YdwaXIibFUpj8RwEFeWWhuQoaQOBggEpwBa878FPWSnztqOyRdvEMSnP0+Mclq5cKy/4WtiCo1kJ46d9eNif4VvfCFaj90bVluXLwmyG9scwFLEluGcIqdim/Bmn2cXhgkTSQW1KjQw4MJK2M+M67I5iAhPNkpAhPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781571676; c=relaxed/simple;
	bh=ls3HmpOgHhONDL/zyYQKXM6JmTBUuGrq/nK+wOXB2Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJAXsPnbaflT9QhTHjN98XoKJbd8qsZyGi1VHnG7WVLQ1rX3EU28Fv0sGndSRt3q+qfRUZN1bWh3AXtPEKkU+lSJPABlYghTLdmanKsk3/fTmx5XIkgVw3pXOEfRGTXv/hBW62n3f/2oe/iFe31OoOwrBQ8mlKNfGhUJcVDidO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9PR013s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9PR013s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0709D1F000E9;
	Tue, 16 Jun 2026 01:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781571675;
	bh=Dm0za3nNNqXWe406TFKCsAXtR6FAj8KUkFXQtNDJi0Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=T9PR013scgHSgYmlD58QMOy2RY8rEVAxWw+BOUrIKtCNy2yxJLbPKQ0Pny4XppTyk
	 A3BvaEleJ+/d3tNSEaxTbxc+c8y5u2v/Gn8yP/0XU7jrTBY9yLACTKqVnZYTYD16MF
	 eZLg6/wrE4isDZnW4cuH2hT0/Ivx6ZDoY4QYjK76e5oLCxiygj6ZtyNmFqozr7aAv2
	 c9+U+I9fomilkXJg42OmMYy4Jxz9XABA802T5hopFS/6LnUaHwbaD70/JvOtbQIq5M
	 mLCuKAYXsIG41z4asLnDyppA+pMmR0lkBMccgSyKOdvfI0hQ7uuRVErEyJ4dmziUxa
	 iH9YMkizGn7Ng==
Date: Mon, 15 Jun 2026 18:01:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, Jonas
 Gorski <jonas.gorski@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Kurt
 Kanzenbach <kurt@linutronix.de>, Woojung Huh <woojung.huh@microchip.com>,
 UNGLinuxDriver@microchip.com, "Chester A. Unal"
 <chester.a.unal@arinc9.com>, Daniel Golle <daniel@makrotopia.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Wei Fang <wei.fang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <clement.leger@bootlin.com>, George McCollister
 <george.mccollister@gmail.com>, David Yang <mmyangfl@gmail.com>,
 netdev@vger.kernel.org, Sashiko AI Review <sashiko-bot@kernel.org>
Subject: Re: [PATCH net] net: dsa: Fix skb ownership in taggers
Message-ID: <20260615180113.13fca89f@kernel.org>
In-Reply-To: <20260616-dsa-fix-free-skb-v1-1-fd30b35dcf66@kernel.org>
References: <20260616-dsa-fix-free-skb-v1-1-fd30b35dcf66@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 00:33:00 +0200 Linus Walleij wrote:
>  24 files changed, 243 insertions(+), 91 deletions(-)

Impressive. Thanks a lot for doing this.

patchwork says it doesn't apply to net. Is it on top of net or net-next?
Since the merge window started already net-next is probably better but
you need to designate in the subject correctly. Feel free to repost
without the 24h wait, maybe we can still slip this into our main PR.
-- 
pw-bot: cr
