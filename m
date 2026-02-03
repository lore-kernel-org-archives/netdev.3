Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963732F3608
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 02:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770085256; cv=none; b=UqJ57On/bc2fr+jxmK44atoUtB3BylyEXIy9CfBAsPA4v4Wl3kxp3h8TVUaAWSDdK/KhgQGAivNiA6EtTYPvBUjRcndaSAggW+eFQkn/jUwAQq299e1lmlDZ1qbL6Smuc+B7x0xuNcnaGkDJvFokktNqfVrff98/CF7SJAAWgII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770085256; c=relaxed/simple;
	bh=xymFwFpJdFhDLLlEMBm1kLd8cDzjnY7GN2CpPvbJg1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d650t5JPyYcLAI6ZF/YUC3hy0Mtko4opLA7NhkZercg5Sx0LuUTe+pLb3FwiSBQakQCTe5Zh2RMQPlFuFMZZ4Q4DL+pJKVLynOU50pH0wgLOaw/GFuU0/bqurfx4eQ57dJTsvDitYyGwK+gxFLvhrVq07UYlP5Hja5YFN70hRbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HifA20UV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HifA20UV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F55C2BC86;
	Tue,  3 Feb 2026 02:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770085256;
	bh=xymFwFpJdFhDLLlEMBm1kLd8cDzjnY7GN2CpPvbJg1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HifA20UVBMCmWTSZVgmsE8IksS/j3bGxAkbJbLUZ6Yzts7dTDIxL19t6wXzQDSHIp
	 0VMhx95yt7IjtBna9ZFh1/ja4ycmcM/Av/sMBxE+DiBszAmpRihCdFScpjH+yfUtYK
	 eKI1vNHG5i40SKPRXMouGsFdvEyM4CPzZNfXiu0f/5dwy4og94NX54QaXlMF58Smu0
	 +zlJzdfdgeT1ROoQcEbi44Y58Gk2bmhoaPCdUwQDTdNTMe5IOtiLj34F9DLK77kRw0
	 HCFlLcORC3wY2bcPllpcvBbthLMMmAKozPHOVvt6+p384zY9qEQU5BQcqX3a21I4qz
	 wB+/zmPzZyoLA==
Date: Mon, 2 Feb 2026 18:20:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, Don Fry <pcnet32@frontier.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] net: ethernet: pcnet32: remove VLB support
Message-ID: <20260202182054.0a755aea@kernel.org>
In-Reply-To: <20260131012119.25863-1-enelsonmoore@gmail.com>
References: <20260131012119.25863-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2026 17:21:19 -0800 Ethan Nelson-Moore wrote:
> The VLB bus is very obsolete and last appeared on P5 Pentium-era
> hardware. Support for it has been removed from other drivers, and it is
> highly unlikely anyone is using it with modern Linux kernels. The VLB
> auto-probing code also has the potential to affect other devices that
> use the same I/O ports in unexpected ways. Remove support for VLB cards
> from the driver. This allows the code managing device instances to be
> simplified significantly.

Unless the maintainers acks this I think we should just wait until 
we can delete this driver completely. Unless this unblocks removal
of some VLB-related APIs (which I wasn't able to spot..)
-- 

pw-bot: reject
