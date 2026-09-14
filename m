Received: from mta0.migadu.com (out-146.mta0.migadu.com [91.218.175.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197C82E7391
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 06:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789368098; cv=none; b=Sk1/mxLwY0pO65t0hJH9yUxyuzlSB4g5qdMuMbSAt8cdZr91b67o34jQB8iGDsOg/fZrQ7vESUY4bStEpXFKbCidjBDMGMmOYkmnTqe5v3E09zbKUnYmdiLu8t6e1udA9sXCYABrim/sI0HpPwvRohhflYIOgJViFpTld1jpUmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789368098; c=relaxed/simple;
	bh=B7j3S9hz/Za2T3o/AkBrJDeuApRYDK6C55qvl/qBb/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOA4bUCm7gW6cLbZ9qAOLslcUMMXbmiQVuA5/lYekB1lbZmJ1aq3vUGB45BjkPlFcbyQd2/e3G4LH3XGjWKpPK8tCUInWgBtUfnxjJ6S8x8U1f68KuiktJJWnEHUfFxYMalFJjj/eXyQPS9fyeOO9YuKDBtOMoWJcmdVpMkB/4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pjQIz7FU; arc=none smtp.client-ip=91.218.175.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pjQIz7FU"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=B7j3S9hz/Za2T3o/AkBrJDeuApRYDK6C55qvl/qBb/Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789368094; v=1; x=1789972894;
 b=pjQIz7FUfkKvpME39tQtRSrCYvzHPuZE0CnkqmKQp2Xi+0XD1+dvo0FMGzmeLblm9XUuE/og
 SUQBIp+jN2O44Uczi/unmghgeCpYnd4MzZ7LYxtLeANehsO1oI472qEelZ2RhTWHWcky/WUYoI/
 Es5vul765bXSgvdVasQUBKFE=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 6e1b387c25adcb8d;
	Mon, 14 Sep 2026 06:41:24 +0000
X-Mizu-Trace-ID: 6e1b387c25adcb8d
X-Migadu-Flow: FLOW_OUT
Date: Mon, 14 Sep 2026 14:41:06 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	donald.hunter@gmail.com
Subject: Re: [PATCH net-next 1/2] netlink: specs: tcp_metrics: fix the
 attribute length checks
Message-ID: <aqeXAob9hyiXQvhs@fedora>
References: <20260912234337.308298-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912234337.308298-1-kuba@kernel.org>

On Sat, Sep 12, 2026 at 04:43:36PM -0700, Jakub Kicinski wrote:
> TCP_FASTOPEN_COOKIE_MAX is the longest cookie we accept, not the shortest
> one. Cookies are even sized, from 4 bytes up, and the ones Linux itself
> generates are 8 bytes, so a 16 byte minimum declares all but the longest
> cookie invalid. The reference policy kept under #if 0 in tcp_metrics.c
> spells it as a maximum, which is what .len means for NLA_BINARY.
> 
> The IPv6 addresses err the other way. The policy uses
> NLA_POLICY_EXACT_LEN() for both, so a request carrying a longer address is
> rejected with -ERANGE, even though the spec advertises 16 bytes as a mere
> minimum. Were the policy generated from this spec, as kernel-policy: global
> promises, the check would turn into NLA_POLICY_MIN_LEN() and start
> accepting over-long addresses, of which nla_get_in6_addr() would take the
> first 16 bytes.
> 
> Nothing generated changes. fopen-cookie is reply-only so it never gets a
> policy entry, and exact-len only feeds the policy (and the fixed size array
> form, which needs a sub-type).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/netlink/specs/tcp_metrics.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/tcp_metrics.yaml b/Documentation/netlink/specs/tcp_metrics.yaml
> index 13144aeed31a..1d365908084d 100644
> --- a/Documentation/netlink/specs/tcp_metrics.yaml
> +++ b/Documentation/netlink/specs/tcp_metrics.yaml
> @@ -32,7 +32,7 @@ kernel-policy: global
>          name: addr-ipv6
>          type: binary
>          checks:
> -          min-len: 16
> +          exact-len: 16
>          byte-order: big-endian
>          display-hint: ipv6
>        -
> @@ -63,7 +63,7 @@ kernel-policy: global
>          name: fopen-cookie
>          type: binary
>          checks:
> -          min-len: tcp-fastopen-cookie-max
> +          max-len: tcp-fastopen-cookie-max
>        -
>          name: saddr-ipv4
>          type: u32
> @@ -73,7 +73,7 @@ kernel-policy: global
>          name: saddr-ipv6
>          type: binary
>          checks:
> -          min-len: 16
> +          exact-len: 16
>          byte-order: big-endian
>          display-hint: ipv6
>        -
> -- 
> 2.55.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
