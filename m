Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE103BBFB6;
	Thu,  4 Jun 2026 22:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780612297; cv=none; b=SIgikro7J48nxpkGeXi7jWXT04Rz4S6tPOsGX2bVWNVsq/fcAnCYxjFqV+f0m6cTZuVgdTTuKR3F2rOjRmfxqsqnrKVw4Q2wDXDTfNHp9nFaBMzWwuv82aaMunr1Wk1fJaPOEekjpmVqe8zpZrv5xBz9Iig8mCh78aFgzNi2fpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780612297; c=relaxed/simple;
	bh=5HAtlgw5/Y7O7w6wpFMhAKspPS+xoUwCTIb4OZ8B1nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzU/QyeTbiH8i//rCBsBvFLDpoRDfqrqcU2rquvur+toWUKlOdpdzheNKs5cC4ViThK7jfWmYEAXyZRN6CxDnKHcEFE718SWxvq8Tj8vTT4Ow5krtsJLlZl7pDUN5NQ1VLUzDrBiYf8rTc6ycyVKgyD06d/+LZAdhvC3jg9muHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=K+WTlvB+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="K+WTlvB+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=+jIBNjlrd+8cBpesyOegY0Ulnp5mjGSHeu8lpw+r880=; b=K+
	WTlvB+tcexno4iGj1x0gIpyyUT39sI5jy5yJGiWkNkCHi8Prm7Eh4lMUZkclmARYN7NswZ7tzISc+
	hfEZR+GNqbevMRmUKnZRRTalgPToIEtMx6hSibeg9/TFiDZbfmMwwgKJOL/j0lFUdnxjOSyMUq4hd
	gzH6n7SvcmaTgeA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVGay-00678b-Mk; Fri, 05 Jun 2026 00:31:24 +0200
Date: Fri, 5 Jun 2026 00:31:24 +0200
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
Subject: Re: [PATCH net-next v3 09/13] net: ethernet: oa_tc6: Add new
 register address defines
Message-ID: <a113080e-44ae-4867-8414-14a1b1a3c7a9@lunn.ch>
References: <20260604-adin1140-driver-v3-0-5debdb3173c4@analog.com>
 <20260604-adin1140-driver-v3-9-5debdb3173c4@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260604-adin1140-driver-v3-9-5debdb3173c4@analog.com>

> +/* Vendor specific memory map. */
> +#define OA_TC6_VEND_MMS1			1

I'm not sure that is the best name. Table 6 calls it MAC. 10-15 are
listed as vendor specific. Ideally we want to avoid confusion between
MAC registers and other vendor registers. So maybe OA_TC6_MAC_MMS1?
That would fit the pattern:

/* PHY – Clause 45 registers memory map selector (MMS) as per table 6 in the
 * OPEN Alliance specification.
 */
#define OA_TC6_PHY_C45_PCS_MMS2                 2       /* MMD 3 */
#define OA_TC6_PHY_C45_PMA_PMD_MMS3             3       /* MMD 1 */
#define OA_TC6_PHY_C45_VS_PLCA_MMS4             4       /* MMD 31 */
#define OA_TC6_PHY_C45_AUTO_NEG_MMS5            5       /* MMD 7 */
#define OA_TC6_PHY_C45_POWER_UNIT_MMS6          6       /* MMD 13 */

I personally would generalise the comment here, and add it to this
list, so keeping everything together.

    Andrew
