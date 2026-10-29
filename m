Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793289290;
	b=lDej7rKl6pBE64gyuUj8OnfVsWL1dx4Rrf4W/7Mvqi/DVUMfq4WgHJwIS4M+I/qi+nPI
	 JSLRAC2uKiorZsqzqRvynqRdYbuSzwcklioFo7Q7Nlq2DodTacnfw8IM9rpOM17Mp8rF7
	 yMrv17+hr9iD424dYrL8BBDLN/tbH9v0c/hHirlytndeTMcnZlzsUIU4smXkqGrkySP2f
	 U7YDLoinvJIlCdNc4BIl1MK8oriKCv3Gb4aV+FhjsosaY77DxV+qSFrFn8mUOa/HvG3jc
	 spvrIMU0Pmp+5gkGWg8Wj9rkPI1YNoMJUjdimVVg2ynFpoVm8My/jdCRacbpdnMRz3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793289290;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=93R32k8kLpVhsBKeHbps7aqhivYbnUaf+31Eyu9Uqf0=;
	b=O+frRI+k3bw5+x9z4a0Po2KRnlb7R/ALTE3+DM5L6shREVXbGWWSIji2zIqaVl8cGpv0
	 3SdtQvCH0Wuy1QPlsnxLsHIqObf9QzYEF7SYxpHpVmtyPHWwHNwtt+luEVQDf+x6NeIuN
	 k+I37KdlinbmY96lSH9gC8vf5A29GbfNMNiee7JWPJIR7wV59wv12pforT1QgiwZnrZP9
	 BDVn1JlJmFCeFnqwXvRnCibR3PnVIVQ+yDCOeFNstXM2WAgOsYaqx+pSKKVZLuZ+Ay6gO
	 8Ty6zZrmQsF3X1iwGLGRRFQjXrvYUFoQd+4H0JIwuQ9VRFkKhlO0kiyRdv5G0EPT5jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VaIRD7FV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178F9606A31A;
	Thu, 29 Oct 2026 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VaIRD7FV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DF71F01816;
	Thu, 29 Oct 2026 15:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793289289;
	bh=93R32k8kLpVhsBKeHbps7aqhivYbnUaf+31Eyu9Uqf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VaIRD7FVjiY5EXlISNHQPY64jdxMw99zHlEwBXT73L4oKCcqdReN+a6Q/wTllRWZ6
	 9mHQz0wKYQfs0DAtCn3nggZeteVbHtDw8kvbKRkdzNuqkOg0iFMmHNxpyrYXgW8MOe
	 fkbiPxTAc2bt9+lGLrklCwl4GRcvTj4XdWPY+eURWdAth1xm1W8DZQgeIy4XkcmRgL
	 LBJKBsdcpJW93l2Jysw9zA2aiVONFXHQElZ11KIRlfI5gWUriwwRxiQki1OqeShbpl
	 7jH/nD+pgBRud07/aAsYD3mD2o3UUr7psrzCz8htlam9HUTpPpsa1Ot20yDyjk4CBz
	 sI0chb2Iwyvvw==
Date: Thu, 29 Oct 2026 08:54:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: vmukunda <vmukunda@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Sunil Goutham
 <sgoutham@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, "Subbaraya Sundeep" <sbhatta@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "Naveen Mamindlapalli" <naveenm@marvell.com>
Subject: Re: [PATCH] octeontx2-af: fix TX hang after link mode change under
 traffic
Message-ID: <20261029085448.08903fe7@kernel.org>
In-Reply-To: <20261029074635.4139111-1-vmukunda@marvell.com>
References: <20261029074635.4139111-1-vmukunda@marvell.com>
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

On Thu, 29 Oct 2026 07:46:35 +0000 vmukunda wrote:
> Signed-off-by: vmukunda <vmukunda@marvell.com>

I told you yesterday - real name needed.
