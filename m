Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D347B374197;
	Fri,  9 Oct 2026 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565534; cv=none; b=p2yJbs5xynIj4DsRYFw8rrTRUz2OfqnLYV+e7+oDfvq+YHFABNZrAfwkUz7FISxGi88bvqTIm6OgXQqNlKmIcqtFTh5n6bK5aoDJZaRL1VOxqiWUNw8mjMhBwGEox8Odg/8jj1qkeOWRe6bp3lafBSoDuUod7HQ0SUcAcoOql7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565534; c=relaxed/simple;
	bh=1EXblDtmTUDbjN5dv9pX1vjQkxgsuBgOMzVuw6oes8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkbPfL3veOqOHxXwANImC1XDsS5qdReQiYv2Fl9IuoBvDToOJaJtAaaw461EgaEjSpyKB8QXIcOtTFkUlAxAs/Jkjgk64sfnUyVNfAzE9kE1a4v9SXJJ3RtA9u0Zp/S134bcjxPg9euZEhR4Y28Y/0HbrCjG77cslQKsa2QPmGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRgc/zr2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRgc/zr2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B561F000FF;
	Fri,  9 Oct 2026 17:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791565533;
	bh=isi1S/78aXjX4j7WkQK2y24jEt12fU3sBihyO/l2c7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GRgc/zr2YV73TaC0geho75UC9CRhhO12LepjspC8iEO5Nbf11nommcqbDoacIXfV5
	 kT8ISMern0b5nl7DS3bhQO9Bb/JYHwO76TYZfE3Se+NSsbm0CBJxZ+OOUFNpdoWRO8
	 qHzRFHNp8DhMoP5onwPeYztSLrWFSxlq0ES+laCPaeqnlQFSHL+0Gq2oRRP9+XElaq
	 1lUF7tkYsGDpYDXDyAeLmWqcCDbjTHA+/fE1KNWcEt93IFki64Wzdh1DG8mvRBpfQg
	 eWMYfdqsXxfkalHpGKrq5oSOlguKHEna87fp2s5UNKBdFSmr69TlxSJj0eo5olffQO
	 gH5/190MbSovA==
Date: Fri, 9 Oct 2026 18:05:29 +0100
From: Simon Horman <horms@kernel.org>
To: Omar Ramadan <omar@blockcast.net>
Cc: Taehee Yoo <ap420073@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/4] amt: fix relay tunnel keying and
 unauthenticated-Request DoS
Message-ID: <20261009170529.GL83879@horms.kernel.org>
References: <20261008003606.3666617-1-omar@blockcast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008003606.3666617-1-omar@blockcast.net>

On Thu, Oct 08, 2026 at 12:36:01AM +0000, Omar Ramadan wrote:

...

> Omar Ramadan (4):
>   amt: key relay tunnel state on the (address, port) endpoint, not the
>     address
>   amt: send the relay General Query directly instead of via
>     dev_queue_xmit
>   amt: make pre-query report drops visible
>   amt: do not create tunnel state for unauthenticated Requests
> 
>  drivers/net/amt.c | 315 +++++++++++++++++++++++++++++-----------------
>  include/net/amt.h |  15 +--
>  2 files changed, 206 insertions(+), 124 deletions(-)

Hi Omar,

Unfortunately this patch-set did not apply cleanly to net-next at
the time it was submitted so our CI did not run.

Please rebase and repost.

-- 
pw-bot: changes-requested
