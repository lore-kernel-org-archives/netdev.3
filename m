Received: from mta0.migadu.com (out-143.mta0.migadu.com [91.218.175.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874FD3D9526
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 07:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789888371; cv=none; b=hdDh/bIkz2wuC549kF55xA5He2dX63LxTUAKTukJSn+DHpWy4T0bgVtbUsW3hVI/CBfAmOMfjguhQ28ZoWoBtfGrTeM26MbmYFswpCetW8e3lbbIUP01cSHMbFZHhg+jj3yZ4sCMIaForIK+Irbghw7g8BylbWwQUyiLiMAOX9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789888371; c=relaxed/simple;
	bh=/auR9gCHvoV1ZZy41WfsTy51Ovl7b7KYbkYc8K8mWGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5lz8zMg4fsk2XPEVKkWj9BXZiqtDfa/7rewuUK09eUIahF7z2rIGb2Ma4DOBP9Q8/969yzaI4prxKgt7WvG/1cbAMfo55h3tLb2aMjZs/0cCsJHfSp/7+axxZk3gmZnb7F4VUoA/3TcezhoLi4AwCk1G8UTVL8s4vhOAVITPz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uwP6yZkT; arc=none smtp.client-ip=91.218.175.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uwP6yZkT"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/auR9gCHvoV1ZZy41WfsTy51Ovl7b7KYbkYc8K8mWGA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789888368; v=1; x=1790493168;
 b=uwP6yZkTkDQeTvvmU39ag8J43t72VbjNcercY6upGsbubp+tDYXSuneg82+jx2ADtmmHyA7M
 YJNUB6GfThOjoANZ1QJOOY8vsM4gTrG5ACgzsi1kpqke2Rb3CznecjzlBA35rQLVk+lB5ORJb+I
 iW/wk5cNkc7jPARHR8uE6sKU=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 9f2d3912fda08430;
	Sun, 20 Sep 2026 07:12:48 +0000
X-Mizu-Trace-ID: 9f2d3912fda08430
X-Migadu-Flow: FLOW_OUT
Date: Sun, 20 Sep 2026 15:12:36 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Hui Peng <benquike@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
	willemb@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fou: reject FOU_ENCAP_DIRECT with protocol 0 to prevent
 sk_buff leak
Message-ID: <aq-HZFIueACIiKgU@fedora>
References: <20260919215238.3471141-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919215238.3471141-1-benquike@gmail.com>

On Sat, Sep 19, 2026 at 09:52:38PM +0000, Hui Peng wrote:
> In fou_udp_recv(), returning -fou->protocol to udp_queue_rcv_one_skb()
> triggers IP protocol resubmission when fou->protocol > 0, whereas returning
> 0 tells the UDP tunnel layer that the skb was consumed without freeing it.
> When a FOU_ENCAP_DIRECT socket is configured with FOU_ATTR_IPPROTO == 0,
> every received packet returns 0 from fou_udp_recv() and leaks the sk_buff.
> 
> Reject FOU_ENCAP_DIRECT configurations with protocol 0 in parse_nl_config()
> and drop packets if !fou->protocol in fou_udp_recv().
> 
> Fixes: 08d323234d10 ("net: fou: rename the source for linking")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
> index 5e867f1b5c1d..3fc087c808bc 100644
> --- a/net/ipv4/fou_core.c
> +++ b/net/ipv4/fou_core.c
> @@ -77,6 +77,9 @@ static int fou_udp_recv(struct sock *sk, struct sk_buff *skb)
>  	if (!fou)
>  		return 1;
>  
> +	if (unlikely(!fou->protocol))
> +		goto drop;
> +
>  	if (fou_recv_pull(skb, fou, sizeof(struct udphdr)))
>  		goto drop;
>  
> @@ -696,6 +699,9 @@ static int parse_nl_config(struct genl_info *info,
>  	if (info->attrs[FOU_ATTR_TYPE])
>  		cfg->type = nla_get_u8(info->attrs[FOU_ATTR_TYPE]);
>  
> +	if (cfg->type == FOU_ENCAP_DIRECT && !cfg->protocol)
> +		return -EINVAL;
> +
>  	if (info->attrs[FOU_ATTR_REMCSUM_NOPARTIAL])
>  		cfg->flags |= FOU_F_REMCSUM_NOPARTIAL;
>  

The patch looks good to me. But the fixes tag is incorrect. Looks the LLM
only find the tag based on the file name.

Thanks
Hangbin
