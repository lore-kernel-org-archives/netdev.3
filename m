Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CAF284B29
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775785809; cv=none; b=V+PS08tBnkIJiiUMmOyQmBMqwPqXbbhDEuGL4gsyY7K4N45qtT+z3YNa0FluGNO2xZcaenY281AIx/xfZluCUWoeUORpCH4KRtGHi8b+flqhxEdhA7m0TOhSN5cV7kWl8XmqejS3+rC4d8XM0gY16/4g5xpr+1NR+5Qh+HdkTZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775785809; c=relaxed/simple;
	bh=KPA1gni+vyRjVWWNvEpxm69hGiq7GdeFPchgxIwy8KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P8lAoeG07ambBy99+PoLYzbPGcedm1xO6m7AcPFr5O98Ryu5EMSogSk9VRGU/mYZcSoY5hx+47ZhkTW4iOvlFgUO/ZUC+e1g+dwvbEsE2nkJWvi/16JkNfKBev6EvvJ2t058xWDdDeyu6KpiiVhI0+rB7aGKvPvT3ZsAWgqMZ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5lyM5c4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5lyM5c4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661E7C4CEF7;
	Fri, 10 Apr 2026 01:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775785808;
	bh=KPA1gni+vyRjVWWNvEpxm69hGiq7GdeFPchgxIwy8KQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n5lyM5c4ezyXE5qVQpElyuAPsHt+jY0WLkcWI5ANpaM7pB7Q0eyu09hpld/VMQqyp
	 ckl0fCV3ChO2/L/eVwNy5ktXvYS3coY5D3L4e1fzTlv00R6asgoAsTjYfOnedjyRe7
	 HoRL0kWFjwUZ0+u34TqBmHl+aHwW59aSwAAoxctHBLjdhBBI9Xz3qA+LHeIDSMprHO
	 r4Khulj62iy8VObC0zjRO/rXMtTxaIEpYgGI1KWDn32T2JbF8UlBHIkFqHBpLBTDxm
	 2P82YJn6vyjVm6HDZQT2cC6xLPQ9pjbwOiFig0hK4OtJLxsdijgy1sfg01hoHt/K8c
	 F4+mGehJLmtCQ==
Date: Thu, 9 Apr 2026 18:50:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v3] selftests/net: convert so_txtime to drv-net
Message-ID: <20260409185007.516a0563@kernel.org>
In-Reply-To: <willemdebruijn.kernel.1b750e4c127c7@gmail.com>
References: <20260406025020.1636895-1-willemdebruijn.kernel@gmail.com>
	<20260407191543.0593b5aa@kernel.org>
	<willemdebruijn.kernel.1e324d665bb85@gmail.com>
	<willemdebruijn.kernel.1b750e4c127c7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 09 Apr 2026 11:01:49 -0400 Willem de Bruijn wrote:
> > Alternatively could record the root qdisc at the start of the test and
> > restore that.  
> 
> This should work:
> 
>     def main() -> None:
>         """Boilerplate ksft main."""
>         with NetDrvEpEnv(__file__) as cfg:
>     +        # Record original root qdisc
>     +        cmd_obj = cmd((f"tc -j qdisc show dev {cfg.ifname} root"))
>     +        qdisc_root = json.loads(cmd_obj.stdout)[0].get("kind", None)

I don't like doing setup in main() TBH. It can well fail and no KTAP
will be produced. Breaking all the tracking and stability-based
filtering. Not sure if it's still the case but for a very long time
not all tc qdiscs supported JSON for example.

>     	ksft_run([test_so_txtime_mono, test_so_txtime_etf], args=(cfg,))
>     +
>     +        # Restore original root qdisc. If mq, populate with default_qdisc nodes
>     +        if (qdisc_root):
>     +            cmd(f"tc qdisc replace dev {cfg.ifname} root {qdisc_root}")
>         ksft_exit()
> 
> 
> Do we want to add a tc command similar to ip, bpftool, etc.

Yes, we can wrap it if it outputs json.
