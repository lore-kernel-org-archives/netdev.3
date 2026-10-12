Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C7C491584;
	Mon, 12 Oct 2026 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810220; cv=none; b=CL/97W/S6iY5/ScPi8FTaquCoe4CRxzpfe1rEgJLPrJb1FjlWEmYTJck1Q/A8jPyKDVxdWYRdpcHcoAIrB049uid5sle2WRy6z9s7gaTFMFPjCOrWY/dvOCwwBLILyeLsFN0bb99PuODM4uBes115bklGdsF1UNmxH9SjFBpdjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810220; c=relaxed/simple;
	bh=KcivMhNMVFjxwJ+v9QDqEk/ZgIbJAPWywea5c8aI9MA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UdoguXvTm6IPI13eIaKNz1ryqRArqXX+6ZAbcHJSHM3Ow8Y/t3pdsvVt4B3f2N7WbqBQBhbUsQ03a3SZw4nr9N3BPJ0PnZDelCg8KgecPeJj6rkXJizLHXu/69qzz8G+yDDnQmrQ2HQV352HOa9Q1jhV9QxrRfbH38DRTPTHtlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftRM36Cl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftRM36Cl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB531F0089C;
	Mon, 12 Oct 2026 13:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791810218;
	bh=2lku1KyKdw732Kq8KhwoCfK+ylAugbcjE83/Tw2WWRk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ftRM36CleDupVyoUou6+VkVHe1lp7EnYpPNM5ENqzq2Hna82KNZa/pY/J3dd0WwEz
	 NE7DTU3QfYpvPyvB9qL01gyzkd2xjV7YBC5fFV44DddsJzRxIOjNYd5kGo7diDEeTH
	 vXn6vZ9eM6SpJAg3uDUyqUsfkdDM8nGd+gzrA91O9UapYNDfsxBqyrVQknQG4gOfWw
	 CjLJfXChktEL5IwRINVpkmeusuyA6KO6+R6P+bCo/IUFJmyyjGHlAg5QgNV429aSPs
	 NdERRrIGJGB/OX/Qd7LDG0SV7c619gJp6nXVRy8ml7YGd5xjyrMBvG/elczV92cZ+M
	 Cz6HPdxHHbLgA==
Subject: Re: [PATCH net-next v2 06/11] net: ethernet: qualcomm: ppe: Add
 IPQ5424 BM buffer configuration
From: netdev-bot+sashiko@kernel.org
To: jie.luo@oss.qualcomm.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, quic_leiwei@quicinc.com, quic_suruchia@quicinc.com,
 quic_pavir@quicinc.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com
Date: Mon, 12 Oct 2026 13:03:37 +0000
Message-ID: <179181021716.434549.5133462136648736892@kernel.org>
In-Reply-To: <20261011-qcom_ipq5424_ppe-v2-6-8c7b057e2c43@oss.qualcomm.com>
References: <20261011-qcom_ipq5424_ppe-v2-6-8c7b057e2c43@oss.qualcomm.com>
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

- [Low] This patch adds PPE_BM_PORT_GROUP_ID_IPQ5424_ADDR = 0x6001c0, and
  ppe_config_bm_threshold() now writes the IPQ5424 BM port group IDs to…

--

net: ethernet: qualcomm: ppe: Add IPQ5424 BM buffer configuration

This patch adds an IPQ5424 BM buffer configuration (per-port thresholds
and a larger group0 shared pool) and a ppe_type field in struct
ppe_device to select it. It also adds per-SoC address and entry-count
macros for the BM register tables, which have more entries on IPQ5424
and in some cases sit at different addresses.

> diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
> index 746dfbb5a682..441e8e04a80b 100644
> --- a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
> +++ b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h

[ ... ]

> -#define PPE_BM_PORT_GROUP_ID_ADDR		0x600180
> -#define PPE_BM_PORT_GROUP_ID_ENTRIES		15
> +#define PPE_BM_PORT_GROUP_ID_IPQ9574_ADDR	0x600180
> +#define PPE_BM_PORT_GROUP_ID_IPQ5424_ADDR	0x6001c0

[Severity: Low]
With this change, two tables in this header use the same address on
IPQ5424. Right below this hunk, the counter tables still have one
fixed layout for all SoCs:

  /* Counters for PPE buffers used for packets cached. */
  #define PPE_BM_USED_CNT_TBL_ADDR		0x6001c0
  #define PPE_BM_USED_CNT_TBL_ENTRIES		15
  ...
  #define PPE_BM_REACT_CNT_TBL_ADDR		0x600240
  #define PPE_BM_REACT_CNT_TBL_ENTRIES		15

ppe_bm_counter_get() in ppe_debugfs.c uses these constants on every SoC:

  for (i = 0; i < PPE_BM_USED_CNT_TBL_ENTRIES; i++) {
          reg = PPE_BM_USED_CNT_TBL_ADDR + i * PPE_BM_USED_CNT_TBL_INC;
          ...
          reg = PPE_BM_REACT_CNT_TBL_ADDR + i * PPE_BM_REACT_CNT_TBL_INC;

On IPQ5424, will the "BM USED/REACT" debugfs output show the group ID
registers that ppe_config_bm_threshold() just wrote, instead of buffer
usage counters? The REACT values would also come from the wrong table,
and BM ports 15-18 would never be shown. Ports 16-18 are the three
physical ports.

The configuration write to 0x6001c0 looks correct; only the debugfs read
side is affected. The new PPE_BM_PORT_*_ENTRIES(ppe_dev) macros also have
no callers yet in this patch.

A later patch in this series, "net: ethernet: qualcomm: ppe: Add IPQ5424
counter debugfs support", fixes this. It adds IPQ5424 counter table
addresses (0x600220 and 0x600280, 19 entries each) and makes
ppe_debugfs.c use the per-SoC macros.

Would it make sense to move the counter address split into this patch?
That way the header never has GROUP_ID and USED_CNT at the same IPQ5424
address in between patches.

> +#define PPE_BM_PORT_GROUP_ID_ADDR(ppe_dev)					\
> +	((ppe_dev)->type == IPQ5424_PPE ? PPE_BM_PORT_GROUP_ID_IPQ5424_ADDR :	\
> +					  PPE_BM_PORT_GROUP_ID_IPQ9574_ADDR)
> +#define PPE_BM_PORT_GROUP_ID_ENTRIES(ppe_dev)	PPE_BM_PORT_ENTRIES(ppe_dev)
>  #define PPE_BM_PORT_GROUP_ID_INC		0x4
>  #define PPE_BM_PORT_GROUP_ID_SHARED_GROUP_ID	GENMASK(1, 0)

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011-qcom_ipq5424_ppe-v2-0-8c7b057e2c43%40oss.qualcomm.com
