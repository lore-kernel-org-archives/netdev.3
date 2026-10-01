Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2123A0E8E;
	Thu,  1 Oct 2026 22:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894589; cv=none; b=RAarc1iQ6OLEfoc6uiGqS+14bOsmliKOhHVnJNuhJt7BH+EswExYHNyTBza9DbkYCAqJuWdP760ySR+W5BgVgwn8FE2Gh9QZUXdFEZIqILQK4yqN+mOczvvrI2AUCLH42BRkdxwS+fBuXmk+bKOE78XNUIaI1MsxYsadCaGUnmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894589; c=relaxed/simple;
	bh=zvpmhm+BAUlfIVJ/6Kp9ShG7pA3G2q65FWBMzuTisWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BbRzWoy3dR10uS9ZHVhyHqk/LZuQbBOrIfzN/JSExccz8dNvGm2a1/IKknvfobFkNjTKrN7c379kXpSNVDMENZ/xLY3AxlYHTW9/uH3RTLoe7XFLOaSCY9/LWFUq1ON+wsaEDfsgt773N8W38/BGYMTEMI0eTEGiOwQFoRw8yFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QT07rmvd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QT07rmvd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCBE1F00893;
	Thu,  1 Oct 2026 22:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790894588;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QT07rmvdbjRWLlunq3lKfUyS9jG5Qn1e//R6A6Li9yejbaZvmSAY89XBrhe/N10lI
	 gztej521xv3FU4JK4EYuaFcDOYL0M2VoHoOGi5YHesgeoT7Xuc2o/bpWhJQJhwOnYO
	 6MF3zozdUcgXRw6OdD5dkh4Q8/NmEm2ukYEd2H78tdIEEGFf+01pPgfsC7jJnEW2zy
	 QctDvJXd3f5Fq2pCmswiIYBNr1sIxkXXOHgWTm2gyzWD/jp5SbMMrwy8KjnbnqCVIb
	 Q/0OBwfOuUZRkw1iRIbh31XWzn76kpRNBzOnWOtdpB09IHvRO8sVkHsrtLq22mDBOo
	 GtWOZa4+X4gLg==
From: netdev-bot+sinfo@kernel.org
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Clark Wang <xiaoning.wang@nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: 
 Re: [net-next,PATCH] enetc: Set eMDIO MDC rate to 2.5 MHz only on i.MX95
Date: Thu, 01 Oct 2026 22:43:06 +0000
Message-ID: <179089458690.1402591.7465828322706427522@kernel.org>
In-Reply-To: <20261001223947.60189-1-marex@nabladev.com>
References: <20261001223947.60189-1-marex@nabladev.com>
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
