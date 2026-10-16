Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8036312815;
	Fri, 16 Oct 2026 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163900; cv=none; b=k2EaHHSJLTek4xOzKXNEN/NUanjKmxQ9TX13z9WwbtWeq+QFTnI38j4FDpMBmVtT8EiD2mNdZoiqf3+tsIzWjxTqKB1Jy827K6U+FSgadwGI9zc8LCzb743+013A54RV17fJkQKg1925ChLp7rtntcF61+L0qggH4CBs1Z8AwXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163900; c=relaxed/simple;
	bh=7hXisu0buXn1ocaN/QSBIXUdN6th/11AfAFa14tgl80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUzDa3atMFOqUlIVcTz5WyKcNq3JsYUKm6Z7dU2wzW9/XMzYyeoVQbjbxw+rLI7JdXZ345GqkPVWThrrWFGiOC5/TiB8Ys2hSzkkVc6rFwPbL0oXwlfjdCoLZAIdTdUucDr/TtZttBkhkEC2tj3oXIgNqcm5WlrgPWuc41xctFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kBQUxyZ2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kBQUxyZ2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bAeJYFRqPlmLLhZ5DHrTj1KzskJiPmPQV7ulkxgT2/s=; b=kBQUxyZ2Gvu/cIdI/fqVcAU5VZ
	Jzxrk4l8KSbo8MjO4C/lCE+fRYKvCQ9Lf1RjjPWVsi+bUn9cRzXcuq8NdztEiCoIz/YrGa1cFsEtd
	oO2X0Wa0SLvlNdsMcczWCn49SOkbu61Lf2IFW+lE4j8qz0Uf3EKy1wFSyiRBYQ+dC/ns=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xHjhC-00BAYF-7u; Fri, 16 Oct 2026 17:18:10 +0200
Date: Fri, 16 Oct 2026 17:18:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, hkallweit1@gmail.com,
	linux@armlinux.org.uk, Frank.Sae@motor-comm.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com
Subject: Re: [PATCH net-next v25 3/3] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
Message-ID: <a1895927-77e4-4e71-a238-d2d9a50856dc@lunn.ch>
References: <20261015145021.2216003-1-kyle.switch@motor-comm.com>
 <20261015145021.2216003-4-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015145021.2216003-4-kyle.switch@motor-comm.com>

On Thu, Oct 15, 2026 at 10:50:21PM +0800, Kyle Switch wrote:
> Add support for Motorcomm YT8824 quad-port 2.5G PHY to the existing
> motorcomm driver, using the phy_package helpers for the shared top
> extended register space.
> 
> Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
