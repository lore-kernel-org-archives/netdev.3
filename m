Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538A543935B;
	Tue, 13 Oct 2026 01:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791856696; cv=none; b=VwW/9TMZsRpPMYP969P0rKlvBzju46tBEfw6zkImSSifIjDFqn2t4vK9lZmmlcufqPJFctxtAOkcX+Zt6zjYoYp234XrLvcSMWdhC21zMyCanKH2fNcQXFqUwbTbCU9hPNRUiJMieJHZ970uaQyAPfmqNWurVq1QAyc/5YFj578=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791856696; c=relaxed/simple;
	bh=NLkExvZ7rh2FUr6aZ/Y++lMG+FhvZf8xgi+gU1Y5AWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4loxpmJsFR6YRvg70T/F36gD/IXTUNYFqOO7AZNDPqFOAnPUNfR+YHovJ/wyRcB6hZ9X5VwSSTQqCfftS2bFogzaqG6M4JcHbRvmdjr0N/TIem/YLx4laaXsBWyYdB5MD4ck/CiekMqACRQM1lFAI1U7BY7Udithq44c0gfmdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vTmnpUNp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vTmnpUNp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hFmuoA6evBfPn2bJzhqhtfZQ8H60rQOYeX2w8em5reA=; b=vTmnpUNpnAPu7VEAwU+2o4MReE
	WdDvqDn/rXBonzLmxLRuPHaXqSKKUT1/4PaiAiksoAorNriI5/DgrdLAKJ9wvuy5c8JDzVlDjDlr7
	Bqvc6NgWqSQzV5mZKwVwZXHV7mHbNbjvpESE4lqY90kkMbGQLm0A74ugFyaCJf0fnHPM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xGRmI-00AQeP-Hd; Tue, 13 Oct 2026 03:58:06 +0200
Date: Tue, 13 Oct 2026 03:58:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Frank <Frank.Sae@motor-comm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/3] net: phy: motorcomm: Add cable test
 support for internal YT861x PHYs
Message-ID: <3525a1d8-255d-4393-b4c8-250a9b27ebab@lunn.ch>
References: <20261009175936.428256-1-mmyangfl@gmail.com>
 <20261009175936.428256-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009175936.428256-4-mmyangfl@gmail.com>

On Sat, Oct 10, 2026 at 01:59:32AM +0800, David Yang wrote:
> Add TDR cable test support for the internal YT861x PHYs, reporting the
> per-pair result and the fault length.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
