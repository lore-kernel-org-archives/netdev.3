Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C24E175A68
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 09:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778405841; cv=none; b=NsXWS8BVFLLne9nMdM2984uNGR7rB6MuGu/mMB/ojclmHJBcwjT0hF6bmRPuiTZR9P0PFGHdtFxezEosu5UK2vLEqIZcReescbaIxavtP04PHJySj/EDlz/mtZAJ8Tar/LsE6Bb8jPJemQQkkmg+WDNP02mz4LdBBCdOzZGtd/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778405841; c=relaxed/simple;
	bh=5qfVToau/NxEM8AamjQl/D4qddlYjsunXieljdEvmq0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NqEsD7Dl/VkX1/LKjmu8eD/W9D7eWlDMZKRQ6P74Gv5fltPiQpXOQgDRxHa6nJxXD+288LaWh1hhb7JXg33oTsMcRQPAYgRsDzynNFXYEGnCEZ6i/P40u7l3/wzjZ7y+jDNY2t/GDP1C90nAJ5gzQWpEwbyBtTwUc3Qa5O4P1/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Authentication-Results: mail.toke.dk; dkim=none
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>, Victor Nogueira <victor@mojatatu.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, Eric Dumazet
 <edumazet@google.com>
Subject: Re: [PATCH v2 net-next 0/8] net/sched: prepare lockless qdisc dumps
In-Reply-To: <20260510091455.4039245-1-edumazet@google.com>
References: <20260510091455.4039245-1-edumazet@google.com>
Date: Sun, 10 May 2026 11:31:25 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87se7zpq4y.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> Goal is to no longer acquire RTNL in qdisc dumps.
>
> This series annotate data-races, and change mq and mq_prio to
> no longer acquire children qdisc spinlocks.

Nice!

For the series:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
