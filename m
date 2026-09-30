Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3F021E097;
	Wed, 30 Sep 2026 03:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790738379; cv=none; b=Fgg5WdSNcNjL4BEG2O21O54p7C8tF7qtTA9l3JNOkeE2EeG25HFiE8fiwW3aYYVPvUOejZ0RV/bqdGBDrf2I++Q+mUin3eQW0UkQcUcUCN5WhD23w0KGZ9ul0Bly7IoIIGHb+pWmXumt8c1TqSG9o/eZcxbLJMNB4JNSfT7W3OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790738379; c=relaxed/simple;
	bh=ThP12Tv7gwbyfTnvtFj5aN1T5Kx+E9g/MIGql2mX7d0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JLOHTmdC0N9qhAR1DJXeQG17qV/1fwfHM+vWPdMjXmbjqOJn3f7WcEvX2rtHi43rvC21z686MqSqQjMTT/gmYPwW1AWM2MYo9xilCDbB7i5H3oQoTIE28TSbar5lDbvXzxWe/DMM3OnRHt7gjGgCImwbjqv0dG+ELqQXbOazDHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7lTfrv9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7lTfrv9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664C91F000FF;
	Wed, 30 Sep 2026 03:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790738377;
	bh=Nb4NqFdWYWfaWTFhpA/eJ8dsBAMYjbSrDg/2ufGZyH0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=V7lTfrv9HMfMArc+kKB77PnJu1hyocRpcyZ6qFy+C7WwKJT3z3Vwfg/2+AQBRTGAj
	 AjmE2cVhjQ0ZqdBYPzIp5qEhyFrWZl52/MSDKGZToIuQJoOj93exx1BnljtEaE1tL8
	 gct/J2C3lfmt9uW8t0tHYoBIXi34kgYOzOZnBckjTy7zXd4sQE8ej9/vorXLjibfFh
	 3USV6KrF3s+AaKuIQEDbmwl8aKxo6tcD3pkCF8dUi0D93r8RXkeMBkq0gg/+KbTXAD
	 7FprIgC3uNwIsJyMix63mHsh7bpWbS4iPxa+LZMPbgDEQ0Fzn0mMdywRulf70daxxl
	 KLUvZ453zTlEg==
Subject: Re: [PATCH net-next 1/6] net: dsa: motorcomm: Split TC module
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Wed, 30 Sep 2026 03:19:36 +0000
Message-ID: <179073837688.434549.16725584220078648669@kernel.org>
In-Reply-To: <20260926211813.935723-2-mmyangfl@gmail.com>
References: <20260926211813.935723-2-mmyangfl@gmail.com>
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

- [Low] The patch moved the comment "/* Custom meters only, not including
  dedicated port meters (11) */" away from the define it describes.
- [Low] tc.h does not compile on its own.
- [Low] yt921x_dsa_port_setup_tc_tbf_port() is declared in tc.h (line
  361) and defined without `static` in tc.c (line 292).

--

net: dsa: motorcomm: Split TC module

This commit moves the traffic control code (policers, TBF shaping, flower
ACL offload and port mirroring) out of chip.c and into a new file, tc.c.
The related register definitions and ACL structs move from chip.h into a
new tc.h. The ethaddr helpers become static inline functions in chip.h.

> diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
> index 28e4f26f9cc49..02419bcde3f21 100644
> --- a/drivers/net/dsa/motorcomm/chip.h
> +++ b/drivers/net/dsa/motorcomm/chip.h

[ ... ]

