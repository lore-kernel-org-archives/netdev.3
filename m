Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13165547070;
	Fri, 18 Sep 2026 22:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789769726; cv=none; b=ZOW7ONHTolUfy7zBpkyc0K8+eWbIB/hOP/XGTaR+nfx8LjSTbKelnbJG/FRN0xpfpEeM+QvZB5O5uBHPPh1TI4skRjO2Y7/XUyKiC6+jrve+gT9yUhVZGv/oaHBCelAQNFnUXdTomvsysEgH4c19T1dfZjjDYuzZX44fFacM7Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789769726; c=relaxed/simple;
	bh=fN8y45PXKcbM4yoj3xa94QofTBbmHJjgD4PwOWGEQuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QqkZGquBsZcmMaOnOVBaLg5yGqytdELSkJBV0x35WfbSGJ3qA4HOulz5djYiipSCLVvVIsiUqQOe1wWZnzTq3sg/EAxw0zI6HVCiLb3MLpu0gj/fLwAXbSQ4j5IZ/4Kxhw+DgitALR7E5wPwlJjVOORincySYVvAYWGmV5Pj1rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZoRtcau; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZoRtcau"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7E51F000FF;
	Fri, 18 Sep 2026 22:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789769724;
	bh=2VX29fK22A0GVBgQXNalWm4RKvRMnao6Y7xCzTiKoOk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LZoRtcauKQs2K3f+ieuSeR3XnFUXmDyfMeYVA4WCl0JsLSKVEJiVniSLrLIwYzatT
	 /btFj6V9HlIXpqvFFWlCdShtfOkoBADNeHxF4H8M+FSFTP333NDz+R15ta4+4iqpKJ
	 1SbNhQmMeq/8UkcBjlVqHqF1FTSq0p2CsjC4QUrR/exgi/hWUV7SOBeCekskGEcCtQ
	 dB3+mfLf58v7Um07fPC4O7JJej5QyTPE2M8Ko8Z4P9B85ydmhrhD4t7GsNhUNx/V0Y
	 q2KQCwb9JNHUWQoiH77UphAWr7wxoVOLIyrOrgkfRSJLCJ8pkHVvLcXlK/KBoIeUOU
	 yTdGgYx41aYng==
Date: Fri, 18 Sep 2026 15:15:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: Aryan Sinha <sinha.aryan03@gmail.com>, Sunil Goutham
 <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] octeontx2-af: remove duplicate SCTP port flags
Message-ID: <20260918151523.2bf90e82@kernel.org>
In-Reply-To: <aqzZRG5WcSZYGu6M@rkannoth-OptiPlex-7090>
References: <20260918060323.53860-1-sinha.aryan03@gmail.com>
	<aqzZRG5WcSZYGu6M@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 11:55:08 +0530 Ratheesh Kannoth wrote:
> On 2026-09-18 at 11:33:19, Aryan Sinha (sinha.aryan03@gmail.com) wrote:
> > proto_flags ORs BIT_ULL(NPC_SPORT_SCTP) and BIT_ULL(NPC_DPORT_SCTP)
> > are present twice. Both fields are already covered by the first pair, so the second
> > one has no effect.
> >
> > Drop it. No functional change.
> >
> > Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>  
> Isn't this a fix? Please include the appropriate Fixes tag:

The patch has no functional change, how could it be a fix?
