Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CAE2066DE
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 01:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785290260; cv=none; b=fCMHd8Zf7ol29o1UQtEr3x++9sr5Zi6HWn/BI4BLKLmvyiVLsyVzubh3udMFNsax6+swPj4B+ksMrnYUa5xLHwHnpAmYm/rD6OODHaXcefuYnOMUHrQcpKPLr7aRsNIveDOkJ4GYPg1c9a3w0h+JWfWGoatakmZni7l9ZFTuykE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785290260; c=relaxed/simple;
	bh=mVvgPOq7udeL5bgpfOK1+L6iFcMHUEgOyehItfRTJ08=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TlKL45v5C0QrbjuA0sRcNri4ieg8hfHOn4RUiqmvDU8WxFZ9gCq2hCkR38esrnmQ/VU6pGx1BcL2imkWV8/J5xiVeJaZFVh/Qef5y2C9Bn1atOq01i/xXZ8lR9k47GTN4uOIBd4n7WuiUTlanCrj7xqRPuPXJTetU6wuXeG0qAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lb40xbR7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lb40xbR7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1991F000E9;
	Wed, 29 Jul 2026 01:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785290258;
	bh=mVvgPOq7udeL5bgpfOK1+L6iFcMHUEgOyehItfRTJ08=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lb40xbR7vM0hd1XjANyjLG0hALhQa0M05QGSusFLUkw7SxIpKj1h/YQwSbyUsoz2X
	 +o6hLi2v1K96TNJnMHfkZImSBQdpc7Tdttc4S7MgNuFfHXrLLPSeKTQKDkaEWNEz3z
	 BjKNf4oT+Bpom+i1esWYvZLp/cICH4Y4yZT0Hivhi0JDDZ7w5F0yTewACpVxsOBXqi
	 ulukvrVQUwQaJ3+tS9xInoI2EIDu7sCfnBacuTP655wZvTxoD3jZMQz1FYBs13dv75
	 SMaGx4cbVCQEvPK/SMFbGB/ohJg7QAU5sVWcpuA+E2dK58znw65X6/pvyQfOUDc00p
	 CIS7ZaSNh0Ulg==
Date: Tue, 28 Jul 2026 18:57:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, Tangxin Xie
 <xietangxin@h-partners.com>
Subject: Re: [PATCH v2 net] vlan: fix skb_under_panic and races when
 toggling HW VLAN offload
Message-ID: <20260728185737.519431ff@kernel.org>
In-Reply-To: <20260724035419.1473174-1-edumazet@google.com>
References: <20260724035419.1473174-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 03:54:19 +0000 Eric Dumazet wrote:
> Toggling hardware VLAN TX offload (NETIF_F_HW_VLAN_CTAG_TX or
> NETIF_F_HW_VLAN_STAG_TX) on a lower device invokes vlan_transfer_features(),
> which dynamically changed vlandev->hard_header_len.

This one needs a rebase
