Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0FA1DA23;
	Sun, 19 Jul 2026 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784476165; cv=none; b=oOvBroBUD43JR8Tr6/n631ByawbQnyxqYV9SFa7UgnVprJGviqZfftesvNFL8l0gNgQ8i5MT3aB7R5B/QvZ09izx675Bkt52wfK31RXU5uYbRYP7QTREVLG4EiX+ZrtSFtQCoU2CAqtGFJAzz4X2a5kTm69B0OICp55OuwTyqL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784476165; c=relaxed/simple;
	bh=7+pRm6XFNmNAC8L8MwNOHuhMQqo+TfaEb3MmRBdz2OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PS+yGWalywmFpAdMGvpvPWbrSTzC25ZiP4MtnxRVHs5IekoKUj3JvYadH+2BS4XS7fx9QRRUOxT+ri5cOGPl3WRIGc/UJ1JukxHJ3mW8MhHPdJnzlIuhGgT1/K2Z0ym5oKZGAxBky9+htqjK9IKynNMRwRYTLg3xXxWsp2xZDzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ie0sC1i9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ie0sC1i9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Jf1SvJ/fVMCBXUTw2i8hSYtmmnGFI8fyfScXlxDpAsA=; b=Ie0sC1i9dT+4wZMb4kEZQM0edQ
	XiwhZKkBYS9Mi9SKSw//p43fk40SlKFRMSy3VmAUg1OSQbmpzRQzzxigBoiD5nP2kwZ5JW4n/TZGd
	N8TALGNiLk4Ra6gXKNSiPxkuGOybbifJ5M/dmR6D5b/fIjxvthxehAYqKZQ7cSPEDQ+s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wlTlS-00D6U8-Lx; Sun, 19 Jul 2026 17:49:14 +0200
Date: Sun, 19 Jul 2026 17:49:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sfp: add quirk for HORACO copper SFP+
 module
Message-ID: <681ffad8-ed55-433e-9e1b-b95b686af3f9@lunn.ch>
References: <20260719100158.874882-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719100158.874882-1-olek2@wp.pl>

On Sun, Jul 19, 2026 at 12:01:55PM +0200, Aleksander Jan Bajkowski wrote:
> Add quirk for a copper SFP+ module that identifies itself as "OEM"
> "HC-10GE-113C". It uses RollBall protocol to talk to the PHY.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
