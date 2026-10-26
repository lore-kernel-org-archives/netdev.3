Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793035858;
	b=m/+8H3+sR803/sibQ11hjoNv+bZfx/5zgKke6he88W0VNGwUyJRFfKcbx80ScWWAqBYY
	 0yqnWBdesqSOUJgTQ06Mb0L5JhDuQWpEzKH2oUCk5GY8e9SMDBcpQqDLl8SQyMBllv3gT
	 uoq44n6mKr6QLVVu1PkHfmrXQWk8WgQmAhj0obXvifhBMnw5ivkB/PjKC6J/2ZsJF9XuO
	 idIAad4045bGepIwOHMVkSPqcFUB+Hig7yUSLqBwmVJn0ND6YofxPZuX+pHu4v52GfZks
	 sc/yMMvZkZk/G9NLJosNwp5lm7lgXblaKC2J1V1x0ziIjmC6VzXA27gg4DeZFgjyx9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793035858;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=jCo6rQTncltfN7loN+6cKDXKC9HHnYRUjvXVEiMemcX/vp7E484xbec8Rkwga5QrrMOl
	 xlIZEscbrPAcHk1RuV4jhoBlYoUY9Yvk3lgiye4bqAGrX88xx+A08XibZoZEztMZWcNDN
	 hH0S/El6NJsmgGYrcXQCCnVqL5OQ0QTr7WgaEJKdlZxD4IrQZQqhB1GfrgroRMe1am/5P
	 os6Kwgwa0uHyeG7ez1njlqztHc5K9tI+Sg3HJwJjh5f9QEO3L8F2tkm5eyQoGU+OYuvIu
	 YgAak217kHNP4qDm1dE1Xlqlz/zk32cp8LKdcnRfLJFNvNnWO47Ke2QWF6ZW51j65MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ClYcui4b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B502F606A31A;
	Mon, 26 Oct 2026 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ClYcui4b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B345F1F01825;
	Mon, 26 Oct 2026 17:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793035857;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ClYcui4bskJC8a3hScgN3hQxNtHOelCqugg8MbzsW35FBFtA/YKnTuwSwnWDAQn7c
	 ODsvvy9Zep1VpG8DuO47bPcHr6ifvY9WFEg3GKL4/vLvmhNucpx3HyrYdGNMf9VtnI
	 aT50u2S1O1ASXL5FLioOVmf+Q0BBjERLuTrs+fNtGpcqir+T7N9nbDYOYhXUIs7qUI
	 RRnM8V7sq6TyWeiwG/EziPHl8PkzYyO1b9FJec7EdfMZ3ixsrkMaaiWTT2GkA5FsyI
	 cg95xB9WEH8KW1G7YH0Q7fospszrEFizH9J23I8tO/EF+XjqeUFonVwE38dwnvGvDY
	 bz2dqa3HYJo3Q==
From: netdev-bot+sinfo@kernel.org
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vivien Didelot <vivien.didelot@gmail.com>, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH] net: dsa: b53: Enable IGMP and MLD control packet CPU copies
Date: Mon, 26 Oct 2026 17:30:56 +0000
Message-ID: <179303585627.3327.17394761075603736161@kernel.org>
In-Reply-To: <20261026172453.3152951-1-florian.fainelli@broadcom.com>
References: <20261026172453.3152951-1-florian.fainelli@broadcom.com>
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
