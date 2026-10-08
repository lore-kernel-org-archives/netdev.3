Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFC91A76BB;
	Thu,  8 Oct 2026 01:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791422552; cv=none; b=YHKXsFcFWPiavSwpzcDbyGi3v77ippAER0VlWbKrD568DyuNH0lNPqrUHheQvzffBIpFzt2DjSWZZPZcnzZ1BqCgWMKZwIergwnN9E0tpbH7iXlc3A0CGQOfnlCI82GvUKN3RLbABeveZTqd6wHDJdyAt6MQn1IzpaMi07yMQ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791422552; c=relaxed/simple;
	bh=Z4rYWcsgHrby/PHy224w/OfQG861Ta1yeGlMldVGXsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TF3HdgvGw4MvNEwcY7rye9NFEZRjCVnvb1EjRjCft0tuEs7a03IbwGufsxpz1X/2I+cdMirrL5icEyIx8ArS5b9e11m56RhIdWpTk2S125LqB/Ij0LKp1upvXBAmSK+NZ5DzUhz+8lLQPwhSVZSskxFl56V3XKyHesctZ1XvLJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GjEvN/MT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GjEvN/MT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lj9GNbQKxCNlcoY/Wjpq3ci3xOdaubfTFoBdZ3Vpwoo=; b=GjEvN/MT1d9masEoDrFLRE5lRL
	v3hlQ9Oe3iUF1NzpSchU21P3JKWDZI2udV4082w5RdHrlqcC/hiZKHLgdhXkcWrHH+vuAwXykGGjk
	XqUOWE5bwG/bxUZl+w7MziHlPJpHSj1ug/7OGLoKTDvO32380uSWc7HBADyjWEEdQGno=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xEcps-009XZf-0n; Thu, 08 Oct 2026 03:22:16 +0200
Date: Thu, 8 Oct 2026 03:22:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: linusw@kernel.org, alsi@bang-olufsen.dk, olteanv@gmail.com,
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux@armlinux.org.uk, luizluca@gmail.com,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/8] net: dsa: realtek: rtl8365mb: set RGMII
 mode for family D
Message-ID: <eec36c89-b6fd-405d-a951-aec0677b149d@lunn.ch>
References: <84fc7483-b22d-45ea-a3b8-3285dc357265@yahoo.com>
 <dd78e00b-c161-4915-a917-3b5694139621@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd78e00b-c161-4915-a917-3b5694139621@yahoo.com>

> +#define RTL8365MB_D_REG_EXT_TXC_DLY				0x13f9
> +#define   RTL8365MB_D_EXT1_RGMII_TX_DLY_MASK			GENMASK(5, 3)

The current code looks at tx-internal-delay-ps and
rx-internal-delay-ps and programs some other registers. It is not
clear to me that the code you are adding here is correct when combined
with the current code. Please could you look at the delay
configuration.

    Andrew
