Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021773;
	b=UNTWqRZwqRD2T0viSCQ+fMvzPf2tBcF2MSRdh6mUAAW1rkq08BWOx2Im6l4wJCNB1KrI
	 96s8/My/n/cAwCvspKr4adg+kf6FNnkpw+AFHinqw0hX9KdnbhirC1EkuJ4/xdq2m1MUh
	 vKgEyXNDrFqSADfH/NbEAYPTAouqk76Zfp90x1c9/k6gihn19QhaZh3JDPBmmOHkYzrLi
	 nT8jtVsBPif38LAQErFYMwPa3FlopmYIhGtUQQxHTA7hD0pqZS1L5imbnZ9SdS9pRwcSL
	 MQj48vr9ngjSVrepX/eOopUv4u9IFy9UcGo9GCjH3likHF84zHn5Wco3XMmYCtkz4/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021773;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=p1WtSQn7L0DYGC9pR9BMqKWHT52U+ozj60nsEhplsp0=;
	b=l7Q358NBMo44nKJs3x0r32BApbC8rNb2yTCARrOEGBeC3HVR7ricBon3WBn2ksPvAU32
	 GSJ189j6h/mJ//3WxD2gM42Kkji7a0GSzKA71Rk/VnhKCbnfiK3jSxH8DN/OLWloN2yrV
	 ZkB4dwP76DhglkY1F2ZYuTz7L7GIBaBaLMzO9qHe9Z+oBPVjy1uh9vQL+2Ypx4ab5wJHZ
	 2+KrnJ5tZpA6umEndVvwQNJzut9XY1g4ANZJwaWohcUB4uPb3d56dXYlYe1MeeTZrmijx
	 zZVF+PBgUVINx+1YN+9dDirS10O8kGbH+Q0aeqzn2M7Po3eWsdavOZpZYcbfbqH+NjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DatefYcg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894EE606A31A;
	Mon, 26 Oct 2026 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DatefYcg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D010D1F01825;
	Mon, 26 Oct 2026 13:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793021773;
	bh=p1WtSQn7L0DYGC9pR9BMqKWHT52U+ozj60nsEhplsp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DatefYcg/w9HGFfuOna2c60G1rJCinc4ssy2DkZ0bAxS6PSuFH+217D3rCKY191kH
	 ak1SF5ksx5VQuTXD8EZE7PYHw1Ll8x5jxCT6isWnxZd+5kTvjSQpFdACH+m7ZLLhJJ
	 enkOVXHZaIPa6YgsGeaSzWaR3J0B/0z7YMybtdEqs8LpCnb1so8xKPFBME/DmbBsT4
	 wIdeX97TtU+OGkb+NvOY629Zy1JIyOUBawqgsh7hfv5LJWxBrJq7B63sfr4knVp2y9
	 0iqGGw6gkbeQ8a7yG56uk8pt3pfCF6Xec6AVtKpUOYeA/kVMYAWzTIQdSu8hxubz7E
	 7zaoHwN5a5fQw==
Date: Mon, 26 Oct 2026 19:06:03 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Chunkai Deng <chunkai.deng@oss.qualcomm.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-arm-msm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, tao.zhang1@oss.qualcomm.com, 
	peter.chen@oss.qualcomm.com, jeff.johnson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com
Subject: Re: [PATCH net-next 3/3] net: qrtr: implement shutdown()
Message-ID: <at9WXQsV6pZzNZuL@debian>
References: <20261016-qrtr-add-shutdown-v1-0-e1cc01ca5919@oss.qualcomm.com>
 <20261016-qrtr-add-shutdown-v1-3-e1cc01ca5919@oss.qualcomm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261016-qrtr-add-shutdown-v1-3-e1cc01ca5919@oss.qualcomm.com>

On Fri, Oct 16, 2026 at 01:58:20AM -0700, Chunkai Deng wrote:
> QRTR uses sock_no_shutdown(), so shutdown() fails with -EOPNOTSUPP and
> there is no way to wake up a thread blocked in recv() on the socket.
> 
> Implement it the same way as unix_shutdown(): map SHUT_* to the
> *_SHUTDOWN bits, set them in sk_shutdown and call sk_state_change().
> 
> Do not use lock_sock() here. qrtr_sendmsg() holds it while sleeping in
> qrtr_tx_wait() until the remote returns flow control credit, which would
> leave shutdown() stuck in an uninterruptible wait. Take sk_lock.slock to
> serialize concurrent callers instead, and use WRITE_ONCE() for the
> lockless readers. Do the same for the store in qrtr_release().
> 
> A sender already sleeping in qrtr_tx_wait() is not woken by SHUT_WR;
> later sendmsg() calls fail with -EPIPE.
> 
> Signed-off-by: Chunkai Deng <chunkai.deng@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
