Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F121A43B3D2;
	Thu, 23 Jul 2026 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815487; cv=none; b=gXVeJqVY4REMXYoDM/y6y+4B9TZK41/DTquzH9JJMOs50QVEsAq53ePzffe+Ica58XM2ylfT3S3y+4JIXNWIszGDIdUsrvOCrbD7ax4Q1m2ILsRWDHcd3xuttCRTOnhmuCT/RqywRYyKBfgHHkBexweqUMW3VyrsKxOo8Gah4UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815487; c=relaxed/simple;
	bh=QONQuC+cHsosjfdLXXq/A1Qe14XsjnKSP95qF/wt4Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MG8U8zdSVcTVlutIRTGjJff6/OM2MLxM8RD2guRqhk21K1h0ig96KEO0hmBBSMhmTmpOfVwp/yuREkMhleY2DNVLo6rI7qhYOkZCODCT+xN9CmfzUOs75Byio1VQlTBriWP8ihX8q5xFio7emMwZlFtAzSalL7aI0m8s2pzMA7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8028B1F000E9;
	Thu, 23 Jul 2026 14:04:40 +0000 (UTC)
Date: Thu, 23 Jul 2026 07:04:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>, Alexis
 =?UTF-8?B?TG90aG9yw6k=?= <alexis.lothore@bootlin.com>, Jan Petrous
 <jan.petrous@oss.nxp.com>, Heiko Stuebner <heiko@sntech.de>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Keguang Zhang
 <keguang.zhang@gmail.com>, Yao Zi <me@ziyao.cc>, Mohd Ayaan Anwar
 <mohd.anwar@oss.qualcomm.com>, Romain Gantois <romain.gantois@bootlin.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Drew Fustini
 <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei
 <wefu@redhat.com>, Inochi Amaoto <inochiama@gmail.com>, Emil Renner
 Berthing <kernel@esmil.dk>, Minda Chen <minda.chen@starfivetech.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-rockchip@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
 s32@nxp.com
Subject: Re: [PATCH net] MAINTAINERS: Add myself for stmmac ethernet driver
 maintainance
Message-ID: <20260723070438.69c158ba@kernel.org>
In-Reply-To: <20260722142125.1767689-1-maxime.chevallier@bootlin.com>
References: <20260722142125.1767689-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 16:21:24 +0200 Maxime Chevallier wrote:
> The stmmac driver based on Synopsys' dwmac IP is used in a very wide
> variety of SoCs and is currently very actively used and contributed to.
> 
> It has been orphaned in January 2025 after the previous maintainers
> became inactive, but Russell King was providing very valuable reviews
> and fixes for the driver at that point.
> 
> Now we're seeing more and more activity on the driver, but are lacking
> people to test and review contributions to both glue drivers as well as
> core stmmac code.
> 
> I have access to some variety of stmmac-based platforms such as socfpga
> CycloneV, imx8mp, some Allwinner SoCs and stm32mp1xx boards that I can
> run regression tests on, and I'm offering to step-up as a maintainer for
> driver, for the time being at least.
> 
> Let's hope other people will eventually join this effort.

Thanks a lot for taking this on :)
