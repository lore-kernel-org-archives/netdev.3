Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87FE36E487;
	Mon,  6 Apr 2026 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775479707; cv=none; b=SQb+CaXLEBVRMqJEz5YEl+tV4BOA+vEIh2eE7dBp5jgMenlVSUOxcXN6vmcUyhKpmVS+KpSLK2rkK5QaMRL9d5E5xPiulnarARHas3Q1YLfyS2akuoaX07eDsffDV7k3IdbNYPvqltygT0ToYJpUfxd6M/ENMrjAJ3m8sn4om0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775479707; c=relaxed/simple;
	bh=thdk4scEbCEfjDTiEe0RV/ajU0uS958gF5HffrDyMpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVAvanmuLoaKVZ/7MazIPEbU49K6JOfBTv86hLKjRRBZnUQ4wmkYuq2FkZX0wFmhIUNXKF+vnxojVCFtrKvn8pYv6CWnFQ+ZznFonlPQWCankxTV53oIWliC4jwJFpjAQqlCDsYFwVPb/1YuzXD2D9qftlA7KSQoWVFcn/rlkMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w9jNG-000000005zN-34Rs;
	Mon, 06 Apr 2026 12:48:14 +0000
Date: Mon, 6 Apr 2026 13:48:11 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: John Pavlick <jspavlick@posteo.net>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sfp: add quirks for GPON ONT SFP sticks
Message-ID: <adOri4VEQl8ezm24@makrotopia.org>
References: <20260406114352.69168-1-jspavlick@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406114352.69168-1-jspavlick@posteo.net>

On Mon, Apr 06, 2026 at 11:44:05AM +0000, John Pavlick wrote:
> Several GPON ONT SFP sticks based on Realtek RTL960x report
> 1000BASE-LX at 1300MBd in their EEPROM but can operate at 2500base-X.
> On hosts with serdes fixed at 2.5Gbase-X (e.g. Banana Pi R3 / MT7986),
> the kernel rejects them with 'no common interface modes'.

While the quirks themselves may be correct, the statement above is wrong.
The BananaPi R3 (and all MediaTek router SoCs) *do* support also
1000Base-X and SGMII, the SerDes is *not* "fixed at 2.5GBase-X". This
can easily be verified by plugging a random 1Gbps SFP module into the
board (eg. ubiquitous copper modules based on Marvell 88E1111 PHY).

Also you have to make sure to not break support for those modules on
boards which do not support 2500Base-X and need the module to operate
at 1000Base-X (eg. older MikroTik QCA9xxx-based MIPS boards).
