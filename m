Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D6253F685;
	Tue, 22 Sep 2026 12:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079270; cv=none; b=J9QS3SC7f1A3cFn+MQzwlppTv73ZC2Ym3BWw3ZykfZXrQlWmBtRi7mPZTr7O57jrHEukda29JX/cHIscSwvwKbwHotgjPLcdJtc00susDq1L8mIVYu6SliNTQuIAov5Lo4EuccIUuPNARb3j2gfvqsEKGJHXHSGRFMR5hZ3c1yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079270; c=relaxed/simple;
	bh=OQOe3VHua0vcGyoyh/IsQDl8sqMbC4HhnOtHHfjd1WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E41oC/uvB0rq20cTB8DFovqPchfAlMM8flX3wC1qDALLyeMTGZ8Zv3n0sRY3A+Qe1M30332I5ZgeilkzmQUs2oNg6CA5RR1AE+1rBMNt3RJxNfC6ZHu39wXoUkur/SyM9isTAc3aSFXH6WtxXvYHpHieFu+FNGbMSJYufKZH7V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sABnGHj5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sABnGHj5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=N3zAADUWYmg6MnWP7lx8XkjYe4YOB+urybqd0LojM+g=; b=sABnGHj5WECTpWvSh/0ZTFobE3
	t+EMo74agGY7Pbl20OtCRr2EoT105e66LwTQteIg7liCFbKJ76yQGd/dG8dU70SBjhbulh9eQ7rfv
	hXN5wqSs74AFco8vuoLqdcC7/l2wWz7xoqZd/b6iSrpr6t+OKmpwC0RTG0+fGHemhJfw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8zNy-006aAe-66; Tue, 22 Sep 2026 14:14:10 +0200
Date: Tue, 22 Sep 2026 14:14:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Joakim Zhang <qiangqing.zhang@nxp.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Alastair D'Silva <alastair@d-silva.org>,
	Maxime Ripard <mripard@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net 1/3] net: phylink: allow stopping a suspended instance
Message-ID: <231c84e6-7ead-497e-b2f3-ef19cfa1a978@lunn.ch>
References: <20260921-submit-stmmac-reset-fixes-v1-v1-0-87a4e431ee00@gmail.com>
 <20260921-submit-stmmac-reset-fixes-v1-v1-1-87a4e431ee00@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-submit-stmmac-reset-fixes-v1-v1-1-87a4e431ee00@gmail.com>

On Mon, Sep 21, 2026 at 10:54:02AM -0600, James Hilliard wrote:
> A MAC which cannot restore its hardware after system sleep may need to
> close the network device instead of calling phylink_resume().

You need to explain this in more detail. It sounds like you are
pushing a workaround for a broken MAC into the core of phylink. This
is generally wrong.

	Andrew
