Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.93
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793784820;
	b=NeEw8Jkp6kcEGSrunxTpAjVZ3D5MKDN6jW8QJlbHrxrK3bLx+bkSMA5kCiYlbOtzDmGR
	 goEO5vaK/diC6EJD0/zlH3eFic6MuX9Zf4D8g36onh7H/hnRV7wMZm51ZXVlNzY3nGF3J
	 pFK22jttI5kZZ2SFFb8z5AOWPcmX0s0/ZxPa8DeiKNq6Jpb6KOY4c8sT5ETjLyEAxq94l
	 XO9KpTC2EJhgevDSx7JZNKbE4drfk/Uu/55GVAks2MeGkJVgDleepGEA2V85pAyAs99u0
	 04cGLaKlgy3bbHv+mRjwREOGQnS4Y4BTz0gkSUf46vrNj44eJU2KNDkkZ9XSSxSTN2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784820;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PUV7VlMf0EvvLzp+y5o1NyE7TTufq1+bMSMSc6a2SOE=;
	b=4v7jSeFreAYjn9t3gGshLllufwe4Fzm88yubM2RK8DLL3xJfDmpcNy2KmyaA5SkXbtxJ
	 FvDBvsDPAF2k1c1pVxQmYwQ3SDSdo+k8JBggxjTMAAkzAKVWM8LKIC8zgeK+hinzzWkcK
	 s92f1JOoGTR7Wf021ubmeWsyjF2p6NQZ+XOrwhoZh/VWPPZvJ0I1Pye7m37lAc0WoiPeR
	 Cz2FjEzSzDPiDcdybPf/x8czFBhbLHrI5dgc6JFmvq4gsq82O4Gyh9iSHy/iR4+m1p0yZ
	 X/Ld5Gj7qE0mt+oT/yD3UeR8nJPd3TIY2ZLDeEYJkfhsLSA9paVJ/Tm1lG9xJHT17EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=j7HCUZ3X;
	arc=none smtp.remote-ip=91.218.175.93
Received: from mta0.migadu.com (out-93.mta0.migadu.com [91.218.175.93])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C077606A330
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 09:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C077606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=j7HCUZ3X
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8dK0Lo7DM1WJ0OGxApcuKa8B214rVf6nLR5cxtZwcuc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793784817; v=1; x=1794389617;
 b=j7HCUZ3XEX9RzkQzuaBsIvF+yJySl9qKAMKcK6gL1KSgkapo9XW5KlnO2KVE0+3NzQjJx9Vv
 hM/+NDR6x5uRVN6nTr7lF88oFSom8RZdc+kRCGptJV5SZP8sMymD/Xvhj/41ubIyEKvqSuWXENN
 gbzx1l+rk+a1H6zAqAw4+6BA=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 5b91f46f81561111;
	Wed, 04 Nov 2026 09:33:37 +0000
X-Mizu-Trace-ID: 5b91f46f81561111
X-Migadu-Flow: FLOW_OUT
Date: Wed, 4 Nov 2026 17:33:16 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Justin Iurman <justin.iurman@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@kylinos.cn>,
	Sashiko <netdev-bot+sashiko@kernel.org>
Subject: Re: [PATCH net] ipv6: ioam6: do not modify shared tuninfo eh.nexthdr
Message-ID: <aur73BdyLKNrZAUZ@fedora>
References: <20261104-ipv6_ioam_lock-v1-1-4f24c41b261b@kylinos.cn>
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
In-Reply-To: <20261104-ipv6_ioam_lock-v1-1-4f24c41b261b@kylinos.cn>

On Wed, Nov 04, 2026 at 05:27:23PM +0800, Hangbin Liu wrote:
> From: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> ioam6_do_inline() and ioam6_do_encap() stored the next header into
> the shared ilwt->tuninfo template and then memcpy()ed it into the
> skb. The lwtstate is used from multiple CPUs without locking, so
> another packet can overwrite eh.nexthdr between the store and the
> memcpy.
> 
> The packet can then leave with an HBH nexthdr that does not match its
> payload (e.g. TCP labelled as UDP, or a local packet labelled
> IPPROTO_IPV6). Set nexthdr on the per-packet Hop-by-Hop copy after
> memcpy instead, leave the shared template read-only.
> 
> Fixes: 3edede08ff37 ("ipv6: ioam: Support for IOAM injection with lwtunnels")

This patch should also

Fixes: 8cb3bf8bff3c ("ipv6: ioam: Add support for the ip6ip6 encapsulation")

Hangbin
