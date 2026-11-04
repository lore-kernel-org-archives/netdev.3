Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776318;
	b=HEIdKnEhu18tw62jnd/ANLb/ajK0jpPsD7AfYMFe18PdnDO7C/aWK400BV2v8tewFq9k
	 SmUGBWRVzYTgzeqO4sW8zgeXHL+rBqnUZ3+osYkGh5LkOhouFcVDkAfX7DduwCgzBCV5N
	 Xy1V8t8Jz1OM5zuTIqPuOU6eDhj7EPOnvm5+NjjLfTdRfKC+XUGEilmXH59vYVcCHvZtm
	 0eJzwPRDpLgzoLU4Am0fAHYAO5qSkdY23lnaEcedMza7jTnrYbhG3DM1L3UNLqN9LTZnR
	 MOH90JotlRDs3hHt4rv9g9KhS5as4JO/MX1+cCx4vR4X6QRhVHdJllabWDsYtshkJeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776318;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=67tMf6yvwclmZif6chXBIm4kJBJKenRUKUJwhmdRgps=;
	b=EOAuIZWsJpxnL7sACoF4AUrxh4f+x/BjX2bxN3MYBIOVXuMVPMoTNI0HxmfmNJDJlL9e
	 UQ5dvTOWfTW3v/8BcSAI5KfmMi3/hQUl8gHqt0MNf9cg3XuSquWm2SYzgOj21ibtT4u53
	 sNm7k/xXRq0jW+mpYB5IhLcfzhvDpSTLMnmuCnWGqlJrMTAMUoI9wswjtHq0+gd0Rqux1
	 djeNne5179fqzYwn4u1gNNKdAGMI2mDqjAB+gNIpCTZfZIaat++vu8ccqjNQvBp401dyU
	 sI3tIhmjEk6EcPxHfnr97IiijIWFH4FhY0gf4u776kgZrhOdeNm6Ms2GZpp+BG8Rl6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dks6ewJE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9677606A328;
	Wed,  4 Nov 2026 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dks6ewJE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615181F000C1;
	Wed,  4 Nov 2026 07:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793776317;
	bh=67tMf6yvwclmZif6chXBIm4kJBJKenRUKUJwhmdRgps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dks6ewJE+WK6bAYIEDOfm55sLdX5GL3L8d+YyGVFLAutCCcVJzGvMrJrFaTq3M1fd
	 SpUdABkekK0RDFGu/sc9bt2hayLLUvxVrU/1XNnUZEPHeZCJDlAZENaqyfzj0rwDpD
	 MlbyL+JpaloTe+cdo4CN+PL1gAbSGFKrH+bNHEgVCjwQrC4JurSAPm7KrksOJ3E64+
	 KeVBMh3u+0SGao5jrgqVlS+efEf+w1e1MYtd6XTim0sc2oMR9uOPRlkVptSFhaega1
	 GVTVtFpQWETHEqqmHHrB4v+gG3OZiFCWrpumD5wo6G3rPLlTMBo24/weZdyM230PPU
	 uK+9qcmajaSPA==
Date: Wed, 4 Nov 2026 08:11:54 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: oe-linux-nfc@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH] nfc: llcp: drop the socket reference for non-datagram UI
 frames
Message-ID: <20261104-excellent-artificial-finch-b7bd77@quoll>
References: <20261104022810.1484199-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261104022810.1484199-1-vulab@iscas.ac.cn>


On Wed, 04 Nov 2026 02:28:10 +0000, Wentao Liang wrote:
> nfc_llcp_recv_ui() looks the destination socket up with
> nfc_llcp_sock_get(), which takes a socket reference.  Sockets of every
> type are linked into local->sockets, so a bound SOCK_STREAM socket can
> match the lookup.  When the socket is not a SOCK_DGRAM one the function
> returns early without dropping the reference, leaking it for every
> received UI frame sent to such a socket.
> 
> Split the check and put the reference on the non-datagram path as well.
> 
> Fixes: 968272bf0087 ("NFC: Handle LLCP UI frames")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  net/nfc/llcp_core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




