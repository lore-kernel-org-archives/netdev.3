Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4902222AA;
	Fri,  4 Sep 2026 00:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481754; cv=none; b=ZObTHY2ultBedzZlZsAl1NKwTYfbsXagwewcnr+KsAb3RokOzIcl0fqU+KRDh7Mq+MJqpFcuxgy/JUEgHP6/z7XjjKFcFGBs6cM5i0uoyYr/nZ6v2FAncn/w2tJgTp/59aPBjbYnaPOPc12W6oUo+KJR3BESRKweSW6WapHoRmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481754; c=relaxed/simple;
	bh=lM2bBVpkOaY1gWE1D3o7+lOIyxR8QV8/FKxB7p2aH+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrQ/C8yhQZlXLsjXgOsqLshUmPdsSwIhQ4chC5sSGyAJ5yRaM5iNeSikLh+3Df32syshVIYLfuxfEDHVNKKsdx8pDI4yKBTvjFnv5x3243ktsdx1DmSi2U20XMUkWzOdY8AJ4tnsqY1kgspap+fLKYe2Lk8iCMxUZdCsPgIwQgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=A+WhuVTp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="A+WhuVTp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/uuEwAKm6y69l4WVF1iKAcH7RsgH/xAYrU/IqgK4CdU=; b=A+WhuVTpXOk118hcIhD154rBsL
	am9qmdaqvJR+rQWQGK7CIuPunLGzb2IZPgfh3ElZ4DeJEUmwXhgPaAHwSirXvb5PqtwxoVHgJZHKg
	GI0JhAPO/vhXfkUZwviRK65xnDw8GfrPh57v0KWQ9924sKUSbroTbVtDyQK0V7dob844=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x2Hnh-002p5U-4G; Fri, 04 Sep 2026 02:29:01 +0200
Date: Fri, 4 Sep 2026 02:29:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 2/9] dt-bindings: net: ethernet-controller:
 add slow-to-probe
Message-ID: <c2f1d0ab-ff66-46cc-b6ed-897e760ad88b@lunn.ch>
References: <20260829052546.1152446-1-f@lex.la>
 <20260829052546.1152446-3-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260829052546.1152446-3-f@lex.la>

On Sat, Aug 29, 2026 at 05:25:39AM +0000, Aleksei Sviridkin wrote:
> A port can reference a PHY whose driver is not usable at connect
> time because the PHY's firmware, or the module carrying its driver,
> lives in a filesystem that is not mounted yet when the controller
> probes. Today such a port is dropped at setup and stays unusable
> for the whole uptime even though the PHY becomes fully functional
> seconds later.
> 
> Add a boolean the port node can carry to declare this expected:
> the connect keeps the port and attaches the PHY once it becomes
> usable instead of failing.

That sentence does not parse for me. I have problems at the :

> +  slow-to-probe:

Maybe this should include what entity is slow to probe, since this is
in the MAC node, but it is not the MAC which is slower. We might also
get the situation that the PCS needs firmware and is also slow to
probe?

	Andrew
