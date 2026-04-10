Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA7327456
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 03:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775792140; cv=none; b=lWYiB4Da/0D28nrIxSqP7QL5Vv6rEEMU+6GlmDsefQG/UIBf5YuWcEbT3Y/6t1T7SA3q9SQ53dPPY1OGCtx+tkZC72ni03p/D8Z/ExzdBq0rEK9Ox6kf/+UBF+n53I/2yS2Joz6wxKCvNiI5JN7rS8MnzHGzs5lTspD8XuPcCUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775792140; c=relaxed/simple;
	bh=7bklhLbfR1ys8v8hxfDXtHey8Rp/a8UoInTCx1wqcss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7mxJmYP9nzEcpcXrlLFIFDvsBE9wykH6JUKaqwuDDFKL3tx2owuZ+9qkTG9SaYJM0IpgznPax5Q5tPz89La0nxReIsZ6oVV3Gbi8IgkwTrv9h0IDMLsGopRmDh7kMkyDjY8RUrM/8QPT8idPgowogWkgE78hBZojhwXoC+rfgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RezecpH5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RezecpH5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A14C19421;
	Fri, 10 Apr 2026 03:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775792139;
	bh=7bklhLbfR1ys8v8hxfDXtHey8Rp/a8UoInTCx1wqcss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RezecpH5XGi6zJlQAcDlO/E+mA+cVXKG+mfp4mZiDMciX5ragKG48onb2lUJFpC7E
	 KGSRkd5LAKOSD4RYXygMWLdnLmAqszsTX4am9u0XjwdhDmlzClAyrL+VVNTWy7wzbh
	 VsS262mEGEoEC09+dmOqb088xofYlVpOgomWGLAgEJFSMfva2/AR4DQUNEAZAQ8o0o
	 LH+broIy0AV4uYEPLkHjKtRBIWboIAqbhkVPCOKA6loQA/cG+Q4Bb5yLtu+eQ1IlcL
	 uAKwZnM/PaTIRISkqinYNhPOxfl7VKkfPx7zbjdzf4Gm92IKp75/bBkAgSsGvKqota
	 ZeBqf8vbco5wQ==
Date: Thu, 9 Apr 2026 20:35:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Xuegang Lu <xuegang.lu@airoha.com>, Simon Horman
 <horms@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v3] net: airoha: Add dma_rmb() and READ_ONCE() in
 airoha_qdma_rx_process()
Message-ID: <20260409203538.35337631@kernel.org>
In-Reply-To: <20260407-airoha_qdma_rx_process-fix-reordering-v3-1-91c36e9da31f@kernel.org>
References: <20260407-airoha_qdma_rx_process-fix-reordering-v3-1-91c36e9da31f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 07 Apr 2026 08:48:04 +0200 Lorenzo Bianconi wrote:
> Add missing dma_rmb() in airoha_qdma_rx_process routine to make sure the
> DMA read operations are completed when the NIC reports the processing on
> the current descriptor is done. Moreover, add missing READ_ONCE() in
> airoha_qdma_rx_process() for DMA descriptor control fields in order to
> avoid any compiler reordering.

Sashiko seems to have more orthogonal complaints FWIW
