Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7F73750C4
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781281703; cv=none; b=j3bvJXZ7ghYmofwFZ4ghPZVORZybA8Qg4g+hJ/uSAStYcH/fI2vVGAUTQesdTXUaYzTsdFsAECX6EbinGIJJ4QQ2w7hz71RBbhuG/nhAMTU8CoTpHjLHPoRRzBuLEr9KmB/Y4ufVj6+9vnugiyo+ghLOx8n+fFxM24e+UWrhKnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781281703; c=relaxed/simple;
	bh=8Lg9Bb4x4TWmemkBKnMCVb8Nt4i5MGAjBOI00+lnMKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEtgfHXOInCyCqVw8GY0HVcR65K6jt4V4tdCDlf7hJDel/QuYwxDIJku3Dhg6UaAvLffE2wbNCnq1az4Zsp0XQriqBFUXYEDT1X6JKC39W1hAVbXC0SIYUNpBbu9piXZMmyydKOVOL/4NLXoNwlG7URaHQ8XF8LEzoag6cRmI/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqw1Vp1+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqw1Vp1+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68BD1F000E9;
	Fri, 12 Jun 2026 16:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781281702;
	bh=xi/QvlDyoWoyjS7C1yT9gvcxhFW0VW+Wf1DoCcoSY6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dqw1Vp1+XRaqGDbwUfrTu99HhY4tldd5cJ1lzgwE/r22mX1AjHYXcfLAvO3TSbAaT
	 gVDifZa4cYkdCQirPmUp1aGV7OLmtRnAf866g8LN6L936PLOC62+ymyVhGtLJN7g7g
	 PRZozR370niAA5yYI2dH0vOuIXdp3LarEdVisBr1xreXcY7T17lYbuu9Lva4xa43kf
	 Mz+2Bhpwau1kY974qZgRJHsyRGcF8k5KxDSIwZlFZf3HqaeOAZY29Gx3ZF47OXU4Dx
	 P5DWLyB3DhOQhfNK/Q95sCN30fSn7JM/G1ZbbogSsjFL2mvDTjapceCvCvU0lUYf73
	 vfxHQEQouvkLA==
Date: Fri, 12 Jun 2026 17:28:18 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net] ip_tunnel: annotate data-races around t->err_count
 and t->err_time
Message-ID: <20260612162818.GF671640@horms.kernel.org>
References: <20260611165247.2710257-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611165247.2710257-1-edumazet@google.com>

On Thu, Jun 11, 2026 at 04:52:47PM +0000, Eric Dumazet wrote:
> ip_tunnel_xmit() runs locklessly (dev->lltx == true).
> 
> ipgre_err() and ipip_err() also run locklessly.
> 
> We need to add READ_ONCE() and WRITE_ONCE() annotations
> around t->err_count and t->err_time.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Maybe this should have a fixes tag?

In any case, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

