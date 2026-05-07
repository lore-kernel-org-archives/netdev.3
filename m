Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E573B7779;
	Thu,  7 May 2026 12:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157122; cv=none; b=jUFQSEO/isY86T3FZWrd1LFNS91reFJX5PPJWTpKJVo0QaaAL4nhmwWB8cVRxuCRYsD1+5BnNErdxgWAO0gFjnwwSzwo/MzaWM0oYdH+Jt+hrpczQFP496Hx496ChwU+XeIlVsHyVkVrNZWj0bJF/M4UCOTEYoJvRAPGzpL+jUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157122; c=relaxed/simple;
	bh=P+Wu9uXpjLxayHEv/9p76ytZiBYfa8Q+8JejxJzxJxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMuWMWgnRYmhWlE/R7pv6nh7wfvM87FEziPM2pgMPL1rwmUDqf6di1+lK3aE9bOUx/mFwlQLCRuWj+F5Prq/ZhsQ6drSqCnH2UFR1hsSLgPl+OyPwXtHdwX0Dr8pOJo7lnLIwvZBa5IzvjPeCJme/XaaLd7ezeVImpnNyNyxLsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LoAC+u+A; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LoAC+u+A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QStBV4W/pFnq/ao0e1zo+1+UEG6Ckm37ySwTjsU3SW0=; b=LoAC+u+AbD4EyAy6pfbLNwSxfh
	hvE4gmuwNIQu0YrWp51VpNqTrWYT9ZEFDOqahyrjWORZ15HbnJNimN+NlQexc3NTFcOPPaHb5ENMK
	qqdz794vGp7y4dcuo/wA/GT7GzdaS0h6/J80AgZ8gTzsyVjPSTRtM1e66anjrTgu/5Yk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKxtN-001oJ7-7Q; Thu, 07 May 2026 14:31:49 +0200
Date: Thu, 7 May 2026 14:31:49 +0200
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
Subject: Re: [net-next v3 1/5] dt-bindings: net: starfive,jh7110-dwmac:
 Remove jh8100
Message-ID: <f62157c0-9472-4fbd-9cbd-d8ad9d79cc71@lunn.ch>
References: <20260507094115.8355-1-minda.chen@starfivetech.com>
 <20260507094115.8355-2-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507094115.8355-2-minda.chen@starfivetech.com>

On Thu, May 07, 2026 at 05:41:11PM +0800, Minda Chen wrote:
> Remove jh8100 dt-bindings because do not support it now.
> StarFive have stopped jh8100 developing and will not release
> it outside.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
