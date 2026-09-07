Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F973AEF35;
	Mon,  7 Sep 2026 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788801783; cv=none; b=s0012/U4i/2DLvdfy1rqG4T1EKxclJyjd4nP9u61Dvu9peXGgrIzatkFIgxbUpTz+SVtym3UvrkW9SqkjeJyu9a2JUSs3F6LdfwnpxhxmoqY1/dSGRIN3lCfFImz6/IlwvkWsrmQ0Xh9iwUUCbQFEoFEuKWC1PMcYwNr7S0H9Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788801783; c=relaxed/simple;
	bh=Arv9t87aDfZviQmkGYJRxKLs9nEJj7a0Gkqk0YVPb6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWk4dnXvI1Ijp37gs1ztjbHR7vbR0PHWKwU2T+WfQvSXwhY7Hg8jThNkHW8bd9siFFifp7PWhbUK/948+0ev+J8tHfQ+dSo0CatSneQp0P6amArbKouvwoFIL5NZJC+sroTUrPO6oQF7GO+NEzLyR5Bl+5uYC13baM2wE7OrtJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100)
	(envelope-from <daniel@makrotopia.org>)
	id 1x3d3W-000000004Ls-3Jk7;
	Mon, 07 Sep 2026 17:22:54 +0000
Date: Mon, 7 Sep 2026 18:22:48 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Jan Havran (Advantech Czech)" <havran.jan@email.cz>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/3] net: dsa: lantiq_gswip: SGMII/2500BASE-X and
 flow-control fixes
Message-ID: <ap7yeykTFK0nNbzz@makrotopia.org>
References: <20260907134818.16670-1-havran.jan@email.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907134818.16670-1-havran.jan@email.cz>

On Mon, Sep 07, 2026 at 03:48:15PM +0200, Jan Havran (Advantech Czech) wrote:
> This series fixes three issues in the lantiq_gswip / mxl-gsw1xx DSA driver
> found while bringing up a MaxLinear GSW145 over SGMII on a Marvell
> Armada 7040 board, with the switch CPU port running 2500BASE-X and the
> user ports at 1000BASE-T.
> 
> Patch 1 reorders the SerDes NCO clock-rate setup ahead of the SGMII shell
> reset. Without it, only the rate the switch was left at by the straps or
> the boot loader links up; the other rate comes up but forwards no traffic.
> 
> Patch 2 adds the missing SPEED_2500 case to gswip_port_set_speed(); without
> it the CPU port was forced to 10 Mbps at 2.5G link-up.
> 
> Patch 3 corrects the GSWIP_MDIO_PHY_FCONTX_EN field value (a typo present
> since the original vrx200 driver).
> 
> Tested on GSW145 hardware only. The register values are backed by the
> public GSW145 data sheet and by the driver's own field encoding; the
> xRX200/xRX300 data sheets are not public.
> 
> Jan Havran (Advantech Czech) (3):
>   net: dsa: mxl-gsw1xx: set SerDes NCO rate before SGMII reset
>   net: dsa: lantiq_gswip: handle SPEED_2500 in gswip_port_set_speed()
>   net: dsa: lantiq_gswip: fix GSWIP_MDIO_PHY_FCONTX_EN value

Thank you for taking care of this on a board which allows you to actually
test it -- on the reference platform I had to develop the driver with the
SerDes interface of the switch is hard-wired to an MxL86111 PHY, hence I
could never test 2500Base-X mode.

Whole series
Reviewed-by: Daniel Golle <daniel@makrotopia.org>
