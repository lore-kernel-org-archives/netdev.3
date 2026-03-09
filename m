Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD7A256C84;
	Mon,  9 Mar 2026 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048530; cv=none; b=r/sIeYBEyFisKr0FoAsiY/T/71vnOMbMwS9p7gktul4gCGhxHsgZJi4gUoShkr0PMVWNZeILvMcr0yBwcGIWWgLvahsLVQu9sS8QR3DEyUqnDDC1Yrq2fCLD3oKfLg/JB19UOY1hDqXMffVaEtczeoGhCKPLY0UcDsBTRTtlkek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048530; c=relaxed/simple;
	bh=LpRG2AlLgt08Jkppajb4Z2JBo+23zfmGF4k0ZskURFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLTb83qCvZo6JslyAeLRNfPJJW/aOKVm8ah5RKj7QDg54qfDFpZTiKtpK0PSnBEG0yvR1B9+Axhy0fy7sjwGy72JtbSgXEAvBL6GHE+RafeA7Kqg9NrbBZxfExyFpb56dCa1loV3s+InOIPZ+SAxoW1olM82xlurUq03dXc1r9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHq0/hW+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHq0/hW+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22887C4CEF7;
	Mon,  9 Mar 2026 09:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773048530;
	bh=LpRG2AlLgt08Jkppajb4Z2JBo+23zfmGF4k0ZskURFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sHq0/hW+Dtr2lWAvcL9g8I04+uJLQaxu88BRd3kxEeOaNRaOEt7vTNSVOuXiQ6z2m
	 JDCBYiWrXYXTUmEAX25rDid/7hM6bJM/6WTvNfvcbFM3wSzMw946+5ZyOtkJYDKFMO
	 ra+awVasUB39skfHb6ewnSRX8cfdQ4yeq7eigJGK6iWHBpnh32Qssc6nPGcqy3fFH6
	 XBCSaTfGfEdW4PBlLA3XerfiaPFakrb1WjA686YCa3p1o5CDvsgk/HdEwxArHMn1Fd
	 LMy7kzj8NXl0yd5q0i2NwiAfCn2vXWrV/XCYYO1Yk69lstFYJ3XWwPjR3xgG0214dh
	 epbbdWGSAO5UA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vzWut-000000005CX-2hyj;
	Mon, 09 Mar 2026 10:28:47 +0100
Date: Mon, 9 Mar 2026 10:28:47 +0100
From: Johan Hovold <johan@kernel.org>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: mdio: mvusb: drop redundant device reference
Message-ID: <aa6SzwcP3bCke0ME@hovoldconsulting.com>
References: <20260309082641.15574-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309082641.15574-1-johan@kernel.org>

On Mon, Mar 09, 2026 at 09:26:41AM +0100, Johan Hovold wrote:
> Driver core holds a reference to the USB interface and its parent USB
> device while the interface is bound to a driver and there is no need to
> take additional references unless the structures are needed after
> disconnect.
> 
> Drop the redundant device reference to reduce cargo culting, make it
> easier to spot drivers where an extra reference is needed, and reduce
> the risk of memory leaks when drivers fail to release it.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Forgot the changelog.

Changes in v2:
 - drop explicit error path for of_mdio_bus_register()

Johan
