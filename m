Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85771548EE;
	Tue, 31 Mar 2026 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774919422; cv=none; b=Ma6wQbQ/Q91mxZpIv3zCQmxif0MSLRbaeYkBt1sVHK4IC9g9lV00VQo2uMCmnsJRICVtechbGpPy+HFv6VJI3nZeBiSvlKYOMAjnEa/xzRSZk3QURfyMQt3iHEHuknVPpDCjRtdVVFCvUxjah11TsE7w4M0veucoohnsENJaPOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774919422; c=relaxed/simple;
	bh=Uf0hLhDoRKYV8KUasE1qKevKhLjr1VDqmB5YSdv2fJg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T73Xwd+/zowo1wBDvCeCuxHbuolfgnRm1Egr1NNQhTbUv2bbPlYpt5jyAfh5xDo1wIxTooAOayhWjwvk6vzIPncn6SyzLHZ00FOTk78aqW47wvkmCwcw3TlWs4uPKKsY3fl2p2kpuNKPMAq+e+gfmkRYBHD14zauqsDCZMccAQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4Vw+Ehd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4Vw+Ehd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE7BC4CEF7;
	Tue, 31 Mar 2026 01:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774919422;
	bh=Uf0hLhDoRKYV8KUasE1qKevKhLjr1VDqmB5YSdv2fJg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L4Vw+EhdnrympL5O5eJgG/vvBN703pwlt1dHDdXvYMqArApxWUA2EzwbG9J5UwUvD
	 Vsk7Xu+M2LvlpRV4REia6+VZpW+i21YJ8Dxe5ZK3FPGZfOCcqNznOYfgm2gv1rlgeU
	 xpz9y5vQzUzCwt2FWa47Y6/nU+/xhTLu35PDOcwN8+HqhSx7krKRxt0qRaF3+ScbW7
	 J2OEL5asfRs7k73NCG2xiGWDGubi3rp9FCjJ6KjajWRP6o5UlMm031VnMXHedWTMFS
	 0ITxfQgyHzaJjScmUtrmbLCW3jGiunl0NM/t/H7PTYQmW/L/RUPVfGAats0zL+JZXQ
	 yk/KDqTqt983A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEBC392FF97;
	Tue, 31 Mar 2026 01:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v7] bnxt_en: set backing store type from query type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177491940629.2043537.7272762691684317333.git-patchwork-notify@kernel.org>
Date: Tue, 31 Mar 2026 01:10:06 +0000
References: <20260328234357.43669-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260328234357.43669-1-pengpeng@iscas.ac.cn>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 29 Mar 2026 07:43:56 +0800 you wrote:
> bnxt_hwrm_func_backing_store_qcaps_v2() stores resp->type from the
> firmware response in ctxm->type and later uses that value to index
> fixed backing-store metadata arrays such as ctx_arr[] and
> bnxt_bstore_to_trace[].
> 
> ctxm->type is fixed by the current backing-store query type and matches
> the array index of ctx->ctx_arr. Set ctxm->type from the current loop
> variable instead of depending on resp->type.
> 
> [...]

Here is the summary with links:
  - [net,v7] bnxt_en: set backing store type from query type
    https://git.kernel.org/netdev/net/c/4ee937107d52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


