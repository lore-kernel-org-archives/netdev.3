Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2B63955C1;
	Thu,  8 Oct 2026 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478023; cv=none; b=frXUBfbrpRaiD/CnC6IYluYa4foF+h0V1VBPSL4XbILKMWLCat+fsEAduxcsGlqRYsBJAmTeJcQwlcLimAbuKIcmTsfUQsbavFQlI0dxKMcPnViPQF8UaM9TH/kWq6IHglEH0CjSswwCTd2RxDxI3FmFe/U/N7UiJVsUH4Hqeus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478023; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CPNkZ1BTit9hgvHZ69URq2VWIzCHcsqmelOMkQzpXHj6sBLALGyb0CveVYND60r1wGtO8AeVp2D+C8fEBWemJfpTCm0G3OMpITET3nS/PLyCFmC9iiXQNxrDoI7yjUvqpY3ttwfEawtopQwwCKrjT1V6bOrorELfvpn42QZpfR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HP65iv9J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HP65iv9J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679881F000FF;
	Thu,  8 Oct 2026 16:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791478022;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HP65iv9J+OJBjRzHDe+x3Q0fxoJqwG55CWjZ7g1cMsMf/MH3seGV4M2OkIJNbkBrK
	 h0HADaT0ajp3QmdalQrnAdRdaHT+uCqqC5Wn1LEnjgkIBJHp2szA4zDo04sIpS9rnT
	 u9VOnZyR5bzwVELda8eqpU4f0/WVDO+QUXbngNLyK5eF91h3XxIZUJOQnVVHLYsGao
	 zUILcQ8Dc0LUQsZskSPZ9DhSDBCz3WWkc6UFQYbnqnyiOexbrJIJLmwFyauQe7VIZu
	 kqCPrjrbL4785e37yZZ5W1OFWmD0+OrcWxA6Gx0aBQQkEkpEsEQqBOBhbRfxRIcfS8
	 09yMvigG7A34w==
From: netdev-bot+sinfo@kernel.org
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH] net: phy: bcm7xxx: preserve __phy_write() error in write_mmd()
Date: Thu, 08 Oct 2026 16:47:00 +0000
Message-ID: <179147802087.2527009.5778359159706354094@kernel.org>
In-Reply-To: <20261008164240.2694229-1-vulab@iscas.ac.cn>
References: <20261008164240.2694229-1-vulab@iscas.ac.cn>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
