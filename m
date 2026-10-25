Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792968736;
	b=Y46Yn/zH/jnL3kVauCmyrdbIf8zequ24hVS8jRgAhBG9IVw9v8+KjwitwuacLaU2lcJU
	 /lvaiGBJy5vAVBsX9xz4u5VGchXfPIfYCYJoyx14ctr2C6Df6b8w2Oe9REPkofIDEvgTK
	 KKfdXAZLRlncirMczSRLU4p+ppwxLWOCWyxGeTRVg+pzBMHE4gEYYnQVIXb+ranVO4ezN
	 vUfNEtxRES3sv9R6hA5JrFbnkyyaJ5efS7GvV3WitWAVSAtF9rQEt6x37tF4mFQz7GykQ
	 i60jdSHoOe6/wyURKU2stagNd6tLTeNm338C+xSsSTL1BEBRUJ75KqFb6J/YmsrB+lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792968736;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=4MqgIb2Gl2nEuxWB3kwgjNBYWP+TLsPoBNbr93fTbr8=;
	b=W5pOpjkAcaW+LBKGpxlmnRUKz6kEKrR354503P959eKv/MWu074oeaiMzVaZnHGvGRxl
	 Hgb7AA4OGO7yA1MNJSIEXTnAZH/RtBOfsWi+K0XHJsGH+PVd3slQpsuaMeylChiGsPaUh
	 0A3Vqoy1gp5RunGXIqnFJaXJ8rSiyPy9fzlHJA0381/7zTc5DUX5j1bLFEPh50V8QS1zA
	 xCNxtTrzDqJboQp124ksWTumG/SvfExdrWLJAqbI4N0z8h0Y7fdkOrMARRRZdEiwT47QU
	 ddVwIkMp23Q+pTgvVBeoUpvf//s+5bzwtNGCU2XwYnZvrzy/UKA8/xEK0HFYxxxEbHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=IG6Q6c5F;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F34606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 22:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62F34606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=IG6Q6c5F
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4MqgIb2Gl2nEuxWB3kwgjNBYWP+TLsPoBNbr93fTbr8=; b=IG6Q6c5FGxOoaGBFhwihZHIN3h
	1yikroi6wWVu5lHSwyTPyq+r6cQ1GS7qY7B4wGJLxQ1AY7lNW5C/kM8dvz+NRjCtFFJmspV4KdANH
	29cVnSuoK4OibVvU/BiavH8VYowLueetwh9tQn09hQ7doLLhASIWz/RAeCvYAj19lrK4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xL74P-00CipC-Nw; Sun, 25 Oct 2026 23:52:05 +0100
Date: Sun, 25 Oct 2026 23:52:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Chad Monroe <chad@monroe.io>
Cc: SAYANTAN NANDY <sayantann11@gmail.com>, netdev@vger.kernel.org,
	lorenzo@kernel.org
Subject: Re: [PATCH net v4] net: airoha: keep PPE offload when NPU refuses
 flow stats
Message-ID: <54711f8d-d71a-43f6-876c-d32f4c562b8d@lunn.ch>
References: <20261021100423.9159-1-sayantann11@gmail.com>
 <05adf618-f608-4c8e-a862-4c1d0779567c@lunn.ch>
 <J3XqO9fJOEvpsUH9m_DyrV8wgQzdtZdfhE8KZHv9ejvVty51zjizvG-0nmYn8ZhTGRJnLq0OcEbX7l3DvpqFp8dFEYuWYVpV5ZRKnGXmGKc=@monroe.io>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <J3XqO9fJOEvpsUH9m_DyrV8wgQzdtZdfhE8KZHv9ejvVty51zjizvG-0nmYn8ZhTGRJnLq0OcEbX7l3DvpqFp8dFEYuWYVpV5ZRKnGXmGKc=@monroe.io>

On Sun, Oct 25, 2026 at 03:25:28PM +0000, Chad Monroe wrote:
> On Wednesday, October 21st, 2026 at 5:49 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > On Wed, Oct 21, 2026 at 03:34:23PM +0530, SAYANTAN NANDY wrote:
> > > From: Chad Monroe <chad@monroe.io>
> > >
> > > With flow stats enabled, PPE offload setup requests flow statistics
> > > from the NPU. If the running NPU firmware does not support flow
> > > counters, the request fails and the current setup path aborts PPE
> > > offload.
> > 
> > Since this never worked, it is not a regression fix.
> > 
> > Why not keep it KISS and report the firmware is too old and suggest
> > the firmware is updated?
> > 
> > Can the driver do the firmware upgrade?
> > 
> >     Andrew
> > 
> 
> Hi Andrew,
> 
> The NPU firmware bin is downloaded at each boot and is present in
> linux-firmware so no issue with keeping it up to date.
> 
> The main reason for this change is to behave better when flags mismatch.
> Previously, loading a driver compiled with flow stats support enabled
> would silently fail to offload if the firmware didn't have support.

Sayantan suggested this is a regression. It used to work, but does not
now?

We should avoid regressions.

   Andrew
