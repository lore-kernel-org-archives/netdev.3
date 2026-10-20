Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488955;
	b=obWbqHMyRjDF925ZloxIx+WhlucpjfiZcnDKJC7dg5kgqbbcYcuvjbSbPkHY0ZaGrJ7q
	 wAZ07DUUyvfgZx1Y13fy6ATousZW8vgD9Fy7uSJAJSwCXKiCXj9cRmYZyEDEwU68WsqX0
	 U1jwyQbzV6VJ6Kiv9ny3rRMHZQZI8xOWTDSRex8LpHf03SUapKuMa6Jhmhy0QlHlSy2ds
	 8gWrf9Aovu2yVeOSlo0vEJFV5cBp2AH0G4s7yilOV4A1N60W/8HwPPLUZMq2Dig2vRqbm
	 KUOZi0TeuvzAWSmjP1u+9JAEKf/Svj+7+aXGSLLy7yQE8ebKA34V6s4GDek9VxtLb5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488955;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=5SrFVlhqweihfl8k9IgoOl+0ODAHoLQXMzmHVFVUY+4=;
	b=AHGYnhcU2Jr2C0O1dBPTr16txhBf3rYsidcOLzjtsmOv5+p+DEj38XgwU+2cEN4bppHk
	 cklHZSZWo9suNjxV1l9o/4N8Ask0MdZjZv/j4IaFJzt/FRTEN7gRrefqwHGWKDioONDdM
	 vpj+a3+nJ6oRp9rwHe6vukIKmrG6A+KembbqYqffgC9TMV9VBNuSQtoxiABKUO6vpyPzt
	 inEc0irf77LeWrZ2HU8y3D5x4yCWWjeY3qsLlkBTGqJT1yPrpZcS48j9tAidUhtMH/tiv
	 7iptJ2cR5lzAvw9zUL10WHQ5YTRlw0esOeb5iH10idluvkK40SxdI8GAH+XJkxgXBIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cTRlJZ+c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC779606A32C;
	Tue, 20 Oct 2026 09:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cTRlJZ+c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D711F000CE;
	Tue, 20 Oct 2026 09:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792488954;
	bh=5SrFVlhqweihfl8k9IgoOl+0ODAHoLQXMzmHVFVUY+4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cTRlJZ+c06ltDCZMu1qT+1KCSvkfPR/mFbvcYtfTtJiRY38RipWa3tmFdGOG/3KWJ
	 /KmzkHzykgN8QNWjssMWMUPG6ReK+03rcg4Xg+CP0C8O6TnYIEV748FmulqCZeLAXI
	 7INdmAKKjUNPc8Woal88/kKYECxjZTMxuAZOsiKqdI6cmGONg6i2SsPcpeiCR27bsc
	 wULs3OlXX8u/dv0MRrQmZJ68Md+5cYYxntorWkviKuHfMJQHr3mJp788u9sLByZAkK
	 NJEZPkoZHExX0R/59AKgldq8rnVcITjkD+trCNCB3VBHRyrDIe6XFUTXcTPd6nNTJC
	 EqbuX84ZlHobQ==
Subject: Re: [PATCH net-next 2/3] net: qrtr: propagate sock_alloc_send_skb()
 errors from sendmsg()
From: netdev-bot+sashiko@kernel.org
To: chunkai.deng@oss.qualcomm.com
Cc: mani@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-arm-msm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 tao.zhang1@oss.qualcomm.com, peter.chen@oss.qualcomm.com,
 jeff.johnson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com
Date: Tue, 20 Oct 2026 09:35:53 +0000
Message-ID: <179248895346.3135.4501440719994077753@kernel.org>
In-Reply-To: <20261016-qrtr-add-shutdown-v1-2-e1cc01ca5919@oss.qualcomm.com>
References: <20261016-qrtr-add-shutdown-v1-2-e1cc01ca5919@oss.qualcomm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch fixes a userspace-visible errno regression in
  qrtr_sendmsg() (net/qrtr/af_qrtr.c) and names the commit that caused…

--

net: qrtr: propagate sock_alloc_send_skb() errors from sendmsg()

This patch removes the rc = -ENOMEM override in qrtr_sendmsg() that runs
when sock_alloc_send_skb() fails. The error set by the helper is now
returned to userspace instead. This brings back reporting of a pending
ENETRESET from qrtr_reset_ports(), as well as -EAGAIN, -EPIPE and signal
errors.

> Since commit 179d0ba0c454 ("net: qrtr: fix error return code of
> qrtr_sendmsg()"), qrtr_sendmsg() returns -ENOMEM whenever
> sock_alloc_send_skb() fails. The helper already sets rc on every failure
> path, so this overwrites the real error.

[ ... ]

> Signed-off-by: Chunkai Deng <chunkai.deng@oss.qualcomm.com>

[Severity: Low]
This isn't a bug, but the body names the commit that introduced the
-ENOMEM override. Should the patch also carry a Fixes: trailer for it?

Fixes: 179d0ba0c454 ("net: qrtr: fix error return code of qrtr_sendmsg()")

179d0ba0c454 has been in stable kernels since v5.12. Without the tag, the
stable backport tooling may not pick up this fix. Those kernels would then
keep returning -ENOMEM in these cases:

A pending ENETRESET set by qrtr_reset_ports(). sock_error() clears it when
it reads it inside sock_alloc_send_pskb(), so the notification is lost.

MSG_DONTWAIT senders with a full sndbuf, which should get -EAGAIN.

SEND_SHUTDOWN (-EPIPE) and signal interruptions (-ERESTARTSYS/-EINTR).

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-qrtr-add-shutdown-v1-0-e1cc01ca5919%40oss.qualcomm.com
