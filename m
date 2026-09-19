Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404783BA24F;
	Sat, 19 Sep 2026 01:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789780891; cv=none; b=kncQOaXqNpkRXUsJ1RU65D6iT+/7eoBN16Xu3tug8cGSuRdbU4JOf8pwDKonzi+l6ErLUEcIKA/xmQpYukTGevxu8BJDYKyoaXx5jvhVklLlhVYdsKs7AMnGmiR2wY4VcEqr4v3l3CN9mZARE1y2ma9MT/ab5WbCjJ3gxrWswWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789780891; c=relaxed/simple;
	bh=5wOoMLm7pxOnW4MJKxhQIqxE0QcNBnQJUFbLZqyxf6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/EBQtuIjRXGmGRo32PUUoPLWVKns13LNRA40Dp4vV+y3lrAgBMz3nScvkiXJF4YIgfC1pDNTcNmQPmRdDoZB/4/Du8YIWAKYQb2ctqnfChraOCm8rArfwvH7wKxqlU0CM2MjCbvx6PxSmn+U9GimWVqERvlIksfG1hWH1hdFJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnGENrMT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnGENrMT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FF11F00899;
	Sat, 19 Sep 2026 01:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789780885;
	bh=ieA0vBcbiVBxr29OQUyABbcNUgGCgwjWyA87ulocPqI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RnGENrMTk0qCgmLbaEVzq9tUOk3Ndc9B9jebc5huYdKe6UCfJj/vg9M8OliSAGVNq
	 v8xWRYZNoI2rd/YNiLQmWNKZBQBd2BS+O3uHk1YXAYfmsNAfxHwMrWshoYeyjUsFiE
	 heAAktrJpot7Z5li6KzdUjRtsJ3ExrQXZFTVP0Sn1dukFVDY41BksWEv6Dbp/H/w70
	 Mybysu2tqe3W4hFfWnkq96wCTzXVLCv/T75t3kd4bW4ZHHEGlRcud0E/zr8K097V2Y
	 O+uaUA/C2LO6lbRSOBcOYQ0ATc5rzy2K8h1RAhtOexko4UflMvQij3WlA4rPo/0Iyq
	 1aqmbC5puqZsA==
Date: Fri, 18 Sep 2026 18:21:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Cc: <netdev-bot+sashiko@kernel.org>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] ch9200: do return USB errors from
 control_write()
Message-ID: <20260918182124.487edd13@kernel.org>
In-Reply-To: <b43350d5-09d7-4fc4-9791-16bb4322d794@auroraos.dev>
References: <20260915185805.38712-1-s.shtylyov@auroraos.dev>
	<178954341078.22033.8722936070498955076@kernel.org>
	<b43350d5-09d7-4fc4-9791-16bb4322d794@auroraos.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 19:21:04 +0300 Sergey Shtylyov wrote:
> > There is a second point about the resulting contract.  On success
> > usb_control_msg() returns the transferred length, so control_write() now
> > returns a positive value (2 for these register writes) rather than 0:
> > 
> >         err = usb_control_msg(dev->udev, ...);
> >         if (err >= 0 && err < size)
> >                 err = -EINVAL;
> > 
> > Would the obvious caller-side follow-up "if (retval) return retval;" then
> > treat every successful 2-byte register write as a failure?  Would it be
> > better to normalize success to 0 in control_write(), or to check
> > "retval < 0" in each caller and update the callers in the same patch so
> > the errors being returned are actually acted upon?  
>    That's what the patch I linked to does...

Please fix the issues in one series or not at all.
We have too many patches in flight these days to be chasing people's
linked series. Too many LLM-happy "helpers".

Please explain how you discovered the issue and how you tested the fix.
