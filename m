Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793266241;
	b=Ff8aRmFccMhyHWVZlNWmiXO6Qb5kcU/BjFqnG70gAr00xh3IAPysBy/b0TBbd+8h7pGH
	 aZpJyFGabqPMt0q5a7YzUuPpUYmH4JOWKou9T3lfg2QJ+P1HrTK5WgkuAVws2agWjZskQ
	 KmcXlvsbpQsf9yMllLmj0xLzGIbY2a15ADvPbJ279fkBWOJh0hlWy6sBs8V8C72Vy+Ooi
	 4z+kARYJy16AbXmm4qpVqaXkbndARJAcC2gWefkZU4jvygrbgshXWMKALICqLoNczG6rr
	 Hvkd5AUX6hn0vQ+Mop9azE+eVdR2TrlOWpzZFZ8ZOsof6C4XpO3njQsT9LyfLDIZ81A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266241;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=vB9Rz2jyc9Z+bxkmPHTaZIsXYURfYfaDTCbiMfj16PQpNrrQw5VayncC5x7Q+z8J+997
	 6e9iRlW+6cjjt1bRN6XgJjYB9wBY5Rl40nf/ogX7PFqWLzC8+jBYsV5vfO9Th+UBKiRIi
	 a5pzJGDzngnUyX+NL+4TpftmMJKjzvNVVkvAOKH1gzDrbTwuUnIgssubB760sSUZ2NWV8
	 thJSYyks3NbeL6yU6Sn5/CDCwnfIXqvfrQOSLzF24o6jw/4J+1XIXzAlC/VVmVJd6J0Ea
	 FHmhV+1bbs3Cfkjq8y3uFhDQZdKgkecjiMHjRv7CicSWxaa8NlG64sOFbVpbL8/yLmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZCaiuV5J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888B1606A31C;
	Thu, 29 Oct 2026 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZCaiuV5J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA34E1F01825;
	Thu, 29 Oct 2026 09:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793266241;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZCaiuV5JSEsdIQcfy6fCgy51/0Pv65BOiQosFCtcGpdbZKaelap9FdpyNvOFwvLBT
	 nZYjcQArHoSYDfZx9Uu86KYzWF0B+odrGkMT+5FQf9Z5wRYRBEY0ZtnEFSA4Yw8pls
	 vIRhCd478rfi28wnrAYMFf/J3kWqbC+vzipSxQe0LHI+IsT10xaFLR53+4GKi+48+b
	 kCRzwcgNJiWwEuSMNHJDqTVETquolqbiHffZLbpv+fLiweK0Rg9gaYBAebkTJIQb/7
	 CfQSVsEC/GbgKksDQgabaPIpASWPZIxRgVYYy+1crhZq4X8ViRRf9ShpHTP9NGUAdM
	 VFb8oQCD2/MPA==
From: netdev-bot+sinfo@kernel.org
To: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
Subject: Re: [PATCH net-next] net: phy: aquantia: Poll global status register
 for provision ID
Date: Thu, 29 Oct 2026 09:30:40 +0000
Message-ID: <179326624025.3327.5471427454050749790@kernel.org>
In-Reply-To: =?utf-8?q?=3C20261029-aquantia-poll-global-status-register-v1-1?=
 =?utf-8?q?-808089824a3d=40oss=2Equalcomm=2Ecom=3E?=
References: =?utf-8?q?=3C20261029-aquantia-poll-global-status-register-v1-1-?=
 =?utf-8?q?808089824a3d=40oss=2Equalcomm=2Ecom=3E?=
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
