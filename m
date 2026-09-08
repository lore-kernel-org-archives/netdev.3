Received: from mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0739F330307
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788835238; cv=none; b=E8FU/eIL8zx/gX4thHTHufjgrKkS8KPzPJuwHMjwbcg+Q4rohro25Dn4H+12pvMM9D8BVNueZoS7OYz3h/ax7AJYCG/aE/UoJMZxOipL5BtNTWsq6+Jrh5dOcn/Sxo77AKLgKijGpIiUhiZnl3pClRT8tZUwWpv32E4yg3N59PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788835238; c=relaxed/simple;
	bh=qqephO7MiF3EglduJF8KB9YgLfHVQKCikHF2v/k+K8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9gbjYYy+tocRK8yK3vKSnOpJVlEYmuKrX4tL1uNzyXol8yze4Av//ohLDfXFZ0fvr/QeaA89i22QqSo802o9i7hLmzJzSplaUdBMR+iU7qRj06e7wd0bXV2T529j5bXQFJXrrNp2yTVnSY4GCxADpWfOPF9h++P5ZlETxChWoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Oof97gRd; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Oof97gRd"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qqephO7MiF3EglduJF8KB9YgLfHVQKCikHF2v/k+K8k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788835231; v=1; x=1789440031;
 b=Oof97gRdkVjqLj/3tFS4dj2oyFRw+nbNQuDNctEHUFY+99rt0FwEVyn7xqvjxpsHvi5yOQ8y
 bRP0PnkrIDdgZTpRMC+Nc1+/cfF5VTwtdPXWE6f/F0PDgckygIKxYcs5heNTI01RtvIVF98VWe+
 0EKz8WMpYWEYSx/QC+VCzh+I=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id d4164907f45634ec;
	Tue, 08 Sep 2026 02:40:31 +0000
X-Mizu-Trace-ID: d4164907f45634ec
X-Migadu-Flow: FLOW_OUT
Date: Tue, 8 Sep 2026 10:40:16 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Eric Dumazet <edumazet@google.com>
Cc: Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] selftests: icmp_redirect: remove xfail support
Message-ID: <ap91kK58_DL2P9DH@fedora>
References: <20260907132423.3353361-1-edumazet@google.com>
 <20260907153733.GA755346@shredder>
 <CANn89iKAFuAKgR=pZSfNWtNj9aT_PgmZzfu04mt14S1UFfeN=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKAFuAKgR=pZSfNWtNj9aT_PgmZzfu04mt14S1UFfeN=Q@mail.gmail.com>

On Mon, Sep 07, 2026 at 05:52:13PM +0200, Eric Dumazet wrote:
> On Mon, Sep 7, 2026 at 5:37 PM Ido Schimmel <idosch@nvidia.com> wrote:
> 
> > Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> >
> > FTR, I don't think cd51b74bdd0b ("ipv6: Fix redirect exception creation
> > for UDP/RAW sockets") is what fixed the xfail (I never saw xfail, even
> > before my patch). It's more likely that it was fixed by commit
> > 0e02bf5de46a ("selftests: icmp_redirect: IPv6 PMTU info should be
> > cleared after redirect"):
> >
> > 1. The redirect message quotes an echo request, so it's going through
> > icmpv6_err() which calls ip6_redirect() using the correct oif. It's
> > possible that rawv6_err() later called ip6_sk_redirect(), but by then
> > the exception was already present / populated.
> 
> Ah right,  I will send a V2 with an updated changelog, thanks!

Good, I will rebase my log_test() cleanup on your patch.

Thanks
Hangbin
