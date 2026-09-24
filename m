Received: from mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2BC442FB6
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790249239; cv=none; b=blTohoRmhucj+dH74JBQjwZhMnsRtY8lcrIcb711/oAQbP9xXJ/qCor8UtBPE+kLrcr21LSvpKEXgDvlS+s21gHKwbaAGa8YCcPa2e9TLcXQzWcI+yL3c8rh/7Orvkdzsx61SDfQn59ixM8X7fjm3hNVkX3ZBZyVcQ9EL9f39UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790249239; c=relaxed/simple;
	bh=wdW8FL4CrcYs3IlqjSRmJQL1D/VjHT4D9E/Mn1PzdOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmfM2BUo/MIHFOAQYd4+IZuj9Ol+8pmNoevSObusrvdbqMqxtqaRF6UvKn3mkuZ0ihkTvCbU8hmG091XKD8eHUyx4U9DlYFh2EELADcsasqMdphj/3wgKSABHS+fkJQhltrI/4vdnnZQ/cthD4PP4NLTG8j+mhCEaW7SXCSfBio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N016X3gy; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N016X3gy"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wdW8FL4CrcYs3IlqjSRmJQL1D/VjHT4D9E/Mn1PzdOI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790249234; v=1; x=1790854034;
 b=N016X3gyLGB5l7wm9MrJe3dz38EqLJW/kr6uQryfmtMwzd+QIBtQh4cyR9fF+rJQRQVo6v+C
 5h5hlRJ6dxubWEHWAEeNHi9jV6dxJKKS0j21F9bYkRqFFL1CPsTgbYGXtE+BXlOaCcJKm9CsLSf
 VoOHAX+X3Qiq/Q2hS0+mAMWU=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 8e2d080d4a9bc1aa;
	Thu, 24 Sep 2026 11:27:14 +0000
X-Mizu-Trace-ID: 8e2d080d4a9bc1aa
X-Migadu-Flow: FLOW_OUT
Date: Thu, 24 Sep 2026 19:27:07 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Qishuai Liu <lqs@lqs.me>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv6: fix prefix route expiry in
 modify_prefix_route()
Message-ID: <arUJCyrHCU6lSf3p@fedora>
References: <20260923132048.3272878-1-lqs@lqs.me>
 <arR6KOhDYJrK0lqB@fedora>
 <CACtPduyfC3QMKsFTLjwvVRYfa28T-mNWLeA0CPLtRM5=s2ZnDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACtPduyfC3QMKsFTLjwvVRYfa28T-mNWLeA0CPLtRM5=s2ZnDQ@mail.gmail.com>

On Thu, Sep 24, 2026 at 12:35:18PM +0900, Qishuai Liu wrote:
> On Thu, Sep 24, 2026 at 10:18 AM Hangbin Liu <hangbin.liu@linux.dev> wrote:
> >
> > On Wed, Sep 23, 2026 at 01:20:48PM +0000, Qishuai Liu wrote:
> > > modify_prefix_route() is given the lifetime in clock_t relative to now,
> > > but fib6_set_expires() wants an absolute jiffies value. So when a
> > > permanent address is changed to a finite valid_lft, the prefix route
> > > ends up already expired and GC removes it.
> >
> > nit: Does GC really removes it? I see the expires is negative, but the time
> > seems overflow and GC won't remove it.
> 
> Yes, it is removed once the fib6 GC runs, i.e. within gc_interval if
> the GC timer is already armed by another expiring route, or right away
> with "sysctl -w net.ipv6.route.flush=1".

Ah, yes.

Thanks
Hangbin
