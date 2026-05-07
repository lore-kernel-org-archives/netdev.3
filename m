Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B29372B23;
	Thu,  7 May 2026 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157736; cv=none; b=q2CY4QkI543Uf5SWyeb9jwQNQwSELAiTDjVGgsMqnuCr5jFh2cW4M19gw3H8Ey99IYGpCXy53ptrYGUVJiDdAhCQ9hSwF+EBSQJF7mz0TaXU17SpwOdZ9pdVyu1mWGf72MXVKVLuqFs01xQ33P50PuFIgDOAwEtSBPPxCBK6zzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157736; c=relaxed/simple;
	bh=URA02KwjTJEGBx4rCRLzVlwT+9oixNNuaVAA5l7Z7YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lozg8I/XlzWS/g+yx23+0wuOpCWmKLVXyws/W3U9uG/4yrL66Mmr2rFV8Uq8lPy7eJjr/0ip16xxU3YAYZZ1zX6Th6k129NEyOvqRuqDGM8mrDZ9tF2kiUS+jBtqqOZ040Uvzr2KBnHUcpo8S/Nqae3G8EpQB+wzcycGdsOnpFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=c593q9x2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="c593q9x2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6Ourvj2gy9WcsFR16R5kadXRSlzivDujIwrNsP/U+vo=; b=c593q9x2L5mfrcnUwUt/92fJDo
	2g9xlWV62o0rfpvU3z4hBFmaeyYg32cboG9jSq7I8Vc824SN4EYlX5ti+iLr5aKgGI517bkvWTupQ
	wMB8o+qrYwV8WW8O7bkVI4S6FAnCkDAyrfKlywYSt5UkCzvM+4vGsQZmifwV76bEhxRY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKy3K-001oO5-D7; Thu, 07 May 2026 14:42:06 +0200
Date: Thu, 7 May 2026 14:42:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org
Subject: Re: [net-next v3 5/5] net: stmmac: starfive: Add
 STMMAC_FLAG_SPH_DISABLE flag
Message-ID: <1f4765bb-cdd3-412d-a341-cb76709c8ce6@lunn.ch>
References: <20260507094115.8355-1-minda.chen@starfivetech.com>
 <20260507094115.8355-6-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507094115.8355-6-minda.chen@starfivetech.com>

On Thu, May 07, 2026 at 05:41:15PM +0800, Minda Chen wrote:
> Add default disable split header flag in all the starfive
> soc.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
