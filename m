Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F1A9463
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 22:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782600575; cv=none; b=q1YRN5eSP2bTmM58pXG/qVb4Fb5lV1prh88jTNrEbSSm1hHmFbKXQp0p6/bsu9SYxYzNf2Fg5XeVKRs7JpFj1Y9/M3O4iDbvH7JPhFH44pnurBoE/lYy/7dWfYvny62TXjof9jsSRFEwLnp6lFRRPHEEsIklws+qWr2ubQTyLBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782600575; c=relaxed/simple;
	bh=EDV4vW7XuXcYOKgF8ffKtCsB4ZtaV4p1IMk5iDX3t70=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SvTiW57Gvn3tDXoK5yTQgh9Eq3NteDUJp3LCE0uOmqY7zrJLWP3QVHVM9QpUOWiPCUvpDkqCeXD4p2lmYao22u4XlYzJCvO/2w2XOLZPaNQpGw8wUu1vTznYGMX2KA7DxgibDbkePf76M1u+9lsLde63Wq1yb5vLIDoIYG/iRc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzC94qMH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzC94qMH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC081F000E9;
	Sat, 27 Jun 2026 22:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782600574;
	bh=lvc4789cmtfQZqve++GjyXObf85hW1/QotscR9uDLek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GzC94qMHKna911BVaHrhsAln32XiWYt0EojNHEEVQaAlKRzVsoGY01S6nSUcMIqmc
	 B+fwmwpzvxBj8zQVg3ApeV8HU8VBFll1jLytppVWD93GK7qBH8Zg15jOn8ws8B6CF1
	 COphaCX3dV9UNfNI6ULQCMXpP5BneshmWe3sAkGDdWBOAvWuJIVZfbCy+GlDxLzQeE
	 YciTgJS/dPPs/9o3Xjs5eVQgfJ8R/JV2MPQ84Ouac/2tIXZmyGlJUdff+/KwKKv8aA
	 ZoW0yy52dwUfGgo0fcf0o65sT+URodqdgfMp8+Hq0M7re4gMBlh8E8rdtNaVa3sm22
	 QYr/N1mNMAGdA==
Date: Sat, 27 Jun 2026 15:49:32 -0700
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
Subject: Re: [PATCH net v5] net: dsa: Fix skb ownership in taggers
Message-ID: <20260627154932.1304e1f4@kernel.org>
In-Reply-To: <20260625-dsa-fix-free-skb-v5-1-b5931e4cbdb0@kernel.org>
References: <20260625-dsa-fix-free-skb-v5-1-b5931e4cbdb0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 09:47:01 +0200 Linus Walleij wrote:
> NOTICE: Backporting patches to taggers (e.g. for stable kernels) after
> this point cannot be mechanical or they will introduce double
> kfree_skb().

Sorry for the backporting pain but since the DSA reviews have been 
a bit sparse lately - I think we need to keep this code base free
of tribal knowledge, to the extent possible.
