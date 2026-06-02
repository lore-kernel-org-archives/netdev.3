Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894EC3A7F73;
	Tue,  2 Jun 2026 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780428006; cv=none; b=OKy3plY418/bc1MXfYVF0X5yKIi74fkmtp/mego2VYJGo8RJSVVelVgOig2qMDIajxCHkusLTq71l8FEviwMRKHKeBOXD8G4WO0JTpovo61L+Z6o2TX9NiO6U121RToLV4pksrH33cSGm119iKRo2o7l7g76DZawMhYMtCKWXu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780428006; c=relaxed/simple;
	bh=iY5lxsufbIs6GBTopTls6bbsXH/MIbKi7m5qIfPLAIQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V/EOLUE6fOwmESDHgjNpjotBPpxPL2cwJ5cjwzOE9GRhIiX/paVdwaYF2hY6O/MS+sWNC/NAM4qPfJr5CV7xHreRIK9vmjGCKIC7LHcSGwclHYsNsh3a1+ubJakJ5BWaRzDY2nGJ0aIP7GvAFiXKVJo9AJ5N6ZeD6QITzKUMQJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVT3p86R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVT3p86R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402611F00893;
	Tue,  2 Jun 2026 19:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780428005;
	bh=1Ly8Kx3ZJ29PYIkpBHUVyCnqBzuLK3fkAbcgfIqfT+I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WVT3p86R55nggMaNgeXEphhspHN1gFEL1GIAaBzrlHdF4jwRTjUliy546fvWs7Bx1
	 QZMgc6ciI/Fbnk/RB3oHtS42/gurZU5qAl3AvveNKtjR5kiehPglidLlxnzzvnkjNH
	 aYe1DqOySU9eRLdFpUoX7SXGSwzas6pNR/r9XTX6fc47RtJez/kwOsM9HWCqzjfSGj
	 bdLzdq5mcqnValm7a4gzSbAuHFNpiDpknRVj4ZP17A2pGU+DAPvR1yaeV3ukL/i+Kj
	 qP5kxtetkzo0JXN9FNOreeNLsl5v3+CKyn++o4wxKdZN/h00Z7AlFbvrRIXx30iQ0N
	 DwhX+LU08jjMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569BB3811A6C;
	Tue,  2 Jun 2026 19:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: garp: fix unsigned integer underflow in
 garp_pdu_parse_attr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178042800690.1014313.17359151426074181113.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 19:20:06 +0000
References: <20260527083200.42861-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260527083200.42861-1-zhaoyz24@mails.tsinghua.edu.cn>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 yangyx22@mails.tsinghua.edu.cn, wangao@seu.edu.cn, fengxw06@126.com,
 qli01@tsinghua.edu.cn, xuke@tsinghua.edu.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 May 2026 16:31:58 +0800 you wrote:
> The receive-side GARP attribute parser computes dlen with reversed
> operands:
> 
>         dlen = sizeof(*ga) - ga->len;
> 
> ga->len is the on-wire attribute length and includes the GARP attribute
> header. For normal attributes with data, ga->len is larger than
> sizeof(*ga), so the subtraction underflows in unsigned arithmetic.
> 
> [...]

Here is the summary with links:
  - [net] net: garp: fix unsigned integer underflow in garp_pdu_parse_attr
    https://git.kernel.org/netdev/net/c/16e408e607a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


