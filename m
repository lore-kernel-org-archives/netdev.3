Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792542197;
	b=zgkU+IWAGwkH23MaAHQUxbQLE8pqBeMKFTzsxYfpaa6lQk82K94TcvgmUbHB/RaPQH1v
	 +D9OP9DZkNYq4KDEIWUHCaov7XKwEpYSKzgB23lgshiBd+KWx6/BFFJDT9YQEk8cWbuvu
	 es0fRnBfchQT/GdIG+ysZOj1fiaxcDQP3gKvpy0/gW6DuaTWHeE8rqishpwsbhqKi60rE
	 g0sUwO67hOANbw8LJOc261+z2g7bakizs5k4mGQHIBmDxrqTVz2alQhmr97k6V4UAN1u3
	 /gwdSmQB3B9GVTZMcgixyY5rZvNfjcoh53+fev/TDbH5clbSSpTXwdO+URhkwrDFoNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792542197;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=xcCFNvGGQvapXD2Xc55CLgTOs0nU7SC8w2RxNeVBXy8itxo9Y+lUsMfaEB3LBy0m3DmO
	 WMdjY5EBJ1o3sw9Jg5Heo56OQn5RxklS9ytYQxoc0gHv+tRjBwVSDCXi2AL+1fVkRd6zX
	 d2Trb0fC5BVNLEvEvlQj3mNjjsz775u/d1OEmMEzCc4iMIBpnZ5fr8zPd4CiRe+bzkhg0
	 es0ldMqOcm7MsmqMdEujCZudletbQv0uV76k3bpNu4W3VnhSfHWsJV99p0U8byXUVQ2Ep
	 X1ukFRkNDJC03ySQrwCxcUVye6riyASzGcwSPr8GNoGv33NYY/1v4jP7QDVK+zl3axw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IBZQbCen;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BC3606A319;
	Wed, 21 Oct 2026 00:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IBZQbCen
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA0B1F000C9;
	Wed, 21 Oct 2026 00:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792542196;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IBZQbCenZxcObQLsue6vyanTlVg1bnVO6JftuC/G2UFoPiIkONWQYe3Uub/dIOJ7/
	 s2exdJLKYkPIIsyxbSy1xatay20PJ8IJGn9koUV5EezwuuzrIKbi/HDM/NfzAM/aqS
	 y4qd9bZS4h74QhYQKiJSI55VtI7ndWpO0QcolwqxCZLlw3A6SHjXR7E8wdb21cb4Hw
	 Auq819TdazJzfzxhdbN0kcJ7N+WxuMJqm3/rJRSUaw7O7ccY7GDcQBDDfUjzpVKdgV
	 +Gfgwc6i1/LBryFa68QaOsNxc2zbp9frEB1B6+iPiWQCSYoMgK6xsDo/6c/7BSEQfr
	 G2yD5pa/W4XBg==
From: netdev-bot+sinfo@kernel.org
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org,
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Felix Fietkau <nbd@openwrt.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: bgmac: fix TX DMA unmapping and slot cleanup
Date: Wed, 21 Oct 2026 00:23:15 +0000
Message-ID: <179254219525.3290.1761340258214254709@kernel.org>
In-Reply-To: <20261021001744.2042320-1-rosenp@gmail.com>
References: <20261021001744.2042320-1-rosenp@gmail.com>
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
