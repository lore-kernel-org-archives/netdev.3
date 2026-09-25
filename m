Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEAC3E559A;
	Fri, 25 Sep 2026 23:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790378673; cv=none; b=T1Wdnht82ppUWKGQfI5DjLc7LfvzcbEZ9jMt+Ubuh4h/BkFPYROOEhEwi+m0nlTFCbjj9j1Q83v4Pq4j2Phy08W34Z+VAyq4WtqpHjQkmLxJnuu/AQqDFG9ie+hEwRb3atqHaWdISvlc84zycSjsUBS8bYf5tJmYl0InmStW57o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790378673; c=relaxed/simple;
	bh=o+pM+zrUJNkibvekj4uLAVaC9g9qFqeun2zv9Ixq1po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R40vPWBdv0w5fcSKoVDtI5JYyjbKVDOL+7iRX/BlnRtyhXOWLng+AbHkgtskptMBJ+GgXlmPHUv3xyzTJwthlf2xJZ5BQtANeC4BKTLomYbtJQddd0CzvXRDKFqpAgBVd0YDcN+U6O6gPkDTUWbkq9K/VE1PXhfmoS86H7QBrpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ek62hOk2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ek62hOk2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iT6QX+O7sw6uVIvNmdcKKCpfLXYghMQTaVawNpkGbrI=; b=Ek62hOk2ZxPgogYIqqs7F64EKD
	OM528zb0GPK1ZdrWDZw6PLUItBdtZnTUeTrdVG3QmnPSQHS+xGadoewRqhJnrpjvXoOXF5F1xFg9w
	n6nHyiB8qtKYTrsMz7sL8xUlJjsWCAtajRxy9z5NqMdiVzQqtp42PELHIeO4WajSDdqI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAFHD-007KFc-QB; Sat, 26 Sep 2026 01:24:23 +0200
Date: Sat, 26 Sep 2026 01:24:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH net-next v3 8/8] net: dsa: soce: Disable unsupported
 hardware STP
Message-ID: <ea1f498f-fce6-4e9b-8afb-10d16ac12f08@lunn.ch>
References: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
 <20260923-devel-vstrassheim-soce-dsa-ml-v3-8-ddebafcb9ba7@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-devel-vstrassheim-soce-dsa-ml-v3-8-ddebafcb9ba7@linutronix.de>

On Wed, Sep 23, 2026 at 12:39:35PM +0200, Vasilij Strassheim wrote:
> The driver does not implement hardware STP offloading yet.

What exactly do you mean by STP offload? Can it do the actual
protocol? No DSA switch can do that, we always use the software
implementation. I'm not even sure it is possible to offload the actual
protocol.

	Andrew
