Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9C2549368;
	Wed, 23 Sep 2026 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188832; cv=none; b=bjMHuAItz8nUBRG/NIWSTxIUyks15RNNLc/jf5XnLAngUEsiLg5a9NO4fLMGY8s2ScBgxG7FV+/3UFIQTyk+z8VHF/w6PeltaP+Rz67Rqaq+mRxAC/unyGNTI555VuCHrRTKJIPdXEdepmiV1cZfoVTvXY4ViLvFVh1pR/6JqPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188832; c=relaxed/simple;
	bh=wCYU6kCsjbsft4QljuAJcwuTKbKPA5+QrGeSnX7f+Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogcmkJjfX8hcEsIV92AUKtKBcCTgVJV/ccSbiSdfApJmaP9CcDdl4j5t9Zz3FT1zQP4FSP3aT5oxYIKEyQ/x+TJ5NA96X7LiGglfPCfBwGY6pnotuJVFKlqNcp8yrKzQJC/PT1AWkqqMJssoyG28jafArUpQyES2RQxPgBNeGrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yhjkIJHl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yhjkIJHl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OrNV4RTSvEcp80MsSzY2H5C2CS5EoMlyA0T62CgMGog=; b=yhjkIJHlzT5HZm76/wauJUvG4J
	zvNPInWrpiIamTIHq+/4DT1d/lXMf7A7/5b180690PBD8CnvhmtRRjrI+J2t3/Q6qsC+G/hjveV0P
	saXb3BlBn6A9yKrlsmASrZaFqihFvzMGphAF2yhbbsTCnmchHhcABiH2b7aSpmkGf56o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9Rt1-006rEE-GC; Wed, 23 Sep 2026 20:40:07 +0200
Date: Wed, 23 Sep 2026 20:40:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Coia Prant <coiaprant@gmail.com>
Cc: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Richard Cochran <richardcochran@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	"Jose.Abreu@synopsys.com" <Jose.Abreu@synopsys.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Shawn Guo <shengchao.guo@oss.qualcomm.com>,
	Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>,
	Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Subject: Re: [PATCH RFC net-next 0/9] net: introduce Qualcomm XPCS support
 and add Nord Ethernet plumbing
Message-ID: <67d74ba3-e1f4-46df-b14e-9ccf06a72043@lunn.ch>
References: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
 <5135e15d-b6ac-476c-9a7d-b7d64e4eed5c@bootlin.com>
 <arOtU15iv5CWPUEu@oss.qualcomm.com>
 <CALj3r0gAaQ_CoS5_9Mmf5HY+Fu5_e74fbb+r0LstafMhagHx6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALj3r0gAaQ_CoS5_9Mmf5HY+Fu5_e74fbb+r0LstafMhagHx6A@mail.gmail.com>

> Would it make sense to take that route here? My pcs-xpcs-rk does the
> MMD redirection through a custom MDIO bus; maybe the Qualcomm glue can
> reuse that idea directly instead of extending pcs-xpcs-plat. Happy to
> help with the generic parts if that's useful.

I would be happy with a custom MDIO bus as well.

  Andrew
