Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91AD3EE1F8;
	Tue,  6 Oct 2026 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791288934; cv=none; b=VLKFd8t8xbag1OT+vHFORyWdJv81W3vCTRfWpe7HihghzpwxmQUwGiJEw0bt4tUpv9BWLbJsTkkg4GbUroo8Zeq1ALrAuMndoag8jbB8HbMWIStLNqT4rnD3PJT+Y23vNM3QyyUgFR3/d+miJeeR3H/FrBz1w3CRoCDQ3OJ3/UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791288934; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bYM8pOHUuAYu3kScYlREWItwyD6wrljKNs8hXk6nkySg1ENkdl7pindAcy9gx9yWguQR8Q9a0x13kUq1r865pCexPfHGFc0CQUfnJXg+ylUwn+2prWpFklwjyss8pFGCnCLmaZjopVef80E7eSbjrkTzOsxIn5tNa3O6X/zvzUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKwWjlTd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKwWjlTd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97631F00893;
	Tue,  6 Oct 2026 12:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791288932;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RKwWjlTdvYZONbkV6HxvycXq0CozaTw+PCB4h42smsV+z/mzRdcAHQqIRw6yMl1fu
	 NOdwOwvWWKs70Rkz2PZd9xSH8jJyVk7un/XDM+Iit2XSwKuRFDS/3Udz4MdqTnulKq
	 t6ebxczqj1/B8jLFB5Q3mFsuWVvcDyXzQxSGyyGpqsHKDHjeJwfffEEQdeHenx7XI2
	 bkz4llAlFTqfwgsNNA58kHP4vmGKuZXRlwwRCTYLgwJsCQ3uPJI0fIjh4M/nPvb8Dx
	 H6vt8MPE/eIvLSI+xMX2MVJ02eBalT9dRk2HLgaRTc3vOwGiA1RS4MKlIBlm42Yi7C
	 tQm2WtAFBpB3w==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?=C3=96mer?= Mete Kaya <omermetekaya0@gmail.com>
Cc: netdev@vger.kernel.org, oneukum@suse.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net v2] usbnet: fix EVENT_RX_PAUSED race in usbnet_skb_return()
Date: Tue, 06 Oct 2026 12:15:31 +0000
Message-ID: <179128893145.2231598.9489740412744373622@kernel.org>
In-Reply-To: <20261006120825.342164-1-omermetekaya0@gmail.com>
References: <20261006120825.342164-1-omermetekaya0@gmail.com>
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
