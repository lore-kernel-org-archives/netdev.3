Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B502857EA;
	Thu, 15 Oct 2026 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070279; cv=none; b=Dm3H9g3W7frgBtGeK2fikDRaGGPFR5d7UbWrRgTK0JtnStNIeQIrziIrQMIzumDCT/eEXE2OnuK+3WPFCvmAHvCyKFGTNf3I8Y43F6WthiiTMx/hkf2ZeGrAVLBLR+SbxbxOajbpk3xmJuZTN0hqkbLu9nnorWD9YePTfdWJH5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070279; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sckhFlYMXXMm49CYjOMa+5Oel4P5cMfnrWN1+0bUnGZaugJ89P/w/cbNNYeieuvwCLhnrhaZvEUDP1xRNAR4l7EjZxeOklqCd6Ag8fL6cI565FVnjJ+gomDZz8vym7/pmlML/Hf/6mjB55ETnSujguOEmYCtmZhq2ESXtJ5a+wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXei5rwJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXei5rwJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D081F000C4;
	Thu, 15 Oct 2026 13:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792070277;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZXei5rwJ3mNTP+4d/0R4yxwp1i8pAhKVAiMGBaaXOIyVn1x4MfABDpApndJeOX7rL
	 aCV7xkcFPpadXAPoo6sSxGpIFPNcB/LHeO1JpPUTWfl2E8WakaJzDZGRehvr3pF/Fj
	 d+Jbhm9L1ECFI5KGXH3hfj+9XkjHVyhmO3niWweU6AGVUeCQwgj0G8tSjJmXudogHp
	 TxIrg9oFSoeaVQNOOAC+9zfLJUdkp5MzCrNetigb/q9nhTzOOKQIN7nIdpVHMVFAt9
	 vcYiyE39ADNU3n8dda2Me2d/pursMVp2hPPLWow8o16YAPncBmbrwhNEd/QwkvyF8L
	 G9/EKknzaPWWg==
From: netdev-bot+sinfo@kernel.org
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 David Daney <ddaney@caviumnetworks.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: octeon: Fix dma_unmap_single() size
Date: Thu, 15 Oct 2026 13:17:56 +0000
Message-ID: <179207027693.408196.17036993852197974189@kernel.org>
In-Reply-To: <20261015131336.34801-1-fourier.thomas@gmail.com>
References: <20261015131336.34801-1-fourier.thomas@gmail.com>
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
