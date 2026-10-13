Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD14B4499BA
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 02:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791857363; cv=none; b=pkUnNWirZ6fwiIDKyTiA7Ive9S8dfsNXHaOKNjRN+cRJfsQnOr+tXYVIgCs6//bcb2YL5D5xkM0mMYpQW7VGzhtYZmw3QPj5sFbhq/ZswRzUaBST5shmK2RsF+fqi31ojbAsverWc6j9BCDZ1r6nEoA98U5JAg0bBIK+nYIZ+hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791857363; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pXQ/KP7J7jqAiDQZYgd/XLkPOoy8s9B/Z8vdx0S8jxXwXqYeOlEyYmMZEaEcO0jO7/BC3xo6c4Q2FRZVWqE4epCEouvgXEg5NMwfswPLnWYitWETh4W+HgiVZuMid0aOz1PNpMk4lUhyT7RR3xWakv3OEsiNdtFY40Dm6uYGGtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orPgdij2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orPgdij2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE431F00893;
	Tue, 13 Oct 2026 02:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791857362;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=orPgdij2PCx3pEDI/lvN7ksG2rQ5gtXVK4mKZvhrkb2F51pNlXJihldyFOLmWx7mR
	 QMGclcs5CnF0eCLSnKNJtUhQS78uYt8EcJDq//17NVzhHwFbSr5+tJIZHG/V5WH412
	 Ij1cGlPyKM/EImbAZX/WxF0P3pwo4QZZ1osm034WrkDCsd/Bvyt0yKgo792V2JfFp6
	 vX7hTSQz+byNhbbHG8tEVhY1+4dPnwMUpw1eJgZ6jVhvouQiw7nXK4fBVXHxzvwGSd
	 RDp1kwsGtRtA7tEZ/oGqMmN8tIxh4SS1D6cWUefYIJvDNWouRHXhbyoyy6t++6gyK0
	 fRtYtU9nRPv0w==
From: netdev-bot+sinfo@kernel.org
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Jacob Keller <jacob.e.keller@intel.com>, Kees Cook <kees@kernel.org>,
 Chenguang Zhao <zhaochenguang@kylinos.cn>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Uwe =?utf-8?q?Kleine-K?=
 =?utf-8?q?=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v3 1/3] net: libwx: keep NGBE OCP cards MAC enabled
Date: Tue, 13 Oct 2026 02:09:21 +0000
Message-ID: <179185736117.2527009.17237483632731841289@kernel.org>
In-Reply-To: <20261013020626.5548-2-jiawenwu@trustnetic.com>
References: <20261013020626.5548-1-jiawenwu@trustnetic.com>
 <20261013020626.5548-2-jiawenwu@trustnetic.com>
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
