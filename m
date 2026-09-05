Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DD431715F;
	Sat,  5 Sep 2026 00:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788569557; cv=none; b=XiTLhSYeLCqZQu/c/F18/Bf53ckFFVXavX2mKTYAr6xJ9dhXpG58RcZR2cZuYwVxCmRD8rb9pCIjn4m7kPAtTT3tBB+u565AEhDS0/bDUtHKRhE2mtVXnUgAa4z7HdPcSjXe8bW+9MSOA/VZU9SzasGh2h2I4+yFKCiUKa3iDCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788569557; c=relaxed/simple;
	bh=azOTZuSt6WoePHrdQ8r4keF+HbxVxf486hyjpOM5rwI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSgu2UuGWEcORD05g4adKikMCsfMYp8CYKLk0A2i524L4t/wzVMl/YofmGb6B/Ij2NSiAXZHzRoMy4J5BrJhvoNYUAiGiUK1EORy3GEMIYlhKlzVPMvPOuaVnM2dLFqb0mwTm6L2Ox13iollkq3s5DqhxM5qSw2nihsnTz1y/Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlLN7RtY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlLN7RtY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2021F00A3D;
	Sat,  5 Sep 2026 00:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788569556;
	bh=azOTZuSt6WoePHrdQ8r4keF+HbxVxf486hyjpOM5rwI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MlLN7RtYiwyCQOX3kQo70IEjQzY6WC8/pAouGkR/sZbHCbcdvTnRmdc0vnXD6x4sK
	 Qtr6WMmVQMa2X2tN8mANiG+YsQGFoVpIUBHFKTEItZvhofVaCjHiaobtNFB+ymhemE
	 w5g1B+MLVAzLUGrkl5CJ5linMMfz2rqEAmSjo/Uh7L+UYgDzKtuYJuPicIcEWuc4Nd
	 nV7I5KHqDYQzhyjnPkrroquNGMsQ/P5BCXZ8av/2UFJjQdaZzJHEyBxbv8gO+3Ybgr
	 YQeSQWghzAYrQUN2iKxlVWMPWdNQbIUZExeA2qzP6NvqjXHvlIDde5Z322iUWhZexr
	 PPiQ12bap/y2Q==
Date: Fri, 4 Sep 2026 17:52:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: wei.fang@oss.nxp.com
Cc: xiaoning.wang@nxp.com, andrew@lunn.ch, olteanv@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, richardcochran@gmail.com,
 wei.fang@nxp.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 net-next 8/8] net: dsa: netc: add PTP one-step
 timestamping support
Message-ID: <20260904175235.66dd766b@kernel.org>
In-Reply-To: <20260831082335.1184605-9-wei.fang@oss.nxp.com>
References: <20260831082335.1184605-1-wei.fang@oss.nxp.com>
	<20260831082335.1184605-9-wei.fang@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 16:23:35 +0800 wei.fang@oss.nxp.com wrote:
> The NETC switch supports one-step TX timestamping for PTP Sync frames.
> When transmitting a Sync frame, the driver reads the current PTP time
> and writes it into the frame's originTimestamp field, and inserts a
> To_Port subtype 1 tag carrying the low 30 bits of that same PTP time.
> As the frame leaves the wire, the MAC captures the SFD transmit time
> and derives the residence time from the timestamp in the tag. It then
> reads the correction field at the offset given by
> PM_SINGLE_STEP[OFFSET], adds the residence time to it, and writes the
> result back.

Please spend more time on this code, especially this patch.
This really looks like clumsy slop, some DSA expert will
have to review it before it gets merged.
