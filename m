Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C217D3B42FB
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 23:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780703000; cv=none; b=aY8WMXYEyfjSAFkI//UfBfVyMpdzIzgqAS+No72R1SC0ScmwHfHJZFLMoxccQDWvOJdL4wCXYFGb18qzGXh76iaW+TB4A4N4j2Afv1QG38vWmqF57fKOD6khGfKVYQauN2gnSKOu+S9sKAj2c+uGc8yRtroOVsotyh0vI9TgxUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780703000; c=relaxed/simple;
	bh=UMmaAY51oAGuQW93dfYJ/TQb6jQ5YkEz7jUeN5xl8Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXtIxMQAnbPVvHLxtkOV35p21LpJ1xGzItV8cWF03bvq2BalK0SkCn+6KPcXc1zwPsTxfG0n+GFi1SOrbvlle3BmVCTMGFWv1uvu4mOluELEHsFUlThyJsAO0fftYp9+pc7uOJRU8T9aDQk5naXs6ri7JVQYtnsv29SvSmfKez4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ol/pozvI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ol/pozvI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EA11F00893;
	Fri,  5 Jun 2026 23:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780702999;
	bh=UMmaAY51oAGuQW93dfYJ/TQb6jQ5YkEz7jUeN5xl8Tg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ol/pozvI1QdQ9wBvJCAmSSqxzZSu5g/5MlgmQa2IYajj+teeZDev/cK/E1zaMKT3Z
	 9or0wcA/2N2DANsJ/604GD5Cyi/3ob5CgRFL2lQg/KS0PR0i4+JHyau0YR1qiiP6du
	 d5r+Z3YWjlJdmuTi1vXzsyiZ6umY7zNqsSSU2RgBNsIy1e/l9PCYYKQFvlgsdXOaU1
	 BJCSjOZkkyzbEHAoIhIibCwncDw+y3HOqvc5NYak6A/Gj7DwK+S4TrUH8ZrKDa0xOq
	 EDvrrpgovEgWqLCLhmHZ27BgADFoZWnu0UHrrRZpH07OAeASsVsEcpqIT3FHXERMCF
	 fV3dXmiB90hxQ==
Date: Fri, 5 Jun 2026 16:43:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alice Mikityanska <alice@isovalent.com>
Cc: alice.kernel@fastmail.im, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, lucien.xin@gmail.com,
 willemdebruijn.kernel@gmail.com, willemb@google.com, dsahern@kernel.org,
 razor@blackwall.org, shuah@kernel.org, stfomichev@gmail.com,
 andrew+netdev@lunn.ch, horms@kernel.org, fw@strlen.de,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6 05/11] udp: Support gro_ipv4_max_size >
 65536
Message-ID: <20260605164316.366304d5@kernel.org>
In-Reply-To: <CAD0BsJVydUv30m+35nzbmdCcAx=PdW5ahH2iW6BhUyT+y-e=2A@mail.gmail.com>
References: <20260602093931.516281-6-alice.kernel@fastmail.im>
	<20260605023712.3627277-1-kuba@kernel.org>
	<CAD0BsJVydUv30m+35nzbmdCcAx=PdW5ahH2iW6BhUyT+y-e=2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jun 2026 12:30:55 +0200 Alice Mikityanska wrote:
> OK, so it can see that it's handled in a follow-up patch. I can swap
> them, so that the fix comes before the uh->len = 0 change. Would it
> solve the issue?

It's alright sorry, I think I just glanced at the report and whether
the series touches up conntrack. Should have read until the end :/
