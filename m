Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD183911BD;
	Wed, 23 Sep 2026 02:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790131815; cv=none; b=tmGEvLZ4deXpv96VlEg7NbckTZgOmGUjyNpmZf9k0Bp7J2e0He1tec6E+oRPn7n/zXj9ia3qm3pVshUqy/JhGNJVmZPRTkFxlhmBhdtBge5Rl1opGXdIGgMkNzC2U3RviisN7CtNIcN9F7qVDMAs1ObIBPxJTOHXQPj/H7mStOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790131815; c=relaxed/simple;
	bh=Eo5PNvzKKc4BFL3+MuJflE+BxX4YdcxoeglU+t5KwrY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAiQ9nIguO6aadAHiy5tMFKhVJKzaGcCQBOiqgosRbBcVFeCkYadJ4r2bVcuF90ZtP6z9AFcSBDN7c3TmA4//l64EsZPv1cpHqov8ObjUNnR2WdY0VYGE3jo3bAypDTesugs3Y49hbwxwHsi/NufSrGQ2smbALJGqHzndZrXEqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZQ5CORt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZQ5CORt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D221F000FF;
	Wed, 23 Sep 2026 02:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790131808;
	bh=Eo5PNvzKKc4BFL3+MuJflE+BxX4YdcxoeglU+t5KwrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JZQ5CORtA6ZeETmwbFwtxoC2CfxFDPqnS+RC7NQO9H6gNAWIrOqRx/Ufk0nd7fXBP
	 iDsMlkWUtzAnjAvlhBCUMNzhaXQ/vkFLbfx2lrBgDBLqshGRoPTToU+UzQECX2lS7O
	 3hOj1XpvCcXAc0DcB6YInNKaNEJ5699vb/l07V4BKzELxkLf2ZDEb+lTAyv47yBAPk
	 ZhJnVtJSnQx768X8qVjVvdmubkx3JubAP3KHc5ZiF9vbvUNSKMN0r/kGszo4Y/4OhV
	 aWR4snVHpOGntttMBDW8Y0zH6Od2jXwwQs9+77WD1uLLF6eFaDTxtom3jZjBRSsu18
	 oaCSP+Zmih2Ow==
Date: Tue, 22 Sep 2026 19:50:06 -0700
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
Subject: Re: [PATCH net-next v10 00/11] net: pcs: add basic support for
 RK3568 XPCS
Message-ID: <20260922195006.79890f24@kernel.org>
In-Reply-To: <20260922200336.2201212-1-coiaprant@gmail.com>
References: <20260922200336.2201212-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 04:03:24 +0800 Coia Prant wrote:
> This series adds proper SGMII support for the Rockchip RK3568 SoC
> using the integrated Synopsys DesignWare XPCS, along with necessary
> fixes and refactoring in the stmmac core and XPCS driver.

Please slow down with the reposts.
Not more than 2 a week, and please wait for the AI review to finish
and be published before you repost.
