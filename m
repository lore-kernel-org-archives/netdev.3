Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3FA373BE4
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 01:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772502117; cv=none; b=rUy+P4ubemJWvKUaup5Lu3bdpo9smBra1M8VKj+KpIpRI7rMvIeVFxOl3ndilef9GHJtgLWevGaW4xfJDVQhqp9E7eof+mXko9SSY08/7wynAlmCXjla78q2Bkd9+Q1XwtZiSVlyosWR+t+OB0a8wqemKTTrJfyrA7lwCMrd9hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772502117; c=relaxed/simple;
	bh=TPaqrDNCQk9XGqNEyBhzUJhNXYzsVJB5kKUPv1Nf+Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdmW9J6Fhucq5M4P29xG3W6Mx9ZYBrCtbEYz9M/j0DIsnJoAh9MM3FoapdbwDaFJuWg55EptaHX2S7/qPiJAHMB0L3jGi4aAR5rJ9SRy23Ir2fPBkYUgH5yUFdHeGuP1a+a9jsDb6uAVe3U7NRS8ACtlcpzD8N4Guz9n/Mt6Tlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 630E960492; Tue, 03 Mar 2026 02:41:53 +0100 (CET)
Date: Tue, 3 Mar 2026 02:41:53 +0100
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, Willy Tarreau <w@1wt.eu>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Zhouyan Deng <dengzhouyan_nwpu@163.com>
Subject: Re: [PATCH net] tcp: secure_seq: add back ports to TS offset
Message-ID: <aaY8V14pSIbAE8pu@strlen.de>
References: <20260302205527.1982836-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302205527.1982836-1-edumazet@google.com>

Eric Dumazet <edumazet@google.com> wrote:
> This reverts 28ee1b746f49 ("secure_seq: downgrade to per-host timestamp offsets")
> 
> tcp_tw_recycle went away in 2017.

Indeed.  Thanks Eric.  The original situation that prompted per-host
offsets might not be applicable anymore.

I think its worth a try.

Acked-by: Florian Westphal <fw@strlen.de>
