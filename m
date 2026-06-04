Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D322EEE8A;
	Thu,  4 Jun 2026 22:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780611706; cv=none; b=peEcc4zeZzmagUkEyj58o6PAehuOoxKPqnlCD6fK9iXrBDFQU6+7R74edbvxQSFt3frov1M+Q+wkqPPRGy7DQyAivbpq0LVlM2+J0UQY8CQpKH2FBCkm+ueLLtW2ZDuSx7PUOUmaPnTme9EtbrIrvb/OAMwWVIokejLGLVHowD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780611706; c=relaxed/simple;
	bh=+CKgqB/YJkxILwT2ak7EQahmIG03A3cY1QsoiM2dDmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W18H/48eWBzi9gdwTxyvVWVwHQDPnP9Zp3eACqEW8T3PW7zgKLbIB93zpqiBw693ZUkpMdpnHKAydBYcGFDgiUJ9vKVkRFrXkxZgMgK1N7zhl4vYpJ52VKVR+U38/KamhmbLu4pDKO/6roDQyZcEz3baOQVlikH2+7dLdvF8WQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hqgNdtAm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hqgNdtAm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=i9r5Qdw+LqjvQBs7tLMu94QRtOhMM5/rtVdOPRFY20o=; b=hqgNdtAmtFIGPiqrJt6IsAdmVo
	ogWW7HavniFMta9cNFwQ2hCPlfVYWTm5WCRnT4vd/UA2qrN28msXaOtWHG52F16syQ5HZtAFMxDiU
	cSWDXznoGjQhdaIp652aVxvOVuB3R6zUOi1XCJBJgiDqZwgdiz0SSYnpShhTW5ep+X64=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVGRS-00673v-J5; Fri, 05 Jun 2026 00:21:34 +0200
Date: Fri, 5 Jun 2026 00:21:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: ciprian.regus@analog.com
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 07/13] net: ethernet: oa_tc6: Add
 read_mms/write_mms register access functions
Message-ID: <d74d15f6-cfe6-44b5-88d7-d4a4a163d208@lunn.ch>
References: <20260604-adin1140-driver-v3-0-5debdb3173c4@analog.com>
 <20260604-adin1140-driver-v3-7-5debdb3173c4@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604-adin1140-driver-v3-7-5debdb3173c4@analog.com>

> +#define OA_TC6_REG_ADDR_MASK		GENMASK(15, 0)

> +int oa_tc6_read_register_mms(struct oa_tc6 *tc6, u8 mms, u32 address,
> +			     u32 *value)

I think address should be a u16? That way the compiler will catch
anybody trying to pass an address which is too big.

    Andrew

---
pw-bot: cr
