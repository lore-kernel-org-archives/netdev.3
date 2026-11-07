Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794040265;
	b=vcWdhCzHNtv5P0AICcp4o0xBsybAq5pJSr4C3hPn2QKIkzqgHR0TevkihfGPqlA7IzzV
	 BsrcTvQqc+xqY4pHHLGMh7JRUKJqWdoSPe19NDHjYTzngNx+ezgRvhBLumDpsEVL+H25+
	 ukxrxvLoyF7w9tMG3WvU37wjx9053OP8QIJe7iSd0if0GDRV8kZDKaJuH/2hrgcyxWTkT
	 G4oJkW1tdXmO0BlJ7F1K+uRMjfY0MVFh1Nx9RwzuXEarP75Ssl/fOLEdRv38zbQKhrj4C
	 7epU6ayrNoLHXI/3U8iq6xZUOHvxmEeik8DeJcdwYLfyi6rjlk5M/A4o+QvGPdDZPSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794040265;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=G4Iv907qKVDLmH2yQjXis41UAjdBKBaOBxr4J7kEc/JACWGMBV2B0RcDCyG+CrKSoftZ
	 YrjgawEfAn9LEKwTrTloIwuY3H2hKGAekNczegWDnBSr733Hzmt0CNciBQVO5XUHYBLGH
	 fkSj+g8xK115a7rbhxYFQ5gMo0k+cC2P8NM8OfqVpq8tAuw6m2ClgztJR8Q3NlZVz5gWK
	 QtJa2Gqhw8m+jx8XMJzQPczHNqb2kdIQbDQ9QAyu4/16WTSkx1k9F04S3Z6SQh9P57w8j
	 2Add3wlmR1n0rK3qQ1xqv9GlN/DwFGLUwXu11VA6f7qizlBc40BZ3I0OX7NO02mJiqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IRyrGjBE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60406606A326;
	Sat,  7 Nov 2026 08:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IRyrGjBE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A2A1F0089F;
	Sat,  7 Nov 2026 08:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794040265;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IRyrGjBEosXDTqASV/X01slFzdcpoCHZ+JbAYe1kL//tCPhHAMgDbRZRhfPdNo28+
	 kEzOMDItNqAvTjtklX7LX4B8nsZP9f1WXkleHzZZmOyf7Lc1UusHvFGhkY24ACds+k
	 LIXR1F2dYbX5ZMwik/9QHloiYbvWHcJNKhla8/l5KjXB9Xu9WarxX2BCZ1tpMvs+Pk
	 x98HFTXHPKDvc5S0MdFFtHgEDdMjUefhxQ0Os3V8NvE9daxJd8VcRQ6Y1vvL0S88Q4
	 HI3lHtIf2l2hGJOA04xCcL3XDhu6UZmXNjVplPECUAUyVKjOC23j7IKFhBsx+YTky0
	 gwqW7g9pHnUqQ==
From: netdev-bot+sinfo@kernel.org
To: shaos <shawnq1@163.com>
Cc: jmaloy@redhat.com, Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tipc: don't count unjoined publications as receivers
Date: Sat, 07 Nov 2026 08:31:03 +0000
Message-ID: <179404026391.488859.6017667215098843887@kernel.org>
In-Reply-To: <20261107082422.900347-1-shawnq1@163.com>
References: <20261107082422.900347-1-shawnq1@163.com>
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
