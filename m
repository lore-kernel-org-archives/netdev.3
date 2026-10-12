Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF59F391838;
	Mon, 12 Oct 2026 03:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791774115; cv=none; b=Ciqdsn+iPR9qvaZ6B2RBaWlyZQOOy5Z3yJ/JjRsZX47flkKrAfg9Di6gXZsuMRc2IoxbjM9Twq5uf5tGhKQN/QKuUggZ+vc18qMsR/ft3yhaBXM8N01MktA760ee/TsateFF8yBgMC07/A8KE3hWHEqjwTGU2cEeMPrr/GHOWuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791774115; c=relaxed/simple;
	bh=4lovSobfyYeIj0BJYkI3mOUw4greSek31OIDz6d1PGw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QmURZAThjCckph621Ns28mTk8zb/gVoGaIWP/91tOr6cfRFg7Ttpne2rLxYJvJ2bvUEint5bOLaJOXTGIyfLFxBdDSG4T3AyCSIYgPD/20+MJuOzL5L4ZKTqkHVRCUaHaOYmag6tzy8qqXRMc1HSnajVWawM/yohwUd+9dNgYdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxMB4YEN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxMB4YEN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987F71F0089C;
	Mon, 12 Oct 2026 03:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791774114;
	bh=fqI52G4/N1h0CFnjgU+cnVh70cY42HCFyRQNFN7g/V4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bxMB4YENae6siclAo+FSSk+31dZ4l24KsCJ10PiryGVGKO6/NhT5EfkkLwRNn9OaP
	 Ma73h8l85Fo6VyEtDjldSBeG+CRXzZvCTll3KFFkEhPfTMsu+4RM4f0OBThCeo1CF8
	 60LnE5/T+VuPRzVpX7hYlRNcJP6PlBFlh5nKa82QZam/XPXFwMK4NA9Wy2LNXzaFAX
	 AhaprButnipqgkfP8q9DPNHSJ/Lvg9oOBeNCT3+oTpvgrX+CswzGXVKl0hv+idpJHD
	 PwsKKQXz2oDnA4rbDPHitA9IazX0n7CIQHnNmxH5/j3nvuXGUDPEZR5Dqw9jLBbGyv
	 q0QrZX4FVMiZw==
Subject: Re: [PATCH net-next v13 3/5] net: dsa: motorcomm: use fixed-width
 GENMASK_U*() helpers
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Mon, 12 Oct 2026 03:01:53 +0000
Message-ID: <179177411317.434549.9487392652475811243@kernel.org>
In-Reply-To: <20261011025043.1859940-4-kyle.switch@motor-comm.com>
References: <20261011025043.1859940-4-kyle.switch@motor-comm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message for "net: dsa: motorcomm: use fixed-width
  GENMASK_U*() helpers" does not match the diff.

--

net: dsa: motorcomm: use fixed-width GENMASK_U*() helpers

This commit changes several GENMASK() uses in the motorcomm DSA driver to
GENMASK_U16() or GENMASK_U32(). The changed uses are the internal_mask
entries in yt921x_infos[], the ctrl value in yt921x_chip_setup_dsa() and
the phy_mask in yt921x_mbus_int_init(). The commit message calls it a type
cleanup with no functional change.

> Some masks assigned to u16 and u32 fields are defined with
> GENMASK(),which is an unsigned long constant and wider than
> the field type on 64-bit builds. Convert the affected
> internal_mask entries in chip.c and the YT921X_MBUS_CTRL_*
> masks used by mdio_bus.c to fixed-width helpers.

[Severity: Low]
Does this description match the diff?

The patch doesn't touch drivers/net/dsa/motorcomm/mdio_bus.h. The
YT921X_MBUS_CTRL_* masks there still use plain GENMASK():

#define  YT921X_MBUS_CTRL_PORT_M		GENMASK(25, 21)
#define  YT921X_MBUS_CTRL_REG_M			GENMASK(20, 16)
#define  YT921X_MBUS_CTRL_TYPE_M		GENMASK(11, 8)  /* wild guess */
#define  YT921X_MBUS_CTRL_OP_M			GENMASK(3, 2)  /* wild guess */

The masks are still like this at the end of the series too.

The only change in mdio_bus.c is to the PHY probe mask in
yt921x_mbus_int_init(), which is not an MBUS_CTRL register mask:

-	mbus->phy_mask = (u32)~GENMASK(max_ports - 1, 0);
+	mbus->phy_mask = ~GENMASK_U32(max_ports - 1, 0);

For chip.c, the message only mentions the internal_mask entries. The patch
also changes the local ctrl value in yt921x_chip_setup_dsa(), which is
written to YT921X_FILTER_UNK_UCAST:

-	ctrl = GENMASK(10, 0);
+	ctrl = GENMASK_U32(10, 0);

Could the commit message be updated to describe the phy_mask and ctrl
changes, and to drop the YT921X_MBUS_CTRL_* claim?

Also, there's a missing space after the comma in "GENMASK(),which".

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011025043.1859940-1-kyle.switch%40motor-comm.com
