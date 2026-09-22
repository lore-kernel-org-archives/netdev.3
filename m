Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809903CA4BC
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100909; cv=none; b=PWjFv9o/PWPoVc3toR5Fbp7RfTiqpLpQDPqZa8HxhrtPxQ36Co62VhloyExba/v3X0sXDBOY5/XTyzGSkCSlCF3ua+Af9T2kctJFFo+Ke2kuvpcpRb1dbjJ0jZVqnVchj0HxNcOPt8uMqdjtvMZdTDH+qGixGkrUfs345ZJcyHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100909; c=relaxed/simple;
	bh=Z/NEARBwcRN4gucgW1beaJ6RUdf4yT1Mcb5ydRZfw8U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TmTxwhYr26SxwXdyD4xhWtkhz0lQbFHArO7+PWyc8FaPa2+CEpf524ZFZalWm7XXI3V7hMkwDmc0KDOghJBuxpvXghrorjUGMasqTeFmKHzGvnlm7iaxHaFduIFj6Z5pN3sXXJ6GksI9l8AKRrHMbYFeq93rKouYDYRgShI7CCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUq+obgC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUq+obgC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E421F000FF;
	Tue, 22 Sep 2026 18:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790100908;
	bh=3hkNbDrZHwt3amQkI6GQaWw6v1TtXPbRje3GNcFKelQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HUq+obgCwM5x17NbFXp59esrrPgNZ91dUed27s/n1cfT2SFRS4s5fBHpoR527YeCr
	 Gdq/m+46B3XGN52kYefOGsvriGMfvPXdpc5Or4jRt+T7yQRiLPDU2HUWSGlLpwJZG4
	 JtEShvdfv8Cd+sHW54QGkNVyV+QNRlhxfJZFVRY793k//0QPY9ofTUHsl0ey1dJG2V
	 SnKN9DhMb77W3SVAs5VPkMVTc+4tfP42JD+oKzN5MWIP9DxKgh2p0BnstEXIk3IXlY
	 bzR0CbKk6+dE+gJV7XxsI6Mp1Z/kNfGCqB9k5KsuG4mQkNcV0lF5Vh6muzxax1r2xc
	 voMYNXfr/7N5Q==
Date: Tue, 22 Sep 2026 11:15:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next v2] net: opt loopback into instance locking
Message-ID: <20260922111507.6fae8770@kernel.org>
In-Reply-To: <arGd3auaaTerBqNb@devvm7509.cco0.facebook.com>
References: <20260921190452.1467853-1-kuba@kernel.org>
	<arGd3auaaTerBqNb@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 14:14:19 -0700 Stanislav Fomichev wrote:
> On 09/21, Jakub Kicinski wrote:
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> > v2:
> >  - move setting the request flag from gen_lo_setup() to loopback_setup()
> >    to avoid splats on the blackhole dev which we don't care about  
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> (mostly because dummy is also ops locked, don't think loopback should
> bring any problems)

Stan, the issue Matt reported in the BPF CI is a generic sw device +
netdev lock issue. We are triggering it on lo because.. probability,
but it reproduces with dummy + netkit already today.

Do you recall why we have separate classes for each device type?

Classes make the lock_set_cmp_fn() ineffective across different device
types. Quick test removing the classes and sticking to just the cmp fn
seems make lockdep happy, I'm running the ksft suite now. But maybe you
can tell me if it's the right idea before it finishes..?
