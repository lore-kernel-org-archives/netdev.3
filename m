Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DCC29BDB1;
	Tue, 23 Jun 2026 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782213360; cv=none; b=tFyn8r72naU8lyQN3P+ou8cpNP0Jtj0K7MTefKxEZJFyxO1B2jUBz7HoH7zI9cUGeysLgLCNXWQZQcQV7hWROciFybJO9x1JySfC0O1QCX3Ej0eZHJD9DeUmwbmF/c3q6wtEGBRPAvk7FjA5H9B3mboWw8Gm89gSzE7z9rK8NdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782213360; c=relaxed/simple;
	bh=+KXcjBKY7YR3o+zhpl4sX70MZT71k4lD/kr5bq37pX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcd2tdquZ7JThV11KaOuEtNWbcnEIQPL7Zn/uHp9eaesRrgn/kKgWnMngSGeBGK4PIvKzUGOF1T7slx777B1a3UQQFonFYvMCeNCR7kAbitKsjNgIL5m7OkJxP/2r/9Oveib2i45WvDlcfu/C0qbzgkqgcLHD7h6AnFCoOOgcRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Sn8S7EUI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Sn8S7EUI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vzI+77fgywEc/mBEngRcXhnQZItCX9YrgMAB9HG31H8=; b=Sn8S7EUIIKyPE2Hesm3otpPIsb
	IMvoanljKoxrL/JKzpTRruwhen+O0/yAwvY6Ut05Fu5PRz73qxJDfVcaDNjhBJZrpfJqz+dfh2D1G
	a81OoBOB/G579xWhtEFJtDN1F2T4v7qYggSqXRqROaTILYnJb1H0D5yFnbpYtZEm9Xuo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wbz6h-008wYT-Gh; Tue, 23 Jun 2026 13:15:55 +0200
Date: Tue, 23 Jun 2026 13:15:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wells Lu <wellslutw@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shital.gandhi45@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH] MAINTAINERS: Orphan SUNPLUS ETHERNET DRIVER
Message-ID: <ba86fbe2-58d4-43c8-a4b1-cfc6c0d4fe8f@lunn.ch>
References: <20260622180721.28334-1-wellslutw@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622180721.28334-1-wellslutw@gmail.com>

On Tue, Jun 23, 2026 at 02:07:21AM +0800, Wells Lu wrote:
> I have left Sunplus and no longer have access to the relevant hardware
> to test or maintain this driver. Mark the driver as orphaned.
> 
> Signed-off-by: Wells Lu <wellslutw@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
