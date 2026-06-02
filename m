Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9502F3431E6;
	Tue,  2 Jun 2026 02:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780365760; cv=none; b=J7u8Vw/BF6/Cbv1mJgNLHifGPh5ZnmHwd0n23B3+6zAJZVZdudqlfF5/adWIa7DZgLVIGj0p5a+J1Ow/IUQ3w7dmIrAgq0KsiCbs5d+41lHWaTKctRS3xmX6+qz8CpP2opklWttmxhRhdOjXlLZtbtJFSDsZ4TIN/B9z6xRvdLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780365760; c=relaxed/simple;
	bh=+R85iHydaGjixH4D85cAGr2LN2rZSBXxrW7q1KqT96o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VvscJxzX5JA5WxMmiZp1X+Lj2fz53b5ysnRmMhcgr4h70GsOErTzU7ry4MOzS9Qbzy0qZMu4HTOpB86MGrhkB8Fp1DLE3S/MShD1nd35FdpjBvhwODwZvSOByJ8fVa9OF7tIsUNvXMzXO6cyQacXlDNXUdoxLcvGc96tuI3f/5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rv8MOhMk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rv8MOhMk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C361F00893;
	Tue,  2 Jun 2026 02:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780365759;
	bh=G57dt76b/BRFzvZIH60bWFWhhN1lOS3Iz+slVKKPV/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Rv8MOhMk1XXrHWduO8x88/ba2omjk6a2ZtcyA9c+q8aecOp/PP3Z5apsFdLtrdJMH
	 DE/Xeg1IEdM4ab1yRBkBRO/3i04X86YG9FVJ7sduCEc2+WN18QYlSqRHt8xtzXaL8d
	 5hbrcoYMDNDVq5VL3y5SMT2RM5Z5UfO9SH7zw4mTIpzmxGYUdJqcyxdmRIoano9bgW
	 uP39VMkPs6VGZeczMjIj6wdx+7Tz5xg2yo5wT5k/mJy0aTlXkVbiQtGcF/SeD7otFQ
	 sJL4nqHjuq4IcnXAiG9YH7o2Xv9lecet3RGKGQP42lSz/XsXiSj84a6ZuoRaLU95pf
	 NqNcfdYBFBCdA==
Date: Mon, 1 Jun 2026 19:02:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yuho Choi <dbgh9129@gmail.com>
Cc: Sunil Goutham <sgoutham@marvell.com>, Linu Cherian
 <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, hariprasad
 <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] octeontx2-af: Fix PCI device reference leaks in
 debugfs
Message-ID: <20260601190237.76d7d47c@kernel.org>
In-Reply-To: <20260529052333.1665989-1-dbgh9129@gmail.com>
References: <20260529052333.1665989-1-dbgh9129@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 01:23:33 -0400 Yuho Choi wrote:
> Subject: [PATCH v1] octeontx2-af: Fix PCI device reference leaks in debugfs
> Date: Fri, 29 May 2026 01:23:33 -0400
> X-Mailer: git-send-email 2.43.0
> 
> cgx_print_stats(), cgx_print_dmac_flt(), and cgx_print_fwdata()
> look up the RVU AF device with pci_get_device() and pass the returned
> pointer directly to pci_get_drvdata().  pci_get_device() returns a PCI
> device with an elevated reference count, so the lookup reference is
> leaked on every debugfs read.
> 
> Store the returned PCI device pointer, check it before reading driver
> data, and release the lookup reference after pci_get_drvdata(). In
> cgx_print_dmac_flt(), release the AF lookup reference before reusing
> pdev for pci_get_domain_bus_and_slot().

Looks like cgx struct has a pointer to the pci dev.
Can we use that instead?

When you repost please add net-next to the subject:

[PATCH net-next v2] octeontx2-af: Fix ...

and make sure you base the change on the net-next tree
For some reason our CI wasn't able to ingest this change.
-- 
pw-bot: cr
