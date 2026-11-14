Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616337;
	b=IDGMX7L/FjK/rMzzyF/i3+9rpkK1VQAoozFMPlM2hlZfnzocO8tYBRsWrgx2r6+mcPOJ
	 +GOhRnGxNMrccSHqCTKuF6UCy4xm7cIGfCs71/YVOaIdplROgj3cqeHMbT9lAdIQY2Lpf
	 TCHRePz8VBR4tL1TW1l1soCAgKLK1IyRivyVNc30IBLGvzGvwgH+Uwm3dazJBKUc8Jhlw
	 fjwuzGz1ptdBNTs+UKeuKAuzPn6EM8yAKHZ8SWD2OEn8Y+/TujhskQAtO3grYGahU+4UN
	 C3fL6bmoT+Kjmz1qbiB71JroXrr+VFl42avtMnm2qjWEB2bWCybIF6b1QFtE9+/Cwhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616337;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ld9+YyGfs/W/wYUchYl+G0tuTdeNOsMW/DqiAiz5bT8=;
	b=x45jIPeDVqn329eF24EGdhM8Xthky7EzDPUsUiLnxWo4v3PXXuYExpljQtJKi8zqiwor
	 8Rz+R3PzTwKNRRFzu+ruPjCVSKyWc598kZ1PoXKUTmFd/dIX1nB+dyRYrOMUNVGawfFYb
	 JLLRvwSQdE2R3nKxmrhjehZ97B0eRUQKbr9nt0S9LBIb/wb96lkeBdqYWHZ5IFOh22Jfz
	 hXkfkoxuLAhFrzc+XSCHXLj1eYYIJPbjDjUmulnHr5dLqAStXIJXMfp3i/eMq6gmoeMzH
	 xVeonOJHAc+DFnSevbjYT+RnAxlg1X8IoBiI3crC4qUbbpPlH5y+kDyVBtV7xvixGLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iA+2NgHs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB04606A330;
	Sat, 14 Nov 2026 00:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iA+2NgHs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E821F000C5;
	Sat, 14 Nov 2026 00:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794616337;
	bh=Ld9+YyGfs/W/wYUchYl+G0tuTdeNOsMW/DqiAiz5bT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iA+2NgHsIM1XGhJsN3YhlgEAOkvSXDvn106dhXYWMkWhG8xdOu0HbJtl8lp+VQ/tL
	 REacGdAPJXouCZUPgBiedOQ0xrnJUpEgyB36W6nzdYrLmAl74w16UYajZEnVGgqjJU
	 xFITQ7vzF1w0LTGObI15Gyhwo/ejTYroExNxe6HdFjrXpHeuKpZjPuv4k2O/pOpesn
	 VeeXCJ/SLasPfq+jaaGfxHk99SWjjYRdeP8foFGF4n1z+wc/jAsKcDnvnXg/rRgEcr
	 HhJ7UEJVB2qqXE8GS+Dl5GYH8kRn0zCeqG+rsumm4rAIg2DNPCB4FEetoPn1OZ54dF
	 U4yl6uqjYFa3g==
From: netdev-bot+sinfo@kernel.org
To: Sandeep Haemoon <sandeeph@loljews.com>
Cc: netdev@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, Daniel Golle <daniel@makrotopia.org>,
 Mason Chang <mason-cw.chang@mediatek.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 1/3] net: ethernet: mtk_eth_soc: fix the RX
Date: Sat, 14 Nov 2026 00:32:16 +0000
Message-ID: <179461633631.2168702.17586474086593763386@kernel.org>
In-Reply-To: <patch-4b4c5003bcf028fafd094e719c5e910b@loljews.com>
References: <patch-9e765e74d06edbba3fd85a0cd49c4bb5@loljews.com>
 <patch-4b4c5003bcf028fafd094e719c5e910b@loljews.com>
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
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
