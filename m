Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6FF40803B;
	Mon,  5 Oct 2026 19:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791227645; cv=none; b=pqwj+r7aImPoly/J3wvrbUkEsI4dUZ18KZCF6U5k1QezBVm2uQLkIJXkBLRzfgKG/oQfANn94PqR2O36/CI6PDDc7lL5WoRAw77LOnkAmZuClFDaW7NkX52PoSXo7Hi42iaNqbgYlEWYSlM+/tdi9mbk6wqipWlaDRln4hKu6qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791227645; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DA+m/kRzXMUMjpIsCANyQ5kMAduzNfP6YrfiSVSl0aILRM8ghRDK6kw7eC1c6MK74iFoab65WZiuMGXpAiZZwikU3/RAOAlNjvbhv7hlqPBn+3PzYqdaPytNXhhNGIGvBCm8C7btd8pM6OeIzrzZoSuDBh8VwwPHEn/TJkWzvFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4RHala3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4RHala3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED051F000FF;
	Mon,  5 Oct 2026 19:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791227643;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e4RHala3k7Pgfs0tZe6jUe7QZxvXpOCC840iskKzEysX3ByWNU48Js4gxTgDAtqph
	 PB8NIsVzGGaM7tUufIMPp2QoLQ8FJF4pSnpl2qpszjm8iyGsJ6dGKYm0PoCzAd0W+k
	 luqC7J2XaxSKlkzgzXSsbJC++MY/WyMEeR+KrMXuVWaymSAR47bwLc0OiApfbS+zML
	 2qUY/3u4h7uiWKDGQJY1RzNWgZZBRVTLuYysgA0Qfw8CMpJXgOg6WX3KCo6nxkVD3j
	 QKfe86Bdvcgp6EAESi1lVxnws9K6cY0xsBHxqNtD8ZXWdBBkACHJOKqAmJVjoOpMiI
	 eLE7ISb+6fOsA==
From: netdev-bot+sinfo@kernel.org
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: phylink: allow stopping a suspended instance
Date: Mon, 05 Oct 2026 19:14:02 +0000
Message-ID: <179122764255.1402591.11842213570415395688@kernel.org>
In-Reply-To: 
 <20261005-submit-phylink-suspended-stop-v1-v2-1-8b8e5d53dfc2@gmail.com>
References: 
 <20261005-submit-phylink-suspended-stop-v1-v2-1-8b8e5d53dfc2@gmail.com>
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
