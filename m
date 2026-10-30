Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334627;
	b=HhHFAcxSM/IRCODNafDbs337BoZlOTCw7FsC5QFtrr7kZDkzGZ8QL8WPzzulMHloHLBf
	 3Bxpyg4Qe0rWCLXEu2C9Js9rzGkLUhcUDR8QOvr/4XbFITTMq9b+UDBYxAQR9pHRXgMPp
	 tAgupGYBEFr7SS+qQXcAYEzGsvm48xmxPYi8GzZQkpSyV1kwoomGz6YvCudTKMr/78TJs
	 53T9EIE2iyfmmrChvNmo259Yn2wb61yQcS0K4HPTcPnrHSVzI2uOxnjJl+abu1wt5UtaH
	 yqZZJWYCCNozdtjTUAj66BOUs6c2uDAQSavovG91KdFgeF9TWuf8WQ53sGl62AVSvOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334627;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=ZtUSIB6qsjg8z9MC//ynP7K9cHEEwQi55LLrNmPUvIr90U8XHBIBw57G8gWBYE3ziTgu
	 OvBMASjDiqWveV8s1Qd4wyPUI05ORT6Xl/KE0o0T5JAOoUDAprt62EOM6r+j6j+0GFWNW
	 Rtudog73nX4/ef0dJhkG75VNq+HOt0iS3HdsfYVZWwpnP+azWjghKRXGWjBOFHSeig21g
	 /Ky9QOvvzWq9hlzsDVgzQqQZouoewWdCpKT69/g9WBKW3j51KI/m+nKUWDiXC1jsDkX2I
	 KAVbskjniNxeiSXUJ6BYd8MM7vTsDeCoxcXZ7h1B7ChIWcycN2kRDF0PxBNjcLf4Djg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WXi8g2/u";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5378D606A31E;
	Fri, 30 Oct 2026 04:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXi8g2/u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AB01F000C1;
	Fri, 30 Oct 2026 04:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793334627;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WXi8g2/uYTmFBSGj6FqmKCqcozz/onUAtTGAEiqhEI9EPrbAQYbcwXy/AODGgdliE
	 Q15IdIUWrqbU9Pz5+6s4XOcKEI/DXX5uNs81H35ond5Qx5iNn7aXlbG4lw624akTNI
	 RutJcuLjtiJM7x+47FVbl6EoLmQ/Mm1BfNawZN4Ovqg4okLiwC/V+Loku2l69o1iMf
	 N7zbugTByp5nMHvTHwfadDd54SHddsHIWTTyU0/GSKAqsU5g8M+mIr37FQvegLPrbs
	 r8ITUq04CbyLxDrlXgyWCKKzGZubLSe1Sf4PoiBBO7qX0HRb0pKG0nq+oI/e1ror9z
	 +itMXVMnUfWig==
From: netdev-bot+sinfo@kernel.org
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 outbounddisclosures@openai.com
Subject: Re: [PATCH] xfrm: serialize SA activation with state deletion
Date: Fri, 30 Oct 2026 04:30:26 +0000
Message-ID: <179333462644.3327.16763225981592707759@kernel.org>
In-Reply-To: <20261030042353.74606-1-kylebot@openai.com>
References: <20261030042353.74606-1-kylebot@openai.com>
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
