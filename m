Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7622550D5
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787672229; cv=none; b=iAMb4ad8x1tFKWS7iBfN6wX/4w1Qnt9YGAblmnZUuCQ/oOzwvkpkUJjw2+IUakaMuucxJ3RYUdem9GVPGyBj74kBC+aV/Gj9xW9wr+yEthwPRUASVRM6w3OvmGEepCuuBfs45ROGaANKgW88GM6aVykouBGG+wqTWv8q70W5CVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787672229; c=relaxed/simple;
	bh=gl8c/52mHwdRNgCsWZoFjwRPD1HiBQV8oMT9/goj4Nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2aKl7msm2J25ELAq+KRR1ltA2rAlVj9miHomWzb7TMOyW3ppDPAHlSDFUtnNTOGGsOl6sTImMDFQQg82aReQYK01K5/n8QuTAUJ8BrYFo70mcjxvol9TpgQuKlRbDkmtKsJyI7afv/wErA9h+ps3VC4QaX3RZHnozkykETYcMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=vcSFst3y; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="vcSFst3y"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-754ac74c495so1519329137.0
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 08:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787672225; x=1788277025; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vP4UCJgmXlfaB3tgGtO/enO36tzbOdYwtbcZaFOpx4k=;
        b=vcSFst3ySnrKGF1iFh0CbES03M7LTCDa8DoYZYw0ZJGCphzsihr4s8lQ1K0MgsOeCx
         fC4Iz7uXINcqBDkUlTxUbFc8D98cxUiZ3H0Bzr7+BFGsjOmumhM0wX1b+CR9l2uRBmo8
         1MNVfKeI8sqbPgb/kdxWGI4st4A1/Cj+rCzmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787672225; x=1788277025;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vP4UCJgmXlfaB3tgGtO/enO36tzbOdYwtbcZaFOpx4k=;
        b=tZKWqNo2MvacaYX2DizDLZMhNv8SEld3bAcT+FuVtQRX9y9ElgVg38Tm0DWe3yKSIy
         LxNivnr1EmzojTquH9alCefRDZ6ePQeQ0m5E4laIiEfPp9gdCH5npSk0grQujVh7CXun
         mFbiiYBfvIezo2GP8Yj9R3TyPNhl8fvYBe0koGu/Q1SLCfs55gIZR+EjfCw2zLXqcSc/
         oBJR0sZhKFgosUD7vqlB5ItzoHodoouuZehNt78pzYVURKREGSykS+IKv0nVNsRF22aq
         Gail2uzoCtrVtyMNzkgR84fnYvK/mdKMoYomndvX8HdlgBw9baFl5n91UI7z0zVJWHo9
         EUTg==
X-Forwarded-Encrypted: i=1; AHgh+Ro98ukTe5qvZth6uqip+g7hvMHwQ2EWeWyVxcAYe9fRe171qlHHXR0TyD7hY00Wzyr1VJIWENs=@vger.kernel.org
X-Gm-Message-State: AFuF++nt8soU3GQDMflOS0L64YT4I1RFksT5VRr6iAvI18HaYz7ofm5v
	nF1qIZ/G7A9715Ytbow8Ifhu8NGYH23JQKdU7QdXKMWzsfpZuiFyYtq+AJoaFuTFzg==
X-Gm-Gg: AR+sD13UEsKFK8cZ+0GGd4H3HNJBa7kyFrtWjYEAQJy1boUzgiFXocukDlG99O6v6kT
	J7miffZIXdEnmigOmsSPvAI7qRz0RCvdqyp0D7PiBVldqU3Iz9tWsr1/Hj4WCS/Ebfdwee9/a2G
	165n6hPx60dzjWT2RLfHAtOQR1h1ggnWoUdqWBy2GU+QGVxH/nM36g5tr0R/lmuvqeB18c8ewQz
	UggGp8GZWtnLTSZHccX9oqkzySeu61JkJeOzRwnsFmsv2XgRF/xgcw3Dni+K4VqhTlf7WNGfV1O
	8u8hs645vfBC27HWM+bc9yLzJQt5szJGJ6bgPaV3nZ78Uh95kUXtBsh7XFxkON/vxswrnf2S7d7
	KDJ5vIidYS3MCAltFTRF3cq4+nt/q7zQ3Dgbl2vgwQrG3l6P+RidBLFF4xbTU9GSl5T9jB1mwHb
	xjqcKG/o7r138v1XB8NWhG2j5BSEVbK9ZgCXGU2vAruH0FsylhngEMobI16jvKBEcDrPLoZ2icx
	t9fbQ==
