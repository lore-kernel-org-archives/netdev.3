Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7943A1A6801;
	Fri, 29 May 2026 22:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093235; cv=none; b=ED+JatC7ZnDyJLj5Putjo3VGyyKWgXZKF+GQLsJBopzB1djjR6TUSICXosF5HZt/kcqUSthNh7wRDprvncpyeRhzJi1KJ6Z3zGgPh1sdsjLyhwowLWl5crIV/QxQ8OmiYV0iz0kRaHgR2AEonm0nJfHzLT3GNlgbakwqtvkisKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093235; c=relaxed/simple;
	bh=mUcfMFIfIFixpZKAGeb9swVPvFiHk1Wy3Bj8aajcYf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iU9nTBSHXVlM+zaIP4Ba7xPt9HbRqrbncHd5Q74d7KgyMAwO5fncSwavSHfk69ZIp7KthWlUGEWQ5Q1t5R8/68Ijls2m5D201eDSjG+4d2sJV4lk8AfS+CyYmMPDPhMvFiYxC76Qbn54r6XqW8oZST3TgnjTM6YR/OgE5QNLqSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=M6hieMaW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M6hieMaW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tOwEDJEHNi0JB1hXuw1FNdRIzzl/AL2NjPHmf4QK9fs=; b=M6hieMaWbWKN4uyh+QnkkU4oKO
	KUaLdn50NWH/bs89BXvX9jcprcsvYjv2Hta00bAlarRvJsA8tXb88ScBf00L4jqli+3Jw19M1WM+F
	ifKsufGf4qwbw6Z8TknAv9krbPeLtpcEE+DPxyL/F12wxCWM9IJaKHSuiXLWjsyPSUYI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wT5Z0-005B4D-Ts; Sat, 30 May 2026 00:20:22 +0200
Date: Sat, 30 May 2026 00:20:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"wahrenst@gmx.net" <wahrenst@gmx.net>,
	"jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 03/14] net: phy: microchip_t1s: Use generic
 APIs for C45 read and write
Message-ID: <133ce346-5bf3-4eb2-80ae-89836adaeb17@lunn.ch>
References: <CY8PR02MB92495A456BF9029FFCC1D4FB83162@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB92495A456BF9029FFCC1D4FB83162@CY8PR02MB9249.namprd02.prod.outlook.com>

On Fri, May 29, 2026 at 06:39:39PM +0000, Selvamani Rajagopal wrote:
> Replace vendor implementation with generic API to read and write
> PHY registers using C45 bus protocol.
> 
> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
