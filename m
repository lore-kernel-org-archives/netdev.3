Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C0A31F998
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 16:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781282952; cv=none; b=C0pHOac7zz3cGwzMKJT9y2vl0a5LgqLYi2IjO7zY3yqS0iVG6XX0BVD1JLEVJlG22M7X5cv/XTn94tdAeN3ONji6JxgRUm9ULKp0DrAoaGF8Wg/fFmm0+yiaoaRmw18vCESKBIiVt+iORFWUfHvWOeMJGWwIHb8NXSZsFMo8enA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781282952; c=relaxed/simple;
	bh=uX3Lpx4f7WFzbDyghMLEkCIbGiSRhGiSGuY3cUKCkn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZcHe3wHh73tiwfEJFt1idUWHU+tV8sk1gsZKrgBqweZVopKmyTBosfRUAcS1f4/tciAMyE4OHe0LA0WhdKb7TZxd0qVOhl3Re2Csby1PvUdceVS8EJa81isL/jHnq/CKAppKg3MWq7+ZzQq3+uhUppFFIk/dpvweB+3n08Qi7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdenUG4n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdenUG4n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2E01F000E9;
	Fri, 12 Jun 2026 16:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781282951;
	bh=I3+0NpVchnIFcN1iCq9hCjRAuxbBaM1XX3Xm/Foxhoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DdenUG4nj9oU87PrgFFgD7nrbzQ39OOuK3NC4G6xdJRfmgLGB4gm4SvuD2HMLD2TP
	 Hu/t09ugVW+UFUrUNOLbFmytX+Fo9I+mT+BO2wfeOZRBneYIzKlWJo8yfSwdCk717f
	 DkI3rHsQ1X9E44VcmIh7Fo/4g5tZ4LlFpL/mkfekQqc4yixhRXcB4fsnahIDVqKsVX
	 3VMBcb0TbQimC1mvctJ0CVdXgIMwF1bUzcfvRTw/T9S+g4o1PSnxbC4Bxnw6Y9fXTr
	 EJ/RWpkh/8FC8Wc7zqeZHFTd9vicuGLmsIEiJaQ21BqKZa8DREieGn8yoNQ32a3bGR
	 RCVIBl7yl5/Gw==
Date: Fri, 12 Jun 2026 17:49:07 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net] ip_tunnel: annotate data-races around t->err_count
 and t->err_time
Message-ID: <20260612164907.GG671640@horms.kernel.org>
References: <20260611165247.2710257-1-edumazet@google.com>
 <20260612162818.GF671640@horms.kernel.org>
 <CANn89iLw_wT+fqYNixYiTP4y14R5YeyZXXhbOhSTvvtKris_3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLw_wT+fqYNixYiTP4y14R5YeyZXXhbOhSTvvtKris_3w@mail.gmail.com>

On Fri, Jun 12, 2026 at 09:31:51AM -0700, Eric Dumazet wrote:
> On Fri, Jun 12, 2026 at 9:28 AM Simon Horman <horms@kernel.org> wrote:
> >
> > On Thu, Jun 11, 2026 at 04:52:47PM +0000, Eric Dumazet wrote:
> > > ip_tunnel_xmit() runs locklessly (dev->lltx == true).
> > >
> > > ipgre_err() and ipip_err() also run locklessly.
> > >
> > > We need to add READ_ONCE() and WRITE_ONCE() annotations
> > > around t->err_count and t->err_time.
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> >
> > Maybe this should have a fixes tag?
> 
> Ah this was meant for net-next
> 
> We just merged into net-next the IPv6 equivalent patch.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=f6033078a9e671e3c8b83d387b91591a6f6a54e7
> 
> Sorry for the confusion

Thanks for clearing up my confusion.

> > In any case, this looks good to me.
> >
> > Reviewed-by: Simon Horman <horms@kernel.org>
> >