X-Received: by 2002:a05:6102:26c5:b0:772:5acc:b848 with SMTP id ada2fe7eead31-77a62c46273mr10701638137.6.1787672225388;
        Tue, 25 Aug 2026 08:37:05 -0700 (PDT)
Received: from [192.168.50.25] ([179.218.14.134])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-782b335f8d7sm57196137.4.2026.08.25.08.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 08:37:04 -0700 (PDT)
Message-ID: <9506fd63-b0fe-45bb-b160-e2b10ee7775b@mojatatu.com>
Date: Tue, 25 Aug 2026 12:36:59 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/4] net/sched: act_api: fix skb sizing and action
 leak on reoffload delete
To: Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 jiri@resnulli.us
Cc: horms@kernel.org, baowen.zheng@corigine.com, louis.peens@corigine.com,
 netdev@vger.kernel.org
References: <20260824153903.4143642-1-victor@mojatatu.com>
 <20260824153903.4143642-4-victor@mojatatu.com>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20260824153903.4143642-4-victor@mojatatu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/08/2026 12:39, Victor Nogueira wrote:
> tcf_reoffload_del_notify_msg() sizes the RTM_DELACTION skb with
> tcf_action_fill_size(action) alone.  Unlike every other notification path
> it never wraps that in tcf_action_full_attrs_size(), so the nlmsg_put()
> header, struct tcamsg and the TCA_ACT_TAB nest that tca_get_fill() emits -
> 24 bytes on x86_64 - are not budgeted.  As long as the single action stays
> well under NLMSG_GOODSIZE the floor in alloc_skb() hides this, but once its
> fill size crosses NLMSG_GOODSIZE the allocation is exactly 24 bytes short
> and tca_get_fill() runs out of tailroom.  That is now easy to reach for an
> offloadable act_pedit with a large tcfp_nkeys, which commit 8e2efb3f45a5
> ("net/sched: add get_fill_size callbacks for actions missing them") started
> accounting for properly.
> 
> When that happens tcf_reoffload_del_notify() returns early, before
> tcf_idr_release_unsafe(), and tcf_action_reoffload_cb() discards the return
> value:
> 
> 	if (tc_act_skip_sw(p->tcfa_flags) && !tc_act_in_hw(p))
> 		tcf_reoffload_del_notify(net, p);
> 
> The action has just lost its last hardware instance and is skip_sw, so it
> is left installed while processing no packets, and with no notification to
> tell userspace about it.  An -ENOBUFS from alloc_skb() gets the same
> treatment.
> 
> Fix this by budgeting the message header the way the add and delete paths
> do, and release the action even when the notification cannot be built -
> dropping the notification is strictly better than leaking a dead action,
> and there is no caller left to report the error to.
> 
> Fixes: 13926d19a11e ("flow_offload: add reoffload process to update hw_count")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260810164357.1653956-1-victor%40mojatatu.com
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>

> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> ---
>   net/sched/act_api.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index 20b6501fd33b..37eced84dfa5 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -1867,11 +1867,13 @@ static int tcf_action_delete(struct net *net, struct tc_action *actions[])
>   static struct sk_buff *tcf_reoffload_del_notify_msg(struct net *net,
>   						    struct tc_action *action)
>   {
> -	size_t attr_size = tcf_action_fill_size(action);
>   	struct tc_action *actions[TCA_ACT_MAX_PRIO] = {
>   		[0] = action,
>   	};
>   	struct sk_buff *skb;
> +	size_t attr_size;
> +
> +	attr_size = tcf_action_full_attrs_size(tcf_action_fill_size(action));
>   
>   	skb = alloc_skb(max(attr_size, NLMSG_GOODSIZE), GFP_KERNEL);
>   	if (!skb)
> @@ -1888,15 +1890,18 @@ static struct sk_buff *tcf_reoffload_del_notify_msg(struct net *net,
>   static int tcf_reoffload_del_notify(struct net *net, struct tc_action *action)
>   {
>   	const struct tc_action_ops *ops = action->ops;
> -	struct sk_buff *skb;
> +	struct sk_buff *skb = NULL;
>   	int ret;
>   
> -	if (!rtnl_notify_needed(net, 0, RTNLGRP_TC)) {
> -		skb = NULL;
> -	} else {
> +	if (rtnl_notify_needed(net, 0, RTNLGRP_TC)) {
>   		skb = tcf_reoffload_del_notify_msg(net, action);
> +		/* The action has already lost its hardware instance and is
> +		 * skip_sw, so it must be released whether or not the
> +		 * notification can be built.  Drop the notification rather
> +		 * than leave an action behind that processes no packets.
> +		 */
>   		if (IS_ERR(skb))
> -			return PTR_ERR(skb);
> +			skb = NULL;
>   	}
>   
>   	ret = tcf_idr_release_unsafe(action);

