Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C0D416842
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 23:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790809728; cv=none; b=WSe3roUA1makeT3IXmkcGBO/lOqe60xNUKgr3hQeqlIj0KprQD8OTb4BfGV26G93nLf2W0f/uwc85n9htVXWsmuDWqvkcYWEDCAU+dlYzfqxmE8E50AxaRB7EJkfaCvwXsjECb8HdnTGaOqB7DpdlsWpMk6MOAfTP8MYx4rF0j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790809728; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ib3Ys1UtMH/6YZZ1M0BgMBnpggYzcnFMIM4rsTR287M/9tX0XIpjwXOeOvA7EAGAeijoydB287bI0F5zYd+sb9My8SwaqnXw184UJHnltdFvWLmQ8Do+w9JXi3VwhkNYpmtL/rkWzQIq/qazbvxoqKAAVcoSDVSxHZNja843BPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cc99gnuW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cc99gnuW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183781F000FF;
	Wed, 30 Sep 2026 23:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790809724;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cc99gnuWtjf1CvHLldKIvkyx3+uQ0Vs1M4Al0rEkTPsdyOzeBfVBL/GIoARF/P+9F
	 mQU0rO09zKMRObcAy3NuIe3vyCyA14XBZhC1qEsp1VM57Cf/NHWgpzlnuQKJzbrscM
	 Bb5hOrTdcxlkOiSCak71ndrl3JlNyFGzXPbO3xTeSFk+MBCRE2A4XtQWqThlMec4iP
	 rep0fgEpthDvAogIXYqFItvh2aPhPlLbTISUvXsfC8LTAIdL/Sj7lMZrRmq4VlEtz9
	 As+oc/L/tX3r4zfK89fhU9M1zu3MmWC3hK1Lr4K4qW+kgYLiDMNZRGHDmCpOgHu9/a
	 fmzpefBY2NHZA==
From: netdev-bot+sinfo@kernel.org
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com, nb@tipi-net.de,
 florian.fainelli@broadcom.com, opendmb@gmail.com
Subject: Re: [PATCH net v2] net: bcmgenet: if UMAC was suspended in SW_RESET,
 restore it to SW_RESET
Date: Wed, 30 Sep 2026 23:08:43 +0000
Message-ID: <179080972360.31693.266631430009737406@kernel.org>
In-Reply-To: <20260930230634.3132729-1-justin.chen@broadcom.com>
References: <20260930230634.3132729-1-justin.chen@broadcom.com>
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
