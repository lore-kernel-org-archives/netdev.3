Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFFB50B8A1;
	Wed, 30 Sep 2026 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782523; cv=none; b=bvw6h5k9ObMizje3Sf7bhLrD4bveo/uzeH1slJEPVLRKu5aCafmssvaitpwtv9XuX9+lcizevuV0dHLAtrGcJsKKwh23YL2QkYNq6pGviMs8aQMGeU3bpCqDGDDnOEkwwEiKUc7Cr1RTRx0KoqoVaZ2hKCG2mgnsaOnO99SQjos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782523; c=relaxed/simple;
	bh=LQ9523PqMwp6asxSRjh88A7+vdB1cQFZ+NZk3IB6XRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqcdlHPVi+fJCYvG7bDMCraRXJsh+bwZAC1KjTMipOf0u4LGkm9gVP6eCSK8n076lucilv+6EWPvFmExGTcqKqvyw7U/uQL/Lx0VRNfkOrQrJuzRRhwrcAJQLOyxdm0q6cnqUSohWPf4RzOiYs/kRY6YegTyyhQCm7nGKmyDw1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lPmI/koC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lPmI/koC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qVYFXys6e8hO1IMWu88kIXYiUK7hAuy8M6s6wk13ceM=; b=lPmI/koCnimrjtsKRJhvsE6xUh
	YjvV7ede4D9/KzClZ/7ujfvU/0qCsYllIN51KKANhwteNSByrxh5GlvRNUf0t1uWxDRmR8y/gjp1O
	u9vS/MExF0twQMxe5VKUuWJeVMCYh5xZ7gPHgLFc3jTxv0bT+qTAS5GoQjEF+t7K+WKE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBwKk-008BuX-Fm; Wed, 30 Sep 2026 17:35:02 +0200
Date: Wed, 30 Sep 2026 17:35:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Robert Marko <robert.marko@sartura.hr>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, hkallweit1@gmail.com,
	lxu@maxlinear.com, michael@walle.cc, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	luka.perkov@sartura.hr
Subject: Re: [PATCH 5/5] net: phy: mxl-gpy: support MxL86211C lane mapping
Message-ID: <3fa11f0a-3b08-460f-9355-72011dcfa7b3@lunn.ch>
References: <20260930122305.293686-1-robert.marko@sartura.hr>
 <20260930122305.293686-5-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930122305.293686-5-robert.marko@sartura.hr>

On Wed, Sep 30, 2026 at 02:22:17PM +0200, Robert Marko wrote:
> Configure the MxL86211C physical TPI lane to ASP mapping when it is
> described in DTS.
> 
> MxL86211C supports per lane configuration.

I assume you have a board which needs these features? Is the .dts file
ready for posting?

      Andrew
