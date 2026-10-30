Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334245;
	b=N6Tzf5/FBPX8C7IugP0vLoqjHki+L9EFyEU2qDGb5iPx5DBM2Zq6M4dXDW3ad3qGUUwZ
	 w0zIjBASCIkRbwitjKb6MMSkf6cTIBIU1Sbo5kv13V9XS8Gjw2jsv5izV+j7so3SKj69I
	 Kn08T4n1aVLsFIDqkhh/9lT8LvtheVdOaH41AQSC1TRg9aN3gMuLgXPu5cRYLl8tsHMHX
	 mM4jzSwwT8W0BLXuSvlRjl6QU5gJJT2eIhBTprAJ/0J3z2muhegPVUMv6DbItgET7oU00
	 wLG34wfWo6x0Cmy+fnrxJTE+QvQOVPgkWe8f6PRHs+sMgpJ1AyQyg5+V5j6d5H6uJDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334245;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=4O8ZLuKRAWM91YK+pD1wOaeizq1aKAPS30niGA7SQuD8O03eG/uLtHxULDSGJaNt/l/+
	 oX0slhJorjf7OSa+vVHmeGCWjK++cA2/HsVKCCfOZ73uUaDT1ynf4KRE7KZ1SCX4xZSSn
	 MK7vbZtpBy6S06Bv+g8IYjI2gD/FDjibAs1XtwhLqVpepVJmBENxtCoKG6fWUkc7zQwWP
	 dLBOqdS6HRBKJSAPlNcqxB2Sz43l+siRf9vsk0MM7arnGY3V/uK2wb76ZK89e8Sa8imy/
	 LCcLo4uvooQFg3cABciszDIBW9n+YuZjosfi4cJMq7ThYFTHNQn8sEKWL4Wv7rYivHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dh8caDS7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBED60A263D;
	Fri, 30 Oct 2026 04:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dh8caDS7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124121F00A15;
	Fri, 30 Oct 2026 04:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793334243;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dh8caDS7LQiaMEZdCpy+q1verBYTgJsnLXnD00vLjc6i3i6Xqryj1fRCgFmTnbaNC
	 Y8fzaLbp1aHCbtBcfF126IQZk5cTtNYDAt921AARhiNjCzM+QD6v0vgZ5Ys2ux9pgZ
	 q2dHCGBkZz+A/Vh7EGYek7Ma4TJX/4ka5jcxE7CKeTTbqkMAVe6IJnjXGYwn9V6fwI
	 wb8YOa2GN99/V8XSRASYBbyD60zFiyMbnxJEOfk9IKVr+IUgBbHmY4AkSoHqmhfrz6
	 C/kljxa1pl1kCwivWX1UtmC/GcF+to4uIeY3ZO7uZynEbumhrh+wgw5U/BumdglduY
	 rZwB0e4s42lLw==
From: netdev-bot+sinfo@kernel.org
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 outbounddisclosures@openai.com
Subject: Re: [PATCH] net: gro: avoid parsing headers from shared fragments
Date: Fri, 30 Oct 2026 04:24:02 +0000
Message-ID: <179333424260.3327.8381907365060593649@kernel.org>
In-Reply-To: <20261030042212.73949-1-kylebot@openai.com>
References: <20261030042212.73949-1-kylebot@openai.com>
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
