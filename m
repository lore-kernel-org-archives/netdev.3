Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1D83749EE;
	Mon, 28 Sep 2026 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619593; cv=none; b=KXW9eTqby+nFt4C74CBvQcqMpEwvRqPsBRFzak4FUz0GWQMlI9M8UrNcLw9H31vLoERoPfF0W0xj7Z4XQNHiSC2QM43wV6caoX3bx0lqmfvnoDbHvpkzhCdi4KXolfOlK99JjHFXuoGqXWknK/uWWbVVoFq2ZEAlS/mbUDO+ouc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619593; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LU6fprp7eLi6gnz6NDysgAc82z8FHK4LQvG+Wzb3trPIxtaqsq8XUVMjVtN1lZHlqEFdARoz4cGGBWZbxCx1Ngc9Lpibynb7sVlFwMoXt//DS4Ze5Wa3MRmPqdyPE0Bsjhy2lff4Dv/PgAe+adpVjT3n2T5S6/ovstvOXXT7ITg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsQ37pSY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsQ37pSY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBAB1F000FF;
	Mon, 28 Sep 2026 18:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790619592;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nsQ37pSYVY90i6Da2g93ZWwhigYHG8dU0DvKYYVevowJYf0qVgS0eUVwH1AsKjJyI
	 Q2IlbLDYr6F4vHt+HOY7MA2Xz2MIZvY4855qz63MW2IOfF2/BOEUacW5btWUfc97S2
	 SdZwRIKDwq7LR05JIBWP/pndjr9vd7L2jwAbwYsd2lD4L8PFnYAQ1PVKyQbNjG2Y3i
	 Gy4fSnUFWf5grbbByNe99c4GEAXbHupJzReMISAnYpqJjtrs+BInwlO1tFnlAXpMWY
	 9NtC9UkGdYyD85h/AHZmhQHxA0M35bBcUaJzVEARcOtSHH/Plpe9qCOtjD1DmILKtq
	 og3MSYT/g9WFw==
From: netdev-bot+sinfo@kernel.org
To: Omar Ramadan <omar@blockcast.net>
Cc: Taehee Yoo <ap420073@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] amt: do not offer software GSO on the amt device
Date: Mon, 28 Sep 2026 18:19:51 +0000
Message-ID: <179061959167.31693.11895969550331516671@kernel.org>
In-Reply-To: <20260928181554.85766-1-omar@blockcast.net>
References: <20260928181554.85766-1-omar@blockcast.net>
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
