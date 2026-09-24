Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403053D1CB4;
	Thu, 24 Sep 2026 02:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790216489; cv=none; b=V9IsLTFMzpX/Wny/UTLdXg2ATbxuL1UfzooRflCKVUS+t1okRtFGmwm6d4gI6Xe7vrJo6VASg2RoESgfPDoWjCM/msSfUGqj2NUq9fRWcPpFcyxx3NO49aFQ1VqV4cFD+GdlGda/lhoJ6U6h4ztbd97TB+0/2XNDYdBtHbJXzek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790216489; c=relaxed/simple;
	bh=Rtd5TgrCp/zE4+sjKN8UD1PTpS3JsNummN7U+4iX+no=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LNX/Snp2b4jhPYJrZj5Qjv7z06hXEb6JoyldKDbOLADnhyDlnNW81jLOLarGlqOvPFYAuazbq3HcROPjwooXwjC1SiB4L+7DmWUa4bGDEssatg5qAJvTypgYB2riRgZCff+FxBhOAdvMWsmMdVBq0gpgLbPqaePYutU9g+OgaS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkQw/h8L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkQw/h8L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE361F0089C;
	Thu, 24 Sep 2026 02:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790216487;
	bh=s7BQn6WkLZH+Ix/ALFZ9dSrBku4X9YNs4M2zE5d6Ln8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HkQw/h8LUSL90higrvZUQNXqr2vkhzcTyl0+J9rARxxhuRJtA+G8nHni1wpHJkJ+6
	 1b7XrKq3JsHp+iQ/oVz/xP+2Ku+X2N/jV7pd+fEZXMEZ1+dq6uhc7txqnwQtKv2EE4
	 2N8NsSZuAGF5CjOfT2P+ZyYIBETZv4X/pLoz7k5tg/Yx+jFjI3NE4PJquc+HEODhlb
	 z+WJsyzxLMqMsEJxCTExHIqUgQJluZU8fxd/K0WEgv0sFsxGdb+97dg1lxxBEqFDNF
	 PupkkRubMNsSvpvv1/of+k8oSpBayHWPPpLP8LiO8bcCLlHglHnHM5xY5GhjSrp3Gu
	 1vHL3wLI7JQ5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939E839E9611;
	Thu, 24 Sep 2026 02:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/sched: ematch: check nla_put_nohdr() return value in
 tcf_em_tree_dump()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179021641714.1281065.10384838349478970893.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 02:20:17 +0000
References: <20260919210624.3030344-1-benquike@gmail.com>
In-Reply-To: <20260919210624.3030344-1-benquike@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 19 Sep 2026 21:06:24 +0000 you wrote:
> When tcf_em_tree_dump() was converted from the legacy rtnetlink
> `RTA_PUT_NOHDR` macro (which contained an implicit `goto
> rtattr_failure;`) to `nla_put_nohdr()`, the return value check on
> `nla_put_nohdr()` was omitted for container/simple matches and raw match
> payloads.
> 
> If the netlink dump skb runs out of tailroom at `nla_put_nohdr()`, the
> error is silently ignored and `match_start->nla_len` is finalized
> without the match payload, emitting a malformed/truncated
> TCA_EMATCH_TREE_LIST attribute to userspace instead of returning `-1`
> via `nla_put_failure` so rtnetlink can reallocate and retry the dump.
> 
> [...]

Here is the summary with links:
  - net/sched: ematch: check nla_put_nohdr() return value in tcf_em_tree_dump()
    https://git.kernel.org/netdev/net-next/c/528de6832b21

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


