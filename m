Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE3E2C11FE
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 17:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771264178; cv=none; b=Tj3vDYotQlDvrQ/6xQM5sWHRJ6894IXgG84uKa+VQR8lT7Zku/St+GX8F8mbn2I87uP/5cmCrOnrHlgyI1etiiHxqRXAnFLseDMeWPA79hrId2RyqpnQZxLc0U216iBpwT52/3r3AVK1QaF781kzpda6OiXDiUby8dSp/9MwLZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771264178; c=relaxed/simple;
	bh=gHSsLqqRaSL8TX3IJWyBQUV9R16r8UuifjrO/qmk0N4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i2udJxOYOAUHppCfAfHDxsQ8npQ9I431JG8R9N5IpbFtBWrEj8jU6woAlThupZvHqROKQ+OyL/XuYvVRnXcOyo9/bYaAjLhIjvBD1E0yEpUs2F1M06wBlEpU/GR7rGJ0/5O5H/PllwbYT/mtIDzn7Dht7Vu7cj57RxfTysJCZPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szHFvUXy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szHFvUXy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8228C116C6;
	Mon, 16 Feb 2026 17:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771264178;
	bh=gHSsLqqRaSL8TX3IJWyBQUV9R16r8UuifjrO/qmk0N4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=szHFvUXymL8hFN/Qey0wJXWgMsyu2nniFZqgwg8D9H5UiD/UgGD3TAf94Mx6eyRqW
	 Y6QPb4Kxa7oVPP5qtfwASoVlnMb5B/k3gaHqDYb2Rl745TkMhMozAAxOlKyQSjR6/A
	 me9ZL5bpEy14WmemctVFyFEtmZsoo2Xi9cJ57dchpF5r8aku7xhx0YV9nOWrLjLiaI
	 DqnY54YRxRNmtrKi95fG82aLVySdytGe5dZ4/h8wp0FG0hwa1vO0AgUSQ54K3O3m3i
	 7MfShuI/8vH54OD26C/nA7BTPLTpWneEupscLMCkZywnQh/f6otpCauDgVaWDff8z0
	 JhCwt9Q+DBGdg==
Date: Mon, 16 Feb 2026 09:49:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: kuniyu@google.com, ncardwell@google.com, netdev@vger.kernel.org,
 davem@davemloft.net, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org
Subject: Re: [PATCH net-next] tcp: try to defer / return acked skbs to
 originating CPU
Message-ID: <20260216094936.5bf9d789@kernel.org>
In-Reply-To: <CANn89i+P86WVVUY-4WppUAH1TGix1Z3KhgX9vSHok5nXqQAiHQ@mail.gmail.com>
References: <20260117164255.785751-1-kuba@kernel.org>
	<CANn89iKmuoXJtw4WZ0MRZE3WE-a-VtfTiWamSzXX0dx8pUcRqg@mail.gmail.com>
	<20260117150346.72265ac3@kernel.org>
	<CANn89iJ8+5OaWS2VzJqo4QVN6VY9zJvrJfP0TGRGv85mj09kjA@mail.gmail.com>
	<20260119090435.44b1da2d@kernel.org>
	<20260129150459.29419003@kernel.org>
	<CANn89i+P86WVVUY-4WppUAH1TGix1Z3KhgX9vSHok5nXqQAiHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Feb 2026 17:06:58 +0100 Eric Dumazet wrote:
> > > Looks like selftests run into the zerocopy Tx latency issue.
> > > I'll drop this version from patchwork..  
> >
> > Delaying zero copy forever is a bit of an annoyance.
> > I believe the same thing can happen in net-next with UDP
> > but I haven't tested to confirm.
> >
> > I assume the attached patch is out of question since it came up before?  
> 
> I think I totally missed your email :/
> 
> What about not attempting defer for zero copy skbs ?
> 
> It turns out existing patch e20dfbad8aab ("net: fix napi_consume_skb()
> with alien skbs") is already a problem for zcopy.

We definitely need either this or the timer patch I attached, for UDP.

I put the TCP write side on a back burner because slab sheaves got
merged, I think skb defer free will still make a difference but IDK 
how much. Maybe juice will no longer be worth the squeeze?
