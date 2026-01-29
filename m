Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBF2344D8B;
	Thu, 29 Jan 2026 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769705499; cv=none; b=Ci2Op4d1pht148HZLqaGSNxoeQf3mHsf/Yp0GZ2VUT7/X7g5Dk6OgCTKApPR0aKwTfhJYuNjK99F4WU+JcrX5o+JAjS020hdwwzmpnAdJlxfyp74m6ajWHhcwzK83WqWnUVVs9J6W2K8Zh9koc8v2ENf4EHzK4v8UL1uAKw4wvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769705499; c=relaxed/simple;
	bh=YmG0tgmvN9wkowhGDe7r72zqEn4bWMNuc4djbes+i7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utga5HU6IMBiqxIImyX4TKEmE2Ur3CV7vN2U6kIlF+RDqNyQKYYvJQeWus325qzIas2kjP2yjXx73IezdoQRbdumcrLmg75QT+/AbcasXB2BwbJ/hXBB1oHawsk7BMZP8I1Vl8XfmiS3GC5+QNThlEsuyyBi8fR9fSAHyQiwarw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jy4Ve4L/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jy4Ve4L/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFE4C4CEF7;
	Thu, 29 Jan 2026 16:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769705499;
	bh=YmG0tgmvN9wkowhGDe7r72zqEn4bWMNuc4djbes+i7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jy4Ve4L/V7YNRtTvddViMvmxnlxWUTQKwWlNePNOeOrXavOoH7mf49OSyoqQ3ijMF
	 d/33ZVs4f9pQdu+jNkHi/S+EkUF/vz5gNERyOpDO85sxJ7vfjRAYkyerehsq0EjGQn
	 FkZDdq/YJN7pzbXcsJFLBY1zlee9qe4RSa9scIabFDOX7Z4vU2NcsG/rRLwfVfbARf
	 0B3iuRRyhj7VSjkB/9hKwJSbYH+5R3/tBqCcyS+OyFXqGyM9OgnPZEtcpUHIBxli6W
	 gjNttqiQUS1PvNR+MYYRpI5bp/9PkHFraoZmJlovHyUY0N8b3FOJerc3B3ozR90hFS
	 cgJfiLsvNrxAg==
Date: Thu, 29 Jan 2026 10:51:38 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Cc: devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Matthias Brugger <mbrugger@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	NXP S32 Linux Team <s32@nxp.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Chester Lin <chester62515@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: net: nxp,s32-dwmac: Declare
 per-queue interrupts
Message-ID: <176970549762.1267513.768026318632683991.robh@kernel.org>
References: <20260128-dwmac_multi_irq-v4-0-82fa34fcf2f2@oss.nxp.com>
 <20260128-dwmac_multi_irq-v4-2-82fa34fcf2f2@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128-dwmac_multi_irq-v4-2-82fa34fcf2f2@oss.nxp.com>


On Wed, 28 Jan 2026 09:49:53 +0100, Jan Petrous (OSS) wrote:
> The DWMAC IP on NXP S32G/R SoCs has connected queue-based IRQ lines,
> set them to allow using Multi-IRQ mode.
> 
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> ---
>  .../devicetree/bindings/net/nxp,s32-dwmac.yaml     | 44 +++++++++++++++++++---
>  1 file changed, 39 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

