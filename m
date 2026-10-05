Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AF03876BE;
	Mon,  5 Oct 2026 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791233982; cv=none; b=n4lnM/0rMUFCWY7bC9SzOUhdXCEqFGV+iOQOsw/vyUYNyBO8ihUYeunN3YKWwRXfilEe0DJXbz696K8sDnL5xluga3gNr1QVrRl66Y0bL0fhNIYvoEie4mRbPGg/nQKfsUDQn52VRmxosoCNW+svfpHuWci5TRebKVPDep7VnWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791233982; c=relaxed/simple;
	bh=mVWgfGZfotmXvsJphNGazrhH2AwQ7eNHb3tlBoti7d4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kHgroCkvOhVPKGq+KaBJIcag9l22yG52r9F+B4KURRjLdgv0+GeFRUY/1knRL4XWk1GgQQrPutGPFlTbem3wD7oJdharUTV7dkruCfbcWU2Q5deSAYSGsyUrNOe72rkuSwgxlIlAiaqOTKeYBgqfOdSkqqMLdgUMfGuEtt0WqJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3kTnT4a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3kTnT4a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2AF1F000FF;
	Mon,  5 Oct 2026 20:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791233981;
	bh=Hd4+5Wpltbd4UHs8m7Jg0BtmW4zxBsg77tDhADJx1qU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=B3kTnT4aYxXIrltShEqfO8pnc3XaIm0eVzw1o4Xekcf3wYgLM8ESzohQfGoVi9DQl
	 d7wzRQPMTuCXTB8C7AorKMNdpSCdH0VKdun7BqkR5lt+CYcmpz5SgB1h/fCFJbMBxq
	 5XpoVR08NsSPs8MBVZ/dk1sKIHqsX4DN5D182EBjT+taB9U3Hj/Nf7FC6WLJmX87vr
	 Ypl8i9d0hIMOyA/eQKwYHwcQEBlK1cNIPjuljt8kjkjQfF/PuNJrKLLSS4lRZbQBu7
	 kyVy07a+v8Rp8YIyd+UuAA2umIMXyFPTdjelr14S9l77O0YEZN/Lx6wDVNb8/pYxSj
	 K+WZMgH76ajqA==
Date: Mon, 5 Oct 2026 13:59:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Coia Prant <coiaprant@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Romain Gantois
 <romain.gantois@bootlin.com>, Heiner Kallweit <hkallweit1@gmail.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Russell King
 <linux@armlinux.org.uk>, Shawn Lin <shawn.lin@rock-chips.com>, David
 Heidelberg <david@ixit.cz>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next v10 03/11] phy: rockchip: naneng-combphy: add
 SGMII MAC selection for RK3568
Message-ID: <20261005135939.01ccde50@kernel.org>
In-Reply-To: <20260922200336.2201212-4-coiaprant@gmail.com>
References: <20260922200336.2201212-1-coiaprant@gmail.com>
	<20260922200336.2201212-4-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 04:03:27 +0800 Coia Prant wrote:
> On RK3568, the SGMII interface can be routed to either GMAC0 or
> GMAC1 via the GRF register pipe_sgmii_mac_sel.
> 
> Add support for this selection by introducing
> the "rockchip,sgmii-mac-sel" DT property.
> 
> From the RK3568 TRM (Part1, Page 229), the PIPE_GRF_XPCS_CON0
> bit 1 (pipe_sgmii_mac_sel) is defined as:
> 
>     0: SGMII routed to GMAC0
>     1: SGMII routed to GMAC1
> 
> The hardware reset value is 1 (GMAC1). If the property is set to 0,
> the driver routes SGMII to GMAC0; if set to 1 (or omitted), it
> remains at GMAC1.
> 
> This is necessary for boards such as the Ariaboard Photonicat, which
> uses the SGMII interface connected to GMAC0.
> 
> Out-of-range values are rejected by dtschema, so the driver does not
> duplicate the range check.

While looking thru the patches again I noticed this is changing generic
PHY. Maybe you can send it separately to Vinod? I don't see a hard
dependency? The code can "converge" during the merge window for the
whole thing to work.
