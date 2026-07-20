Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478B378F2E
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 02:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784515961; cv=none; b=Z/GKvvbK9umimIlmQDmI4WuK8FV1nAGcxJtiiHWKGMVtJsvsRV+fgwXIr4yUeK+hRduOf1xwyZjFqRVkoKOPC16cXH6ugCPQOSiDwJEbigAlFkt98NP3q+CT5NZzihCTypynNR1VeznJ11dNCdDlIFCtZxVPSGyf0O2T34PUe9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784515961; c=relaxed/simple;
	bh=LXpaBCpsppv6x9DpmAW+yDFRuOD2Xeee81qlkCzqg7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBWbrNzosiliVXr6FIc+y3qJRRCk4E6rxudi0p7NRZwVllaf5ssWUkXQ7dCR9xcgU2pxtEXxDZZfoHprvm070GVOgQOQlt5MlKA+gfAVFd0r0dznEDARSI1kzEJTyNNhLDsiRd2onTccZQSwsTRX8mbP1YT+2fdzPKr5Nt2HVmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=u0dqy5Re; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="u0dqy5Re"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eHEcpnlBK+/9Bw4zif1GGToEY3GMVPHDoyvFJZsXXNQ=; b=u0dqy5ReRUKBBWLuaMQ/VQ9oz5
	dc8UeqweUAFBkDO7eisaqeNMJDOQcaoTg22sPHi5X424l90yhuXGYtwQkzFjrNVmMt3ScAghwxEsa
	+QeAKUmODdR+jYRk3T3BA2Nbe+wF5SU3Wi+bcmQAzZkpFksORDc6gp6xluDeEsIw67pg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wle7L-00DC1y-RP; Mon, 20 Jul 2026 04:52:31 +0200
Date: Mon, 20 Jul 2026 04:52:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ren Wei <enjou1224z@gmail.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, aconole@redhat.com,
	echaudro@redhat.com, i.maximets@ovn.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	pshelar@ovn.org, yihung.wei@gmail.com, vega@nebusec.ai,
	tonanli66@gmail.com, xuyuqiabc@gmail.com
Subject: Re: [PATCH net 1/1] openvswitch: Fix CT limit teardown use-after-free
Message-ID: <c357f846-d42c-4b98-acc9-46b751818dca@lunn.ch>
References: <cover.1784355642.git.xuyuqiabc@gmail.com>
 <aa8a1d8dcbac8a13dbdf077a642a66f4c5d81e4b.1784355642.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa8a1d8dcbac8a13dbdf077a642a66f4c5d81e4b.1784355642.git.xuyuqiabc@gmail.com>

On Mon, Jul 20, 2026 at 10:14:16AM +0800, Ren Wei wrote:
> From: Yuqi Xu <xuyuqiabc@gmail.com>
> 
> Packet processing uses CT limit state under RCU, while netns teardown
> frees that state under ovs_mutex. The CT limit pointer was neither removed
> from readers nor protected by a grace period, allowing packet processing to
> dereference the freed state.
> 
> Replace the pointer before freeing the CT limit state. Wait for in-flight
> RCU readers before freeing its contents. Serialize CT limit netlink
> operations with teardown for the full lifetime of their state accesses.
> 
> Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>

Is Vega a person?

> Assisted-by: Codex:GPT-5.4
> Co-developed-by: Nan Li <tonanli66@gmail.com>
> Signed-off-by: Nan Li <tonanli66@gmail.com>
> Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
> Reviewed-by: Ren Wei <enjou1224z@gmail.com>

Please take a look at
https://docs.kernel.org/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
and the sections that follow. What is listed here does not follow the
rules.

> @@ -932,11 +932,15 @@ static int ovs_ct_check_limit(struct net *net,
>  			      const struct sk_buff *skb,
>  			      const struct ovs_conntrack_info *info)
>  {
> +	const struct ovs_ct_limit_info *ct_limit_info;
>  	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
> -	const struct ovs_ct_limit_info *ct_limit_info = ovs_net->ct_limit_info;
>  	u32 per_zone_limit, connections;
>  	u32 conncount_key;

Reverse Christmas tree. The lines should be sorted longest to
shortest. Yes, it was already wrong, but you can actually fix it here.

    Andrew

---
pw-bot: cr
