Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB963C343C;
	Thu, 14 May 2026 12:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778763462; cv=none; b=KZq02JqLaZeuqGRRMaBkr6MOuacjVSH337qlYTqOxW/PBHVL+3i+zP2dkHLNzJ/z2nOPBQCcklJSVTRcBAlfXqvUQ/e1JHxtxdxyMbdubjF3SD1rmvaL3jc9mTqwvICzxbil622dfw5lR86I0CPtaTnWQeKYsgwcXtRiiqhDeS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778763462; c=relaxed/simple;
	bh=kykvLU/ntAr02TkhzsRxTcaW1clizagmqSdmCVQTr9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuZnWSXs4RGqoDrO5wrcAOxE95mJBfxOjdiCpVmDbUPPNCTT71neCg7b2ddF9wpfDp2CpHrSTa+5RJblz7Lo6UxJ2sUFiHPPY7MPCjaWGuWwEWKQlyF4SeJVR4Pl9YH6ueKcGRsyHPAni6wtmL7q0ekAXFs7lJM2NxupX3ewPBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yNL6ACPA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yNL6ACPA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ynGEkldYZgbsfh9dtcyMEnBpK9l9CBo3pHYEM5UdRgo=; b=yNL6ACPAMbI5BiIOWnrb10NU0h
	jljWmjSTs3I4z6U/013aC+TeiG0UIfF/cwaWM0aNteU9X8fPNgiAj6wvDe2sPxrgHLHAYrvD8sqTy
	aysKyNjfJoGRdvqJ/HdLS3BPENaiwos0I+xJnNlpmKUKrPwu11tWnxC/TAr/PlDZ9m74=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wNVd5-002uG8-0q; Thu, 14 May 2026 14:57:31 +0200
Date: Thu, 14 May 2026 14:57:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
	linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] net: lan743x: Add support to software-nodes for
 SFP
Message-ID: <40f567f0-e6eb-434f-9d54-7f226f0f70fb@lunn.ch>
References: <20260514105028.42942-1-thangaraj.s@microchip.com>
 <20260514105028.42942-4-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514105028.42942-4-thangaraj.s@microchip.com>

> +#define PCI11X1X_TX_FAULT_GPIO		46
> +#define PCI11X1X_TX_DIS_GPIO		47
> +#define PCI11X1X_RATE_SEL0_GPIO		48
> +#define PCI11X1X_LOS_GPIO		49
> +#define PCI11X1X_MOD_DEF0_GPIO		51

How do you know these values?

Can i buy this device, design my own board, and decide to use a
different mapping of GPIO pins to SFP cage pins? Or does the data
sheet say you MUST use this mapping?

Maybe consider drivers/misc/lan966x_pci.dtso.

      Andrew
