Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E2643D51E;
	Thu, 17 Sep 2026 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633886; cv=none; b=UHdxhFZxv1+QVAhzWAeUPCYlO9wGCF7t0XLD60yMoQWMzEFfRqrYuyMIYI0xqR22sdBP8tFfW1nvr1dYWFsNQrWhOYtZv0QNiT2CZBa8TC/DiVIjmsVPNhsKgVz2er0ZiMx4S4NbT+3gVDgC+H4FN9d4bf9iWXZui3ltLaNJPSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633886; c=relaxed/simple;
	bh=sZgkRwiRrlqYyrfJRMGp3n0c5/aSEtnD8nXpMVOL6gU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T+caDJt7c1TnlOU4kTZfp/A0ndCqHcaMmQODLgIaJmUSimebjutnQ6tjxgOppG0tklhZWIpF4SkvOt3DPv7GR0/ZIgoimaoTFLGDgSrpLEFfAf06X0j+H6FV0VMJtoRqqsIyb2AIYP4JF6ACFhpOu7ZoQV7H1hJl5PzeeQPWF9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcTU/q7R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcTU/q7R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B731F00898;
	Thu, 17 Sep 2026 08:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789633870;
	bh=LO9eaufMm0duk8wGY4ihfDIzUgYxdIMkz6Fmb6I1oSE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fcTU/q7RIlFTHV3pFT2K65KSjMm5NJG3KeZ+tZCez/13nwMjXCT5gwW9wGtXwlvJd
	 FqXBZBRtexw++vnpEEmmUeoSa/VUDaAdDxennNWOG9CKP/Et8dRC39Oac/L27kh9Op
	 z0siz+kDI+bJHA3ViwI3aKCdtgOddfYAXZdDPEpdHdGWydW7lN1n8juimcSuRn9UWz
	 r1e5noqygU2uv/97R16HBE4TZEvo63HosOvEYm+guGH2srl5Wiys8oAbSiCIkw2Zh9
	 grRX8/SzsZOrjo4oIkK0UPxcm9M65rGyotFo+ucr+VSnViJ3bCms/NuaoE/N756cZs
	 ZTEvFVLo1mOqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A60380CFEC;
	Thu, 17 Sep 2026 08:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] ppp_synctty: Use common error handling code
 in
 ppp_sync_txmunge()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178963380438.3497657.12392153187415676873.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 08:30:04 +0000
References: <15f151c7-58c8-4116-8a03-e985fd132b0f@web.de>
In-Reply-To: <15f151c7-58c8-4116-8a03-e985fd132b0f@web.de>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-ppp@vger.kernel.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 jirislaby@kernel.org, pabeni@redhat.com, qingfang.deng@linux.dev,
 tparkin@katalix.com, linux-kernel@vger.kernel.org, kees@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 15 Sep 2026 11:23:01 +0200 you wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 15 Sep 2026 10:48:11 +0200
> 
> Use an additional label so that a bit of exception handling can be better
> reused at the end of this function implementation.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> 
> [...]

Here is the summary with links:
  - [v2,net-next] ppp_synctty: Use common error handling code in ppp_sync_txmunge()
    https://git.kernel.org/netdev/net-next/c/063510768490

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


