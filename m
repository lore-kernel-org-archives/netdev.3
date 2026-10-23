Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792749982;
	b=cmqizypSeghI2khG2x3y2z8/YkXnxBbOx3uOdSrBHQZY467abZ46MpEk8NSt6vVLcCK6
	 UgGW55yBn53TQPgAx5e3WGA4pMjX5CS/qZ7VGPbmTo6B1tY10fu7KSGeVF5vXzjoBgKoI
	 cmDPk8Wit8R1GYTw5IZ6m7j1okXWihYFfaFL19LD7xPM+35KJh7b+p1dqzpqObsyWg79b
	 6IrdBzY49nMTnuAGolChNOsERfjD4yk78Vygl21y3/D/aDbf719fXanhwW20ghQrVVDrm
	 nmUtDqBVtou/eKMlm1Y0bpggNRSZx6Ptl1AIQeUVp69DBqXta14HhOq8EnL00OA2qdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792749982;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=SmSL3QUEFQ2P/zMXBCGM8vyNsjbqPeyh8tHr9zYi5B9nAAlbtzU6kJqtdFhqqLOnTJJW
	 yD3+s0A6ZaG4NHAynfvZijmL1ffEacPBAxYjQgdQVbHmr4qrA1MB+l9L5RiW8z3ifUP6o
	 dDEYUQ8n1h6fWD2rMUbatKyFcvceneaGA7QhUuHQ4lY4Gcy5VtnuP8iJde4xOIcy2SMCk
	 bCInDA/76KEeYsobTW3tlwusH/8d+Hu1npw50PENZAzfguQ2SZVxAPENwezrSyBML554j
	 B9q8nGUuahQKSnZl4JVN94XA4vl7fZ/DeQrXe0aRFxaz8HDgKzPubfakxEn32akGydw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=STHzw7Pc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A121A606A31B;
	Fri, 23 Oct 2026 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=STHzw7Pc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F59D1F01825;
	Fri, 23 Oct 2026 10:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792749982;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=STHzw7PcNbwqhDbj/xy6o4o8oUbsyqBkmitBbgg2Rd6Rz16Yzyyb4eq8duJfDmgFF
	 x+73MOgvEE16SiajkMjiQr0bouEFbvz7e7Mpq6mXLdM5RdJVnRhqrBGoX1Ud70qdOc
	 44Doy1ZGqyudGvxqNKPEo5Grtx260RU89Pd9g4gSXlQTgDRjtEc6hCKniJQ7/2tzNo
	 Q8j6uWQ4K1vn64O1zVtniKXe/b+PmuGP7tQKr9V9b5Ml2pXE6MNDiFFjCTbXFfCCaf
	 tMEOrE33NQssbCZOA/Omu9huelEJLK2Vh/CPBaUBCLrpTEBfCNMAIrciIdas+tCQZU
	 BPBNVtWP2EKVg==
From: netdev-bot+sinfo@kernel.org
To: vmukunda <vmukunda@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sunil Goutham <sgoutham@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Subject: 
 Re: [PATCH net] octeontx2-af: Fix npc_delete_flow counter read for cn20k
Date: Fri, 23 Oct 2026 10:06:21 +0000
Message-ID: <179274998116.3327.12401310357430696240@kernel.org>
In-Reply-To: <20261023100112.3402726-1-vmukunda@marvell.com>
References: <20261023100112.3402726-1-vmukunda@marvell.com>
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
