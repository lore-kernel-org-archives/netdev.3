Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E5D483BF1;
	Tue, 18 Aug 2026 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787073028; cv=none; b=UAT6ddg3zfs3R6swC+5/svX5tiHY46Ye2orKdWJI7m4ypvJnr377EbvYwq/UbhgQfxwu3NZrfgNmy6W2viQ/bhGsPJQ5p/ZUg/tIobpDnwvYvcH8zR2kDPiuB+fjtdMGwwxG1JOFVTXh5g240IDWKBZofQUMqUbbgEU6zWUWLFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787073028; c=relaxed/simple;
	bh=t0ypvUVHSNZuJ1guxPyIkX6/hxRI3rFiJ2+SnFS5gDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sT39W8V08MlOrsZHSZvIKZDHVitRhxua8DXtm6hm8g66zx0MMEj/UTsWT+1cTJZXM27hA79ndXPreeSaZbC3prbXQDflOFgHhAlC7Ou+zqJ+eZJcC2LlRu8AXgzKujMyj6rMfyovoTr/xZ/WpLdzT3eLVCqFiaSbse6PLv1HA1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnsaEGra; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnsaEGra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7C21F00A3D;
	Tue, 18 Aug 2026 17:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787073026;
	bh=iDibG0afIv0qloy0MNPMiRBh0MOvyMxPazplLke7E7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HnsaEGravZPQL6uUSt+U4RSAIUpyJ/z0U9OFZBORz2u7OS96N/vecvX4JKrQ7IDLc
	 dpAaR9vxG0300AyKG9BYGu+yZ0DNlxz/aNw3Y39JDefqeQcVniAdYdA1HBfX0wG8Iw
	 t0nPIsXr3RzjJoHI3iM7otXunTgANyEctZ4ZDnxCnRiUcBtcfdj8oH7HgbzQWktj0p
	 95w8WKtRj3PydVi7q/HkV2TWWvqPqC3+XiAXpPhH9JbX3sFayKXlBv8TwrQu1B+tzX
	 bUmyGAg6mdAgds9VLSLCfIT8I3EPBOzQirHm06mMEjx1Wq2T6KdijAjJrLzTTdqrrY
	 C6f7KbZ3Ac75w==
From: Jakub Kicinski <kuba@kernel.org>
To: mmyangfl@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 2/4] net: dsa: motorcomm: Split SMI module
Date: Tue, 18 Aug 2026 10:10:25 -0700
Message-ID: <20260818171025.4020314-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816193905.218112-3-mmyangfl@gmail.com>
References: <20260816193905.218112-3-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: motorcomm: Split SMI module

This moves the yt921x SMI register accessors out of chip.c into a new
smi.c/smi.h pair and adds smi.o to the module objects.  The helpers gain
external linkage, and the thin wrappers around them become static inline in
the new header.

A few comments and questions below.  The chip.c and Makefile hunks are
snipped since the comments all land on the new files.

> diff --git a/drivers/net/dsa/motorcomm/smi.c b/drivers/net/dsa/motorcomm/smi.c
> new file mode 100644
> index 0000000000000..164c25ef494a1
> --- /dev/null
> +++ b/drivers/net/dsa/motorcomm/smi.c
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 David Yang
> + */
> +
> +#include <linux/iopoll.h>
> +
> +#include "chip.h"
> +#include "smi.h"
> +
> +#define YT921X_POLL_SLEEP_US	10000
> +#define YT921X_POLL_TIMEOUT_US	100000
> +
> +int yt921x_reg_read(struct yt921x_priv *priv, u32 reg, u32 *valp)
> +{
> +	WARN_ON(!mutex_is_locked(&priv->reg_lock));
> +
> +	return priv->reg_ops->read(priv->reg_ctx, reg, valp);
> +}
> +
> +int yt921x_reg_write(struct yt921x_priv *priv, u32 reg, u32 val)
> +{
> +	WARN_ON(!mutex_is_locked(&priv->reg_lock));
> +
> +	return priv->reg_ops->write(priv->reg_ctx, reg, val);
> +}

[Severity: Low]
This is a pre-existing issue and not introduced by this patch, since these
two lines are moved verbatim out of chip.c.

