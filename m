Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ED051615B;
	Wed, 23 Sep 2026 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188565; cv=none; b=ds/vfYzGUo2nycK/npTY+LYoZ2WHzrHzrTcuHuOgb5WWS5nUYhQdJpJk5ZTDQrj5594f6otDChbIyoF8bIbYM7YwXDuIbrs3/KHgH0eiUyugSmI2qDlGaT4bAvrymf6GvnqiBJ3VAfwYdYjURPylxfAM7YEUGkN+LCfVlQ3bO2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188565; c=relaxed/simple;
	bh=q4HUdbYJbdNB46N8Hk+HNN2RCzv/8hW08osPcRdAG/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSSjMFto4Znz8rk67zEjWxhREemzRHmfLFV1ILk9yta+Ncf4LPF9cJ85by/Ci37QaJ/hXFY+sRSraGGVAH7/4weAJeVR7jgn6HH1r+2NbCZXzRrFjcvcN6YDAE63xslEupxVdNio5GMPNLtnQJBm5rN+ZNZHqFrikEVE7JeIRdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iKAwokD+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iKAwokD+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HXJnRJRTxgy4hjZ9q9bU+112uVIymJuRU1zRdHwHYCA=; b=iKAwokD+QZzNxHtib6CZO8slHG
	6a9ePUyZsbIPtW4/T3Hab0cy186YRSmwntzxMx+VRURlU6Th6lfT0b1Edbcu5hCNQ8o5Pr7O1g/fL
	YVecv794yM7XumvEu6aApqdRlWO1ZAkKj9lIr256PTNsIDLQDqJgD6ow4XnRUe3XWAeI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9Rod-006r79-Tp; Wed, 23 Sep 2026 20:35:35 +0200
Date: Wed, 23 Sep 2026 20:35:35 +0200
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
Message-ID: <ca67076e-3877-49ca-8c67-a6dc1b70e667@lunn.ch>
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

> Non-existent MMDs
> -----------------
> Returning 0xffff on reads and silently discarding writes is what a
> floating bus / unimplemented feature looks like, so I agree with that
> direction. My pcs-xpcs-rk does the same.

Did you read 802.3?

  45.2:

  If a device supports the MDIO interface it shall respond to all
  possible register addresses for the device and return a value of
  zero for undefined and unsupported registers. Writes to undefined
  registers and read-only registers shall have no effect. The
  operation of an MMD shall not be affected by writes to reserved and
  unsupported register bits, and such register bits shall return a
  value of zero when read.

This is what i was commenting about in my review, returning EOPNOTSUPP
is not correct according to the standard.

	Andrew
