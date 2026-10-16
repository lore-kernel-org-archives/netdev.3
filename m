Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA11A442397;
	Fri, 16 Oct 2026 11:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792149798; cv=none; b=MjTHXbcwlS7zo5cv/yc3y8+EmF43UkU/go09S+gJKiXViKhE/wsGT2YnPH7zZ/fdvMC6FF09k7gpwyKOvrkAgijDfaUS2GjMvNklzHWCtmaRgV9htON+6xhcr4o0lp0Stf/luMY+FgqYHLNra05Pr4E29rDEsXi9bYix8muVXuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792149798; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jQ6rKBCCsXGEeavSYa5Ucr3P+BBLDjFYghzUjUwnKqT0IGKQPsIIGW3rmXhQMLw4qgzJf4muY40yzLMWHo/GOWkzywuS7DiCOaaHodxVoozSsLG/wDa/l2nvJxRcmGyY6voaCcLLlZmJA647HFVC2hHiz/wnWNxoa7MUK8c1PRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMbGhJbY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMbGhJbY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E111F000C4;
	Fri, 16 Oct 2026 11:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792149796;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lMbGhJbYO2+QP0XChqqc4f6LxF7mzlqW9Y/EoQnU//Qh5ZFxPzhAucIzDbEzxG6vY
	 +W+ROUZGp7VhK2Tg++YoIUtjJ+Du8rRl8lw5kXYwIR/s/1wJwIgbnn/bDGJmV6Z1zU
	 EY0/omqJ/jXywUxwRxQUH1uK8heCrJGCrpPxyFKl56UJR81F/XhwuX+Fe+5xRmqguJ
	 5LuTdtE63RPhYWGa+USrDY4yBcLOeGvYLmPXE5tpzyPpA8jbQCm/Mt6hYpW/NTrd8C
	 WZLbzvpzfzetOw8sE0GqWPOiTc7CdOQFHlY7cxQhsQx6+ok8RWAKABgQYWMDHtDAnl
	 EKEUCdGn+Wu0w==
From: netdev-bot+sinfo@kernel.org
To: Sai Varun Mudepally <saivarun@couthit.com>
Cc: danishanwar@ti.com, parvathi@couthit.com, rogerq@kernel.org,
 pmohan@couthit.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, afd@ti.com,
 basharath@couthit.com, horms@kernel.org, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pratheesh@ti.com,
 vigneshr@ti.com, praneeth@ti.com, srk@ti.com, j-rameshbabu@ti.com,
 m-malladi@ti.com, rogerq@ti.com, krishna@couthit.com, mohan@couthit.com
Subject: Re: [PATCH net-next] net: ti: icssm-prueth: use
 dev_close()/dev_open() in icssm_prueth_change_mode()
Date: Fri, 16 Oct 2026 11:23:14 +0000
Message-ID: <179214979438.408196.11375100740673315884@kernel.org>
In-Reply-To: <20261016105206.167094-1-saivarun@couthit.com>
References: <20261016105206.167094-1-saivarun@couthit.com>
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
