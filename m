Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793420325;
	b=ghh5wjxsEldAlvUpsnKEIhLeo0/QTwZJrkksghgkaB2Nw25XaNZ+5LFPVNq96OA2ng6h
	 8JcQ6z9+CGCQG+1pgrsEAAq4xapmOFwWoK64BlZRy6/C1mu35AGAZwm87UTN11tnzhDiA
	 1sSs76OO4Z0VyOoHjTBJXVDmWkD2PvdxDVar8l2uQojWEcWxZsG6rMb73SF4ITz+OeC1T
	 IW9kYfE49wCxyEy/1dFrB9gyaUhbAEvgHsjWIWcpoRudWpQq4Wnfr3GTeAZjh4jpSk6xI
	 fMvgdSq/yGbjffD03GnJSLYHJGxCBOI+Co/J7AbTLpeztwJl9G3+mKuqfpGaRWOi+AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793420325;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=Snguuyp18QvWLb9cGp+wAxPu7wY8N31s13jih6PFRFgQm2CvoqnuAsKFpEmehyjjWWH6
	 1tbhBKEBRKNjqWXQouoCLKN3Zhe/D5dSA/aZYFV5R9bt4sdkS21cX+7lZJEFFVgnYbg1D
	 YuDxqb42Yfb2lTiq8JCWFQaPhAa6S8mfPYZmC9piayWLijbzq3RjcVw9S2WApMipMUg+K
	 PM/iO4sy8ddWHkkEs7BZlMqIV2VLKEmaySKi4kNsBRbA/Ds/mniGFsCl452OS1C363ibU
	 oPIdtnVwXyapuvg0QRMcSkhi/vL75AxxRPnzTVghhLnkNXLh4ZD4a66o+HtsVJmf7AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbT0KJVz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6DB606A31C;
	Sat, 31 Oct 2026 04:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbT0KJVz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B8C1F000C1;
	Sat, 31 Oct 2026 04:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793420324;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nbT0KJVzZeyPQWKJpwN+OAUD+ODY/HtmahXU+KTS1YmOBXszd6eNUdvMMOCVPc0dg
	 g3JgVyB2Kyku8AHStjyMoSGVhvKad5HI1Mv11ngmW+8arie2Hhx+T6tvptGmmzQTUv
	 Svxn8UZhvz3zFtbaya/DtErwl+ApMcKMkC9Yzn3R7Vg/R2ggOrIv5SGcru961h3OTk
	 lSD5DLnzroHDUdZHGxOxkMeGizbQqbsbVoW/XZjgsmxzDB/iTa5K8R8P7fmYSzE3hE
	 cwwaYyJLJ5HXAnKxm8vXiKepzhFlEmIAYp6X9p8I+BjVxGzpziKTrolRAHgYRNl7mS
	 +Tym2wSxqTUBg==
From: netdev-bot+sinfo@kernel.org
To: Cen Zhang <zzzccc427@gmail.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, jjzuming@gmail.com
Subject: Re: [PATCH ipsec 0/2] xfrm: fix state lifetimes in xfrm_migrate()
Date: Sat, 31 Oct 2026 04:18:43 +0000
Message-ID: <179342032377.3286.12462579966925281138@kernel.org>
In-Reply-To: 
 <pm-xfrm-core-objects-candidate-0027-v3-cb1e033bff1976f510c9-0@gmail.com>
References: 
 <pm-xfrm-core-objects-candidate-0027-v3-cb1e033bff1976f510c9-0@gmail.com>
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
