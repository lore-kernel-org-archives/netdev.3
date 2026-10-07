Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6083BAD92;
	Wed,  7 Oct 2026 23:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791415089; cv=none; b=lTo6nO53KEpMmcjUd/15xN1SkFEh054+UvqwjLxCTyrgxPAlV+SDoXIKSi+8snMOkHt3Vvcxa3nO2PahD6T6CX29eYL5Oxt0cH6B039vFfqVB+VYD+JvwLmjx6mslC5C4clCF9rFIf3ehdULfzEUYUIJAagUOdKXX66JQGdcdGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791415089; c=relaxed/simple;
	bh=RA4zVpydR71PURhkhkzdO8w7oL18NXaDV1LGYPkMzkI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kpidwQkGdRgrQ8N7SC5p00BoSbbltjuMAhsA73pz7E26pRNile9ThKXcKEBfbrbpnF3/DDjoWTg0FnYZlaTU5l6dPPCscf/JiSyb8oYg/H0e+VVr3bD5t20vVwtPwXjiSqCYqSacjDQ708vMH/X+PSYjTod/B2aD0q3mFZc2sNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOyfQY8M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOyfQY8M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5723A1F000FF;
	Wed,  7 Oct 2026 23:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791415087;
	bh=M36Ul7HENPj+ktWO112ZYZHlUQirv0nvRjuMYFR3gMg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TOyfQY8MitiANuLHMy/M0jmvSLg5SXCUNf0+AXuNRXcoC9Exou++bj8xh1rDC112z
	 Anc9+9bFOt5MWFuDor8kUbVbTgCVc47GAV4mAa6lQ7J66p3NSoE1gI33OwArYIHaIE
	 H3i0aMfoPh+HB/PhCte42QEKiGbCzuLk9kYO3w4WnaoLPHJPs1/dGxlOX21jSACG3Z
	 Qo3cCXJMXc89F4Jzn8zY8OMapKCeO8E2ITcjSEzGkCgjJKg9gjXL1h+ZvoO8xdJeEi
	 3vorsAzhwB4jifv4wjwcETVZN/UHocIpRJAbmjA/eIMX5YNeYYPL/NIQ0GxXxLv+hX
	 gLMi9ZfHdb8Ug==
Date: Wed, 7 Oct 2026 16:18:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Harald Welte
 <laforge@gnumonks.org>, Donald Hunter <donald.hunter@gmail.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, osmocom-net-gprs@lists.osmocom.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next] netlink: specs: add genetlink-legacy spec for
 GTP
Message-ID: <20261007161806.5fa99d43@kernel.org>
In-Reply-To: <20261001090250.3395779-1-anilkaushikwireless@gmail.com>
References: <20261001090250.3395779-1-anilkaushikwireless@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Oct 2026 09:02:50 +0000 Anil Kaushik wrote:
> The GTP (GPRS Tunnelling Protocol, user plane) generic netlink family
> has no YAML specification under Documentation/netlink/specs/, so it
> cannot be consumed by the ynl tooling used for user-space clients,
> documentation and selftests.
> 
> Add a genetlink-legacy spec describing the existing family: the PDP
> context management commands (NEWPDP, DELPDP, GETPDP) and the GTP-U echo
> request (ECHOREQ), the GTPA_* attribute set, and the "gtp" multicast
> group. The spec is derived directly from include/uapi/linux/gtp.h and
> the gtp_genl_policy / gtp_genl_ops tables in drivers/net/gtp.c; command
> and attribute values match the existing uapi one-to-one.
> 
> This only adds the description; there is no kernel code or uapi change.

Do you have any plans to use this?
Why send it as RFC and not PATCH?
