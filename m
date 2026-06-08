Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A6631D39A
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918219; cv=none; b=Kzk3b9A+cyUJ3AHwalZYW94i6wLhBHw+RhpvolPqdCLFqgFVN78rNLbSVycIfVuEVhHqADRcsKUqnUcpjBrjtiIdaA1mjTwUdhcjf5Vp5Y9QDYi4FCr82HMdxLPoGpw3EvxBY7qFknaWL7iUbfj6pclLN1FZKzLyaqK2/eIZwvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918219; c=relaxed/simple;
	bh=tyd3+C+BS5PJiTMQDRxszaKye425T2FF388CJYSrqZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lS++xiuI8i6LDJpinbbuOw2st2bLgpEyYUMKS/1XBI2iLhDxAEX6ZVfGxw/iVmyuFERsXj3+ciX2+z2C7oV8CBaZvWyeGNHicnqZK49cgzwpgknVbF6e1Fg926FB4r8zfT0XvcjQHc4qVg+cVnlgyHsCvTD5hFYcxaJcfjmR0v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=TXq6LN+Y; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="TXq6LN+Y"
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id E15DF600B9;
	Mon,  8 Jun 2026 13:30:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1780918208;
	bh=lCgLJ9gaJT240/Ypm+XErlk+f+KAtV1QE9O1XyfhvUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TXq6LN+YF+NoldgpNc2UFQB5Hmhek7UpzXOxBlueYnVcWDKxehLh4erYXsA5hmnxf
	 uBgpth/A9c8ss7D148H8KhLX00Dd9ST/e7M693GD0unJRL1oBUWSOExFnPF2+XIf8v
	 I2fET26pniKsqygwNf2GDV1q84uD5E6lQWNGjx5+LJl09xDaz3mYuvS/xpjlEqJiqe
	 nJK8m9Eio8bDAaw+gaOG5vlKD7dspyRMYp8/POlFzEKdFucDGKYpZMfVoPgs7TlJmz
	 5150ooso0rNQrz0GfWgf96xrakPFMw4MwMfAL4y9/LTO2ESRHIJjCUxDDGi3kJ+isR
	 6kea7HVby5StQ==
Date: Mon, 8 Jun 2026 13:30:05 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: xietangxin <xietangxin@yeah.net>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, Willy Tarreau <w@1wt.eu>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Zhouyan Deng <dengzhouyan_nwpu@163.com>,
	Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH net] tcp: secure_seq: add back ports to TS offset
Message-ID: <aianvVzqzZbOaeR0@chamomile>
References: <20260302205527.1982836-1-edumazet@google.com>
 <99caeafd-edf5-44a4-8742-4eada5d0f5d1@yeah.net>
 <CANn89iK8GcY3GHCRs-8EVrDoBPhdw1iY4mBjZKe8gx58+ko73Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iK8GcY3GHCRs-8EVrDoBPhdw1iY4mBjZKe8gx58+ko73Q@mail.gmail.com>

Hi,

On Mon, Jun 08, 2026 at 01:51:49AM -0700, Eric Dumazet wrote:
> On Sat, Jun 6, 2026 at 4:06 AM xietangxin <xietangxin@yeah.net> wrote:
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

Can you check where the packet drops are coming? There are several
tools (iptables trace if it is the ruleset, dropwatch, etc.) to check this.

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

With this information, not yet.

Thanks.