> @@ -791,19 +484,7 @@ enum yt921x_fdb_entry_status {
>  
>  #define YT921X_MSTI_NUM		16
>  
> -#define YT921X_TOKEN_BYTE_C	1	/* 1 token = 2^1 byte */
> -#define YT921X_TOKEN_PKT_C	-6	/* 1 token = 2^-6 packets */
> -#define YT921X_TOKEN_RATE_C	-15
> -/* Custom meters only, not including dedicated port meters (11) */
>  #define YT921X_METER_NUM	64
> -#define YT921X_METER_SLOT_MIN	80
> -#define YT921X_METER_UNIT_MAX	((1 << 3) - 1)
> -#define YT921X_METER_CIR_MAX	((1 << 18) - 1)
> -#define YT921X_METER_CBS_MAX	((1 << 16) - 1)
> -#define YT921X_PORT_SHAPE_SLOT_MIN	80
> -#define YT921X_SHAPE_UNIT_MAX	((1 << 3) - 1)
> -#define YT921X_SHAPE_CIR_MAX	((1 << 18) - 1)
> -#define YT921X_SHAPE_CBS_MAX	((1 << 14) - 1)

[Severity: Low]
This isn't a bug, but the "Custom meters only" comment described
YT921X_METER_NUM, and that define stays in chip.h. In tc.h the comment now
sits above an unrelated define:

tc.h:
#define YT921X_TOKEN_RATE_C	-15
/* Custom meters only, not including dedicated port meters (11) */
#define YT921X_METER_SLOT_MIN	80

Could the comment stay with YT921X_METER_NUM in chip.h? It explains why
yt921x_dsa_port_policer_add() programs meter port + YT921X_METER_NUM. With
the comment moved, YT921X_METER_NUM has no explanation.

This still looks the same at the end of the series.

[ ... ]

> diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
> new file mode 100644
> index 0000000000000..38dd4ec60bbc1
> --- /dev/null
> +++ b/drivers/net/dsa/motorcomm/tc.c
> @@ -0,0 +1,1457 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 David Yang
> + */
> +
> +#include "chip.h"
> +#include "smi.h"
> +#include "tc.h"
> +
> +#define to_yt921x_priv(_ds) container_of_const(_ds, struct yt921x_priv, ds)
> +#define to_device(priv) ((priv)->ds.dev)

[ ... ]

> +int
> +yt921x_dsa_port_setup_tc_tbf_port(struct dsa_switch *ds, int port,
> +				  const struct tc_tbf_qopt_offload *qopt)
> +{

[ ... ]

> +int
> +yt921x_dsa_port_setup_tc(struct dsa_switch *ds, int port,
> +			 enum tc_setup_type type, void *type_data)
> +{
> +	switch (type) {
> +	case TC_SETUP_QDISC_TBF: {
> +		const struct tc_tbf_qopt_offload *qopt = type_data;
> +
> +		return yt921x_dsa_port_setup_tc_tbf_port(ds, port, qopt);
> +	}

[Severity: Low]
This isn't a bug, but the only caller of
yt921x_dsa_port_setup_tc_tbf_port() is yt921x_dsa_port_setup_tc(), here in
the same file. Could it stay static and be left out of tc.h?

Also, the to_yt921x_priv() and to_device() macros at the top of tc.c are
exact copies of the ones in chip.c:

chip.c:
#define to_yt921x_priv(_ds) container_of_const(_ds, struct yt921x_priv, ds)
#define to_device(priv) ((priv)->ds.dev)

Would it be better to define them once in chip.h, next to struct
yt921x_priv, so the two copies can't drift apart?

[ ... ]

> diff --git a/drivers/net/dsa/motorcomm/tc.h b/drivers/net/dsa/motorcomm/tc.h
> new file mode 100644
> index 0000000000000..3d4a8a24f8a85
> --- /dev/null
> +++ b/drivers/net/dsa/motorcomm/tc.h
> @@ -0,0 +1,380 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2026 David Yang
> + */
> +
> +#ifndef _YT_TC_H
> +#define _YT_TC_H
> +
> +#include <net/dsa.h>
> +#include <net/pkt_cls.h>
> +

[ ... ]

> +struct yt921x_acl_rule {
> +	unsigned long tag;
> +	enum tc_setup_type type;
> +
> +	u32 action[3];
> +	bool sw_assisted;
> +
> +	u8 mask;
> +	struct yt921x_acl_entry entries[YT921X_ACL_ENT_PER_BLK];
> +};
> +
> +struct yt921x_acl_blk {
> +	struct yt921x_acl_rule *rules[YT921X_ACL_ENT_PER_BLK];
> +};

[Severity: Low]
Is tc.h meant to compile on its own? YT921X_ACL_ENT_PER_BLK is still
defined only in chip.h, and tc.h includes only <net/dsa.h> and
<net/pkt_cls.h>. These arrays build only because chip.c and tc.c both
include "chip.h" before "tc.h".

The dependency also runs the other way. struct yt921x_priv in chip.h still
holds struct yt921x_acl_blk *acl_blks[], but that type is now defined only
in tc.h. A pointer to an incomplete type is legal, but the split between
the two headers is inconsistent.

The other local headers (leds.h, mdio_bus.h, smi.h) include what they need
and forward-declare struct yt921x_priv. Could tc.h do the same and include
what it depends on, such as the header that defines YT921X_ACL_ENT_PER_BLK?
As it stands, reordering the includes or adding a new user of tc.h would
break the build.

This also looks unchanged at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260926211813.935723-1-mmyangfl%40gmail.com
