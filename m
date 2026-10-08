Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6146F41A794;
	Thu,  8 Oct 2026 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791451809; cv=none; b=QmfXnKexdRlSw1WDnbeyV8eQSUYQbWTJZIrJZaxmg41H2Yi6EF8mZh9Wc57WX0xo9k7DVpoWoppIIHumvxwisYi6XZOTBbSZB0pIX0pbA1NLLFSqMsXJ9ISNpbgytLyaMvLrfjKaZc5mRCBVpl3cKiIvGCOpbOAPtneJDualAyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791451809; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CFd/znnHR393qrqagUflyTYNKnSZvZ7gGJjImot/lQbvQol5u90h8ck+/vXZAtP6EslD9ZU0CbvU6QaN7IfS78r0oePDKG/FshzD4Vzea7srb2zulVnE0K0oXdTivX/ADbMt5YCwhvyFTkOIfdDQj+98u2tbRaWmPafTpsw+O+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8HmM/NK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8HmM/NK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB471F000FF;
	Thu,  8 Oct 2026 09:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791451806;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E8HmM/NKQ1+hTwMCUajb/8B5wxIEHalk0dAG99zOUrLHtIcZUI6JtkSyxoLDgIzOF
	 VyXVzipO2uY7pyZVuA9N2KpF5KQuwdCcxpYOONDfHvLE2vFtu/poAi8ppVww6aKdpU
	 UWdTnX1mvc3mQy7zz1H4l5Cl8WtlvG/nwmd2hP0iIRocdLy4irjspHlESacex3pf9k
	 mWLvCxPPlkpLeatLGRCv2AIXcZtnOB8COTS2Gb8+HiH0L+bdr4RTiSum/nEhqGnM0U
	 KCo0eqjCkKlRDj8APcTrunG60gXfswLKu7xvKGsyjFUMTxdCDhYVhdlNbammS7lyq9
	 9huHb2PWWlNFA==
From: netdev-bot+sinfo@kernel.org
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/3] tcp: fix a few divide-by-zero in
 congestion control modules
Date: Thu, 08 Oct 2026 09:30:05 +0000
Message-ID: <179145180562.2527009.6846042530753196895@kernel.org>
In-Reply-To: <20261008092641.140777-1-jiayuan.chen@linux.dev>
References: <20261008092641.140777-1-jiayuan.chen@linux.dev>
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
