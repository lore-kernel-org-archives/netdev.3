Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B293B6C00;
	Fri, 16 Oct 2026 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792184694; cv=none; b=JUd8SUnhMoI7CHcVJQ+KiWuj400wxgVjdKtvNG96WLsWwbnDsTYqUfkooejTCivnSslsdJwY8HgoDkQpZo1/gBmJmpHyxqBalsxmcacvzX+uPHy+w2thFTOQPOElb3Do0gw5CGc+vx4YfNd9LKqw3l6cjUSZHNP7ChxbfAFBszc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792184694; c=relaxed/simple;
	bh=ZGp+J06eERhRbOHAuPLv1b9Eu2kgbyfRFp8n1/qjoj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnxLpHLFb1zLLbxTPiXYI7KWX2kuIyAC4yY9CsR0MfLnG8NmQrBJgX3PAQZ5pGumfwYD24UGbwdPku3KIupH2YcBOTn3rR6aPDiYqQPeMsxKP97403iEZMe4h57fQ6NQjqJKMkUNBoYjJl9v2VNd0uY4kkbHSVFzaFm3+tbDz9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=y69Ss/Lx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="y69Ss/Lx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hhV8CmkcUTV2PD33TUL5A3kJzfshn1FwvWO3Wmasnbo=; b=y69Ss/LxionSAElhMqlyZTdaV0
	1oo75Oze4HPzbpF9sfOcr485iiA2gNMKTh3rpyEQ0yzAJkPtU42y2S/DFxFh3JQbXIGOfeSIVgVtT
	Fncbuju8VxcFYBDLsto0KIQoOyMfeBSDJFCBNISADusRNcOejOe4OYXb2hIttiN7x/Mk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xHp6V-00BE28-43; Fri, 16 Oct 2026 23:04:39 +0200
Date: Fri, 16 Oct 2026 23:04:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/6] net: ftgmac100: Add AST2700 upper DMA
 address support
Message-ID: <2f0b9424-b9d0-488d-872a-9bfc205c3e46@lunn.ch>
References: <20261015-support_ast2700-v3-0-8d7999171ac4@aspeedtech.com>
 <20261015-support_ast2700-v3-5-8d7999171ac4@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-support_ast2700-v3-5-8d7999171ac4@aspeedtech.com>

On Thu, Oct 15, 2026 at 02:46:57PM +0800, Jacky Chou wrote:
> Program the high RX and TX descriptor ring base registers and carry the
> upper DMA address bits in RX and TX descriptors. Rebuild full buffer DMA
> addresses in a 64-bit type before unmapping them so bits 34:32 are not
> lost to 32-bit arithmetic.
> 
> The descriptor format provides three upper buffer address bits, so
> request a 35-bit DMA mask instead of advertising an address range that
> the hardware cannot encode. Gate all extended address handling with a
> match-data quirk so older register layouts remain untouched and later
> compatible controllers can opt into the same capability.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
