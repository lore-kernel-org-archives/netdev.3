Received: from mta0.migadu.com (out-130.mta0.migadu.com [91.218.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA124A21
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790560829; cv=none; b=oL1OrYTP9/7mFchx01mWkSogcUEKcZdYM41aBRup1/n0ZtS9eH03u6EQSuswV+3PbX3aq8ngaxHuyp2ZzrtJ4b30LvtswMRfvR+Vt5j8VK2wdSQHdVn3QspMcobZvzU+35Ha8SYY7grDFNXnOUle30b1fKvjVwGFs5C+dM4xQ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790560829; c=relaxed/simple;
	bh=A7C0cOCHyZT7e0S8ER1YNxiejjnfhDrIw0iXWc1d5FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbT9ax+6g/IM7HGE+QWol1ZKCOPxWAFWtZRfiyDmdcxg4DOu84/hatpbmv8xIgqjwWvWCRVCcbWDVPTVp0/s8/kqF8f1xagBZxeoXtOyJbYXWV0/xjG719q6RMJvchQQIdFT6lpZeD54RmVLdiO3wggPUbBmGoM33lw2GuBn6O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SKAsIp9Z; arc=none smtp.client-ip=91.218.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SKAsIp9Z"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=A7C0cOCHyZT7e0S8ER1YNxiejjnfhDrIw0iXWc1d5FA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790560825; v=1; x=1791165625;
 b=SKAsIp9ZzscZHjFPTiaZmPRywI0dgw92DdO+iogD+ur33LhXyMAJ+m07a/UAEqEcpuYVjXuD
 H8vdvEtdqVH211e/he82+llRkw32hntlQeiqK/qKl3Q37NU5Li2RTJgdCmtO08nIVJBHW2qbfCb
 fd5a0KumPad33eqO3L/dHuGE=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 32a33e1614fb5b9e;
	Mon, 28 Sep 2026 02:00:25 +0000
X-Mizu-Trace-ID: 32a33e1614fb5b9e
X-Migadu-Flow: FLOW_OUT
Date: Mon, 28 Sep 2026 10:00:14 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Danielle Ratson <danieller@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next v2 9/9] netlink: specs: fix incorrect
 name-prefixes
Message-ID: <arnJFLyI-idCF_OB@fedora>
References: <20260925213918.204767-1-ast@fiberby.net>
 <20260925213918.204767-10-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260925213918.204767-10-ast@fiberby.net>

On Fri, Sep 25, 2026 at 09:39:12PM +0000, Asbjørn Sloth Tønnesen wrote:
> Fix two invalid name-prefixes in the specs:
> 
> - It's PHY_UPSTREAM_MAC, not PHY_UPSTREAMMAC.
> - It's PHY_UPSTREAM_PHY, not PHY_UPSTREAMPHY.
> - It's OVPN_MODE_P2P, not OVPN_MODEP2P.
> - It's OVPN_MODE_MP, not OVPN_MODEMP.
> 
> CC: Andrew Lunn <andrew@lunn.ch>
> CC: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
> Note for Sashiko/Clashiko: Targeting net-next, so no "Fixes" tag.
> 
>  Documentation/netlink/specs/ethtool.yaml | 2 +-
>  Documentation/netlink/specs/rt-link.yaml | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index 6868eb473478..a66594ad9e73 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -99,7 +99,7 @@ definitions:
>      enum-name: phy-upstream
>      header: linux/ethtool.h
>      type: enum
> -    name-prefix: phy-upstream
> +    name-prefix: phy-upstream-
>      entries: [mac, phy]
>    -
>      name: tcp-data-split
> diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
> index e3a4b4e7e5ef..81b58633911d 100644
> --- a/Documentation/netlink/specs/rt-link.yaml
> +++ b/Documentation/netlink/specs/rt-link.yaml
> @@ -842,7 +842,7 @@ definitions:
>    -
>      name: ovpn-mode
>      enum-name: ovpn-mode
> -    name-prefix: ovpn-mode
> +    name-prefix: ovpn-mode-
>      type: enum
>      entries:
>        - p2p
> -- 
> 2.55.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
