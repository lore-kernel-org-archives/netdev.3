Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350B647F796
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787246334; cv=none; b=AB9Ep8mG1CZYZqwuC/cFGITUyDp6k+uSLL9YGi5UU5KdKEdAdj5dhOqlscNl94HcNTQd5PT98lg1TZ1s5rf1nFTsX9wuZRmuKB+qAPJ/3V2vHIa2V70fxYPWpZw7adzteLHfJxGSOQxQYxx/WfIw27lfskmNAXRzaOMAjav8mZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787246334; c=relaxed/simple;
	bh=FLRTZnEDviijJzsjwddfvnyaqLbr2r1IukiSisfKzmc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cz6vfHqjcK863RNn/8Sd2i+++CNPNTkSiootYs103WkMrYAJ9mp/F0L4tK8QfFME4ySJn6Y3qVp+AmjpEIucnqEBCu2QraY0G/FREh8xYMral7pQoJlbjxY06ImaGwxaQ1BgLW5iFtLCg4p3qZNmb+YgmzSiVdS6evoqmVF5CuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXpT+79Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXpT+79Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BC51F00A3F;
	Thu, 20 Aug 2026 17:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787246332;
	bh=FLRTZnEDviijJzsjwddfvnyaqLbr2r1IukiSisfKzmc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eXpT+79Qr29I+auqIZyO6vPcyQMnyFicpz48SJ+z3e7S62QUWBZWfa+LNNUa2rmA2
	 Xyg0hWrYhs69ufEsGeCVW9YqyhoiwnfMf78sorTgRlDBULOrVBzgTZiMfumT4c1CJ7
	 c6Hu+go7sDDSNJv/b5w9sRXhvKTirixYauikD5ERsOGP3i2G0/arzYhiNH/7KROA2h
	 v5LrTOZy/S4Dzmnoq6HQ+tWC7nta/eNNVI1Gn7vr9u9NDUduh0oZac7UW0OaT96EDs
	 DnO3Onw2mYB2MwISBLiY3VCSbjr/PwhsYbAkSob8F71uS9Aw5Y+6PpiwPl2YHsJZvE
	 WVqk2MEMYpTag==
Date: Thu, 20 Aug 2026 10:18:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Pawlik <pawlik.dan@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, win847@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v8] net: airoha: npu: use cacheline-sized buffers for
 mailbox DMA
Message-ID: <20260820101851.0b4c284a@kernel.org>
In-Reply-To: <CALC2ApiCSY8DkVpd7puTssbJZMWBHGVtFCnG66fiK0PX7-u3Hw@mail.gmail.com>
References: <20260817090601.1256389-1-pawlik.dan@gmail.com>
	<20260817161756.5fd2185a@kernel.org>
	<CALC2Apj7rQv=6uUqaqBjfJ9yO+VCddQqHB=yDhXH7+QUCh2JyA@mail.gmail.com>
	<20260818082933.28b5c9d1@kernel.org>
	<CALC2Apj-KLB5CVbSvoZWvA4Oan7dmAerK=VP7W86jmErWW8OdQ@mail.gmail.com>
	<CALC2ApiCSY8DkVpd7puTssbJZMWBHGVtFCnG66fiK0PX7-u3Hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 10:20:08 +0200 Daniel Pawlik wrote:
> size=24 < cache_line=64 fails this regardless of address alignment.
> The swiotlb sync code itself is fine, but the NPU cannot DMA-write to
> the bounce buffer address range (it reads commands fine, never writes
> responses back). This is probably an EN7581 platform limitation.

Sure, that's pretty much what GPT told us some revisions ago.
The question is why.
