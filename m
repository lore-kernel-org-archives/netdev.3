Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCA3355F39
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 06:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775629733; cv=none; b=R8ul4ccJdMJ9Gx1nk0ku+bGAhDFwvgqdEp+DbwB+QHRebnI1BlOmI2Y0v6Mch4u8nMTx1Q8tF7o3gv/NxQv0BiyjaZ6BNJYrEXeXkoXdMWkn0+oCgTbjpBqggDJaRF6bWPHnnElNUH1OyV/P9jwMyBfR0kxbrBiWzq3DV0g9Nh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775629733; c=relaxed/simple;
	bh=t8FAJtCeUfAC/CTlET9xn0DuAuKTJkSWMfexIMhBFQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1NV3deCfm3sg4FldBd+OVcsFfHPwJbcUClijAsRuBjmobtYW3vfQNxBN8S2n+h0mFQ9dtZmo8qr3NtnnQs4+B75+N2IzCI+iGxom408mu7SGoINGeDr3acdKC8XACybmIJgP7HN/sYdL+MVR4JdzqrzBjryfSLVQLjPVQ1TR04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G3imsfTf; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G3imsfTf"
Message-ID: <59d11588-0af2-42e6-a030-83240a0a5512@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775629729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8aFfmifB7q1gLRzmTxqymM8xXpXF6N+3LNyHdfnhsGY=;
	b=G3imsfTfc2RoHKnrxcrD/4JUi/AvuuRDkysT/qlds5JqPUUC6rcrV7YiDijKu9iABK9xbm
	xRZ7rL+tkf+g6ueubF8r7+Bz4nfpTYFk12IHLHeBcQYye/F3D8Wm5DAKLJNJcppHezqTeb
	OFHMQSgZ/SWpSWUeXFkrbK6gkBCYvj0=
Date: Wed, 8 Apr 2026 14:28:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ppp: require CAP_NET_ADMIN in target netns for unattached
 ioctls
To: Taegu Ha <hataegu0826@gmail.com>, netdev@vger.kernel.org
Cc: linux-ppp@vger.kernel.org, gnault@redhat.com, jaco@uls.co.za,
 richardbgobert@gmail.com, ericwouds@gmail.com,
 Cyrill Gorcunov <gorcunov@gmail.com>, Matteo Croce <teknoraver@meta.com>
References: <20260408042345.1011-1-hataegu0826@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <20260408042345.1011-1-hataegu0826@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

Added Cc: Cyrill, and Matteo

On 2026/4/8 12:23, Taegu Ha wrote:
> /dev/ppp open is currently authorized against file->f_cred->user_ns,
> while unattached administrative ioctls operate on current->nsproxy->net_ns.
>
> As a result, a local unprivileged user can create a new user namespace
> with CLONE_NEWUSER, gain CAP_NET_ADMIN only in that new user namespace,
> and still issue PPPIOCNEWUNIT, PPPIOCATTACH, or PPPIOCATTCHAN against
> an inherited network namespace.
>
> Require CAP_NET_ADMIN in the user namespace that owns the target network
> namespace before handling these unattached PPP administrative ioctls.
>
> This preserves normal pppd operation in the network namespace it is
> actually privileged in, while rejecting the userns-only inherited-netns
> case.
>
> Fixes: 273ec51dd7ce ("net: ppp_generic - introduce net-namespace functionality v2")

For fixes, you should set the target tree to "net" in the patch subject, 
using:

git format-patch --subject-prefix="PATCH net"


> Reported-by: Taegu Ha <hataegu0826@gmail.com>

Minor nit: Reported-by tag is not needed if it's the same user as Signed-off-by.

> Signed-off-by: Taegu Ha <hataegu0826@gmail.com>
> ---
>   drivers/net/ppp/ppp_generic.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
> index e9b41777be80..99a8557188c0 100644
> --- a/drivers/net/ppp/ppp_generic.c
> +++ b/drivers/net/ppp/ppp_generic.c
> @@ -1059,6 +1059,9 @@ static int ppp_unattached_ioctl(struct net *net, struct ppp_file *pf,
>   
>   	switch (cmd) {
>   	case PPPIOCNEWUNIT:
> +		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
> +			return -EPERM;
> +


These three identical checks can be combined into one and placed before 
the switch statement.


>   		/* Create a new ppp unit */
>   		if (get_user(unit, p))
>   			break;
> @@ -1073,6 +1076,9 @@ static int ppp_unattached_ioctl(struct net *net, struct ppp_file *pf,
>   		break;
>   
>   	case PPPIOCATTACH:
> +		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
> +			return -EPERM;
> +
>   		/* Attach to an existing ppp unit */
>   		if (get_user(unit, p))
>   			break;
> @@ -1089,6 +1095,9 @@ static int ppp_unattached_ioctl(struct net *net, struct ppp_file *pf,
>   		break;
>   
>   	case PPPIOCATTCHAN:
> +		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
> +			return -EPERM;
> +
>   		if (get_user(unit, p))
>   			break;
>   		err = -ENXIO;
