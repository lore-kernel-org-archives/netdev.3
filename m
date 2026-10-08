Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B1F3BAD92;
	Thu,  8 Oct 2026 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791482396; cv=none; b=XFSwNPIUgnMAPG5H1lXViaXy/3mwMyhJO/xP7B7atVlTgiOXOzCF0X1TC5JcguPHxNrjukrfu3PKurQwBMKdPXDTKi7O5pkC6Ue1hb0SJFnz8iK8vg+n1vNwAofLdMb51DdOoCXS1F10aODRrpNXz+b8Vmgok2sOEcV3lhmzGSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791482396; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UwXdS66VY3hceP9PiK91mBcMEL7+CHCUMpciEqu5lf4e5Flh66/RWY5etoOfJRgEsWZTJKb7ipD5Omx5pZ63NMex2f9elg/22JYWQCTrlHLzcOA2r+GOoreCJ+qLusN6dVYMRsX5pBpv2pH4L8jLtI+fkNkMK8kEcK8WRxlMrF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOn1V+KD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOn1V+KD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9CC1F000FF;
	Thu,  8 Oct 2026 17:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791482395;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LOn1V+KDSgzFq3N3mIjckNkH2b538v4W/4jRV37u3DLN5UREek/hKMRTCu3XnWQiQ
	 aXF2iY4+Sh64wfi3T6dLhu79QXt4U5wZujVTasDIdaeCOpyF9WxaEGnlxeQDVtkBEY
	 ljlGcbhQc55XMgzfNhIHPeq03CtsQbQavwtrq6STjSLbrhXeawBv67NHKjVh/3ZRY4
	 eCTiAG3WEtd11PqVoKqxEK2qVXbPA/tAJvoQ87hZStzi8uxGs9sNx8gSrkvhJebDmR
	 Nww40wmcGz0NqfNUhpCJeWDEB3JQA5m/rLtKsRYDu9B1qsY625MBO6O1meE6hI0t7I
	 Ejfd7I17w5S/Q==
From: netdev-bot+sinfo@kernel.org
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Daney <david.daney@cavium.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH] net: mdio: mdio-mux: fix device_node reference leak on success
Date: Thu, 08 Oct 2026 17:59:54 +0000
Message-ID: <179148239445.2527009.5790575209483188852@kernel.org>
In-Reply-To: <20261008175612.2748920-1-vulab@iscas.ac.cn>
References: <20261008175612.2748920-1-vulab@iscas.ac.cn>
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
