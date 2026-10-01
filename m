Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499673E024D;
	Thu,  1 Oct 2026 23:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790896332; cv=none; b=bISn8zae6na5PeylgxOaraWZeUq+/485fjiI9m0stV2rEwM5eMPMk7IGdJaYQtnXzKnTNc+ZRsnsisfMWIHI+UjiN598dDLHgdwBpxD4cEVL55uDXUJw9D4ACnkgib655/cID3WCgToWprnGt1Sz57cvrfZ+4HNt0dvw/s6h6M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790896332; c=relaxed/simple;
	bh=d8ED1L3qFizQ2dp0sqpWo29zf8FJplBXtuTEN6dISPo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aV21MxrQj8L5AFd9//Q35xlqYakBaXIcILPPVVg8EnyJXhA53U3CcNEc0VGKHf5T8WHKDHj/nwoJbwBIgabLLCELynxNl9YCJMD382iM/g72VvsLNpc7gYcg5rEfT/v7wklJBNVAJQQkvX1rra8B9Red2uByx3OF6+BiV16RERA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuSMkq3l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuSMkq3l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7993E1F000FF;
	Thu,  1 Oct 2026 23:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790896330;
	bh=iwYSVdb7bxhVz9oEgXCL0yfSZVG7Xia+FychInSbZZc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cuSMkq3lynjb+BXobbyH3KW88Qy/D04ppSpz/2OP6mwOcjKoA7N17HAadJbkNICLr
	 WuRjYcGfZv7OV8BKwOKhcNqDXjlUuJDJdReXpWzYAmaM4ONsNk30kp7yVXXaAR9n1F
	 2oC+iiWuBKR6H507LJZtpVfjQEnauHyBT0H1f9RyueYuA71tQN485mk48DmHPxd7MW
	 iDfHkD/HKb7A790hdsVb998tuiiAd5JrEhpn+IlfTJ7IXpn/ie0ls5y27Gn4h0bF9n
	 vFp9Oq6YVc9MEAxLkmZii4DTnSqkbme8Acx5rEh2PfTKWoMJh9VQ/2O5UfJB7gQqFF
	 XhHgqt2a7ab1A==
Date: Thu, 1 Oct 2026 16:12:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiale Yao <yaojiale02@163.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang
 <jasowangio@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] tun: Drain eBPF RCU callbacks on module exit
Message-ID: <20261001161209.135f0aef@kernel.org>
In-Reply-To: <20260926162554.163197-3-yaojiale02@163.com>
References: <20260926162554.163197-1-yaojiale02@163.com>
	<20260926162554.163197-3-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Sep 2026 00:25:51 +0800 Jiale Yao wrote:
> Subject: [PATCH 2/3] tun: Drain eBPF RCU callbacks on module exit

please repost this if you expect networking to take the patch
patchwork will wait for the other emails that you did not cc us on
you shouldn't pointlessly make patches for different subsystems into 
a series 
