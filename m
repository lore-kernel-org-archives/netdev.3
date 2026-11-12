Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446544;
	b=m6BcJKnFSbLuxCo/ps4AcesYyLLwiW9hRm1WJjBpmlm7T5cOKc8rstJZnW1zLIgXcwHk
	 oS5sDbG0TbC8bkKE3Int/uxchomsQeohy7sLhuXVC1Z65swv3ghAwDNRtmUMtaTSa4p6M
	 ZS73377gWAZWOSl/5HKdqR9MwXqjpn8A0GtczjUM6yABxZAlhwqXl6PNnk9vQ5bO3tX6g
	 kruGd8WARMFNZa1FRmQk5JD8jSq7Smc5eNVcnMdMvpHOuh/QNRpKe2fP4EWg8qEd/9obG
	 AfBskGDjAEPCAnnGXPUOX7qtyHCxBDmSdcRL0BgfRQ4qnx7NBroEXBwOWmB+HU+NjTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446544;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=B/CW36KEeS3ufYaGy3DdV/wzimhKCmAA0IMRiSWriQg=;
	b=mQluvPG5LEoF60pFSa2MXSXX+ow8h0ltsMcUmo8zKHDJoBZcx81s9LNqVysRiTU+L6Ax
	 el1O8M+rSMuOtPurWUBCtnRhB73tQHK0WbUXxhGqlOJsuv6+BK11hE1RvrRyA84aDXbaj
	 iV1mjNSr9tLyIos3/7m+P7XVzUk/JZ6ArsIvsQJblhqlg+PyDv9SkU/5l6p1OWCODF333
	 f49Zwj66w35ShEZETCZo2VYsl2pZv4xgKBn0EskaD6n4/6ggYSbNqXybx1CxZ7VmDeL7z
	 Tv7mTvQS5ewXnSyjYKWoW6mwg7SBLpJqZsorvbhndJBpt911q9SVi0szXEHVfFMZ/Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XbnP+x2M;
	arc=none smtp.remote-ip=91.218.175.158
Received: from mta0.migadu.com (out-158.mta0.migadu.com [91.218.175.158])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2906C606A324
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 01:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2906C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XbnP+x2M
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=w2G8knjyk/9VoInzbPgqvCjcKAfz1Xlhb7AVxmgYgcc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794446541; v=1; x=1795051341;
 b=XbnP+x2M27vY/iVBBwC00Iitdz8PE1etrJ5FfQk2jXLwZVAc/rZ0qAvSGYeZkotim5J5JoYu
 VFUD1Ib9BA7hDFlEiSY7p4bi6W7a7fwe2/riFaHJ5+VEEctPX/SSu8XUjiM+suEQzj1h3FG75xE
 8CT8cm6uW6LokgoEYpeuS35E=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 9d76ee2f2cf328f5;
	Thu, 12 Nov 2026 01:22:21 +0000
X-Mizu-Trace-ID: 9d76ee2f2cf328f5
X-Migadu-Flow: FLOW_OUT
Date: Thu, 12 Nov 2026 09:22:11 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	1342116488@qq.com
Subject: Re: [PATCH net] team: validate the length of U32 and S32 option data
Message-ID: <avUUw4deZxrmGJO1@fedora>
References: <20261111085924.360720-1-sunwenbo@cmss.chinamobile.com>
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
Content-Disposition: inline
In-Reply-To: <20261111085924.360720-1-sunwenbo@cmss.chinamobile.com>

Hi Wenbo,
On Wed, Nov 11, 2026 at 04:59:24PM +0800, Wenbo Sun wrote:
> In team_nl_options_set_doit(), TEAM_ATTR_OPTION_DATA attribute policy is
> NLA_BINARY in team_attr_option_nl_policy because the option data format
> depends on the option type.
> 
> When setting an option of type TEAM_OPTION_TYPE_U32 or
> TEAM_OPTION_TYPE_S32, ctx.data.u32_val or ctx.data.s32_val is retrieved via
> nla_get_u32(attr_data) or nla_get_s32(attr_data) without validating that
> the attribute payload is at least sizeof(u32) or sizeof(s32). If userspace
> supplies truncated option data (e.g. 0 to 3 bytes), nla_get_u32() or
> nla_get_s32() will perform an out-of-bounds read past the attribute data
> buffer.
> 
> This issue was identified during a code audit of Netlink option handlers
> in the team driver. The bug was confirmed and reproduced on a UML kernel:
> passing truncated option data for notify_peers_count (U32) or priority
> (S32) succeeded on an unpatched kernel instead of failing validation.
> 
> Add explicit length checks for TEAM_OPTION_TYPE_U32 and
> TEAM_OPTION_TYPE_S32 in team_nl_options_set_doit() to reject truncated
> attributes with -EINVAL, similar to commit 5bef3ac184b5 ("team: better
> TEAM_OPTION_TYPE_STRING validation").
> 
> Tested:
> - In UML, verified that sending truncated U32 and S32 option data (0 to 3
>   bytes) is rejected with -EINVAL on a patched kernel, while valid U32 and
>   S32 option settings succeed.
> - Built with W=1 on UML, x86_64 allmodconfig, and x86_64 allyesconfig with
>   zero new warnings or errors.
> 
> Fixes: 3d249d4ca7d0 ("net: introduce ethernet teaming device")
> Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
> ---
>  drivers/net/team/team_core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index 957cc7885d2f..617f13e1620c 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -2833,6 +2833,10 @@ int team_nl_options_set_doit(struct sk_buff *skb, struct genl_info *info)
>  			ctx.info = opt_inst_info;
>  			switch (opt_type) {
>  			case TEAM_OPTION_TYPE_U32:
> +				if (nla_len(attr_data) < sizeof(u32)) {
> +					err = -EINVAL;
> +					goto team_put;
> +				}
>  				ctx.data.u32_val = nla_get_u32(attr_data);
>  				break;
>  			case TEAM_OPTION_TYPE_STRING:
> @@ -2852,6 +2856,10 @@ int team_nl_options_set_doit(struct sk_buff *skb, struct genl_info *info)
>  				ctx.data.bool_val = attr_data ? true : false;
>  				break;
>  			case TEAM_OPTION_TYPE_S32:
> +				if (nla_len(attr_data) < sizeof(s32)) {
> +					err = -EINVAL;
> +					goto team_put;
> +				}
>  				ctx.data.s32_val = nla_get_s32(attr_data);
>  				break;
>  			default:

What if the data size larger than s32/u32? Should we check it with

  if (nla_len(attr_data) != sizeof(s32))

?

Thanks
Hangbin
