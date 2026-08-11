Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0931242B736
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448451; cv=none; b=Nqm0Ds+CY9RrwO/5RXoaVT1R61N3aREnNy97Dr2D4mMkxnky6m4BpOf2LBBCjXHaNyNT5pqjwPjSkcvAHHpnMFDm3s4R2ZI1sHIUJgW9JZJw5aSfQRNaxkdVvTWo5OEUX4kiGGiOZnzogBoAdUDCZAYfB+dp/mnsT1w1VzXcnnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448451; c=relaxed/simple;
	bh=jVtT1y9c3mH/4qXTZja64Bu1z/Mw/g3jHlYyzdX+bBI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UTHXoa16LrirRsuDd1NQeMTsZEfWzpnXrsD2ioCzHD1IVejSkJsU25CIfVloh8dh0eI6HxdRWMQ8zSEleAUV69O7l9VocKe3ZUmiLCRy8yuic8QVPaR7joNTfHlMb0kh+6eXXdlusCT/vmUWLouE2TVphvNppXVZAqn+TpYptDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4806XNH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4806XNH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69021F000E9;
	Tue, 11 Aug 2026 11:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786448449;
	bh=MbgJFZa+D4SqK0Yz87FYjrYdk+E5CVUHiFPrH+4t54Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=P4806XNHQzbJamBojol5d+IYlqJ/93JFUuQT1uEiRN2b1nTWM+5taUE6IySAe4F6e
	 Jhzz6wWnED15UJNOD92QDnFozT7/2n//nj4cCbPxbsgWiCnsc+oyZ+/8DeC6bKP8qK
	 X+maTpa2L8sOw7EZ52i5i4B3JS2A4MXNamF40rr/rsH+D8mDovJmmRit2/vGSZbQn7
	 9u7tDEFHuxSLnXtVG98v78DzTsBooAyQ0hEWSIgXGpkzA+iDpxgtecGtEd+4QbHmAv
	 4m5Zdd7blZxfrDOmRZMJqddDqf2Ee7mqeheY4SjydPTtrDBVlrrhbDfxwvQOIdhBTD
	 7Wo/s7wuk1ofw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198BB380DBCF;
	Tue, 11 Aug 2026 11:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: ngbe: fix NULL pointer dereference in
 non-MSI-X
 interrupt enabling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178644840589.486052.17588417592857890356.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 11:40:05 +0000
References: <B2693E9A8BFAD110+20260807062214.410838-1-jiawenwu@trustnetic.com>
In-Reply-To: 
 <B2693E9A8BFAD110+20260807062214.410838-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 aleksandr.loktionov@intel.com, weirongguang@kylinos.cn,
 u.kleine-koenig@baylibre.com, larysa.zaremba@intel.com, leitao@debian.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  7 Aug 2026 14:22:14 +0800 you wrote:
> In non-MSI-X mode (such as legacy INTx or single MSI), wx->msix_entry is
> not allocated or initialized. Calling NGBE_INTR_MISC(wx) dereferences
> wx->msix_entry->entry, leading to a NULL pointer dereference crash.
> 
> This issue was introduced by fixing the IRQ vector when the number of
> VFs is 7. Fix the issue by explicitly checking `pdev->msix_enabled` to
> determine the correct vector index.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: ngbe: fix NULL pointer dereference in non-MSI-X interrupt enabling
    https://git.kernel.org/netdev/net/c/5f3a13e0bb5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


