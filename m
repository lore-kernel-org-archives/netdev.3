Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794298289;
	b=HUuy6hJoVYCXEkt7HT0WyWVc+EaefuZcGIfb89x1JjBINPJbV3Q1IKSmluxOsLYL5zUR
	 Y9qmpxtlgcYLIo85mJ5Rab6gVO3hR3ELnfdhZKMLZDVqYwWLJLh/7ROauauQ5RGmQEUix
	 5hooYlZiM/4fLUt7KinIHBsf7T1gcolSecc3wcE9Azx8mIa9gcHmD0/iu0NlBbA3COuiw
	 IFoyOb8O2j+y5g3TvD8S5kim5hPi/IHTfVVUUOSVqOUgQO23I3nlImEz6ZflhNSbvQZt6
	 UyORzM4Vs6u4iuTkvAWUpcdU3ZGatOosguWul/TupVMsXFzNvT+8UqxKHTYfTGo8Qtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794298289;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=jOh7ZgnccO4L8Qeh1oaXwjE5S2FwXwDj1PkxCIz2bvQ=;
	b=M4R4Xmlz5Qx6oQ6zpbV3JFCSIWRxAUENp2/FdWlYx7oWcRu3u8ZC/aeuFY2ZYPRggjAS
	 /XjGhBRmZbp65t3SFs5BAXb5ozjCG9AP1okQjjBh/Hp2Z1pCwjZi50rXBoVd2OMYv2JCR
	 TtO11U7PTb+H6Dyyw6MwTXcivZF0br1mgOFzx5wwNb4WN/Mp+//+gWF2XkPUv477GAMqN
	 lb6IAWgVaLWZb+bydY8BtCNlQxixi/ixayTaTUWvH9pDi0rBuvc/FJdI6EVna3rpEGNIo
	 Y5ZhBRcH1Rg2IeGXpIxo+BVtrqiSn/+9PAKujY8dotu8ohLYE5u7Fll4XAQzIEt5bzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXwyv7k7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822FE606A31C;
	Tue, 10 Nov 2026 08:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXwyv7k7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47ED01F0089F;
	Tue, 10 Nov 2026 08:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794298288;
	bh=jOh7ZgnccO4L8Qeh1oaXwjE5S2FwXwDj1PkxCIz2bvQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lXwyv7k7RCG1HZme74th2ZxaF60JVoYGpIkmDSEOIFN6vqgK3Yccn5edW3L5+wkJK
	 Ul7q5eJUI7wSyqpf8Aet2p/e+2pirXuVxKhFMW60jLth/4+LneVxd+08xmCVaC8nFd
	 AghlxIPxCVm8HXERn1OkiAIZkP7PxINXaKr8FNX9/NjH42Z53DuD8Ptt+jkBe5QlDw
	 ZbJ9ON9vwXSxNNQrwpNrxaQ2gS6PTFsWBIBOAIht7NNucADubplptxADnmkfem79aQ
	 GMfEqqmDZqvrB2+PFgxCGiHvdxJOZQ2uKxthP+mrjlzsCICwt2DUac77opsFue9xrX
	 Xow4LQrsrJLLQ==
Subject: Re: [PATCH net v3 2/3] net: dsa: motorcomm: Resolve the flower action
 list to one ACL verdict
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Tue, 10 Nov 2026 08:11:27 +0000
Message-ID: <179429828784.994134.6502837547336557554@kernel.org>
In-Reply-To: <20261106073806.112122-3-mmyangfl@gmail.com>
References: <20261106073806.112122-3-mmyangfl@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch adds a claim to both the commit message and a new
  comment in yt921x_acl_rule_ext_parse_flow_action()…

--

net: dsa: motorcomm: Resolve the flower action list to one ACL verdict

This commit changes yt921x_acl_rule_ext_parse_flow_action() so the flower
action list resolves to its first terminal action. Before, every action was
accumulated into the ACL verdict. After a redirect only a drop is allowed.
Any other action after a redirect falls back to a CPU trap, or is rejected
when skip_sw is set.

> diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
> index 90b017a11a1b1..5c82719e461f3 100644
> --- a/drivers/net/dsa/motorcomm/tc.c
> +++ b/drivers/net/dsa/motorcomm/tc.c
> @@ -1030,55 +1030,56 @@ yt921x_acl_rule_ext_parse_flow_action(struct yt921x_acl_rule_ext *ruleext,

[ ... ]

>  	memset(action, 0, 3 * sizeof(*action));
> -	flow_action_for_each(i, act, flow_action)
> +	flow_action_for_each(i, act, flow_action) {
> +		/* Only a drop can follow a redirect: a drop is an empty
> +		 * destination set, so the software verdict is the same
> +		 * whichever control the redirect carries. A second redirect
> +		 * would only extend it if software continued past the first
> +		 * one, and the flow action entry carries no mirred control
> +		 * verdict to tell that.
> +		 */
> +		if (redir && act->id != FLOW_ACTION_DROP) {
> +			reason = "Action after redirect";
> +			goto fallback;
> +		}
> +
>  		switch (act->id) {
>  		case FLOW_ACTION_ACCEPT:
> +			action[2] |= YT921X_ACL_ACTc_FWD_EN |
> +				     YT921X_ACL_ACTc_FWD_FWD;
> +			terminal = true;
> +			break;
>  		case FLOW_ACTION_DROP:
> -		case FLOW_ACTION_REDIRECT:
> -			if (redir_act != NUM_FLOW_ACTIONS &&
> -			    redir_act != act->id) {
> -				reason = "Different redirect actions";
> +			action[2] |= YT921X_ACL_ACTc_FWD_EN |
> +				     YT921X_ACL_ACTc_FWD_REDIR;
> +			terminal = true;
> +			break;

[Severity: Medium]
Is the software verdict really the same "whichever control the redirect
carries"? The commit message makes the same claim:

  Only a drop can follow a redirect: a drop is an empty
  destination set, so the software verdict is the same
  whichever control the redirect carries

This seems to hold for pipe, and for the controls that
tcf_mirred_can_reinsert() accepts (shot, stolen, queued, trap). For pass,
continue, reclassify, goto chain and jump, software looks different.

In net/sched/act_mirred.c:tcf_mirred_to_dev():

	dont_clone = skb_at_tc_ingress(skb) && is_redirect &&
		tcf_mirred_can_reinsert(retval);
	if (!dont_clone) {
		skb_to_send = skb_clone(skb, GFP_ATOMIC);

With these controls a clone is redirected and the control is returned
unchanged. Then net/sched/act_api.c:tcf_action_exec() ends the action list:

	if (ret != TC_ACT_PIPE)
		break;

So the trailing drop never runs in software. A jump control skips over it.

Take a rule like this:

  flower ... action mirred egress redirect dev swp1 pass action drop

Software sends a copy to swp1, and the original frame continues into the
stack or on to the next filter. In hardware, the FLOW_ACTION_DROP case keeps
FWD_REDIR together with the DPORTn bit set by the redirect. The rule is
therefore programmed as a pure redirect, and the original frame is only
forwarded to swp1.

Before this patch, this action list hit the "Different redirect actions"
fallback. It was trapped to the CPU, or rejected under skip_sw. Does the
patch now offload a combination where hardware and software behave
differently?

A standalone redirect with one of these controls already had a similar
mismatch, as the second half of the comment says. But
tcf_mirred_offload_act_setup() only fills in entry->id =
FLOW_ACTION_REDIRECT and the device, not the mirred control. That means the
driver cannot check the equivalence this gate relies on.

Should a drop after a redirect go through the fallback path as well? And
could the comment and the commit message be narrowed to the controls where
the equivalence actually holds?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106073806.112122-1-mmyangfl%40gmail.com
