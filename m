Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A1C1EF09B;
	Mon,  6 Apr 2026 20:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775508208; cv=none; b=huv9XBUxR7BTX1JlWFNB4VAhwzVkYbqoiSGMsN5FoN+IcBSWrLCb1FVpAzBElKBVBsviGa2AFrhasUtIwNlBcrIxSgA/7P4CYWl1GbjiIo8yeXuirfYz5hwWCeULo9tVwc3r62g0zP/gc908PUo4yLr++5hNgv8d6CSz3ypRCkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775508208; c=relaxed/simple;
	bh=iHLrsLiebOl/BHp6Bpz9Hquu13t28LrwDbJFgBf7gYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8o0u2aJGqwoLFmUeyR/8Pjz+EjyLlEjkE5y9NpCLlCuF2TAEkT+FU+gz8qQ3gvoX8xDP/+3oJDnlcT0ruzZCXBSyA/nGr2kImPX83HilnldZ7neg2bsq9hxhueAUX+zf+eViJUVnu3HRBsicoMmA0qrnQ+j9Z5E9br6San+Zpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w9qmt-000000000VM-0US2;
	Mon, 06 Apr 2026 20:43:11 +0000
Date: Mon, 6 Apr 2026 21:43:07 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladimir.oltean@nxp.com, michael@fossekall.de,
	markus.stockhausen@gmx.de, ih@simonwunderlich.de,
	rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: realtek: get rid of magic numbers in
 rtl8201_config_intr()
Message-ID: <adQa29I3zYoBWHUY@makrotopia.org>
References: <20260406201222.1043396-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406201222.1043396-1-olek2@wp.pl>

On Mon, Apr 06, 2026 at 10:12:12PM +0200, Aleksander Jan Bajkowski wrote:
> Replace the magic numbers with defines. Register names were obtained from
> publicly available documentation[1]. This should make it clear what's going
> on in the code.
> 
> 1. RTL8201F/RTL8201FL/RTL8201FN Rev. 1.4 Datasheet
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>
