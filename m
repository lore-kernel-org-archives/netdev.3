Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1D943DEBE;
	Thu,  1 Oct 2026 05:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790833149; cv=none; b=F+22Jwgoz2t6c6VDPh2Pp1y/+lpqLe8eONkLeSC5XRuyFE8D1M7JCZHjuyXVim4fg7wSuTG6CVwugxzQ8amnYiucmO1VeG9M1798HJnCZm+X2KYE68YCVOCDPrxKD++arOcPJ45XdBLvWpHq6GvqscsIX1kzgGDTcUdCtP2FVWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790833149; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GNkEBcn0VJLapeqslUbU6XABWedLRa1lVDf7PQgnnU1vOYrHE1YqwO2lZBKWT18yVj/f/M3ocyg4RIh+X57b1eqQUeMfT623Lr5v7bYzXtZM5D95Ec0O0E7IJvwqQFBCp42JuuDSNwY1nTn3P7u1QyBPemkWRRGNTa1lNY5b0B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/SdpxBx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/SdpxBx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9F71F000FF;
	Thu,  1 Oct 2026 05:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790833145;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B/SdpxBx+sXCbLm2ir0RdmyuGV91/wsTGD1L7tzg5bP47cZFKLen8tFsBV9HDsjkr
	 I9Vrxzc898KkiquEemsDMyMBEjChQ3fSFvQAZT2WQBq5hSFjBERaId/4QsG65sGeAX
	 AcxCOVo6Id6ERBKrR4u/Q4sRFE/yT5rzBZ0UtoRMoe136/cBLg1cIssIVKPG2qHvXC
	 BW8CWH1/GNAXnQzD8D/EI0CzrTImJjqT8DEQkk4Tw9zSPTdPgJ5k/vOCYa0p7NsFaZ
	 WsjeHkMfyotE/zAWD5WwR69JMxbcdeItHlGEHwMObn6jcT3qB+oQKMXEuyd538bBKf
	 ThS/1EkhJHU7w==
From: netdev-bot+sinfo@kernel.org
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Yangbo Lu <yangbo.lu@nxp.com>,
 Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ptp: vclock: reject failed physical clock samples
Date: Thu, 01 Oct 2026 05:39:04 +0000
Message-ID: <179083314427.31693.1407407420445848454@kernel.org>
In-Reply-To: <20260930-ptp-vclock-sampling-v1-1-c11bc16691ae@gmail.com>
References: <20260930-ptp-vclock-sampling-v1-1-c11bc16691ae@gmail.com>
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
