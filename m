Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776307;
	b=oMez+1sF034aw9rJFeleBaJWaRFzl69MKQaGrlsGTeAhGrxXqRiXgplSWOBAs5MKlo4C
	 Cq1E4P2bDEmBMtMv54MbBkQsZi/Jj6xdiUAGOgVljoKzAbYRNn3Ad8ac4rg5OLAdIfyJm
	 L5Igr1PHGVpr2EgXk5Yiq3iACLUpg9f5sh199Cff29w/5q58xior/oHiyQZ/vTfC56Avh
	 oJjk1y5GeAJjN5t98+JfDcqeE53wX8ExN28m1JxN6eViOIX4afXqUQn4pKP0rn5sCpqGr
	 iA8mJsjQeglI1w1oJ04pHrvrorqWmOyV/OXtwWcRNbsZI8fbrjrQweqfuRcNHiWbelw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776307;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BhyrL+gZPz2pormGcY9bduMW+6XwjaguNMO4upbxytE=;
	b=ygi0JjMawwSVvd9pxIuq0oHkfg1+/+Uzlz2wHSe0IOw3AKzSa6Twts2Ktek2tGf8tGkf
	 e0QiOnNS2+lry55Btq53BMzv3o4KznhUFikv5jii1kUgabcElROCrIy8uS3YZ82nt+bZ8
	 ZqQqp5lIpbaGDIU/ibGstLuMLD1DAKwzGjiBROBFu/oVtRMSwCQXF4rV4MsGF1iM87ZWV
	 ASozrvcqDREGFCLN921lDbyh3vYSIsSiA3PXOYCEvCxubUvrBuwynsR4imEGDDDfHDLD8
	 uaeI18jBGOe3t8BiOOWl0IxDhfucPcZcMwDY/0HEj350TrmmUIiPJQfm7GMu+Pb7+EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MCCZ1/2u";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5FF606D804;
	Wed,  4 Nov 2026 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MCCZ1/2u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946841F00919;
	Wed,  4 Nov 2026 07:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793776307;
	bh=BhyrL+gZPz2pormGcY9bduMW+6XwjaguNMO4upbxytE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MCCZ1/2u7usMXkzLabkYawkAc+KkLQRh8To1Fn9vaSkbVEyFHAymYWT4D8HPj3dtw
	 agC9MpD7BaD8o3YByj3BVKd+jm8cDFC7ogJ58zKldT3YrfJkbY0yYYkwECLdq2JDM3
	 OZEYZK6kc3jmA8JHMaSWBJgJYNWqSuW9VSMr/pbHZkkE6eahyaNKLkfpdL+PhDwa8f
	 fQ140+iPh1B3du8hSuBLdVeFooHEe8fa51zvf687sruoJMtijtGb4O8/JCvKjMuDDJ
	 TxV/Wr9+wiOIEGR9xtcEn6nBkp2pzLx25wzlUq4PS/KZVWt1nwet/vuH3kV/sWemPq
	 s2KbD+tBeDo1w==
Date: Wed, 4 Nov 2026 08:11:44 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	oe-linux-nfc@lists.linux.dev, Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@kernel.org>, David Heidelberg <david@ixit.cz>, 
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] nfc: llcp: put the socket reference on a refused
 connection
Message-ID: <20261104-colossal-witty-gerbil-1caad4@quoll>
References: <20261104022811.1484216-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261104022811.1484216-1-vulab@iscas.ac.cn>


On Wed, 04 Nov 2026 02:28:11 +0000, Wentao Liang wrote:
> nfc_llcp_recv_connect() finds the listening socket with
> nfc_llcp_sock_get(), which takes a socket reference.  A socket that has
> been bound but not yet put into listen state is also linked into
> local->sockets with dsap set to LLCP_SAP_SDP, so the lookup can return
> it.  In that case the state check fails and the function jumps to fail,
> which only sends a DM; the reference taken by the lookup is never
> dropped.
> 
> Put the reference before jumping to fail on that path.
> 
> Fixes: a69f32af86e3 ("NFC: Socket linked list")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  net/nfc/llcp_core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
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




