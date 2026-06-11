Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70B223C8C7;
	Thu, 11 Jun 2026 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182352; cv=none; b=X5H0nF8TvccssbJXA9jfaD96Us86YgCp7B7atxDatdlsuAw4k28Pj3doPCESLPAACuGkErMe5Hr7uPOszZhTCkjSHUPk9hyIcwE01vpeqVc/1julvyT5KQ27TogbW8fTcVgRCjpm7W1zpqsL0KsXG0n5DgPZwXeCA3rN0KxZ+QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182352; c=relaxed/simple;
	bh=/+tXc+z2JushcI1YiVewkG5skjb4gKzsljOWJvYgdUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oH2rrIxQGJGa8YnjpsEfy9HcTFFWZgtZN5wNnWItp1ojZcfY0WYAZQBxt0HEwcqUa9Ot/DevEPAwuDeTeJILW9NEZPoVHSNXZfY4tFhx0qkHVjTSBH3hbGnst1JOqQt2RI2LvD8uVCU4bIxiSUa0HoEx+hBxekVxGyARn1G++Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uhAc/8sD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uhAc/8sD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=31VgQsFzFepavMOOxKoMWZGOpsqgkKg4iMLx2GTebx0=; b=uhAc/8sDXZ0PTkQw2QVMq3Q2BJ
	q3XJUJjftEE1IWsdQwlsN513seZYnBuzqqAGI+53DxxeHmBL4ipMmFPawHO6Z2WAXXYXktpRk5PfZ
	fW6txLg4pzVq3dvKbT4/IGK5kdBVpdRmtiTZDl7zv/8FwAZTdqhTnlPhjdF72KTjbjyA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wXetJ-0079pc-VT; Thu, 11 Jun 2026 14:52:13 +0200
Date: Thu, 11 Jun 2026 14:52:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: George Moussalem <george.moussalem@outlook.com>,
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 4/4] net: phy: at803x: add RX and TX clock management
 for IPQ5018 PHY
Message-ID: <10f2c054-3d5e-4a80-adc8-2e63c655b3ae@lunn.ch>
References: <20260605-ipq5018-gephy-clocks-v3-0-f232d9ca0966@outlook.com>
 <20260605-ipq5018-gephy-clocks-v3-4-f232d9ca0966@outlook.com>
 <36cd63f4-749e-4b09-b8a6-cbf6924dea88@lunn.ch>
 <SN7PR19MB673634FEEF98FB8BCBBB15979D112@SN7PR19MB6736.namprd19.prod.outlook.com>
 <471a21f2-7ab0-410c-861d-5722a94b127d@lunn.ch>
 <SN7PR19MB67363B4F852FB37071637A299D112@SN7PR19MB6736.namprd19.prod.outlook.com>
 <afdced5b-73b9-4214-a94a-c13fadd39dce@lunn.ch>
 <f492327c-7ee1-443f-bb11-b78af0eda207@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f492327c-7ee1-443f-bb11-b78af0eda207@oss.qualcomm.com>

> Is there any prior art wrt enabling/disabling the PHYs (not necessarily
> clocks specifically, but say power supplies) at runtime?
> A quick grep only points to this very driver, which gets the regulator
> during probe, enables it and never turns it off

Not really. PHYs which care about power do their own power
management. They can sense the line and know if there is anything
plugged in the other end, and only then enable parts of the PHY. The
difference between an active and sleeping 1G PHY should be around 1
Watt. I don't think you will save too much more by turning off the
clocks.

	Andrew
