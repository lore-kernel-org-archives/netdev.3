Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8825438655D;
	Thu,  1 Oct 2026 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873131; cv=none; b=fIa+LEH+9QHkGswfiRNo1LBVm9eoLvoXUjrkfVuT1aMYlMXy9zxlagFB/N0i7PzdeviCLAPI3KTSdJw9nkNbEO712tsGv7WXlsfmI9gyDzAE1DHBniluySHCfc0rUpjHx9ce6x3gwiaSaYiWCrVTXibsS2pFdJ19nvEs8jo0c4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873131; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ddLG62zmiJwKjRnnLZcbLiKxJCsZJn2ksZ7NXELY9qE6z6jQnikn9gRAUJDqPBmIuGHttqaRsGKrhlUh8O0rsv0FGob7rj/8gUq3ZnG+xqPlYTjuwfRJz5FBWdCrzWwrNj3JOUn0VmOjemAbu/XqjrPuq9AXO8ARAy21uGKc9Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zk7neMj8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zk7neMj8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA881F000FF;
	Thu,  1 Oct 2026 16:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790873129;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zk7neMj8PgVCs6SNfY1nofCAiC8ammsGgiRbkAOQT6ZOndWrFNeE/sEgmqY2Yq8Ag
	 HUHESZs2nS6m3JMiRbRtIHxA9ip1udShxeiUfir2lwGLRh2CG0HTwjuif7CnKW4AuQ
	 QVndPoQR0JugWpmNmsDTlHiJPwWFUKTPzO93Jr33veFrrVUky+35wV+0M7hPYFVVLF
	 jI0PLCG170jodORpXxbay7CJcs7lbM8E29EqZ8oFkTsbRHO0DyyOpmJLQFLF8a1Efe
	 zU6S23j91RFCq2ArneOyuWDLDpNYzb4QWtMq1CAMatn3GFWzFNjkZ95HYMPhUwIaol
	 hT7cTG2ztv6nQ==
From: netdev-bot+sinfo@kernel.org
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Alexander Duyck <alexanderduyck@fb.com>, Jakub Kicinski <kuba@kernel.org>,
 kernel-team@meta.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] mpnic: add NAPI buffer depletion check
Date: Thu, 01 Oct 2026 16:45:28 +0000
Message-ID: <179087312824.1402591.13891424496391739284@kernel.org>
In-Reply-To: <20261001-linux-mpnic-v1-0-6422ee74233a@gmail.com>
References: <20261001-linux-mpnic-v1-0-6422ee74233a@gmail.com>
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
