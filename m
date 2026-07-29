Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107EA40DB5E;
	Wed, 29 Jul 2026 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785320625; cv=none; b=AQ///5iGC2l250YsokQOm7j/M0Bzt3PcYVRohBFfnKqcK3w4eUrqLwe3sdhIz6ZmMeCSb3FHYTICZhKeIAyzgTieEGAnJ0g/Gu810tvNoOeh6BOSf8zzMTxqfR2jyhiY7pjXVy2NsTzUU2/GVEgvORoDQ7Kq/JQqOgw34tHXNiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785320625; c=relaxed/simple;
	bh=kfhuk77B0e9r5D2spgZKrCMAL6v1/GH3Ig45qmhEP5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mv/+1q6cv7ymC36ewKXHGkMkVfoCPN3UbuM4oe2k/++0ekL07CYVTtVDIq7+hB/xHciO++/+NDGfpb10/MY/FwJopczLDzTkq6ASdteUXgk9Xyb5bLv8rujPDevE5Vl50+uK8ODJjrWAYwF/Jow9iM3gvQM8gRZW67A15ORzTOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccXMZbc7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccXMZbc7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DBC1F000E9;
	Wed, 29 Jul 2026 10:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785320623;
	bh=TD+Lux/rBcKsRsV04evXaZy/8eK5ceys6vLCawvVXE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ccXMZbc7C/HzjDOdPn+wxBNnX/KCvzAmBXWU5+LmesuCAO0U/Yanuhpu8kKYpWXnI
	 c8IXjvBFVJoxhj06AL1GvANdTWlxg6vzilrlP6ZTpIeUxvXM9kVLgFpjJgCSWGvECB
	 bkkI7f1umm/ePPokZSkIrEJMsL4Q1jd9+jLG256KqLIFgay4AP53pGSdlUJpATEA0k
	 PFDgyh2psLxMnIRYxP1N249+SZW9wtSBjdX/mtwGeWPAbvOA6hXOEU41ZxikTEKp16
	 xFLR8CqCggIscZEdIR3LOnWGt/LyTc1ygKbFKCxFR5evwLJPhDr44MClGC8Rrl4FYQ
	 du//opyiSDziA==
Date: Wed, 29 Jul 2026 12:23:40 +0200
From: Antoine Tenart <atenart@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Gal Pressman <gal@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, 
	linux-kernel@vger.kernel.org, Or Har-Toov <ohartoov@nvidia.com>, 
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] devlink: fix net namespace reference leak in reload
Message-ID: <amnUeT6MHSNvnM_b@kwain>
References: <20260729080600.2427721-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729080600.2427721-1-tariqt@nvidia.com>

On Wed, Jul 29, 2026 at 11:06:00AM +0300, Tariq Toukan wrote:
> From: Or Har-Toov <ohartoov@nvidia.com>
> 
> devlink_nl_reload_doit() calls devlink_netns_get(), which returns a net
> with a held reference. When the requested namespace differs from the
> current one and the reload action is not DRIVER_REINIT, the function
> returns -EOPNOTSUPP without releasing the reference. Add the missing
> put_net() on this error path.
> 
> Fixes: 2edd92570441 ("devlink: don't allow to change net namespace for FW_ACTIVATE reload action")
> Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Antoine Tenart <atenart@kernel.org>

> ---
>  net/devlink/dev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/devlink/dev.c b/net/devlink/dev.c
> index 57b2b8f03543..fd5633fa88ec 100644
> --- a/net/devlink/dev.c
> +++ b/net/devlink/dev.c
> @@ -578,6 +578,7 @@ int devlink_nl_reload_doit(struct sk_buff *skb, struct genl_info *info)
>  		    action != DEVLINK_RELOAD_ACTION_DRIVER_REINIT) {
>  			NL_SET_ERR_MSG_MOD(info->extack,
>  					   "Changing namespace is only supported for reinit action");
> +			put_net(dest_net);
>  			return -EOPNOTSUPP;
>  		}
>  	}
> 
> base-commit: 3bd438a58e910db5dc369aa25dfed1fc95f1b596
> -- 
> 2.44.0
> 
