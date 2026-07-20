Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B996A41B8F1;
	Mon, 20 Jul 2026 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784552043; cv=none; b=CQqvQIAq8d5SlPaIYqk3uyfXUmbLFYtsJ+WOuCstEm3jrL7bmNwiJdH6Atf2IH4kHAnV9TOjpoFu0b9bhrtDxOwhkPJ0V9TqNsEG48PW9yzR1nUiiKu+/BX5xSypiwwRKefbx7TSCljrBxZsWtyQDtcaaYNFxjPoXgRdJ0/zxbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784552043; c=relaxed/simple;
	bh=Ph0xsHWFlp6M/sJI3+/zWIpIArglFlquJ5pz2Ln7rXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9acZ3HVdZsd5SqmBp+DnKuTS9pw8n5ItOy7LEhbL6IQJVrgcuX2+IjUnxlUd9WNX5XVOKoBEi0/iw7W0ZL147SWwFULiG6Pf4ARPjvxhBnZObuA02r/7SsDAAZqoduL5z8HO2/urFQY3kT3z0gKSHHke5WTh/eOXCQBYlnJxUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=wLC+Oz2/; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="wLC+Oz2/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xn8QgODelX8SRdXOis3qJa6DeGttzHTXMrwHPpIW7lM=; b=wLC+Oz2/8S/4l7X5ji1xarUrvZ
	+ick31cUHPJ5B1GxHuyIh7Rxl3zX8d/nZul/cecoCEhrld6GjhSpfhlLAdDwfG/V8fz20J2akVGfE
	iDbaCNfY05DroXHGftZ7dr9mADqX1zNqysFzAu+eVssgQaoXtNGHcHMVwMbEcfzp0b7Hl3siHc4XT
	n+9Zu6lbYdzm+fCeFpif8dww4nfA2izICrA5NyWHpPQi5RFbANQhzaF0gA6KfUM3xvSvVSN9dVhmH
	+o1aKnym49K8D6O8raqgWPu1XFhwuSStPtkN8IdhDtg+OIUuZPNgUXIuX0kSN0dmVr+M8oIlnB9dO
	g5asmCNg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wlnV8-001Rsi-0o;
	Mon, 20 Jul 2026 12:53:42 +0000
Date: Mon, 20 Jul 2026 05:53:37 -0700
From: Breno Leitao <leitao@debian.org>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] e1000e: Fix out-of-bounds MMIO access by validating
 BAR0 size
Message-ID: <al4Z4_tFbyQM-ogu@gmail.com>
References: <20260715035850.588070-1-pulehui@huaweicloud.com>
 <al3uh7OU2OtkEkSY@gmail.com>
 <ffc0a0d8-6560-4589-9570-04f40d817009@huaweicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffc0a0d8-6560-4589-9570-04f40d817009@huaweicloud.com>
X-Debian-User: leitao

On Mon, Jul 20, 2026 at 07:56:20PM +0800, Pu Lehui wrote:
> 
> On 2026/7/20 17:47, Breno Leitao wrote:
> > On Wed, Jul 15, 2026 at 03:58:50AM +0000, Pu Lehui wrote:
> > > +/* Minimum MMIO (BAR0) len, the largest offset is lower than 64K */
> > 
> > Why "the largest" in this case?
> 
> Hi Breno,
> 
> Thanks for pointing that out. I meant the maximum register offset accessed
> by the driver.
> 
> IIUC, common e1000e NIC usually have a 128K BAR0. But since I'm not 100%
> sure if older NIC might be smaller, I picked 64K as a safe lower limit
> because it covers the largest register offset used in the driver's codebase.
> If my assumption here is off, I'd really appreciate any corrections!
> 
> And for this comment, how about the follow?
> /* Minimum MMIO (BAR0) length to safely cover the maximum register offset
> accessed by the driver */

Thanks, Would something like this be a bit better?

     /* 
      * Smallest BAR0 that covers every register the driver accesses
      */

