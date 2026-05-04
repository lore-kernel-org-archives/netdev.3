Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D93F3D523C;
	Mon,  4 May 2026 13:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777899778; cv=none; b=pJ6u0sd5y6C6J4A+7Ubu7O/rRpbE2/ICpi/+5OPEJGJd6VNzr8TAmJ9CVEyI4KcBRLgZUlFS9JpxX5S8VIW8c4F0aYzwtdn0jBE1/e7jyMiwUAbf5w/lohz7RE2j1/x4VyY6FBotBu7SwHHxIRWY6VXegmCVF0kA2Vs8gLRmXO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777899778; c=relaxed/simple;
	bh=N4vXZDn5Df4IJmA509gN41pd7mTXA4BEeaNK0/qv6FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFu0NfOCC9oq929UebfLL4pos6wiNuOGaJDomYl4xI36mDZfhe6CMn5EOvSH4jO0+X1WI3X8jeS03kbhSGg4i/HF3Xxp6hCs67KCl/8/nNoj5o9nN/3/7np4/SrO/NBaDT8alruguNlewl6Wm3fjVec9GSYXw3z6V+sVQnCd+M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=L1y8FUFm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="L1y8FUFm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SX3xRb+Kf3Kn0aEftvrBv7pyrElY5rmPCe5smBaRekI=; b=L1y8FUFmAY6afj8mS2ps66RKF8
	G2ToE3wtuZEdx7g0Kk+e9H8BFA97XLQkqk3qID6UCtFlGUxIi2JydljhfJj1DH6iDaOV+kVIDIful
	0sNZTQk+tpZTO4jsQeWo6alSzeyya7tR9Ct1iTSt6uiorDxrxwMZfHZzDfyrKwYtYuYQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wJswo-001GLd-4i; Mon, 04 May 2026 15:02:54 +0200
Date: Mon, 4 May 2026 15:02:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v1 0/5] net: mdiobus: HIde ACPI implementation
Message-ID: <aee27459-387c-46ce-9c06-3de66309c8d6@lunn.ch>
References: <20260504074610.40799-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504074610.40799-1-andriy.shevchenko@linux.intel.com>

On Mon, May 04, 2026 at 09:29:51AM +0200, Andy Shevchenko wrote:
> This mini-series is dedicated to hiding ACPI implementation details
> from the wider users as they (as of today) do not need to know that.

Please could you expand on that. ACPI != OF. They have different
bindings, so you need different implementations.

	Andrew
