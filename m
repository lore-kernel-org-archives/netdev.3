Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F343D23EA84;
	Tue, 21 Jul 2026 14:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784645575; cv=none; b=DiCqnteTKvSY9g90nWdGIyJJPLYvvW4N3p8Uq+VLMnVaTqcwiXXGQfMRLnujgkkqPnwIoUxCReJEx8RxjLkvM/ygiJ2kHnpaBU8OyrCxnta0j6ethg/W/piIUtmEE1+vltczqaAupOrFc2WYGph3h/QXnT1FHADLFlYAtBMazp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784645575; c=relaxed/simple;
	bh=y65zkbX9n2/R3VELPUIWF/uEp9OUpapvWkMrehxDlbg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fwSssJaAAoyWOrQJgDL+6etB9Z+1NTOU49GETlZPt8Ge4xbZVEdflfOLheHWjyUkB5BQYJHEnh5NzkM5Me/ZKn6mkoNcG26MRnsg6Sh72+V/Sa4EoEEvBu4FWiou7u0ZhkouEgdY1G4nB6hSqrC3uQHo5O/E8/3j/iJECTG21i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SB1IDIat; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SB1IDIat"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B051F000E9;
	Tue, 21 Jul 2026 14:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784645573;
	bh=28KRg4ShLYaeTidvzTHjOoSACQZCwvPVAZjtKcdTDJI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SB1IDIat5CBY3117mhMMrGy91L8Qpbcyd6PzTOZ3azcVQhza68uR+Y8epxjCyzBNb
	 s+Ggh2mHlaiqH/C9NxMviO1TWHvZynMBgtGwsyEu3EOYACheETgt8K3X+34MOTqChB
	 zwZ+qaa8HDnl6RJpDe+9q5GuBrsqxFsMuMLJxluqUiqjrXt5PfnvUmMnHnqPbel4vR
	 VMnhnVrPS8HlOITu0riLRtbm/yJWZrGYaK7z+b+QpVfDPnxBPu1KeQqCVhz+NdC1gC
	 6R5UXO9PikR9ttcA4p7EVTLAnqjTyRD0YAhX1hQFW0maUHXmIFxCz3p/0FR18fVkF/
	 Rkpj/2cRldKAw==
Date: Tue, 21 Jul 2026 07:52:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kiran Kella <kiran.kella@broadcom.com>
Cc: daniel.zahka@gmail.com, willemdebruijn.kernel@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, weibunny@fb.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jayakrishnan.udayavarma@broadcom.com,
 ajit.khaparde@broadcom.com, akhilesh.samineni@broadcom.com, Vikas Gupta
 <vikas.gupta@broadcom.com>, Bhargava Marreddy
 <bhargava.marreddy@broadcom.com>, Daniel Zahka <daniel.zahka@broadcom.com>
Subject: Re: [PATCH net v2] psp: fix NULL genl_sock deref race with
 concurrent netns teardown
Message-ID: <20260721075252.1d577783@kernel.org>
In-Reply-To: <20260707185937.3177211-1-kiran.kella@broadcom.com>
References: <20260707185937.3177211-1-kiran.kella@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Jul 2026 11:59:37 -0700 Kiran Kella wrote:
> The race occurs between network namespace removal and PSP device
> unregistration.  When a netns is deleted while a PSP device associated
> with that netns is concurrently being removed, psp_dev_unregister()
> triggers psp_nl_notify_dev() to send a device change notification.
> Concurrently, cleanup_net() running in the netns workqueue calls
> genl_pernet_exit(), which sets net->genl_sock to NULL. If
> genl_pernet_exit() wins the race, two sites in psp_nl_multicast_per_ns()
> then dereference the NULL socket and crash:
> 
> CPU 0 (netns teardown)       CPU 1 (PSP device unregister)
> ======================       =============================
> cleanup_net [workqueue]
>   genl_pernet_exit()         psp_dev_unregister()
>     net->genl_sock = NULL      psp_nl_notify_dev()
>                                  psp_nl_multicast_per_ns()
>                                    build_ntf()
>                                      -> netlink_has_listeners(NULL)  
>                                      /* crash */
>                                    genlmsg_multicast_netns()
>                                      -> nlmsg_multicast_filtered(NULL)  
>                                      /* crash */

