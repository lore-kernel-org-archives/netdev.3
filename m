Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337C951814F;
	Thu, 15 Oct 2026 12:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067158; cv=none; b=g8zao1ZKozhigFGr3IK5CfUgnOw2QII209pzc5ZaM481KPlOLVm/7K1qI14YtQOcELnGKFtrc6Pim+WA2fEM6nnPBa4e3KvuwsqvJYaVDZT4WXlfcn/BRBilV1l0N7jiEWGBuTEOxQKwkWbO9dWKdhX8kdc1nKXmIBuYvk9CmzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067158; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LXVJcZ+sYzC3iMJCWQ6/Yoi7CsAIG47aoXFoOKX0cXn9OXOzeW9krbs7LYAiDIGT7pqdi0INe7olgMjwXp2f8kLA96UiiYy6vh/dTYoX1AlezqimT9ysWxRO4j6/JTqh6MgChNMmR3qukjvOwPQlFWfq4fkrxBA1tEevKz98EnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHrPJU9p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHrPJU9p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E441F000C4;
	Thu, 15 Oct 2026 12:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792067156;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CHrPJU9pmHVEr1L1ltxqVEd/yKPxYXAHD8UGY39GlH56K+bI88omAo5lOD8mgfaJG
	 xbywwZ5oosFOhd30DZtGYS8RRNsmJ4yKY2/om6bh72CMZhoO7IYmZCRJ1F1sxBRYaX
	 UYZRRbgTe4gaYTAflamV2F4NH2klK0vwZZAKi3iF4sTZnFuDUCLvUD0UUadEhwxqHW
	 kHJmpE3hI0i9aJAjxzMQqghLoQuvMHwe9YnB+ZjhYwTAJPxje988svUJ4bRFhv48nr
	 rCL7Ra0/SIYsUmjW3jhVJmGiWqmht4PyvbQ6rS6FHlYwjMHwVpP2+jmS6RL6XBV7Rb
	 KJi+u8GuKUgWw==
From: netdev-bot+sinfo@kernel.org
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
Subject: Re: [PATCH net v2 0/2] bnge fixes
Date: Thu, 15 Oct 2026 12:25:55 +0000
Message-ID: <179206715563.408196.17628524065724738513@kernel.org>
In-Reply-To: <20261015121847.1933308-1-vikas.gupta@broadcom.com>
References: <20261015121847.1933308-1-vikas.gupta@broadcom.com>
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
