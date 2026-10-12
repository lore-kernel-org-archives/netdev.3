Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFE23E4106
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791800076; cv=none; b=Xro5i5rRbcEBx546zGQqQFH9GSvAn8gLXjk/+aU41A1LoMXPyoXaENtBomEvTli4VZeKknhrSMQUWkJOfTphoDEUYElNfIqiBMCFeNe5dzLM5SF3vJX1RG+1O3B9VPI8Bc9K5hLJQH/+EKH4QZUh1+iXoR5F0DqxX9HpD7986xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791800076; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YOl8tOO6gdN5FVoWByGnmfnzXAdTDPYmKVTATbWjm1MRIqJ4trW+m6H8a+lX7mDlug/W5t0AIDTaX6MLMfdUuBrZUSIeuA1CWMGWZ8hEMyv49CNxw1LTbyhPMixX5LJeDZBgU+dlSE8O13rqUYj40fEg5ocHTasJ3ecfMxMPNYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJI49sFi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJI49sFi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093A11F0089B;
	Mon, 12 Oct 2026 10:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791800069;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dJI49sFikF0DKzPaVpyflgcfcsl8o3Jr0acSXHGvg/TKT8MsD71DIyIxw7EQVHU21
	 3Lkm92rwVZumwJ2M5SLRT/ecli1IyC+Mb7R4CqbAc1zkEeINKvg8OGh+WDtz1efAky
	 RZEEFQYFT+H2aEsAJcoUwOsHnWzl57/Vbls4SqzTvXNTiY8/KfWiPvtagnvMomzNTD
	 UqpANDYujeYS8uJK/a2JN51uoANwHRT8Hub5L1LnXWzga1Da5Qfbl3zO+CHWJ5ItCm
	 0nPaC2LC8SFZLm/sJGFJbFAHKjRCKRzNmWagm6+Y5oc3MPfrFmBKZWM3GJmPJJodYQ
	 9CochCUu3BLfw==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Neal Cardwell <ncardwell@google.com>, Ido Schimmel <idosch@nvidia.com>,
 Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 net 0/2] net: fix sk_mc_loop() with request and
 timewait sockets
Date: Mon, 12 Oct 2026 10:14:28 +0000
Message-ID: <179180006852.2527009.12798603432513947865@kernel.org>
In-Reply-To: <20261012101029.927296-1-edumazet@kernel.org>
References: <20261012101029.927296-1-edumazet@kernel.org>
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
