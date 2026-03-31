Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3C6199EAD;
	Tue, 31 Mar 2026 01:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774919280; cv=none; b=ACgdIRcEii0yihAXVFfEE8nQi51nK8SvRx9dUXkubrdULNxkKTd/a7eRjqrJOzwqpxwGq3ghpKY4Hr1R77QGsvPpq54pe3dUSfZZY5nwdvs2CN5Xb6wSDA9nwI0PmrcyWTK4zxTQh8TZTr9yR2eLA2O0VLnfmDqrUOxMQqI//j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774919280; c=relaxed/simple;
	bh=YPKedhinytKiFM0fCdGWpHxSrEqj4peL3W4HELhDc5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7q8yhKm2F4PIPxV+l/MAly82e/u8FzL7xikWfep9A2SqgRc4vo4uLgwj0izk+LB2Hp7sZNjIMjrWTF4NydSGSafO6c/BSMLsGL1Y0oqQv53oeI5PvRZHYGrCsn/cirEAz0p+3tkigh2h/uuWdNxMPTYg7qB6WeLEIRiV4sbJr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GkKF1MWD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GkKF1MWD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pkngNd6jf/U4DeIklxaRbT3w8CR4haD9hiqqW+Z52cc=; b=GkKF1MWD45LJjuq3sZ9HD+UUR1
	Lh6qHABIGTqroDP3XSSLo7AinZKAMwfonGsKzD1r06DiRBjv2fYvtWWRg8wepm9w2meMbuUdJ0DO/
	2hLUKj5vbQ+j6Jf5HkrzfDZi7FtW4PaqJj/hKXD4khBeG11Cj7FDd6jmFynPE9p6/7Q8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w7Na9-00E7Pz-UX; Tue, 31 Mar 2026 03:07:49 +0200
Date: Tue, 31 Mar 2026 03:07:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mxl862xx: cancel pending work on
 probe error
Message-ID: <b94aae11-e0ae-495d-b440-c3b89e251795@lunn.ch>
References: <3fd163f5bb88de426ca9847549f94b4296170ef0.1774911025.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fd163f5bb88de426ca9847549f94b4296170ef0.1774911025.git.daniel@makrotopia.org>

On Mon, Mar 30, 2026 at 11:52:09PM +0100, Daniel Golle wrote:
> Call mxl862xx_host_shutdown() in case dsa_register_switch() returns
> an error, so any still pending crc_err_work get canceled.
> 
> Fixes: a319d0c8c8ce ("net: dsa: mxl862xx: add CRC for MDIO communication")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
