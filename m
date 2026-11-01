Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793563743;
	b=V1+4z1VJyiuRGY8pqWnvGFZUNqRa2GQ8iKqXzzvaNqMvoE0wdBJaPi6IEJRqUERCa5t2
	 Bw+nfsDq3pRnpMnlGJR4uOHWFyyLNLT5xkBKamGtME2dm2ThEBI49HZtParyjvXm1uH8o
	 h9kbaRFYw+Uzt4ccnGxiZL1VIVPpxcnLW6bkdMUJlxR07lRQNq3C7uW8DqtmKullvlwD3
	 lGjBM3vlGmrTsGu44XOgv8HUYZa+qze9zlAM87dD03WYie9ZrPKkopHt70MOPtXSFN7Cy
	 FINM9t0OLmv0Ma4A/0eyE4NJ4ld+x7NAjH8goXCNkEvjcTqNm97ZjV0wnOYc7NsN/uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793563743;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=I/HTtGR5M738QJceeVRxe3NW6d0h4PDevlOscw8aHEUcLOkhvzXdqHaW/bj7wwUfRj1C
	 Cz8MpcPBvspdHORY+iUIBFz6KEfw7xjmm0TmJbKeOPEaArHEOcNczdhcrKaue4gqArroD
	 2XLs9E81MExiIgylX9jL3QVSjxRdKzSr+XxkkGD7TT99mHxtnAjXqiOIGKFu4D7sAgaXJ
	 7TjdqppDhF19UsYsrSdGTzQLdm2MTF334PkUQChsHqifLvTKMTZUcodYtP9HHv6QcrmTS
	 7cvjIIZUSP3SSqosMXHROirsWQavmZ0syD/0Sn82M86MzrVK1S2s3QTIpw6NFdPzw7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pq17LDVf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3161606A324;
	Sun,  1 Nov 2026 20:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pq17LDVf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A171F000C1;
	Sun,  1 Nov 2026 20:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793563742;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pq17LDVfVdLL9mbHcTBegqctQavqfx5nKygs2Co1YBkwtPXQEFLqMsxUxBn2ipvbf
	 zgAVC2oQGev+MAlBf1euJa1gBtFGrbs8JqyLEuAYhdPdeegoKRiNLzIsYPg+789HRg
	 GUAmQjINjlFT/MT1QFjfPiWIdBRoJKTSukMI1yg9JkbXIlwtpxeYrHETswk1g2en9Y
	 TGifCXX6IlU8WcbzUgP9NcUGD1PO1ju61cA+JjHK1q3mB7J3Z/ljFO6xe8/u693HEP
	 H7AkxQKaL0upLtWHtaNN6g06n+oJOQxzB8rL0xgtHOG1yL9vOodg5uj1ynpXNptruj
	 su9Yo8qSCcWZA==
From: netdev-bot+sinfo@kernel.org
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, kuba@kernel.org,
 pabeni@redhat.com, anisa.su@samsung.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mctp: accept MSG_CMSG_COMPAT in recvmsg
Date: Sun, 01 Nov 2026 20:09:01 +0000
Message-ID: <179356374166.3286.2383588037768263377@kernel.org>
In-Reply-To: <20261101200331.1956836-1-dave@stgolabs.net>
References: <20261101200331.1956836-1-dave@stgolabs.net>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
