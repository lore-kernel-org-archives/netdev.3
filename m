Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1313B23741
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 23:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785973063; cv=none; b=C6Dsd+XvRtxoMZdXw/lbXPR/RqjexBb1cnGqxe0JkSSM2p1x+87XE1GLcQdjCX2pc/JX4zAvv6DbCMXh3VP9b85MfEwM+2cEn96bNWe1l8tbVxHzllnix5yahmRImtzkDlWLWiF7GuHrNd0ObGJQQlWzO2QzUjbn8uFT9BlM4ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785973063; c=relaxed/simple;
	bh=ASbxXyWAVQed13Lu2cdQ3Hd7KKmMDd3m11D7DfDiEQo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pnpvl5dV/sUNRv77TnonCdlP79idgW3Ju+9u1yVERgl2xV1aY6stwG4li43a9IQIimWt2R4G8iTq4ac0iQ0bO+xKBt9hk8Pzb2tAHlxzNhktVRtOrSjczxm9Sur6nmCnO/zTtCDH5QyavClaX8w7MlsfZa5/AheRG99CtxPX6bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhYE5NP2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhYE5NP2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D59A1F000E9;
	Wed,  5 Aug 2026 23:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785973061;
	bh=oWYpX6jr7zAUUaERvSchg0aRONrwDek1Jtfofbfukc0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FhYE5NP20Jn4lm9NiJP4hGTzCRow9YSzhcAUbAX3T2OP8OE+IWHuhsAGRmIYPZW6P
	 +FbT4awHqwEwfr9qEENEXOBT3UtE5x+LZXwUdYq/EuLv97AVzWIxl3F8ggz2MGGNik
	 PuviFjdvYmj8leTOZ7QbbFk9mMbHEspiVe5V7hNjZ7Lc23GKyleb+IyShKUxm6qq4u
	 BMHh+o10p+KXK3glFUkYgsYYaL9CeQgAF2j10ztqiPucdDz+b2IUy+PW9jLNaQWHdc
	 42LP89kOY945O6kXrSK/8yYRXbUOzIjuhTzRF91j0XVIa2t7WErIsWOaDDLs6fhU3o
	 q9QTLNqL7f88w==
Date: Wed, 5 Aug 2026 16:37:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: zhilinz@nebusec.ai, netdev@vger.kernel.org, dsahern@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, leone4fernando@gmail.com, vega@nebusec.ai
Subject: Re: [PATCH net v3 1/1] ipmr: only copy pktinfo to cache reports
Message-ID: <20260805163740.3f921dee@kernel.org>
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

Orthogonal but do you wait for Clashiko (netdev-ai) before posting 
the review? If you do I'll assume you already screened it going forward?
