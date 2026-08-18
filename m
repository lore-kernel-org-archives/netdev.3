Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4FA483BC4;
	Tue, 18 Aug 2026 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787073026; cv=none; b=lLWGyNpoo7aMFeTt9B+WyArTJUsB7DvMCHjParoU+HUcVPac8Os0cukUf71laIIYM2fvk2hntXu3IQXFm+VKvgHJrKMRvV7RLVQIvMWRW61zXwDrgqKzubN49xNvJP3CEoAktkHrJh4SIAgdfBvMwKNxAhQCAyL5UVeXcAIa5OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787073026; c=relaxed/simple;
	bh=ney4FO5ZXP0WjsbUb0InPZmYmk62/w/CSnIzKhe+yGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLXbQh4ZihiNe5nInk+MqnL/Dylr9giUXfMHTZcIulxydUMFVEff0yqj9W/ZZmlF1fTOoiSa6iaoNmpV4/rGRb13eGluruCTijKRMcJew9bzxfxEiQhfvex5rwUoIuh5ShpjYSRJww3W93461fDYdTCZ66zvHOvV039b/3DO2Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVTkXtwi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVTkXtwi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9564B1F000E9;
	Tue, 18 Aug 2026 17:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787073025;
	bh=6Kr/zCnSfgDdDrIsPRDTyhecXBtLu37KSZXVtk5ihkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eVTkXtwi7xkeEXp1S7T2FF0MLjqU2nxCCwoC9MG8Hptx3OtTd7cRlQ8gxuJbXeTAk
	 kEVWHSK0O1puTqxDjpHUimj24RRlU4osvuMpI6Thvjnc4pIlOmZ2u03gJqQMc9yymM
	 az4dUvFikadFwQjbt631XcjZ/vJrh0dScX4gOcqQJbgoUfY4auzZhSfix2tgv0wQhf
	 xDdIs209lui4wmPqnAYQzYywTLgJncJZvnuHy2uGSG7SQKN/vjoF+8YPCLKaZMXu58
	 LPTP0uwcQwFdp2DXjKiLnfPjN897CIS5wawMzFCxw1qJUnu5JNyn2DsN7AWe4G7h3C
	 BlAnTmuIg+rhA==
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
Subject: Re: [PATCH net-next v10 1/4] net: dsa: motorcomm: Move to subdirectory
Date: Tue, 18 Aug 2026 10:10:23 -0700
Message-ID: <20260818171023.4020249-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816193905.218112-2-mmyangfl@gmail.com>
References: <20260816193905.218112-2-mmyangfl@gmail.com>
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
net: dsa: motorcomm: Move to subdirectory

The yt921x DSA driver is moved from drivers/net/dsa/yt921x.[ch] into a new
drivers/net/dsa/motorcomm/ subdirectory as chip.[ch], with the Kconfig
symbol and the build rule moved into new per-directory Kconfig and Makefile
files.  MAINTAINERS is updated to match the new path.

> diff --git a/drivers/net/dsa/motorcomm/Kconfig b/drivers/net/dsa/motorcomm/Kconfig
> new file mode 100644
> index 0000000000000..1fddd386f866c
> --- /dev/null
> +++ b/drivers/net/dsa/motorcomm/Kconfig
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: ISC
> +config NET_DSA_YT921X
> +	tristate "Motorcomm YT9215 ethernet switch chip support"
> +	select NET_DSA_TAG_YT921X
> +	select NET_IEEE8021Q_HELPERS if DCB
> +	help
> +	  This enables support for the Motorcomm YT9215 ethernet switch
> +	  chip.
> diff --git a/drivers/net/dsa/motorcomm/Makefile b/drivers/net/dsa/motorcomm/Makefile
> new file mode 100644
> index 0000000000000..afd03be9fa35c
> --- /dev/null
> +++ b/drivers/net/dsa/motorcomm/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: ISC
    ^^^

[Severity: Low]
Is the ISC tag on the two new files intentional?  Both
drivers/net/dsa/motorcomm/Kconfig and drivers/net/dsa/motorcomm/Makefile
start with:

    # SPDX-License-Identifier: ISC

but the text in them was moved verbatim out of files carrying a different
tag:

    drivers/net/dsa/Kconfig:  # SPDX-License-Identifier: GPL-2.0-only
    drivers/net/dsa/Makefile: # SPDX-License-Identifier: GPL-2.0

so the same config block and the same obj-$(CONFIG_NET_DSA_YT921X) line now
appear under two different licenses.

The sources these files build are also tagged differently:

    drivers/net/dsa/motorcomm/chip.c: // SPDX-License-Identifier: GPL-2.0-or-later
    drivers/net/dsa/motorcomm/chip.h: /* SPDX-License-Identifier: GPL-2.0-or-later */

ISC only exists in the tree as LICENSES/deprecated/ISC, and
Documentation/process/license-rules.rst says about that set:

    2. Deprecated licenses:

       These licenses should only be used for existing code or for importing
       code from a different project.

These two files are newly created and not imported from another project.
Every other DSA subdirectory (b53, hirschmann, microchip, mv88e6xxx,
mxl862xx, netc, ocelot, qca, realtek, sja1105, xrs700x) uses a GPL-2.0
variant for its Kconfig and Makefile, and these are the only ISC-tagged
files under drivers/net/dsa/.

Would GPL-2.0-only (matching the files the text came from) or
GPL-2.0-or-later (matching chip.c and chip.h) be the right tag here?  The
commit message describes the change as a mechanical relocation and does not
mention a licensing change.

> +obj-$(CONFIG_NET_DSA_YT921X) += yt921x.o
> +yt921x-objs := chip.o

[ ... ]
-- 
pw-bot: cr