Can you explain how you hit this, in reality? Seems like an extreme
corner case to me.

> Both the main_net path (derived from psd->main_netdev) and each
> assoc_net entry in psd->assoc_dev_list are affected.

I don't see how assoc_dev_list is affected. Assoc dev list has 
a notifier which should serialize the netdev unreg on psd->lock. 
And netdev unreg must happen before the netns dismantle.

> Fix by replacing the bare dev_net() calls with maybe_get_net().
> maybe_get_net() returns NULL if the namespace is already dying.
> Holding the reference ensures genl_sock remains valid across both the
> build_ntf() and genlmsg_multicast_netns() calls.
> 
> Fixes: 00c94ca2b99e ("psp: base PSP device support")
> Fixes: 06c2dce2d0f6 ("psp: add new netlink cmd for dev-assoc and dev-disassoc")
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Reviewed-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
> Reviewed-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
> Reviewed-by: Daniel Zahka <daniel.zahka@broadcom.com>
> Tested-by: Daniel Zahka <daniel.zahka@broadcom.com>
> Signed-off-by: Kiran Kella <kiran.kella@broadcom.com>
> ---
> v2:
>  - get rid of the extra struct net *net, by doing
> (!maybe_get_net(assoc_net)) directly (as suggested by Daniel Zahka)
> 
> v1: https://lore.kernel.org/all/20260703112431.2860506-1-kiran.kella@broadcom.com/
> 
>  net/psp/psp_nl.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
> index 9610d8c456ff..1438dbb07949 100644
> --- a/net/psp/psp_nl.c
> +++ b/net/psp/psp_nl.c
> @@ -62,7 +62,10 @@ psp_nl_multicast_per_ns(struct psp_dev *psd, unsigned int group,
>  	struct net *main_net;
>  	struct sk_buff *ntf;
>  
> -	main_net = dev_net(psd->main_netdev);

comment like:

	/* device may be changing netns in parallel */

> +	main_net = maybe_get_net(dev_net(psd->main_netdev));

not sure how the dev_net() is safe here if we're not holding any
relevant lock. Do we need rcu?

> +	if (!main_net)
> +		return;
> +
>  	xa_init(&sent_nets);
>  
>  	list_for_each_entry(entry, &psd->assoc_dev_list, dev_list) {
> @@ -77,21 +80,23 @@ psp_nl_multicast_per_ns(struct psp_dev *psd, unsigned int group,
>  		if (ret == -EBUSY)
>  			continue;
>  
> -		ntf = build_ntf(psd, assoc_net, ctx);
> -		if (!ntf)
> +		if (!maybe_get_net(assoc_net))
>  			continue;

AFAICT we clear the psd on netns move for assoc dev so I don't think
this is needed today.

> -		genlmsg_multicast_netns(&psp_nl_family, assoc_net, ntf, 0,
> -					group, GFP_KERNEL);
> +		ntf = build_ntf(psd, assoc_net, ctx);
> +		if (ntf)
> +			genlmsg_multicast_netns(&psp_nl_family, assoc_net, ntf,
> +						0, group, GFP_KERNEL);
> +		put_net(assoc_net);
>  	}
>  	xa_destroy(&sent_nets);
>  
>  	/* Send to main device netns */
>  	ntf = build_ntf(psd, main_net, ctx);
> -	if (!ntf)
> -		return;
> -	genlmsg_multicast_netns(&psp_nl_family, main_net, ntf, 0, group,
> -				GFP_KERNEL);
> +	if (ntf)
> +		genlmsg_multicast_netns(&psp_nl_family, main_net, ntf, 0, group,
> +					GFP_KERNEL);
> +	put_net(main_net);
>  }
>  
>  static struct sk_buff *psp_nl_clone_ntf(struct psp_dev *psd, struct net *net,

