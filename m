Received: from mta0.migadu.com (out-121.mta0.migadu.com [91.218.175.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E63385D7C
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 08:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337571; cv=none; b=DPEtGf3vgm+Z+t1YkyMc4QCANbgRMx8yTyU7rCrAL+4QP6ok0u/ncE/4p6+XOx+d+CCQSALFEUrB2i//QhBfu52NDlCKp0l5lBUV87elbj5797mP0LgTCV9p7qrCqrKkXtY9GAbt49fuCBu7Sd8xX4X+IwDdn2+hRf3NLWPoFXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337571; c=relaxed/simple;
	bh=1ABJDsizdbUcsTFjmjqXc7Om99Oc5ojiy8GHmxNb4As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaTRciBCYEO6AoLOY/6N06WgaWY5h+YTkb1NR8FeWbEtlV5n0KpAK3GyZtoqIIx60xGUN8TXldslfHzGmSMADxd4d+IEhyxcUV7rnsx5THe6FojZDtpu/042gHpRnTaLWLjdh2fPPNOXS3mlGVoAPIL7xx0JP7HpTEdFMHivk68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y42s2UIX; arc=none smtp.client-ip=91.218.175.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y42s2UIX"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1ABJDsizdbUcsTFjmjqXc7Om99Oc5ojiy8GHmxNb4As=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788337568; v=1; x=1788942368;
 b=Y42s2UIXf7JixuWET/opY/YOISsp76Z93AkxS1iLk/4BWAtxcdvSv45/q/kPvFn9SVjezgIM
 1gqvpmrNlMCcZOR+uYmqZ0QHpxbpJ1F8p/kjZZbSjRAhNyGhTkI7UZTjbsL0Df4IcTQj15dSCu8
 8cw73ox/60zTnqXT6CmUKcNk=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e46753c69547a79b;
	Wed, 02 Sep 2026 08:26:07 +0000
X-Mizu-Trace-ID: e46753c69547a79b
X-Migadu-Flow: FLOW_OUT
Date: Wed, 2 Sep 2026 16:25:59 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jussi Maki <joamaki@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH net] bonding: fix slave_cnt leak on XDP error paths
Message-ID: <apfdl4YtJQiqtJoC@fedora>
References: <20260902-bond_slave_cnt-v1-1-36e95bf4a6ff@kylinos.cn>
 <a85105b2-a576-4702-a9fb-3d17ddf4d2a7@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a85105b2-a576-4702-a9fb-3d17ddf4d2a7@blackwall.org>

On Wed, Sep 02, 2026 at 10:31:41AM +0300, Nikolay Aleksandrov wrote:
> On 02/09/2026 08:21, Hangbin Liu wrote:
> > From: Hangbin Liu <liuhangbin@kylinos.cn>
> > 
> > When bond_enslave() succeeds up to the XDP setup stage, slave_cnt is
> > already incremented. If XDP setup subsequently fails, the error paths
> > jump directly to err_sysfs_del, bypassing the slave_cnt decrement.
> > 
> > This causes slave_cnt to drift upward on each failed enslaving attempt,
> > which would lead to unbalanced traffic distribution with round-robin and
> > balance-xor mode.
> 
> I don't think it affects balance-xor, it's using usable_slaves->count which is
> incremented only for actual usable slaves

Ah, yes. I missed this.

> 
> I think we can just move the slave count inc after XDP setup when we can't fail anymore?
> I don't see anything using it before the slave array update.

Makes sense to me. I will update the patch.

Thanks
Hangbin
