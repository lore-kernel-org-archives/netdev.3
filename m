Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794073539;
	b=uZiYiyF6bC2BLkbVoOfSEFEo3xa5N2t2syuiRFpyKGeTy8jkLc8V49+iKJ4bMZvTsBBe
	 6A+tdqwooCKxNu7TYd8npvX6SuLXLGHPtSToSC2I6VfRRiUAJkV3quADdrq4nHg5qL0DR
	 t6sVWBCiMZixxP/WWtXouOl+kmqW5N5UUrrZOhbJR8Ql8JZmOC6+Abosd9OuT19p3JM8m
	 U3IsoCGwlFCRNUXVOnNJh6jXrvabPAg2JGidnjKGOQOVuS8xERC7ZXeJyYK2Kr3zGf/35
	 h5Vikbyb8rtf2u8LwCmkVOQzHVa+3gMSMVEfTB5wjc+6lwTzjcApGcsMPrX2HmQ6B6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794073539;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=5vBYX3V/G4OcOLWrHLlmjniwWqCHFJN1r+bxt3LUavk=;
	b=F1Km5J0LcmEL1KE8IGlbCFhemlh4V7a3BGpIxkfNHVX+eAn7OK4Rz9jtOjj72MXOtecF
	 A2QsZfH7r1kn3GNO/6L59Fw5WNT8miUqv1cYvJ5KC8BoG7bdswFHNc6Hb+O9JVhzos74V
	 nAGIdRBqsADegURSo+70SfyiPHLZSDB1GowDFVKA7rCxYVMXbsHeLyEOp5amPPjSIBn47
	 fmHKLOS6Q6LigJf1KexvhkCRIGeLcqwEqG5fqdbHw2NXIl/IXED9d8lBnbSHC7j+tdjFI
	 HZO8qLMnCAboaFv+cmgAncP1tWsiZP7X8dyD7zkmnBWS8paSCzphzCb66FA+3yNAoCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=KYF6ZcnA;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8846606A326;
	Sat,  7 Nov 2026 17:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8846606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=KYF6ZcnA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5vBYX3V/G4OcOLWrHLlmjniwWqCHFJN1r+bxt3LUavk=; b=KYF6ZcnAJlhVWA8j/YR0QVCEDK
	/5aUtMmHkvzA7LPjQJ85GKPZ4otlrQTS6b/X1b0FUmqKtuFNxcw45iPMk/6+tQQPj3/CiCa/DC1Dr
	lvv+wf9H4/aL4tOFwd9c9N9EgnsmB2qJloRiMgvPLDyAqw2J+RjI5P/1Xfo+OaA5SPq0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xPkTr-00EzG3-Js; Sat, 07 Nov 2026 18:45:31 +0100
Date: Sat, 7 Nov 2026 18:45:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	yaojun@mucse.com
Subject: Re: [PATCH net-next 1/5] net: rnpgbe: Add basic ethtool support
Message-ID: <bd4ef54f-549e-40d7-b94b-d3909af3cb01@lunn.ch>
References: <FB722C2F25FE9005+20261106112420.43050-1-dong100@mucse.com>
 <3637FA23D47B2459+20261106112510.43809-1-dong100@mucse.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3637FA23D47B2459+20261106112510.43809-1-dong100@mucse.com>

On Fri, Nov 06, 2026 at 07:25:10PM +0800, Dong Yibo wrote:
> Add get_drvinfo and get_link callbacks to report the driver name,
> PCI bus address, firmware version and carrier state through ethtool.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
