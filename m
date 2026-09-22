Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FE051596A;
	Tue, 22 Sep 2026 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077576; cv=none; b=pLs2gAoy38dYUXoY7EUVBuaZcQXW7Er8UIhIKnlpeDvorqEJs4qULBzdKMEDlwyzabXK+BxtXNyGQ4UhSC9K8HQKw2/ynWC1TvlLNz5jGlshk5Knpa1LmRR616+A58r5mrbNN9TlGWEiPGIbAI9evhVuFoeI8Sf2hL5Ac2x0lW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077576; c=relaxed/simple;
	bh=JmC/sJKfg55cuAcGUeHBmyKSLVazyVeLdHI612PuKIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpKyTJD0st4ASuOIvdtAvXyQRfTnQHHaS+JW2iwUdoGJKlXKVUN5aWOj8+9qD+c5CQNy0LHdAgb3WijIROmleFVMPy5j/3z0P7uK3k1fbZu4tmBRKaIVqzaTvWbnRsJM7C/eO8PX40NG4dzdkqWXdqXPrI6PxHM2NKEsYT6GyaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZmjnHQiq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZmjnHQiq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=98DkiVkgsKZdmsmxWDBFXn9t/yutUpZkM/zEGn+Ce5g=; b=ZmjnHQiqzkZHg5LBVejOzCLhLx
	hI7sXPx2qzLhGHdYnJMYHBLS1j7m7/NvkKHtAKjlW8dX0LJvRn89rremM3alR3ANJRACqDJzZlJqX
	n/nu0ZFA3jkFiB4pReb0BKvTQVh12JnhZZp4qtdC8M4neBuk4j7wGp4JGXicwFwLFG5U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8ywf-006Zee-Fw; Tue, 22 Sep 2026 13:45:57 +0200
Date: Tue, 22 Sep 2026 13:45:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/8] net: dsa: motorcomm: Remove
 YT921X_PORT_MASK_* macros
Message-ID: <62ea671b-cd5b-4b5f-9e1a-e1fa6529bc46@lunn.ch>
References: <20260917185010.3189199-1-mmyangfl@gmail.com>
 <20260917185010.3189199-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917185010.3189199-2-mmyangfl@gmail.com>

On Fri, Sep 18, 2026 at 02:49:48AM +0800, David Yang wrote:
> Remove YT921X_PORT_MASK_* macros since they are only thin wrappers
> around BIT() and GENMASK() and are not used in other places (plain BIT()
> and GENMASK() are used there). No functional change.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
