Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23FE488748;
	Sun, 18 Oct 2026 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327140; cv=none; b=n2YwdwoOC+hCfL3psXs4aIGnw7znZEXkQP9xKtJP0zo7KahCrLAyC+6CPzPoMW7rQPQUmtkYykikXX5MpOdY4oWSO4WFvbO+4E9U1kPpqlWzkm/YYzOaxRbWBb1M2756KXDc9TWJbTDokck2TErkKKbpsH+dTnQ59SC89v9zlC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327140; c=relaxed/simple;
	bh=oVPdqOD1qQ/9Bwu47b0AGq40Ro6mBbDMSB4AIRFG6vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnK7fIqOMQqHVJxM05N+1zFdKG4BEQlZsgPSdBH4EQZL9QW1+bfymlfGi+vna7vvDQRl7iwp2YdHEKRKvxGuK97FRzJiiVcsbuIsSfv/kjNdkmQ2+2B/R4pCXEBOFbksH0E91zYPcr7DNMhWt3OZOMz43AFA3VEnKWJkP2oWWDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Df2zhNES; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Df2zhNES"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DE21F000C4;
	Sun, 18 Oct 2026 12:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792327138;
	bh=h1LXYDOO/Z8xuh1wGAPdOZloEBmsk/yg3LNiA+dYzDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Df2zhNESQtjsQtxvephl4BVpUKlUm/CEh2OhVKE8c2EvnEcDHQsrvymQy8lOXVNmq
	 Ou4FqX8DU5qu/P29qOAPvNpuOlxpzM2ZB4aB4UWSCvqKyFU9/2tZv4X7jt04OgvaYs
	 59splyZzCwZnMoShPuAHXRbZ4Hkbo4ikRv8XQT9LfNAvsQbvi5/mnytoMzX1qYTrfn
	 dclBZjMgjSV4vVvHo6JLks4biiwmTeeoFK9zVkqCYHCdWrgQre09LL85c4AzBvpnQ8
	 ATYGexPalqMu1YJTFSdX+OtgCZvHS5yGeYtUW6xT7NmJCbEJ79E6cmsluEBzpJlMmj
	 zKuhQxEZQoS9w==
Date: Sun, 18 Oct 2026 13:38:52 +0100
From: Simon Horman <horms@kernel.org>
To: Jie Luo <jie.luo@oss.qualcomm.com>
Cc: netdev-bot+sashiko@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, quic_leiwei@quicinc.com,
	quic_suruchia@quicinc.com, quic_pavir@quicinc.com, corbet@lwn.net,
	skhan@linuxfoundation.org, rdunlap@infradead.org,
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, quic_kkumarcs@quicinc.com,
	quic_linchen@quicinc.com
Subject: Re: [PATCH net-next v2 02/11] net: ethernet: qualcomm: ppe: Fix
 multicast queue config table access
Message-ID: <20261018123852.GA503057@horms.kernel.org>
References: <20261011-qcom_ipq5424_ppe-v2-2-8c7b057e2c43@oss.qualcomm.com>
 <179181020968.434549.112728167970187942@kernel.org>
 <56401e91-6d8e-4489-ab34-ee25af031a74@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56401e91-6d8e-4489-ab34-ee25af031a74@oss.qualcomm.com>

On Wed, Oct 14, 2026 at 03:20:53PM +0800, Jie Luo wrote:
> 
> 
> On 10/12/2026 9:03 PM, netdev-bot+sashiko@kernel.org wrote:
> >> Fix it by converting the queue ID to the index of the multicast queue
> >> configuration table and accessing only the 3 words of the entry.
> >>
> >> Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
> > [Severity: Low]
> > Should this have a Fixes: tag? Commit 806268dc7efd added both the
> > multicast_queue_cfg[5] declaration and the absolute queue_id indexing:
> > 
> > Fixes: 806268dc7efd ("net: ethernet: qualcomm: Initialize PPE queue management for IPQ9574")
> > 
> > ipq9574_ppe_qm_queue_config[] covers multicast queues 256 to 299. That
> > means kernels which already have the IPQ9574 PPE QM code take the broken
> > else branch in ppe_config_qm() on every probe.
> > 
> > Since this fixes code that is already merged, could it be sent on its
> > own to net with the Fixes: tag, rather than as part of the IPQ5424
> > series?
> 
> The IPQ5424 QM configuration in this series depends on this fix. The
> issue is only theoretical: it was found by code inspection, and no
> user has reported it. So we would like to keep this patch in this series
> for net-next, without the Fixes: tag.

Reviewed-by: Simon Horman <horms@kernel.org>

