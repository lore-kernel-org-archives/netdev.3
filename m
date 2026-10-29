Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793287733;
	b=oZp4cbYM9QdSVwrnlW/uTenybJE6dyblhi9g7/M0FOl2WnahvstgxVWJrshCeD/VCnXw
	 76LRk5+REGEU+11ljBFV89jwLAawAa4zcuUEX5DDoV0jiwc79a7/S1Fi+Er1oa5vCbHiE
	 /lh3tqX+P6JjlimO73ybX8iq+NZNBuLCUAMd2wN0MrQUX1cpefw1YCxbmXR+8Qib1u3Eh
	 hWBvYIeDdLucLpj/1DSHSxN0UHGT+wIz5Q5RpQiRMckxTWRy0OQtOQ7jgLlXzvdGftIjf
	 poyEOBQiIT/sTmpL/qMOa32doZDxHLqbKA29At/AGkSOxDLFkvHvoIytCYlmFwEwR8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793287733;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=zoAK3q1/cVpVKfo6gFkFhZYU7NUXMsr+0dMkQ1+QcW9svq6a8ajPwevV76POpcPeiiVi
	 T+4T+iNRRYSJN48Aev8+dXzUg1GD7BpkU4Hnf9jdl6ANFTEF/E1J6fKV6N0+47nx1cz7N
	 2n1vItOodULz3clV4iMPI56wOIqs+WHWFPIJwvsvRl6DWgZjGx73EeTqaeQR+H+JgzJNy
	 RyAAZ8NLv0H+6EqNJ3R3NQAtYawfgPtMOtmnX4bFeoxyt3IRjDbqcd1e0USl3KD6jTyqB
	 oRlmHHBsHaPzjBDC6T3mdjBxzs6nwnoOyY+5RQRIiFfYN7hDi0EUE6NxNdrpfZULdoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gxKAbBY/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33164606A31A;
	Thu, 29 Oct 2026 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gxKAbBY/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F5B1F01816;
	Thu, 29 Oct 2026 15:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793287732;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gxKAbBY/Y48EhvjB4DYHVT8zbAlR/gYvB8yyiw9R5JGg6w6o5TS+mmXI0MQBIwD8l
	 L3kchs08LNSOu+UnpOJUBM63DScud0nFflKeBrgPC0Qlm9ZKXb9z8Ko3mzZW7DVKDC
	 bLjrSQOwInxcd7+72c/r3I4j313109O85ammw9K46iyqmnrGF0UkfajCodDD9Yhg/X
	 QT85UgtrftUBvuEhzdP2DT+imlvHzxSiTwcByXH7HBPBnO0UClQFkKAqVxl8O+tQpt
	 bb8LePSPZoF9F/3ZjjThBm0gJK5qUqWB9Z7aQ+vS8dHWdkMkNapHWG5/VXxxsIrQrN
	 xs8eFkk82pLFQ==
From: netdev-bot+sinfo@kernel.org
To: Yingjie Wang <1075151112@qq.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, linux-doc@vger.kernel.org, alexhenrie24@gmail.com
Subject: Re: [PATCH net v2] ipv6: bound temporary address regeneration advance
Date: Thu, 29 Oct 2026 15:28:51 +0000
Message-ID: <179328773152.3327.3386236398576649712@kernel.org>
In-Reply-To: <tencent_C2E4FE9B7C0A05615861782611715EAA9C0A@qq.com>
References: <tencent_F6E8C7CAC6D390C8E912EEE4FD9FE4333505@qq.com>
 <tencent_C2E4FE9B7C0A05615861782611715EAA9C0A@qq.com>
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
