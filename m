Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362776;
	b=kPDRnpPt1NrVXld3b0Pc96GEEOUPCAiDs0onflc+Q63esYLAsv65hW6zJ23grsTvukQp
	 mqTc0bMw3yeShfFIzdMwp8fH7YuANZsNHirYP/Kwke4veCU5A7DzctMWUq0YuBJod3jak
	 Q1KKyYyhbHlA8h4maDdNbw7h5cXWW7jbyMfbVVkzSlksdaXWruyPtJ0WA6qfAx22Uithh
	 bvYDb2Bo81Pl7J+1S2V014pOfDIdi5R6d/7Tji/eugxB4onvstI1z93zR/fECh0mr4Zct
	 K+QynX38TxlMU/Hqq4Te0w5mfHFXP760PEV6LMsNzhkSohbMq7auaRyKkZpbpqpaaag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362776;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=JsOR9OI/8wVrTDDfayLYLLVqdXattNskIIfQ8os4skbIMKxyBvUYY7OXrWrBNdLGQsb/
	 LODyANTMDDSuAGhijcQFO+6C0L5/sr0oL6YKSQFHeFZ1pNZjNJY5Wv1/92g8oiqXk/mMT
	 agRRYJRjqDxRpY2nsO4dASwrd/pOZsCh1qEX3/c6vUTqlF2afjSl62+n1XnrhSPeWof4u
	 YnkesQDdTZOlFreuoTnle40YUUY6jHGzLuKJ/GQ2ehutBerhzY34slZwyWBtCfi+vJcpa
	 SlDvoFo249A2Sn/Mb3u8nL1OqhYYoh4nAAulz8Qmvmgx3WhotxqJapAC2rzUqR60myw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kaW5slQ4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83391606A320
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 02:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kaW5slQ4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714981F0089F;
	Wed, 11 Nov 2026 02:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362776;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kaW5slQ4jWtfGyI2+QK1mYooHLzwzdW7zi8dXwEaZDFO1bnw4KNt0zYMWcY8ejgR1
	 N6n4pbUFLWdrUsdEO3U505gPTFWdlPeuarOVE0vAijL/TUUK2F3ullJchV9A4YnW7M
	 U0gnPJEEN2Wt7EfUMODir23maBTWb8jBDylP4XIWqeRjhPT63Wjbxn9UtINWkFy+Kg
	 2gjEBkvIwrxg3B03v1BYRoj2bB1c8pjBDE1YpCEpAgVL2p59zWIUllccCgtM5g8aRi
	 0+zguBmzbh8ImeJnwYcXtmb54O7x7KKYLUNKXnp3YXYbllogHH6MXTZSe18BkXY62C
	 4UCi11HQjkMvg==
From: netdev-bot+sinfo@kernel.org
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net] tcp: Pass req->rsk_listener to
 inet_csk_reqsk_queue_drop() in tcp_check_req().
Date: Wed, 11 Nov 2026 02:06:14 +0000
Message-ID: <179436277497.2168702.18011061847143862824@kernel.org>
In-Reply-To: <20261111020304.1532064-2-kuniyu@google.com>
References: <20261111020304.1532064-2-kuniyu@google.com>
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
