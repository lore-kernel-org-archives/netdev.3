Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA9E3D5229;
	Mon, 27 Jul 2026 20:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785185462; cv=none; b=R87T0v2FFF2XkkpWOhj7Wk7sK4/y6PGWUcNClhbCMP5rLJl4lmZHNil4ncnH3r9sRN+u56bbcEvUTUWtSwTqDVLxYIBOEicsxXoYaMacCrF8Gmb7Gp80zAa+R8cg2FG6TbEJ5FEcg4pRtY2lj/4Eh6IMWrPXY4jvcwEA2LQMvIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785185462; c=relaxed/simple;
	bh=BEtd8tI/B+02NFzySetBurIzSXANv/LEuVqd6CxkaQU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R43JRIDkGq0Qrfq93E0HMmMgtmi4HolnACGL43+1+LShdzQiAi05TySR7M2Al3xZ1ZRn1L0FvMdWpxeTH5TwoyaS8Qo5mlK0JcDgRcgAqqt9S8RZeAQE2Ne9FegvYbsXeoSq3u9qC7efYgFmSFVENWSyhzUuy2eepNzSigQVJtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q45GIBkl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q45GIBkl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEB61F000E9;
	Mon, 27 Jul 2026 20:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785185461;
	bh=WVUyXHVvjF3fipEBjzQ6spYODkj4/QiY+rhq80/D0gc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q45GIBkl58PjfGhvKZSSU4mpJ2Gy36UEB9Ylu+7h9njyDsUxo5NeA4uM3oPQ5FtCw
	 ll96JkyU5FxUt2bP8JsVG/FRuWzhuCjQHgHFZviS0BfcjnPQNUJceQUEy+Z94VfVMD
	 OffAwUhnExk2xZmDqoe8wdZliSr7nksCeyO1QaBn6y4zoIlLX8px8U92lpfwqP1vGv
	 6nRf+qHfn4epmY/KxhJC0qO8QnaBkHNz+9Gcfazr+PErYyV4YkWWHN8AZ4hTZfUBgB
	 44kBvsKtxRFo7O4Qqwh5ctDCmfDsk3w4AttfIwe63M87Izgk5xHEzbuiEi/gG+e2Bv
	 nPxbjvbp0TBFA==
Date: Mon, 27 Jul 2026 13:50:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v5 net-next 9/9] octeontx2: switch: add TC flow offload
 path for switch flows
Message-ID: <20260727135059.6e0c8fdd@kernel.org>
In-Reply-To: <20260724094018.3213907-10-rkannoth@marvell.com>
References: <20260724094018.3213907-1-rkannoth@marvell.com>
	<20260724094018.3213907-10-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 15:10:18 +0530 Ratheesh Kannoth wrote:
> Register an ingress flow-table offload callback that translates TC
> flower rules into fl_tuple state, resolves ingress and egress
> pcifunc via FIB for accelerated ports, and notifies the RVU AF over
> the PF mailbox.  The AF forwards flow updates to switchdev and
> keeps per-cookie packet counters in sync using NPC MCAM multi-stats
> when the switch requests SWDEV2AF refresh.

drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:682:35: warning: incorrect type in argument 1 (different address spaces)
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:682:35:    expected void volatile [noderef] __iomem *addr
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:682:35:    got void *hwbase
-- 
pw-bot: cr
