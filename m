Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8C5346AC2;
	Sat,  3 Oct 2026 20:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791058782; cv=none; b=sqOzJ/bN00Zj3mPCMWe8sj3NPmuadiXPH2kK9Zf2pBHM8mPx2MJncs3UcFnTRGeT1PqFH+IUlNDkkzKrhYlCkX10GAwU2bgv8LZSdURQLc9lRsMJuqTNhO9FtXuG5fu/LQaLlrp7xInhafs7zC5uvEpKLs9kHz1hsgx/Bs+cDJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791058782; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SlViaW5qF4jTb4yso3EByshyzuqJScCWK2tNSCh2KmA4ev9MlZaqfqnjVkbYkwQWbEthvaEU3aQ49MxIaDx+ZnPkeYG1wFU2DQNbd11WhewoNoey9VMAR+4zFwodU8Msut8PfhtNteXPK0uJRaWzLdxQ2uUTxUNsqhM7Eiwkn58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWZph68P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWZph68P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47D31F0089B;
	Sat,  3 Oct 2026 20:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791058781;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PWZph68PirMsQXPtMU5Zuk+nhWTztWdKlewvV/bvw2n/mzEgfznBR5pKIuheVfx9k
	 Yhqi+9UFaxzqdhswnIMZcomJF1USxKs1yBGKTuATiAsjCSnvglzsW/NhV7HDKbd7zI
	 6EvXpbxoH8m+IHSZ56cf5umrGiJY0QQ8gwieSeI2QGmuXx4KaLccMwOSCyYVRS04F8
	 ky9qHTcpLiyKBxGkk+bspesPBZ4sktzs1318v+Z89WtFod58cW0XkFTFQdP+M01v+y
	 ydAdXCeUwJa7+1toa/dyj/XIZMP9iMzTgmFTuXEXNhmTuRN5D7Y7w4f4u3QbaHmBa3
	 5r/MHpY8fhxIg==
From: netdev-bot+sinfo@kernel.org
To: Andrii Pasichnyk <apasichnik9@gmail.com>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>, netdev@vger.kernel.org,
 wireguard@lists.zx2c4.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] wireguard: peer: free packets left on the per-peer
 queues on removal
Date: Sat, 03 Oct 2026 20:19:40 +0000
Message-ID: <179105878022.1402591.10615903497956533993@kernel.org>
In-Reply-To: <20261003201625.4572-1-apasichnik9@gmail.com>
References: <20261003201625.4572-1-apasichnik9@gmail.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
