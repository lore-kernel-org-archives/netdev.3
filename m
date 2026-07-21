Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6303E92BB;
	Tue, 21 Jul 2026 00:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784594383; cv=none; b=T5SeEZCSbIzDW77VwsA8WQ8du8Pw6IuWQguNUn0X2eWBQ2n0Adf+g6jkdJDGcSrHuzCS/lIJmF7DLjQ8QNrqItQCUrni0wHMyvCKv4c/W60P2DPuovn2ZHI3U72dzCXy2PQ7MTuXdWXljA1NqM/PYyn0UycoB5z/XwSn3+7eiLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784594383; c=relaxed/simple;
	bh=rrqiU9aNnX/sfiVLWEBvmepPhSM8FzUicLf7lZPW5sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2Ds1MshW+rKtHO0Obt/xQt/o3Syc7DuNxA7F7k8cRjAW/Jw5HxMTVfVw8wJCZsncEH4VKeYQ1vNXKNQA4H2mGcMsSKJUdzjZX61znEW+VyMYLu35EpCJukug1zgBBbZ7c/RdlHF+7HGd6YlNr2vhWonS8/kkOIXzvXO6/JgrY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fCT2cKty; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fCT2cKty"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1CSkd1TSKu5JCz6BkVBLXlO8GJdhBnnjUKfmzFm6Rjo=; b=fCT2cKtyZSmrLbQJwl0quLDz4K
	mbzneRcAfsrLdlsiYC3UNxkZYsv3tWj2XYkc0R44yJeJyb+SEk7HiAgimdtvVCBtgShFfKv+7w5aZ
	Eg+if4EeduR6gQGXJ0F/fLOolhFCZ9NWGrd/2TNFmCXaUIZxIaPixwLGDGcwjTQAkEOQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wlyW7-00DLo9-0Z; Tue, 21 Jul 2026 02:39:27 +0200
Date: Tue, 21 Jul 2026 02:39:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>, thomas.petazzoni@bootlin.com,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next] net: stmmac: Simplify ioctl handling
Message-ID: <6fa4cb27-20f8-4425-95c8-202d7c7f010a@lunn.ch>
References: <20260718143848.677531-1-maxime.chevallier@bootlin.com>
 <ae82997f-537e-4a2d-abce-d163fcf9d868@lunn.ch>
 <6ac12388-60de-45aa-a8d0-62fcfaf7bea2@linux.dev>
 <1e640dcb-43ce-4a3b-a74a-ed8e48706b86@lunn.ch>
 <d4f606b9-d793-47c1-8c91-9c9da0e68b4a@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4f606b9-d793-47c1-8c91-9c9da0e68b4a@linux.dev>

> looks like it won't work now. we have to create helpers in phy to fix it.
> I can work on it, but I don't have such HW combination to test. Do you have
> some HW to test this combination?

I don't. You should ask Richard Cochran. He added this code.

  Andrew
