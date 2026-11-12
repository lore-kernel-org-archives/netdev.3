Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467743;
	b=dEfyB5fGb38FUS4m3fF7SORuoGUDX99WtONkir9D+9SYF6Sq2YbX3GZ3jLfGM4VDJphQ
	 0YvFA/eIMi7OW2J0XzqjODE3YMw4NLv1yHhi/PsvUvLa0CA4bYQCA7y94konLHzyH8L3f
	 mE2fcjNPRBtZT1e7KXYYM8+R/iPNEMgDSyAtr5xfEt0y+ItcxIU5aH5fcgmIfanY6mA3H
	 avEit2NJoxxQ1xn4WkC0lCepEi9xMpFdE6sDkZG+bPi/b0ROiUJ/DA2gRzdA7QfB1gQMg
	 c1MYGsap2885lKQw/7QKtpi1rR4EV0iid4KNS2wDS0ssw04p4gBmrF295iHmZ+e4eQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467743;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sD4XhwxF8s8xTiMUALl2zDR61pVT/mrOLvoYZrZI+nM=;
	b=BRbxYytcNztMnyKtJ3x8RwEkNt4jn8ojr37wgE2RiVy6jMUEQCZkGO0hhCCyjEmzl4RP
	 GSJbHR7Drk54Dl1oUQmd41ys0fBdQ5A81PdxG7ZFLke/Se5LgvqvZ1n87ccfAcKERCeeu
	 ZvANF3KokDbV59H1eZHV54Q7+cId0uizuJwYfrM42QWxq6InJFUrkWaB7XO5zU2cnn1zC
	 AovySsC4yM6nLOpAOe76PSwi83tii6/PU0hR8aQFnUDzz2pAjbTB9sEsaRvzL9IUyflk5
	 JOCumPqEc5rTtpJW8stahmF1HsKKdR+vylow/OnXN/6gDNySFRvJhaaXiStBgD/S/NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=cQyyEr4N;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6566606A323;
	Thu, 12 Nov 2026 07:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6566606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=cQyyEr4N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=cQyyEr4Nr1ZgpVPx16UzNx00wgG86++ftWFsuRmDnh1aiTWnaDDpbYuPwfla/d8uNJ2GiiOEbqeEI
	 uz64dHp/mfOaOnbbPqM7TjhnVw9WktZdXJli5wsyKrlqAQMqvo1GBPgnD/1ShzQTRkzmV6Lo8ui8p1
	 IbCEV+wW38MZlp3M=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66af56797f44-abc8d;
	Thu, 12 Nov 2026 15:15:38 +0800 (CST)
X-RM-TRANSID:2ee66af56797f44-abc8d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.net (unknown[223.64.115.200])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76af56799825-f6c50;
	Thu, 12 Nov 2026 15:15:38 +0800 (CST)
X-RM-TRANSID:2ee76af56799825-f6c50
From: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunwenbo@cmss.chinamobile.com,
	1342116488@qq.com
Subject: Re: [PATCH net-next] ipv6: check mc_forwarding before calling ip6mr_get_route()
Date: Thu, 12 Nov 2026 15:15:19 +0800
Message-Id: <20261112071519.96139-1-sunwenbo@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <avUhGnPJk5Kzci3E@fedora>
References: <20261111094528.425826-1-sunwenbo@cmss.chinamobile.com> <avUhGnPJk5Kzci3E@fedora>
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
Content-Transfer-Encoding: 8bit

Hi Hangbin,

Thanks for the review and the Reviewed-by tag!

On Thu, Nov 12, 2026 at 02:14:50AM +0000, Hangbin Liu wrote:
> In commit fd61c6ba313d ("net: ipv6: remove nowait arg to rt6_fill_node"),
> David Ahern removed the nowait arg. Should we still return immediately
> after err == 0? Also later if (err < 0), it still goto nla_put_failure
> and return -EMSGSIZE. Maybe we can carry the err to the end and return
> a more meaningful reason?
>
> Anyway the added checking makes sense to me.
>
> Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>

Both are very good observations on the existing ip6mr_get_route() error
handling in rt6_fill_node():

1) Regarding `if (err == 0) return 0;`:

   Commit fd61c6ba313d only removed the unused `nowait` parameter (whose
   value was always 0) and kept the pre-existing `!nowait && err == 0`
   early return, mirroring IPv4 rt_fill_info(). Returning 0 from
   ip6mr_get_route() means a cache miss was queued via
   ip6mr_cache_unresolved() on nl_queries for asynchronous resolution;
   falling through in rt6_fill_node() would append normal FIB attributes
   without RTA_IIF.

   That said, looking closely at inet6_rtm_getroute(), `skb->dev` is
   currently never assigned there (unlike inet_rtm_getroute() in IPv4),
   so on a cache miss ip6mr_get_route() takes `if (!dev || ...)` and
   returns -ENODEV before ever reaching ip6mr_cache_unresolved(). Even
   if `err == 0` were reached, returning 0 early skips nlmsg_end() while
   inet6_rtm_getroute() still calls rtnl_unicast() when `err >= 0`.
   Reworking that path would require changes in ip6mr.c and
   inet6_rtm_getroute(), which goes beyond this patch's scope.

2) Regarding returning the real negative `err` instead of -EMSGSIZE:

   Agreed -- ip6mr_get_route() can return -ENOENT, -ENODEV, -ENOMEM, or
   -ENOBUFS, and jumping to nla_put_failure masks all of them as
   -EMSGSIZE ("Message too long") even when mc_forwarding is enabled.
   Among all callers of rt6_fill_node(), only inet6_rtm_getroute() passes
   a non-zero iif and propagates negative errors back to userspace, so
   initializing `int err = -EMSGSIZE;` and returning `err` at the failure
   label looks safe and much cleaner.

To make it easy to review both together while keeping each change clear,
I plan to split this into a 2-patch [PATCH net-next v2 1/2] + [2/2]
series after the 24-hour resend window:
- Patch 1/2: check mc_forwarding before calling ip6mr_get_route()
  (carrying your Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>).
- Patch 2/2: preserve and return the negative error from
  ip6mr_get_route() in rt6_fill_node() instead of -EMSGSIZE.

Thanks,
Wenbo


