Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59606313277
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787432224; cv=none; b=hQPL37eMSX1eMDzzvBOXmjzQYsvMSrgxC0wCP3przYRfcuFlpg2e6grYc1w4YeYnv967PB5ZjHtgcF+oK7PCSBH569Jd/VmdTdpkIeZ3emCnTtr5Nr0iuVN2THKo02Mg8qjj3zYdjSP9ofam1dUJXPb75cwxpDJpHg5XH7LxoGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787432224; c=relaxed/simple;
	bh=mvFaavEPXLFxlIH/mrNMpK+qwpraYHSKh9zw0+b9+BY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HMmVQ8kX13URoByBOnH2y80EiXScaRl/+MRhwAMIcmDDog7N7Jg0FUM3+8fku5mmItkJS1qJRQMajqOWXVGUECjhNhEegQkceMCAFefJRLHE9A1SKF46lMB/4dHvjFs/CwwY0pcXISXDvKLLA1jK+h3WfsSQawX5omameYo6SzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/kpPYvs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/kpPYvs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF0F1F000E9;
	Sat, 22 Aug 2026 20:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787432222;
	bh=1aOPWtbKew71wuCl1EKTIq514poH8+nwpRLMzcMKN5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M/kpPYvslA5Hh3+uw7Qn8nyCCsf0MxDz1w8uhR9n3TShjVtv5n7Wk/RdTH8PLRew+
	 uaAxSVZjkjwmq2xA8CvT0Ngy3yk/cymdlTa2rAU9fCHQ//BMrjWpaKy4saugsdWeq2
	 5MDq+gTimoGwXtbxOCgIDVG8Nab1QIpxWKc80UZhT1SzgFiUcDuYY0/KPUtLokZMwH
	 l1lGBkccKMExswWNqc+SH7SYg+zLS8ZrxxIz79e3DsOCvSRDZ44XjrDUjsjxmy2FMx
	 Ndui3/3riqHkpEEjMPJozJ5yotHd9U1rOSawl9oxLKrKmD0FYvm5tthF83p8COdN50
	 DKxGReCrLf9sw==
Date: Sat, 22 Aug 2026 13:57:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edoardo Pinci <epinci@outlook.com>
Cc: netdev@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH] net: dsa: mxl862xx: enable assisted learning on CPU
 port
Message-ID: <20260822135701.7ab5ddf5@kernel.org>
In-Reply-To: <DU0P251MB0699AAFE65D7D30FE7D4C474C4A42@DU0P251MB0699.EURP251.PROD.OUTLOOK.COM>
References: <DU0P251MB0699AAFE65D7D30FE7D4C474C4A42@DU0P251MB0699.EURP251.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 15:45:54 +0200 Edoardo Pinci wrote:
> The MxL862xx driver enables FDB isolation but does not enable assisted
> learning on the CPU port. Consequently, MAC addresses learned through a
> physical switch port are not updated in hardware when the corresponding
> station moves to a foreign bridge port, such as a Wi-Fi interface.
> 
> The stale hardware FDB entry continues directing return traffic toward
> the original physical port. Traffic entering that same port is then
> filtered instead of being forwarded to the CPU and software bridge. This
> causes downstream unicast traffic, including DHCP OFFER and ACK packets,
> to disappear after a client roams to a local wireless interface. The
> client eventually considers the connection unusable and disconnects.
> 
> Enable assisted CPU-port learning so DSA installs foreign bridge FDB
> entries on the CPU port. This keeps the hardware FDB synchronized with
> the software bridge and allows return traffic to reach locally attached
> Wi-Fi clients after roaming.

Does not apply, please rebase & repost:

Applying: net: dsa: mxl862xx: enable assisted learning on CPU port
error: patch failed: drivers/net/dsa/mxl862xx/mxl862xx.c:4571
error: drivers/net/dsa/mxl862xx/mxl862xx.c: patch does not apply
Patch failed at 0001 net: dsa: mxl862xx: enable assisted learning on CPU port
