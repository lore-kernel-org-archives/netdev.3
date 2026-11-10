Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.63
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794299276;
	b=olHAKFfvXTN1SII0c7f6TYyutHaYebZ41E0/b2ajlzMNbGXGqDOONpBD0zIdWgSMLszA
	 5hu4PeqAops2RZbEOM8xfkrq1ZbP6wFQMy/tg17exKKYnFVf6HLw5TR7gw4W7bu831XVj
	 1pj4a6xsCQK+w3aTbmBBuhSOZvT03p/XlIKRfq8lEdw6yQZUEQDxMb0z3+55wkpoSUnpB
	 CpEfA4GeTi/1MO3xKqnIqD7FV3E8ZhEl0SK9oZfmhCIIRCqI5CKnr+btohOEZeZb9V8cg
	 uVExU3SCMC6ZnH7P/pi+jKmzY9gJjAOGj+szWqx79kuwoMdOSoNM3D91+3/Het3sZTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299276;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QVG84ywnvvvo4mhvznhN8Apw+WrF5iBUfJxBCISwA4g=;
	b=OEoURv2ylLubuuW75VckarbosxPTc3lxT732lXfxBH43sVeYmqvG3+gnJROSu5ms/1O6
	 wX7aGtLZdEkxaYSb1H/L5YH0DRPphlAHtQ81h4IS1YDVyFlUpGosMz1LDCbtbOZzcrLze
	 aAyaLnpXbimKKrchKMm1TGsOWShT5QTIzzH8nHfCRsCv8oPzqQWzp1Az1RDyuqHQmuR0J
	 Ocm+0jFgfyTF9JwbqvsuFSsZEcGHjEG2Lw1e6K5R98CcdAG+GGo7hTPq7ngb1aU2a87G4
	 AIvecZyEhBtoW+tZQ9pz0ujGI7oWKHAU3Z1EpfcWahSOYgjoGr1rNueSvR0A3QteAcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sc3N4wsY;
	arc=none smtp.remote-ip=95.215.58.63
Received: from mta1.migadu.com (out-63.mta1.migadu.com [95.215.58.63])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEF360A262B
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADEF360A262B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sc3N4wsY
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/s2vkEvJeQPZcd9B+wkgpvWUhoTDAmhxYherM65EMfc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794299273; v=1; x=1794904073;
 b=sc3N4wsYqvfA8Zc/1gkRKERt/kqFqyIZ2+9kifSVGgwL/aY5vHq8yiK9Ksy/Os0CNLPMSVY4
 KCNvwRlXDRa1TKJ7CLuqpILesIVJmIt7kPqnyQs/0UgTr35fqin+sZ6oKq4pgeqsg7657x7aBpI
 iVMRCQMo/uWRo4HYUC19lTuM=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id f3e52e94e0089280;
	Tue, 10 Nov 2026 08:27:53 +0000
X-Mizu-Trace-ID: f3e52e94e0089280
X-Migadu-Flow: FLOW_OUT
Date: Tue, 10 Nov 2026 16:27:41 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, dsahern@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrea Parri <parri.andrea@gmail.com>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Nikolaos Gkarlis <nickgarlis@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] rtnetlink: return EMSGSIZE when first dump entry
 does not fit
Message-ID: <avLVfWQEtsLH4BUA@fedora>
References: <20261109012115.11898-1-stephen@networkplumber.org>
 <20261109012115.11898-2-stephen@networkplumber.org>
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
In-Reply-To: <20261109012115.11898-2-stephen@networkplumber.org>

Hi Stephen,
On Sun, Nov 08, 2026 at 05:13:12PM -0800, Stephen Hemminger wrote:
> If a route entry is too large for the dump skb, the dump is silently
> truncated and no error is returned.
> 
> For handlers with RTNL_FLAG_DUMP_SPLIT_NLM_DONE, rtnl_dumpit() drops
> -EMSGSIZE and returns skb->len. With an empty skb this is 0, so the
> dump ends with NLMSG_DONE and status 0, and the remaining entries are
> lost.
> 
> The first dump skb is allocated from __netlink_dump_start() while
> max_recvmsg_len is still 0, so it is only NLMSG_GOODSIZE. On a 4K page
> kernel that is under 4000 bytes, and a 500 way multipath route does not
> fit:
> 
>   ip link add dummy0 type dummy
>   ip link set dummy0 up
>   ip route add 198.51.100.0/24 table 100 \
> 	$(for i in $(seq 500); do echo -n "nexthop dev dummy0 "; done)
>   ip route show table 100
> 
> The dump prints nothing and exits 0, although "ip route get
> 198.51.100.1 table 100" still shows the route.

One question. AFAIK, `ip route get` doesn't support "table" parameter. No?

Thanks
Hangbin
