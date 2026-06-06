Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CD9241695
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 01:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780707628; cv=none; b=RhNT5zn/mPODJ3SHfJpH3ISFK7T6GIYZ3zgAfbhdlAihBb1yUihwQkUd+DFNJSFruaHW+zob4fzqEon4liJ4c3E3uMMiAVeyaqtNbybGC1w1TnccMiQitFZXgkU8XMKlG38k2JWja1gdybSkArVcTooDDDUVtjKQVzQ9z7DB7Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780707628; c=relaxed/simple;
	bh=i+chHhBjSXZzG/gF+2hL0I6G/dcNrZYBeMuGn9lnMNQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GeB2ZEgZbOYNDxJQEbSznJ3xseyFjhx3lxCZAw9bCChyRPpECQwCtaV4hpq8eV22NUWc1WM4tW2RZG9Lbg42KhQB9JOWDi4IoMDEaNPmOFTZjT9Im99SfMCF/mdcCxmpbQOazchiVESyb+VIoM+wmWGSpDTDc6PjPBRrEd4ETOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrgxyrON; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrgxyrON"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA0A1F00893;
	Sat,  6 Jun 2026 01:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780707627;
	bh=LkTBnCJwnVbBp/UHzogkwHXIi2GZ2BrrqyTNL/j45rA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GrgxyrON1WeUZly9qmvPNzcytlg1LfFbl7+gjDgZbQHQz8K+KyCsaxCfq2uySZR7p
	 8kgMjwdCVF3M/yukeTlMElpOchFhPY9VhUqLnKsV8Z9uhbq31tGiooOyjyMpVuJuAJ
	 QhXFalvVjd9ZEFZB10FfekfUywzlLb/rGRw0mlPrdVgd9FQHenM5ZtJJrws//Du+JO
	 zTww3VrqWW4n+AXIkCxNpfRSjdt3eKrX8xm+8omXhxr86Mm823DpGlWfGDPjF8lK3Y
	 45Zu47bZ5Pii4ki/UJx5144P5AEpq7fuP8ga6aftIEGSMB4q/oDsrPtW/r2/99xofn
	 +hb8wr1FWKNCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939BA3930C06;
	Sat,  6 Jun 2026 01:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv4: remove obsolete EXPORT_SYMBOL() and
 EXPORT_SYMBOL_GPL()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178070762713.3975748.7464742357411295064.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jun 2026 01:00:27 +0000
References: <20260604173413.2782008-1-edumazet@google.com>
In-Reply-To: <20260604173413.2782008-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jun 2026 17:34:13 +0000 you wrote:
> These symbols no longer need to be exported, they are only used from
> vmlinux:
> 
> - inet_send_prepare
> - inet_splice_eof
> - inet_sk_rebuild_header
> - inet_current_timestamp
> - snmp_fold_field
> - snmp_get_cpu_field64
> - snmp_fold_field64
> - fib_nh_common_release
> - fib_nh_common_init
> - fib_nexthop_info
> - fib_add_nexthop
> - ip_build_and_send_pkt
> - ipv4_sk_update_pmtu
> - ipv4_sk_redirect
> - rt_dst_clone
> 
> [...]

Here is the summary with links:
  - [net-next] ipv4: remove obsolete EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL()
    https://git.kernel.org/netdev/net-next/c/b056e7326724

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


