Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2442834EEFD;
	Mon, 12 Oct 2026 05:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791784219; cv=none; b=jaLE8dbAfaDc+k0PSFWRGXmm7/6jUBFKtu3Cl5ok5YDje57nqrCwW9oVBO30lXtdcoO3vEkynwLb7pd/9AU0iGn+phJRlQGo52NQYn79tQ69+BpT+puOqJPKKaNtpDXoE1fWxthbtF55uchb984TxpOmdqteJv9TP6Vs7hSgjX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791784219; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MmUpLXsWizHj51zVBMyufcVIbk+x5HP4/DjaoYyN3dUi0vr++EcqQeWmWaB7tTqjiASvGrS0xR3TM8cxRL0+YsJwmLNwsq2zUO1MSASv3aLnEakziJkSFivXTmLbldWLE+KBo97fe18pGr11bqIoxA4CuA+7UOEuCO8lOoDCTY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hC23uCu0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hC23uCu0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93951F0089B;
	Mon, 12 Oct 2026 05:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791784217;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hC23uCu0mYw0Gc/4k9yqAsabHqurdOBWpiSXvDiWzcg0MUHNGPzj07nH2D18Chi7R
	 Ik97x/LORBYAx4H5OP9RXmVJBcLQBUnb8EPnLLSZgkO0P/BAei+PTG//GOvcpbBgdj
	 +dNuWmjwC8v2DN0BNNGh6kQSyn4blCeHLps0pHMXVRTwFmeM+8uPada70BktfHvxGj
	 bQisGo3yGu6BTHp6L3YfAArFiSxaArHWM3h/XSa5TBIpivW6b7pLDnjqKYoMA3Z1Y6
	 8UbSl2W/MU0zOkimw2Pa7jiRTSplR6IO9sxAi2YTbDhVg+caRqtvu6qjFUfT0LR+Q9
	 fghxxlaZ/LgDA==
From: netdev-bot+sinfo@kernel.org
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
Subject: Re: [PATCH net 0/2] bnge fixes
Date: Mon, 12 Oct 2026 05:50:16 +0000
Message-ID: <179178421647.2527009.1868476498128575514@kernel.org>
In-Reply-To: <20261012054325.1782819-1-vikas.gupta@broadcom.com>
References: <20261012054325.1782819-1-vikas.gupta@broadcom.com>
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

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
