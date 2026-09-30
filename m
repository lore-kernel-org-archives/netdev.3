Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A90B373BE8;
	Wed, 30 Sep 2026 07:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752801; cv=none; b=IYDL1ypeEbt+2s3TQU6OHCOeLlm7BdVjR9k7ZeER/3+vjRhj3XECKcO27mkkGhNeODF7DPmB9PBis8DW7howDGkI+jhXFF3JiBmmcC6TIQHJeqtDzDg3dkt2zpcmqXO1L4+AX3XNDYQltHpMVmxuRwpoGpZsAFtZZi85b/+pfhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752801; c=relaxed/simple;
	bh=Frc+ADQTxRwKDWaoqMQMlUJQ/gCXB8qyIs31/48aD70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I9huYP5ignUUMKOCy8Jx6wjnOyXRP2MSWkuY+cNLa6Wvyg6YFIibSbc9fodyvXBI8u1za+qhNb8q7c94qRvlGcXDHNgzLCVvz5mokN3/V1oWyhzDTpeG779hdCG1vhONFAOb5Hw/exqnGGiu4eVogRQKITU4SqoKsqM9JKYpK5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1ZeUbIf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1ZeUbIf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B391F000FF;
	Wed, 30 Sep 2026 07:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790752800;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H1ZeUbIfZC5ycSUZAJzlMkNZj42855Q7MEIBZPwVCAPRX6gP3U9b+ELjNqab1/nlV
	 nkcAdh26pSvyMw+ytLfbvScigRWMMG94yGy7x2DAHWfRHDsYesriMumsQ+yfda1ewe
	 R+rc2h6i7o6PMOjI5MJhc2igLfJhR4O4yi081V7T05/Rp55rt/4gi3XBCCydvL5ncK
	 vscTkSJJm7w3ckqhaLqCxSO1ggTD0Dq+KxMIa90Zm3JNzMdCrUq1996MJwLR+ToBgr
	 kbGzoPFfw2M1wQdq58qixN19ypytkgDg0lsk5NN6tJ7/+2CGwl9ipELmjvwcOBA60g
	 R6JW3BfhHjM3g==
From: netdev-bot+sinfo@kernel.org
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, radhey.shyam.pandey@amd.com,
 michal.simek@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, robert.hancock@calian.com,
 sean.anderson@linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] net: axienet: cap the TX poll return value at the
 NAPI budget
Date: Wed, 30 Sep 2026 07:19:59 +0000
Message-ID: <179075279901.31693.4789169176025211757@kernel.org>
In-Reply-To: <20260930071536.627964-1-maimon.sagi@gmail.com>
References: <20260930071536.627964-1-maimon.sagi@gmail.com>
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
