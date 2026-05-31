Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BD030E0E9;
	Sun, 31 May 2026 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241017; cv=none; b=ZD6jXdTe1GYW9048leoOVBZFUeCkfid0EwqaRPTB16ncmIrOpOUk+H8ytc/2QWbtvxLxibT4m5cf7SckcqoQawb5/DN6TkALh97vxytqR7QmYNCUqotEEsH8duoiJkuj7PjDV2Jg6mzvPTjzgYyO7DbXNrYJ/pPZ6LGAdPFRnHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241017; c=relaxed/simple;
	bh=9+GoCLTacqFsxBUI4rXF+9XRsxxKX2H6KWw2m2AdVsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPftBNxTumzC0d6f0iUc9FfoSlvNFr9wXGoeWy96fnrZ7fRvXVgFGpLVIGBb5TsiBHIbgmXtAIEKtmNaSm8sDWDi26GzGvB2vSajSu9f/agfie2YkD5WPIYub2i6HSezi2h35KoI1gZZ0FYJOmsRd7kfvS5JWeGe3aIDmDmcJYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RGgutXqX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RGgutXqX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FVLcp16kWlnIgiT4A2M93BI7rQzuS5B/fT02iYN5hZ4=; b=RGgutXqX4YVefeJ3S1+vO8gyid
	u8+fpadaehkj+v7PFWJfOaXa7GdkZDSGvvGo4DHsFC8X2qb6Z20+SfD9LuTSElgNbJtIdaGCCmPmT
	vW+081yMV8rnpOLbh+gS3YGhkkvd56tj07qd//1h/MKa2eru4nF4DMfDciazWCALEM4I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wTi0a-005N5o-71; Sun, 31 May 2026 17:23:24 +0200
Date: Sun, 31 May 2026 17:23:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 14/14] Documentation: networking: Add
 timestamp related APIs to OA TC6 framework
Message-ID: <53d5f13c-7095-49ce-bfa6-fefee9e0c4fe@lunn.ch>
References: <CY8PR02MB9249D1ECBA54A1083D404A6D83162@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB9249D1ECBA54A1083D404A6D83162@CY8PR02MB9249.namprd02.prod.outlook.com>

> +Register the PTP hardware clock related functions with the kernel. The module
> +simply registers. Hardware timer related functions are provided by the vendors.

This last part should be expanded. Please document what is actually
needed from the vendor code.

	Andrew
