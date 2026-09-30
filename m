Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A200466B1B
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759638; cv=none; b=Wb+K0kMzlkVg5vIJS9jN3O06u2rAVyq89P6l+adepQY/ETp96pHt5qUBCNuCF/9Yb9zDjYSV4T7up6i4kwKQns8mrEhRsUBetg6lGGuPWK8lSUHJxcU2cy62gLi3Q+7MxeSi5jM5d1tKwD43gHi9tS+d/F8pRlBxdzXakOlhdSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759638; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Djkp2DBpQpd1uekKL2k2sdTSYdRqfSVgGwHTODgUJEd+Ymz7zYZ9e5No2xw4AhVft62+yQkbQ/7049QV4Tm71k5OhRagDWD/Qdj+2Vn6sl2RD+6wsXzmiNawntf4MhpmdWdCBGR2sgpTB1V8sg2/S+Ty8fsavDfShegZ6/LioRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ot1Afd7y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot1Afd7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748901F000FF;
	Wed, 30 Sep 2026 09:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790759636;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ot1Afd7yHM6R9jCUhbR4r4j8AwPnbceLR5UhnNEMNlo8M7RKCCA9zQQTMZ2FNTiR7
	 qIFq8W2CZ1wL5J16Vwh6Hm2TCRRJ684DGH2mJjy4OjrI7FbrHuky1xN3X+n2kkvuNZ
	 D4+BY6eyZcV5C06l19EPi99fvn0n9zlX/VNnadg5LX8RhwVHWDudlZHWr9Y3OyN++V
	 tiieeeiDimpVPi7kh310LDgjhBIvUVy8GYlh1d6Uq+C4Iw6aJVOOu8GXIEbCA9MycR
	 mn3C/wKXEHNxGi/VsW5P0pFU3MvURpgNG7NGQY6SxIM39/yBdGvjvGU1YdJ9yruWWb
	 q4/JMJo1Tv6HQ==
From: netdev-bot+sinfo@kernel.org
To: Qihang <q.h.hack.winter@gmail.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au
Subject: Re: [PATCH net 0/2] vti: fix tunnel device use-after-free across
 async crypto resumption
Date: Wed, 30 Sep 2026 09:13:56 +0000
Message-ID: <179075963600.31693.7880919208314874803@kernel.org>
In-Reply-To: <20260930090813.73901-1-q.h.hack.winter@gmail.com>
References: <20260930090813.73901-1-q.h.hack.winter@gmail.com>
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
