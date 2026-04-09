Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4B11A3154;
	Thu,  9 Apr 2026 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775753132; cv=none; b=m6cgEeXnsE4RkO6kg7MA5ucuUHxT9JaViEi29DUPmUxjwtQm1uwtM/J9TgBryKvPfJJWTK3QnF6lxnY/HrrubtSnT1hjiFo2kdP7TJwggkpxg6IpS/EmhUqK4a17JuiHoDiiUomwPNVLOJs8phfpFQyUroNa9nhM5AYjtjdko1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775753132; c=relaxed/simple;
	bh=dVXr03RoqzK0gwU6bzmF456fwdFwS/5nKDD/1hodd5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIAHftoqb0ciOl9llHAvhs9AtWt/kIitrnxUGDWmViVLaqAyBgG5ueHmPuM4W5ucgp6KTyHkYgYvLm/XSDfyz2iO0eVrz6Vvx423dbFIykxMb0pLTvYj/uIo4kZksQHQDcfmrsU/z45YV59SB49wny3qr62lDzSqZ1iSe4rFfoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xm0ORjg9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xm0ORjg9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66917C4CEF7;
	Thu,  9 Apr 2026 16:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775753131;
	bh=dVXr03RoqzK0gwU6bzmF456fwdFwS/5nKDD/1hodd5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xm0ORjg9v241Bg2dH6v74j+EqROwVDJfRzUr0uqjUU9Ah2QXV2ut8YowwaLC7mMTG
	 NlGvyS3iaU0oM5K84yZbfrXzkx6J6D0Y6Hl+uj104854yfsPfqTNdk/FCGsLetL9kK
	 3UhQ8NjoPno0mZHId3+pZA4mo/5o0gOxiT3r5YABoq4JKwYSJjwJktHjgL08KY65sN
	 aimgMdmn87LeBDMoZqBoYytLEMvjO2+Y/zorUnC1OO4YcG+tGU1t8/9BBu3BhC+6K9
	 JnZXVMkue4cgM4+IlMtIarb1o2C/O92gtEjb67+ZBlCfGve5IaSqxY8gmiEDtwip1l
	 Uy9M15tJtXeIA==
Date: Thu, 9 Apr 2026 17:45:27 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?TGVrw6sgSGFww6dpdQ==?= <snowwlake@icloud.com>
Cc: netdev@vger.kernel.org, linux-nfc@lists.01.org, davem@davemloft.net,
	kuba@kernel.org, krzysztof.kozlowski@linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nfc: llcp: fix missing return after LLCP_CLOSED check in
 recv_hdlc and recv_disc
Message-ID: <20260409164527.GP469338@kernel.org>
References: <20260405164158.1344049-1-snowwlake@icloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260405164158.1344049-1-snowwlake@icloud.com>

On Sun, Apr 05, 2026 at 06:41:58PM +0200, Lekë Hapçiu wrote:
> From: Lekë Hapçiu <framemain@outlook.com>
> 
> nfc_llcp_recv_hdlc() and nfc_llcp_recv_disc() both call
> nfc_llcp_sock_get() (which increments the socket reference count) and
> lock_sock() before processing incoming PDUs.  When the socket is found
> to be in state LLCP_CLOSED both functions correctly call release_sock()
> and nfc_llcp_sock_put() to undo those operations, but are missing a
> return statement:
> 
>     lock_sock(sk);
>     if (sk->sk_state == LLCP_CLOSED) {
>         release_sock(sk);
>         nfc_llcp_sock_put(llcp_sock);
>         /* ← return missing */
>     }
>     /* Falls through with lock released and reference dropped */
>     ...
>     release_sock(sk);            /* double unlock */
>     nfc_llcp_sock_put(llcp_sock); /* double put → refcount underflow */
> 
> The fall-through causes three independent bugs:
> 
>   1. Use-after-free: all llcp_sock field accesses after the LLCP_CLOSED
>      block occur with the socket lock released and the reference dropped;
>      another CPU may free the socket concurrently.
> 
>   2. Double release_sock: sk_lock.owned is already 0 — LOCKDEP reports
>      "WARNING: suspicious unlock balance detected".
> 
>   3. Double nfc_llcp_sock_put: the refcount is decremented a second time
>      at the end of the function, potentially driving it below zero
>      (refcount_t underflow), corrupting the SLUB freelist and causing a
>      subsequent use-after-free or double-free.
> 
> Both functions are reachable from any NFC P2P peer within physical
> proximity (~4 cm) without hostile NFCC firmware:
>   - nfc_llcp_recv_hdlc: triggered by sending an LLCP I, RR, or RNR PDU
>     to a SAP pair whose connection has been torn down.
>   - nfc_llcp_recv_disc: triggered by sending an LLCP DISC PDU to a SAP
>     pair that is already in LLCP_CLOSED state.
> 
> Fix: add the missing return statement in both functions so that the
> LLCP_CLOSED branch exits after cleanup.
> 
> Fixes: Introduced with nfc_llcp_recv_hdlc / nfc_llcp_recv_disc
> Signed-off-by: Lekë Hapçiu <framemain@outlook.com>

Curiously this seems to duplicate this patch:

- [PATCH net] nfc: llcp: add missing return after LLCP_CLOSED checks
  https://lore.kernel.org/all/20260408081006.3723-1-qjx1298677004@gmail.com/

-- 
pw-bot: changes-requested
