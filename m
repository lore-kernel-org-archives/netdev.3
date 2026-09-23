Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ABE481255;
	Wed, 23 Sep 2026 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176597; cv=none; b=RVUqxkPL+rHPdWtW3zQ7odF7AikSxHTYpS2rO/3+Z+rvDifnRvVzl4NFxUrll/5X+1Tgv2lCRn+4+X9nSEXGDEIFFis1mkchv66XdarvfC9SYBCK8HqfXERjW6S/mL5hkGYNdST+z6cQEagrmtCamtGph4h9JbSo8Z007VBQlXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176597; c=relaxed/simple;
	bh=05dlzMt6G88nV3zR2PPD19DDLvKz4gMdaNvj7ZzU0lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+0vXmzdTWFQDySaIDU5NjdJBT1SNjhsOywvqze7vBdKOX4YTxk6L2udtt6qaITl8jO6suzsRAw+7oP0lScy+oi0pfgvItTQFWz3j5Um38i2xlEKS8SEImnSxATPjxWcBzczz506D+lda9fIeu9DtVlLJDHaZVv16xLy078GSIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mAps+FK/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mAps+FK/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DpKeGCK87szjoNyGISCstPHlTshXz1Y1JnVLiGLvX08=; b=mAps+FK/IKHLGJ6ryyNEBZvMiy
	bcob3AzJv2CKb4NGjVgsMdiqL88mKJMrEMrOitydGxlvnFVAH7TAL0K0g5ZmX0seI42XjRW1qWwFs
	9Z2qzk2hlUukq5g+5UsTbSlX/yXgea5nXAmrpo2fjnbSub8+8MUOwkdr6Ko4Dq9tAF7Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9OhO-006pZU-S5; Wed, 23 Sep 2026 17:15:54 +0200
Date: Wed, 23 Sep 2026 17:15:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
Cc: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
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
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Shawn Guo <shengchao.guo@oss.qualcomm.com>,
	Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Subject: Re: [PATCH RFC net-next 0/9] net: introduce Qualcomm XPCS support
 and add Nord Ethernet plumbing
Message-ID: <5e6dc1ec-3602-4cbf-95e8-58e2b94feed9@lunn.ch>
References: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
 <CAFkd8hsUzJEsDYjGSM3tsJzzwByuEkA+G4k1c75uYD-y5qU3iA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFkd8hsUzJEsDYjGSM3tsJzzwByuEkA+G4k1c75uYD-y5qU3iA@mail.gmail.com>

> Good Job, Mohd
> 
> Tested-by: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
> 
> Tested on both IQ10 RRD and Ride

Thanks for testing, but its a bit early yet. You might want to wait
until we get to version 5 or more, and it is no longer RFC, code the
author no longer is requesting comments on but is Mainline Linux
production quality. And after the AI reviews have stopped pointing out
issues.  Only then does a tested-by: make any real sense.

Reporting your test results internally is probably appreciated as the
patchset goes through revisions.

	 Andrew
