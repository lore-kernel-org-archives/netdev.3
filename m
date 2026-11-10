Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354732;
	b=OqSojIF7ImfOkndwemkw4F9HVdRI2aIOgZtqW89QtgiWRzqmvi56VYn2/C4MvPk0RQms
	 /yjyo93qNI7biES+rrovCyvF2w3u7fy9+HtSo5clOQ7WsR3n5wFZbydOfC9LgbMCTZJbh
	 YhxpkkHRIqyct5XPBx/WxF3IMoJAN4WSY7keB2RMJZzbhCy5AZ+SI6cfwm8fFFVSZ9rEp
	 ZKqY8oWy4fUOSHzYrYBpfSTCrlZ3k/WHD57bbFUIoN5T0Kiukfcwb8SKv6ZjN2oF+1Jtl
	 ccN6WWwKeX3jgYkVP+YpCu6OUIz3+RVy6ftmkKhuVeVG5oww133/861FVOZ59mDJ1qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354732;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=iSWGc1+jTASEcnUfet0o2SGVDT7thSeomcVfc2dZPz0=;
	b=xPS/7sCYVsNmsczQm2wHg52V8SjqEHJRM+zxuB5BkpRDnd3mfbRA7ezpO8fBzPAju1/p
	 QRvzdC+Y2vpcNlQymACrhEDadTuL/rv8jDPCJiGSK8XjjE47CnugIxE2qSnkvGQuDxK+k
	 suwVySa8KFz5tCWJ8wtyQxQG4y+fUuKn6ijQR4dFdgUsWFtwaei4Sr1YgHuLY1ifNCqVd
	 yxQ9Tyb3jLAL5e9Axwaa8Gtf5FPjuCIbRMHNyZSEbuV0BIfn497QN6Br3jwLgDn4ZYlqs
	 WfeTCaZ7iyXc/LoIXj44ji6R0P/X+pgVLOuwyqX+lbcngtKkB0hTQZMDzFq724KPFUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bd9pa+ml;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8B5606A321;
	Tue, 10 Nov 2026 23:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bd9pa+ml
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABF11F00A09;
	Tue, 10 Nov 2026 23:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794354732;
	bh=iSWGc1+jTASEcnUfet0o2SGVDT7thSeomcVfc2dZPz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bd9pa+mlT1Fdo9Los3Jo3oO8UpeharkFPIk41yC833SaahdPLCK/ccMlBrYs49my7
	 KNTCi5zgsc+twhCxBzcwPNwOFdJzRu5eUHS+9F6l0Sz/Bkqu94T42gbxD2sVrR5/6x
	 VYvZB4BTVbOj0bBQFaDCw3fdLbIciWhDLx4IRGZ6eFqy0urok6/E9M3kp7PqwkwEvM
	 m6dW5Oy4DTGkqDw86dcZIsadSpPdDFByuE2oZq4mK1ZDnC/u4doI7R+fgd7/ToX1NL
	 ksVyMkA2VjERjHST67xEhdmpEVMXPe9lKE1rvJvU5VHjNXeufS9IfWKCNwEQ11O45K
	 1SNnoFzDTP/qQ==
From: netdev-bot+sinfo@kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Daniel Machon <daniel.machon@microchip.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/4] net: sb1250-mac: ethtool link updates
Date: Tue, 10 Nov 2026 23:52:11 +0000
Message-ID: <179435473107.2168702.11847862148663488665@kernel.org>
In-Reply-To: <20261110230300.2769327-1-f.fainelli@gmail.com>
References: <20261110230300.2769327-1-f.fainelli@gmail.com>
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
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

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
