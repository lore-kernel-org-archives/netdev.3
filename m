Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A382F7F13;
	Thu, 13 Aug 2026 00:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786582265; cv=none; b=f71iwqwIsU27PAEHyRyKEYREgu+pWQBnyM3cXQ8N0k+XLx12mT0vs+6rfy4EurswsmPZSDc2JIi2JYKWksqQIaSmLnBqvILojUkELW2r/M1QbShAeec4qG/WzWeF8AXECCuc0xI38w/E1CEBF3b1QK+jqqyVE87T7/HvD0XWHLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786582265; c=relaxed/simple;
	bh=fKLVXUtrkP5Ig0F97Fa+4GmBPi+qzpRsavCtY1zSJfc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GBjtsBNkhKk87IFI+m6sDg0weC30tIyA4rBLhh02GW+oyCoNWzdHrKX0C6obpx4XSDyNvKT6J6AkmULoN1/f+5xH1vxtMfkV5fkjv8K7BPxNG7oYLER+E6yQDuV7QXgHXWurOHqY01ySMAF/CDK/stzU3ipyOPZ1ode/BDwnCH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCq9pPB1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCq9pPB1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0131F000E9;
	Thu, 13 Aug 2026 00:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786582263;
	bh=yirCD5X6JRo6FnvaQn8dOoocTC1WS5mRd3Z8F+DJEGI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lCq9pPB1LayH5HtbYkpt4oX+TiDhrC2ZJv8lbWaZJ7i7gw/4l82h1cydXjhWWHJpA
	 q+WYj4ve6Hg/HclNwhCB3+IQdvRfBtRePYCyn3PVkc6brvbQIyEQFMSlfGvhao9CEJ
	 7+6mayWRKkUtsbi9a4EJSlCHrpfiNe5Jt6/yZ1mGTYHcA1qIFNwI3A8N0Ow7IGVzmn
	 zCvSBSGGmpbaFetVsHP7EkJUW87yT2Qt7/bpQceb91yJDBk5+cHgxdQm5ausQf2ipE
	 fnvyt1qQr4pbN5nafhEJuG6wEB97q/VdibcN/shcIt3KjCJDQXwdlQCTpmU2gOG0Fm
	 O2lcfHXSZMAUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19913380CED0;
	Thu, 13 Aug 2026 00:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw-nuss: Fix port_id
 extraction
 from SRC TAG
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178658221863.2168272.12259674468445322692.git-patchwork-notify@kernel.org>
Date: Thu, 13 Aug 2026 00:50:18 +0000
References: <20260807111738.2055900-1-s-vadapalli@ti.com>
In-Reply-To: <20260807111738.2055900-1-s-vadapalli@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, c-vankar@ti.com, horms@kernel.org,
 vadim.fedorenko@linux.dev, v-singh1@ti.com, nm@ti.com,
 daniel.zahka@gmail.com, nora.schiffer@ew.tq-group.com, oss@vassilevski.com,
 grygorii.strashko@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 srk@ti.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 7 Aug 2026 16:47:37 +0530 you wrote:
> On the packet reception path, the ID of the MAC Port on which the packet
> was received, is embedded in the RX DMA Descriptor's metadata. The ID is
> extracted using the helper function cppi5_desc_get_tags_ids() which fills
> in the 16-bit Source Tag into the 'port_id' variable. However, it is only
> the lower 8-bits of the 16-bit Source Tag that represent the MAC Port ID,
> while the upper 8-bits are Hardware-Reserved and carry an arbitrary value.
> With the existing logic, sporadic kernel crash is observed due to the
> subsequent driver code accessing out-of-bound memory because of an invalid
> port_id.
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: ti: am65-cpsw-nuss: Fix port_id extraction from SRC TAG
    https://git.kernel.org/netdev/net/c/36a05d282007

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


