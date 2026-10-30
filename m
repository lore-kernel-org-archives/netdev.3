Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356322;
	b=BHRBbwe+bJhgv1IVsJTq2WHQlZx8ASCPZaZL8bYKvtnFl8dD0Pv4YhpmXfWfcW165NpV
	 vG3ENMY0LK15HYE3qjAewixrOQaWjA9YE7WrlR+/NjUUM6h9+uGE2yjexR7GbDznk1fAW
	 vbThZvQFnzwCO0hevGxOWtKK7Dr0JMnu7LOSgSytHHRvXsg9RppoAT3jnw1bXq75tcSPM
	 xevogIKRF5dfqnrsZKmBxqpTMDXos19axc0y5AYEitFP9YSlVoMuErmkDqCZEBuXZg8Zz
	 1C7F5OEIi0OZm2V98kROGgg7KWwGGLGjLt+KTbXhCxXgkjV8b65veweF2o0gJFdIWQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356322;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=2iiS+eMb7XAlieAPmXHMABznip3XUipzmcOi5i9z2Ko=;
	b=qMNvyHumh6zJ7u3VLaPVhRdhkS3sKNekP1x0j5xwMdkvMPLqnhuxcG5kbcVC7zfygeue
	 C7kJnPntBdzKlRRepRsOt7+lwr0UPFfqv8dOR8ExqEpTkxdGHji/+66hNXYeVEY6FTltB
	 9xuC0jCX7aYSXydGyxwa7AlpbXmejpj6l87ht9DDceK5tL/wDuSke32vImwqAvBZv8ux+
	 nddJu5buq89i+ABtMn7wA1jKdmeVwikO6w9FLBGBdtLLGagLn2Fo/zYydoc+Wtnp98TRG
	 881ZNmqHPdIRUbWJoS1YmwIjaz8lPQYE8cUJpKP42+2VgNgzgJoGV7wMOFZZhrS6Fww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Anc6two2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EFF606A31C;
	Fri, 30 Oct 2026 10:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Anc6two2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB05C1F0093A;
	Fri, 30 Oct 2026 10:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793356321;
	bh=2iiS+eMb7XAlieAPmXHMABznip3XUipzmcOi5i9z2Ko=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Anc6two2Ae0LK2XAZ4qzVthOsNyBzSR/Ht2s7VHbhIweM1kGf5uZulAxnxzSmelrM
	 RqpUB2lT/BvvWVfXhsVu8+Uwxyr1ENrmd7vJZQLotGAcnZqDTmknSBlWyFec+if0yO
	 UDVL1cIUeWM3K8r3FDw0THh42wPAnm/0AaLSmx+SVIFdxgVRP0jAns1T9huNGagA4/
	 JPxBp2prbGEk6IeBd6aiachtSRakPk54eHDvbdpYZJ+5LEYwuYfdQzPoPtM4fIDLYD
	 7ZyqbPSPMztHForTley5bgqcRJCPDF+hK9TAlU+uoowcPy0C65/StPv9i4XB4ylLlk
	 IqTUXxTnz14eQ==
Subject: Re: [PATCH net v3 1/4] net: phy: as21xxx: handle stale link status
 during autoneg
From: netdev-bot+sashiko@kernel.org
To: ansuelsmth@gmail.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 30 Oct 2026 10:32:00 +0000
Message-ID: <179335632023.3134.1234553586034910370@kernel.org>
In-Reply-To: <20261028073024.25175-2-ansuelsmth@gmail.com>
References: <20261028073024.25175-2-ansuelsmth@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message for "net: phy: as21xxx: handle stale link
  status during autoneg" says "MDIO_STAT1_ANEGCOMPLETE may be cleared…

--

net: phy: as21xxx: handle stale link status during autoneg

The patch makes as21xxx_read_link() record whether autonegotiation has
completed. If autoneg is enabled but not yet complete, it forces
phydev->link down, so a stale link up bit cannot be reported with an
unknown speed.

> When autonegotiation is restarted, MDIO_STAT1_ANEGCOMPLETE may be
> cleared before MDIO_STAT1_LSTATUS. In this case, the link status bit
> may still indicate link up even though autonegotiation has not
> completed.

[Severity: Low]
This isn't a bug, but MDIO_STAT1_ANEGCOMPLETE doesn't seem to exist
anywhere in the tree.

The code in as21xxx_read_link() tests a different macro:

    phydev->autoneg_complete = !!(status & MDIO_AN_STAT1_COMPLETE);

That macro is defined in include/uapi/linux/mdio.h:

    #define MDIO_AN_STAT1_COMPLETE		BMSR_ANEGCOMPLETE

Could the commit message say MDIO_AN_STAT1_COMPLETE instead, so it matches
the code and the name can be found with grep?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028073024.25175-1-ansuelsmth%40gmail.com
