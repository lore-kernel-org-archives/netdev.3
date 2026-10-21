Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572229;
	b=SHEIh1RT0Bgsdx0GhGgX8HnlUtoMeDctpaPx0C4llZmFg/HrmI7MYpdrVPtOO0c42ymE
	 9krrl0PK+z9dQ/FLJx1nhQDAYTT9t4/x1jebo4SUjNeKaXuUQG0Rcx88m3kWp6qBK4Dj1
	 ujuGieHN5//7g27nWps//zQSC9bz0QR5opDQQb6xtjZMC/ka0TbVlZvJy90PtqohMM1R2
	 QlRkPcgGoEKyr08NJE+IAN1HQ1i47g6jcEDpH0jr21yOa1hpEYG/XOWEUaOv0OQX06NJi
	 H3XD/jg8TWGZKeUEEEpK4Sdf3PK+XuyI3CWcxHRvlOGl6cgRjFyMbjNcDinAFL5SPSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572229;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=vk1ORYvnZm2kGFv+/frkhzsQBZ70JcuWJzesvTx7fHaU6HE1oa5fV+D3lQfvpaK8nXHs
	 MPSO1RqreVpzEF+XPytr4OGAvX5sCLkUP4fu8CvNYflb2zsVP0The5ucGsagvqvHkjhg7
	 42cIpr7dAWVIfQKxx4CBy6Wb8uIOIlUCoillezOI7ycqHdf8XCqSwkDOoheDzdHZDwzyR
	 +2wsjOK2WuqAG0837NKn5AXofrviT9H8VtggDAoD85Ts7eoW2rxmgK8dLZrfYIrUVYae/
	 o7oeQFVq5mfuiHEqPyAcUfQgTBOVpfbrCknSGuEBv8yy/ZIg4WEyn7029dnEAlNZxPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A8Fw7XkN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C10606A31D
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 08:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A8Fw7XkN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BD71F000C9;
	Wed, 21 Oct 2026 08:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792572228;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A8Fw7XkN2FgfvegLJ8R/kH9rmcK3y68tqfrWtr7xX0eN/+DJCMWLEZI+290c+Hgru
	 lw1qIs4ailHRctSBXRSnTXCZ4dd8EarF9ciMPR4vntnre5fPLdma3bd6zvmNqZOw+Y
	 0iOYMFKxLOs8ohtigqsyTU8YlUDNioMZIDKWBMkzj/dJWRoUGhDsyOtGyGHSq2Hakb
	 b7N0zvKr3HycY5tHRBBPYEcmmo8koJbjnh7WVj/NJFhWzds8sTy7wiohW3MNmftalZ
	 rPFfE680JXA1zZWGH8PZyKNFAqDrT7EoHND/h6m4oWp8Ke3CinBgYQZ69DK/aVgEQW
	 i731Uzrs2WzVQ==
From: netdev-bot+sinfo@kernel.org
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 martin.lau@linux.dev, john.fastabend@gmail.com, weiwan@google.com,
 sd@queasysnail.net, jiayuan.chen@linux.dev, netdev@vger.kernel.org
Subject: 
 Re: [PATCH net] inet: reject unhashed sockets during established lookups
Date: Wed, 21 Oct 2026 08:43:47 +0000
Message-ID: <179257222719.3290.12321272724290760263@kernel.org>
In-Reply-To: <ath58Egc-oI6p3Jl@v4bel>
References: <ath58Egc-oI6p3Jl@v4bel>
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
