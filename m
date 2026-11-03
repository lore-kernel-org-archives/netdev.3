Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746721;
	b=Wez/xTIplHGDBy0ezjzGn7uxr7WtjbPUBZYvXUEKir4svC/hk/yZ7FH+R+Cg2gqtZB3g
	 5yy8+A1krnjQCTvJdgpTECuNLXHc1lMM3hjnuyN+ROCDqHTBWmJcOvHVPf/ggFCfxrRuK
	 1d4u+Cw9ggZUfmee/ZxXzCtf3ZfG4EKsShJiiWR7LhB7AEaoXgB0au15B7YI53LVH4eUA
	 hvG0TFEIC3k2jzYI3spaCLVKm2DSaFWKZg2EVCkw0dUNDpL5SXnUTzOLScHyGdpFJAtWK
	 zA0yuVdH103OtdD2LvOIVu6larCMCRvI6pr9FxKhqkBXPGEwKQnZY0cR2QPL4+SO4Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746721;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=DcnDbXropaNiB07+vlQXRRMuFdJav73ETU23+YTC1uN0I5xSoI3AAISja4poc5qEM9PX
	 CXJQ/kxf1W1qUWL/eoMP0fn3XXnt5gwW7eRj2SCKT6RpSJmeGt1tjiJJSzhnKCBUdNj05
	 eIaN33BOcMXUpOjEEzZoe/ubPpw6w510PcmhubmobX9dPtSpCM4NCq+o8Z3GnGh8DRyrl
	 ufyhJ13cZw8nxsRvFT1XO1CbLyNERbZObra964N/qmAtq9QYYwCGVfZJRgp8Mv8iZU9r4
	 vT+YuzAYHza8buBninwujxcxAa1Ha7X50GAae5xuUnF+3/2XVOGSqliir+NaVedpOJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iApUR34l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27141606A31B;
	Tue,  3 Nov 2026 22:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iApUR34l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85261F000C1;
	Tue,  3 Nov 2026 22:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793746720;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iApUR34lnb+0hXkOeT3w31t9V7u5jLaNEX8UvWtGBJwgBcdDf8IbA24um8YtQr+ko
	 XeaVyGVjHDlqDNwFlFiGRGgycjXJzrc2CEmUtHhN83QAIc/CPS3VbLwpZTSJ70xhE0
	 c2Oh1ThKNbMxZRAIsMfEvAa0kM5w6Fqbe59SjBLznsJp1Vk3qcA3nMwl57g+TaUJW0
	 9GwmWba+u9OtiH4uKjumZHTGcXsv1/ila454D5i0ZROqfGghErQy8DJ24J0pZVIN7L
	 EU/1EwlxtzFC97MCe08jx0XF6OlI4cHnd/arCiB48mgqt54bRa8Z4mkF7WIuLRJviZ
	 guMKlnP8DaAVA==
From: netdev-bot+sinfo@kernel.org
To: Tristan Madani <tristmd@gmail.com>
Cc: Jon Maloy <jmaloy@redhat.com>,
 Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Richard Alpe <richard.alpe@ericsson.com>,
 Ying Xue <ying.xue@windriver.com>, Erik Hugne <erik.hugne@ericsson.com>,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH net] tipc: fix division by zero in perc()
Date: Tue, 03 Nov 2026 22:58:39 +0000
Message-ID: <179374671942.488859.7670547676757961796@kernel.org>
In-Reply-To: <20261103225433.2663943-1-tristmd@gmail.com>
References: <20261103225433.2663943-1-tristmd@gmail.com>
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
