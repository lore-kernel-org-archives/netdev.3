Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142833859E2
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792105715; cv=none; b=vC2/CtHhGPbLuqgvlX8ZLDHR7bIpEYDEZM7sBGGQ2dQIbXFPrIPuwCAMQVM1mlHgWdtAkTjoOpd7rUfcj5qZnJySdcc7RdB73eybGUY9FQ4zff9Ov9kXSizmgQM3mij0MK7YZtoOCJ1YzsbKAphtTTOYKG+igMhBh20fha5GOkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792105715; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L9VetlTErJ9E9Tvc8iKp0JQLs9CMJ8rewezpX5ePOPTO200dm5WZgI1njq3oSsDOUyUE/XBrDDeaur/XWK/sLNOVrXqEHlUrKUPDNjL6GsJ8UEsKtL6JsctQaMqaK8iEZ1DEkEb2YEM4q8Kbz7YPLr9TnBUKP5GIUZ7QUGGbpOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oy/97Amq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oy/97Amq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB1C1F000C4;
	Thu, 15 Oct 2026 23:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792105713;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oy/97AmqSjsv6+UzT4jKLbpIpUxWKd7hk5/67m2wxZ4VEksy1G1Y0T0SD+1BkCEnh
	 KHZAghTlw0dRB7etxNiIfDUJ+F0YQCzNe/rryXcJZITuYIHrEeo2lZZdD9Ky5RwcjG
	 UPiiJWVEBgoB43GL4i2SbWwL2fHGC6uaQC2hWJ7wj1pj5vbfT/xJFyFBXs7sS7eAxP
	 /JD4u1zy/EQenBmzDZQ/JSyvKjRODeubJzoDU2/EWdN+/dXJgzGtErlpvwipEFlfAH
	 ahpicUpm1pl3ZSwwkMQmoo0Sa6uCp8Bi2+BWuy3mhTFnJeHgjKCGWUa/xCG+K99wWJ
	 +F9MeIzc4U+dA==
From: netdev-bot+sinfo@kernel.org
To: Eric Joyner <eric.joyner@amd.com>
Cc: netdev@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Eric Dumazet <edumazet@kernel.org>
Subject: Re: [PATCH net v2 0/2] ionic: fix port_info lifetime bugs
Date: Thu, 15 Oct 2026 23:08:32 +0000
Message-ID: <179210571254.408196.9199301625371086933@kernel.org>
In-Reply-To: <20261015-ionic-port-info-lifetime-v2-0-57232013fd79@amd.com>
References: <20261015-ionic-port-info-lifetime-v2-0-57232013fd79@amd.com>
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
