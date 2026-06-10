Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7C62DCF6C;
	Wed, 10 Jun 2026 07:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781076228; cv=none; b=Y72k5iPNK3N6MVG70AxVE6XBAq+eiydoyUl+ulsPivXCj2n1MhRMS286sTxtaozbETkyywFNMgiuEjbRlBffOnSooBvu2M0YhDiITIrpL32CgC2PCWHCpdzbzBOq6uqm1tUmNbMq8ataxX8WvOCN5n1H0vl0Q3m3tzd3Ssv9OKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781076228; c=relaxed/simple;
	bh=l1+DPqvMAgg3HOOALyhkcYJXxQRVlS9p5VuUtJl8PdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itN8o5sgRaAZsbgaUwtlTP/m3m/yETVtWg39WwI5+nl446GpGlm7WpWE/ctS7N/4V892LK334M/neocbtwpsQgoeotCt+BmNKsE8HxOh5pwPCgwwz1dfmqSnUSv112WvFtgkuLChm4UmlXgohSOVq46QuyiYZhi9DPsERWCpubw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZbIzPaQQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZbIzPaQQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9+73fvhzH0/0eG8vkUrapayA5/sgEVnP+SMhnMVF+eQ=; b=ZbIzPaQQl7esjo1YhKh/ff5FZE
	RVjdf7asLlJ+lGRozwH+jUPEVecZ2bNkxYZ7adwxjFhlUMBX0DqM60RJhuiuB0X+GHyb+MN702L3X
	NB0xC88/G/kW1GgIA4K05fhRPLf0cLJ5NnMV6pDR5Y+3fwRselSRErYj3GJtIGn25ndQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wXDHl-006wH1-76; Wed, 10 Jun 2026 09:23:37 +0200
Date: Wed, 10 Jun 2026 09:23:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: loop: Fix devlink resource ID
Message-ID: <53211107-5f22-4ea6-8374-b70317b9b2cb@lunn.ch>
References: <20260610062554.769892-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610062554.769892-1-mmyangfl@gmail.com>

On Wed, Jun 10, 2026 at 02:25:45PM +0800, David Yang wrote:
> Fix collision with DEVLINK_RESOURCE_ID_PARENT_TOP (0) by keeping the
> real resource IDs in enum dsa_loop_devlink_resource_id starting at 1.

Please could you expand on this. What is actually wrong here?

When i look at mv88e6xxx, hellcreak and b53 it does the same.

     Andrew
