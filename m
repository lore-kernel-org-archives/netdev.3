Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F542475F7
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 18:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776103761; cv=none; b=IlVZWYw9VHkjeudpihJW6Vr6H4g1V7jWd5W7e43TSLPnnN1sJkmPHgImunHM49wW9SwcF0QetS6imu4SMg7yZaj0s/FyRYQ6BglR6HJ0CfAEBRSzNU4NdRlMv5Dvl2R7Kwdo8Sb1j1ETUSs4/LNGOiSSY/uL3ev9qSg/CxmGAwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776103761; c=relaxed/simple;
	bh=FD6EzJgEH7JctYLGReT8g7AiZ+LRTAjp7HUqJD3V0hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSLKp3xHk63ByNFtL+AEX0PRgibEHXmhxToM36wG+qKgK9QyCZgAIIcZz+gAQvBqJPf6LvKQrDaU3NZTnR/2n3QYNhp7fE1Pq7zvIjzEcxNfaGjC7QJA7J+uD6LFTnBY3WQfPohw2N48aZSmP0VbOX3zZ/7JyhEYrm//h11BRSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=GmFroPNO; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="GmFroPNO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f70oiokzWco9+Ks8FL+MDau/8OW9ZRYalxksw2j92o8=; b=GmFroPNOlIhaU8tnmlMaB+P9pX
	L5BRJFpTPybQxcjSVVVLtZahm+SHPfO9O2Lsmu+z94Ijx3y/wwZ00/YTpQyqRUlx56f3nvAN2O75V
	7/uWcrcF1tfpTGwBECU6LM7Op1s19maBYZO752ES1LQo9MTtYlbufqFqVxHtXDpieliL+hR3VHQnd
	+vdJrumggDmPmp6QbTN17jwZFsmGSgYSF6uUx7iIjkWZTK6HqZ5PJaU8t2VOK1n03eX6EmE+yYIqy
	8Oo/udmqezpfpU2bVxVDW5NHhtRIfJthTy+jZvFFxIU3FPT9NONM8mcAbVAfPP6Q4s9s/6mtraxm4
	39EXI9mg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wCLio-00CTip-0P;
	Mon, 13 Apr 2026 18:09:18 +0000
Date: Mon, 13 Apr 2026 11:09:12 -0700
From: Breno Leitao <leitao@debian.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v7 14/15] selftests: net: add
 team_bridge_macvlan rx_mode test
Message-ID: <ad0xPQ_NkaIXPdsA@gmail.com>
References: <20260413171131.550126-1-sdf@fomichev.me>
 <20260413171131.550126-15-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413171131.550126-15-sdf@fomichev.me>
X-Debian-User: leitao

On Mon, Apr 13, 2026 at 10:11:30AM -0700, Stanislav Fomichev wrote:
> Add a test that exercises the ndo_change_rx_flags path through a
> macvlan -> bridge -> team -> dummy stack. This triggers dev_uc_add
> under addr_list_lock which flips promiscuity on the lower device.
> With the new work queue approach, this must not deadlock.
> 
> Link: https://lore.kernel.org/netdev/20260214033859.43857-1-jiayuan.chen@linux.dev/
> Cc: Breno Leitao <leitao@debian.org>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Breno Leitao <leitao@debian.org>