Now that yt921x_reg_read() and yt921x_reg_write() are a cross-file (and per
the commit message cross-module) API, would lockdep_assert_held() be the
better assertion here?

mutex_is_locked(&priv->reg_lock) only reports that some task owns the mutex,
not that the current one does, so a new caller that forgets to take
priv->reg_lock passes the check whenever another thread happens to hold it.

Would WARN_ON_ONCE() also be preferable to WARN_ON() on a path that runs for
every single register access?

[ ... ]

> +int
> +yt921x_regs_update_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
> +			const u32 *vals, unsigned int num_regs)
> +{
> +	bool changed = false;
> +	u32 vs[4];
> +	int res;
> +
> +	if (WARN_ON_ONCE(num_regs > ARRAY_SIZE(vs)))
> +		return -EINVAL;

[Severity: Low]
The chip.c versions guarded the vs[4] stack buffer at compile time:

	BUILD_BUG_ON(num_regs > ARRAY_SIZE(vs));

and that becomes a runtime warning here and in yt921x_regs_clear_bits().
Is the reason that num_regs is no longer a constant expression inside the
callee once the function has external linkage?

No overflow looks reachable today: the only callers go through the
yt921x_reg64_*()/yt921x_reg96_*() wrappers in smi.h with a literal 2 or 3.

Would it be worth naming this conversion in the commit message instead of
just "Minor changes are applied to fix build errors"?  The lengths of the
caller supplied masks[] and vals[] arrays also remain unchecked, which is
worth a word since the helpers are now callable from other files.

[ ... ]

> diff --git a/drivers/net/dsa/motorcomm/smi.h b/drivers/net/dsa/motorcomm/smi.h
> new file mode 100644
> index 0000000000000..2995e91f3b3d1
> --- /dev/null
> +++ b/drivers/net/dsa/motorcomm/smi.h
> @@ -0,0 +1,92 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2026 David Yang
> + */
> +
> +#ifndef _YT_SMI_H
> +#define _YT_SMI_H

[Severity: Low]
This isn't a bug, but the guard name here is _YT_SMI_H while the sibling
private header in the same directory uses __YT921X_H.  Was the difference
intended?

[ ... ]

> +static inline void update_ctrls_unaligned(u32 *lo, u32 *hi, u64 mask, u64 val)
> +{
> +	*lo &= ~lower_32_bits(mask);
> +	*hi &= ~upper_32_bits(mask);
> +	*lo |= lower_32_bits(val);
> +	*hi |= upper_32_bits(val);
> +}

[Severity: Low]
Related to the above, and also not a bug: this helper is the only symbol in
the header without the yt921x_ prefix that everything else uses, and it is
now visible to every file that includes smi.h.

Its only users are the two METER control word calls in chip.c:

	update_ctrls_unaligned(&ctrls[0], &ctrls[1],
			       YT921X_METER_CTRLab_EBS_M, ...);

so could it stay a file local static in chip.c, or get a yt921x_ prefix if
it really needs to move?

> +
> +/* yt921x_regs_*() are exported for linkage only. Do not use them directly. Use
> + * yt921x_reg64_*() or yt921x_reg96_*() instead.
> + */
> +
> +int yt921x_regs_read(struct yt921x_priv *priv, u32 reg, u32 *vals,
> +		     unsigned int num_regs);

[Severity: Low]
Two things about this contract.

The comment above says "Here we require full read and write operations over
these registers", and this one says to use yt921x_reg64_*() or
yt921x_reg96_*() instead of the raw helpers.  But the wrapper set is write
side only: yt921x_reg64_write(), yt921x_reg64_update_bits(),
yt921x_reg64_clear_bits() and yt921x_reg96_write().  There is no
yt921x_reg64_read() or yt921x_reg96_read(), so a module that wants the
required full read of something like VLANn_CTRL has no permitted call.
Should a read wrapper be added along with the split?

Second, yt921x_regs_read() is declared here "for linkage only", but its only
callers are yt921x_regs_update_bits() and yt921x_regs_clear_bits() in smi.c
itself, both at the time of this commit and at the end of the series.  Can it
stay static in smi.c rather than becoming a global symbol?

[ ... ]
