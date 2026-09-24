Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C983BB57
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 00:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790208099; cv=none; b=oVwJTWOzN2XS4WrLrmtPGkLDjuX1dqiTeVP+EHiQW7uU6v7r6hArBVdvdIynNgBrO72Oxzb2MkEvP+yde48ADGFvGepKmoK/J8JAHLspYAMtihUtnLxZP2WNuVAfBBHR6rkmjC4NVAlXtcWWV/ADLfjwC5ZpPfo3pS0CzYMSO4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790208099; c=relaxed/simple;
	bh=RMOAo7nJ9Le+hYUYXELrGccpYEOe9s5U/ZxHmlDlDSg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EnG3NvkSyvE8+LTL3IwW200DTHKORXCdbB/KL3IAjokyMwrbyYzmaiXIKFqMoR+QNPeqjL8+zpzijuzG5sJ/+77enK0ABbHBU6x2VHfGsdyBGgRYamSv6o95b5gF5QaCj5cGuvoJstOvXwvi1rkKWuePuv+YfwSoAiIF76KYHC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMVrTb4G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMVrTb4G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69A51F000FF;
	Thu, 24 Sep 2026 00:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790208098;
	bh=RMOAo7nJ9Le+hYUYXELrGccpYEOe9s5U/ZxHmlDlDSg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XMVrTb4GucGRwfbmR0I6FlZFD0sqfahhDaqPCj/1vdDN3NbvzgG+xHHv4Agv2Z3xa
	 uMZ0toAxe9v+G4NkFJXGOI9hkiXlB8NECg+X7dMYGpgfedQKMOM8l4n+PM1m7XLEV+
	 3khKCEaPOP7cYVFKaOrG9bWlJDGrf7wve6tU70azorpb9adlevgPKWzZZfmNi36FBd
	 J6OhEjd1WkzNCpVlQbtQTG9sTfJgU/3pBxYVWlGKCXnsFNgXSffO0Ze7FnafmrItmC
	 gxzjw99wtosx4+zvtecVii9avs1ScCs0TqgF2NZSWcxZEde9HuC9PwL0tGgXYyAub6
	 TyxWQTVMGBAFQ==
Date: Wed, 23 Sep 2026 17:01:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: netdev-bot+sashiko@kernel.org, maxime.chevallier@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 daniel@riscstar.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, dcaratti@redhat.com
Subject: Re: [PATCH net-next] net: stmmac: add tc-mqprio qdisc offload
Message-ID: <20260923170137.3380f176@kernel.org>
In-Reply-To: <arQEUBOpXLhLt_Ln@lore-desk>
References: <20260918-stmmac-mqprio-prio-offload-v1-1-5328157fcb58@oss.qualcomm.com>
	<179007733391.2160803.15760096543003194202@kernel.org>
	<arQEUBOpXLhLt_Ln@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 18:54:40 +0200 Lorenzo Bianconi wrote:
> I guess we should just forbid this configuration in order to keep dts and tc
> paths aligned. What do you think?

Are you asking the bot? :)
IMO rejecting ambiguous||contradictory configs is a good idea.
