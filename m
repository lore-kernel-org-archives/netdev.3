Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793774339;
	b=VhV4Ha4b0zdr1Y0QKu9QxlrcV7pv5KvnArCPJvhESvR1EUK2zKexoU/nkXa6ranS/m2+
	 v20lb4Rpt13ER4thKnRBuVVNUotmJHMfRLJEoUhtL4dmDKg/d3rPghdkr3HgZZ84yXumL
	 +avXaBjsk9UnJ8O+ISDof1vItE/A9UaCgnGQ8aVvgQbdXhvDq7z3Gpod9wXiJfvx2LDBi
	 2Seys4ZBqYlNR6LfHt+pOuL+byLpjg6rPW7cIqsl8E+uLl47+k9+c6T5lzzlYvNOxIgjC
	 XXM7SWVIcftYyOdNXNHCQzZ0urorwVHjp8yKKpIVHICpr14+oMY6U03n7IZ14oeP1Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793774339;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=xIxQV6kKk93Q3sW/C7LGEzMtB1OXyt/cBj4Bwl1X6TaOf4/UmNQO1q+tBEt6gETrkakS
	 bHMo5nymzcfuGHlqYUSPzj3rr7LuaeiTXcOgcUkuDhDw5oVQyRShssRtajl2BqZnbSe4v
	 H7lDCqqYzgL6Y03kl1wSYqielaJrpKHz/pjltLCIdQHXBffgKelxczYewZD8zDWPufaSQ
	 A+tZPjo4ttQyKU52M7uzPN2Q+s4KOiyWCOYydTKxfBdfjigeWGAwdLHBqLTukzIQmRKuP
	 VXf4TX5dZYfi/4GeYkW6Ab3KUm6bKmszx4pQE1wwJ6X8PILCkbyGOz0dbT3i+2apZtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HZ2h5uEn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3C9606A31B;
	Wed,  4 Nov 2026 06:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HZ2h5uEn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A681F000C1;
	Wed,  4 Nov 2026 06:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793774338;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HZ2h5uEnYRnfZcXJxJ1g3ymerS3WsjEermfG8+mS/vV6URcFsdxny+83YCsU+P8sK
	 ZHr1bv5uN6E7kNGK9vu6WDBTzqkavKJwB5CPeRuF+1Am0i41OSaFqYDLY9Au5gpVSs
	 1mCaPDPuaqmepq8fMFbAU8a27d9TUrmqMXiykeI6TOYN/+GnusI93QBQ2fE8luED4l
	 vMDxmLLqzvOHjRg7wllFmQ2DxT3J9LCcLOmd0vxNQrlkjIP7DNdAPjjH0dMVcckVv1
	 Z2VgPw0HH5L/07/dew79h1uDRfrPaAmv7ofoR7/MEkZfTNmAuz3DjHJrZDuajl0U/s
	 fj5GJ9N2XBZBg==
From: netdev-bot+sinfo@kernel.org
To: BeaCox <0xbeac@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/3] net: ethernet: disable async work before teardown
Date: Wed, 04 Nov 2026 06:38:57 +0000
Message-ID: <179377433748.488859.18424652819498691331@kernel.org>
In-Reply-To: <20261104063245.23402-1-0xbeac@gmail.com>
References: <20261104063245.23402-1-0xbeac@gmail.com>
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
