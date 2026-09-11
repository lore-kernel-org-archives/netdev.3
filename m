Received: from mta0.migadu.com (out-233.mta0.migadu.com [91.218.175.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09E13E1D0B
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120967; cv=none; b=JQsMbHb0Z30BLbycb9HfJHrsIv5XfNpuhxU0aCswVpaRWCFSDN6UW7u+fh55Z7mxCLswEa+/TTi+Y0V942l5abtyiHadaUv2Z9hkDLePWblpSi8bBi2ih6xWnIhT7cIkh+hRX9HYCBOk4SZNAW8eoBTJevC2cNa1EHvvGIwujzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120967; c=relaxed/simple;
	bh=e/ufJvr7I2vQpQhXkidxxbRvwwaYEN1CaglWEdsLWI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIsl83/swqqvqGHTHieVBLcDcFxApvhpgMb65CxMpVf7JeDfC0zzAmRcDx43nft0aMDZIjK7zO8hrHGzy8bRNiDriIcfnPDX1v5UUP8bspHMg0Otum+zqn8VCWqFldjJbub723AxPOyZ6qZzZWnhEYe15s4ZR0h0+h5VAGbtsJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PpQ9U0Co; arc=none smtp.client-ip=91.218.175.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PpQ9U0Co"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=e/ufJvr7I2vQpQhXkidxxbRvwwaYEN1CaglWEdsLWI4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789120963; v=1; x=1789725763;
 b=PpQ9U0CoQigAEJH31FDw7RaIRmqOrLGvmEQwOLk429v96DEcd3xKEuHFe1hQEA1FMfCLLH5N
 DfvpgtGN9cJCF348Oa3gB5x0hI3z5Xk/ej2G0gmrPGRHA/4aWyeL2p1WXpU6/bBO/kxDy6Hwmpq
 csMkOcpbEqMP+aowgww38tWo=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 5cb2031d932c4968;
	Fri, 11 Sep 2026 10:02:43 +0000
X-Mizu-Trace-ID: 5cb2031d932c4968
X-Migadu-Flow: FLOW_OUT
Date: Fri, 11 Sep 2026 18:02:33 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net 4/4] drop_monitor: fix out-of-bounds write in
 reset_per_cpu_data()
Message-ID: <aqPRufC2SefOtiB4@fedora>
References: <20260910204612.3762015-1-edumazet@google.com>
 <20260910204612.3762015-5-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910204612.3762015-5-edumazet@google.com>

On Thu, Sep 10, 2026 at 08:46:12PM +0000, Eric Dumazet wrote:
> In reset_per_cpu_data(), al is computed as:
> 
>     al = sizeof(struct net_dm_alert_msg);
>     al += dm_hit_limit * sizeof(struct net_dm_drop_point);
>     al += sizeof(struct nlattr);
> 
>     skb = genlmsg_new(al, GFP_KERNEL);
>     ...
>     nla = nla_reserve(skb, NLA_UNSPEC, sizeof(struct net_dm_alert_msg));
>     ...
>     msg = nla_data(nla);
>     memset(msg, 0, al);
> 
> Because al includes sizeof(struct nlattr) (the 4-byte attribute header),
> genlmsg_new() allocates al bytes of tailroom starting at nla.
> However, msg points to nla_data(nla), which is located
> sizeof(struct nlattr) bytes past nla. Calling memset(msg, 0, al)
> therefore writes al bytes starting from msg, exceeding the allocated
> buffer by sizeof(struct nlattr) (4 bytes) and corrupting
> skb_shared_info.
> 
> Fix this by letting al represent only the payload length, allocating
> the skb with genlmsg_new(nla_total_size(al), GFP_KERNEL), and zeroing
> al bytes from msg.
> 
> Fixes: 683703a26e46 ("drop_monitor: Update netlink protocol to include netlink attribute header in alert message")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/core/drop_monitor.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
> index 795c15dd1771a2a5f15e109d0ef2eed967c45443..edc660778408e1bb996124be5a5349dfc9be3568 100644
> --- a/net/core/drop_monitor.c
> +++ b/net/core/drop_monitor.c
> @@ -141,9 +141,8 @@ static struct sk_buff *reset_per_cpu_data(struct per_cpu_dm_data *data)
>  
>  	al = sizeof(struct net_dm_alert_msg);
>  	al += dm_hit_limit * sizeof(struct net_dm_drop_point);
> -	al += sizeof(struct nlattr);
>  
> -	skb = genlmsg_new(al, GFP_KERNEL);
> +	skb = genlmsg_new(nla_total_size(al), GFP_KERNEL);
>  
>  	if (!skb)
>  		goto err;
> -- 
> 2.55.0.1007.g17ff1f9808-goog
> 

Yes, nla_total_size is safer.

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
