Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A7C227EA7;
	Tue,  6 Oct 2026 01:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791250303; cv=none; b=LkzFI06nsRZ26QOi5drSFGlZLpIzduxUNPvQ/FqPHPSP3Dv8c+LlK3PPD1kJzipd11NjaqKXfAk0cUUAmBIXbcjidwlwkheV/wYg4T39GNVLrlPFR5vUzycTeUC1ezxjoA9s6JKegEPT6ei9dCutGrwoZgXoNsns01a/TateXkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791250303; c=relaxed/simple;
	bh=j9aRdpHNKjEwSBk8lnQiieO4mA5w6OYUDRsLye9llEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FSUzb2dTMi7LhrO2SOU6tp5Sj7NZL95p/R0U8hlMTUd9ytn/k2qJMmMiPlE4YSHkMR+5zSDv6H29Stdp4MjZSz21TpQlbCbyIzQbad5eoJPOHcDtPq6Wp5KSdDIJcnstyxIzC34twrVADAesJ5KjamNnWSfmYqe0kEnTLQQhoGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSGzfQJN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSGzfQJN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD191F000FF;
	Tue,  6 Oct 2026 01:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791250302;
	bh=NpEddScD2MhFM4asg7yiG6V4QAx3qOAr4L0trrAeG/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DSGzfQJNk8YDUB6RCVCWRf11WAy/Zpx4knV0Kgrw3/JKi7q/CdXMevvxKLMvnDFP2
	 mSzaJZ4EgWIZ8PQnXd3wxCDdwdVoNVhJsAK2ZjE58NTCei9wGQc2SotfZ6hQxs+CNy
	 BXXq0tK/q5ZKlBko9FxXpSOn2Dp9oMC3nBKikcnln7w8I1+p/LWDDpB2lkYJ3Wr+Y0
	 U+ZZ8um/Ob8Ll+bm0vIK1PAZ5hPmKF1KLUz23xkCkDFLDAMPqTP2soENzWHWguYW21
	 NysRFPQmThuveOpNtNzYhtUgsI2C26+wlare582bendrbtnas6CKzDvE3qBseXLPfU
	 Y8pVpR2pE3cEg==
Date: Mon, 5 Oct 2026 18:31:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Roshan Kumar <roshaen09@gmail.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, chopps@labn.net,
 linux-kernel@vger.kernel.org, lilly@aronleigh.au, shubham@octane.security,
 gio@octane.security, robert@octane.security, paolo@octane.security
Subject: Re: [PATCH net v3 0/2] xfrm: iptfs: fix queued receive state
 lifetime
Message-ID: <20261005183141.5e246d3e@kernel.org>
In-Reply-To: <20260930050307.1978654-1-roshaen09@gmail.com>
References: <20260930050307.1978654-1-roshaen09@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 10:33:05 +0530 Roshan Kumar wrote:
> IP-TFS can retain received skbs in its reorder window and reassembly state.
> Two lifetime problems interact in these paths: the shared drop timer
> does not track the two states independently, and retained skbs do not
> keep their input net_device alive.

  net/xfrm/xfrm_iptfs.c:1346:2-12: WARNING: NULL check before
  (net)dev_{put,hold} functions is not needed.
