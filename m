Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103610;
	b=eA8m8Y1HgZek3/RRH4arMml9oNUyODhYhCsOfoKK5q09pk9lb5MxhbpFy7cagArEiS/r
	 6+5zkceiQPCSq8F9ICXy7qhAKd09Ic/ua/2Pj6tZ16/07bgd+gMHjBSwy3uXVrey0RaSt
	 mMxfcri5YQbI/3666lMpqB5h+q/OaAEDN0Gdzy4RzVkcENkfNStZswsX17rpQgG66APoB
	 pDeJ+ZLeRsHLwMDo+kJM2nSQBcC1FSQEUxl2AILm3ALj9dFds8Y5OXJYwI8+eezMAmzUf
	 MI7xJ+qrfDCq9BMEvwyORvCq6pY2TYxh7MIJy5N3uEaWQQ3LHmdeDCrLN3jolONtQCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103610;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	b=etF8xelyW3nMxExqadtPiXOwGVSOHt9wKUgJxVm+HiQ7A1xyM2X2KtD6fY+NVvaKqG5+
	 8zl8yZw+Gb9eK0LXlHnhwLPW0U256o1+mvUyGlNo3IRwmQfVJSsS2cZPbh1lOutGNcCA5
	 UxOV76SuYPES2pDrQvJXftuKRe3I1d6PZ7oRUD0hdhxS7voSwyQdgUjvBbtkLf1lu2GsP
	 W9vmAZTg6s9Q3UZtAVA0iDdyhprGC/xBPcG+NBZgGs8hkAhcjB/Q7RCJbBJmaM198Gq82
	 LlZ89JEMEW78zqf065D8kBil6LDffGdWq/0cIuuJxkZBLIT7pbKdro3TXoOZfxt4lwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iEAhnRJi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA52606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iEAhnRJi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FB61F01825;
	Tue, 27 Oct 2026 12:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793103610;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iEAhnRJiB4uWBnRlaX/a2bxhjXfdDSQaZXG/HRjqs943SzYeUWZ5H3Udr4+6pr7Wd
	 o3M69PSb4ouLUtACExiC/TLXZ6RbC60GKiSgNaC5786TuKF5xE8nSuGgnfQ0b6lc1m
	 KLy5IXZeVT5Rba7WcbkNm8z7WbN4QSS02M9lN0uXIfEYkFEvh/9pzx1S14OseB1Sre
	 Vl520JwEEV3/Qjy15bL07y7RRm0QIr6kI8Cihx9AbKVnjMcwwqkePrco9qlsmb2a0c
	 OGrm+Ji2+fYxmxjg4MrClsCCyN5wYdvusHU0SAWcjHxLhFT3vaBsZVmZUksXJben/y
	 nmHVEvVMPvkeQ==
From: netdev-bot+sinfo@kernel.org
To: Magnus Karlsson <magnus.karlsson@intel.com>
Cc: magnus.karlsson@gmail.com, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
 maciej.fijalkowski@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH iwl-net 0/2] ice: iavf: fix USO for 32-bit systems
Date: Tue, 27 Oct 2026 12:20:08 +0000
Message-ID: <179310360889.3327.4157213770892413960@kernel.org>
In-Reply-To: <20261027121442.907414-1-magnus.karlsson@intel.com>
References: <20261027121442.907414-1-magnus.karlsson@intel.com>
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
