Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59360516144;
	Wed, 23 Sep 2026 12:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790165255; cv=none; b=kVn64DlVVtj6kAbEOjQMkLn042HJnR/4zwRocwQFEDMdKnietnpzu9oTea2DYNi4mZ+P0iyG96VkjRYX31Q7tK+faKwJTkJsSsHTetOJ87PiwgE7pfTZyUw6pYyhAzWtuMMVcVGLXJhkuKIFwz3Q2fADL0LvhfYGSz5zh/PLA4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790165255; c=relaxed/simple;
	bh=zeNCUAgPqeauNDOF2uFGpS5QxgR+E3ekuxJBeauYKHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQvQrbBzefyV0SrHfrDo/jbE1Pw6/Ud70SdwiGJpTvOWcU5VQ1/mmTHBmj8zFNIK4xgdH2SdlOqjkKtMRZ7iON05pkp81UcXYrPGXMGLvruLA00AjU0lCAr00cy/TXPLIKfjYfmB6xfN8R6m++TWV9aa8ek1CqrIIbdaSO/KWK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IRN44ooS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IRN44ooS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EAK2smec0sGpBh/YVftv5pYSh5pJeWG4AIykWvsLZu0=; b=IRN44ooSDxxsucQ8S7dmamUca8
	fpcZJDb4l9JgMusPXVSmjUEC0y2kkaP89A61I+XEUSmk8X3AqSWLjMn2x+krXG9niiOwoCt5vZx7H
	6jUk91duty+5roaiQXa3VewphnwDUgnYO8o3ibWEEY2a1rXh94fa4e0gZy/8smMW0Obw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9Lkh-006nMp-OI; Wed, 23 Sep 2026 14:07:07 +0200
Date: Wed, 23 Sep 2026 14:07:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
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
	Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>,
	Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Subject: Re: [PATCH RFC net-next 4/9] net: pcs: xpcs: add Qualcomm Nord
 platform support
Message-ID: <b7cab76a-c2f9-472a-bdde-162e1fcb5fd0@lunn.ch>
References: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
 <20260923-qcom_xpcs_nord_emac-v1-4-4b1c682af70f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-qcom_xpcs_nord_emac-v1-4-4b1c682af70f@oss.qualcomm.com>

On Wed, Sep 23, 2026 at 06:37:30AM +0530, Mohd Ayaan Anwar wrote:
> Qualcomm Nord exposes the DesignWare XPCS register blocks through
> separate direct-MMIO windows instead of the standard contiguous
> MMD/register layout. Add accessors that translate MMD accesses to the
> Nord windows:
> 
>   MMD 3 (PCS), standard registers: SR_XS at 0x0000

What does standard mean? 802.3 C45.2.3 defines registers 3.0 -
3.32767 as standardised. 

>   MMD 3 (PCS), vendor registers:   VR_XS at 0x2000

and 3.32768 - 3.65535 as vendor.

However, with a length of 0x2000, there is only space for 8192 of the
standardised registers, and 0x1000 gives 4096 vendor registers.

>   MMD 1 (PMA/PMD):                  SR_PMA at 0x3000
>   MMD 31 (VEND2), standard regs:    SR_MII at 0x4000

What do you mean by standard registers when talking about VEND2?

>   MMD 31 (VEND2), vendor registers: VR_MII at 0x5000

	Andrew
