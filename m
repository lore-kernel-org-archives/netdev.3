Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33712FD1BF
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 21:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771365009; cv=none; b=KlV/wnyL4dUsO7xK7mMCUA3mIaTsMLB3aOeRxGPsGPUOthkeIlVwGUy+ILHj958iQR3qbiQ42yrsOanxJ5765ldO5XHi373lciOvLLbBtVsWTiDIC0MjrwS/q1plQkNac3CIAoczLueQEA6lBgpMwF3ggLQzn7vu4zAasvOm47o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771365009; c=relaxed/simple;
	bh=pvDZPoLzl55yumLqYP4PLy4xQzkiAuiTqZbKLIP8ny0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPYgeLXVttVmhircX0kHUxELOfEGlbGnK42DiC2eUUWzUsxAvJAGRHTv6NFXfltVlwAbXr2AiN4V32rCfRnThEWw6o3/pBCe97OnAUsRsbXS6gkiYSF6Nq254R8liE8c5lRIkviPoi1n+WfcnvGK+WsZI76ZXk3lX0eHPJgNA68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjJENHkI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjJENHkI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD2AC2BC9E;
	Tue, 17 Feb 2026 21:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771365009;
	bh=pvDZPoLzl55yumLqYP4PLy4xQzkiAuiTqZbKLIP8ny0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EjJENHkICMOQEUfGJtHfBsGzutK2mmgKF1Uby00PIc6IYiOgsEpFrlM2Bm+dklilC
	 fAMg8+0uYB35+0giIrIUHZVdvKHJKxpisMHRmw0XUYAh03+Mv6t18fmP2+/e2O3R8g
	 XHotOmu4yoRhxNAU/EDHRhJqIOBukDpDlr2l+aDar37XnolKeUOr4Xo4qFHL+mj7Qj
	 yx0W9SmU0TwRgdZNN+h0swTzTPzFqPMUWpVi5LnYzzqAIRb+OCdQvVMOpR5ilcOYLb
	 cDPz+tUvL8qRVytPBQcU843MSTiU+SPOT4/MmBQn/jsFJdbDfaixONvgGO5bUyt6zO
	 bXZ/G348j1fmg==
Date: Tue, 17 Feb 2026 13:50:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: kuniyu@google.com, ncardwell@google.com, netdev@vger.kernel.org,
 davem@davemloft.net, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org
Subject: Re: [PATCH net-next] tcp: try to defer / return acked skbs to
 originating CPU
Message-ID: <20260217135008.30561ad9@kernel.org>
In-Reply-To: <CANn89iLURfPA69TjXjdBJjbc+Ad8X8XO-fiDQp=Uc8J+0PU5JQ@mail.gmail.com>
References: <20260117164255.785751-1-kuba@kernel.org>
	<CANn89iKmuoXJtw4WZ0MRZE3WE-a-VtfTiWamSzXX0dx8pUcRqg@mail.gmail.com>
	<20260117150346.72265ac3@kernel.org>
	<CANn89iJ8+5OaWS2VzJqo4QVN6VY9zJvrJfP0TGRGv85mj09kjA@mail.gmail.com>
	<20260119090435.44b1da2d@kernel.org>
	<20260129150459.29419003@kernel.org>
	<CANn89i+P86WVVUY-4WppUAH1TGix1Z3KhgX9vSHok5nXqQAiHQ@mail.gmail.com>
	<20260216094936.5bf9d789@kernel.org>
	<CANn89iL+kzhRqwBr5wAcEBMdC_wbLFanHJ6VxS1r5ppGKUhftA@mail.gmail.com>
	<20260216101108.6b2319b2@kernel.org>
	<CANn89iLURfPA69TjXjdBJjbc+Ad8X8XO-fiDQp=Uc8J+0PU5JQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Feb 2026 19:16:46 +0100 Eric Dumazet wrote:
> UDP use of skb_attempt_defer_free() is  with RX skbs, and normally
> their zcopy status has been cleared ?

I meant coming in via napi_consume_skb() -> skb_attempt_defer_free().
There we are freeing Tx skbs, which for UDP these may legitimately 
have zc state. No?
