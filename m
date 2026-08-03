Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4008929BDAA;
	Mon,  3 Aug 2026 20:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785788462; cv=none; b=ThOyzpN0ztl5Uw3yCxgAOemUj6uu7hrj/lMwOBO3SSL9jOWGuTwmsFpTFE6NL4W6yMnNMFKHgflNiOIb6MXnAdqwRdMC31HurxWbkzxgRP+Lt5FGCGYxcW+vbuJiWlCNeg12zGkvK8YsdZRuUHkUcSxghdqI6jvMEjCRNIppeAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785788462; c=relaxed/simple;
	bh=703HcPBesBni2DgNzuEjZ/8M7Y2rRcTm8blXUCe06Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4J6u7cPtjuYsYbjrYofeK/HOXgg4ox7MBf9ZK8h5R+sjOjXxC6q90n/nmF3J7ta1uRvh6kZn1hrqn9bqGGRO8L8OSCQSCrcpXkSVdd5uw4DlntLYVkDqlk5W+HzWBAA4X4HbIvYDH54HDsnMfjdWLCmUgxvdLl9Wk+T7h0ZyHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kv9n+nD5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kv9n+nD5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E74A1F000E9;
	Mon,  3 Aug 2026 20:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785788461;
	bh=vqUtSXmtaHHL56rGQDVaeojoqOoqakmd/fHfLv5Vrrs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Kv9n+nD5jxAh36ccfq+T/PmLAVJDPEZgQa6Op+2nA5ihDE4yeg96UJrtdkPVNaRkD
	 gqfEDOTL8BfAFRFWsDM5AQX3BrKzD/faqddzQpMNjBPlcOSTmd6+H4brz6BtjBpanR
	 EAx8pFQcPVOAkgqroMmyL9dL0BulOMHkQBOgQjtkopc/GasK9dEIsbKlLE4Yx4HaWu
	 4j6Le03ZNBl633+VzWh1hBv6Npethxak68KOaluEkBl0yKu93Kv0lqQl0dPd/1QDx+
	 6TaSxC/muu05IVzm8PLseOu1mAB4p+Y6Gza0tjzy1lJNBDF7epcG8S9uORiCUfiOqE
	 AXUljGz2qzXiQ==
Date: Mon, 3 Aug 2026 13:20:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: Frank.Sae@motor-comm.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
Subject: Re: [PATCH net-next v8] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
Message-ID: <20260803132059.0e62d3cd@kernel.org>
In-Reply-To: <20260801035236.3560015-1-kyle.switch@motor-comm.com>
References: <20260801035236.3560015-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  1 Aug 2026 11:52:36 +0800 Kyle Switch wrote:
> Add a driver for motorcomm yt8824 quad 2.5G ethernet phy, supports
> 2.5G/1000M/100M/10M speed

Now it got into the next stage of the CI :) Which says:

  drivers/net/phy/motorcomm.c:1450:5-9:
    WARNING: Unsigned expression compared with zero: data < 0
