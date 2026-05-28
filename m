Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475883783B5;
	Thu, 28 May 2026 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962698; cv=none; b=hQJ3xcl5g4lBM8l8Z30Kjs6Xoe9Rn/y+U8na2Fj8nE8W46vKecNnvGeHVbRRajQ7MxwNdJOSCbXR5sRilBThjK9XdELR6ZZM21aEoyU/NbTKc8Cj/0e9ua4o9BNLmergWz8gluujVmlsdVxmdru6xTGrvEctD5CKbSYCVFcwIrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962698; c=relaxed/simple;
	bh=QoP7l8m4J9iMwRF+bg5hnUa7DwdXtxu322JHk/Kep2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVo+jyOlgw1+70m/RD6SUZmHIVDycmk/BkamGCqkWT5Fa60r9M2PVlSj0ozIWqhCGBuL8aM14vTnbyu2ZJA82ZKGLPn3F36ldrM1PkGEhNSjV1o2ifDsfzdYoQVsLr8wW/2eAX2i9IMKn1beSKL/Ht6P5XL0UIvjTqCGhT5ds34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkUwgDz/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkUwgDz/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8156B1F000E9;
	Thu, 28 May 2026 10:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779962696;
	bh=ZUtr641Tb8/9Ppyf1hBIVtsR1pCzSTByWE9Y4T0unpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dkUwgDz/qjst0SG10cPF/178DIQU+F0P2JEaNxLY8k2f7XRBk40umv9ZeP736FzjS
	 AGz6EUrkMg+N5TalQqAWPKHvtMWm1vvGA654KhWUAkqaaAdhA8JnBbJJ3Wmmz1b0MA
	 OIBIWKnDDjBk4BcVI17F/m10NHUf14TB72CfGU4u33YScepfDOfBKALPe86x0o/aYC
	 r5p+3deywq+0NXt4Tk5qWrGzXlEwzwk5MOWRL0IDQvCFIfDz+c8yGMLcI38QRvoKRi
	 aiVzB1Ocw/vu9vdxceZl4FIAL1br3BsiuYcnkCoXle/6zIg7+gqwHwpIAexWY9DLKs
	 El1IFP/V/FC4A==
Date: Thu, 28 May 2026 11:04:52 +0100
From: Simon Horman <horms@kernel.org>
To: Len Bao <len.bao@gmx.us>
Cc: m.grzeschik@pengutronix.de, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arcnet: com90xx: Mark cards and numcards variables as
 __ro_after_init
Message-ID: <20260528100452.GP2256768@horms.kernel.org>
References: <20260516134628.30672-1-len.bao@gmx.us>
 <20260520201644.1528107-3-horms@kernel.org>
 <ahCNnuSAr2QpLl37@ubuntu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahCNnuSAr2QpLl37@ubuntu>

On Fri, May 22, 2026 at 05:08:46PM +0000, Len Bao wrote:
> On Wed, May 20, 2026 at 09:16:46PM +0100, Simon Horman wrote:

...

> Hi Simon,
> 
> I'm a newbie in the linux kernel development and I believe I don't have the
> experience to fix all the issues showed in this review by myself.
> 
> Also, you tell me to leave it be as is because it has no real attention.
> So, my question is:
> 
> Is it worth that I try to solve the issues mentioned or not?
> I am totally confused.

Hi Len,

Sorry for the confusion.
My suggestion is to leave it be.
