Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48A634F497;
	Thu, 15 Oct 2026 22:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792102471; cv=none; b=dNA/rM8xYvfONeHT9g5FnUEnDtmcI/E4rHSCZBuKoyOYGMnNK1fl0hFUY5DmEEyP3TOqfTo+N9NDLhmNowwP3Yrnx4drOaYNVOvjOdCyy0qwDEUqIB5NLfJlDNjqTpJ29EYevopunyf2deP5IRG2Ui0nFwkcBaqhJy4qdGmKbGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792102471; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K1clO0MCEoZzjeCCkQnZ16XkBDpz3cScDz0cC9KtHTMVq5tbWC52u4RYLN8GVo7NirIahhFsPFU0ptBsVTpdzQeN2q5pux7mCmF/rzO39iEHsTrYiYmdy3+G2xaZN6fD2DEekJCf+XTlZA3cH4Gy7qBdJqIZF/9gGIMBE7Yav+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfFRooRY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfFRooRY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C8A1F000C4;
	Thu, 15 Oct 2026 22:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792102470;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bfFRooRYqdqXzFbdG2AV+3FDmXL/cHLD7IClfYbqqNGfvnNp+H7lMeiMSx6aS/aZY
	 a9XssHJCV85vtXFEOC3CE5cK01rPGyEsdnD4Q/39PvwGgppkcVFCO8n12FTfe1Gdwy
	 OAbSDXxjNRhk+a4IdcJRpup9FduTjdgrl1nVEWGlak1cR0dN+7Lmv197yWBLHpKK6G
	 a1htElYqKZM5eCcPuG980qHbdbPiCx17wO6rwLujjc28KidEphhl7oAk6z27xl2+rp
	 M+gMTEez0IkVW7BdVp9TmniDtV3YQjnuW90gFVEN0B/MPXuKrxo4vySjv2eA4pemNV
	 zBMiQWPk1lNhQ==
From: netdev-bot+sinfo@kernel.org
To: Omar Ramadan <omar@blockcast.net>
Cc: Taehee Yoo <ap420073@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v4 0/5] amt: relay tunnel lifetime, validation and
 request-path hardening
Date: Thu, 15 Oct 2026 22:14:29 +0000
Message-ID: <179210246931.408196.15916217763910071624@kernel.org>
In-Reply-To: <20261015220648.1545576-1-omar@blockcast.net>
References: <20261015220648.1545576-1-omar@blockcast.net>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

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
