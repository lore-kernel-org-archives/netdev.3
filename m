Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90FE49362E;
	Fri, 11 Sep 2026 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142981; cv=none; b=aC/wB2DVPF8O28xTRc7tdKGGX78FZFKdYJWmZO+zpTB6wBt6iaiU9Wf893vNucqg63mqDwaCIXVW3qn7TZku2u4eIld+qjwgauw/cidIUd/ipvI8+82KUxTiFPJ4o0sZIWZtxl9Ctkybsvki/c2tOLvMyzmuS4ITjeqhnY2YTRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142981; c=relaxed/simple;
	bh=nGc4MsQZjD2VcTLlfN41zDAxz90aZkv7fLi5jdqZc40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWbFLS8RRT1eUgAU8ed3gKNdRGeMuElEchdJ/WS9novOJ3NUMOS61Ijgt5IfgEPd3zjR2xH60+2P49HWCceEFsq4fePV5t5Q/76IYQ1I/9wQFgLZ7IX95iril9YW1xdmtsfgUHaw0rH2gI4zEYI1gvFldN+Fzd4wjB0/P5osiTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=UrBCjTSE; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="UrBCjTSE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x6ObjDhK35n1dGSg6qPiIBjnnl5pQb3BSL8UFeKAShk=; b=UrBCjTSEHl1sMpM5E90ET45GYF
	YwzHp5lG+URoH5uY9cbn95xemgmJFApNr1fMJ+t55JCRCqI1WjZ7PhN8qO3TIQ1meYpNXk9gsSCgm
	WEdkj/ApJG1jf43uLM4tUiv0fhefJGkhWJm7VrnfQgCtzeI6YKs3BSWeg3HRhviNgtWQJOYkTnHmW
	v94GS/ETKkEwz7bHVXgTi9O0Msx4GGV710KAb6WyEFyzzLbOxWlRW0ZdJty/ngp4LtoNM9P1atqBD
	LHa+6+BOS3gyocE+SuobIdu4Ne5y6y7UjDgGQxoCWDT+DdJRlAVe4DuZMaXsDDShBQN6LzOXBhqkM
	hR3/4Ilg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x53oe-001PKs-0y;
	Fri, 11 Sep 2026 16:09:28 +0000
Date: Fri, 11 Sep 2026 09:09:22 -0700
From: Breno Leitao <leitao@debian.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, david.laight.linux@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH net-next 1/2] net: add sockopt_expand_out()
Message-ID: <aqQnF9vWKVk3GkTp@gmail.com>
References: <20260910-getsockopt_phase6-v1-0-e681e102d5b8@debian.org>
 <20260910-getsockopt_phase6-v1-1-e681e102d5b8@debian.org>
 <aqQkImqiHPorszOY@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqQkImqiHPorszOY@devvm7509.cco0.facebook.com>
X-Debian-User: leitao

On Fri, Sep 11, 2026 at 08:56:23AM -0700, Stanislav Fomichev wrote:
> On 09/10, Breno Leitao wrote:
> >
> > +	if (size <= iov_iter_count(&opt->iter_out))
> > +		return 0;
> > +
> > +	if (WARN_ON_ONCE(!iter_is_ubuf(&opt->iter_out)))
> > +		return -EINVAL;
> 
> nit: if you end up re-spinning for some reason, maybe swap these two?

I am not sure we want to swap these two. This is the reason:

1) The first check (size <= iov_iter_count(&opt->iter_out)), check if we
   need the "hack" or not.

   a) If we don't need the tack, then we are fine and this could be called
      from user or kernel.
   
   b) for the hack (which happens in the next line -- iov_iter_ubuf()), it
      needs to be ubuf.

So, this force kernel callers to use the right optlen, avoiding hitting
the same issue as userspace.

