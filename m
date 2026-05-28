Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534013EFD36;
	Thu, 28 May 2026 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779972180; cv=none; b=AaB8VcngbMqPuC3oWJvqtPhhR7iG5PFJndMtwVUUjqFVPzlkLSPOfc4mZTN1tvGmsJeSCLmQyVq8nhLrHODSLRplzxtuOzXvRGHhNBfaCDxejh+BME8oED0s9V5q23k0yZQLow4WbNk+Uz6U5HuUuGUc/d+05alnij6BGW9W9oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779972180; c=relaxed/simple;
	bh=oElCyJHJ6VNdTgCd3tnBDKZLC6Q47wcfMz/OxOiC0lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLo/TpFx3mE5dh3rlI4HTBsFb1+ALR+e93so1FSnUF1eI/laSE6zdh2ywkIVKgXkVQsXOFgPb0t+KtxXHU9f3qwRLenNMlHyJTTHUW5VcSy32ShPPfGdlg2b7EDeXTnrNg1HluCfoMwoCA4NQuT4BCdXaTdQMcsm5JbdsTIYXAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pEZqzhQe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pEZqzhQe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IEjbkvghcg1Cm+l1dyBxOmTmo3+PsrEnHJ+zUPNWy3Y=; b=pEZqzhQeunKMB7AGQ6mVuwlEnd
	bsFt/7IxQt3vzGFeZVKV1++h/engRBnKphT/ai2ekFtXL+4XRCH0ePa//Gq7UDgcODFrWgDOiQiDG
	C/BUNV8vIIfK/0cBzdK2geRPWaB4RbIdCtljFxmB6V/1KFa1ZZYYetKxqv5cNviXq3q0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSa4Z-004twb-BJ; Thu, 28 May 2026 14:42:51 +0200
Date: Thu, 28 May 2026 14:42:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	freddy_gu@realsil.com.cn, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel@makrotopia.org,
	vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v1 1/2] net: phy: realtek: add support for
 RTL8261
Message-ID: <f1c392d8-0e88-425c-83da-038a884008d6@lunn.ch>
References: <20260528075226.1054-1-javen_xu@realsil.com.cn>
 <20260528075226.1054-2-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528075226.1054-2-javen_xu@realsil.com.cn>

> +struct rtl8261x_priv {
> +	enum rtl8261x_chip_model model;
> +	u8 sub_phy_id;
> +	bool is_generic;

These don't appear to be used anywhere, just set. Are they really
needed?

	Andrew
