Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6087B241139;
	Sat,  2 May 2026 19:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777748945; cv=none; b=ULYcuZ5+O/w288RNt9xEvZyc3Ko4tv5l3YCEimPsopAFG58V6u0jGeiEZD258EgjrBvsiYeQlVA1D4Uj4CcJHGNXIgarjeknU/5+oSAwJaeHQk6g3wdYreCnluwrP4VNyv+axqTi07Ev39bZSkZyO+sfKx7QWKV8BNKjINYiUXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777748945; c=relaxed/simple;
	bh=j9jwhnd1WUORpvpmvyYCsc+IRTa+uqCKb2xMEE1dO3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHJD86w4yqt1o/wMn1ndbe63sXmMEgEiYis/VYJT6Sv1BQcmCqCy5RjVziWqE9jWhfbnOMrIAEjivseg5o+f6p8k9Q1zurJjKBTvUPe97S8AGa1vrZcSYAQZm943gUBK7OnlpT4lNxV/9764nkGGQyASH/uwulpW4Tl8tdGOJ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wJFhp-000000000ov-1qR3;
	Sat, 02 May 2026 19:08:49 +0000
Date: Sat, 2 May 2026 20:08:39 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladimir.oltean@nxp.com, michael@fossekall.de,
	ih@simonwunderlich.de, rmk+kernel@armlinux.org.uk,
	marek.vasut@mailbox.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: realtek: replace magic number with
 register bit macros
Message-ID: <afZLtx2P8AIMYEeH@pidgin.makrotopia.org>
References: <20260502092857.156831-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260502092857.156831-1-olek2@wp.pl>

On Sat, May 02, 2026 at 11:28:47AM +0200, Aleksander Jan Bajkowski wrote:
> Replace magic number with register bit macros. The description of the
> RTL8211B interrupt register is obtained from publicly available
> datasheet[1].
> 
> 1. RTL8211B(L) Rev. 1.5 Datasheet
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

