Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E663DB334;
	Mon, 20 Jul 2026 10:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784543782; cv=none; b=r9nX+gQHZP/+52WbNjmA/Sql3o5o9m2PMjYrNRNAxPAUq+sLuSSDsPPJHdL7lP3Hi/SnWmulMzDtevSnMT0Y8eUoKxqo29JAR6ruOjBG0/SNF8HbomfEDxjjt4kLChDpg29Arrhi5MDuic0HBLAx3MVYSHVtrp1WKJ3Sa14gHZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784543782; c=relaxed/simple;
	bh=Asw/uy0Cae9cPhW/rY/eXjhAmjWgPfoVTN2V4pueuvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkI844puj+FHukUxaDefmyt85jWMQPAcJdsvb0vE6e4qUtqiWE9IcKC0BxtMcV+KEzIkmqoYasMTUhrSKHE/IzKQ5N4hsNrp5jU+sO4jjmoHZvrC+cyophF03D3JbQuKb1f2HCiRGf+yPqlUmPpxnz4EDYSrWMeAEFcfRqJF76M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Et7nuXNm; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Et7nuXNm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lsJ7ycZqmNfZ4qcNV3YiKPKQ1rFYnrAAMeqziv8zi0A=; b=Et7nuXNmeSqF3viCX0rn8wephK
	NZYeYohV0vJLexKKxsyzFYDczkmxIvyqfMT0NQFIzpURT/8YTcqpqoPIp8hdj7mKe8ZVqhkWN/UyL
	y1iInzlC1zdGXkoSU8qapDGiGDU94xDGt12UuDw4vkK5j+iBoapJ3yUyx0zupgC2MXBED5AlSyHZE
	NZqKX2qLYX5lfnEloJDKEfljT4019Ean/R8sy6WSOWv9b4tas332v+HNZ2lCmfoVaMj0eoVNMjcCT
	9m7e3n7XvCDRj1ucIc3iFLOZJtQGZVXapXThzL7LG8P0WNPAt6IotBB4qcVCrr7y/PRCaumXtI3DQ
	Rnxf/I8w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wllLz-001NQI-1e;
	Mon, 20 Jul 2026 10:36:07 +0000
Date: Mon, 20 Jul 2026 03:36:01 -0700
From: Breno Leitao <leitao@debian.org>
To: wei.fang@oss.nxp.com
Cc: richardcochran@gmail.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	Frank.Li@nxp.com, vadim.fedorenko@linux.dev, wei.fang@nxp.com, imx@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v1 net] ptp: netc: explicitly clear TMR_OFF during
 initialization
Message-ID: <al36BnzPjbQ0gSao@gmail.com>
References: <20260720012508.23227-1-wei.fang@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720012508.23227-1-wei.fang@oss.nxp.com>
X-Debian-User: leitao

On Mon, Jul 20, 2026 at 09:25:08AM +0800, wei.fang@oss.nxp.com wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>
> 
> The NETC timer does not support function level reset, so TMR_OFF_L/H
> registers are not cleared by pcie_flr(). If TMR_OFF was set to a
> non-zero value in a previous binding, it will persist across driver
> rebind and cause inaccurate PTP time.
> 
> There is also a hardware issue: after a warm reset or soft reset,
> TMR_OFF_L/H registers appear to be cleared to zero, but the timer clock
> domain internally retains the stale value. When the timer is re-enabled,
> TMR_CUR_TIME continues to track the old offset until TMR_OFF is written
> explicitly. This can cause incorrect PTP timestamps and even PTP clock
> synchronization failures.
> 
> Per the recommendation from the IP team, explicitly write 0 to TMR_OFF
> in netc_timer_init() to flush the internally cached value and ensure
> TMR_CUR_TIME follows the freshly initialized counter.
> 
> Fixes: 87a201d59963 ("ptp: netc: add NETC V4 Timer PTP driver support")
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Breno Leitao <leitao@debian.org>
