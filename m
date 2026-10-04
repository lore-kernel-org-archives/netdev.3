Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811E817BCA;
	Sun,  4 Oct 2026 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791124524; cv=none; b=bB8AFcqgEB/8GvRwYwIhBgeAFRMiIs12B/gDuZuYWUwnJTBMcvS020dCypRn1w+pskukSRKNh2VisBg9W1iaghNyRBlRXa9HcA6qnThPls9fnqkq5N9TfLvzXB36rrGMMPcJHBREcJIHbVrN0PNdUFIV8zqIRuzvSI+A2NFIMEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791124524; c=relaxed/simple;
	bh=KfkLjcW/tKdgnBJXgRKTVEeAR1KUWD8jDu7yRDyk0Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cet8/z4mkJQpQxOgH6ZhoBJGi9+wFVJvqGtpghvHjzJTjhjBX1jyy34I3fq1u6kFZaiLbCIMaQ7ZPLtMUSXB74f1DwDGJTWVBVy2nTi+yzM6aWLMFGkmqkp4wjH2tcd7XTvApydqk/VDSTht6gj7rGK6umbMPSDTUtAIeIlVmB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sLT0G5OC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sLT0G5OC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3Xj2E3zp+z9VyVZKqnPlhHjZYBy2RAnbUbQDh2qi2aQ=; b=sLT0G5OCXPy5WzJ5YXXg/WcZwh
	ggOtnhEnXIqj5Y1OEqd6qCVRuxHOKXU6GUEhDMi1OspCY7itkukZBWQMxWQHcvbbrTz00j09QT593
	Y5QSaX+8un2D+jqThhCc2GfoCfke+oU4BI8hnyAFx+DCpoqaFtMUdr+4jVYcd8jLGFiY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xDNJ4-008tKz-Q3; Sun, 04 Oct 2026 16:35:14 +0200
Date: Sun, 4 Oct 2026 16:35:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Igor Velkov <iav@iav.lv>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lukas Wunner <lukas@wunner.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: postpone PHY interrupts during sleep with
 MAC-managed PM
Message-ID: <77e5a3c4-8b47-4609-b8a2-7f7b353bc219@lunn.ch>
References: <20261002043548.1302145-1-iav@iav.lv>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002043548.1302145-1-iav@iav.lv>

>  	/* Wakeup interrupts may occur during the system sleep transition when
>  	 * the PHY is inaccessible. Set flag to postpone handling until the PHY
>  	 * has resumed. Wait for concurrent interrupt handler to complete.
> +	 * The MDIO bus may be powered down even when the MAC manages PHY PM.

Just think about that statement. MAC manages _PHY_ PM. It is not MAC
managed _PHY and MDIO_ bus PM.

To me, this is key, because it means your whole approach is
wrong. Lets start with a clear definition what MAC manages PHY PM
is. Then we can decide on a solution.

    Andrew

---
pw-bot: cr
