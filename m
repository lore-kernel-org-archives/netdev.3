Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45115429037;
	Mon,  5 Oct 2026 12:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791203004; cv=none; b=bfKnyf1sxWK9RuwpRsYcjdgKuEBtjNWxqrtQdZEmSjJo2TU2G7j4eFQfPyHTiaJa0VHomK9/2ej+vVAeu88KFfud2XwpSM4XQcRsR7F3y8jcV5jTNiVxPGK2ZtOUmFcPe97emDR7YJcNELHt6iTV2S2secjXz5eXguQ26QzKsyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791203004; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uMemEX3b4rsCfEYTGNJRU3cBNW97B4yKjKtCdS4KylqCk7f5M68iNRAXn4+x7Jan2tKgodqVT9hCi0kYnw0gTsdD1Q3ZgPKU4iZpcFyY5vwJ0mYFewlsZkCWjBh1iY6OkMISkqPXyLK7LQ6NUTgX/4or560OgDlFEthAR+fD+Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUSVs+ds; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUSVs+ds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD531F000FF;
	Mon,  5 Oct 2026 12:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791203002;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gUSVs+dsZ9JTxa8LBCJpurNYpKgBmlxXvRXHX4J/2nL1Ag8k/3oewb5ITm6lif7XW
	 iuyaSIm6bcfQWSGjgcRfQ2ogOIjE0i+AG1Age0fG5YdHvq5rd1vsN0bTNj6TuFKSXG
	 E6eRdEyU3LwC2bOzG9N7v19P+/l7NiYh2Dc9kuMK1jhKjUnBqXMns6XPJQvTpd9Ydw
	 7h7zHkkdl6GncrNOWtBqxThhv/zjyCQMNlqqkCOtvFuuvgj/Rwpd8u+SDyjlgI+iYH
	 2ubBR7bgd7KwsDoy5Q7m9G/KMjql0f4fmnWto/AjtU+f6HMyMjjKaqWF3+IuiGM0jb
	 UdU38jfD7urcg==
From: netdev-bot+sinfo@kernel.org
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com
Subject: 
 Re: [PATCH net 0/4] bnge: Fix error-path and IRQ setup bugs in probe/open
Date: Mon, 05 Oct 2026 12:23:21 +0000
Message-ID: <179120300167.1402591.3718496528368377342@kernel.org>
In-Reply-To: <20261005121704.227866-1-bhargava.marreddy@broadcom.com>
References: <20261005121704.227866-1-bhargava.marreddy@broadcom.com>
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
