Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031284A8FE6;
	Mon, 12 Oct 2026 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819718; cv=none; b=Go2ooYr8zlozYHTyUE6m8z/i8svV6SKkP9N9szoXGsYHTzolrq/iHzWe9G1CeNIlfGFyoyxC1vrQ9UMgoXyt76j4T4yi/5/oA4JcKweNcqmxGbLCEseciRShzGy40bV0y0KRDtXNmRAV8qqp2IjBDvahMgg0IoQBhpVa2pnPQ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819718; c=relaxed/simple;
	bh=dH2iRzUEs06/K2F8s2qWf7X18rw1d3WbzKm7DvvtJoM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zbx94s/MsunRhMfeeuHUfXdWH/oJ7oUTlX/yT3gfV6+cHsWEvk9J4hUahVIESRX1YK4Izr12/io+waWUFjl3vuk50gQ8zxEazkuTA0+Rx3cuVRG9Pfgr+vRiMHEVF7C3dkRLqHVqQ6xkrQcjoESDke6oWNdg5Ap/o1V9nK6pM8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCdfnKme; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCdfnKme"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A684D1F0089C;
	Mon, 12 Oct 2026 15:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819716;
	bh=RHlg+EfPJHOO/fgU1HEhgMSGvdNalYaXSB7c7H8S7ew=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UCdfnKmeDKe1pKhkQkT6ZiAspgKNGO1pDz+XC3wM1ZXRurRNRQSJnnb7r3tC52ATv
	 Y0yZT+6t8WHxp9kM684SM5LtZ8qvDFhpjHcWhp7rpzkhpPIpWDQRL9VbTSoVNQedSz
	 WElUTZYyTD9RWD5PSngtOKvtQsgSdppBls2JNPwTxiLHnPHjEFwaOCr/MEC2BWxLOv
	 qHx5YvMKzWqGThasYzffPbtUoG9N6XSx2l7iFx+69Bc/quW6nIBihFlcfEjrxKP+NW
	 FhYt04sVhLrmwt+Tx26HBD2uolr0ftYCDFvL+fHdRZcURuiAlLivuEabHo6JKWoMDR
	 xZsLciBXkiO0A==
Subject: Re: [PATCH net-next 05/11] net: ethernet: qualcomm: ppe: Add platform
 support for IPQ5424
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
Date: Mon, 12 Oct 2026 15:41:55 +0000
Message-ID: <179181971523.434549.1300369159235274267@kernel.org>
In-Reply-To: <20261008-qcom_ipq5424_ppe-v1-5-16caf43e44ee@oss.qualcomm.com>
References: <20261008-qcom_ipq5424_ppe-v1-5-16caf43e44ee@oss.qualcomm.com>
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

- [Low] In commit "net: ethernet: qualcomm: ppe: Add platform support for
  IPQ5424", the qcom,ipq5424-ppe compatible is enabled before any per-…
- [Low] At commit "net: ethernet: qualcomm: ppe: Add platform support for
  IPQ5424", ppe_port_resource_get() in…

--

net: ethernet: qualcomm: ppe: Add platform support for IPQ5424

This commit adds struct ppe_of_data to the PPE driver. It holds the
per-SoC clock rate, port count, regmap access tables and interconnect
paths. The commit also adds the qcom,ipq5424-ppe compatible.

> diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
> index 3c301e609d3e3..f71b673b6f978 100644
> --- a/drivers/net/ethernet/qualcomm/ppe/ppe.c
> +++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c

[ ... ]

> @@ -218,8 +301,25 @@ static void qcom_ppe_remove(struct platform_device *pdev)
>  	ppe_debugfs_teardown(ppe_dev);
>  }
>  

[ ... ]

> +static const struct ppe_of_data ipq5424_data = {
> +	.ppe_rate = IPQ5424_PPE_CLK_RATE,
> +	.num_ports = IPQ5424_PPE_PORT_MAX,

[Severity: Low]
At this commit num_ports is 4. With that value, does ppe_port_resource_get()
in ppe_config.c still return the reserved resource when asked for it?

The function still indexes the single IPQ9574 table, where the reserved
entry sits at fixed index 8:

drivers/net/ethernet/qualcomm/ppe/ppe_config.c:ppe_port_resource_get() {
    ...
	if (port > ppe_dev->num_ports)
		return -EINVAL;

	res = ppe_scheduler_res[port];
    ...
}

On IPQ5424, a request with port == num_ports (4) would get the queue and
node ranges of IPQ9574 physical port 4 instead of the reserved entry.
Index 8 can no longer be reached.

No in-tree caller passes port == num_ports at this commit.
ppe_queue_dest_init() iterates port_id < num_ports, and
ppe_queues_to_ring_init() uses port 0.

A later patch in this series, "net: ethernet: qualcomm: ppe: Add IPQ5424
scheduler resource configuration", fixes this. It adds
ipq5424_ppe_scheduler_res[] with the reserved entry last, at index 4. It
also makes ppe_port_resource_get() pick the table per SoC and check
port >= scheduler_res_len.

Could that change come before this one in the series?

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
Is it safe to enable the qcom,ipq5424-ppe compatible before ppe_config.c
can tell the two SoCs apart?

At this commit neither struct ppe_of_data nor struct ppe_device has a type
field. So on IPQ5424, ppe_hw_config() still programs the IPQ9574-only
tables:

ppe_config_bm():
	port_cfg = ipq9574_ppe_bm_port_config;

ppe_config_qm():
	queue_cfg = ipq9574_ppe_qm_queue_config;

ppe_config_scheduler():
	bm_cfg = ipq9574_ppe_sch_bm_config;
	...
	qm_cfg = ipq9574_ppe_sch_qm_config;

The scheduler tables give BM/QM arbitration slots to PPE ports 4-7. Those
ports don't exist on IPQ5424, and none of the slots has a backup port.

The BM port thresholds also cover the missing MAC3-5 and EIP ports. The
queue config includes multicast queues 284-299, which IPQ5424 doesn't
have.

Three later patches in this series fix this by adding
switch (ppe_dev->type) with IPQ5424_PPE cases:

  "net: ethernet: qualcomm: ppe: Add IPQ5424 BM buffer configuration"
  "net: ethernet: qualcomm: ppe: Add IPQ5424 QM configuration"
  "net: ethernet: qualcomm: ppe: Add IPQ5424 scheduler configuration"

Could the IPQ5424 compatible be added after those patches? Then a bisect
that lands on this commit wouldn't probe IPQ5424 with the IPQ9574
configuration.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008-qcom_ipq5424_ppe-v1-0-16caf43e44ee%40oss.qualcomm.com
