Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CB442BC4E;
	Tue, 14 Jul 2026 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784064551; cv=none; b=IeOeEhRDY19upSt9wyu0U7D/BWM5HxBFdxlv6uNQ2DMht9DKZ3ZoiFgDqoNNs0jqBnse3DKL3pl9uCwFGg+lVERoyuHQ3h9NYtAnYfnjbib7QvYIUG2hq5fiMyfhCmBZbrHwhSmhd7miWECCZLNR6AMbGA+5iYGm6SHL0GVnssc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784064551; c=relaxed/simple;
	bh=Bpvtk1w8wV8HWIFOpcV3in5/WC4GIMCY5VMMG9umu/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FriSfJX9RvVhEX1FyAOhP2X+LOo/wT29JXgkvrAPsGEgPo+3YVA88sCighGeowf3tdRhsS1DVtbm4JXMsxD/11hM5nXLyessufNcr4plaui7is7snQy1ajm846zKd+sqDVTvC8wIDIaJyBpExmoBefpMiw9ZmxdFTo4qNdKuYyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sBpwKpI7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sBpwKpI7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tGonvPPlDGQZ4gzGaAE5ONSL7R/+KJFUYJM5k/cS46A=; b=sBpwKpI7EB9v8CROH/LRfco+iW
	04q83SalkG4SzKJq5Y6lOM6Y5Ph3R9GqWrP71Bgme1bRNzE1eif+HWXamTSUrO6Ewkk+ARsFV+3R5
	q8+5F7JXfSgz3qbvH1wqP52qfhLRuPaITFt6ozWpdNhdhhKq8OOx8WkPw8VkgUMQWa8c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wjkgW-00CFjP-P4; Tue, 14 Jul 2026 23:29:00 +0200
Date: Tue, 14 Jul 2026 23:29:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Liu Changjie <liucj1228@outlook.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: phy: Add Maxio MAE0621A support
Message-ID: <c03931fb-019d-42d7-99aa-f2d97fb97660@lunn.ch>
References: <MN0PR19MB6091CD5A84D2DA5DACF434DAACF92@MN0PR19MB6091.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR19MB6091CD5A84D2DA5DACF434DAACF92@MN0PR19MB6091.namprd19.prod.outlook.com>

> Hardware tests with the 125 MHz setting:
> - 1 Gbit/s, full duplex link negotiation

What happens when 100Mbps or 10Mbps is negotiated? Has that been
tested?

	Andrew
