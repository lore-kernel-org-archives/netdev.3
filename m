Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FF5346AFD
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216376; cv=none; b=hPiFQPiutmMs3BWER+bCzFOBkW+BKGRloiyFt8kyqzmCitqMiwxumiReJ7rhVSULDUhC6f0spmXoV+5zPrMEa7C3yjR6AgNTnkkvchDj6m20ys/FF9Tb85a4LmcwR1f9mIhNaDGnJ4JB4yRbTLje/dTUE5y9zEraQT3ZBII0IzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216376; c=relaxed/simple;
	bh=7t8Obm4TIta0+IBUfYrRiEGzc/niIXSDZ+bwcjFY6EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elivB3m+aUidSgwfJ9a8Ykhvnq2RGGh5C5QbGY3zgghuVaXGq3PBv2UrMwKDgozJse2yfUQLLP9DHv1jnoGRAJVsglmrwlcYchI3lTw4QCq+t37GFfo9S+NcTHijt87PLmvenWNuWGMgU2Zu8vTuwOaE3CKj6VVGRORZBDpcmy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=T9XGlJTm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="T9XGlJTm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UJhWEpH/xmTLRsD7tn5MGeOn6klEOIDmPR6Pwj6w37E=; b=T9XGlJTma7FUNHJiN0eimNNiJw
	FYj8lfDiUHPrp58E6N+ZjtmMllstDKya73HDrHtporl4Ggkip4Ocj+v3Z1QBGeVJVrIcxeWRpXp0R
	CIkQyADKAt30nxlxDo6GSfuYi2wTSFZXR9vxJI+E7J4LTbA9QFNtpPTHBQZ1qS9Nj47w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wPPS9-003ick-6g; Tue, 19 May 2026 20:46:05 +0200
Date: Tue, 19 May 2026 20:46:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org
Subject: Re: [PATCH 9/9] net: mdio: realtek-rtl9300: Link I/O functions in
 info structure
Message-ID: <e4a1cd96-ff7a-49e7-add1-353a24b9aa08@lunn.ch>
References: <20260519165747.1288903-1-markus.stockhausen@gmx.de>
 <20260519165747.1288903-10-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519165747.1288903-10-markus.stockhausen@gmx.de>

On Tue, May 19, 2026 at 06:57:47PM +0200, Markus Stockhausen wrote:
> All SOCs have slightly different I/O functions. Make them device
> specific by adding the functions into the info structure.

If they are all different, why put all the registers into info?  Is
there some level of sharing?

	Andrew
