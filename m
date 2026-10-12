Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ACE4908CB;
	Mon, 12 Oct 2026 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810219; cv=none; b=Q7rSxolhoKtokf9i1Qnq4hR+dajF6qmYl1XkJVvwEumYvQUqvdTZxM7RtAOK46P+AtyuulZzy09vRGn+fAFAUDVp/dBfHbmAW7mz6BHlqSH5vZiwSYuaWervwXmd/2lR8X83UoZfBrFxwMR9UBGEN/hhWBpU6MxrTtARTlm8iI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810219; c=relaxed/simple;
	bh=zUXlJCl8rDmQnz8PUw4S9XrSErwozWk9CDHe2Vh4fUk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ORHNQ6q2v2Jh7Rk0Ojgei15GSsEwzksdaOqaygpdiLTlYZU16+qCaPlOpWiTDpp2YyW6uEDhc9V7iH6dGOXi1ROYmxYB0WaKPXLkMNVeWWHJoj+Wh0desc9buolu5qFByzxOV2WFhgcgShqtux0MsM3MtPNTV5gLVeLRQyPNOVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmzzIKnT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmzzIKnT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59311F0089B;
	Mon, 12 Oct 2026 13:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791810217;
	bh=yqsWvQB7DLhx+KgOw/QY/III9eiS0yuZEfqUUYfeWVs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bmzzIKnTuBOT6lFNin/kRHGVdqN5ymi3bvDQF5AYSlx7zmupfxBg6eHp4edYSMAEN
	 7mi6bjhUrOQ/UHTWL9zL8j5VlkknHOAdb9v1g1UKKDz8rH5sJriRsKRezsjly/HkdY
	 avk74e1AxoBW/U6XjeqdGnKNtqrNVK+ntvUMZ75SF2XnkpcG+o7aarAyZvfJoWTKQb
	 hULy0/6UR9r7F4pjCB5XdGOBeaxzwVzm2WTnQynF/EGV+/6ji1XyCWSacZrpQPRbHB
	 TdQeIEKgyGiNxU2nZkJmPWp/dbtoiJnqhdKrwuWBLThsRuS0zhXBVqzDJzJT2pqAY+
	 zr/9nd6xN0cRg==
Subject: Re: [PATCH net-next v2 05/11] net: ethernet: qualcomm: ppe: Add
 platform support for IPQ5424
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
Date: Mon, 12 Oct 2026 13:03:35 +0000
Message-ID: <179181021546.434549.14442931724407401600@kernel.org>
In-Reply-To: <20261011-qcom_ipq5424_ppe-v2-5-8c7b057e2c43@oss.qualcomm.com>
References: <20261011-qcom_ipq5424_ppe-v2-5-8c7b057e2c43@oss.qualcomm.com>
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

- [Low] In the commit "net: ethernet: qualcomm: ppe: Add platform support
  for IPQ5424", the new "qcom,ipq5424-ppe" compatible makes the driver…

--

net: ethernet: qualcomm: ppe: Add platform support for IPQ5424

This commit adds per-SoC platform data to the PPE driver: clock rate,
port count, regmap config and interconnect paths. It also adds the
"qcom,ipq5424-ppe" compatible. IPQ5424 has 3 Ethernet ports plus the
EDMA FIFO, a 375 MHz PPE clock, a smaller set of interconnect paths, and
no access to the MAC3-MAC5 register space.

> diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
> index 3c301e609d3e..f71b673b6f97 100644
> --- a/drivers/net/ethernet/qualcomm/ppe/ppe.c
> +++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c

[ ... ]

> @@ -218,8 +301,25 @@ static void qcom_ppe_remove(struct platform_device *pdev)
>  	ppe_debugfs_teardown(ppe_dev);
>  }
>  
> +static const struct ppe_of_data ipq9574_data = {
> +	.ppe_rate = IPQ9574_PPE_CLK_RATE,
> +	.num_ports = IPQ9574_PPE_PORT_MAX,
> +	.regmap_config = &regmap_config_ipq9574,
> +	.icc_paths = ipq9574_ppe_icc_data,
> +	.num_icc_paths = ARRAY_SIZE(ipq9574_ppe_icc_data),
> +};
> +
> +static const struct ppe_of_data ipq5424_data = {
> +	.ppe_rate = IPQ5424_PPE_CLK_RATE,
> +	.num_ports = IPQ5424_PPE_PORT_MAX,
> +	.regmap_config = &regmap_config_ipq5424,
> +	.icc_paths = ipq5424_ppe_icc_data,
> +	.num_icc_paths = ARRAY_SIZE(ipq5424_ppe_icc_data),
> +};
> +
>  static const struct of_device_id qcom_ppe_of_match[] = {
> -	{ .compatible = "qcom,ipq9574-ppe" },
> +	{ .compatible = "qcom,ipq9574-ppe", .data = &ipq9574_data },
> +	{ .compatible = "qcom,ipq5424-ppe", .data = &ipq5424_data },

[Severity: Low]
This compatible makes the driver probe on IPQ5424. At this commit, does
qcom_ppe_probe()->ppe_hw_config() still program the IPQ9574-only
hardware tables on IPQ5424?

ppe_config_scheduler() in ppe_config.c uses the IPQ9574 tables on every
SoC:

drivers/net/ethernet/qualcomm/ppe/ppe_config.c:ppe_config_scheduler() {
    ...
	count = ARRAY_SIZE(ipq9574_ppe_sch_bm_config);
	bm_cfg = ipq9574_ppe_sch_bm_config;
    ...
	count = ARRAY_SIZE(ipq9574_ppe_sch_qm_config);
	qm_cfg = ipq9574_ppe_sch_qm_config;
    ...
}

ppe_config_bm() also always uses ipq9574_ppe_bm_port_config and the
IPQ9574 group buffer limit.

These tables have entries for PPE ports 4-7 (physical ports 4-6 and the
EIP FIFO), which IPQ5424 does not have. The BM scheduler entries also set
backup_port_valid to false. The only code that checks ppe_dev->num_ports
is the ppe_port_sch_config loop.

At this commit, neither struct ppe_of_data nor struct ppe_device has a
type field or any way to select per-SoC tables. That means IPQ5424 gets
the IPQ9574 BM, QM and TDM scheduler settings. Scheduler slots go to
ports that do not exist, and ports 2-3 get bandwidth shares sized for
IPQ9574.

Later patches in this series fix this. "Add IPQ5424 BM buffer
configuration", "Add IPQ5424 QM configuration", "Add IPQ5424 scheduler
resource configuration" and "Add IPQ5424 scheduler configuration" add a
.type field to the platform data. ppe_config_bm(), ppe_config_qm() and
ppe_config_scheduler() then switch on ppe_dev->type to pick the
ipq5424_* tables.

Could the commit message say that IPQ5424 support is incomplete until
those patches are applied? Alternatively, could the IPQ5424 compatible
be added after them, so a bisect cannot land on a partly configured
IPQ5424 PPE?

>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, qcom_ppe_of_match);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011-qcom_ipq5424_ppe-v2-0-8c7b057e2c43%40oss.qualcomm.com
