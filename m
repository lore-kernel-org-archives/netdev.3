Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1D739AD33;
	Mon, 20 Jul 2026 23:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784589920; cv=none; b=GBAIZGfO8wAimJui0cLo9xtjItFnym1/Q1Ll19yzjRBkA1eYUGJ8/Gf/Q9b8ko1dqIMQgVkN8SpddoHMGWcqApkcT/yFGVCn18lKLTWjqGlHB/Abhpza/AvOfOCk9Pz5APXiLKKsVTjsD2kwSEok0SephtH81x6eJMq62cxQdAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784589920; c=relaxed/simple;
	bh=/Y10i3wozkMnf60Wkl3yCC4igU9YXIYYPPeobwa3GDI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mltefJmGKyFvXhcqtehWpsvLbceUZ7t9rCHPwb0na7HYzAcbvAXS+bnirNk9X8gCnNmwoFbqntBHjfuQvlfJ0TmfSk0H5ey7sDxXu59y0a28RIrx3Fa9Even86UZOsUXTufN1X2q0H74IuCaYyjyLltk59I66jj7HZgzhoeBR0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hacxyw3L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hacxyw3L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E851F000E9;
	Mon, 20 Jul 2026 23:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784589919;
	bh=jgMSOwocUwqAdnPA+okL7WtufVXOcE4kTmboHQVEvnw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Hacxyw3LHN/3dDFBy5YcmUJu740ha98pSzZoBPyAurnGhlpK+Yf5hYZXIHdSvl9v2
	 OGflHt9SJn5SUE/6kCsFfVpXuHziTv/9XslkrifV7R/1BFSIdWrh0nitWz741YMIpB
	 ggm4nOR8ubWjbuQ9v0GDuudtgI93f+vvSLtepQV4fA4SGAHfIHiKqmJY64GMG39qIe
	 vXLjtpkh3ipgb1ZrqPS57ZvcyjzAB+TcDDquLiU737iztaanbH8OhEBmlnEOy18983
	 8eNcmczNiNTRzqrHEICFSKE1UYpfRaJe0abtJRvPAyN9jBdC4ihgXM7FJU35hGOi7p
	 9YXXYANhmXvzw==
Date: Mon, 20 Jul 2026 16:25:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jemmy Wong <jemmywong512@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org
Subject: Re: [RESEND PATCH] net/core: consolidate RPS dispatch into
 netif_rps() helpers
Message-ID: <20260720162518.38414fa0@kernel.org>
In-Reply-To: <20260707154855.12134-1-jemmywong512@gmail.com>
References: <20260702152830.39065-1-jemmywong512@gmail.com>
	<20260707154855.12134-1-jemmywong512@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Jul 2026 23:48:55 +0800 Jemmy Wong wrote:
> The RPS steering logic in netif_rx_internal(), netif_receive_skb_internal()
> and netif_receive_skb_list_internal() was open-coded three times, each with
> its own #ifdef CONFIG_RPS block and manual rcu_read_lock()/unlock() pairs.
> 
> Factor it into two helpers, netif_rps() for the single-skb path and
> netif_rps_list() for the list path, and switch the callers to
> guard(rcu)/scoped_guard(rcu). A new internal NET_RX_UNHANDLED sentinel lets
> a helper report "RPS did not take this skb" so the caller falls back to the
> local enqueue / __netif_receive_skb() path; it never escapes to callers.
> 
> netif_rps_list() keeps the early static_branch_unlikely(&rps_needed) bail
> out so the list is not needlessly walked and re-spliced when RPS is
> compiled in but disabled.
> 
> No functional change intended.

You haven't read Paolo's reply, please go away.
