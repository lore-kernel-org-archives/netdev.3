Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2025633031B;
	Sat,  7 Feb 2026 02:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770431093; cv=none; b=OrxG9/9zMXMlccn84Ht3sb7DpsfzBxqGjQk97DOSqCmg2nnECkQ0nG753MN9iH4JRnz2gv9rlG19vb/c/tnaFgw0GfdPk/pW8fe/WRlvd/WNkScwOoMuT1pyamZEoTyu7wf2FLjpJ5Fj6bvOr9bG3oVuNKU1/XPNp/jB7bibDbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770431093; c=relaxed/simple;
	bh=jagzDFdG5cn5dqrQ7LKmMSnFuPt4sggBumGGF6Rj2ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ye46LMFbzdy2t4iZxtpjfXnz6Li3INOqyGVqwn1jbkiqSW9t5/f1G8TbY0w8eu0aZlP0MZ8KzGRqZwyCu+A1XpHm88VU0mivdrwkm3EQGs0HF8uZ+EZ7s/XLlwuy8YHMxi3A7bBULLsOeE8jGhdHx7eWyu57tB47YYMXXGXYEc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OozKlB5n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OozKlB5n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A273C116C6;
	Sat,  7 Feb 2026 02:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770431093;
	bh=jagzDFdG5cn5dqrQ7LKmMSnFuPt4sggBumGGF6Rj2ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OozKlB5nhtai5sMn1hvIDT7XCfIBkrnN+KXI3xgn40pAaa9CJAfAyd1EbHixfOXKc
	 02e0+tMtTpf3wd+bJN524t5m8Nz2ZCFzlFOby6mjoGxyPPb+3uTLpHJ5G1nTtq4zij
	 p4s7/4QUJ9XPfEtXlteRHfi4RnSWLKQMr0sYQQZ4uyRcLomuvuQbwLGUV9kvedcf/X
	 0LNW14S8fYNF69A5VdISqCv3EWDphIKRmvoqG4tQr19O6kqkD5ef6EPbgOL7OqbrKi
	 i1L/jNCVH2099EUEMCcXdqQ/KZAcaBvGdbtLJU8spZ/h8tKCIZ6B0KDIh1lwH7D+IT
	 LKNGtx+y78p+w==
From: Jakub Kicinski <kuba@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	sam.chen@nebula-matrix.com,
	lukas.bulwahn@redhat.com,
	dimon.zhao@nebula-matrix.com,
	netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	linux-kernel@vger.kernel.org (open list),
	corbet@lwn.net,
	lorenzo@kernel.org,
	alvin.wang@nebula-matrix.com,
	andrew+netdev@lunn.ch,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org
Subject: Re: [v4,net-next,03/11] net/nebula-matrix: add chip related definitions
Date: Fri,  6 Feb 2026 18:24:51 -0800
Message-ID: <20260207022451.4017791-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206021608.85381-4-illusion.wang@nebula-matrix.com>
References: <20260206021608.85381-4-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email says "This is an automated AI code reviewer, please treat what
it says with a grain of salt."

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/nebula-matrix: add chip related definitions

This commit adds hardware register definitions for the Leonis chip,
including PPE, DP, and interface module base addresses, as well as
P4 configuration data used during chip initialization.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw.h
> new file mode 100644
> index 000000000000..f657c1e6a5ad
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw.h
> @@ -0,0 +1,128 @@
> +/* SPDX-License-Identifier: GPL-2.0*/

This isn't a bug, but the SPDX license identifier is missing a space
before the closing comment. The kernel standard format is:

    /* SPDX-License-Identifier: GPL-2.0 */

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
> index 240d356f18b0..9000650256ca 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h

[ ... ]

> +#define NBL_DP_UL4S_BASE			(0x00204000)

[ ... ]

> +#define NBL_DP_DL4S_BASE			(0x00614000)

[ ... ]

> +#define NBL_DP_DL4S_BASE			(0x00614000)
> +#define NBL_DP_UL4S_BASE			(0x00204000)

NBL_DP_DL4S_BASE and NBL_DP_UL4S_BASE are defined twice in this file.
While the values are identical, would it make sense to remove the
duplicate definitions?

[ ... ]

> +/*  ----------  DSCH  ----------  */
> +/* DSCH vn_host_qid_max */
> +#define NBL_DSCH_NOTIFY_BITMAP_ARR(i) \
> +	(NBL_DP_DSCH_BASE + 0x00003000 + (i) * BYTES_PER_DWORD)
> +#define NBL_DSCH_FLY_BITMAP_ARR(i) \
> +	(NBL_DP_DSCH_BASE + 0x00004000 + (i) * BYTES_PER_DWORD)

BYTES_PER_DWORD is not defined in this driver. Will this cause
compilation errors when these macros are expanded? Consider defining
BYTES_PER_DWORD or using the already-defined NBL_BYTES_IN_REG.

> +#define NBL_DSCH_PORT_MAP_REG_ARR(i) \
> +	(NBL_DP_DSCH_BASE + 0x00005000 + (i) * sizeof(struct nbl_port_map))

struct nbl_port_map is referenced but not defined anywhere in the
nebula-matrix driver. Is this type defined elsewhere, or is a definition
missing?

[ ... ]

> +/* epro epro_kgen_ft table */
> +#define NBL_EPRO_KGEN_FT_TABLE(i)         \
> +	(NBL_PPE_EPRO_BASE + 0x00001980 + \
> +	 (i) * sizeof(struct nbl_epro_kgen_ft_tbl))

struct nbl_epro_kgen_ft_tbl is referenced but not defined in this
driver. Is a definition missing for this type?

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.h
> new file mode 100644
> index 000000000000..75b7dd783354
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0*/

This isn't a bug, but the SPDX license identifier is missing a space
before the closing comment. The kernel standard format is:

    /* SPDX-License-Identifier: GPL-2.0 */
