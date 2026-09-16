Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD68E4BD7BE;
	Wed, 16 Sep 2026 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552922; cv=none; b=YcfGgWrlVlxTc1OzyuI5NEgYHBnENiywC371kwHPCexM92iD3awk0bxiHG8mAHH6IcmdmtwUdAwtOtTAt+StLoMrxYICGWDnLn7LEdlLyxOpjYt3IUjLriRptyb9QwiHrTPA+sb9hBXF5ngXZSyVlcdUTFN+pLHN2u6jEWaOZtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552922; c=relaxed/simple;
	bh=Q0KUjZndmryi6+lJ1zoTmy/CxkR8d4apeEMW4Q28Ong=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/uBpROUsCwefo4N5WlHuz5+edMT8hpttFB3sVghOJWBmu2t5b0VI83YGPg++OaFh3o/oqSisyGuW5udfrtijAhqq0DAQ3vGKgs1QxsPPg6/p1hi++3JjkOpkB8hhdAiieDv5QeCFKoD5mn+EmfP1NekYt9hVIYbMoKtNphX0eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=S/OjSK/F; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="S/OjSK/F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XH9Pqr4Mw5lyo9AD7bbvs9Z81Iv1pNh6ufP64/whGEQ=; b=S/OjSK/FX+BcCeoff2wXcUWnNe
	c/WsgEG8fkFISfOLaJUDPYNcGsyu5+DxsATTK7u4/sRxxqQYC6FpHtFW+PgYJpmoSpSAoQRK1rE+3
	30T7BOUehS8jjS8643QaeovOsEugdoNXeSNHO7DxbcJsl9IV0Z+T0U2b9zLiRtaG9/43mQlVOEm29
	trh0mEfe24CReel1BRsecA38Rin2Vv/TmbF2yF7cJ2d9DR2iWEfAjz/vjNxDJHfbForDAcqxYZfSX
	wqECoTMAa0scBQOat+DEj0JmID9E8PbD46TVV2hR65PkPbxymBU4QaP6UuJ0SAx54Aw2EoHdgDmEF
	qKc8w1Dg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x6mSM-0055Sa-2G;
	Wed, 16 Sep 2026 10:01:34 +0000
Date: Wed, 16 Sep 2026 03:01:30 -0700
From: Breno Leitao <leitao@debian.org>
To: Zack Gomez <zack.gomez@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] netpoll: bound the deferred transmit queue
Message-ID: <aqpnhJyXHYrqqohg@gmail.com>
References: <20260914041221.1028092-1-zack.gomez@gmail.com>
 <aqeyvaw06I2883Fo@gmail.com>
 <CAErB-w3fmW4bQqRg7895dZ4ZRqkDJmfb7FSCLPvRCkwrhQzaqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAErB-w3fmW4bQqRg7895dZ4ZRqkDJmfb7FSCLPvRCkwrhQzaqQ@mail.gmail.com>
X-Debian-User: leitao


On Tue, Sep 15, 2026 at 12:45:00PM -0400, Zack Gomez wrote:
> On Mon, Sep 14, 2026 at 01:47:39AM -0700, Breno Leitao wrote:
>
> Seems to work as advertised: with the link healthy the target sends
> exactly the configured rate and nothing is parked. 

Good to hear it.

> > I think the rate limiting should live on the netconsole side, not
> > netpoll.
> 
> I'd still argue the netpoll change is required: there should not be
> a path to OOMing the box. The rate limit is opt-in, and even once
> set it OOMs the same way if the limit is above what the link is
> draining at that moment, which above is 8k/s under the pause and
> 200k/s without it. The two rows at 20k/s are the same configuration
> on a good day and a bad day.
> 
> I read the two as solving different problems. Yours is consumer
> side: it limits how much damage one machine can do to a listener.
> The netpoll cap is producer side: it keeps the sender from damaging
> itself. Both seem worth having.

Yes, I agree.

> > If we do end up also rate limiting at the netpoll side, I'd like to
> > see a WARN_ON_ONCE() here, since it shouldn't be the main ratelimit
> > path, but rather something to flag that something is off.
> 
> No strong opinion on that; I'll defer to the maintainers. The drop
> is counted either way: netconsole sees NET_XMIT_DROP in
> xmit_drop_count and exposes it as transmit_errors.

I am not worried about netconsole here, it copes with the drop fine.

My concern is some other netpoll users that do not check for return
value. Is this change going to affect them?

For instance, team doesn't even check the return value.

	static inline void team_netpoll_send_skb(struct team_port *port,
						struct sk_buff *skb)
	{
		netpoll_send_skb(port->np, skb);
	}

One way or another, I am in favor of adding it, but, with more
extra information about this drop.

If a WARN is too heavy and it seems it might be, would a drop with
a reason be better than just dev_kfree_skb_irq() ?

      dev_kfree_skb_irq_reason(skb, SKB_DROP_REASON_FULL_RING); 


Thanks,
--breno
