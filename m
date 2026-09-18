Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE5F4FD26B;
	Fri, 18 Sep 2026 17:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789751165; cv=none; b=te6qYVCj5BqYaxIsx8s44fgr3B7MDuOAbG5+NCrQaBWNzxS3nCTvhW7j/SbUjXFj9RGHPe4bANbLufbGMvYm6KxdE5z5LXfcjzdi4oLfXQXaPgYn20i2NUQDTcSpyVH2dcR/IBtN5/ChMG7MYDk1wz+DUKYGP/ZHKFhlka8066A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789751165; c=relaxed/simple;
	bh=TxT401mbN/X0oQrmivqXL24TjETstKfpLXf1ZASP1uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWTRlHoZe6AweU12w+AIHzRxO4oc+5KFIBg3XcUGpimbX+oDZV6rQzucC6yL5UkdsYNoxL4eixTp/gsPz9mbOkCSrhX2Yz+BQU/eR2XDfgyNIY0ZSfCk2udPZKML3/JoepHlLvCtJT3JWbnRz08WGIu07a1tXWKCuGVQjRtz9Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXV77aVe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXV77aVe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718051F000FF;
	Fri, 18 Sep 2026 17:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789751164;
	bh=gcICjSK5IyD2t7/b90H8nOlZ5YYvxRv6ttDXIKR/d5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eXV77aVe2J7JfuJG/8WQDEkapbHcXL6YHmVRTiuNf9B5FtlqQS9BIeyYR3T8Sl2LY
	 C31173QQsl/bhC5hoUd6y8CNfy2Wzcecn7RMnBlBQb43tYrzLkHQuuFSKJgss3HH2x
	 Hd8LkuLOfJmhlx8CwPJ4/D5FyPaSM+MxKnkgV+dp0W0PoQus5SnU+61Dhyu2Qmg1eO
	 Nkx9+J7jhpab7yoIz6kk0gLwYsPyx0toSTQNKwGmaA2ir7XowaPq5kgQhYOJyM2yZr
	 T4tIXWhbWsk/nPIng9za29JQ82BMe/l1aWco+uyX7e9Cna2r3Y6s0PTCRQnDICFN15
	 ys0/WeCIMf9Ow==
Date: Fri, 18 Sep 2026 19:05:46 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Daniel J Blueman <daniel@quora.org>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chris Lew <christopher.lew@oss.qualcomm.com>, Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>, 
	Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qrtr: resend HELLO on MHI resume
Message-ID: <nhbc6epjziyb455l6z4xqunfb74bdboycuq52vt6nrr7fqjo3z@ruh4isxdkyom>
References: <20260909055846.16539-1-daniel@quora.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260909055846.16539-1-daniel@quora.org>

+ netdev

On Wed, Sep 09, 2026 at 01:58:44PM +0800, Daniel J Blueman wrote:
> Since the MHI HELLO exchange was relocated, it is sent only at device
> registration. During a suspend-resume cycle, the firmware in WiFi
> cards such as WCN7850 indefinitely waits for another HELLO,
> triggering:
> 
>   ath12k_wifi7_pci 0004:01:00.0: timeout while waiting for restart complete
>   ath12k_wifi7_pci 0004:01:00.0: failed to resume core: -110
> 
> Fix this by triggering the handshake from resume_early in the MHI
> transport.
> 
> Validated on Qualcomm X1E-801800 on Lenovo Slim 7x across 10
> suspend-resume cycles.
> 
> Fixes: 544d85de4dc2 ("net: qrtr: Send HELLO message on endpoint register")
> Signed-off-by: Daniel J Blueman <daniel@quora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Since this patch fixes a regression in linux-next, it'd be good to get it merged
asap.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
