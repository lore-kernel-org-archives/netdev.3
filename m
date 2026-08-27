Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452AD3845CF;
	Thu, 27 Aug 2026 19:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858273; cv=none; b=aTEsaj1w5l2HymsRch00XyclCbIyxsem8CBDTt3ozQzzYtoUnl4P3p18V2gKwhDljMADkgCvuJpZ6+3vvDIrvwfUniGXO5uL9Npm7Ib/lVZIKvPAj9V/4S9LR2hy2g9SRNyWohFKUQyS8Xtgz6OLGsNtxrmXVz58FXWD31kRQn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858273; c=relaxed/simple;
	bh=66kALFDc2J6WjRZdn455eKMgns2n2ASsKM/zW12bcfA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6f8sYWiTaXWvLh6ChYuo/18OgXU2cWb7GN5FnVl0IJ1q8UIXV01FXs3ysTaqmqLo8ofOJGJYjya1j2+5MBd6yCtDaLN9IMLyoxJ10BuL7UwdG0Vgj8B2fEskJkY5Lcwrbf+81/pg/BgSbR6hXhcr1mjaIKO0P8akgEHHOwj78U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKofmqhz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKofmqhz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938291F000E9;
	Thu, 27 Aug 2026 19:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787858271;
	bh=naGKqcuTSdRoSKu8BSOR6nFZoZP8zhL1AqozC0137TM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CKofmqhzmVEErEwj37JQdbVc2fYMnpCl/drEsOetewCXp8FwUpJVY4UPTRfZjpR27
	 l1Fi7loxBXPX8YOFoW44GWu5WO0oWFFdx/PNLej8piane1RaV4cANX9oXmfH8s8V17
	 sbnvSBjK3KbdjPTQ2qyaPtC/xKnkCkyMs/YTovNWXEi2Ds6lDMoUHIcEleXodz8rRH
	 3rxExSNgubLC9kztdJL+7qRy9HUOgz5B826ElmaGho9DyrnSGaV53KGbepFWGmqAAx
	 9ms7d38sFIK0UJ47zrTAaRPWG5TBi/l1HbIU0wl97xHjQ6w0VaJTMLA0aPwPghuIK8
	 fiZK5IzrUrnBQ==
Date: Thu, 27 Aug 2026 12:17:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: Po.Liu@nxp.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v3] net/sched: act_gate: Limit the max value for
 cycletime
Message-ID: <20260827121751.33dac8aa@kernel.org>
In-Reply-To: <tencent_FAEDEECDD478AE6DFC2DE96D389440E96A0A@qq.com>
References: <tencent_9E794E6CE82D396E9894ECEBFAEDE6CE7C0A@qq.com>
	<tencent_FAEDEECDD478AE6DFC2DE96D389440E96A0A@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Aug 2026 20:13:02 +0800 Edward Adam Davis wrote:
>  static const struct nla_policy gate_policy[TCA_GATE_MAX + 1] = {
>  	[TCA_GATE_PARMS]		=
>  		NLA_POLICY_EXACT_LEN(sizeof(struct tc_gate)),
>  	[TCA_GATE_PRIORITY]		= { .type = NLA_S32 },
>  	[TCA_GATE_ENTRY_LIST]		= { .type = NLA_NESTED },
>  	[TCA_GATE_BASE_TIME]		= { .type = NLA_U64 },
> -	[TCA_GATE_CYCLE_TIME]		= { .type = NLA_U64 },
> +	[TCA_GATE_CYCLE_TIME]		=
> +		NLA_POLICY_FULL_RANGE_SIGNED(NLA_S64, &gate_cycle_time_range),

Why are you changing the type of the attr? S64_MAX is perfectly fine as
range for NLA_U64

>  	[TCA_GATE_CYCLE_TIME_EXT]	= { .type = NLA_U64 },
>  	[TCA_GATE_FLAGS]		= { .type = NLA_U32 },
>  	[TCA_GATE_CLOCKID]		= { .type = NLA_S32 },
> @@ -501,6 +507,7 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
>  			cycle = ktime_add_ns(cycle, entry->interval);
>  		cycletime = cycle;
>  	}
> +
>  	p->tcfg_cycletime = cycletime;
>  	p->tcfg_cycletime_ext = cycletime_ext;

Unrelated noise, please pay more attention.
