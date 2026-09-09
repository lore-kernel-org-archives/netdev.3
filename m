Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68729349CD1
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973026; cv=none; b=YKZs3nBlh5njx2jPaSt3LXvokIdrvSq5/m8YsSaUhKRrnWMEPHeT9gPBSUX0yIZ/wlQb4R26dNXobaU38akS/a6ReBwIzZbX3elge4yiHlCOFfiE28IzQb4WxOOhzoj5dlj+iQ/FmMYE6+u54j7WJ6ywUaGtTsN1kKp/J0TAG/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973026; c=relaxed/simple;
	bh=8Qm5vN7bRxPt6tOvNnkjUjODr+A5w7dWcLbRGwINMtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXdAf9Jzyezk9JGhc2mKSGMAVbPc0O3ShrM6fQZgTW1duon+6As6e/J+8qZ4A6fcs1jil6G+jj5pgJB6Zg3vViyPue9He8lV7waOtlC2oHekVq+V6rPgyQzXg6DdmfQ+CDGZKtBXC2OLn/ObFFN4vN+cambHi1shGyC6Uby/7jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSlv51RD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSlv51RD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818031F00898;
	Wed,  9 Sep 2026 16:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973025;
	bh=j15N3hYnX5ZwLpMjKYG1TjgPiIyW1ERm+AGo7QZlasQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fSlv51RD1nPCvZM2t6Z0JZSQ579nj7fUWyaI77lWyK8qwuY58WVHZHI//s0QkYWpk
	 8RfVB7GvPkLrI0hSnEvMf4Hrw2s306V6fSsANjjPwUBT2ssF9w8fXg7Jxg5owqhN1y
	 PGNaop0QZTmmGOOUCJ79gByZ+ruEE4GntcrmU/Jl9gxuBGTLCpVqI0CsUbTujgXgtT
	 jnHA9147SmV0snFMfJDB9ng5uMsfvOo8wja0LKGepiPb2FReQ59KJnp2I9R7rDEf1e
	 zE4f8dI7q6ac1tmpR2pfO5mVgZxC9EdJVyueS+AIhxxgr2l5zEIL8XamhAz1T750Zt
	 8cOWupICcRi3A==
Date: Wed, 9 Sep 2026 17:57:01 +0100
From: Simon Horman <horms@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v3] selftests: net: csum: filter packets by
 source address and port
Message-ID: <20260909165701.GK40544@horms.kernel.org>
References: <20260908155537.813889-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908155537.813889-1-willemdebruijn.kernel@gmail.com>

On Tue, Sep 08, 2026 at 11:54:29AM -0400, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Add source address and port verification in recv_verify_packet_* and
> recv_udp: non-matching packets are skipped.
> 
> The receiver reads from PF_PACKET and UDP sockets to verify incoming
> packets to test hardware checksum offload. It did not validate the
> packet source address or source port.
> 
> During tests expecting an invalid checksum (-E) or zero checksum (-Z),
> background packets can fail the test.
> 
> For -Z, build_packet_udp chooses a specific source port that causes
> the checksum to sum to zero. When running in receive-only mode (-R),
> call build_packet in do_rx to compute the expected source port so
> that source port filtering can be applied to -Z as well.
> 
> Also
> - add an inter-packet delay to avoid drops from bursts.
> - remove a comment that is no longer correct.
> 
> Fixes: 91a7de85600d ("selftests/net: add csum offload test")
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> 
> ---
> 
> Changes
>   v2 -> v3
>     - also fix same issue for zero checksum:
>       calculate expected src_port by calling build_packet on rx side
>   v1 -> v2
>     - also check udp socket, with recvfrom
> 
> v2: https://lore.kernel.org/netdev/20260904030624.3833721-1-willemdebruijn.kernel@gmail.com/
> v1: https://lore.kernel.org/netdev/20260831210128.1359978-1-willemdebruijn.kernel@gmail.com/

Reviewed-by: Simon Horman <horms@kernel.org>

