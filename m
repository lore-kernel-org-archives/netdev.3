Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA0A4503ED
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 09:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402207; cv=none; b=BKRjBXY9suRwhKTitq2drFwDaltyNauNIUL++vBDl/oczwXPHh1uiXrHU/7VMvYt/3mk13U4/A7dbm5nc+f+1n9o4gqQxKMUD5fM7sD+Jryq9Q0XAjVUPmnCOSXriCoHL4e7UolKCrEkNkJVD2DsN0YcCbSjs39nAMWSHtlv6NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402207; c=relaxed/simple;
	bh=p1QzlCetlPkeCkvMF8YOrFvF7dybOUqxI1xaMJ7nhf4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CGxiDcJjniNCSSowvxNMcdMsTtiI9Mhq8A3TFiK6uP/4AjFuEiNRHQhIqFqurQWu2dDp6HOFh8XPp/YzIOZVoWvvamAowS35WEW37sr6lW11BNyMLaWgKxYXR1kP2geTbn7Dnmcr/+ifi/vKlQDCgq1G+WoZ+67Kg72k70/m8Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXvhTaFY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXvhTaFY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817691F000C4;
	Mon, 19 Oct 2026 09:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792402206;
	bh=h+6y2Aqdx9hQP4X3Z42enndZRrGfIu0yYOFBDeErtAU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bXvhTaFYUJhzcsmvp1updAj04rnu4G4jxsat2lTyE/TknHkWNyC2WF/tuUMpEbjgk
	 6jwyS9UnaByWew1Tmna2TAmPP4OdekQa2+smVnpHZn48GYGLI//dGAfsFMhyisQEf4
	 fCapS4dzQCOrzAJQnrYsc/u6Y9Ng4ZXV0D3VmzvCC6bSKmgIHSofzG3k4w/FxdVa96
	 NhAlB1s98wiBBNgSBnUD5jjtw5Z1Ux2rqJKzcuXcmTeREuh8W3MmUWPLVvIoDhoeCA
	 QBuieThI1DKrX8EnKtWZuc2nnbjetNIS0T0PwwEn/5k7Dj3/a7FYBuoJu6d8mnBhg/
	 CYFvB1kFu/rFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7737A38119E1;
	Mon, 19 Oct 2026 09:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-af: Fix CQ enable state tracking after AQ
 writes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179240220517.2517745.4701100148658848957.git-patchwork-notify@kernel.org>
Date: Mon, 19 Oct 2026 09:30:05 +0000
References: <20261011125508.534618-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20261011125508.534618-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: sbhatta@marvell.com, gakula@marvell.com, sgoutham@marvell.com,
 rkannoth@marvell.com, skardach@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, alok.a.tiwarilinux@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 11 Oct 2026 05:54:59 -0700 you wrote:
> Use the CQ context's ena field when updating the CQ enable bitmap.
> The current code reads rq.ena, which overlaps bit 0 of the CQ base address
> and can leave the bitmap out of sync with the hardware context. This can
> cause enabled CQs to be skipped during teardown.
> 
> Use sq.ena for the SQ bitmap update as well, so each queue type reads
> its own context.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: Fix CQ enable state tracking after AQ writes
    https://git.kernel.org/netdev/net/c/07bd391eb957

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


