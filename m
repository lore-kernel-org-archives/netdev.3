Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793455159;
	b=a2c41YMO/3gJQZSnNZ0Vq8NZQrxMWJqReWdp0lTdeFAVMln6rET3GLrO8n7mTIRMkr3R
	 ehbmBAL1oErDdmsplUMByco/3Ik2OJSH08ofOPpUMSc1aBUSPJX/Rt1+U/BV/xyKCqOHR
	 1WzzGTdj2JaS851Nk8h+9GkIQK+yeNBcptbFAFO8Va3mSg2kH5JenFuC4ydqJ2HN4nv3i
	 RtJ5QcQzeFxZ7A8ximHOrjLCl3SYyRy6ww3BTnFsAEZVTErPUem9QKHZSGiTUY/n5nyNL
	 1TWltG+swwijI/HqEWPDSNQsvNDKajTEbdIZE+6aHPag5hk4hyYXnWdA1vmCWsi6jHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793455159;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=dtLCixWDiT1+hGYs6nBz6SS7t/DkQnRXN9xHdqHJSxJtSrTjXQpG8Si5+o2VomUN20p+
	 shRn3oSjZZLn3nd9INM26CHWqmhAb9HOo4BK0Hu1Sxp+I57qm3qyNAG+eHAPzRtWMh5KY
	 U7ToWLsCq9ceqP7IDJXBZ2pfdBFPgp/RchI+uCmaYvfnXLPd/+GwqgMDS0BSklbutjziH
	 6T5JT3Xl2eRSV6Vk8a1liClyCkaa8Vtpa4MutZDm4PKJJjDg57Nrmv2ht2jVzBkBVFDo5
	 GycMxUqShTDY77IkGcH+L4enwgRhb+6dMIPfNJbNWkpFFYEsG3cHgtbfI6oBrkBzLQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWmokqQ0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBA8606A31A;
	Sat, 31 Oct 2026 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWmokqQ0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901AA1F000C1;
	Sat, 31 Oct 2026 13:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793455158;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iWmokqQ0wkjPMsU92at39nKO9rwfFQ3LSKsRx0DocuDovgtnWj6GBaM8VbdA0QDK3
	 ulbvdHvQIexqocotmqY0XN58e/LJRyOioXJh8VdesC56E2HiLO3sgA2z6fwSBpXMSo
	 TDMCvynT8aCXYihmwCUPBhYWwtq3nj6UHiu9VOXMZ5F+KFy8FfRB6x3nqPXTgz5yHN
	 q5QSs524IUdvM0Xyn/1gAsRiUW3ci8BkxXqz0T7L4rDBx+g7iJlbrbtr3gNSm6UBPG
	 C7KEoBXfEQ6V6KY5ZuaUijDBO5ZyUG26EYbPnCl1WoEMPRtdJlQNFg9mk2DjYyTWQE
	 JMCcL2gBMocTg==
From: netdev-bot+sinfo@kernel.org
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, willemb@google.com,
 kerneljasonxing@gmail.com, almasrymina@google.com, josef@toxicpanda.com,
 jiayuan.chen@linux.dev, toke@toke.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: parse the eighth nested VLAN tag
Date: Sat, 31 Oct 2026 13:59:17 +0000
Message-ID: <179345515710.3286.5345760675746189369@kernel.org>
In-Reply-To: <20261031135507.3970551-2-thnkslprpt@gmail.com>
References: <20261031135507.3970551-2-thnkslprpt@gmail.com>
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
