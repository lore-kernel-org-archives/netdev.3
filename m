Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D9D400DF4;
	Fri, 12 Jun 2026 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283445; cv=none; b=IwPQVxyQqBtIvov+rfLvyG+eqxX0xgqxPT2arjbtSUVNmNWXjrrQWQMawK1qRYjQSMwt+MRLk9lQWehILmuiB0/ZZ2OkcgpTxyUY7uFyrKZtYapLAaYQnIrPivOvnlbHFjoX9G/SIIyrCdmN8WC4NMMWBhhl7mW40HJ8nI+l/70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283445; c=relaxed/simple;
	bh=xC1tuX4hJuJuJway5/HwB4D6JNfvF5qVmeIpp7nsnyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSMoak2G+a9Jk4ZRADoZx/f/V6uhfNRQfPzsdlxDUgtK1Vy7+Q1EZuLhosgeMI79zU/ZuLqOWaHSUQMopkhNjUCjRIRNWxazKGOS46p2l/lgYZZG9h6EIhT853ZXkAGNK9bGiKqx65Pde0uJAn/gzgAjPT6qbsx3Mlws7OYt67o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGng2gWZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGng2gWZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945231F000E9;
	Fri, 12 Jun 2026 16:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781283444;
	bh=QENODW8YQNIID3a9TwhBhQus7Lyd1okxsSpHeW4kB3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eGng2gWZdFK9fq2uq9dOWCrz8hRYUEotNL1SbPju/juVG1ED/9/t6XUI9HsTnEN12
	 6/u1lW21lwV11xGd3Bx6i+Zga0A2cToA5uok0/PpbhDScuVF0YazmGSf1zy5KKsyZz
	 PdoDYk5E7vkyMluHHNT765tbSHOA+Cn3CHzFmQ4SnDTP9KkXCjjjba24QDGaEDXB3O
	 es1FDJHHKrxZZfg6MZencxRD5gSZ2of7LXdOnDx+bytbIHc5DqnuEHCyeSeGcstMCH
	 ZQMyInveF2I4Z1Ucxm7tkBEAEs4rQrHu8BR4QWj9i3DBLDxoDDc36rNEfvRjCV2jJv
	 DoRpyfBw74p0A==
Date: Fri, 12 Jun 2026 17:57:14 +0100
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	sumang@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, sgoutham@marvell.com
Subject: Re: [PATCH net] octeontx2-af: fix NPC mailbox codes in mbox.h
Message-ID: <20260612165714.GI671640@horms.kernel.org>
References: <20260611083330.1652181-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611083330.1652181-1-rkannoth@marvell.com>

On Thu, Jun 11, 2026 at 02:03:30PM +0530, Ratheesh Kannoth wrote:
> Several NPC mailbox command IDs in the 0x601x range were assigned out of
> order. Renumber and reorder the M() definitions so each opcode matches
> the stable contract expected by userspace tools and applications.
> 
> Fixes: 4e527f1e5c15 ("octeontx2-af: npc: cn20k: Add new mailboxes for CN20K silicon")
> Cc: Suman Ghosh <sumang@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>

