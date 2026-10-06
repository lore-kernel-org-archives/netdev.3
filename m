Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93373B961F;
	Tue,  6 Oct 2026 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791289394; cv=none; b=YfxTMQtS/t83fsKUcIeqiJAXbGtrYpLo0/CT5hTfVMcnEd2zP3BmDfI3KjF6mSbZvFiLPULUC8/0aqSafBnXQHFsm8UnbiXNFqoDeaGMKBLXYf8/R6j2fsXTfw7ovbi1nGjMQ8YzDGXzosL5hE/OC3e1kK/sORIzH8af/FGFht8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791289394; c=relaxed/simple;
	bh=QsYPcCEk6x1kbtHzappODj4VvqYgWoRY8En1KdtdeLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeY+xpxSVEdnZBq4qqugEgrZW00dE7YHegYjCmIG++hmLm78bSeJeBR/aU//N9nQW2MNOPeT85i+/Fqtc6xl01hQkklU1SiNiJh69jU91YkoPaJKIG3ohPYp5SKGlCprXzAi67Cz4pw+c8rBOVCLV8iNbr3ZXSq1PJn/j3mdRr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=M1kvph3k; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M1kvph3k"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5C68xV8Rja2PPKQVWqPpRRB2YjUKB9zcUPjhhQEGBvA=; b=M1kvph3kamoWjwhBAOzvS/CKco
	pHChtN3euzSszMBRaLwmUHl35iEqN7W1EuktMaWslwRjyOqbJAfi4OMSOj5fr5WGJm7c+cwuUVy95
	Akp6K+v2j5Mx13lJdPGd/dw1OpDWEUQ0PnTpyBXqkQDxqt94jBaeZmdF+HnQ4EG+ioeU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xE4CB-009G4j-0E; Tue, 06 Oct 2026 14:22:59 +0200
Date: Tue, 6 Oct 2026 14:22:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani.Rajagopal@onsemi.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Piergiorgio Beruto <pier.beruto@onsemi.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Jerry Ray <jerry.ray@microchip.com>
Subject: Re: [PATCH net-next v8 03/11] net: ethernet: oa_tc6: Move oa_tc6.c
 to its own directory
Message-ID: <5ccd0967-989e-49e6-810d-d2500f531128@lunn.ch>
References: <20260928-s2500-mac-phy-support-v8-0-7e011aacc309@onsemi.com>
 <20260928-s2500-mac-phy-support-v8-3-7e011aacc309@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928-s2500-mac-phy-support-v8-3-7e011aacc309@onsemi.com>

On Mon, Sep 28, 2026 at 03:25:10PM -0700, Selvamani Rajagopal via B4 Relay wrote:
> From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> 
> Moving oa_tc6.c to its own directory, drivers/net/ethernet/oa_tc6. This
> will facilitate adding more files to support other features
> defined by OPEN Alliance 10BASE-T1x Serial Interface specification
> 
> This patch series is adding two files, one for hardware
> timestamp related functions and one for PTP related APIs.
> 
> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
