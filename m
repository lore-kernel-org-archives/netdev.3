Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E839A565111;
	Wed,  9 Sep 2026 21:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788987676; cv=none; b=WfL8W+KEZNIbLDx01t8uqjI9XqBpjnnZUlNu6eaEzRLFxp/P/okk4ZgVCsRkKT3oASBh78B3s5wsTpwmaaNwjuH9B0PZPhhIN3TwK7msYVu8BDVGP3HGIQqiNNKmDgdrCJHby1koSsjaBgq8GRvWn0+sMRBBCUOowdf8KSVAzF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788987676; c=relaxed/simple;
	bh=oYzKTq2CA0Kvy/jXSbRzpvyLzSwV3btX/5xw8gVsEKQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AM43AzVSkxJq61psJxz6kr9Y9MYMtlbYqla/Dt96QY5y44dpGk73PezdLg9OQ8hOFEO+zxZyKlMiWDSAcbMiq+QoyzdE4KrcBcJsohFj8CsjOeiQaCpgCR3L4G1SXwxcmxshR1ZAjpGMmsvi1TvX8iVA5rdambNx4tjUmicH/Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGuYED4Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGuYED4Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3091F000FF;
	Wed,  9 Sep 2026 21:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788987674;
	bh=i/b40Sqj8tCKTqN4qt3z4g/yZjnss4O3HxuCNjuBPek=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BGuYED4QDfYk05GhbGbPnADgnX4MESnWvTllSIlyS06u9ndaLzDuxg/FwontFPXkY
	 AxMTn1hcL2uK/Bh6u/XxBRsxf759Rnk9A9DC9/6jIlR0ge6CWKnhZz+myOADZ/6orv
	 LSLJ5piHwCVn6ALgHSX8SFl790NKxhR3n+0WtdqRcwyq1hx8IUieZHFcOiiTI3ekG/
	 I3WC6V/9aDB6+cMrlRa5WOsc0NITKVHOtiKUFPFH34rLG0p9VztTQZSWunG6k6JnBy
	 SoKGp1cWcg7NYzEqNErC6FnpaOd3wyfjTLzETTt9esqVUodLL1mPwrijskRcYdWezY
	 yNUrZyU6vaVjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09B3380AAFF;
	Wed,  9 Sep 2026 21:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] netlink: specs: handshake: type the
 remaining
 key serials s32
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178898761238.1057294.17887063472618531866.git-patchwork-notify@kernel.org>
Date: Wed, 09 Sep 2026 21:00:12 +0000
References: <20260904190410.3864660-1-kuba@kernel.org>
In-Reply-To: <20260904190410.3864660-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, cel@kernel.org,
 donald.hunter@gmail.com, kernel-tls-handshake@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Sep 2026 12:04:09 -0700 you wrote:
> include/linux/key.h has "typedef int32_t key_serial_t" and commit
> 160f404495aa ("handshake: Fix sign of key_serial_t fields") converted
> x509.cert and x509.privkey to s32, but accept.peer-identity,
> accept.keyring and done.remote-auth were left as u32 - the same
> quantity typed both ways inside one family, and a generated user space
> struct with __s32 cert next to __u32 keyring. All three come from
> key_serial_t storage in net/handshake/tlshd.c (treq->th_peerid[],
> treq->th_keyring), and special keyrings are legitimately negative
> (KEY_SPEC_PROCESS_KEYRING is -2).
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] netlink: specs: handshake: type the remaining key serials s32
    https://git.kernel.org/netdev/net-next/c/f5134d734770
  - [net-next,2/2] netlink: specs: handshake: do not accept the handler-class sentinel
    https://git.kernel.org/netdev/net-next/c/fd0291fad9e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


