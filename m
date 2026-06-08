Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5E54071EC
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 12:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920697; cv=none; b=Q+8Dpg9HZ7N/VouOptiBOkrvMxbGJWHpki81G+L5ab9fhjLdnjH4YmZuSs9DrBYoCTd2wafETsSQ4mQNPVgTDqYfCnPtYVZ/TtOn/L1RSdk9BpZjeSjPBvMQsGB0FoNBb1R+BEkggg8Tc6ZEpwoy+C5BdCXp50oPQSXP6HP9Ik0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920697; c=relaxed/simple;
	bh=X2oPBa0tJdZD45RtrzjksZtFfaD404Cxrg3Bai+IPnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJxYK8E3eha6c3EM4BDSpIErsb7UCnUqO2p4X/jo0diqcJyS6aqGlZaE9enY8onV2P2aDlF/8j5UdzjVBkIh4EbM2LxgRLkI9Cd2xzQsrtf+NqC7ulhXh2EeuEJUehA8G4hk9i8jsnyUBubSYKFvWwpjTg/II7F8Ex8W400KJU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 6905060337; Mon, 08 Jun 2026 14:11:28 +0200 (CEST)
Date: Mon, 8 Jun 2026 14:11:28 +0200
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <edumazet@google.com>
Cc: xietangxin <xietangxin@yeah.net>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, Willy Tarreau <w@1wt.eu>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Zhouyan Deng <dengzhouyan_nwpu@163.com>
Subject: Re: [PATCH net] tcp: secure_seq: add back ports to TS offset
Message-ID: <aiaxcKgQUqF56SHp@strlen.de>
References: <20260302205527.1982836-1-edumazet@google.com>
 <99caeafd-edf5-44a4-8742-4eada5d0f5d1@yeah.net>
 <CANn89iK8GcY3GHCRs-8EVrDoBPhdw1iY4mBjZKe8gx58+ko73Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iK8GcY3GHCRs-8EVrDoBPhdw1iY4mBjZKe8gx58+ko73Q@mail.gmail.com>

Eric Dumazet <edumazet@google.com> wrote:
> > Is this performance degradation an expected side-effect of the security fix,
> > or is there any sysctl param we should tune when `--random-fully` is
> > required for high-concurrency short connections?
> 
> Hi Tangxin
> 
> I do not know why that patch would affect MASQUERADE performance.
> 
> Pablo, Florian, do you have an idea?

tcpdump would help.  Willy could be right, tcpdump would confirm
increase in retries.
