Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9248156C6A;
	Wed,  4 Mar 2026 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772632608; cv=none; b=Ob6v8P+22+gTlawAHQqIvinP1IucJ9lepz/R74KsdkxyndOKe/8t7GC4DtsXcgcGDj0C7xDmSwjAs+V0l0F7M3fEm3pZ6A8VdZWJZuKlsRsPuzLSlm0q9c2IRLeqFZe7hBxmOBQch1x/q2VAi4g/7CGFyjYRR4h+g9mgcHTEjl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772632608; c=relaxed/simple;
	bh=dzQ5Z0aWE6Qj7FDEDXMAwnOwPDdvOzGKs3TewCc9a34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQdhvzxx7/r9vSeVeAq04/X5gIwAWy0ivUvNFsQ2P6C0wNJQ1TloCSwjBau31xYy+uGK6s5Q5XoccBJJ6owUjZigfmyKy+iSgQAVWA9fpB3P/p6BF3bhjrdk19Fnwy39g9MGa57n8bNLa3QsPofNUKQYGoUiUVYcY1sPobbA6LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=odAkdFgD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="odAkdFgD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dRGxkNI+jiy5ziDfD2yEF2JYrz4BhhOkGGuTJeJcL4c=; b=odAkdFgD9Sc7pzOLhuhHoxkP/H
	FPePLdcjvJzQe5LVNXJSoYY1GiNHZUGPPRuiTP8G10My3T0lfTNfuE/Thlkco5BXomdY71oighoYb
	PP8HtVCH9U5izk4EfDOReAPO6bhhxe/dX5ertTDqsTiXrXZM3ktJ218wUy0W1BmOMfZ8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vxmi6-00A6Wz-Om; Wed, 04 Mar 2026 14:56:22 +0100
Date: Wed, 4 Mar 2026 14:56:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Illusion Wang <Illusion.Wang@nebula-matrix.com>
Cc: Dimon <dimon.zhao@nebula-matrix.com>,
	Alvin <alvin.wang@nebula-matrix.com>,
	Sam <sam.chen@nebula-matrix.com>, netdev <netdev@vger.kernel.org>,
	andrew+netdev <andrew+netdev@lunn.ch>, corbet <corbet@lwn.net>,
	kuba <kuba@kernel.org>, linux-doc <linux-doc@vger.kernel.org>,
	lorenzo <lorenzo@kernel.org>, pabeni <pabeni@redhat.com>,
	horms <horms@kernel.org>,
	"vadim.fedorenko" <vadim.fedorenko@linux.dev>,
	"lukas.bulwahn" <lukas.bulwahn@redhat.com>,
	edumazet <edumazet@google.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN77yaW1BBVENIIHY1IG5l?= =?utf-8?Q?t-nex?=
 =?utf-8?Q?t?= 11/11] net/nebula-matrix: add common dev start/stop operation
Message-ID: <66a61cf8-7dbf-4b33-b687-b44debf7e726@lunn.ch>
References: <20260226073840.3222-1-illusion.wang@nebula-matrix.com>
 <20260226073840.3222-12-illusion.wang@nebula-matrix.com>
 <b8f71f46-735b-4b1f-8df8-01a532bc7964@lunn.ch>
 <34c4ed3f-fef6-4c4c-8b0f-9951fedf580c.Illusion.Wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34c4ed3f-fef6-4c4c-8b0f-9951fedf580c.Illusion.Wang@nebula-matrix.com>

On Wed, Mar 04, 2026 at 03:20:44PM +0800, Illusion Wang wrote:
> 
> > > +int nbl_dev_start(struct nbl_adapter *adapter, struct nbl_init_param *param)
> > > +{
> > > + int ret;
> > > +
> > > + ret = nbl_dev_start_common_dev(adapter, param);
> > > + return ret;
> 
> >return nbl_dev_start_common_dev(adapter, param);
> 
> >But then i have to ask, why bother having nbl_dev_start() when you can
> >just call nbl_dev_start_common().
> 
> You're absolutely right. However, we're considering facilitating future
> expansion for the next-stage netdev configuration.

You seem to be over engineering this whole driver. It seems a lot more
complex than it needs to be. Complex drivers take a lot longer to get
merged, some never get merged. Drivers which start KISS, and slowly
get features added get merged a lot faster.

    Andrew

