Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1A57080D;
	Sat, 22 Aug 2026 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787427880; cv=none; b=bNiHjfTmyasVA3t5/1tWfL9bWVQpdQsHwClltaswfTM52c1c1F+3Ma7fRs3gs2XgeRXKvLkQvue/at3fEf9sY2IUvVWmHbaLTjJUhGyG/vsh/gk4T7Dzqpbr8BkFSruyDoUJgaLy+qcjsbT81m9p6rk2V/R2VEDhtpe1Gng3POA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787427880; c=relaxed/simple;
	bh=dZcPgbFndnuToEm18a1ZbjpdZw5LXlCtcJ+EP3kT08w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQmppcRBxKY9tMbqcBMym3B8vkIGr2BGdLUAfo6rnwVZmN7sFipho9bzkN95reUfl0+ke1JSqFTOTXr7unokCU7hJ7wHXcQbMwLFQGRPHrVQVEy+fpOQswsurg7aBMI3M6r7SL3Pzd5z4pDH7KA7wihIzmc+NEVsGrCHTcv4AHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8iTDr7L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8iTDr7L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE6E1F000E9;
	Sat, 22 Aug 2026 19:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787427879;
	bh=zDyng24oNDCdDgCI0OnzaGcRhJHZICMrLTy9e+W9GRc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=D8iTDr7L0yisd/hYhMolRDHGlp5Di+L7AhGGezgIMmFOIKCi1DP87M+cb1GLdZTwP
	 0ptycL6pV5+xi9cfKIyijKCsJ6CghBerhIPFGdzP9dW/oo3vkVkguOv8waYn+/fbx7
	 yMV0dJMzJOU8g5RZ+cA25/w2KXoe6/Rl2lRIUM4ySF7fHxXDa27Arpsj2ukuWG7RkZ
	 ecHE0J1TXumklmlBhqqbwvd+LxrEXBFQfU/6nuydaWWhiRcwNkIKzVAHFAOSyAUai2
	 T02Ou0aFDLi11/phwDmaKLqiCL5RsYxbal5Pp8DfkUsIfSnrjFn8oVrvENHpBRkqAJ
	 xLQri/PdQtnyA==
Date: Sat, 22 Aug 2026 12:44:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>, Conor Dooley
 <conor.dooley@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: Make sure clk_init_data is fully
 initialized
Message-ID: <20260822124438.527c40b7@kernel.org>
In-Reply-To: <cover.1787240118.git.geert+renesas@glider.be>
References: <cover.1787240118.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Aug 2026 12:07:29 +0200 Geert Uytterhoeven wrote:
>  drivers/net/ethernet/cadence/macb_main.c | 2 +-
>  drivers/net/mdio/mdio-mux-meson-g12a.c   | 2 +-
>  drivers/net/phy/air_en8811h.c            | 4 ++--

Hi Geert!

Unfortunately we don't queue -next patches during the merge window,
you'll have to repsot.
-- 
pw-bot: defer
