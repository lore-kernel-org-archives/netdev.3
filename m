Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656EC471CE4;
	Tue, 29 Sep 2026 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790713772; cv=none; b=TLLRvkaulE5bOP4cRyIJnIporW7gdmyLa8Jlm2GdBCJwPWO4Fa66rYj46lyvOEn87Nl+e7BWxCIvrOWj3aS+uNdt+khukcbHKJR9miIH8UmA/BMrlHcu/fMKETtK9KpE7SJZPt7ZQTV+VcXJGkXGWpikSt+cxYY3qzUYmEnCkbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790713772; c=relaxed/simple;
	bh=xSvW9udmZyzj8NC+S5ap+ZZirj1j3Hj1v0J1GV1rEj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmA7vOYB9W+8cq5EAVZCpEiduIcFo2D3wgln85OgHKBIi5Ub7WWI8In9Ay7LDfer0SVKWNqDGpiuERa6RAqngCaSn3Ikj+avDzY+gP5ZPED328lB2iDEHY0LUZyaou5OzIIzDq1te/w9XgMffciLvjVNlL+OfBtDE1q7B6BKVUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yPfdCekB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yPfdCekB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qfgtS/3YR6scpKjdET977cAtpN9Rc4jD/Yqb7My/5vA=; b=yPfdCekBA5Kcq5J/6HSwIFdFQo
	SDnUZT/d8eApuGgo7Btq1y0HrEsVFqW2lss1toVaq8bAjnYxdQ+2qCwjwwKmdXjo99aUqBSeeR2v2
	NgPXtEgdl9KHgRFc9n2Q5L4s0uj/JBNCtRyg6wHCdWIZUOzGsgtXk9nwaYyCCztFdHYo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBeRu-0081vz-AK; Tue, 29 Sep 2026 22:29:14 +0200
Date: Tue, 29 Sep 2026 22:29:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Disable checksum insertion for XDP frame TX
Message-ID: <f0d8c25f-96e1-4da8-af6c-3286610338ba@lunn.ch>
References: <20260929121025.20821-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929121025.20821-1-jszhang@kernel.org>

On Tue, Sep 29, 2026 at 08:10:25PM +0800, Jisheng Zhang wrote:
> stmmac enables TX checksum insertion for XDP frames whenever the queue
> supports it. XDP frames carry no TX checksum offload request, so this
> can overwrite a checksum already present in the packet.
> 
> Pass false to stmmac_prepare_tx_desc() when transmitting an XDP frame
> so that the packet is sent with its checksum fields unchanged.

This seems odd to me.

If the frame contains a checksum, it is either correct, and the
hardware calculated one will come out the same, not an issue.  Or the
checksum in the frame is actually wrong, because the frame has got
mangled by eBPF before sending it out, and you want the hardware to
calculate the correct value.

What an i missing?

	Andrew
