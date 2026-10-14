Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE17F31B101;
	Wed, 14 Oct 2026 01:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791943167; cv=none; b=NPHYeSIYCcXm7YLuxZ16lc2CIqYH+mJy1d6QxUL9nTqWTqGGHbX6pYdRo4mcKlbg3rpx0phLElg2KDxolXxZtTPUWwIB9YgZb7uUEjoNlNcdr3F0hfVHeSV6lX4yW+WoBN5bo6gCRCe3Z9qLOOX8feCUUeQd4yoVv1JAc/KvTWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791943167; c=relaxed/simple;
	bh=6Akb4ckvTv3S5wLXkTu1jHuygBysZRu52dighwDoCHI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dY0VSW12SN5nQp/kHMfcPlgmUAdO6Ee+5aNKoSaMzBTm0wVqObRF38GizPbcr4Va6yID48hujIrOqtLr4sUMTPAiHO8OGAZ4wSLbxxAzfexyue3+PbTsx/haRtjsQniyB0UJM5+ldTAOITj+pthmSYGgBBvrmWSDdT0FWu/NWfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4444znX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4444znX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621121F00893;
	Wed, 14 Oct 2026 01:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791943166;
	bh=7EFCfGDQUSJpiJj2q+4pVjPtHt/sNg8pbWdul7v4eSE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D4444znX2rVG8LJuT4lNw8O3VjDHQ3g5E4eJdhdZFNNkzcqfk0XmP3YmqSs7+aKdV
	 w6WPgWOqe08BSclc+/fSMZuUCn4V1KO5ow5JEcsYAeqz2Vyh+KsaxLdOy1d7HW+OVm
	 lK7vKnF5rGAtGNbBrwXP0TLECX+5jhqJ7iEtfh5nkRoLyt64rMnvdvbRuJSbNvg5lW
	 xGMOuxnlByYcHRvnBLsHkGRitA2ldL8W9iEioyN/cllyAQP2YyUC7ZfnIpycIrikWG
	 rXQ9SJt/O+0LuTizxB/MXM+Gw3iSKSvwsNtDtAwE5H9O2rqPOCgl9Jgh/XC3T2JK/K
	 njMMUkRIYCRzQ==
Subject: Re: [PATCH net-next v14 3/5] net: dsa: motorcomm: use fixed-width
 GENMASK_U*() helpers
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Wed, 14 Oct 2026 01:59:24 +0000
Message-ID: <179194316494.434549.623576784260344748@kernel.org>
In-Reply-To: <20261013011122.1889766-4-kyle.switch@motor-comm.com>
References: <20261013011122.1889766-4-kyle.switch@motor-comm.com>
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
  GENMASK_U*() helpers" does not describe the diff correctly.

--

net: dsa: motorcomm: use fixed-width GENMASK_U*() helpers

This patch replaces several GENMASK() uses in the motorcomm DSA driver
with GENMASK_U16() and GENMASK_U32(). It touches the internal_mask
entries in yt921x_infos[], the ctrl value in yt921x_chip_setup_dsa()
and the phy_mask computation in yt921x_mbus_int_init(). It is described
as a type cleanup with no functional change.

> Some masks assigned to u16 and u32 fields are defined with
> GENMASK(),which is an unsigned long constant and wider than
> the field type on 64-bit builds. Convert the affected
> internal_mask entries in chip.c and the YT921X_MBUS_CTRL_*
> masks used by mdio_bus.c to fixed-width helpers.

[Severity: Low]
Does this description match the diff?

The YT921X_MBUS_CTRL_* masks are defined in
drivers/net/dsa/motorcomm/mdio_bus.h. This patch does not touch that
file, and the masks still use plain GENMASK() after the patch:

#define  YT921X_MBUS_CTRL_PORT_M		GENMASK(25, 21)
#define  YT921X_MBUS_CTRL_REG_M			GENMASK(20, 16)
#define  YT921X_MBUS_CTRL_TYPE_M		GENMASK(11, 8)  /* wild guess */
#define  YT921X_MBUS_CTRL_OP_M			GENMASK(3, 2)  /* wild guess */

The only change in mdio_bus.c is the mii_bus phy_mask in
yt921x_mbus_int_init(). That mask is computed from a runtime value and
is not one of the YT921X_MBUS_CTRL_* masks:

-	mbus->phy_mask = (u32)~GENMASK(max_ports - 1, 0);
+	mbus->phy_mask = ~GENMASK_U32(max_ports - 1, 0);

In chip.c, the changes also go beyond the internal_mask entries.
yt921x_chip_setup_dsa() converts the local register value written to
YT921X_FILTER_UNK_UCAST and YT921X_FILTER_UNK_MCAST:

-	ctrl = GENMASK(10, 0);
+	ctrl = GENMASK_U32(10, 0);

Could the message be reworded to describe the phy_mask and ctrl
changes? Alternatively, should the mdio_bus.h conversion be added as
the message describes?

The description and the diff disagree, so was the Reviewed-by tag
perhaps given on an earlier revision with different content?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013011122.1889766-1-kyle.switch%40motor-comm.com
