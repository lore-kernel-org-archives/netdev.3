Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE77413780;
	Thu, 23 Jul 2026 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816634; cv=none; b=aTfPd98DxyqjIbzVQV1T2EjWil9GSKMV2S0MMkKal1kUYb3dYPHlCgVPaj0zE32yV/a/ROucD2q3fxSXTYi3hqNeMtkRn39+l96eQ71j0oo6gc+PUKiaz7iS903AH4ShgK63nGxRa0WjJAp7cbOxGB9/HvamkTbdtDY7nNs3J6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816634; c=relaxed/simple;
	bh=vzYuvILLIG+aUS9zcwjN3JQArJpGl8z5iCPdi36V/mE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aslVyYqUjGUi1Nj9FukGHiHXoCmpp0RB08ANVWtmIFGZBTv2rujgf+mmJWLyMfIJWd5/AfkljLP8Yz7n9UrwovQ8QQos3eqIpqPqpP/4YUDOgjC4WMudCQQuR/Ah6Okr9Z+tivdevOSRTKFZ0RseQeB5VdQFRS4k/JiM6NrjspQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB07D1F00A3A;
	Thu, 23 Jul 2026 14:23:52 +0000 (UTC)
Date: Thu, 23 Jul 2026 07:23:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v3 0/2] net/stmmac: Secure against failures of DMA
 memory allocation
Message-ID: <20260723072352.6db4df7f@kernel.org>
In-Reply-To: <20260715123602.51950-1-j.raczynski@samsung.com>
References: <CGME20260715123609eucas1p276498c4701060ffbb6789cb096696a31@eucas1p2.samsung.com>
	<20260715123602.51950-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jul 2026 14:36:00 +0200 Jakub Raczynski wrote:
> This series fixing two issues related to fails of
> __alloc_dma_rx_desc_resources(). Original issue from 1st patch is related to
> page_pool that has happened in testing env, while second was requested by
> Sashiko to have similar change for DMA allocation. 
> To have complete fix for all failures of __alloc_dma_rx_desc_resources(),
> merge two fixes into series.

Clashiko is not impressed by the second patch.
Is it possible to avoid calling the functions in semi-consistent state?
-- 
pw-bot: cr
