Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969ED49620
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 20:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790714357; cv=none; b=lK8HbHkj4ZzgwH9bbTZSUK0MAaX1Vv8+/4f/N9ktT8gcLt0+Ws5Va1QrgrZQNl6Tpi5nXmiFT91DwB862502KHYylz+e3Kd/IOldP5rubY9PmBRJm52HyFSBVjcnBDHXQtvpUTX0ZQEeCxElTPx1kRU414IOoQSLoxBgqb5FC3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790714357; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HQNHFQJ2V21YYseZTXp3nit6/eZ2MetUCvM2GprEksnAJJORBwPuLjxLkisHPDdepKj819NPtJYm3ue1qNfTVlQ77Ybqa5KScIK7EqupmRMmiXuBFyxi3kCxlgOkFRCFKyDBcV3BT9nhbe97skLbBhRarwEnM1ML6KlYtGCeXQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RthHihQ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RthHihQ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37FF1F000FF;
	Tue, 29 Sep 2026 20:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790714356;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RthHihQ56c/4PJ1UluWgs0KSZgUhOAeUaWIjSn4c1dDLe9Xlv21+TlKzIo1D3awZI
	 atcBsw5acsUsevBffPXXdmTcIz4LuJZ4/jfKAel6qrTRhPe03caI3h0EWcupnOSmfZ
	 c+wcOYAW3E8UCZqMjrOq5amqYPJ7oo0ij1BDLsbkoRYx1rcWJaPIJH99K0HtgoqhR+
	 07vXLlyHFXsVYTtMrihhsF5nfrh6EVp+30k0BTn68vib0aT6WiYVqKssNhHKphnHq3
	 6lwZY/0uNR+OvWQwHvHeSibf2I/kSUw+pFEh3wDxhn6IJEzHbvrwa6YyGt9olLCTu5
	 sKnY+Vw2TO3bA==
From: netdev-bot+sinfo@kernel.org
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@kernel.org,
 davem@davemloft.net, andrew+netdev@lunn.ch, florian.fainelli@broadcom.com,
 nb@tipi-net.de
Subject: Re: [PATCH net v2] net: bcmasp: fix lost TX wakeup race with lockless
 queue API
Date: Tue, 29 Sep 2026 20:39:15 +0000
Message-ID: <179071435534.31693.12141825512351760557@kernel.org>
In-Reply-To: <20260929203400.1588868-1-justin.chen@broadcom.com>
References: <20260929203400.1588868-1-justin.chen@broadcom.com>
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
