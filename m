Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3052C390987;
	Thu, 10 Sep 2026 20:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789074001; cv=none; b=sgRV0UfVN8hDxrdR+t9+4r/kEpHlnmELkLT/Hd6KkmJ/eAm4E9p5QfApsb9T73s+5Sh9OKoL/0JNR4oxne4alcC2K053mIgz75rCTTEWT7n/Gi/ZpSbT7kVSHrBVTmj/DQeVjzgA5eNKfXqTHeBAMYHrQRzB2omh2ICcGaJCzn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789074001; c=relaxed/simple;
	bh=JWu8rUmwDaATAWWCoE6KBsO5S5ln2cs/+eBOlI3gnLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIHI3yqUZVF1HQw/jb9ptQacNLBeOo8QHtmJ/jfLp7vedYCchjHEJw0xQBe7wKN4w7EXS1yX2o7JqEYZdqiDjNk0LIwi8aCa9u9af73X2uS6oLWsLDETQCgxIMXU/u7nHMZLm6mrPZU3JL/DjlghT6hLwXIpH22DJqRwuy6JADI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=h+i3/6SP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h+i3/6SP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fD03sGJUwdF3zXJSO+fhv7amNQs4VvVowkH+SKNcmhk=; b=h+i3/6SPyiwygiHKTwFRLJygUS
	3y87cUXrFix/0Boc+qBvI1vY5Xz8iO3LP0XykKpntiVOg3MkdPymkT4VUlKETXfLQqzynLNNW1P+K
	UO75GfLE53QceIw/rSPXQTNhTK5sT2UOIQ0pFK/fsn/bE/U4DxOfszccIET635cteOVU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x4ls3-004Zaw-W7; Thu, 10 Sep 2026 22:59:47 +0200
Date: Thu, 10 Sep 2026 22:59:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/7] net: dsa: motorcomm: Split xMII and SERDES
 port masks
Message-ID: <40e425e2-7d0b-4e20-9880-41e46ff340c6@lunn.ch>
References: <20260909190541.466476-1-mmyangfl@gmail.com>
 <20260909190541.466476-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909190541.466476-2-mmyangfl@gmail.com>

>  #define YT921X_PORT_MASK_INTn(port)	BIT(port)
>  #define YT921X_PORT_MASK_INT0_n(n)	GENMASK((n) - 1, 0)
>  #define YT921X_PORT_MASK_EXT0		BIT(8)

I'm i right in says YT921X_PORT_MASK_EXT0 refers to port 8, because of
BIT(8)? And YT921X_PORT_MASK_EXT1 BIT(9) means port 9?

	Andrew
