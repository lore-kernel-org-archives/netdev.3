Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4294D90B0;
	Thu, 11 Jun 2026 20:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781211530; cv=none; b=SNEyoIckJnnRq0bM9ZB3M9zvVGTW+b52FoiScCHrfxKd8DQLKFSGRDt5xbSFOvJt0tMd3JkTq+PSTP9vLWMUQrolDP2yrMgYVDvGYV4rsxH213DAkf7RJnL9ZJj4mAkjImIH6gZZ3AWJHQC4zHRUIH3xA0cQPE5NpBOfiH0Sin8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781211530; c=relaxed/simple;
	bh=qzs2K+eGFfoUE1EQvP3/W3qLPdBEiGoEEtW9udKERuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhZadLo0OyEw9/JvpL5q5Yg0Dolk+OaEb7nj34JN6Z+JG6MkMm1MybB0F2QsiRYwLsGeeGsuhLDFDO9Urn9d1LCP6j5X6pqfniRy9nY2ZtkzkNC6Ig3NzAKGK7IfPzDchilY+Bh2tZttjqrA3XQbZ/X9iM8gug/6pLsw9Ccr/AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EGuNhWNC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EGuNhWNC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9CYtTs3ua4MECH7jN0VaU7QhxRXBtLb2/pQ4oJEDKIM=; b=EGuNhWNCIwuVlTjwiCWbQqN2yO
	/NDn054MxrgWxsupTnseHEurYMbsp8B9toB0CYtQEXZBGlZ5Hs+2FDSW7AgRXQdTjucN1xBXyGcsi
	k3TVe1Tqqs+HO10abUL/9XG93nLJKJBnyoay90B8hi0OooYLioHUCuCjG+dEHNmXQ9zM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wXmU3-007EYI-Tk; Thu, 11 Jun 2026 22:58:39 +0200
Date: Thu, 11 Jun 2026 22:58:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 7/9] arm64: dts: qcom: shikra-cqm-evk: Enable
 ethernet0
Message-ID: <6fde35ce-52dd-4679-9952-728b6553b843@lunn.ch>
References: <20260612-shikra_ethernet-v1-0-f0f4a1d19929@oss.qualcomm.com>
 <20260612-shikra_ethernet-v1-7-f0f4a1d19929@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612-shikra_ethernet-v1-7-f0f4a1d19929@oss.qualcomm.com>

> +		ethphy0: ethernet-phy@7 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <7>;
> +			reset-gpios = <&tlmm 135 GPIO_ACTIVE_LOW>;
> +			reset-assert-us = <10000>;
> +			reset-deassert-us = <50000>;
> +			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> +			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;

Are these two needed? It should default to 2ns, since that is what the
RGMII standard says the delay should be.

	Andrew
