Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885BE1A9F96;
	Sat,  5 Sep 2026 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788638408; cv=none; b=efDcSwhaPyBzcLtKlg3EbaFAZEk3T3X/OlN2h9lyeg4xVB41asaU6Gfyq6boXWnsA2QwHENGBTnep4z6BP5hmzIbVGDzzJxusecFTAdB7/bGN0x2+Imt2O8Kj8s+w+9WflD8mfnyCmxehOTn6ZSjpkj1lsY7CrNA1OY2ufBoAMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788638408; c=relaxed/simple;
	bh=uczvBChY7lQ+Oky6JcWrtsf+vIJAE+vyHgoT9Xgwfkw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1IrwuiQFfUQenfFLgZMBsoyG4V2xjwQ97+J/sfOMMvnM7O5swOPolLBjsowXY1tylkAMoJwAQM9VjdiNNcj8lgBbKdg0DDQVfAeKiyrlo/ZfVRN6sCnHw3BFcr257EE1YyVSEO7s+xHWTY65MhKEO7vfQb48jGatCOYeVS6XHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6DQlpP4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6DQlpP4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFD61F00A3A;
	Sat,  5 Sep 2026 20:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788638405;
	bh=63CDWArl34nC/nIG+OV+7OAhAy4+5URidIuMjWHPM2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=n6DQlpP46uM0WxUOQATB/man5UR6KwjpOp6XNghhqGYHbx4zJr+q9LGIpqpWALlP3
	 i8V/Gk90Hhf02ZjZ4n3+wcTLTI2TiceCY37ACOswayiuO6WYr9LoXkWZmVJ0rtqIis
	 O3g59j0xNI3Vl8qKUo9OgWnfhUHs0WMyvefa3IPXQX9QyQsy3nmb4YfU8WRaE3AuGp
	 26GV9TxyuWq9OnaFfdM+CnNwWpCeTZ2vRM6aBo57o0/afQRaeZ7OuMDOsWZiiuhsP3
	 OiFxfpMM+bvPjEC5CxAM4mqVdg2t9uH8nbyDuKD8Ka2e0tW4/noxA/X6WgU8mkIlvB
	 uwU5+9nGsySaw==
Date: Sat, 5 Sep 2026 13:00:02 -0700
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
 linux-phy@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next v3 00/10] net: pcs: add basic support for
 RK3568 XPCS
Message-ID: <20260905130002.554a167a@kernel.org>
In-Reply-To: <20260901150111.141037-1-coiaprant@gmail.com>
References: <20260901150111.141037-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Sep 2026 23:01:00 +0800 Coia Prant wrote:
> This series adds proper SGMII support for the Rockchip RK3568 SoC
> using the integrated Synopsys DesignWare XPCS, along with necessary
> fixes and refactoring in the stmmac core and XPCS driver.

Not sure if this was already reported but FTR this series
breaks allmodconfig build
-- 
pw-bot: cr
