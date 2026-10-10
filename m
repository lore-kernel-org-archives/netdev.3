Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D01037269C;
	Sat, 10 Oct 2026 19:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791661220; cv=none; b=gccYP4ewdM72tslMhhWDC645z0jHR6vMZW4QQJvFtys279vMMOqtpHS7ezglZ5F0yJ8a8YdwKGyozPAWpjzAC0yhy6MTiQsXC9PPFii3zltacNsw1ckxViXqtP+Tl7Bw+xYXXrIsq4gnjarc1kxGMtN95XxVwNxL0CxH5nBlZO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791661220; c=relaxed/simple;
	bh=O+Bu2puz/WXmvltTHOg86j1NW45KGnY8AMtphOlhmbg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iPZgl0DxW9aOam51/SDOfBdMJPjkkID+JTUeEmNrQesQjgS59kZlylVMsXAYsy9JcDJA35BqyghYpxvEzRAahePP/6oso2xXHbbT0HhsllaZqBGr444ZHhn8STyrgfgwyMlEXDYhEUxYyM0WNdNAuarWyQbh22UzH+rlEnP1Oss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHaQGXSu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHaQGXSu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE0D1F00898;
	Sat, 10 Oct 2026 19:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791661215;
	bh=O7jPgtWlaLzpLbIefWvv1Ic2MxSd+b3STMx1pkYwTcs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bHaQGXSuNa8ix8e37gIYES6Z+L4AaINIbyeLe7JOc5gS7r8irL5BRV5XsRgNHBwBw
	 eVeSLkDcDqtB1mD++XoK/ApLtfaHVPObcOELR8SSpvNvvsXJALqK9lTMfql/ALlh8S
	 I9TbPfTUtMJus0UB9jreV9omm8vnSEbMRp89MalBodgLkRPLZk6bkUFlTjPIDWojdv
	 tkefxoIChIP0DmwRbCaYlMqN6tEPBQNc8oNfd38DnGq10WHIEcHHX4CY1SgV3NHeQc
	 U/0BN7XBcXPbijavkkyAnuaQdLHHFQ8P2NWJ+Fd67a1tMeHLez8LdAfVUq7vpJrFhB
	 F7BjaSZM1NumA==
Subject: Re: [PATCH net-next v9 04/11] net: ethernet: oa_tc6: Move constant
 definitions to header file
From: netdev-bot+sashiko@kernel.org
To: Selvamani.Rajagopal@onsemi.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 parthiban.veerasooran@microchip.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, richardcochran@gmail.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 edumazet@kernel.org, piergiorgio.beruto@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, jerry.ray@microchip.com, ciprian.regus@analog.com
Date: Sat, 10 Oct 2026 19:40:13 +0000
Message-ID: <179166121360.434549.13863914493616373656@kernel.org>
In-Reply-To: <20261009-s2500-mac-phy-support-v9-4-dcefe1d0bf0d@onsemi.com>
References: <20261009-s2500-mac-phy-support-v9-4-dcefe1d0bf0d@onsemi.com>
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

- [Low] The new private header
  drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h doesn't compile on its…

--

net: ethernet: oa_tc6: Move constant definitions to header file

This patch moves the control/data header definitions, size constants,
enums and struct oa_tc6 out of oa_tc6.c into a new private header,
drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h. Other source files in the
OA TC6 framework can then share them.

> diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h b/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h
> new file mode 100644
> index 0000000000000..403a9c22b5f14
> --- /dev/null
> +++ b/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h
> @@ -0,0 +1,125 @@

[ ... ]

> +#ifndef OA_TC6_STD_DEF_H
> +#define OA_TC6_STD_DEF_H
> +
> +#include <linux/ptp_clock_kernel.h>
> +#include <linux/net_tstamp.h>
> +#include <linux/netdevice.h>
> +#include <linux/spi/spi.h>
> +#include <linux/skbuff.h>
> +#include <linux/sched.h>
> +#include <linux/wait.h>
> +#include <linux/phy.h>

[ ... ]

> +/* Internal structure for MAC-PHY drivers */
> +struct oa_tc6 {

[ ... ]

> +	bool prot_ctrl;
> +	enum oa_tc6_quirk_flag quirk_flags;
> +	struct gpio_desc *reset_gpio;
> +};

[Severity: Low]
This isn't a bug, but is this header meant to be self-contained?

struct oa_tc6 has quirk_flags as a by-value member of type
enum oa_tc6_quirk_flag. That enum is defined only in
include/linux/oa_tc6.h:

include/linux/oa_tc6.h:
enum oa_tc6_quirk_flag {
	OA_TC6_BROKEN_PHY = BIT(0),
};

oa_tc6_std_def.h doesn't include <linux/oa_tc6.h>. It compiles today
only because oa_tc6.c includes <linux/oa_tc6.h> right before it:

#include <linux/oa_tc6.h>

#include "oa_tc6_std_def.h"

Any new file that includes "oa_tc6_std_def.h" first would fail to build.

At this commit include/linux/oa_tc6.h has no include guard, so adding
the include here would also need a guard there. The later patch "net:
ethernet: oa_tc6: Support for hardware timestamp" adds _LINUX_OA_TC6_H.
Could this patch add the guard and include <linux/oa_tc6.h> directly
from oa_tc6_std_def.h?

A smaller point: nothing in this patch seems to use
<linux/ptp_clock_kernel.h>, <linux/net_tstamp.h>, <linux/sched.h> or
<linux/wait.h>. They look like they are first needed by the later
hardware timestamp patch.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009-s2500-mac-phy-support-v9-0-dcefe1d0bf0d%40onsemi.com
