Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2092472AE;
	Thu,  8 Oct 2026 00:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791419881; cv=none; b=btpm5RzlcxBHh8jYNC/9ID75X5NhWDXf7E7eJWZnZrYVzY63BYp60ody7N1/affgNdVzre9NbmEFIhwapS9LHJjQ0JIYDAQHLUp53dDkW712nXqwJu9G1Nlcyxr/OLnFE07FoVnFHNgrp3jF13pz1aP8/iqIhvQ74IpASD0HkEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791419881; c=relaxed/simple;
	bh=ra9qelWQsYVHrYJbfH0MgFkiKcVy83oV6vo6jRkHszE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YR/Pid53t2ZSOacmGLx6HyNgx9GHLzAKj9K3K8VCstsYRMSjZPB4LNtcnsR3Rvv0a8f8H+RBFwSYqqsqE36b4eOf+/ggD5fSVi4OY2MrKSXRlrzAKcJY9YpiupVb2ECVF6TYJUzluggN8yyroFW1G+H7/o8kq13xsz6Wa5spFFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcuEBSXs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcuEBSXs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08161F000FF;
	Thu,  8 Oct 2026 00:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791419879;
	bh=GA3OD8YP8kA43uRwiqGHMLv9THIO8ScV9l4ifw2Ty88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DcuEBSXsTJX+9zy1cEQLUMpet8lqaNcY/S8RCIL5hsKXGOQDrK7kwdwv+GVaLuXAo
	 NGN6f7q8/a+JjXUC0dgQ+QU6q4lu0oTJlezJ+mYOAgOjj9emrOMTa7xalxtWVJGeWv
	 xmbls43Ayd8TOU6jFEZTC2u88MB6DpPbLvia7SG/OLg0T69qOkku/dLCKvEsTA5/sn
	 aLVXUjrOv3YXBsH/MDdi9ckdsEYT9N67OKr1BdCdoaDl9MINnWYUWiTJIr3eoWXjCi
	 y1yy9tUtr8Uon5xmsCicyq8fGN3hSAVvM/p13AYnCBCtP93MhV2y0H2D0ivh9f5qGZ
	 scxb1a0hkfJJw==
Date: Wed, 7 Oct 2026 17:37:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@kernel.org>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Christian Marangi <ansuelsmth@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: leave the datapath running for
 normal-size MTU changes
Message-ID: <20261007173758.4e8687de@kernel.org>
In-Reply-To: <20260930-stmmac-mtu-fastpath-v1-1-fd73f378c071@gmail.com>
References: <20260930-stmmac-mtu-fastpath-v1-1-fd73f378c071@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 22:39:22 -0600 James Hilliard wrote:
> When both MTUs are at most ETH_DATA_LEN, the receive buffer size and MAC
> receive limit do not change. Update the MTU without restarting the
> datapath.
> 
> This also avoids rebinding a live AF_XDP pool to a temporary RXQ. XDP
> rejects jumbo MTUs, so all supported XDP MTU changes take this path.
> Jumbo transitions remain on the reopen path until the rollback change.
> 
> Fixes: 3470079687448 ("net: ethernet: stmicro: stmmac: permit MTU change with interface up")

Someone marked this as Changes Requested in patchwork, no idea who.

Change seems good, but it's an optimization for net-next, no fixes tag
