Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4167261A;
	Sun, 28 Jun 2026 21:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782680536; cv=none; b=bGw4fnwxuFtLGqoLChZpVHmFeaZJ8nn0qQTmBEIAnBruAS9A9kLX6ymSbbBXgoZAkDyDUtCx13ongblKHhx8UY1sFRBZ6W0af1+GfjN1cNNg7qna4z3Fpm3L4FMCcMCIU9hpordwE4i3s4EalJ11wXWrwQRly3V1GHIwgt3GLiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782680536; c=relaxed/simple;
	bh=rfpd3WbPnifSHSfMdfb2ShUhrdTA2HxDq0vn2oqQ3JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIIg0Dk8pmib2FULzvMbzqkDfQNwAA60v884rjB0tuVk0/OlavxATxT5CTGYbDgFjrTQFPr5Xgp3EZjc1JqPRJaCtAYMD8vRg/Pl1pZx6n/kTsMtx/ghLNCU59cJQq94Zmmex+pFRVuG9Ajdk3jWjW8QBe8EYdqC7NcnysptiE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DP3DyreI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DP3DyreI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UdPVrGBsfiuqpekwBYy0Es3XVPiPzRaFs+oHp2F9b7E=; b=DP3DyreI+7yUlA/LxYAXw/5+Ka
	U/DI5iIEnr2wYYd20XmdK/lgC8rSXxhEgY03rTeHC5TA1b9aq/9akJGhiXCzS86TEA6pnXsq3zyLW
	BY9RusdBe82e1w+9VdFFh5fQRQV45zTF/TraxXInApku/4SMj9JYQtb19Hz2CZBKhY/Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wdwdh-009eJ8-6m; Sun, 28 Jun 2026 23:02:05 +0200
Date: Sun, 28 Jun 2026 23:02:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rafael Passos <rafael@rcpassos.me>
Cc: Jason@zx2c4.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzbot+9ca7674fa7521a3f1bc2@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Subject: Re: [PATCH] Wireguard: Fix data-race in rx/tx counter
Message-ID: <aa423184-7465-4bc9-aff4-d3d671beb3c6@lunn.ch>
References: <DJFTVX3FE7OD.2O8GTO84798T@rcpassos.me>
 <20260628203823.144789-1-rafael@rcpassos.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628203823.144789-1-rafael@rcpassos.me>

On Sun, Jun 28, 2026 at 05:38:23PM -0300, Rafael Passos wrote:
> fixes data-race in {rx/tx}_bytes counter for wireguard connection.
> these values were incremented inside a read_lock_bh block, but write
> protections were missing. making them atomic was the simplest way out.
> This was found by syzbot with kcsan.
> 
> Reported-by: syzbot+9ca7674fa7521a3f1bc2@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=9ca7674fa7521a3f1bc2
> Signed-off-by: Rafael Passos <rafael@rcpassos.me>
> ---
> 
> Hi,
> 
> I am posting this patch to better ilustrate the discussion.
> If this is a non-issue, its fine.
> As I mentioned in the previous email, this issue was reported by syzbot,
> but I was not able to reproduce it.
> I am also aware atomic calls may introduce extra cost on older arm cpus.

Atomics are expensive in general, especially on high CPU count
systems. 

Statistic counters tend to be very asymmetric in usage. They are
incremented frequently, maybe per packet, but reported very
infrequently, maybe every minute when an SNMP agent reads them. So the
solution to statistic counters should reflect this. Increment should
be very cheap, reporting them can be expensive.

There are a few different solutions. Per CPU counters is
one. u64_stats_sync.h may help.

Please take a look at other drivers doing statistics. This is a solved
problem, you just need to copy bits of code from somewhere else.

      Andrew
