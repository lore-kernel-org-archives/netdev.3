Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398D12FD1DA
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 20:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771619895; cv=none; b=MVDN+w+w6HAb8s9o9XEyWRnzlHz+DV1GvgWP8pn36dsNe9MltxvAoRU6nA3Z1wCNwg3L7COfLFiqE5rgMSEzrbkSpMXGIWrQ3P+Ml6s76M3HEL3De86XyaR2WpZn06kq6kTwDnGXpryzk5QnmtGAbG8gLbiQNdKOUX7cS8m+Qro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771619895; c=relaxed/simple;
	bh=YkeUmJE5VCgB+/8w/kNuLw08/jxthUEWqf0pcnkt7Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VtAYt51BFJHQgcHBn3gK6IphlY/T/j568Sy8+wi3odERV0gcMoDbpNuLG9QSRc5tUfHPL+U8FuxJVJRmcwqRvulejsg+1i5SW30bD8hOOOBFbhW5LgRN8DGdQveTJiBSwduPjvPuRMEsgiGQvXA8tTccKcswaHsF+4jp4Ki9TQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVeBlxwu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVeBlxwu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7D9C116C6;
	Fri, 20 Feb 2026 20:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771619894;
	bh=YkeUmJE5VCgB+/8w/kNuLw08/jxthUEWqf0pcnkt7Iw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sVeBlxwuYPKMYlbDKYgy0GxImyJyTCgi4neui8y09/xveCbg22SD758KHzUDD7z6N
	 D1LlWobBt1KU7Wa9bmHSI2IIzw7wuTK8qyJ90mnBHiA04gBcIz8hrdx35YxZkC2MqF
	 jwgTtALy0yJdFsVdJlYZjvSnXsZ/ho5IwLwkzFkZJu55KPHBrBRCwKCiu6Bs79y5B4
	 zj1anQKJ1FeyzByBShIAszsD+WKBSbvOLN7QBQqGI/vD87IxAZsBgPm6ow9UZY2S1B
	 0r0096DuTV99nCweGeEvSnvIDDDMr2WPWRofgss+7TQt+xzy3I8l5gXDEZxfdAN6fU
	 IJ7wOmj1V1BuA==
Date: Fri, 20 Feb 2026 12:38:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: "Nikhil P. Rao" <nikhil.rao@amd.com>, <netdev@vger.kernel.org>,
 <magnus.karlsson@intel.com>, <sdf@fomichev.me>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
 <kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v4 2/2] xsk: Fix zero-copy AF_XDP fragment drop
Message-ID: <20260220123813.61780c4f@kernel.org>
In-Reply-To: <aZhVdcTDceAlhLvV@boxer>
References: <20260217211019.48280-1-nikhil.rao@amd.com>
	<20260217211019.48280-3-nikhil.rao@amd.com>
	<20260219145529.42b177d3@kernel.org>
	<aZhVdcTDceAlhLvV@boxer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Feb 2026 13:37:09 +0100 Maciej Fijalkowski wrote:
> > Personal preference perhaps but removing error checking always
> > gives me pause. Maybe:
> > 
> > 	bool frag_fail;
> > 
> > 	frag_fail = __xsk_rcv_zc(xs, xskb, len, contd);
> > 	list_for_each...
> > 		...
> > 		frag_fail |= __xsk_rcv_zc(xs, xskb, len, contd);
> > 	DEBUG_NET_WARN_ON_ONCE(frag_fail);  
> 
> error checking can be actually skipped as xskq_prod_nb_free() peeked into
> xsk rx queue and told us there is enough space for descriptor production.

Understood. I was wondering whether the assert / DEBUG_NET.. may still
be worth keeping but up to you.

> Nikhil, I also see you routed the set to 'net' tree, previously xsk core
> was handled via bpf/bpf-next.

Dunno... We had mixed results, I think net / net-next is fine for stuff
that's purely packet movement. There is no BPF dependency here..
Unless you have a reason! I'm not feeling strongly. Just the stuff we
were fixing recently made me wonder if this code is getting sufficient
networking eyes..
