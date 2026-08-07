Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA6147CA7E
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108688; cv=none; b=jkv7CKsnD0njQCkUV4H033XBPyGldP0SIP5bibHuO/mkrD4lXTjpfUWeloWkyUpnVzzhTJigoqF/D2NKgANjOR2Xmq2Vw+AX7uYk9ppbSFzK3ibACeckf1aG9AXYBZgv/1xjNCzqHqd2W/YLBciCgdwiXR0X1msTCqhKCjcQ0vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108688; c=relaxed/simple;
	bh=w2Xz0PP8BrPnLZcjl6mx6Bw9ghx0T8pcVEyQjwO9cQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoCrXMXfOhdQ/AkO4tJHuYp0GkuQOVt8VuUjxaqOTRsqnw9Iy2RQNGIxGgg+bSN5zKKSqITC7MWk0qW59uxCRt2rOW2PVH5BgJU66xhkEbeOiycymprPUKdy3gOdgliv0Vzokfb6SU1kN7Mgp9VahGUdxMObD/Mzb8arpFyOZdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=pTY0SdSA; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="pTY0SdSA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0baHMT8a3acjUVPhKmQPDtxqTuHfz7bXkAxA3XPC5U4=; b=pTY0SdSAzKcWBvYoUDCinV3p8T
	JV2tZHdZ5X9vj1A//xLnaIcGDn+k+ASZB8wsCIlNcivtyIQKNAUngQiHTtbmQfYOm/5CMkzADNOQh
	VN22HPaopM9GcV+GyOm3sBjrJCWDfnadOBkPfmEXNhOBoGl/aazP4OIl7GoM4RyxTQW25CeNWcj77
	XarqtfK7fCtTQCosg3NLssMiGEAebJF0K1gOKEE1b0nPsxHq+nrN55Avx3RPtlSs1hi2RRjGYJq5B
	7fzbE57Xgig281peA1JxwrIf0XQrkspCT21tjopIwp/NNK42L48MfD9zJwp/tU8x1LxzYtBRAL1Bz
	jvmWFnDA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wsKSW-000SEk-2P;
	Fri, 07 Aug 2026 13:18:00 +0000
Date: Fri, 7 Aug 2026 06:17:56 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, manoj.panicker2@amd.com, 
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com, wei.huang2@amd.com
Subject: Re: [PATCH net 3/4] eth: bnxt: decrease indent in bnxt_request_irq()
Message-ID: <anXa8wKW7Rm5Fm2J@gmail.com>
References: <20260803193135.2030368-1-kuba@kernel.org>
 <20260803193135.2030368-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803193135.2030368-4-kuba@kernel.org>
X-Debian-User: leitao

On Mon, Aug 03, 2026 at 12:31:34PM -0700, Jakub Kicinski wrote:
> bnxt_request_irq() has unnecessary level of indentation.
> Use continue instead. No need to re-fetch NUMA node for
> each IRQ, move to the function level.
> 
> No functional changes.

The transformation looks equivalent to me.

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>
