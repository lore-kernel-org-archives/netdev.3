Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06B938F935
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791283771; cv=none; b=LDLBS647pSb/LwK4niXjcZJWp1FZM6kt6+9c1hEnLb4hkYlwwj58ALJmSBXEa22DTKnldIWFFhbv+6zncsGDgBCKI72cPI0prxVJ1ch/5MJXhAtjjdoNR9l3S0lEQaxahQsTSZsTRxUcqVIPs7IqIEfBbEQX85qyt7fLbN5aFOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791283771; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YAYyEZ3sDH84n4YlQEHleIRHaoPxT9FWt8klVf/3/lfvG+hQrqjGYKKwrz1XtVkz9r04daDJyKCP0a2I+6nfvzM1OUD2gHyn9KoihJRpnm7q7zOGQpNZQpYGddQ8fZdvMRiDajvCzOvcqXKMZAOuIeSfhVLKSjABJEURnTt9Fro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXh1lGT4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXh1lGT4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BCC1F000FF;
	Tue,  6 Oct 2026 10:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791283770;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XXh1lGT4lAdzVzC9sthFc2IhYCZDwTBHi/HjnSx15D6rngrynGv8/GTL+2vYzATBj
	 Mv4G6fC5pB/jeydkk8H/HEDiA81zvt8TIx9t9NECy0iamrh54HTyIMos2/hRAb0yWm
	 Yw5FWLb0xbhztFALNihOtH+Al+Gy6WUWXYTS3hZRZ+mrrO5Jl0T3sUgv5R5Fl5mJhQ
	 jzkLsU4zFsmBUDiIty5971jNuCw/DfCxeBm7mUsg7eMNjj3axtZJWC3luDVWirguXG
	 ZTJ3Yj3lecQh55xMhSMGWVeJb52fpUl8XayiBmSMP9gxoUnQKviNPX8j7wisGaQziF
	 F2ieaPs5jadYw==
From: netdev-bot+sinfo@kernel.org
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Vladimir Oltean <olteanv@gmail.com>, Furong Xu <0x1207@gmail.com>,
 Daniel Thompson <daniel@riscstar.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Davide Caratti <dcaratti@redhat.com>
Subject: 
 Re: [PATCH net-next v5 0/3] net: stmmac: Introduce hw queue priority offload
Date: Tue, 06 Oct 2026 10:49:29 +0000
Message-ID: <179128376932.2231598.7510820392039419594@kernel.org>
In-Reply-To: 
 <20261006-stmmac-mqprio-prio-offload-v5-0-d7da93419784@oss.qualcomm.com>
References: 
 <20261006-stmmac-mqprio-prio-offload-v5-0-d7da93419784@oss.qualcomm.com>
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
