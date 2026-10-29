Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793235516;
	b=MqF2ww09asQNpSWQlZfwNgqiil7+cC26dmigZ75E5r2MroNU2Zfuy/Xea06mCV4loj3g
	 JNGHGBeRZjJ+MBA65szJVSfK+mZ9ApJG8GZfWx6p/xTyxz66xl6FtgqfFH9Ra2eJYv34b
	 3wTGxFml3KAn1va3UQkDT2qIfQZnKEpQsV/kWAH5ybwgHgD4u4W2KzBoBn8I5orq/LgWx
	 0LqYDuf8WFFui+nR9/63yY0oo4nMniarTek5wY/ChqJ934St4xy74G+BmCHZdCyV/9/Om
	 8z5Z4cwHzc0EIzhU1Thpn9woz7C7oqKBKOzMHrnYREXFXo3y+6AgsiXHhUZeYw6ZIng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793235516;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=W37NCMtlYKtvcwR2ZMCmGN79n9lPTYd/DwQrGovnkm8=;
	b=XUILBnPdXw9CNEF3/v8NXuk3GA4jjLE+31NjU2f3fGRWTBPU7aMMwUC/7Nwuz4Oxq0uY
	 xsTg71OhnA6cCpqlYFEwL6H6aNZumEyOA6j6HvgWGwFUJifaucWS3nFAG8Dg8ZOaacDPG
	 QjKbuqw6PKQ2B4g53dabzYnAX3ojTKlDCS6b8EFZgETvE3BwYvdas6DZ6mWI7LQreho3l
	 sPiWcBO+uWZN0aBS1FbM28dN7hXxQS3bIn7SrrLDA24/o0g7BIYYy17qsrefIJOjrE8U9
	 OJfeBYaf0UNS4bopdwYEFanLk4hP9UYE6mR/nMiD91kGEP3uVFaZCFu9W46RKmKaNQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KK4z4C7D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6496B606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KK4z4C7D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E831F01825;
	Thu, 29 Oct 2026 00:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793235516;
	bh=W37NCMtlYKtvcwR2ZMCmGN79n9lPTYd/DwQrGovnkm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KK4z4C7DsMW2eyV+ypT/gkSbd08JCP9lKS5+/7423TWxwU99/zXq4KaCROzQWC5Wv
	 ui/e+mZKasfaDG5GYkcGEd/ADDbaVejE/PF43qcKZrg3c0Aod2FR6dJuRwq/mApyeP
	 rWHbZjnyEk6AiGsA9nsRABQnbcy01bOaS7IPQLEbyrp0UT1MbVVVGkFNlri8k/9ykk
	 gxuOK5LGS5zqT6H/0+AiUQGBJ0+mR/+Gt2JXq6be0q1305jHRspH+Eo2e9HK98wWbh
	 zMal+A07bVbzPgsaEKcKxnhkEXaLjJzoIP9xiu2e2Z5teqQxcijGruvwDwbKuOXvJx
	 YGQa0mSbs5lFg==
Date: Wed, 28 Oct 2026 17:58:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, eddie.wai@broadcom.com,
 prashant@broadcom.com, huangjw@broadcom.com, gospo@broadcom.com,
 brett.creeley@amd.com, ap420073@gmail.com, joe@dama.to
Subject: Re: [PATCH net 2/5] eth: bnxt: resize Rx head buffers when
 rx-copybreak changes
Message-ID: <20261028175834.3cbddb98@kernel.org>
In-Reply-To: <179323156552.3134.8258354110964306785@kernel.org>
References: <20261027234940.1267225-3-kuba@kernel.org>
	<179323156552.3134.8258354110964306785@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Oct 2026 23:52:45 +0000 netdev-bot+sashiko@kernel.org wrote:
> - [High] The fix is incomplete.

:S Maaayybeee?  I think the bot is over-focusing on the DMA warning hit
in the commit msg. It's true that we may not cover all the corner cases
for that DMA warning. But I deferred the DMA syncing fixes as mentioned
in the cover letter.

Here I was purely trying to fix the AFAICT obviously missing
bnxt_set_ring_params() call after changing rx_copybreak.

But if anyone disagrees we can just skip this patch when applying, and
put it to the DMA sync series. I included it here because without it
I couldn't test patch 5 without triggering the splat first.
