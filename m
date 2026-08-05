Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1609423741
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 23:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785972987; cv=none; b=YuE4gNwqJFBjJGj1NZNNLTcAbTrKXBgEbYqDu+GqK5NbMoqgcyBeOI/FOjGKmI6i7mZK9vdkauAB+/5keBG7UyVa8VP8nuzbGNSTN8Wrtt6/HaANix4wcTr4kFt0DG1zKKaQ14qWC3EQv5+DlV38lPId1Cz5NymQ8csu7MCca/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785972987; c=relaxed/simple;
	bh=zKd9yRXQ6Hdu5/M2QoZnI+z1t3TUs9iqBEO3RjoBBU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AoPgYgw9rb7XXuVkIWKjUCzxTOWno0fORQJmeJxvo/r3DUA5Mjdvt/lxwzs97JH2rxbFJqwMhWfiyW3/Vl0irlXTaXoHFnwE4nFMSFhtebqlYrcajb0rfouB8FH3g7E3Wi1aKdClieHmGh1onNMI9k1bf0GH7xqPkCTF+CGSb5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7HfgT8S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7HfgT8S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F211F000E9;
	Wed,  5 Aug 2026 23:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785972985;
	bh=rKnPZnCdvA55CkUcZosKmxc3aEoCxrgaY8BJBsxJuPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N7HfgT8S6fF9yYrqRHXg4h5kLlskaNeHS++IHeOiPHAIL/GS0DuYkMsfm6gZLChLQ
	 k86tvLHl0d2VDpdkeG4Z4TaOg1H3ksPsJqvDkri0DLsIzdLVwKD0Ak3mSe7DGXp/PT
	 FFjXddYjatW/CrYiACh+dEH/L6WmCky5A7EtRPDZBW1YgjvTRRcJpoTG+LcX46XlZS
	 f8946cHTjBVgiaVD+/Fk19jFJK3tnt2lLyntRqED+bNZFxdMLChQEB2d5sZub7FXB3
	 dLIZZ8VyhvDnUxjZCvKEcfjRgffj7hoxhL/kedwuMyuh4UwdzBqHOvtAHif8LVLbqC
	 +R8BOTgT6T2yA==
Date: Wed, 5 Aug 2026 16:36:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: zhilinz@nebusec.ai, netdev@vger.kernel.org, dsahern@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, leone4fernando@gmail.com, vega@nebusec.ai
Subject: Re: [PATCH net v3 1/1] ipmr: only copy pktinfo to cache reports
Message-ID: <20260805163624.312b4df7@kernel.org>
In-Reply-To: <20260805081737.GA1284302@shredder>
References: <e93d0d2fa5725ddd06b20e3e4223ab68b93b48d1.1785719031.git.zhilinz@nebusec.ai>
	<20260805013126.4161847-1-kuba@kernel.org>
	<20260805081737.GA1284302@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Aug 2026 11:17:37 +0300 Ido Schimmel wrote:
> On Tue, Aug 04, 2026 at 06:31:26PM -0700, Jakub Kicinski wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email says "Looks legit, let's fix both in one patch?"  
> 
> I suggested [1], but the bug in the IGMPMSG_WHOLEPKT /
> IGMPMSG_WRVIFWHOLE branch needs a different Fixes tag (it precedes
> bb7403655b3c) and Sashiko [2][3] found another bug in this code:
> 
> ipv4_pktinfo_prepare() modifies the control block of 'pkt', which can
> result in this packet being processed incorrectly after
> ipmr_cache_report() returns. I *think* that [4] takes care of it, but
> all of this needs to be explained in the commit message which should
> carry the appropriate Fixes tags (bb7403655b3c + 1da177e4c3f4).

TBH no strong preference on the geometry of the patches (could also 
be two fixes in a series I guess?)  It'd be great if we could start
grouping the sufficiently similar fixes a little bit more. Otherwise
it's increasingly hard to make sense of the patch queue for me, if
nothing else.

> Note that this upcall is not fast path, so the extra work shouldn't be a
> problem.
> 
> Is this what you prefer?

diff looks good at a glance..
