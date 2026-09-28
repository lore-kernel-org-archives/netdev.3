Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C2A32B113;
	Mon, 28 Sep 2026 03:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790567110; cv=none; b=hvTjLdeiEHabmmJcV/L2jv1eGJnjNz562/0FFPqZ7SgkZiYQ+vhiEjydA7euuCU3H0b1aEOmplelzcMmTbRUL847D/+gkjeda2weLgmKzR7fCyj10z568bGKnRkgRzDip7N6u5wH19MzoFQVC5pazFjIMAATpNYffiWAJ2YV3rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790567110; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZcgVMK3eGacHTVKGz4fRFCQru3rXpjruIel4mNM2o/NORPHDA4B58fe1Fs4w/O8xkjIoXofCDibbtNYk/eMmHdvkDdW3NAEvItgtQtImU7+c5qpLHYJ8lH0010rRNSZQZUa5/vvHEdQlbU1HAa1oOpx5+H+zMCj78HWbElwF3ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJkA5TPU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJkA5TPU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6916D1F000FF;
	Mon, 28 Sep 2026 03:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790567108;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dJkA5TPUwRXMExdE5uMCAa2nGcIfwrrOOe8urJ6PNMs4xhVK+ufEXieHpzQFBzjFz
	 uGAjsrsSOVq7wfSGDL6ye5sakl/ktJ7GPPb+tO5XoA7PBGeVkS0J0YfprYY4dInF/U
	 plMM8jVR6Pv8hmm9Q4hK+nIMk1y2GixoAAwSvDsjcn+VeYuTYuYQaPmnC4WpkxSjQG
	 OKwE0/yyQo9KoGz5i+8WnK3aRgCubeZuqCODFfC2gif1I7nE3Tf1jZRMkZ8/QhPuZs
	 PzfwBFCUvGD7I9JvNUWhaS0U94+6z6MA17OBNA7c7IyGgsR68nI77YiIodjujkejrn
	 w0r3Icj7dG6Ew==
From: netdev-bot+sinfo@kernel.org
To: nshettyj@marvell.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Geetha sowjanya <gakula@marvell.com>, Sunil Goutham <sgoutham@marvell.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 Simon Horman <horms@kernel.org>
Subject: 
 Re: [PATCH net v5] octeontx2-af: Fix rep link state sync and workqueue races
Date: Mon, 28 Sep 2026 03:45:06 +0000
Message-ID: <179056710693.31693.828814800942741489@kernel.org>
In-Reply-To: <20260928034213.3173088-1-nshettyj@marvell.com>
References: <20260928034213.3173088-1-nshettyj@marvell.com>
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
