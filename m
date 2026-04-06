Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67078330315;
	Mon,  6 Apr 2026 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491141; cv=none; b=pXCAW256DCoSUde8CzqW3XcstLHYrZWZnAku30yC1FZtpl4QG3RTv7LpQOrbTd1PZNwuQBq97seSfsZbPJoG+o5DK+oZu3KCs3u1dm55kvDFVP1+2WTdOQRWT/MNOFOOHM4srkdWc0ZY6iUQ3DKrObdDiGxegZHcCq/x3Fo69kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491141; c=relaxed/simple;
	bh=2tEKIvmGsHH6aZ9FS4XCW+k7Nk5QoCB70rS9vldSAwM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nlFV9L36HeX/l1hxjQbA1UIS3MYpq/eZ7vQx/ZlPiYmdZoLkuqPTTwWzHirDSdxOriqQaUrgLDnHdAuD2tnW688rLLhyMuuunBkmV7J1nJTCrfNsEdFj9QED19QCjZWiNSD4aFoZaIqg2pECUqZVQurjOCc8nMrQrDiMTSKHqWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QW6Nb6yj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QW6Nb6yj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7016C4CEF7;
	Mon,  6 Apr 2026 15:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775491141;
	bh=2tEKIvmGsHH6aZ9FS4XCW+k7Nk5QoCB70rS9vldSAwM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QW6Nb6yjW6vQxfbBDqSQo54/7rc63nPoe6ixrY4i75LypvklC38L9UbtkgqQWP7J9
	 b/m0eAg43mJdeE+Ov33xQGd0eP4sPzsADmRokxf0/3aWLRyZoeKl/syjhTTCI0wKHQ
	 yzQcZXbZ/WXcRdEc9gWe0CUQbfZgxUr4JEtMm0EKSdusKnnqATpWOxU8bomBJa0PZP
	 Ox9wi7F93GG0r8V59TUfhL1UMd9ejZhKBshck/CMjP1pp/V72rPWL05TcaGyCcOTUJ
	 u9FXokyNGCtQdxgUkEHZgMpPucPF04mJwV/8SqOv6ckG/bfTAII+N7+CohjL3S7O+V
	 dW5+SdBjlWUWg==
Date: Mon, 6 Apr 2026 08:58:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net] xfrm_user: fix info leak in build_mapping()
Message-ID: <20260406085859.2e9843ea@kernel.org>
In-Reply-To: <20260406085449.266466ae@kernel.org>
References: <2026040602-shack-tamale-d8c3@gregkh>
	<20260406085449.266466ae@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Apr 2026 08:54:49 -0700 Jakub Kicinski wrote:
> > Note, I think this is correct, as I don't think a new skb has it's
> > fields pre-zeroed out, or am I totally wrong here?  
> 
> You're right, skb owner is responsible for clearing after put.
> Tho, Netlink is not as perf critical as real networking, I wish
> we at least had a helper which reserves the space and clears it :/
> This is not the first or the second time we hit this sort of a bug.

We could make nlmsg_append() do that. Mostly because I don't have 
a better idea for a name and nlmsg_append is only used once ;)
