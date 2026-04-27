Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2F8264A97;
	Mon, 27 Apr 2026 23:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777332369; cv=none; b=Iq/iNaei9qDvuT8+e1ZGR51xnTkbRWb+XNY/8QWMJwt2WkNJYGyF7/gamWuj8uV3lpy0Yzky0eQP23+Q4//60JMqDpIasZKHIaYi78pGaCkiYMEY9cnHXPL0lCRiqfgrc3WM6gcBydADIFTr12DHK+nTViPT3bQBVE7Yncp4M6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777332369; c=relaxed/simple;
	bh=NCjVlyMEkbMZCsORLvwsyvrNExMeYxUE9LRyioSGo+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j6E4S6SAG9Z855VeCyzqS8qJoB58kXKjJmhGFiXNsaBTcEziLrF2RWbKRqi4gQQsekIcnBvgk0xCjfNaWcRBJROuaHBmjjiiJectjI+MHt10+VkSqhSqCX9JdnO7bGH59KUQskIJyrIQsDJyz5UE4baDWCTA7zrXkOgv61WSHsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGLrQA1z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGLrQA1z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44570C19425;
	Mon, 27 Apr 2026 23:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777332368;
	bh=NCjVlyMEkbMZCsORLvwsyvrNExMeYxUE9LRyioSGo+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nGLrQA1zuhEAknR9FBh4E81srj7ewPenQqRFkRuBfWZrRXrivEBMNUnkJ1Q84+64h
	 bQmdGGl9XAXG3AELJEuqIgJTOd2WiBkl9/dbjZYXEUlOxenDUhCWkNPo6th6VAw0LP
	 1L9mK51zk6dfq4Djvxs3Ce1eRDHSCEMcHwGWeKDhyO2r8daBYv5+cTNaVKPaLGUxBE
	 nuNords68Zvy4lO7lcEeC4QnTiNAL2yj71k9Z6Z04en6xIlIy1dWlr33XqeP4L/zo/
	 jZKAcoaPs62R0lTkKZbng7mm+dFVrMUxiA818k6f5wFeXJK/7MYRcog/GR1X7t6PeX
	 hHsa/go+PPJ/w==
Date: Mon, 27 Apr 2026 16:26:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 daniel@makrotopia.org, vladimir.oltean@nxp.com, michael@fossekall.de,
 ih@simonwunderlich.de, rmk+kernel@armlinux.org.uk, marek.vasut@mailbox.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: realtek: replace magic number with
 register bit macros
Message-ID: <20260427162607.6df44090@kernel.org>
In-Reply-To: <20260426222359.3443278-1-olek2@wp.pl>
References: <20260426222359.3443278-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 00:23:44 +0200 Aleksander Jan Bajkowski wrote:
> Replace magic number with register bit macros. The description of the
> RTL8211B interrupt register is obtained from the datasheet.

net-next wasn't open yet, when you posted.
Please resubmit in a couple of days.
-- 
pw-bot: defer
