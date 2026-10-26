Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019283;
	b=ay2CqwmSvV0TRfNOpB6lyHw7w08BZRiIr+TSM9XIW950q1d26fVEz3qFYtXDZpICBUvv
	 d16UgGCYsXEnDwV9VITNaroGAW56OaDnna5qWQDKKa5z4glbE1NEWC6njkEe0Og8aoS5u
	 V+FMO8KI3ha7OnJ5sak/+Ys8EMfpxA1NhZzPwP22AQU9RVJvQMEuxKqC4RlDd3R58EjVU
	 V4kTmT6l53/W+h+rftFhKLFQQOj0b4EQCKzMYEOz4VItLhCsIs9GpldDq63nTkTd7jvrX
	 TWE8LQucXK8kd7rJXiaBeF8X0ikrWIBENRZopFaL24yNqMlsid8qzK5OSyQcBk32fpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019283;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=stTjYWU9LTYpEyw2KkJjltK+cHL4RbEjtOc13i0AFwM=;
	b=d1qHVdAbQn5u/Q11cQ35iGrJFX6zoUPL7rG1OKcFdYou3P0gi1nddXPvwQNeAFFK7cIz
	 PSKNa2yGjY8Nz4FFyW4DNWPp0NkQv/SpYWCi2IF7I1XELEzTKrNRarXb/TvaUGx+QesU6
	 O+GxqlSEcRG15pXc1A7o2Zn+IX5GUzfWyDrD1iVnX7kJo04FA+X+99Un70AxQTYJHZkM2
	 OcQmVGnyb8pIz2pFrgJQ43FnqFvE+f37ltsk6gTq50QwRdgZYEWZkBU1VbDfPUe+CvB+I
	 2XOCTboZwyt7HyR/R0X3x5PVMrbo4M+jhJZDBEO1ontbWdIpsjsxsWNNb1EycdMM50Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNaynk+U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7466A606A326;
	Mon, 26 Oct 2026 12:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNaynk+U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E0F1F031E0;
	Mon, 26 Oct 2026 12:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793019283;
	bh=stTjYWU9LTYpEyw2KkJjltK+cHL4RbEjtOc13i0AFwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZNaynk+U/kzQg9lGtiediFdN13gn0uVHXrUnzWUmSft2v2ONs5rHjf0H06Io5uRqa
	 Rxbu/YS+UEnjKMYFez8by3pRr3qRJYVS+jzrBWkdkmt5DhQ6jzymWUKyUNfJXC4u92
	 d8hvFfVwyE6xtjkfgNK27+cDb9dPCBKBLuaajlpl7LcRPA3uOmR3GuvDPE/8oJ1Tqf
	 9uwLfKklmvmr0v4sleLDm83QJHzw/SQwW7ApM6ROt9RgYSflhbZ+VJ2gt7aTgrY1Zk
	 qLbnMvhZov2qd7R6reKCNyVZLblLWmKjh/KRZn19KNeqk250W/Lc/pm0b6i3eoQRtH
	 3m/6w9T1za8fA==
Date: Mon, 26 Oct 2026 18:24:34 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Chunkai Deng <chunkai.deng@oss.qualcomm.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-arm-msm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, tao.zhang1@oss.qualcomm.com, 
	peter.chen@oss.qualcomm.com, jeff.johnson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com
Subject: Re: [PATCH net-next 2/3] net: qrtr: propagate sock_alloc_send_skb()
 errors from sendmsg()
Message-ID: <at9NSu863BxqKxOx@debian>
References: <20261016-qrtr-add-shutdown-v1-0-e1cc01ca5919@oss.qualcomm.com>
 <20261016-qrtr-add-shutdown-v1-2-e1cc01ca5919@oss.qualcomm.com>
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
In-Reply-To: <20261016-qrtr-add-shutdown-v1-2-e1cc01ca5919@oss.qualcomm.com>

On Fri, Oct 16, 2026 at 01:58:19AM -0700, Chunkai Deng wrote:
> Since commit 179d0ba0c454 ("net: qrtr: fix error return code of
> qrtr_sendmsg()"), qrtr_sendmsg() returns -ENOMEM whenever
> sock_alloc_send_skb() fails. The helper already sets rc on every failure
> path, so this overwrites the real error.
> 
> In particular, sock_alloc_send_skb() consumes a pending sk_err, so the
> ENETRESET set by qrtr_reset_ports() is lost and userspace never learns
> that a new controller came up. -EAGAIN, -EPIPE and signal errors are
> hidden as well.
> 
> Return the error from sock_alloc_send_skb() as is.
> 
> Signed-off-by: Chunkai Deng <chunkai.deng@oss.qualcomm.com>

Since this patch fixes an issue, it should have the Fixes tag and stable list
should be CCed for backporting. With these added:

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
