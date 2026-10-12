Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C580549362B;
	Mon, 12 Oct 2026 13:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810223; cv=none; b=eu6VY17B5dF/Kov1cCvEundNSQiUoawRqXDr4dO/1bXVNtwqXSTQnuV55Z6FQpHpsdz4iWe1twWUpz/dUXPmtbjpq0MYNkHM1tRhnq0/mpdYttKRuTpYfb9IepBQ1zjNY/3KKGqZfFRDa5HZ+dyM6lhtymc+tnVZVX86Y3LU+6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810223; c=relaxed/simple;
	bh=Fy6EQ1hvo1qkHMUSGHPTavf8NwgB9mnbk+GClbMxdOI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fGbOQYTSUE/N2nWMFofieOruuQbLcIy7LIye+b8Q71R2yn77wzjWSQVpe83xagTWT6h7qQcRu6MGHryTdUkfCVomB5JgnSSL9bv3+V2/tRUO5D2gkrxkVRjBD1IfT4XAs6OyHoehmm8gJZmefbls2/ZMQYGlshoP2yPngGFx1Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvKAgha3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvKAgha3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340E11F0089C;
	Mon, 12 Oct 2026 13:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791810222;
	bh=f6inhc7CPFDGcYJa2C4KqUDQQZ32edNwZz4wJcTeMkk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fvKAgha3DHVf7LA0KXBT0gQiYllV4XVt/Uhpp3Zd/ONdvDoz1TFS/EOAXzFBRA0rg
	 nvYbaDDxqWOAnwibrmUycs3RiLg0doG9PpWyVrsDbWeWQLmT8/eFY2fTOKp+5lPyjc
	 JIKnsR0Yx+KAr5XGx2ZeTjBgxpiWaMJzmRI71IffeZvUtYAiBqCv/+kBIQpMaA4Sd1
	 K0QdrGtcKNkqn3Pv5drF18ZTLzmpsvQBIgwvo3UsbE1hXcJScX9IrohnzXB7ngkoWk
	 ZqVQGOPrjSrj9vFrEPR7qJjh3P8jsaFv2zVF6CagIq3Rh8waX0G4pOSw8Ha5oo5SB7
	 tTk1L71rj/aQw==
Subject: Re: [PATCH net-next v2 10/11] net: ethernet: qualcomm: ppe: Add
 IPQ5424 service code configuration
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
Date: Mon, 12 Oct 2026 13:03:40 +0000
Message-ID: <179181022076.434549.16206547099593179570@kernel.org>
In-Reply-To: <20261011-qcom_ipq5424_ppe-v2-10-8c7b057e2c43@oss.qualcomm.com>
References: <20261011-qcom_ipq5424_ppe-v2-10-8c7b057e2c43@oss.qualcomm.com>
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

- [Low] The patch adds PPE_SC_BYPASS_EGRESS_SMAC_MC_DROP (24),
  PPE_SC_BYPASS_EGRESS_L2_FLOODING (25) and…

--

net: ethernet: qualcomm: ppe: Add IPQ5424 service code configuration

This patch makes the stride of the L2 service code table depend on the
SoC: 0x20 on IPQ5424 and 0x10 on IPQ9574. On IPQ5424 it also writes a
second word per entry with the extended egress bypass bitmap. Three new
egress bypass bits (24-26) are added for source MAC multicast drop, L2
flooding and tunnel exception counter control.

> diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
> index 017d2e8342511..3dc1bcc8949eb 100644
> --- a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
> +++ b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c

[ ... ]

> @@ -1490,9 +1490,16 @@ int ppe_sc_config_set(struct ppe_device *ppe_dev, int sc, struct ppe_sc_cfg cfg)
>  			  test_bit(PPE_SC_BYPASS_COUNTER_RX, cfg.bitmaps.counter));
>  	val |= FIELD_PREP(PPE_IN_L2_SERVICE_TBL_TX_CNT_EN,
>  			  test_bit(PPE_SC_BYPASS_COUNTER_TX, cfg.bitmaps.counter));
> -	reg = PPE_IN_L2_SERVICE_TBL_ADDR + PPE_IN_L2_SERVICE_TBL_INC * sc;
> +	reg = PPE_IN_L2_SERVICE_TBL_ADDR + PPE_IN_L2_SERVICE_TBL_INC(ppe_dev) * sc;
>
> -	ret = regmap_write(ppe_dev->regmap, reg, val);
> +	in_l2_val[0] = val;
> +
> +	bitmap_value = bitmap_read(cfg.bitmaps.egress, PPE_SC_BYPASS_EGRESS_SMAC_MC_DROP,
> +				   PPE_SC_BYPASS_EGRESS_SIZE - PPE_SC_BYPASS_EGRESS_SMAC_MC_DROP);
> +	in_l2_val[1] = FIELD_PREP(PPE_IN_L2_SERVICE_TBL_W1_BYPASS_BITMAP_EXT, bitmap_value);

[Severity: Low]
Is the CPU service code meant to bypass all three new checks on IPQ5424?

The new enum values raise PPE_SC_BYPASS_EGRESS_SIZE from 24 to 27.
ppe_servcode_init() is unchanged, and it still fills the whole egress
bitmap and clears only one bit:

drivers/net/ethernet/qualcomm/ppe/ppe_config.c:ppe_servcode_init() {
    ...
	bitmap_fill(sc_cfg.bitmaps.egress, PPE_SC_BYPASS_EGRESS_SIZE);
	clear_bit(PPE_SC_BYPASS_EGRESS_ACL_POST_ROUTING_CHECK, sc_cfg.bitmaps.egress);

	return ppe_sc_config_set(ppe_dev, PPE_EDMA_SC_BYPASS_ID, sc_cfg);
}

Because of this, bitmap_read() here returns 0x7, and that value goes
into word 1 of the entry for PPE_EDMA_SC_BYPASS_ID on IPQ5424. Service
code 1 then bypasses source MAC multicast drop, L2 flooding and tunnel
exception counter control.

This matches the existing policy of bypassing every egress feature
except the ACL post-routing check, and IPQ9574 is unaffected. However,
neither the commit message nor a code comment says that the default CPU
service code now enables these bypasses.

Could the commit message, or a comment in ppe_servcode_init(), say
whether this is intended?

> +
> +	ret = regmap_bulk_write(ppe_dev->regmap, reg, in_l2_val,
> +				PPE_IN_L2_SERVICE_TBL_WORDS(ppe_dev));
>  	if (ret)
>  		return ret;
>

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011-qcom_ipq5424_ppe-v2-0-8c7b057e2c43%40oss.qualcomm.com
