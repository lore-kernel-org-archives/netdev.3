Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12D83D3D11;
	Thu, 22 Jan 2026 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769095120; cv=none; b=dg1/6N/Y2ab3fDE8Oc323YUuXTGslOLunNmDgInMzUTUcYxHWJEd4rJR+0KNts4Y1N+kxpU6HRBzszHQwCVdsNHFHjT1f8xbqbsltEmXjTbe5Xpx88Gji8u2nK3eAjVCzSnKQYNrI7P5Xp9OhGmKcHYL8It87WHNb5d3BUaBIRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769095120; c=relaxed/simple;
	bh=f+GGFDfnQNRvruYoiEZmHylk7P7mRMfGPaBS0zuNP/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2cBEkIN2cPQrleQOAZyQBoKnFkUL0XBLmfdhrzJXt+X+kH8Jhd5Vt/tENYhvATO+lRHci9DWWB7Scb2c1xh5rAefolaLKDevVvf+27/MYfyNT3JV46qovjV0s35cYqV3PUVj9Frntb4XQLtC4F2xesYvjxMG/FTRLzaPe0OKH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=txkh47Ts; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="txkh47Ts"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Lf8vDYqu1Xu0V5DclzIs8XXcHnL+X33ULLs3B4+PCl8=; b=txkh47TsffNxAQyn9D7y/qFpdO
	GtDdajbkxbuL1vAjxWKuPQwJQ0NXnQdU4YPkKC7m5zarvb82G/cSyr6dNRt7u5SZs9VI0A6jJ0mup
	iF39nbqTwjZjWPiMBflT7AodZF3kzC/IR2B3IVXx5f2E2SUbitZXxkvfQxt6I2uWeiy8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1viwS1-003zTF-Us; Thu, 22 Jan 2026 16:18:25 +0100
Date: Thu, 22 Jan 2026 16:18:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, dlan@kernel.org,
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
	pabeni@redhat.com, spacemit@lists.linux.dev,
	wangruikang@iscas.ac.cn
Subject: Re: [PATCH 1/1] net: spacemit: display phy driver information
Message-ID: <4493e09c-e4fb-424d-a44a-1e4d4510e4e2@lunn.ch>
References: <b4e0b1d2-cd6d-40f3-89fc-c1bd41c82480@lunn.ch>
 <20260122150601.586846-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122150601.586846-1-amadeus@jmu.edu.cn>

On Thu, Jan 22, 2026 at 11:06:01PM +0800, Chukun Pan wrote:
> Hi,
> 
> > > Print the PHY driver used and interrupt status after connection.
> >
> > The standard way to do this is call phy_attached_info(). Is it missing
> > some information you need?
> 
> I initially used phy_attached_info(), but it was too long and printed
> phydev_name() "cac80000.ethernet:01" twice:
> 
> YT8531 Gigabit Ethernet cac80000.ethernet:01: attached PHY driver (mii_bus:phy_addr=cac80000.ethernet:01, irq=POLL)

This is what everybody expects, so you should use it.

You have some control over the names, it is the name you assign when
creating the struct device. Maybe you can shorten them.

	Andrew
