Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794553869;
	b=wx21qJwIWKCuqWiHmLaQfAG8PxFBTc/Eqat6KyGItSxRneFTiq/pus2mYT7QYJWbZu0A
	 F+iYijB5NJPz290ffcBYKxJf8OQCa70T93H9A2QPPFECtTBCfnlcS0TmxW1LuANAHLMaX
	 qbsS/T/+2Ieqdu/dkPX9PikObCOiAPcHGW5KpEyeTGmzFq/Jd/cWKZsRvpApsYKSWfI42
	 WrKb2h1Vq5TgXNvz9IZ1+d+Lm3sufRpePAqBJN4l+fu4WvP0Txn5R1AKG2RX7sqkqMTlY
	 7Ezgs7m+Rlb8K9ADCjhMWtxukMGXNlKQpYr//wCFg2jBrFYVKJKiFer232t0iqDWKDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553869;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IJWs4zNE+gIaPoa05xg+qHkXlF1ISQhiWNboOXFLzhc=;
	b=LiBxnLWdl5X+V5223xWSBBIxkYys2kWOfWzqLez1FJrlXWvNOH5edy6UpOQz9zHOTlSo
	 vd4ZSGFcgqOKC5/QeotQefysp1oZW/lELkX9ytqXWVkP0ryyZoqk1wWyIva2t+XS09wAD
	 0OYoqO3dSDy/2pAhLrLsc5eHs8neHTJE+C4hhyhCzSo64G4aYsMx6ym6ARuBMs+swDenF
	 rGHRIF7OyWO3Gytj1yrnr8kzkca2dQoRDrkGzZ3jDvhrPOi4E/YWAqOGfyMRMu1jiAlDv
	 kUc8WuMTAPEsiiSkZGvV4k1cK/DDE8uuHN+v7sZYbusYXlu4BxxINgU75V39dMex7Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CgLSTeyw;
	arc=none smtp.remote-ip=95.215.58.92
Received: from mta1.migadu.com (out-92.mta1.migadu.com [95.215.58.92])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D88D606A323
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 07:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D88D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CgLSTeyw
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HvD4JIhX9JMIJD9FDvhvLpV8go5wxlXlCHjEMqjep6A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794553866; v=1; x=1795158666;
 b=CgLSTeywh5Ab76k4izWLBgQt+Afg18seRiEqC7lbW2t9NqgZjXIGu+u9pAKnIXWzjcG1HMuX
 a5r0n/1ea6raM92cULa4ySd18U+ls4Oc4NBOux2yYlHjrH8FE4a/hyI5BPd0T4hSBlGeAWgTHEZ
 DrejQYbHdD5j9uoXOO0gTuaU=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 04b16ff434ed104c;
	Fri, 13 Nov 2026 07:11:06 +0000
X-Mizu-Trace-ID: 04b16ff434ed104c
X-Migadu-Flow: FLOW_OUT
Date: Fri, 13 Nov 2026 15:10:54 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	1342116488@qq.com
Subject: Re: [PATCH net v2] team: validate the length of U32 and S32 option
 data
Message-ID: <ava3_g_zsVdAjn93@fedora>
References: <20261112090030.172342-1-sunwenbo@cmss.chinamobile.com>
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
In-Reply-To: <20261112090030.172342-1-sunwenbo@cmss.chinamobile.com>

On Thu, Nov 12, 2026 at 05:00:30PM +0800, Wenbo Sun wrote:
> In team_nl_options_set_doit(), the policy for TEAM_ATTR_OPTION_DATA in
> team_attr_option_nl_policy is NLA_BINARY because the payload layout
> varies with the option type.
> 
> For TEAM_OPTION_TYPE_U32 and TEAM_OPTION_TYPE_S32, the payload is
> read directly with nla_get_u32(attr_data) and nla_get_s32(attr_data)
> without checking its attribute length. When userspace supplies a
> truncated attribute (0 to 3 bytes), nla_get_u32() or nla_get_s32()
> performs an out-of-bounds read past the attribute buffer. Conversely,
> oversized payloads (> 4 bytes) would also have trailing bytes
> silently ignored instead of being rejected as invalid input.
> 
> Validate that nla_len(attr_data) equals sizeof(u32) or sizeof(s32)
> for TEAM_OPTION_TYPE_U32 and TEAM_OPTION_TYPE_S32 respectively, and
> return -EINVAL otherwise, consistent with how NLA_U32/NLA_S32
> attributes are validated and similar to commit 5bef3ac184b5 ("team:
> better TEAM_OPTION_TYPE_STRING validation").
> 
> This issue was identified with the assistance of an LLM-based code
> review of Netlink option handlers in the team driver, confirmed by
> sending malformed U32 (notify_peers_count) and S32 (priority) option
> attributes on a UML kernel, and verified after the patch that
> invalid lengths (0..3, 5, and 8 bytes) are rejected with -EINVAL while
> valid 4-byte options still work as expected.
> 
> Built with W=1 on UML, x86_64 allmodconfig, and x86_64 allyesconfig with
> zero new warnings or errors.
> 
> Fixes: 3d249d4ca7d0 ("net: introduce ethernet teaming device")
> Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
> ---
> 
> Changes in v2:
> - Check exact length (!= sizeof(u32) / != sizeof(s32)) instead of
>   only rejecting truncated payloads (<), as suggested by Hangbin Liu.
> - Extended the UML test to also cover oversized option payloads.
> 
>  drivers/net/team/team_core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index 957cc7885d2f..8fa05c489b99 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -2833,6 +2833,10 @@ int team_nl_options_set_doit(struct sk_buff *skb, struct genl_info *info)
>  			ctx.info = opt_inst_info;
>  			switch (opt_type) {
>  			case TEAM_OPTION_TYPE_U32:
> +				if (nla_len(attr_data) != sizeof(u32)) {
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
> +				if (nla_len(attr_data) != sizeof(s32)) {
> +					err = -EINVAL;
> +					goto team_put;
> +				}

This part should be

Fixes: 69821638b274 ("team: add signed 32-bit team option type")

Thanks
Hangbin
