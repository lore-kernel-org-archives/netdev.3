Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DD33D47BF
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791382232; cv=none; b=lC82GL0xO8gdxfibzDz48vTndgqzE6Mr222d97LQcGkVOZcT0R2NoF0vQpGL0ur9byKJMjSJXS0Y4Np4bwCn8g86kDfD/dbviJ9gnKNO3tam6A5bgDWxfg8gqxbHHZIkZjBjVdAotSGLv/mB3hJMTAyX93WnmcPFX4hEFcFqpQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791382232; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KUWJlU6u4N+22JtDDrPOSIpt8tx1VzpuV4QvZqPgX6eaQbWqLK2ucHvFfKogGGbnRGUPkdJRfYlyO03uVlzQ0rpmybnw0VBqzIt7v0A/S8Hyck0QuSoZeJ3FfgcEawIkXiAHGkC3ZRrWiIw1ewH5+MokEGQsf+ARsGqucMcGvHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEJ5d6wF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEJ5d6wF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9AF1F0089B;
	Wed,  7 Oct 2026 14:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791382229;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KEJ5d6wF8myzyj6Ztznf9dDiNOuxYt3n7e5fwKJs496UCKEI4Qj2VKWHiBe99yMyB
	 6xnFFqhM/9O2X+nM1Mb15Ohw9/7plHx+pwXykf9ozbDjF/dNHLh8ElcQ8CbvcfDDnI
	 bW8YrpN1GhNKNH+leeMO4hqGSMF/A0NnZvMaBiNLvr44E/mYYg/f3sPQCJZ7CJK00Y
	 PYuuNaZL/anGHrmSD+nLtLqht+MG/RJJ9sP3dSczetBnahI3tawzjArZTuWmvlVPTf
	 amHOxm09r6y2d/D22EK5tWVKDKi1GvJrBBMBqVSeP5Ya+noCLPmIc11DDpxaEhUAbM
	 pWs/raE0CfoQg==
From: netdev-bot+sinfo@kernel.org
To: Sebastien Royen <sebastien.royen@armadeus.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, netdev@vger.kernel.org,
 Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH net v2] net: dsa: microchip: fix KSZ8765 fiber detection
Date: Wed, 07 Oct 2026 14:10:28 +0000
Message-ID: <179138222828.2527009.4847778745454758528@kernel.org>
In-Reply-To: <20261007080557.15719-1-sebastien.royen@armadeus.com>
References: <20261006130006.134847-1-sebastien.royen@armadeus.com>
 <20261007080557.15719-1-sebastien.royen@armadeus.com>
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
