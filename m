Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792676846;
	b=pXbKZlseoKvovxWh0Z77HW/Cf3qQpCieDvw9ULHMMHiWdohugm1l1ZboJUQ0YZ4Eu0+X
	 u7ozwQBLiXzyJIdknZZt575Rp7cyM4vNzMpFtFRr2Dq8XscnzyddS2eGaqQSSP0XtHYq0
	 7iQyS8L054as17U/4M3zbdzSi3oIaJcOzWX1uBCXaowYTU2NqE03oqSp6or5N3sC12oSi
	 7TWVIBRsT5Pf3jF5kwzaOLJaegYHnx3KL0N5WlqpWmZlVO191AFv8VGjoMPMr992L7HbH
	 MrIfGm/QvQTzFTtmxJ9czoQ6D3b/gH/CxZTulg2iLpkKNRuhymFzDHvRIo3Pu7DRSCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676846;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=rgESUsPDg3fudYleYRqyCoOEAk9k/s7Erwd4b04TZtRnu/eJF7XiG6Kz5RFdD9hlMtwI
	 qIqUn3gTWd/CgDpOPkOzCwxgr7SOiOA1lOO4eVU8dlVafZZ64KTfoM2Fo7sem/eysjr+9
	 jgXfeaD+p/9NZOOqI+oMqVQ+rSmP8MqUh5gXA5dvfreozHu/kyMQTnBjJSNRuR0hrVbPx
	 06nIF1Ri2YSbYfzLH6p+AJD/j5nLMMWDt09+7xirQLq6KtAx+RIuG/Nl1ohJEAHWoPwGz
	 zD4jZDOfvQ7L/XOL/OGGJiWu44tj5pioRKL8INUZWqUwDcluGZkO5mKH671cT70IGMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tnh0LInH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182A160A5BE3;
	Thu, 22 Oct 2026 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tnh0LInH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D60F1F000C1;
	Thu, 22 Oct 2026 13:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792676845;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tnh0LInHe20ySeHYR2bVmc/pFz52pNYBUOjaMbzA5dy263Tauc8rs5zNPNuzEif4L
	 QkM0NMKGRe71vMxlmINYkSBmYRwFUAjSB9RGRQJkpZrkuabjpJ8jNYmJ0fJPOzz503
	 Tkf42txzZwptNIqDqb/vT46pCGu27ak3ZWEtsE6TcG67taKU9OxhPSz+IpunPaWIW/
	 4vn38fGRBHqAsqyQ2naSCFy7FYnP2lgcCaoL6AnSiqNq4WaYTVDVvpNl4bMVYuPSTA
	 DgFosxCd5O+SFzaAbwhru4nugAJRnsRCOVDNc6nVCbwc70DQ2KkWCTEvwEOFVrKQfw
	 WA4KHPQH+XVOQ==
From: netdev-bot+sinfo@kernel.org
To: Sicong Huang <congei42@163.com>
Cc: netdev@vger.kernel.org, Edward Cree <ecree.xilinx@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>,
 linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] sfc: fix use-after-free of filter_work in
 efx_realloc_channels()
Date: Thu, 22 Oct 2026 13:47:24 +0000
Message-ID: <179267684454.3290.5356948153261754667@kernel.org>
In-Reply-To: <20261022133927.3860186-1-congei42@163.com>
References: <20261022133927.3860186-1-congei42@163.com>
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
