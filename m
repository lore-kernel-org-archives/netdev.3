Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793876238;
	b=jjgaWIJtGSm3C05U9fQEV2jaKadRe6Wm7XTYo2BKcxGKlLwGWNeEsiATxzbhw7wMpKtf
	 AQSXPvOaKemj4slTnvYT+IeL3Nbmn8K8GmfCwHdEB5s9Z3oFwAoYzo/lIJrJLtYnV4vJK
	 nzxBMiOv1zWwJUozMzZtfTdEcOOlbTQFyIOaXzuqNCEfPE452Yz3DYaH4i2PJBYF6Kic8
	 +//aTc9deRtDL+18eYR2qA40JVvTw+bg1Fgj8l2c4pk1JZoWCvR0Iq7tWyhUD/S/JF2rK
	 V0/xxyPgyytH+0KkStAWe/trldOtjnrLhYQ4//0xBKujsjWTQU7FESFe+ZpwViCQVlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876238;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Yk0NNrYkQ4N4ccgY8kCGM4zul3wjbpL9JfKMdme0vGg=;
	b=EgWRCJVEWazN//bJJqFMnxohZmcRACtDSdiafi6uuPMYQom39nt70q6+tbLptJsgQxcm
	 FWtPd4rV+RRFXWOdMjiAL11nloHbg+6V/qL1M8Qd+YURATW1VNdLGHqqsdIMxvK1NefAo
	 x9q/R7lVbV2ammoUXNElBsziLufWB3tg9zXXFrYCVvEsSRNWr17PFpJF1C00ebqakH0TD
	 AUGp3lvuaYwYPx82kiC0sZVQXe+EXlSC6IPjxrORuFvR1jgKNEV0taA3WuDqhE2UodKRB
	 aoYhkPUOwoMGbtiQ9sxj8I1gCV+LgnJ7Xt+CeSvrtoWW5/P43vB0aKzvkJieEcr6O2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c29mcl8f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F38606D802;
	Thu,  5 Nov 2026 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c29mcl8f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF521F000C1;
	Thu,  5 Nov 2026 10:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793876237;
	bh=Yk0NNrYkQ4N4ccgY8kCGM4zul3wjbpL9JfKMdme0vGg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c29mcl8fed+UyMQAwVDV/KKGo0bpd/gzY4E1d1+KmBRGnBUWsYd3w9P/SKdkim34X
	 k9aNTl+lNGFX0yDpLqnlVXFyZfqr9ulIptBzI0V/xs6nHmla21wVoMAQ2Urc/ihXb4
	 J/agQno5SSjy3RrG5jdMjKlBGuQoY1yzicvcwSj1tmXpoXBW3Q03ZWJRrm1FTOxfkG
	 kuMyScKaHUXNj5H7Nz6WL+v7kCLjpapTLSGXUuvv6s8DaMvL2nb4IQ7JjqZ4GJ/88D
	 nzw5hbFvBy4sWl/Wx2gU9np3+UI7fpuNX1ETlf/H/6h+mkjoF+67fEB19ez3IDNXMb
	 othShHJbUiWmQ==
Subject: Re: [PATCH net] tipc: fix division by zero in perc()
From: netdev-bot+sashiko@kernel.org
To: tristmd@gmail.com
Cc: jmaloy@redhat.com, tung.quang.nguyen@est.tech, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 richard.alpe@ericsson.com, ying.xue@windriver.com, erik.hugne@ericsson.com,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, tristan@talencesecurity.com
Date: Thu, 05 Nov 2026 10:57:16 +0000
Message-ID: <179387623625.488856.16993950481980996538@kernel.org>
In-Reply-To: <20261103225433.2663943-1-tristmd@gmail.com>
References: <20261103225433.2663943-1-tristmd@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message's premise is wrong.
- [Medium] Judged by its own premise, the fix is incomplete.

--

tipc: fix division by zero in perc()

This commit adds a zero check to perc() in net/tipc/netlink_compat.c so
that it returns 0 when total is zero. The commit message says this
prevents a division by zero in tipc_nl_compat_link_stat_dump() when link
statistics are queried on a fresh link.

