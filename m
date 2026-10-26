Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793003785;
	b=ZtZoo5VLNp1m3zu1CxGKgTlcKWF9wm2GVHuNjlS4ker8+7x12xXKd8Ux6wiOk+mJP/YL
	 agsCWbk5at18kSvjaNRahfLCzQvCvnrvLr7vmHs+STheym+93GaqAjHIsHqQPOIFTThwl
	 RuEvBVZmYfBVxXRcxOqTCBX05nJR8VvI911UUCZ1LM9cfaV5z6qwAodC0ibbzwuD9JeHD
	 ivsUG63w043xBvr5rd7lRvvcjtb5KZWQ6uPgY8E3N5EQK7wbnHdiuo4feHUhLdpicefgG
	 cYn0AQAh0Ro4u6WRWBWOX1XJw5XgnPhNGVOPho+aR6jCEvi5p8dRoOa7oCP/MfUrBmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003785;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=TrGlv/64gGOYie1nAQVrnG8PnKMIotXtZdyQDKT8sABxkwDTGtsJcOxc0MSkyXgn2QPg
	 /bOgaoKj5djYat3YNWpPzlDXXznNZERQ7lomCM1eJdUdXo1IPu3fW5v2fXQWr3AFi1LxF
	 6gQmDI2pR5aTiKYY0X5QQ6/X7Ht2vnxRPmpR8tQhAWSv0c/OK8tZ1mjHnhqUnBDoJvHur
	 CSZyzcv13/7iOzcM1EcitmG+CxoylWoE47OUIPrLop2p3l5mFPX7HaipNPY73CarcnVTf
	 CMhgdEZTLnVCX8gQJ3FLpu3dM+qO6EL5up7wW9KnJKESXnhZON11dLliwPLHoOFdR0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HFLFOFqM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87036606A31B;
	Mon, 26 Oct 2026 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HFLFOFqM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E651F01825;
	Mon, 26 Oct 2026 08:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793003785;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HFLFOFqMHvBu+6IIUgIfMOaY+mhbNGwlfxE9C+iYBGccPJ0LXJtgS6Sp14/rxxYxo
	 S7g24zyfp2B4WKFkKy6FNnex+Z0XH9TnTFI8GWMLX18Wc0TPzJkvOS80FA7G+uKXK8
	 qqcsG9DgVMzdMFI3B+CCH4O9GqiAaNSauPQ9sbAIb36srQ0jkWeoWzq0X7GOhIaj/s
	 etc3ouSv11nwSl1gz+E8VymbBwdC+9hZMCGRgHg7GJgVC6/MPEO3NuBJAyWTWh8Ml6
	 55dLpTP20pjqwst6tISc1wkJZyo1THLfhah1bryo5sxEvk390+/ys1a8brC2KIjYFf
	 3ggsl3pOB3fRQ==
From: netdev-bot+sinfo@kernel.org
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: motorcomm: Fix function parameter types
Date: Mon, 26 Oct 2026 08:36:24 +0000
Message-ID: <179300378438.3327.666635400432470005@kernel.org>
In-Reply-To: <20261026083252.12684-1-mmyangfl@gmail.com>
References: <20261026083252.12684-1-mmyangfl@gmail.com>
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
