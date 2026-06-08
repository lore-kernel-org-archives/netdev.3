Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E1A2EA480
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780911790; cv=none; b=LpFbbjzl0Dz9f8+jDrIl/jSQcZIi9twYaEfWHrz+zRNuJNYCItWSQ3aWgKIiDhbrte4aNHDWE2ufmT36yDEa2WqPa7W5jBEns+cTHqtDLsxP5srN4fGA5JSATDAKM4f+9SutwAUwPEhtI0XWkNU2P3KnX2HLi3JMfmRto9q7TPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780911790; c=relaxed/simple;
	bh=dmTlg6y6YJ6RgAhWDSVBpvaYlmi6+ny0raS9//d5JAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKmZEAclbfXb9OkMJ+PjRgsLVAHel2OgJc/lnPFFOuxjXQSEruzMLe7B18H9G9iRiuXKyhE5HmV5C9BZbPcoKFEIYi0sgf4vRDzzEZzhaOXF53hRi3liXeKAJ1Qqyxt3w2NRhmayodiNPWw6xxqI51ezRBzyUp2yzbPxr01ltSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=AQeuq2tf; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="AQeuq2tf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1780911779; bh=j5cxWlFBNSuYFYwvRwh1+a59MLTHwwMLo8fZ9XQ0NxQ=;
	h=From:Message-ID:From;
	b=AQeuq2tfJv9QiI9u6YyEAeX8IQBrRJ1CUACcF2GX6oA4i47IdiIJgxOiFoCBKKgqm
	 KpiJKsLDJ9egk+gEz0bcavHqIqeBJm8y3F/MDa61qeZfgDHlVKqpM61gsIjRWpn4Bf
	 8ubeBn4hD8Le0rXDg+Wpipg1skumRw6b67vDRnuA=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id B6809C09FA;
	Mon, 08 Jun 2026 11:42:59 +0200 (CEST)
Date: Mon, 8 Jun 2026 11:42:58 +0200
From: Willy Tarreau <w@1wt.eu>
To: Eric Dumazet <edumazet@google.com>
Cc: xietangxin <xietangxin@yeah.net>, Pablo Neira Ayuso <pablo@netfilter.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
        Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
        eric.dumazet@gmail.com, Zhouyan Deng <dengzhouyan_nwpu@163.com>,
        Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH net] tcp: secure_seq: add back ports to TS offset
Message-ID: <aiaOor1JLLu5Xn75@1wt.eu>
References: <20260302205527.1982836-1-edumazet@google.com>
 <99caeafd-edf5-44a4-8742-4eada5d0f5d1@yeah.net>
 <CANn89iK8GcY3GHCRs-8EVrDoBPhdw1iY4mBjZKe8gx58+ko73Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iK8GcY3GHCRs-8EVrDoBPhdw1iY4mBjZKe8gx58+ko73Q@mail.gmail.com>

On Mon, Jun 08, 2026 at 01:51:49AM -0700, Eric Dumazet wrote:
> On Sat, Jun 6, 2026 at 4:06 AM xietangxin <xietangxin@yeah.net> wrote:
> >
> >
> 
> > Hi Eric and netdev,
> >
> > I noticed a significant TCP performance regression (QPS drop) when using
> > iptables MASQUERADE with the `--random-fully` option, and I have bisected
> > it down to commit 165573e41f2f66ef98940cf65f838b2cb575d9d1
> > (tcp: secure_seq: add back ports to TS offset).
> >
> > Here is the benchmark environment and test results.
> > Environment:
> > - Client & Server: 2 VMs
> > - Server: Nginx listening on port 80 (HTTP), and ip 10.0.0.1
> > - Benchmark tool: wrk (short-lived connections with "Connection: close")
> >
> > Test Commands
> > 1. With random-fully:
> >    # iptables -t nat -A POSTROUTING -d 10.0.0.1 -p tcp --dport 80 -j MASQUERADE --random-fully
> >    # wrk -t8 -c200 -H "Connection: close" -d10s --latency http://10.0.0.1:80
> > 2. Without random-fully:
> >    # iptables -t nat -A POSTROUTING -d 10.0.0.1 -p tcp --dport 80 -j MASQUERADE
> >    # wrk -t8 -c200 -H "Connection: close" -d10s --latency http://10.0.0.1:80
> >
> > Test Results (QPS):
> > 1. Parent Commit (7f083faf59d14c04e01ec05a7507f036c965acf8):
> >    - with random-fully:    18145.74, 15006.39, 15716.67
> >    - without random-fully: 18556.36, 16339.22, 21506.02
> >
> > 2. Bad Commit (165573e41f2f66ef98940cf65f838b2cb575d9d1):
> >    - with random-fully:    11074.76, 10383.20, 10164.81  <-- (~35% drop)
> >    - without random-fully: 17310.75, 20279.85, 18399.48
> >
> > Is this performance degradation an expected side-effect of the security fix,
> > or is there any sysctl param we should tune when `--random-fully` is
> > required for high-concurrency short connections?
> 
> Hi Tangxin
> 
> I do not know why that patch would affect MASQUERADE performance.
> 
> Pablo, Florian, do you have an idea?

I suspect it's because MASQUERADE can shuffle the ports around and
break the end-to-end mapping. With host-based ISN the increments
remain positive regardless of the ports, while with port-based
increments if you shuffle ports around, two consecutive uses of
the same port can end up showing a decreasing ISN, and some
outgoing SYN will get an ACK instead of a SYN-ACK, then send an
RST, and a SYN again, causing a degradation.

I'm not saying this is necessarily what happens here but based on the
commit message description I suspect that this is what's happening
here. There's always a tradeoff between ISN secrecy and reliability
unfortunately.

Willy
