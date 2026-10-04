Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD773F54D1;
	Sun,  4 Oct 2026 22:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791153797; cv=none; b=NcFfIlHUQA2pLExb8REWcZJG/JKUfyi/QcWBWKk2mMnQOrNUp4HI+EcsDHB+Yln2buNc7rl3DheneEeDfiHccpS9YC9iMseGeQivYbjm/uoFYgx4LP37Y3QheqS+ufAPDOcEJizMhi5lieSrTu7mTwmN5HTONy8d/Q+gj2RFmpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791153797; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bm1bY2f4Z1Kv3TF5UfsEDYO2/GHEmZs/Q/DTfGjvQphTLi0vGvJhz2zl8elVdTA3Sh7g7NzTdjiKU1piEhAPy9R4GRny5gD42d0TNPU2nY5iiYpAyW0b+sRGujicYqIA2ldZqgt22wO+jeiRQxUgbjnZkbrcfetbZx5fxFUvEMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgMkTesU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgMkTesU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAD51F000FF;
	Sun,  4 Oct 2026 22:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791153796;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JgMkTesUDn43h9/C6PLmCExHN1V7Pld3L+trfaKecnsVxqpnoBbN5M3RJySbFn0aF
	 UcDHr2AZURnQ355dfC6xFwVv0cFZXSaFZ66BiRZqNEEd0eyTIbqBubPKsgwxL0fSG9
	 Yp47OQUW+yAY8WeNykYMcp4AHq87kZxMIb5tryW+UFxfQHQRrAN8sco8Z5BzFNhTKh
	 tiTKZVKnDczOFeqUgGA6aU1i2Qk7RhvCY8Q4/93RQITBYCKl9SA8bbwC7UzwVTFsUv
	 2JlJW3vDpgfDEcoH/+FB6DkefgcGicLVeo2lR/rfGaNRr1goCzG6JvQ8aQRLBL2MdH
	 YW5pLG6U4jrMA==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?=C3=96mer?= Mete Kaya <omermetekaya0@gmail.com>
Cc: netdev@vger.kernel.org, oneukum@suse.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com
Subject: 
 Re: [PATCH net] usbnet: fix EVENT_RX_PAUSED race in usbnet_skb_return()
Date: Sun, 04 Oct 2026 22:43:15 +0000
Message-ID: <179115379510.1402591.18007585712452116262@kernel.org>
In-Reply-To: <20261004223852.312487-1-omermetekaya0@gmail.com>
References: <20261004223852.312487-1-omermetekaya0@gmail.com>
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
