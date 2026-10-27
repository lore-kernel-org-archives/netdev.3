Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793137096;
	b=DhsqYr2VmOTurbqiabetqEeqpphQNPak+UHhIEQ3EkfgAascnivuOf4SLKxZmb72MQVm
	 ohVxngkAtzBKrqE3PYiQv4SNXWt6HhPucRiU1R3GbAoOhcbnvdAZiXftxqDkug/D49rgA
	 g1APP9Qe0W3hAsPm7ncieEANDuh6xxSJqCNo7ZY62bkso4Y/OT7RIwzrlvdMvsAhB1ezA
	 iUZVkA5sd6/dh+m8Uv9uQLpnsiqsoLBrBiXMVDk82rz5kyqCDhwBd3xO//xeg+rN7g9Op
	 Wz+3Ohk48MnfJS9jey/rj7bBgL5+ezn0OZKbRwmcJeZ3psyaUcbnr/ouU5aeooVC0BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793137096;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PqWOiY9VRjCy+ga6/7GbQl1u6l3t01EavkGObI2f+Ig=;
	b=Jt9/3KZmcKu+GA3waCl4B25/XQtcsJ/gceWIOnwLZxa5VgyVs3pHkGq8s0hKOoIqR7U3
	 SKJ8lJ2isV2G1A7B0xvAUTyBWJjN5gCeZ/jLB8vakmQ6/YqeHLuGnR6U1vLMO7zisOaTQ
	 1074bL+/mz4g0cx+HdUSSuAwQrgcG1SrCnByOo0je8xTOSLcq0MYIS78LXJOrmQCsDk4K
	 yRDsvBvwziS+85KupE6G7kJ+mOURDIS5yNmqb9EUtdhAyvx9xGDRf2z/JnQIeECyTGanB
	 jR2A3SJxrgIW80FFmZ2iVE08dpG/T2jy8hXHy8gPB0YaWSTHqgvwnxAY23x3AnozfNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZMSvuu8R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E06606A31A;
	Tue, 27 Oct 2026 21:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZMSvuu8R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD321F01825;
	Tue, 27 Oct 2026 21:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793137095;
	bh=PqWOiY9VRjCy+ga6/7GbQl1u6l3t01EavkGObI2f+Ig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZMSvuu8RHqJWTLlwmAHIawhTchfRw3MS1sXHlShygeuzsGQaRk+MN989eI4yq7umH
	 2ZOPo6NYGU4vEz8qJ+41hTqUNkMhDkEwhnYBw2LtDwQgnZcHm42E/jf+lmChXecF6+
	 BxDILkBYLK6Ao1VYiZB0Eowh4S8P82/nLrrMnbDxmlx89Ew9KeWulkEoPaRTK7x1o1
	 wlKXzc1+zACJO2ncRqt9gu9mteHISBHiYDVWgBWARsFmUQxCUvrW4WT1tq6EOmtomH
	 9dDAU5OoMnaI/z0hL38HmNwT5C+BOGbNDKPLFcQdtwosCDFKMXNXAo3V+rlLspU/TT
	 Jre28PuVkBwug==
Date: Tue, 27 Oct 2026 14:38:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Ido Schimmel <idosch@nvidia.com>, Gabriel Goller <g.goller@proxmox.com>,
 David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv6: Add NETCONFA_FORCE_FORWARDING to netconf
 messages
Message-ID: <20261027143814.335587dd@kernel.org>
In-Reply-To: <at7JgfsvrAUxtPzy@fedora>
References: <20261023-ipv6_add_netconfa-v1-1-94d14b07d621@proxmox.com>
	<20261025131102.GA184152@shredder>
	<at7JgfsvrAUxtPzy@fedora>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Oct 2026 11:31:13 +0800 Hangbin Liu wrote:
> > This seems to fall under the "Not a regression, not critical" category
> > [1], so can wait for net-next.  

Agreed.

I think this is more of a "missing functionality is not a bug", even.

> One question about this rule. For "not critical" fixes, should I make that
> judgment myself and post to net-next? Or should I send them to net and let
> the maintainers decide whether the fix should go into net or net-next?

Post fixes for net, let maintainers decide.
