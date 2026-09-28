Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048554FD79E;
	Mon, 28 Sep 2026 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790630771; cv=none; b=DU0qGyefPEvEyVfHL0cGxDeaD3xNRhEq1unbL0CHrqR0hrdmtsZpKtupAk+dQ6+gy+4pyVpmRz578iMLpMEdUpXBJMZJlT9dvINXphA5mtSak5OtkDmHaF51FemRKvkuk6CDPhUDyQ8O3bFGyMQeyeFWGLC3FoTf0hNMjzt8K+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790630771; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nzPPbc7PJtENBnNfFBqgbMQuSF9MQL0CGrfwJ1qpCX3XScFwIjaRLsAb0XqAQS6wgxZMUC4zqkOIcTwsy38TLqw/L77o/Pxp0vtivbJFa4S1Nvnc99iplfd3UfzgTTxHPwMXu8Ur4M4OJIZVlQb8RFJ8rpqQSWcL+pFVuLPQmas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MduR3gtX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MduR3gtX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972BA1F000FF;
	Mon, 28 Sep 2026 21:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790630758;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MduR3gtXr91DWRG4YoQW3mgpUn1a2J6JlSpebGZygTQhFLkKXLl+FHe9YmxuqwW8A
	 CwC5Xk+pRS0sP2E+umLdXVhoGyxVPt6BvPqtHXEZjqMhtAa0WCj33YEuC0ZqH1L6j3
	 PnqU5tbAuhM7QmXPFVudy+4EiZnoXsC8CYdr8RDBy2IrZydSYPyVY/ovrlVrmKsh9E
	 8zTHjNCadulUGvM8P8bQDrVpeZTTcNo/lOxwbHXRVMAeTUMkbA3ajh7BptPG8A7wCL
	 gVql1Cok0abTm5mrBFkMz22BABYXLPF73GaA2oK2v3q20Qqa+X0yvzupKX+cH7rd8/
	 gWzIGiJQoCwyQ==
From: netdev-bot+sinfo@kernel.org
To: khendry@reliablecontrols.com
Cc: =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/3] net: pcs: rzn1-miic: Validate dtb
 configuration values
Date: Mon, 28 Sep 2026 21:25:57 +0000
Message-ID: <179063075707.31693.10158252953196019880@kernel.org>
In-Reply-To: 
 <20260928-miic-validate-dtb-v2-0-1ee3d33748e9@reliablecontrols.com>
References: 
 <20260928-miic-validate-dtb-v2-0-1ee3d33748e9@reliablecontrols.com>
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
