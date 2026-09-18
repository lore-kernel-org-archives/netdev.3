Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A143E515979
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748138; cv=none; b=JcDrhJG8WQDCH0tu4d4Ejn8hNOg7t6z6RQBcj6eVd3gTyXQiXwwg1qV2sPSQliKls2Ko2mJDVJ1temuU9OyKdA5xXPr5RGZoqmB87b2sC+qBYgMFQrx/5ZHMZIp124NdXsIpC8RFVnTOdN/OrY+3HtCrZY4eiiuXG7BHOGrFVuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748138; c=relaxed/simple;
	bh=qL2DsK3iIAkxnuzj84HK3kh3SaEQKy0LjipLQU8ZDPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaVQBi+l4QjArJWNPxNXS+No1DBvLpx3ggf8Ddmhm4f7ofG3fWgO0rSjW8sxFbl8jQykrGeXVm6S1GWp21IbSkQK5CJ7GyQjCU75w2qsy1+NFYZ0vvJ312tiv5F/q7w/yU2VAtlGGjI+HjBWPIkWB8wQedyC72OQXfKP6M7yCVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDOQHXfL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDOQHXfL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0704C1F00899;
	Fri, 18 Sep 2026 16:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789748131;
	bh=Hl/qrTfNVThcHDtkWLidd7kTkVp5iYgAlxNzRrRRJ9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UDOQHXfL28fjer5Mfclv343LKQjOARc0N6PhFsqadOlAKKV63CtepH7EdE7Kpy+vI
	 d2Xc6xQJYC4ilp86rFOTgQbC/JmuUvgvmFJgWyBJkYUceN1w81zfHnvFULDLlnwPnQ
	 D/Cj0oP/4wm4+qB6EpIVUlYgF8zl7lXPxIFrRMBTHfToS85A0usua0EcaBrLq0iOw5
	 YkgGdeNXvYyJKxxupiBMLTKpBsSEJQ1r5HstMjJZDJKZz3gncTVagF0XcgHv89M24Y
	 ldfUQNRXMYz2qn6CdA4znf9waOgf7ZbVBfoShyRJtRD1YloR/EHMK8YiWfoxysW36T
	 BehML6t7TNaFQ==
Date: Fri, 18 Sep 2026 17:15:26 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel-team@meta.com
Subject: Re: [net PATCH v2 5/6] eth: fbnic: Set AW_FLUSH_MODE alongside
 AW_FLUSH when flushing the mailbox
Message-ID: <20260918161526.GU51261@horms.kernel.org>
References: <178941996343.7700.9376081102002673062.stgit@ahduyck-xeon-server.home.arpa>
 <178942022583.7700.11050671998277309744.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178942022583.7700.11050671998277309744.stgit@ahduyck-xeon-server.home.arpa>

On Mon, Sep 14, 2026 at 02:10:25PM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> When tearing down the FW mailbox Rx ring, fbnic_mbx_reset_desc_ring()
> writes AW_CFG with FLUSH set and everything else, BME included, cleared.
> Clearing BME halts the device's writes to the host but leaves the staged
> requests parked in the PUL write pipeline rather than draining them, so
> on the write path FLUSH alone never terminates the outstanding requests
> and the flush the firmware waits on never completes.
> 
> Add the FLUSH_MODE definition and set both bits so the staged writes
> drain out of the pipeline on their own. BME stays cleared, so nothing
> lands on the host; it is restored later in fbnic_mbx_init_desc_ring()
> when the ring is rebuilt, once the outstanding writes are gone.
> 
> The read path is unaffected. AR_CFG has no equivalent mode bit and
> AR_FLUSH terminates the outstanding reads by itself, so it is left as
> is.
> 
> Both writes remain plain stores rather than read-modify-writes. That is
> deliberate: the matching write in fbnic_mbx_init_desc_ring() restores
> BME and the TLP attributes, and clears both flush bits as a side effect.
> 
> Fixes: 3b12f00ddd08 ("fbnic: Gate AXI read/write enabling on FW mailbox")
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

Reviewed-by: Simon Horman <horms@kernel.org>

