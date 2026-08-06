Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF0434A3A5;
	Thu,  6 Aug 2026 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032037; cv=none; b=A2fpcppEJaMIHDFUR6DmGukWTsTGo2nQqz33YegwpE4f12ktFXCRMz9fSUDgl79td4dlwOGIu58t9fzrYgRKSHsy/wuFlTq33a1Mj9vK/QaZHahByXDAzy5q8WjgOa4BxBPj56SIl35fnj6o7/d4GbF2ttJ7jlB3ZL8oLRRrDAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032037; c=relaxed/simple;
	bh=GQQtlbmHCePYVY5eOQI18hkECTDR8dzelaGl+os7pCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+oT54lW6JuDiw+QKZNPRNbc3Wi3K2TWtV0OVSdqnwhOdU9DxwVVsYrU4bAKdRjbik7AsZOQgmqFXC9XAg8MJ+1ROK5tYMJRKtCidLYrt1tytRwW0ZKmNVsmq/Ou5/gebejQYeOg9EYC6cAvb7vBIMCTik40TwYQ6uNjPrYqj1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkiZnML6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkiZnML6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5C81F000E9;
	Thu,  6 Aug 2026 16:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786032036;
	bh=X/zghklyEUV2DR/FkrbgmJWs0c4l+oLlawR6unkarUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WkiZnML60HgDyvVIhA5dzExZ611Dw2YBOm/60DwMgRrByk08j+LplpVZbaNd7PLWG
	 v9Iu483Vh4lZw+mdZ4dyVgP682eNuUGaUNXk3mCfbv/jQGYdrdafMVRY6HfwTLDUWW
	 eSYQXTBBjWvLbKxLvDrVh86Da6bcWWk8miJeq+GM419VO8PJIqBtJ+U3nMCb+Kb9aP
	 aLTLlTagGLP25cWzTDEix2FBmoBZfbk36NYCrcY3rkJo0DtX5tMDNy6+kFtfUhHcvm
	 cq5/HvfNt1Je05JhjxhGwzpmshkxmJ2NqC0FRyHMWOHGFqxyiSIAUOCpmru+rdih9j
	 1iXyPD8JfPEtg==
Date: Thu, 6 Aug 2026 18:00:23 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?utf-8?Q?=C5=81ukasz?= Patron <priv.luk@gmail.com>, 
	Simon Horman <horms@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-arm-msm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qrtr: ns: Raise lookup limit to 128
Message-ID: <oqknkvlljjxfo5stpc3yicqzgs6g4an6lg7ybrll4zyvxr675q@hm23pe4cpxhm>
References: <20260804201919.1148015-1-priv.luk@gmail.com>
 <20260806132630.GC51943@horms.kernel.org>
 <CAJmEJMzzuY=hJxo-0yPSfnOymcdd=O9zxmOxdeO_hCB3sbSrLA@mail.gmail.com>
 <20260806072702.71b2e604@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260806072702.71b2e604@kernel.org>

On Thu, Aug 06, 2026 at 07:27:02AM -0700, Jakub Kicinski wrote:
> On Thu, 6 Aug 2026 15:38:22 +0200 Łukasz Patron wrote:
> > After merging v6.6.142 into a downstream AOSP device, it's stuck on
> > boot animation and following log spam can be observed in dmesg:
> > 
> > E qrtr    : ctrl_cmd_new_lookup(): QRTR client node exceeds max lookup limit!
> > E qrtr    : qrtr_ns_worker(): failed while handling packet from 1:16600
> > 
> > No idea why it needs more than 64 client lookups, but it appears to
> > work fine with 128 as it did when there were no limits.
> 
> Ack, I'll fold the explanation into the commit msg. pls don't repost.

With the added info,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
