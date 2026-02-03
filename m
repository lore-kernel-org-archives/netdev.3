Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7591E25F9;
	Tue,  3 Feb 2026 01:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770081239; cv=none; b=qYCd5cwBECybEln09gzvipG3T491J5zRflJog/PLINb7b+b/jiBHI9m7DWEhCT8vCvwIbL4TtDac7R0bocxn9mycA3/GEoyWR9zaVnQJBX+niyciRC1Z+CoiIK01t0Dm1FPjgEIGAZIEa1ZzqpVi2HPTV276nYxTJVRvzZNVJqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770081239; c=relaxed/simple;
	bh=SaJkrdt5k2anq2Urx8bRHPWyklckA/4xYEE5hJDDSgU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUe8mZLQWAGrLjWnpXAoVqTdUFDe94tfRemCnwijJRDBCmdLD7rzGyelCaeaw3n3tBIjt3gAl1M4JA+iWrMQ8IXmhxlhsgxmhmT6aNfOLOncftAUTGzQ8Gk12r1JTp9B3nhIXHnZkAFMXZG5zO8MLntEQIpndgZSvLQLv3Bl1zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKNPOKXk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKNPOKXk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F696C116C6;
	Tue,  3 Feb 2026 01:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770081239;
	bh=SaJkrdt5k2anq2Urx8bRHPWyklckA/4xYEE5hJDDSgU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MKNPOKXk6nE6ae8dgHfoMkC2fuHWgj35tCJuny4m1IzaeLKTJt8YR+P4vAFbqxpEw
	 O1lz5YEcMrtQd7GXLlUzEubVUUHSSZF2j2YWnV43RcSqv04ZlLSuYxYNYYKNzo8Jfl
	 c88VPqJoeJA+ICpzptdG3TJpIdEv479p6zitrXReSlVR07xbMEcyfl/w84TaTYFnLW
	 WIcWudRqvgglkoXywxfWYOD72U/DZSdFfKytZNGJwrSFozuEU/PDACAOAHinVAivCj
	 fbPieYd+ORrjxZ6nUTjbsMG9TlKaXxdhMEB13OdEjvNR76sDpRaGJztaLxFk5UwAKF
	 9Uamr29WXMgVA==
Date: Mon, 2 Feb 2026 17:13:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, OpenWrt
 Development List <openwrt-devel@lists.openwrt.org>, Daniel Golle
 <daniel@makrotopia.org>
Subject: Re: [PATCH v2 net-next] net: lantiq_etop: remove driver
Message-ID: <20260202171357.0e4a9e38@kernel.org>
In-Reply-To: <73f3ea5f-57ed-40b1-9acb-ab595083aab6@gmail.com>
References: <73f3ea5f-57ed-40b1-9acb-ab595083aab6@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2026 17:40:49 +0100 Heiner Kallweit wrote:
>  arch/mips/configs/xway_defconfig              |   1 -
>  .../include/asm/mach-lantiq/lantiq_platform.h |  18 -
>  drivers/net/ethernet/Kconfig                  |   6 -
>  drivers/net/ethernet/Makefile                 |   1 -
>  drivers/net/ethernet/lantiq_etop.c            | 745 ------------------
>  5 files changed, 771 deletions(-)
>  delete mode 100644 arch/mips/include/asm/mach-lantiq/lantiq_platform.h
>  delete mode 100644 drivers/net/ethernet/lantiq_etop.c

Also Documentation/devicetree/bindings/net/lantiq,etop-xway.yaml ?
and arch/mips/boot/dts/lantiq/danube_easy50712.dts but that needs 
to go via the MIPS tree
-- 
pw-bot: cr
