Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5424399C4;
	Mon, 17 Aug 2026 17:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786987526; cv=none; b=MTOj3hu6kF0TynxOx3OXmJ/bpR0oHjL34G1Vtq+yAaNWNM6Osa//xBoO3jAxvH1nnOpOHeGsEC8grNBviOAXLAex7GLdTWooXfcaliKVAk466hC0aKWmPc/0muMz6twJ8GRRF+JCIsaTzYxdTOo3YjbZ/S07YHZCURYEi+3Bhy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786987526; c=relaxed/simple;
	bh=jcRI8Q++DJN+DUkXW3egMfQaW82OLU7I4H+HWfyQ9l4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FdO11Nwf5vwxDrhgD0hETCHr1CZHTSbMSL1nTazlvK/nXQQGi08iqwJyPeR2I3fk5+ix0aF/kqICvlSOGztcOjd6AtBg7P6tyM4pHZbqQKCVD/j9XSG01T2M8M04IwVvBeXo5FE1sixuYreKLnmjnYH6BC2zfW5Y7c7F8JXpNp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIOyFhmH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIOyFhmH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA7D1F000E9;
	Mon, 17 Aug 2026 17:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786987525;
	bh=2sggClO/dtpkjcUCyfktEv+k4mZd9fV9jpEDConDi84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YIOyFhmHaOotMftx+iJA1nc6DsnO0RClHwO7m9pRKMN9wFJ5Ezn15xJ086SYi8zux
	 MemqjY2VJata3oOmDatmWzeJq3CKQYHGA0m//eHF3h4fxEiV2rYX8iiBTpJ+9B8ZNS
	 9TD/CpL4KqbcCCnjr11rAhUNLLXeIf9jt9NNnAwzFBrLPLiiM26/mfOW7neQXrsDDs
	 wyPT4JET+U85Ey+4wSXYuZn+dn940wdu3F4HrX2AD/kncb3kGj5s07p0deJgNFirMl
	 8cBSwTUrv48E65C7HI/7s3+0orbwSkoex5KzkrdXyIrZ+A2M+jkCU7WI0G+jwuOEVA
	 FtVZ0S1zT/oPg==
Date: Mon, 17 Aug 2026 10:25:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
 daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v14 00/13] net: mdio: realtek-rtl9300: Add
 RTL83xx support
Message-ID: <20260817102524.311fd87d@kernel.org>
In-Reply-To: <20260817162632.1208891-1-markus.stockhausen@gmx.de>
References: <20260817162632.1208891-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 18:26:19 +0200 Markus Stockhausen wrote:
> Subject: [PATCH net-next v14 00/13] net: mdio: realtek-rtl9300: Add RTL83xx support

## Form letter - net-next-closed

The merge window for v7.3 has started, and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We will only consider applying net-next patches which were posted
before the announcement:

https://lore.kernel.org/20260816155953.072d73da@kernel.org

Fixes are obviously welcome at any time. net-next patches may be sent
for review and discussion only with an RFC tag.

Please repost when net-next reopens.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed
