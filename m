Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759588;
	b=Nlh8wHL5vqUsretsumXNKeWbowC3OKU/C1GLdd/UWnu8uRTRujA+4NcBNZG5H1ATdiGF
	 0R+tDIYlG7pFjpbMMUxEQ/xj0XYevvB0JnRJrvGVjuzQ5CtgMjuk6teGjlWxLa3wYF+Oy
	 ChQpFm5FvAcp0bFv4wcYcYFo9xpyE6VOGET4+jn2rttR4aEKA7Zq+VPYtCMLp6x/j5rFg
	 NourCVcIqMmxh6FbDsXlD64P/3biG6xx0HOLW6DrzU6cxkUR0FbBx1h1yndTmu6WbWKpV
	 b1M1kiiQ9H+nj+fz97scGmnMa22wp0KcEh+tt03ccZSc/PPNJivjLLg5HHr5+BU2uqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759588;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=CdmhZb9JXWAczyOlf8TeO/DluUcc28rbbQMJzsXXYLqrtBa1KSrL/Mx1or9KbOlhOoxD
	 KC9+aUhchYQI0nJluZWNRgtEoA6TZiy2DgktI1QHs2HHSjkxsJ9XrrcX1zVbSokJV1Fi0
	 3KjYVnpTtft7VTMN5GlTwi/hQuPdfQ2JempMwJIE6k0NT7PMiAwwPWPLZN7GOBs4/7Zu8
	 3EzW3IbY8lHrBZz4VjMS3mEKertGT3JIG4OBI6WSwBkIsmOtZL4Q5QLopBYoaYUAwk/AN
	 0dfDvDkQ72Rvvsy85JlVIQ23wVhOLM+4NTO6QLUtirWPHOwBkgpnN2lcieaJnf2841g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HOFr2pxS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6252606A31B;
	Wed,  4 Nov 2026 02:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HOFr2pxS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498381F0093A;
	Wed,  4 Nov 2026 02:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793759587;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HOFr2pxSBd8My6klkIObkxlqOW/WaEPLtQUV/fdTheTVjOBrpGFrsBnfVtomL97JW
	 s9pnlXxnZMaaQftNO3nTymX3HK6B0m8cko2s9bAp+Jw7qvr2qK/Ekv4V+Aj7ikGN7z
	 +EVhPWPb9yh6q0hDRKt+NwTEp6/vsyO9MR0Go7cBplmAAi3ZbacLFY/jLxoxm5Y2V9
	 BHlLXRLODvYq7XZmj/he+DZOUSx1TyryOAHkWBqfp/qkROGV2leNqOAK8vjDegN9DM
	 X4JUZ2zImanBJKQTmLCGcpwbD5ULKfCvxg4pqKqlLq301OaYP0hJJkYYCIxnU323gp
	 txAZMvcBm1nqQ==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: David Heidelberg <david@ixit.cz>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org
Subject: 
 Re: [PATCH] nfc: llcp: drop the socket reference for non-datagram UI frames
Date: Wed, 04 Nov 2026 02:33:06 +0000
Message-ID: <179375958687.488859.16468079358918278608@kernel.org>
In-Reply-To: <20261104022810.1484199-1-vulab@iscas.ac.cn>
References: <20261104022810.1484199-1-vulab@iscas.ac.cn>
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
