Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949EB4EDCD0;
	Mon, 28 Sep 2026 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614482; cv=none; b=g5O1oCbg4eZaidjmtCXCkNf2MVOOIju8rQR9oNxmgwRNZMiVM6O7PnRpb+J174pCnM8qqtSxXtMJTqgUL8r8naulSJMM6k50oGYDz+PqIoIEXvO6KaV1gMrKd1uR1XgW5aVVWa6Ja6ho15BrwEMphDC0DHeK1yCQalYHJfApVFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614482; c=relaxed/simple;
	bh=DSsk71VprfafNF9kKHe/Narq/qAqoaKWhuKUJK5T6cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeJQRt0qI4mCjjBAdwUgSxETMlrK81o3QQTIwDxvP6udceJKwbJjHi9tfUHflghqZr6BxDlgvbmfjoIpYBLCSiNfP65wwbSGFaF1oej44ObJHdlmTrGFi33qW/DZDXvIgfGXrotQU4roiqdIeyzMqNo6hQjP38heXjdzD3GHBBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pPD2uaEb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pPD2uaEb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VW9yaNTv+ttssgIZFzBXSDWu7kCm5A0VUUTN7itbtnA=; b=pPD2uaEbLelXl2vKpWRuXP9YGT
	GfncToImgx9fG+yhhkvjXrZshb5X1erB0adOxib/4FoZWNac95Tt6qzzfKxUAtd4eEL3emPWpEc08
	p8TTfqVd8u5jie/qP4hTEDy/68rTTTnTkpwjWOpMo+L7zyxeRgwwqDTLYTQlRlNAN1TI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBEcW-007kzV-W2; Mon, 28 Sep 2026 18:54:28 +0200
Date: Mon, 28 Sep 2026 18:54:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: Conor Dooley <conor@kernel.org>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	Frank.Sae@motor-comm.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
	jianmin.wang@motor-comm.com, jie.han@motor-comm.com
Subject: Re: [PATCH net-next v21 1/3] dt-bindings: net: Document Motorcomm
 YT8824 PHY package
Message-ID: <648ae914-e116-4417-87c7-5726e63fc6d9@lunn.ch>
References: <20260924075048.4060414-1-kyle.switch@motor-comm.com>
 <20260924075048.4060414-2-kyle.switch@motor-comm.com>
 <20260924-vowed-roulette-abda42cec444@spud>
 <c78999ec-82c5-4719-9358-5dbded43ccdf@lunn.ch>
 <415c6c1c-f59e-41c7-9045-22f20408a7f2@motor-comm.com>
 <34fc057d-17e2-4693-971a-63898708545a@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34fc057d-17e2-4693-971a-63898708545a@motor-comm.com>

> What we're trying to express here is simply whether it's a phy8824 built
> into the switch or
> 
> a standalone phy8824. In both scenarios, there is one 10G serdes outputting
> four UTPs,
> 
> and the only difference is that some operations are slightly different, such
> as soft reset,

If it is a different PHY, it should have a different ID value in
registers 2 and 3.

> power down, and power up. How should these two types be defined and
> identified?

More details needed. Why does it need a different soft reset? Why is
power up/down different?

	Andrew
