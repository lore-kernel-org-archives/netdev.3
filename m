Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16B3547059
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 20:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790627155; cv=none; b=jmot6HPZP5CZW1kQszU6NHhQcbk54stOJ0Ryc2AJffG4nszAVnrisajIjIubLo+IXlI9e0jj3YZXtRzlxFPHzLLKLJ5biO91mpRAByV2Fjjk/baa3P/qlETMIon3nlOy9XRVfk6juhEH6XbSDxsRd81ieHuCXoecip4aPrVxs+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790627155; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hDhabbjLbjh4DbPjX13wvFiUXkmjl6a2e36xcn9zHYB5s9pHDnhVnlxV3c3aJLSd7NzX4n4IxS419+mFcdRV0HLKTdf7cxW4kvL41ErDdM0334cAKgHq3DmlC4TSMovhi17qTYzp2dAJtPLrBoDhxK16HQDlZV8bZJR7mybcRPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7ZJnG+3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7ZJnG+3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44031F000FF;
	Mon, 28 Sep 2026 20:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790627154;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V7ZJnG+3tUyT6BFZp/au4SwEfcNP7yxjCkekcDTL06JYiUh8vKnYZVgUa/iNtWjay
	 OgOSLDMxAy9SXYTkAkMBOZmGaKzg33JFqETDWE4Q+jQIaKj1k+xUmm+FWrBkMjrwP1
	 ypgrEhqsSA7KflM11XVOHZcLB+Ow8OttnxQzBdmJC33MHH+w9B7mDL5tq4frISRnvw
	 RdqiOLoWEHpPMVcY6su/4JHLdjq1t/hy4wjjQVWY4SV3cvHq7PYcQDklVMzyID46dT
	 2Nob1RZVoea1mQ9CyRXt2txfS++aiPKpkfi+rxRElyfuWJ6Jk3qen5Z94tBOv1vAhx
	 Rq1gj/CE9nqlQ==
From: netdev-bot+sinfo@kernel.org
To: justin.chen@broadcom.com
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, florian.fainelli@broadcom.com
Subject: 
 Re: [PATCH net] net: bcmasp: fix lost TX wakeup race with lockless queue API
Date: Mon, 28 Sep 2026 20:25:53 +0000
Message-ID: <179062715326.31693.15450257108998791332@kernel.org>
In-Reply-To: <20260928201816.3935530-1-justin.chen@broadcom.com>
References: <20260928201816.3935530-1-justin.chen@broadcom.com>
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
