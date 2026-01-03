Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD16208994
	for <netdev@vger.kernel.org>; Sat,  3 Jan 2026 18:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767464054; cv=none; b=rzl59ljUcGs4LAah28msAh4oib76XzIC53nb+MboH+k+eTvzhoG4e/U/f+Zmd6fbAuVw+jEceCnyyr9TTS9zpZCTgojkNxup9+DCyoBwV35AOBlOAil2xiXVdqbegoxKfJkIPPkZX86KohQ26ekx0ETIDAVpzp1+Oo+P5fDF9wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767464054; c=relaxed/simple;
	bh=50VqyCT538dOspdKIyMvdccwY4KMwOwqiR27ePiLcyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNAQQKY3QTDIz20C9kxDM1YBQVcL6yi7jhEF6TlWTxzuKVNB/fEhGrSuvE3xNNUQ1pqrxcSsHadfCt62ZQm/N3tizeUocTkSBnRSpG5dbe0EtNtKhC6C4PnF7NPERLvGeDy/5v6mqrHy+U72r+wDHVlhvSdNeeZ+Pq21+SV6aT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=H6D2Em1D; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="H6D2Em1D"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=W9FefweBCMSfI6CK01SPV0RuNOb0HMAWHKaWzxV36fo=; b=H6D2Em1DWZ/gYBvUPJ1snO8IPS
	OjQ6cT5DiSigRaRFT2M8AR3Fmvcfgc5xW0m/ZoQ2P1w5WXRHQRPC+18ttd8/uQTBoDph9CvY8IMXd
	RdjuSbzsRielty9bVHhfAFflsTImBq04QKm3jQbvKsLmw8a8sU4E8o0tqavUx651oDfw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vc68V-001Hhb-Mi; Sat, 03 Jan 2026 19:13:59 +0100
Date: Sat, 3 Jan 2026 19:13:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: vadym.kochan@plvision.eu, oleksandr.mazur@plvision.eu,
	andrew+netdev@lunn.ch, taras.chornyi@plvision.eu, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH net-next] net: marvell: prestera: correct return type of
 prestera_ldr_wait_buf()
Message-ID: <a16c5e5b-8431-4948-ad72-379375dba096@lunn.ch>
References: <20260103174313.1172197-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260103174313.1172197-1-alok.a.tiwari@oracle.com>

On Sat, Jan 03, 2026 at 09:43:10AM -0800, Alok Tiwari wrote:
> prestera_ldr_wait_buf() returns the result of readl_poll_timeout(),
> which is 0 on success or -ETIMEDOUT on failure. Its current return
> type is u32.
> 
> Assigning this u32 value to an int variable works today because the
> bit pattern of (u32)-ETIMEDOUT (0xffffff92) is correctly interpreted
> as -ETIMEDOUT when stored in an int. However, keeping the function
> return type as u32 is misleading and fragile.
> 
> Change the return type to int to reflect the actual semantic of
> returning negative error codes and to avoid potential issues with
> unsigned casts. There is no functional change.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
