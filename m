Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793115177;
	b=fcg5SghzdtoM0Bh+rf0ZEfzH3giKOJp2RAf58g7Eraf/RnsaMhE3Rn4KUWs3hgxlTDUZ
	 JGV5wPlsOnD6zBvtA6FaBDr1caxbU6j019F4MC/lQ4LJrQwoU6JuFnU/MP8Jl2LT/N+BF
	 FlhWFh3MQR1wkhMINHJrB9oBm6MYq5roktjKTBysJ4/bnD3a1dOpvkmFYLGSWpU1x2rD1
	 0h5Lb1HFLo8EqC4/k+DwuhOnAWqC9TRIcQeAQYE/v9nNJdL9sn7dIyooF+hpASJ4+kxBR
	 o4rpvZlqQxdnnN7NYDVDjN2IrffgAyBAjGp3lA3oLZcPm09/1FZvmw/bFdorh0DdK1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115177;
	h=Received:DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Xo6G1lsXsyqx2BLEOBT7WTn2r4JL2uALlik/SP/CWsg=;
	b=NldGzB/IqaCB8eK8Vyw/I2EUMFxZ2n54lT64F7/ZI9XT72fR78oxiGDOGVPXNXxyiP/W
	 LyhTF7Zx0B11vZ0qDA9QErGQ45bRobV4UnuaGGW5UULAXiaePqGAvifXshF/MBvgxso9p
	 hXGA+NImV0VMMY+CnZvcyigsMDrIA1/ZQAaRIiNqARKcaYQqJzOZzZkleVtkHHRcR5WnE
	 CBUNcpAbmjsID7cObFoUKizOIOLuD+NYYPlBCPry+IXdvD5dBhFKyejRQIQVVYJfYxRVG
	 RJSniqk/pacR3tiLCEtSyiKiXZxIh7lPur/rVeU1FSfgpThdbDjdECQkt9fxjUgr6lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ybcmy0y+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412DB606A31E
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ybcmy0y+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63C81F031E1
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 15:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115177;
	bh=Xo6G1lsXsyqx2BLEOBT7WTn2r4JL2uALlik/SP/CWsg=;
	h=Date:From:To:Subject;
	b=Ybcmy0y+4pFzYHyb6QZRli5F7QKvHAb1Vv7+Z4a6izt+rj0cIUJrjiGfr7+79Es5O
	 N2qAVkJg6AySJECkdXgh1MYITBiE6CXa5nY9XFZVoYpqQ/0vDfdvhVtmBQwD+B3Jk+
	 LW7pQyTprkYHp2e6zzCy6q6ABgF3XMEHBAqvN5Y6Oh/hHdnbeCkrsZ3wZE2FjOgWVG
	 SSawgf7UZrTuWJZey3HZ+UfPdZpS0w1Vt3LF/30q8hDZQMgjdtf2uLhaKjopCkyX/h
	 FUzhsWLKmf0BlTnToPNu9S9dzzGnFOVIezqbc7INcBxq219Jy/ldazVIrpSP7EuCz8
	 FPTRYXpxtleBA==
Date: Tue, 27 Oct 2026 08:32:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] netdev stats and patch scoring now credit the patch author
Message-ID: <20261027083255.14fe214f@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

We're experimenting with/changing how we count patch authorship
in ml-stats. tl;dr is that we used to always count patches as
authored by the poster, now we extract authorship from within
the email, like git does.

Before
------

Previously everything in a posting counted for the sender, as an author.
Everyone else replying in the thread counted as a reviewer. 
Pull requests did not count as postings at all.

The motivation was to place the person acting as a maintainer
as a representative. For NIC vendors especially, I thought
it would be unrealistic to get all the authors to review
code upstream. Conversely the maintainers should follow the list
and bring the knowledge back to internal review.

Sadly, none of the vendor "representatives" acted on those incentives.
Perhaps it's Planck's principle at work, who knows.

The old system while trying to "incentivise" vendor representative
participation was unfairly punishing sub-maintainers (netfilter,
can, mptcp etc.) Instead of trying to separate the two groups
I decided to change the accounting.

After
-----

The patches now count for their author. Whoever sent them is still 
on the "submitting side" of the thread - their replies there are not
reviews - but they are only charged for what they wrote themselves,
like the cover letter. Authors whose patch someone else posted are
authors of that thread, not reviewers.

The "author" ranking shuffles quite a bit as all sub-maintainers 
drop out. But the top 15 individual score table does not change.
Pengutronix drops out of the negative score table since all CAN
submissions are no longer counted as Marc's work.

This change will obviously impact SUIE scores and therefore processing
order. We will keep an eye on the scores and adjust the logic as necessary.
I'm not entirely sure what to expect there, TBH.