> The perc() function divides count by total without checking whether
> total is zero. When link statistics are queried on a freshly
> established link that has not yet exchanged messages,
> TIPC_NLA_STATS_MSG_PROF_TOT is zero, causing a division by zero
> in tipc_nl_compat_link_stat_dump().

[Severity: Medium]
Can TIPC_NLA_STATS_MSG_PROF_TOT actually be zero here?

This attribute is only produced by __tipc_nl_add_stats() in
net/tipc/link.c, and that function already clamps the value to 1:

net/tipc/link.c:__tipc_nl_add_stats() {
    ...
		{TIPC_NLA_STATS_MSG_PROF_TOT, (s->msg_length_counts) ?
			s->msg_length_counts : 1},
    ...
}

So a link with no profiled messages reports 1, not 0. If msg_length_counts
wraps back to 0, it is also clamped to 1.

User space can't supply these attributes either. __tipc_nl_compat_dumpit()
allocates a kernel skb with nlmsg_new(), fills it through cmd->dumpit, and
passes the parsed attributes to cmd->format:

__tipc_nl_compat_dumpit()
    tipc_nl_node_dump_link()
        __tipc_nl_add_link()
            __tipc_nl_add_stats()
    tipc_nl_compat_link_stat_dump()
        perc()

Broadcast links use __tipc_nl_add_bc_link_stat() and return early through
__fill_bc_link_stat(), before any perc() call.

The clamp came in with commit 7be57fc69184 ("tipc: add link get/dump to
new netlink api"), which is older than the Fixes: target f2b3b2d4ccbf
("tipc: convert legacy nl link stat to nl compat").

If so, the described division by zero has never been reachable. Could the
commit message describe this as hardening instead? Could the Fixes: tag
also be dropped, so stable doesn't pick this up as a crash fix?

> diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
> index d9a4f94ea2d43..75f3193a2a6cf 100644
> --- a/net/tipc/netlink_compat.c
> +++ b/net/tipc/netlink_compat.c
> @@ -497,6 +497,9 @@ static int tipc_nl_compat_bearer_disable(struct tipc_nl_compat_cmd_doit *cmd,
>  
>  static inline u32 perc(u32 count, u32 total)
>  {
> +	if (!total)
> +		return 0;
> +
>  	return (count * 100 + (total / 2)) / total;
>  }

[Severity: Medium]
If the premise in the commit message were true, would this check ever be
reached?

tipc_nl_compat_link_stat_dump() also divides by the same attribute with no
guard. That division is in a tipc_tlv_sprintf() call that runs before any
perc() call:

net/tipc/netlink_compat.c:tipc_nl_compat_link_stat_dump() {
    ...
	tipc_tlv_sprintf(msg->rep,
			 "  TX profile sample:%u packets  average:%u octets\n",
			 nla_get_u32(stats[TIPC_NLA_STATS_MSG_LEN_CNT]),
			 nla_get_u32(stats[TIPC_NLA_STATS_MSG_LEN_TOT]) /
			 nla_get_u32(stats[TIPC_NLA_STATS_MSG_PROF_TOT]));

	tipc_tlv_sprintf(msg->rep,
			 "  0-64:%u%% -256:%u%% -1024:%u%% -4096:%u%% ",
			 perc(nla_get_u32(stats[TIPC_NLA_STATS_MSG_LEN_P0]),
			      nla_get_u32(stats[TIPC_NLA_STATS_MSG_PROF_TOT])),
    ...
}

If TIPC_NLA_STATS_MSG_PROF_TOT were zero, the divide error would hit in the
average calculation. The new check in perc() would never run.

In practice, the clamp in __tipc_nl_add_stats() keeps both divisions safe.
That makes the patch unnecessary if the clamp is relied on, and incomplete
if it isn't.

Would it be better to drop the crash claim? Alternatively,
TIPC_NLA_STATS_MSG_PROF_TOT could be checked once in
tipc_nl_compat_link_stat_dump(), which would cover both the average and
the perc() calls.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103225433.2663943-1-tristmd%40gmail.com
