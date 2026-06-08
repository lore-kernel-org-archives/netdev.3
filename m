Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEA93769E7
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780953197; cv=none; b=eYR/fhaI2DPiNA/gxfD0j5HaFLo1Uq6KLtKrdH9w/BfC9WPdNwtP2o2FFo3Yv/4NdicGBqvif5KHeRDkXcnkyvNo+fSsKVMp3lMWTDoYTTcgKAZt9bl/adPrhKor4Gg9IXo5Bn/gMLSWv5rOm4bxTNjZc4C21SIG4FXzTK45su8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780953197; c=relaxed/simple;
	bh=KlDs1Yb70V+ogVTc0HnQcHvKvwpsnDNCGvDvCWb18xc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jLDAezLnOMstBvj1hU7TwHQfSH855qYizMl1Xq23Mwqy3S+4uvH1dpC/MuxLro3RUEq2bFISpnxenfyUJFwDHRUvwq7a5yPsZ/K8EqkDZAXRF/7hoPgoLhgno/O6mDj+qClcd4NuZQx0148/Fjm5YiviiqVMKbMZ8BfZwrYAdEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YN/jIl5M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YN/jIl5M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D582F1F00893;
	Mon,  8 Jun 2026 21:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780953196;
	bh=PJYIVRsnEfzN0c9P01fI1dN7oB8nM7cwGJvoEdA6TLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YN/jIl5MObRBfx/SpWPK/dZzMLdo91OtNyczFDf9UXAoWWoxCdpA9Y9NWFgnH4OcO
	 AZ3hZscTujcllsZeQYHOMVqMRV3NITV67M/RRO2iks4YUKHeWXtzsOyu5x8fR7BD2p
	 yS+OyDXLW4z+nhNpzRgVpxmyxtVYR9sIVfR5dTEochLLp6ePlXqgrEfiHgFyl3qiyr
	 YXo4drDs/DEGiksRvKoLkzIU1sbYY9JwgM0ncVcm9aWxhyuAZGvn/dK/tWqr57I5uP
	 GMFQlwUbHLCv870tWEgzeOwfUXL2p0mFr/ema3P9LkiQlWt/CmvqkJISlPa86Aud9r
	 iAwLosbZ+2SLQ==
Date: Mon, 8 Jun 2026 14:13:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Potnuri Bharat Teja <bharat@chelsio.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net-next v1 0/10] cxgb4: Add Chelsio T7 support
Message-ID: <20260608141314.5c79faad@kernel.org>
In-Reply-To: <20260607035220.528439-1-bharat@chelsio.com>
References: <20260607035220.528439-1-bharat@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  6 Jun 2026 23:52:10 -0400 Potnuri Bharat Teja wrote:
> This patch series introduces base support for the next-generation Chelsio
> T7 adapter family into the cxgb4 driver. 

Oh wow! I thought y'all disappeared.

There have been >50 patches to cxgb4 driver over the last 3 years.
Quick grep suggests that Chelsio only bothered reviewing a single one.
You are not fulfilling your responsibilities:
https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html

This is not right, don't you think?
