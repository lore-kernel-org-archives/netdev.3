Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270C53F329A;
	Wed,  7 Oct 2026 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791397488; cv=none; b=lWPc5IUyAClgcYIyFRlxnmMSQpi+jiBbDr4vbVhyLHCpuHwN/tCPbVtAX/BhcuZFbOljDj3BzQECGRvuL8qaFQS7zEyTwIQISVUYT4qGLvpgo6uG1BHWGypvXpZOCHbnamWQW19t3pIz3C9Bnn5CI4oidtp49A/PHMWMRI+vs5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791397488; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EV6GnhUdmqhtLT7FvOWeBHrnaUS7BCIC9PEMBP1UitVf0Vj9MRtRZmJHcQHh6cT0/4spMhN7JJ3XkCM/98wE03fRsyNkdIMtLrflh5hxZbJLx42uZqpP0rkHZBniUZ994U55lJ4RlkYvdTmidwX1MrYHf+yC76EnlbQLPVQC/4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXfjNm+i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXfjNm+i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2281A1F000FF;
	Wed,  7 Oct 2026 18:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791397486;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fXfjNm+iUKESkR4wrdiVAosUCEHCcIZSMhXZFAc4Mq/gauKW1EK886AElR2+Jxu88
	 yKYRmsIsnnwfVTMn1iKuFqzA/oOvzDMPd7u4WObl9nthiCLHmztDUTBZVvNUQ4ngaU
	 VHR4cwq3loCpecfVTATB2Ugiwvs5jqvyHvO+fbdHR4SXe7Hmv5Lfj8m27PkvpW3Kkw
	 gm/PdMTzNiTNpQS3WMJ/TV3zttQFnxqasQu/S0xu24y6wBtU1R6Nb1c8UFoGpsM1z5
	 N6FIhvuycBWgFRGAC8SQNk+ejvUIr01uyC82RvJb9XwUkmipqGzuWfDmQpRsZfL/Xb
	 nSHI2ra+blpEg==
From: netdev-bot+sinfo@kernel.org
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Michael Stapelberg <michael@stapelberg.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] net: phy: marvell: keep WOL_EIE across interrupt
 reconfiguration
Date: Wed, 07 Oct 2026 18:24:45 +0000
Message-ID: <179139748566.2527009.10663595607133766847@kernel.org>
In-Reply-To: <20261007182112.821061-1-rosenp@gmail.com>
References: <20261007182112.821061-1-rosenp@gmail.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
