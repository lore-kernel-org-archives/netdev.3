Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE7540D56C;
	Wed, 10 Jun 2026 01:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781056587; cv=none; b=OoPNHJ65jXwTmVU0mXRb46rq+QVAWlCwNjwFI6s3H5rDeJ/k0D2sXHjDNUM+IAs7B+iroGIt9OiOMUL3QeklPXQkdQXGi+U958tooQpSdKewrygsNrWOwPXhbJz+3DPy03yIcKq+c8vMY59C0G2VgV1Ek3vJO4gv7x/5l+2zdZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781056587; c=relaxed/simple;
	bh=jqEH/I4ORqQHaVFuiF+WyIc9xDvqyp0+Da3ck9EklqU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/HIxM8fMyn8fk+flEfq+rnxBzsoPdLDYVmONA718roFJOd4a2hltXqlCG80Pk5XwYjgr6EIFk8q7aDbZ2lZR+fVJJOpE8sWaMj5Ls1JSMqhGwAv3EQSigafEhLcWJELbkRqbmaUoY0OmHZxAUivVscWp3oFbGBUvyb/y+iVE4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elkSS2mY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elkSS2mY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135AC1F00893;
	Wed, 10 Jun 2026 01:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781056586;
	bh=RWQWcDFojEGqcP2PeWpgKeXklxJCD4SA/cMgzCf1SMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=elkSS2mY6LN55qxmNJIreK2zXIQX9DHNCZF2Rv9xc7dSpxWJWJpCy9ivwQQDdNbhr
	 YqS4pbIZ+zPaUAn3eOqf/l7dmfmiz2C/tdQrL/WrSQlcGF4KCF6R5HEAujj1dILj2p
	 SbTf7adDvGH1HosjxKq5GnkwklUnPfBSP5VQGrdUI1Ziz3B9iUYNBCcpIxY9HcpjKd
	 fblRN6mAY3p3tvH5vskjt6vyi4wHkz3Q5y9516ZJOLs1PLfYcj17Al7bi/QeiqO5Xl
	 BME0mS5BSk7G7LHsFILS5Yf7dv4/8xyQ2fmAM0bP15CvFzZujbflcp6NbwNOCWVDJM
	 58fDFitcS45Ow==
Date: Tue, 9 Jun 2026 18:56:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org (open list:TC subsystem),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] net/sched: drr: reseed active class deficit after
 quantum changes
Message-ID: <20260609185625.6e4bb757@kernel.org>
In-Reply-To: <20260609003617.1237785.3427a8f0e7b0.drr-change-class-stale-deficit@trailofbits.com>
References: <20260609003617.1237785.3427a8f0e7b0.drr-change-class-stale-deficit@trailofbits.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Jun 2026 00:36:18 +0000 Samuel Moelius wrote:
> Subject: [PATCH] net/sched: drr: reseed active class deficit after quantum changes

If the change is not for a serious bug it needs to be generated against
net-next. This was generated against Linus's tree I guess and doesn't
apply to -next.

> Changing the quantum of an active DRR class leaves the old deficit in
> place.  The next scheduling round can therefore use credit accumulated
> under a different quantum.
> 
> This can be observed by making a class active, changing its quantum, and
> then dequeuing with the old deficit still present.
> 
> When an active class quantum changes, reseed its deficit from the new
> quantum so the changed class weight is reflected immediately.

TBH the current implementation is how I would expect DRR to work.
quantum is the "refill" value, it should not reset the state of 
the current round? It wouldn't in an ASIC.
-- 
pw-bot: cr
