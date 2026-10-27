Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793120245;
	b=WCK+no4mUzCOwL8ruBij/Kxr/1FQTKBee+ItH8HbHd5D+oR/BCabjPWkHMokBnOsswe9
	 VMz/ZiS97KVpCwusb8/Wki1Xe/irA6PrdiqKY3Dj14oHeXTeLCb2PauIVu6DyVb8PwLGg
	 zC2bi70pPfqvzMMcij7VeH1DnKZHUSTFATh3e3capG1OpBqrYpflO1/CnAwO0Wpvj0gcm
	 ijjWTaHobMGwwr+vGxHFDkA99wBf/XmPRsT/uWuRrDtQWHD2Wp92/MOjNZ3yo9QlC8iuH
	 sFj/mKXGLpQsZGNFNbr3elBG/wvZn186WIPUfNZWBMMzX0ne5GW4dixU1UGZzRDwU8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793120245;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DfwYy0M+qVECWL1TzkqzBLLNn3NYK+vrlrVjMqGDA2w=;
	b=A3K8Poa1k+iA4utqr35V45/eCMdz8P6uBbeO/RNaZE+HyMbWVZRjmO4q2MkHzcrnx8Ap
	 87+zj+eYvqNv2jfybc+rhowQvdOkGv8jV3dirGgSiI8hiOPceEtiW3gSNOKFR8ZkXbocZ
	 syCeEywTybCjPry5gAwX615BhIwE6fTyE2KvEtON0MLFrQfNQtdExRXHdhfK0Nuft0Q21
	 Jn3CvFmg2e1jfAd6+XN+0dSSsphKRulStmKsK2VA8p2oHdJk+IeA/L5LfWNbsCoLHoiIP
	 9rpvBUbB3EiwH//IDpV21yqn4OuQGAfb4kBQdNX0pM3y8fKQ8xuaDqqJsQJrHcTsJcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lFHnEIca;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215DF606A31E;
	Tue, 27 Oct 2026 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lFHnEIca
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843C71F01828;
	Tue, 27 Oct 2026 16:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793120244;
	bh=DfwYy0M+qVECWL1TzkqzBLLNn3NYK+vrlrVjMqGDA2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lFHnEIcagsWWX97e17JRKkvqwfmSVVM0ksCWmW6cqQ4YdS1QBeh/wnxWBgopmNJTH
	 vaevCmx7bk1tb9G3e60v5W7fl5A+ezSdLm5nC7XJnVcdxHiTA3jrxMtQzTOXAxxl1X
	 Z5w31LUKFl7N8oRp9nXOHLNan3WWnwVHZpfF3QAWlEY8/XMffNxFDFFfG9TUHs9A55
	 oPAreXuUpIICWl///6EpsHPk5j5KS1tFow8bc7c/5o+FGssynSE66clm/IeuJs/3D0
	 Wzl46jZNz+v0Lgj/9RNFox5rQD9hUPUGsRJSqbqABVNHoiaK15tUBwo55vZ0JESTsd
	 NbpHdEME1bq1Q==
Date: Tue, 27 Oct 2026 16:57:20 +0000
From: Simon Horman <horms@kernel.org>
To: Yige Jiang <yigejiang86@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: Re: [PATCH net] net: lpc_eth: release the PHY device node reference
Message-ID: <20261027165720.GO257209@horms.kernel.org>
References: <rc-review-20261022-ai13-13-8a866c920a94@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rc-review-20261022-ai13-13-8a866c920a94@gmail.com>

On Thu, Oct 22, 2026 at 11:59:55PM +0800, Yige Jiang wrote:
> lpc_eth_drv_probe() obtains a reference to phy-handle and stores it in
> pldat->phy_node for lpc_mii_probe(). Neither PHY lookup nor connecting
> the PHY consumes that node reference. The probe error paths and driver
> removal discard the stored pointer without releasing the reference.
> 
> Put the node at err_out_dma_unmap, which is reached by both failure
> paths after the phandle lookup, and on remove after unregistering the
> network device and MII bus. Both puts run before free_netdev(), since
> pldat is stored in the netdev private area. Earlier probe failures do
> not pass the new error-path put.
> 
> The PHY device reference discussed in the linked review is a different
> reference. This patch only fixes the node reference, which was also
> mentioned in that discussion; it does not repeat the proposed PHY
> device cleanup.
> 
> LLM assistance was used for static ownership analysis and drafting of
> this change and its changelog. The review traced get/put pairs, error
> paths and teardown ordering. No runtime reproducer or hardware test
> is available.
> 
> Fixes: 3503bf024b3e ("net: lpc_eth: parse phy nodes from device tree")
> Link: https://patchwork.kernel.org/patch/14502432/
> Assisted-by: LLM
> Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
> ---
> Based on net/main (305deb54c6c2).
> Compile-tested: arm64, GCC 14.2.0, W=1, CONFIG_OF_DYNAMIC=y.
> Both allyesconfig and allmodconfig completed kernel and module builds
> on the unmodified baseline and with this patch. Unchanged objects were
> reused for the patched builds. No new warnings were found compared
> with the baseline, and the changed driver produced no warnings.
> Both configurations used CONFIG_WERROR=n and DEBUG_INFO_NONE=y;
> W=1 diagnostics remained enabled. CONFIG_LPC_ENET was y and m,
> respectively. The unmodified WERROR=y baseline reproduces the earlier
> arm64 syscall-table override-init failure.
> No LPC32xx hardware, runtime or fault-injection test was performed.

Given the absence of run-time testing,
I'm unsure if this is net or net-next material.

But I agree this change is correct.

Reviewed-by: Simon Horman <horms@kernel.org>

