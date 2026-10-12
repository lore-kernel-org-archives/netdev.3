Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21E32236EB;
	Mon, 12 Oct 2026 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811841; cv=none; b=Ahzj2IA8Fe6NTIs60CPdt+jqqmS0fNfedv8yUW4gWu3NPuI7D31z97gHOOmAowBIfbJ7RbBjz7P18MBgh6svy3a8cf8IVHtbuFm3bXtAZV5tdCG0E0dqPnCe6UF6XIUMg7psMJJss7thCq1xfApSAU2FATy/EdxRtNGg/vhaIUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811841; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rPFsdQxRzPYbFgg0Y0PPN/oVWIe6g5Kv2KrPQhQvjtTJ/mbxPBjOfxm/l4ZfQWvaXkofGhYW1gDoeW833GwQbbt78nafZM+G87amHnONqJfozRhD2XmgZUdXJUzn63YVcjpxOH8jx24QdGM/W+rD7o0sEW7rIDsOfIK41Z6l2t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyeEUK9r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyeEUK9r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B181F0089B;
	Mon, 12 Oct 2026 13:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791811840;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cyeEUK9rkM9/yJLuWX7C2fT5YolBgWEzXAiUBuXUlQXyW5YDjha6Ulag3FkJDMA75
	 mEVDWlNRdt5+28vtjGL/wJTYaKZ+w5CPPHhpVrs52R6Dih9is7wy4MYU4AEGASpNPz
	 o97cOjIviRrKKsQ2zjEI2xv5etA37KK8KymSo0PLa9JXczP54O7MR8Y/0iq9THKoLf
	 4ZphBflQNiXkQB8LYLdgz1RKtazAtwbDzE6ChubYR10Rua9/kWWR6jR4fygsMT8Wx+
	 tOCCtonnP38Kg201YvePHv+6e9pXsFIst2zdBPAYj/TQNT7rqvD3/rsZBJgPquQNEn
	 6TUUe2be+hMKQ==
From: netdev-bot+sinfo@kernel.org
To: Shashank Mohan Jain <jain.sm@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/2] tcp: keep the route window metric when
 SO_RCVBUF is set before connect
Date: Mon, 12 Oct 2026 13:30:39 +0000
Message-ID: <179181183946.2527009.5855837780305581870@kernel.org>
In-Reply-To: <20261012132622.48550-1-jain.sm@gmail.com>
References: <20261012132622.48550-1-jain.sm@gmail.com>
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
