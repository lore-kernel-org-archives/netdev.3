Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794536961;
	b=ptINhdT7IzOnhz3WgVCWNUZQ2fmc/NpBXtQrCgUsQEGXBXl9A4dKEe3mAWR5cHOQQ7OO
	 1JU1kALW8v3SsUUkivb8CHTtxet1vM1Hf3fY8OLWLYkb/yRLnyMOG2Nuoetr1C2vd5f40
	 HbVqtQjo2nHICk/bq28hpL6CI8AsodglmxM8dBp5MucsmaNvtQa6aaT4Qrwszf8KnWVtn
	 BkxXYLhgBEKbgkKwhGO9Up3K4mz4A+QmM8Kc7mBe7jb3xCC3BZZtzOBUJ7SdQsOrtoV5/
	 xgkFaMIIzmvUXpgYFTLUUuC7zGFxcjGvsHMePXLD9lrSnhxWFvBSUhRB8Jia+8WSRyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794536961;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TghEp7p8+eQn+xXccg/iuYCg44RMlbPitTII5OfFE0U=;
	b=We7m8XCkWk54SC3AyZA8k98fbZ5aSeQSBsJDPwvilP64tJwXvVnOAoxm8+eqBXpAQGQR
	 HdWhwPc7shk9zFFnlDM4esNHQnzOe2CgDFK1Jrl7zGeSwB3E2QjbdGwlhuj00W+v2FW/G
	 fTK8OjHnVTcmb8bcEN+AafTTOj3SMrd5nmsxX8WqgCK1ZdLDQ8LCh5Lw5IQLAODCL9A+p
	 hqs8elESOBoKYUyG1XeTq7/hfjs2JwewYOEY1f2FP5MoEcg85b0jy5zXvDmenpopgYLJD
	 EYWaZmF+Qa30ErRcvFV1lO80/RkElqsVL4sK8knWsxSKtDg7Eq9Eue0zcXuN13xgyyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QLKxCfku;
	arc=none smtp.remote-ip=91.218.175.42
Received: from mta0.migadu.com (out-42.mta0.migadu.com [91.218.175.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47B7606A330
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 02:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A47B7606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QLKxCfku
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0OtJooa9aydrZp8DkVzRpBy+NvnMkoj0XNcJ9NHvkEE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794536958; v=1; x=1795141758;
 b=QLKxCfku/igd/Zp1PGFhiPVVBxmx7oZeWWj2Q5TQLsKaR3hbK0epfsB3xJH3OS53IlTh4FLk
 zESjxfYuLDnNYOWmjt82BO/4fLwgRiV8zRAvSiGZwqzz61QJUycyHgP/fqn4hmoT8IrBmIbuXI5
 jh84gdxnIipaLpLTCRPkzras=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 1be86121f214132c;
	Fri, 13 Nov 2026 02:29:18 +0000
X-Mizu-Trace-ID: 1be86121f214132c
X-Migadu-Flow: FLOW_OUT
Date: Fri, 13 Nov 2026 10:29:05 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hangbin Liu <liuhangbin@kylinos.cn>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, 1342116488@qq.com
Subject: Re: [PATCH net-next v2 0/2] ipv6: fix rt6_fill_node() multicast
 route query handling
Message-ID: <avZ18UxLG0q9rh_i@fedora>
References: <20261112094630.197244-1-sunwenbo@cmss.chinamobile.com>
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
In-Reply-To: <20261112094630.197244-1-sunwenbo@cmss.chinamobile.com>

On Thu, Nov 12, 2026 at 05:46:28PM +0800, Wenbo Sun wrote:
> When querying an IPv6 multicast route with an input interface via
> "ip -6 route get <mcast_addr> from <src_addr> iif <dev>", rt6_fill_node()
> currently calls ip6mr_get_route() unconditionally and masks any negative
> error returned by ip6mr_get_route() with -EMSGSIZE at nla_put_failure.
> 
> Patch 1 checks mc_forwarding before calling ip6mr_get_route(), matching
> IPv4 rt_fill_info() so queries succeed with RTA_IIF when multicast
> routing is disabled. Patch 2 preserves the negative error returned by
> ip6mr_get_route() instead of overwriting it with -EMSGSIZE when
> multicast forwarding is enabled.
> 
> Thanks to Hangbin Liu for reviewing v1 and pointing out the error
> masking issue in rt6_fill_node().
> 
> Changes in v2:
> - Reword patch 1 commit message for clearer tone and carry
>   Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>.
> - Add patch 2 to preserve negative errors returned by ip6mr_get_route()
>   instead of returning -EMSGSIZE from nla_put_failure, with
>   Suggested-by: Hangbin Liu <liuhangbin@kylinos.cn>.
> - Verify both mc_forwarding=0 and mc_forwarding=1 (MRT6_INIT) cases in
>   a UML kernel alongside W=1 builds on UML, x86_64 allmodconfig, and
>   x86_64 allyesconfig.
> 
> Link: https://lore.kernel.org/netdev/20261111094528.425826-1-sunwenbo@cmss.chinamobile.com/ [v1]
> 
> Wenbo Sun (2):
>   ipv6: check mc_forwarding before calling ip6mr_get_route()
>   ipv6: preserve ip6mr_get_route() error in rt6_fill_node()
> 
>  net/ipv6/route.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> -- 
> 2.33.0
> 
> 
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
