Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792438781;
	b=UEVdNikOrQUpmLnKQp1Kwcc7ML4xCPCVa+belQMnRCb7bK1+6PClt/8q2kOC5S2zOfCw
	 NZiAfl1o0Vk1FuBCun0sfd1EjAaWf5XODj6U0LXUNu8QacebiML6HQfe67xw3sZpDvaHa
	 CyzMxhEhcTXWXURax9CvUHC9qWu/IQU7SbWZfkVvo+bkP6javUMnKp1sY+YaHRexXNTRB
	 va2455AN5Ou6uhTnDYBw2AsYFogZiP1qw9rin6asnmum5GnUQMMxNQcbMR/yydMJlVCtT
	 X+6NU3mBTBNwKSXxQQAWRvkVIiD2Rln/p948WrI47yPaibl5N0Kbavh1kpXkDeFAezQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792438781;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=FE0BRwcmz9gQoM+pKLb/MyJ+xAO7pRAPHR+IOylH/KdxKahLLyKLbOByk5nDZCaukakj
	 xhQY9iET7TexWu8SawF19EE0TWPYKu7HmpgVhd5qLDndbPU852Nk4YRGuupiebP7whuZR
	 /4Xw0a0iLBBNCfwuLH8b8KrdG+Juu2oAYc3rqNmvWz3GD0adm/X08ECtsK59Jrhi81byp
	 9Dhm5IWOkrgLt9tlnjz33OdTHgvHdBAhXVTleSC1Lj9hBkmuOn8pOF/eahGRt5svsV1nz
	 8fnR0dwt6f2E8URbTL55gfLVTjFqkyo4hnMCnHGGhJ3FaaE8mYrpYVookbFuWFdIWJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FHvCdEDz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DD6606A319;
	Mon, 19 Oct 2026 19:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FHvCdEDz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B60B1F000C4;
	Mon, 19 Oct 2026 19:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792438780;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FHvCdEDzlCNG5MUncYbT5iGTy59HWV1GiRjWYVOWkLmqWF4v9fZ2AuV9/u0nVOgua
	 IjgKEvC0VfaKxaYEPoTjIMYZV7uIKtHhJsW1vtXDdPDg2WDbHhH9GAznkkcnUSXPX2
	 E/A03FoM9vYKBEhhn3hhzpl/sw/6u6JrYxeTrS1GEnr4u5oUGDb4K6gA0e/oyDo6F3
	 XHTrzii2LS+mImB8I+vlRBUJxVgSZRs5jAOZb89P3h4ax3Y9zBqajBZ9U9oyib9157
	 gdF1+wqi7hq3zFBa2g6rzSDV3c4myisGOpWw9JGB1TwkCc1L+Iphw3iRJXe7IoHl9w
	 gG62/To2uXF7w==
From: netdev-bot+sinfo@kernel.org
To: Prashant Sengar <prashantsengar25031@gmail.com>
Cc: netdev@vger.kernel.org, Thangaraj.S@microchip.com,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch,
 linux-usb@vger.kernel.org
Subject: 
 Re: [PATCH net v2] net: usb: lan78xx: avoid NULL PHY dereference in WoL setup
Date: Mon, 19 Oct 2026 19:39:39 +0000
Message-ID: <179243877992.3290.11469645558271556558@kernel.org>
In-Reply-To: <20261019193148.1381545-1-prashantsengar25031@gmail.com>
References: <20261019193148.1381545-1-prashantsengar25031@gmail.com>
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
