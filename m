Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793096517;
	b=qr82sFGtY3f0SZC7BbFEXKXSdt2Th6Gw43dDaDehstPFoQ2RAULbwpgDeZGN9H9GQtm+
	 VOVHnQerVaFrFIXUYyGT9+irDNpgB5FlVWdeurj8zd8XabkbO581Q2Be/Zh0lqfJOZQeA
	 +ICiAGJLxpAyuiyCrFGqet7ehQ3BSdZ+egesC4WYZWWZQ4t4oMuXJGoC8KFBZ7IqUJOuX
	 jkOJAWFmTYVwa24Q2AX03rUm/5LQhmT+xwpps0izZnx1YDUmuhF1PhqYnIMTPZ0xgzi5V
	 Cuebgho/i1N9QdZuOn8ezNrlZ+FPbraZ0cgaOxO9nQSd8WVG7smH/NgYbVJwlNbxNew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793096517;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=QkqrDY4NlXe8i9kkNgQC8NbOUzfMmQodM+mJ9CvRXbyRgRaKrp+EBaiOzoM5en1i6oK3
	 HwzbbRii06J5bkmbuN3K3F3mHUKE5xHQaji5mbxeNgyUYwrw5Cf2q4BeXg7POtZtxJdYk
	 wCCcpmO0wX4oV0Z3EYIet7xTNHL20CC9hwibk/VUrkvadwAteQlwQylQNqCavPugEzkU2
	 GEPhqopucc/i7AEeMFWX/VEHyXXJ4KbLSzGEp1/vTSmRnCqMoqlupx0UF+35uyh2Pjymj
	 QjyqAXwOABWEh3PHv8jPSuSMHYv26NZw9mDraQ1EZi7ca0u8+Env6rbkXD2XkWQyhzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UqoYNZNE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A40606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UqoYNZNE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5B11F01828;
	Tue, 27 Oct 2026 10:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793096516;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UqoYNZNEcZrkA+jxextXQe7x2VupS/j1z8cRc5dE2+PvX7Ix/Tv35Zh61tNuuph3J
	 P7LFGVUynwLwKcrd/oo0u4q8PvC0JlUTv5ua+OSlljI/OmaadyooqDUZ1fXy1QZ7/1
	 gXNuJ/KZ0mVT0/mCTius3GbH/8lVbCRgrBwDV18WZg35UeOk4N2fQMI+TOyko8mv7x
	 HgfKhIZzU6gWtd7rf63g6lK1NgqnxjOJqGbJdihmKtVox94aZ9OGoIf8ijPG80cnS4
	 EmD2zOAtb43j/R5RoEBa2Mse6DvEAIHm4iDizvUPcu1cTfgviCqQHLTPK7VwRPWi/7
	 J4Ersy2lCvMQg==
From: netdev-bot+sinfo@kernel.org
To: Xiao Liang <shaw.leon@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowangio@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net] tun: drop batched packets while the device is down
Date: Tue, 27 Oct 2026 10:21:55 +0000
Message-ID: <179309651562.3327.6162426698384505337@kernel.org>
In-Reply-To: <20261027101830.85327-1-shaw.leon@gmail.com>
References: <20261027101830.85327-1-shaw.leon@gmail.com>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
