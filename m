Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D07E3BD63C
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 18:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781201483; cv=none; b=tO7Ou357S3DaSYscigIpHc49pDi3sz0+nWqB6gezGb7WxDX6yTTiGWo/Euefo67uWLCku6KK+LxEGdxPcP+hBDsxsKsUZ1a0IjWdlacEJqBYWx3lCf3IyXM788Eq0Z89urs4Kp/uYsDgw9OgEV14P83bLYn8VJb9BYa41QtHzK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781201483; c=relaxed/simple;
	bh=4u7MVzQTrfazBV/v2VDbqI6qdbIQV7oPPv3AQ47LKYc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J0MDBvaWHFyAMAA8TAKxY/8JxehwvF8MSeAWpAO/bwLnhNcfw9comgKPmI5PY0LxPGRtpWGqUZMwTkmEpznFgAaR89roesQXeflpYOg2P3wHQqcG4P+cT/J9JSZJzU9TxOrRvJcYz5MS8z/gU4T3jNXDHXQYKg7iOt3NJu4Wh+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8e0Aw/J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8e0Aw/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF671F000E9;
	Thu, 11 Jun 2026 18:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781201482;
	bh=8Nmego15xbmQifYVwJZqOwXE58DRks9KOZEmgOXTWIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=d8e0Aw/J4yaats4WSF62tQ72pGgMThPpThRKUjbPGAonZCN4Q/Ru5D/o8RoR4QAEK
	 /GVREMVU0LJAKHRV+khcQyqJBYF2XPVtMjgkQu7jHc43UT24tTtK4mHOauLolGIuXr
	 QhuNDbgiKMoI1pelNES1q3yF+iMGhXVEnHK8zAl1CUtQAuSsgQCaTnmhPdwBMeTsBk
	 NdVOoGWgWztxpwEnu1XIcx3Yjyi3WTVotDqm99V/Yhta+eCYMQSQdMyHKf6SAfSzsF
	 IjvKsUWr4nJ2o5KUQDADeYUdC9oGID+e3zMCqG5iaX20GdAhh25E4pwoJl3VVf1eZM
	 ZWV1su6Rc8atQ==
Date: Thu, 11 Jun 2026 11:11:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 1/5] bridge: use atomic ops to read/change
 p->flags in sysfs
Message-ID: <20260611111120.4ca5d5e4@kernel.org>
In-Reply-To: <da4de983-99cc-435f-b00c-3321444626ea@blackwall.org>
References: <20260610161836.1275531-1-edumazet@google.com>
	<20260610161836.1275531-2-edumazet@google.com>
	<da4de983-99cc-435f-b00c-3321444626ea@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 07:46:46 +0300 Nikolay Aleksandrov wrote:
> > +		      unsigned long bitnr)
> >   {
> > +	unsigned long oflags, flags = READ_ONCE(p->flags);
> >   	struct netlink_ext_ack extack = {0};
> > -	unsigned long flags = p->flags;
> >   	int err;
> >   
> > +  
> 
> this extra new line seems unnecessary, there's already one

Can fix when applying
