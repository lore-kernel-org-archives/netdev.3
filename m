Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F150048F03F
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816282; cv=none; b=LwB0QrDx61SAgJLgKci3m+Iav9iUOsSTFGa5IJnLTCIGjFHrIlS1fU6BqmT89PBgFfvoIeq08WCa82YCI0YV428tgl5KRk6jpHNpamyn3i6JCeOourmrcSDr1AoPxpEXZlHJ12x6RVYMfadxcmUVm8ih78y1K2X6LDYMlp2P8tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816282; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a83seJdba9m1o44C/JfAWZIz9/bPt79XFzCQU8zO7CwoCLaKXAASOAtNJ/EPFL/3ujqpjbNWwGvXtYXaFov0VgPihxFsPPc5S15yPe/yuhjPnuz1MoWV+UwMc1BTeEvk85L0fjvtB1VpEdncRHVWV/iwKaKx2y7ZsuJGg2YZyZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmRpUgyx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmRpUgyx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6B41F0089B;
	Mon, 12 Oct 2026 14:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791816280;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JmRpUgyxe4iGsmozHUp1FIlTjO4hyIqWJ+nrYRv48ZMvlq8fZzJUZ+2vS0Ucc8AbA
	 ST97NYjdJMja/nSPYDvCKL/ucUyz8oQwp6ocEWrtAXQrahtWpjwcSKTKWZcg6t+lwE
	 fBhZqd9y6l1dl5xJrc5AI5zfoBHfRwSUE4jkTZPpmTH/NlcllUPfeq95rjq+DCiqAX
	 VF576NxmypPNVg89xnnl2Cy9xczWsOyDffVz5w2XN7mg8q089efK5tOMYD3eqswRsp
	 O9TYYCR+otDbLiahjVVzkUxctGP2DqL1FNR+HGnrscX/FrD6cgZkrl6lyYbJFVJ3Ro
	 Yr4QaLYfQy89A==
From: netdev-bot+sinfo@kernel.org
To: Adrian Martinez Garcia <adrimg3196@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH v2] xfrm: account XFRMA_IF_ID and XFRMA_OFFLOAD_DEV in
 acquire/polexpire/expire size calculations
Date: Mon, 12 Oct 2026 14:44:40 +0000
Message-ID: <179181628012.2527009.1279721489172027773@kernel.org>
In-Reply-To: 
 <CACO1+RQUrGS3VN-hrdKk+BK2uuRP7J_Fyadahz1QpO00JXyw3A@mail.gmail.com>
References: 
 <CACO1+RQUrGS3VN-hrdKk+BK2uuRP7J_Fyadahz1QpO00JXyw3A@mail.gmail.com>
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
