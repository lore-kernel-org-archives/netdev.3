Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE4334EF1F;
	Mon,  5 Oct 2026 22:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791240919; cv=none; b=RnG+0h5Zb6kMVdynZKat3RO1tojTi72zua1ZBWMFu9RvO6bXTMHpsTkJg5rXk//Dma2hpd6UnnUF6KuII190yem5Ke609nbs0LhIp69MLBVhJLJg0PbrIxHlTXPlcugF4nLf8CwGJQ36Ek1wd38zy8VDuDyz3lE0dDgRDk07NEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791240919; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kxvwn9pCe3vjGiKUM9jay/BEstA3T7cbLlg58/OGPwBvITB4xgEDGMmIpnGGueQ10Qwm3ZM8+aDxtnQlZ7+V+baLxXIJ48etJ2LMYxbG8IVQLeeTUVRoytWnNWuKt6rodlBlSy/4oSFL0+3k2dM7I8RGN2Yg5YANpOmcwPPuAuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUYJHIhI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUYJHIhI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17BF1F000FF;
	Mon,  5 Oct 2026 22:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791240918;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eUYJHIhIwSokPrXr20EBCn6v44fDtOBYUiDwNJhP+Tcx1zHnZtR/Aftiv/KxxZexL
	 uYdl6WrEtnOGXsZVvD3403K2l6srWyxkmtCHP66eR+aXTfYFbNjqZCT0oLBJNeOBPR
	 AMgeHgCKwYxnraURK8ABOQ0iLqN9fTFamcwRzjKfbIadUFGDg9dRmF1Cvr4V9BWIOK
	 gFS3Do/7FIcVvue98JHS+TSGFaA9P3doLMAHcjN5v20c2eAlWFC8QG2NweByUP75X3
	 AB35LONdbw0NB2VYD4dtQ4W/znktqwLZVsvhowGdS61V0J4QrwVsyXMKg3w3Jv+ksa
	 KtzBAcyAZjGpg==
From: netdev-bot+sinfo@kernel.org
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Michael Stapelberg <michael@stapelberg.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: phy: marvell: keep WOL_EIE across interrupt
 reconfiguration
Date: Mon, 05 Oct 2026 22:55:17 +0000
Message-ID: <179124091720.2231598.15531231594364757004@kernel.org>
In-Reply-To: <20261005225028.465866-1-rosenp@gmail.com>
References: <20261005225028.465866-1-rosenp@gmail.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
