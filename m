Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5B53D170B;
	Wed, 22 Apr 2026 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862067; cv=none; b=dGs0W06fKhIQzkALCr2n1/jXbmH2qSejpp0YvfywShTMkJwzBcWCId1E9rb3oIf1HsKlT6r0ZQx2KJHPEXzPOpwkhzT5bU5ZPAtJMLVNJhx2grSGm9IvY+ouPTM9Hyl+79Sh1VxTJy+O2HTKzv5raek1yfuxUUwVCet6iQUFSt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862067; c=relaxed/simple;
	bh=/7KKzmCUPAzn3ywPe9THLhfNRqp/gG453mYfw4BCtxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFNhxslUHODw82Z70LeglNrIENPdpajzhj6x65KbcpARzri5aSFmCCBPgfJLeuW0fl1d1Ynjf3WaFfK2SJpYrc6ZPFhQT8GsB+hCNC0C/HT6mkXzQ9tubirL0ooT9X0seC9U2/yhlvRU0EcLzYJC0SJACU3+6KgUfPa+3sas+N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VXhwhb/d; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VXhwhb/d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=clASrg+WTACfIVmwSPZRwPOparTt2388K44CIhnQt0o=; b=VXhwhb/do4tzvuXj2cgIdGZQ92
	8Ecq2EzXt9SYjNlwn2KgOjZiWBkSLFhza+L7R5eO2Y0VZUzBKe2RsebYQc2QzCw0pCBOc5+V4tW+k
	z+PhS+Trd7bz8WhH9dUVhNYToI57Bo5nDEyTLKNyIzjJ7YFmjI2OsmqYPU0CChqKxKl8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFWzS-00H1yx-2Z; Wed, 22 Apr 2026 14:47:38 +0200
Date: Wed, 22 Apr 2026 14:47:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	kernel-janitors@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] net/stmmac: Fix typos: 'tx_undeflow_irq' ->
 'tx_underflow_irq'
Message-ID: <f1d51362-ca8f-481a-b9c1-400ab6422686@lunn.ch>
References: <CGME20260421115052eucas1p103281c5b25719a44c0875d6b0860bfa6@eucas1p1.samsung.com>
 <20260421115008.2690541-1-j.raczynski@samsung.com>
 <7eb9e4d4-909c-4203-833d-bd8b664fdfbc@lunn.ch>
 <aeiJ3zr4WJAm1UCk@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeiJ3zr4WJAm1UCk@AMDC4622.eu.corp.samsungelectronics.net>

> I don't see anything wrong with it?
> - naming is correct, same as stmmac_extra_stats from common.h, as it
>   wouldn't compile otherwise
> - string length is ok, as max name length is ETH_GSTRING_LEN=32 and it is
>   not close
> - ethtool just polls data from driver and in my tests it is ok
> - all instances of 'undeflow' are changed
> - 'underflow' semantic is ok, 'undeflow' is just not correct
> 
> Please correct me if I am wrong, but imo no issues with this patch.

ABI

This name is published as part of the kAPI. You are changing its
name. User space could be looking for this name, even thought it has a
typo in it.

     Andrew
