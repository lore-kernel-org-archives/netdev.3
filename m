Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B88436403B;
	Sun,  9 Aug 2026 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786311466; cv=none; b=l/dDOQCH8G0nCR6bZNmdrteyAWWW42xTy7NpReJNP4D3E9S9cmY+qkGDav8QKle/QXyjGeqWQKVpNJWE7IJRIXLJBbJrlEmIu4zAbtVLonsh18fUU8dYbngJdQEHwn3NgzcitXSHb81/NvVRNIu1RsONRSzaJ9RBb+511BmP7cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786311466; c=relaxed/simple;
	bh=N5t/tFWg93CtyLndtH9fD4j9bkUCdKuNRjzPo7HGjDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cF0D8rzyJHoKAjuTTm6Xy3ukwaH7kPudf8P98ppJ6UGJL901L9mC0GVfinBBlwW3HX2sb4Pl1bG5ETkclzXxTQPFA8jLjsGtBjlUjLcAbbzcoyF4l1Q/7gnPU1cboYEWZHx1Yw9fg6xLLGCRb8zpeUfZLcjvUXSqjzw7Ke8z4Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eB9BP9gO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eB9BP9gO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LkXeMyeT3OPjriEcH3/hxCWMIrPjMMXov1/nB+uzpVw=; b=eB9BP9gOipIwT8/DJSQl0gAb1y
	vyh5/Jf0ujiG1OVNjVUDN3zGMhNQFa30G3Rq7YeG52LqyTQWQwjIbHxja4uu+NRe7NKegiPR41C3G
	9JOfGW3HNlK3f+VfZWVSZQasDD0hZXqOBb7eI76xVJ+KddxM7u2C1JlydGpqKT0YF/P4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wtBCm-00GrEP-0d; Sun, 09 Aug 2026 23:37:16 +0200
Date: Sun, 9 Aug 2026 23:37:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v13 02/11] net: mdio: realtek-rtl9300: Add
 polling documentation
Message-ID: <1011a17c-0c59-4b9a-a148-e6ef91f2ef0c@lunn.ch>
References: <20260807171058.522833-1-markus.stockhausen@gmx.de>
 <20260807171058.522833-3-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807171058.522833-3-markus.stockhausen@gmx.de>

On Fri, Aug 07, 2026 at 07:10:49PM +0200, Markus Stockhausen wrote:
> Add a detailed explanation how the hardware polling unit in the
> Realtek Otto switches works. This simplifies developing future
> patches and reviewing them.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
