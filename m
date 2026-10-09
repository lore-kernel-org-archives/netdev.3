Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C004A2A76;
	Fri,  9 Oct 2026 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791540865; cv=none; b=bOZlJgE4gXY4eoM0Xm2gbysJNvagXgrFun0Iwgnso+bkUYWiyKY2/dNlAc0LEITTWqfebnWbD8iWKebuaCW68YtYv07s6AUJT6cVuFGXSKPuRDzfNwCo0f6U0f10jibJClZ+UjzxkPAB742WBJ3Vhll/E591Fupwe67afpdu6x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791540865; c=relaxed/simple;
	bh=Frc+ADQTxRwKDWaoqMQMlUJQ/gCXB8qyIs31/48aD70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AjKYInyiO1C1KKHuiTMr0ggDHk+uOaLHkujSPDiV3ZDzLIMaHSH4Nj9tCm0d4gEkDk7WeBMQBF8iL0bHOIfxK0kj6pfhXv0YzDggIvU8slTJ0jSbsmenExMQKY0DNXATFsQ1m/SY4Y8Znpr+WAk9JXMpR39Utxm8jzLtC/HnoFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOaL5y8n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOaL5y8n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968571F000FF;
	Fri,  9 Oct 2026 10:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791540864;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LOaL5y8niMi0HX0MfKOV5z0uMtEmQE8xP5udsirpoxARoQ27VLyyHnD7oWsf0lDkf
	 lk3F6rRAVb4Ar5PGr7rSa/aA2KHMOV+J8N4QPZTnEw7uZIxKfV98tY6Fhs/8mz5ukb
	 VPeHISzwUIHYrtlbjr7FA4fy7srTD8N0jTsaJsq5DZHe1qs1/4XaSintiP1CQ9Bsxl
	 LnExh3dfj23cXJFQtP7YWHALZsG/XywU6aP+vW4Nvzv6yAl9uKdU7TO5JWa25pr58u
	 RccFtZ99bTbpN0TC7j9Oag9kiXE8A6huGZPc5mSPHIjZXseiN78BCqjQzAXWTUj0QW
	 RRzL2i2gm2qDQ==
From: netdev-bot+sinfo@kernel.org
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bcmgenet: unshare the skb before writing the
 control block
Date: Fri, 09 Oct 2026 10:14:23 +0000
Message-ID: <179154086308.2527009.8212996211776873499@kernel.org>
In-Reply-To: <20261009-nb-genet-shared-skb-net-v1-1-c6d0a841977d@tipi-net.de>
References: <20261009-nb-genet-shared-skb-net-v1-1-c6d0a841977d@tipi-net.de>
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
