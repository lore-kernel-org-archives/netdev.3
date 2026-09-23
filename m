Received: from mta0.migadu.com (out-104.mta0.migadu.com [91.218.175.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F5A32E12E
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 01:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790125561; cv=none; b=Wshmf55numsOpkMiXxiqvfZwQRhzI0JI/Zz14U+xiJNEaSYx0YHltE0INZ/nR0F5uY884eR6sDFDD5Cc9W0cJujhmwAhZtboJGyuVGs2hhwnVxvVQ2MpDwSEhGhXifa7Mdi23RjiTg94XJcg9aJwbwK9/SrIQhniLhkrdNjnlHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790125561; c=relaxed/simple;
	bh=FGIBP2DKRVy8CBJKxfLHahH/Xq3TOzbHupuBVzy36FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saxqL/xlQS4VX9F2kSDblaOdkHvQGYHkb2uU+RNcfqwxTy0YptzVdK/SseWD9mcGIdyFTt9bNA1R/ag3WzxTTOyz4E9YR7ABVJvJc7+Sd3Za8c2AiueTDPC2bpDqcEsyxOoXO3IquXQRrJVNrvn/lesJE368fzoDD756NFRRoNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZMTYs+iO; arc=none smtp.client-ip=91.218.175.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZMTYs+iO"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FGIBP2DKRVy8CBJKxfLHahH/Xq3TOzbHupuBVzy36FI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790125557; v=1; x=1790730357;
 b=ZMTYs+iOjl7FSqnggYn6A0ww9F6vHC97IvL6TyhZb50LWs1Pl4XRwdBw8woI++Eh6AQuVUic
 yUcILIYgz4zp0jyOmqt0oKWcxJJbRDeuOvQTBBDXjpozvxqAMezqkJ/ouFoazRdFPq4ra8pG7ek
 b89Koe8Sw68hWPl+gjzKcYt0=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id c20166ea8e9ea79a;
	Wed, 23 Sep 2026 01:05:57 +0000
X-Mizu-Trace-ID: c20166ea8e9ea79a
X-Migadu-Flow: FLOW_OUT
Date: Wed, 23 Sep 2026 09:05:45 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, dsahern@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, tgraf@suug.ch,
	pshelar@nicira.com, linux-kernel@vger.kernel.org,
	luoxuanqiang@kylinos.cn
Subject: Re: [PATCH net v2] ip_gre: Reject enabling collect metadata through
 changelink
Message-ID: <arMl6ePySuNonC4I@fedora>
References: <20260921031859.9283-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921031859.9283-1-xuanqiang.luo@linux.dev>

On Mon, Sep 21, 2026 at 11:18:59AM +0800, Xuanqiang Luo wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> ipgre_netlink_parms() can enable collect_md on an existing GRE, GRETAP
> or ERSPAN device. Unlike newlink, changelink does not enforce metadata
> tunnel uniqueness. Converting a non-metadata device can therefore
> replace the metadata receive entry for another device of the same type
> in the same netns. Deleting either device then clears the shared entry,
> breaking metadata receive lookup for the surviving device.
> 
> If parameter validation fails after collect_md is set, deleting the
> modified device can also clear an entry it never owned.
> 
> Reject enabling metadata mode in both changelink callbacks before any
> encapsulation or tunnel parameters are modified. Allow requests that
> repeat the metadata attribute on an existing metadata device.
> 
> Fixes: 2e15ea390e6f ("ip_gre: Add support to collect tunnel metadata.")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
> Changes:
> v2:
>   - Add an extack message when rejecting collect_md enablement in both
>     changelink callbacks. (Ido Schimmel.)
>   - Rebase onto the latest net/main.
> 
> v1: https://lore.kernel.org/all/20260917095016.71937-1-xuanqiang.luo@linux.dev/
> 
> The state change on failure can be reproduced without an existing
> metadata tunnel (output abbreviated):
> 
>   # ip link add g1 type gre local 192.0.2.1 remote 192.0.2.2
>   # ip -d link show g1
>       link/gre 192.0.2.1 peer 192.0.2.2 ...
>       gre remote 192.0.2.2 local 192.0.2.1 ...
> 
>   # ip link set g1 type gre external
>   RTNETLINK answers: Invalid argument
> 
>   # ip -d link show g1
>       link/none c0:00:02:01 peer c0:00:02:02 ...
>       gre external remote 192.0.2.2 local 192.0.2.1 ...
> 
>   # ip link del g1
> 
> The request fails, but collect_md and the device type have already
> changed.
> 
> If another metadata tunnel exists, deleting this device can clear its
> collect_md_tun entry. A successful conversion can overwrite that entry.
> 
>  net/ipv4/ip_gre.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 82309efd417e0..e4878e9aa6367 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -1464,6 +1464,12 @@ static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
>  	if (!rtnl_dev_link_net_capable(dev, t->net))
>  		return -EPERM;
>  
> +	if (data && data[IFLA_GRE_COLLECT_METADATA] && !t->collect_md) {
> +		NL_SET_ERR_MSG(extack,
> +			       "Enabling collect_md on an existing device is not supported");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	err = ipgre_newlink_encap_setup(dev, data);
>  	if (err)
>  		return err;
> @@ -1496,6 +1502,12 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
>  	if (!rtnl_dev_link_net_capable(dev, t->net))
>  		return -EPERM;
>  
> +	if (data && data[IFLA_GRE_COLLECT_METADATA] && !t->collect_md) {
> +		NL_SET_ERR_MSG(extack,
> +			       "Enabling collect_md on an existing device is not supported");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	err = ipgre_newlink_encap_setup(dev, data);
>  	if (err)
>  		return err;
> 
> base-commit: 1e24c4f2ee44be0eee94092b5d13cbdb4bdf0d60
> -- 
> 2.43.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
