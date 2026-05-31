Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAA938E8A7;
	Sun, 31 May 2026 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780238869; cv=none; b=IEUsilPvcQmuwU82bw8ws+FnLLLVSV7EBSJxeOJzEplzuHgtufImm/my0FpfAHB5mn1VT8V/N/difk7aileWYWWiGmn5AxtABPw3SuZaMBY1hyyPfVuaEpyo1iOEk+Yh8yAua9Q0kOXg2e1c60qwsmFqnkSeSM4cBE8go/4oKVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780238869; c=relaxed/simple;
	bh=yJpGKoxqyiB19KlA5PES68wyDY7jMsLbW2SJRIE7BpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0Mqr9Y1QZo/8d6CHXKozDSfi+PUn398Pvllst862CgppHzd0AsB9hYTn02ajeEr+bMN8QKR3Ii12Re68wmR3uDGgDNlBFZVJP0nx1Qk1oggfbR2E4ONUzm95bH9OZeFxHyrtvksInkt2D+i6yXqDGMrqy7wCyalckhMXYt6fFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oru0TJ3Q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oru0TJ3Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bWMd1FLZF3S+TqaCfEF/eAHz6A8bYpZodGO1NmhS3es=; b=oru0TJ3QHQA3cxtSHS+Wgalrzu
	XQ+xaEizPeZp9IlODw5xxTEPyKpccUiIAN5MOMimMIJC/xs8lC7v1Git7uoQTtZCjOxCmIkwjgRdZ
	d4HW8xG/udpWb1GA/fPl/44c0DHTo+dB1xm5QvrnsuupjNmKkTBxfQiPFZtb4mdX1R2c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wThRt-005MtI-1d; Sun, 31 May 2026 16:47:33 +0200
Date: Sun, 31 May 2026 16:47:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 07/14] net: ethernet: oa_tc6: Support for
 vendor specific MMS
Message-ID: <23748e7e-6b2a-4338-9eaa-d80605f76b6d@lunn.ch>
References: <CY8PR02MB92492F5D3DB407A8392A36A783162@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB92492F5D3DB407A8392A36A783162@CY8PR02MB9249.namprd02.prod.outlook.com>

On Fri, May 29, 2026 at 06:40:09PM +0000, Selvamani Rajagopal wrote:
> OPEN Alliance 10BASE-T1x Serial Interface specification, table 6
> allows vendors to use any memory map select (MMS) value between
> 10 and 15. This new API interface enables vendor to map one of
> thes MMS values to MDIO_MMD_VEND1.
> 
> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
