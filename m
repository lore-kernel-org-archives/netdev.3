Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C95537AA81;
	Mon, 29 Jun 2026 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744720; cv=none; b=VK9T3TdE5N2Pe7uoku1KsOxLrEpiIfrKbFk47KeBSJmg1/7Jdi5JI0lv6x9v1RGMva4N3yzDzdkj9Q393orJWr8O/7irn+FFU6xVI3Eu53Tmq3rVJnvNvktUaLC7jPeQaljRwKEdKcvdHZANB1CKG7E/ldqfg5ebtlHRbcPh+ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744720; c=relaxed/simple;
	bh=/fnKstZTxpGqEDSaqOgUdnlO5VH/C68uK+N8UmIpMn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQCd5bti1zs66xQ6E6snsxycU2+td0mrxOxS3HENGuAELKnWp1kZ8zK50BF9OU0qSXB5Y+ONF88cDsQIe09EU1e3Oh5QfXILWjp7qhuavv3UYO5YWQjd35LoB60+SmEPgOuS+Zmf/cyFdbxQ6f6xwNHUQaPJeg+/HQttF0+H8iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CyjnYNT+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CyjnYNT+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/AfarInOXZoQttS9XdojiWOifGGDVIjOfnZjpbVuMLA=; b=CyjnYNT+ZnESbXQF1Svd7WQk8f
	uBfbEKyFXVd8qGyQUVAWVUauOKMpiUSWKR8JqGQGCVPlYAJ2fGTlieuDmb61VQsSsr4uaEvVHE9R6
	SyStUQKj1dUeUloX6PkK/z8ohPeKVC+Tg0y/12ctqnEVt2iRiOb0QD9/ZfYb2GCVqtts=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1weDKu-009m0c-7X; Mon, 29 Jun 2026 16:51:48 +0200
Date: Mon, 29 Jun 2026 16:51:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rafael Passos <rafael@rcpassos.me>
Cc: andrew+netdev@lunn.ch, tytso@mit.edu, Jason@zx2c4.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+9ca7674fa7521a3f1bc2@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Subject: Re: [PATCH v2] Wireguard: Fix data-race in rx/tx counter
Message-ID: <b8155b00-ce06-49de-a283-3db4dbc0c99c@lunn.ch>
References: <DJL786MPR9HO.BWHI3U37PDVM@rcpassos.me>
 <20260629125913.2354450-1-rafael@rcpassos.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629125913.2354450-1-rafael@rcpassos.me>

> When looking around drivers/net, I found a few u64_stats uses without
> per-cpu. I will do some digging to understand the reasoning behind it,
> compared to the original "bare u64 counters" in wireguard.

/*
 * Protect against 64-bit values tearing on 32-bit architectures. This is
 * typically used for statistics read/update in different subsystems.

The assumption is, updating a 64 bit value on a 64 bit machine is a
single operation. You either see the old value, or the new value. For
statistics counters, we general don't care about valid but slightly
outdated values.

On a 32 bit machine, updating a 64 bit value requires up to two reads
and two writes. So if a reader and a writer operate at the same time,
the reader might see one of the invalid intermediary states, also know
as tearing. We do care about a totally wrong value.

u64_stats_sync.h gives you a mechanism which is totally free on 64bit
systems, but gives the needed protection on 32 bit systems to avoid
seeing tears.

You only need mutual exclusion on the writer side, from other
writers. If you have per-cpu counters, you naturally get mutual
exclusion, the CPU cannot be a writer twice to its own per CPU
counters. However, without per-CPU counters, you need some form of
locking. I don't know the locking used in wireguard, it might already
be in place? If so, this would be a cheap solution.

	Andrew
