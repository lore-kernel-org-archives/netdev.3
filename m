Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148966;
	b=1jH9p/raivtJK7lhzfl0qb3m0MpK77IBKbZ8KH73f29q+gfl+i0n/UbIIcJtEZxnxdIG
	 J70BWeSBWnwbauE/k3fVWRfhl0fVLybYPfhcsuhAck4QCN5cXF+WKjEg3YKt4fbBC+cjN
	 5kKyRjHXolAAc+QnD2JI0C/T8OMxqw8EazqJ0Tmrojg2N90oT7qKJlXX2vY0OP5CH+DGZ
	 XZ09SmHMxyCVtwjhuI887mkeU803ql2yR5cSkgKLqHfghRRnvE3gkEfpFbNgSLQ7Hu4Fy
	 2K7L/JIPo+x9jaZlieccWyKgIP25Nfz13JXGPv7WiBAFZP3qeTImYt8Y2w9MEvMeLfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148966;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=eit43aTmntcI/a8LLYb0KjYLZEdX3ZZM9XTb1U4DSis=;
	b=ecfZEGP2p+/ZkNMxE2w4vKuVOacYBNnWtoaP8IEitjhCBGp7BIg36jf7kKR9/rb1SjIq
	 IWnPC2gVNv+WHsSVCS97ZwaCecTt82cQpSV4WJRb8Jdg8hNYM9mAwb+IGgWrhn36ZpiNh
	 KHcckpvLgid/B+Of2jhYEejnMPJ+pzOCxcf8m0mMmPvMs21dIRCbOg6u1JohlwbRtzw6a
	 W6KvhtJnUb5FmERwFEdBTWecRtQYxw2B4SN20aV0aML5rWDVzX3RR2AzzOC9V6Bnw5EKe
	 BVrv20quzQd/Fz5Qv0Bm7vmPwBLZZA7n8fkcKhztrpst8/PeEapXpZjmURlzzCfw+sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=la24EeBL;
	arc=none smtp.remote-ip=91.218.175.11
Received: from mta0.migadu.com (out-11.mta0.migadu.com [91.218.175.11])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043FA606A320
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 00:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 043FA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=la24EeBL
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jD/DZc8I3oxbxEmjOJOmyZnS5g2so0+XNRCpAsgTwH8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793148963; v=1; x=1793753763;
 b=la24EeBLCP2x6FcVGepMMGQhXvIelV/QsM8FWqPyAOvhzD1KRXt5FglTaSJiF6FZcJTRreP4
 WsVut+10jGPoFfWHyzZlAMmz2LvRMuWLUDP9VEOZQ6+g7NyPnTFp7/eakdeSuMxVuIA5IOEKdIa
 lw6WFecjU1vZN98aU9lTwGIg=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 9002972c6cdf6e23;
	Wed, 28 Oct 2026 00:56:03 +0000
X-Mizu-Trace-ID: 9002972c6cdf6e23
X-Migadu-Flow: FLOW_OUT
Date: Wed, 28 Oct 2026 08:55:54 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ido Schimmel <idosch@nvidia.com>, Gabriel Goller <g.goller@proxmox.com>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv6: Add NETCONFA_FORCE_FORWARDING to netconf
 messages
Message-ID: <auFIGnqlq3-qd6TN@fedora>
References: <20261023-ipv6_add_netconfa-v1-1-94d14b07d621@proxmox.com>
 <20261025131102.GA184152@shredder>
 <at7JgfsvrAUxtPzy@fedora>
 <20261027143814.335587dd@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027143814.335587dd@kernel.org>

On Tue, Oct 27, 2026 at 02:38:14PM -0700, Jakub Kicinski wrote:
> On Mon, 26 Oct 2026 11:31:13 +0800 Hangbin Liu wrote:
> > > This seems to fall under the "Not a regression, not critical" category
> > > [1], so can wait for net-next.  
> 
> Agreed.
> 
> I think this is more of a "missing functionality is not a bug", even.
> 
> > One question about this rule. For "not critical" fixes, should I make that
> > judgment myself and post to net-next? Or should I send them to net and let
> > the maintainers decide whether the fix should go into net or net-next?
> 
> Post fixes for net, let maintainers decide.

Good to know this. Thanks for your reply.

Regards
Hangbin
