Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433F126E708;
	Wed, 25 Feb 2026 01:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983770; cv=none; b=F9ahWSqJ21ft8wffzZjTj79dZp53x01ZUu4oGHv1XGmSnB5pAU1JGRntxCL1Tg4w9KObs3Q5mvRmx9R/VESsKtYOl5ZZZsp6DFbCzl/HnUWbleqMbx2RlWgnBdxm2Fr9TlplLXF+Va1QJpNNXTiEa50T5PXfXdPnvy1/hhg7+Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983770; c=relaxed/simple;
	bh=/qQjUHwquTb5CtLX9o/HbDuVUMkNhBPNqviYoX0oBfw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ScKefGvqutiZeNQdpAgV/G/jD7KF25U2Hfl2cISFiydn/421jjNwOEenHmlPsXk/mKhf09vJxJrL/pTVPbOAxQ/yVNalPCUYVOl3b+tVfrN0Qb31YO9y36Sa8bJrL/ewwqSnjYb3h/qh9ncNSoJZkB6fbfq3uXFZA2gwYFlGd8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEkcb6Tu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEkcb6Tu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F808C116D0;
	Wed, 25 Feb 2026 01:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771983770;
	bh=/qQjUHwquTb5CtLX9o/HbDuVUMkNhBPNqviYoX0oBfw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QEkcb6Tuc0iKl2UxCSmBYbFxw6qntU3lrFUzz4BKQxVoE9/YYNWT13kCfD4+AhcOF
	 RNXlrph3ieqUNHcte7QZ87XLh2tsRGENgva3thu2q/nkJRKuE3q47jCIQkliGFm9Kv
	 sq1FfjwOOVMorQuiiicy7NWc1w2BvMPUqQIcQcGupVdgQ0pq4njJEbLAlx48vxgerr
	 oDaAVWjutWpizzMEuTlc7KgWABpP9CPrjhDQZjss2qV13HhaoTuiHE2Hz6J7E/FEQ8
	 7QThnNxxgGnhXAJSuXnN/ZYqUgNHMSLtIm2nrpf2ZPVoLDIE++SerUtJdGBy+OCh6J
	 fenqV6kLKwnuA==
Date: Tue, 24 Feb 2026 17:42:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Frank
 Li <Frank.Li@nxp.com>, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Mohd Ayaan Anwar
 <mohd.anwar@oss.qualcomm.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH net-next 08/10] net: stmmac: qcom-ethqos: use phy
 interface mode for inband
Message-ID: <20260224174248.09dd1cbe@kernel.org>
In-Reply-To: <aZ5QmRjp_78ZT_Az@shell.armlinux.org.uk>
References: <aZwfAFJQcp9f0niI@shell.armlinux.org.uk>
	<E1vuSL5-0000000AScX-2wuM@rmk-PC.armlinux.org.uk>
	<20260224171052.27bebff0@kernel.org>
	<aZ5QmRjp_78ZT_Az@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Feb 2026 01:30:01 +0000 Russell King (Oracle) wrote:
> It doesn't. The code ends up as:
> 
> 	switch (speed) {
> 	case SPEED_2500:
> 	case SPEED_1000:
> 		rgmii_setmask(ethqos, RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
> 			      RGMII_IO_MACRO_CONFIG2);
> 		break;

SMH, sorry for the noise..
