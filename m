Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501193;
	b=KjUUE+BqOyxTxGR/OHgjhlqVPrXEwGs3bBin7JDxeMjP+Mefcv7aPABm5IlPba287hSy
	 zvsbFeBYjSzmCPD3vj9m7pbjR8Ycqxk4Fg9Q1r9fqbxrvmAzVrmzxl5n+UcD4jJsVc/ka
	 asNUWRwGWrH0Q/3AHBEe/lNx1bbz0puFIEHZJX3nX94IgyMLfa2DUnm53mrl5QLqADfWK
	 68xwLTT0og8RALnhHrq5AwSnlsUxoQHKMpRdvovkLhHC1SscIdAv+yrvwlFNiZkKDsNIF
	 2oPQfEiCQUhtSXG9REROyvAOnESyGtAeYOd+VrZ4rUujvQp2YI2qXzGByeTPipdxquA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501193;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=yPUd9FeLj5QpouzWq1NZvMG7gxT72E6Fd8Vvq6ez92s=;
	b=kw7sUQhIM3kefBhk/c68Nh8B4jhDpVIcFUfEYQlBZ5qMEE+OUWq1lEEs7WdciHZXqNdP
	 vJUUF072wjBTeJ1eoxcTC0MJYxaOWbAXDVRVM7nLt/TKJ+Z/uzgpsM6Fcyr4ZyHmt57lu
	 F2MgHXtuskwaUw7sRUc2KxUhs14/U6WyoDixXU2pj/sUQUGKBr7BmliWV3enF+OWr4ueJ
	 R1aXj5AGAF7jiAje8yHYqdnEG7bDTE6cUErj/LMSYjQj96Z+bLJfAizJyJHKI3kPVVcrj
	 mWJ0MTicfS8fk08JU3JeDyoWCRpwj6TiuVM40fd4QfbbqDViXO7U3Y75stXIqy1ciiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kkL6kCI/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105CC606A33E;
	Thu, 12 Nov 2026 16:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkL6kCI/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3471F000C4;
	Thu, 12 Nov 2026 16:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794501192;
	bh=yPUd9FeLj5QpouzWq1NZvMG7gxT72E6Fd8Vvq6ez92s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kkL6kCI/5z+yr5mFgZW7w+h2y0/a3TTWefVLABMpxdQHdJudK8lwyF4FjFvwxq3Vs
	 htMBstcmkwA8gIJAq6QxjEz6Mzx2FNoc8zqgdFNqu21GN+h9TwxVxTSJrfhnIaL++W
	 HXlmBp6fvwahXXYZJojhnoDUcdbXbUstH61FpFE96KyvTCnyWm0AJrz3FNQ4rO5QZR
	 +8Pv4oK185Rax6ifdRTKOk8TjNGvzMMKyaKciww3Gmi+pL7+GFv5kX0+vS0J3jwz0r
	 Igr+BBC7PxIMpuLA7dn6QK8QqgoD9UJ6D7sOvsvhRjMMujNoYSzU1A8VPiWa/Os7Ew
	 K0pwlnK9eAX3g==
Date: Thu, 12 Nov 2026 08:33:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Subash Abhinov Kasiviswanathan
 <subash.a.kasiviswanathan@oss.qualcomm.com>
Cc: sean.tranchetti@oss.qualcomm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] net: qualcomm: rmnet: Update MTU handling during
 format changes
Message-ID: <20261112083311.641a2216@kernel.org>
In-Reply-To: <20261108075727.2031331-1-subash.a.kasiviswanathan@oss.qualcomm.com>
References: <20261108075727.2031331-1-subash.a.kasiviswanathan@oss.qualcomm.com>
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

On Sat,  7 Nov 2026 23:57:27 -0800 Subash Abhinov Kasiviswanathan wrote:
> rmnet derives the MTU of its devices from the real device MTU minus the
> headroom needed by the egress data format. Several problems exist in
> how this is handled when the data format is set or changed:
> 
> - The headroom only accounts for the V4 egress checksum header and
>   ignores the V5 one, so devices using V5 checksum offload get an MTU
>   that is too large for the real device.
> - rmnet_newlink() sizes the first device from the port's data format
>   before the requested IFLA_RMNET_FLAGS have been applied, so the MTU
>   does not match the format that ends up being used.
> - A real device MTU smaller than the headroom underflows the unsigned
>   subtraction, and a real device with a jumbo MTU makes the creation of
>   the first device fail while resizing an existing one clamps it.
> - Existing endpoints are shrunk by writing dev->mtu directly. No MTU
>   notifiers run and userspace gets no link notification. The helper
>   also returns -1, and changelink flattens every failure into -EINVAL.
> - rmnet_changelink() publishes the new data format before resizing the
>   endpoints and reverts it on failure, so the datapath can observe a
>   format whose headers do not fit the MTUs. A failed resize can also
>   leave some endpoints shrunk, and a mux_id change requested in the
>   same call is kept even though the call returned an error.
> 
> Fix these by calculating the headroom from the requested data format,

These should probably be 5 separate fixes in a patch series?
