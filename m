Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019205;
	b=a+PRNi9EaCrLYPwEv2LDljUUEJTY/NIGCWsTFU44amhT/VLb94nHYynKl5Hb3Oqal6ad
	 hrWiGmMpEnwk72+rM2KH+Dyro+wYK0XZME7dd8DsZ/ewZyJzEnAVxDRmCY6pKNJjDtTX3
	 TXpUAV3PG77XGLkbXGYbbf5Y7+W21s8MFOJWppQ+HIDv9q7XLpOiiiddB0wIabILNRwV+
	 9Ril99MldjHaJJGHt9dJi4i6WxtnAAKIQ8RuuWwcI7GokCE+KXE3JACSOfQeMboZnW9dA
	 yCo8VArYXvlcdL+E4Z/UgiB6Tq7xuh/wDr6XdGeY4bcRqfUbIfwH0EKFt/KICBHEMwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019205;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=wNAm+QK6fuK2feImJ+iyd7AbEuB0Qapzr4gOqGefZxg=;
	b=d4IADDhXW5yqfUBSqNvlxO7/tpg0FNu2SED5xo4y7asJLac5MwFm81ps/xYNuHKKLf1c
	 gJdbi9eHBA4oDF+5ZAlDTZPSBIM73DvVJv9bDmA1mA8em2ptQgOMB05h2O5qQcUB4G16f
	 BLgb9veydzfeAT/BNWQapsJxW5mmj2DSKp/2uyB5atOxmaLxN4aKXhGzhBb8H6oRdXZiR
	 4LRq0wz17mGdfkYGxZ3WiVclqHY5eSswQllBCAgc99RlZYot4Ls6urZ8dbEj/Qoknme+q
	 VQB5p9lwEqRVDBinkcb0nufa8zsjE36/8YsOUcLsRN419foX2hd6IEHzHqpPPJF+Whg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GGha7X4x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324F6606A31B;
	Mon, 26 Oct 2026 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GGha7X4x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49611F01828;
	Mon, 26 Oct 2026 12:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793019204;
	bh=wNAm+QK6fuK2feImJ+iyd7AbEuB0Qapzr4gOqGefZxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GGha7X4xi3MROzPTAp/gn97EFZNPWFVLEnLQDa5yWCac3ywERdPK2pd9YaQG7pViL
	 DMnrWeth++TYI+qeTsAJr0RCbaX6Qx4eRkNOTVjpsG/X1JCu+c1YeBSSXTIMmMx5Dh
	 zwmr3UWC004jDEroEZWgnauPfvYD7IBoSIK27dWZvm/OdDau3VxeV+Ixi1YGCkNN8O
	 lib9228tn3GRqimPsXIpbt2VlAVcy40xKurzOzeX3OKPqbQWp8jsHg4ZXsOdQ09e9u
	 I9umW3dhG8ElDOJf3BUIzVB1iHlPvvv2UFeU+8BKpgzMYgLRHiKoSrpf7efImvZEeS
	 y/QSkt8BTIEhQ==
Date: Mon, 26 Oct 2026 18:23:14 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Chunkai Deng <chunkai.deng@oss.qualcomm.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-arm-msm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, tao.zhang1@oss.qualcomm.com, 
	peter.chen@oss.qualcomm.com, jeff.johnson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com
Subject: Re: [PATCH net-next 1/3] net: qrtr: do not take the sock lock on
 blocking recv
Message-ID: <at9NMmRJSZhiT3yg@debian>
References: <20261016-qrtr-add-shutdown-v1-0-e1cc01ca5919@oss.qualcomm.com>
 <20261016-qrtr-add-shutdown-v1-1-e1cc01ca5919@oss.qualcomm.com>
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
In-Reply-To: <20261016-qrtr-add-shutdown-v1-1-e1cc01ca5919@oss.qualcomm.com>

On Fri, Oct 16, 2026 at 01:58:18AM -0700, Chunkai Deng wrote:
> qrtr_recvmsg() takes lock_sock() before skb_recv_datagram() and keeps it
> while waiting for a datagram. Any other call on the same socket, such as
> sendmsg(), bind() or ioctl(), blocks until a packet arrives.
> 
> Take the lock only once a datagram has been dequeued. The receive queue
> has its own lock and the enqueue path never takes the socket lock. The
> lock is still needed around the copy and skb_free_datagram(), since
> TIOCINQ peeks the queue under lock_sock() only.
> 
> Testing SOCK_ZAPPED without the lock means a recv() racing with bind()
> may return -EADDRNOTAVAIL for a port that was just published. There is
> no ordering between the two calls anyway.
> 
> Signed-off-by: Chunkai Deng <chunkai.deng@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
