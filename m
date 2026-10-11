Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3199321F2D;
	Sun, 11 Oct 2026 11:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791717550; cv=none; b=qg1MgZutPC34EkusBYVw9+Luy2+ZQ0qIfR7qau2WDU4Ys2h6vA6rvKYJPJq4oba9MPGTz5FIYJBHG27Pc5ZVOYKIJS7yMs7cY5Suh+IAjyNmW4GMVl8UesYW2PnusE0DkvZR0OYmqB0RgIqbbvZhML7fvyttvrisGpYEKOTWol8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791717550; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I1C2ZHsvQC4SxWvHxUlQTi0I0J4DZGdrNtqXT/nLDCC6cAuup+BQMBq4AU0PZTD8t7k/PKx8hIlZKIidXIvlo+4Q7GEubvmAInIbKBIWz1fZ4u2+64/vJJRAI0HgHFNvzIOq99IyKl/191hRUCof3qWNSh1QrlQKHTe+GD/2fco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yo9fuhlG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yo9fuhlG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A900D1F0089B;
	Sun, 11 Oct 2026 11:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791717549;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yo9fuhlGDub3oHOZ2WZc09oK5Tj7iyOLk9t+sN6XgEyNaNle0q251wDihqn1Q38Ui
	 uP3wuImKTTT7QgU/0QoyzjMfLULSOPP2Z06QQdOY90H0j+7F8FI4U1+cVaMR6aiXyF
	 mmVXeGNkYtYY579426vzFz6/Nsx1NXjdpZVf80vBKnTszX2aQDTTvGk7nT5pwowwvF
	 9yDHvABvO4ca0vWE+K0XRjibvqBDgAz2EtQPQpxGhqfqHuFdOa6JvoBpXBsp1JkWDh
	 InV4zZzR/TBTIB1huRPPSLWZU+uerQxkzoZdhJUbItI0cb2w05xf2YJOvhnbjeNTg0
	 QlwTcFhYSWRVg==
From: netdev-bot+sinfo@kernel.org
To: Shashank Mohan Jain <jain.sm@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] tcp: keep the route window on the SYN when
 SO_RCVBUF is set before connect
Date: Sun, 11 Oct 2026 11:19:08 +0000
Message-ID: <179171754826.2527009.561712354727529429@kernel.org>
In-Reply-To: <20261011111606.14753-1-jain.sm@gmail.com>
References: <20261011111606.14753-1-jain.sm@gmail.com>
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
