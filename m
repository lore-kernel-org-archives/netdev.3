Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310122;
	b=yshbSIEOPVvktwrBJP3zzCEDxxt3+Zpu/Gg6qjI72D18Uv4YrqToyoTvVIwo09tkHvcI
	 K9NnaTDrb5C3crb2jdDID9dbnfRR6ssR5srgRS4lscKhiPl5SxdAlpvZnOrtAbSzFjw6S
	 38NWKMZDL8GzOuV2WndljR0EUkDgzheymZjVu9tGO1zsDyb5dn72zWKs7dUnPe6Ngw7mj
	 WLFtnZAptbMSYZXGgXEY36Bi+9TcfBrdWCuObxmeafO/ZhL5MDvB3sQCeSC8QZ5cyhrYT
	 vzuP22JE4iqxE/Q5XCvVQjH/zUWxh8RJ0pgI0HAN7aj39dnH0xwUHIJxUBZNaV1LN4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310122;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=lT9XeouHm2xun5PDGSP7Yyje8lCMCUG86DD7BR3eof4=;
	b=h4noOFZu+QHezujMASm4UHRAq9nu30LltyxsXqtRiPvp/Syp9IkhG4bvnaVAhX19FiFZ
	 cFBRjzqeSLTe1h+IXIjA7xUq6aIlYfpSo0ybteoKdCB1Um+8iuLlGvAjsNn57zmW3MvrH
	 +/uU+ij9MUx8zlh2gLSyvMCSbhwPTvtKN2jkFNwMMGi1eqUDMOUWNKK5jwbz1o8DUZBhJ
	 UhmQuDmUKmD9A0izylK9f4qxRpSAzJ/YIKhpmHgQqyWW7T+ftDgRv2CjXLb5IKbdQM/d6
	 J380PraqJOEPjty9k2IIXDI5RVxDRcCvTkmSJ+apGfYFE3tF18MVpttkOXq6lrCEtcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EBMbPhC1;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF678606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 11:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF678606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EBMbPhC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794310120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lT9XeouHm2xun5PDGSP7Yyje8lCMCUG86DD7BR3eof4=;
	b=EBMbPhC1GzG2kYiX0v4cbuk//IP8m9gUNrgNom8SrKm58MtrA0yjwarRiLX1GnHgDcTRxu
	EttX3PEShspOlMX9Va2etF67p2/s1T8WmY/2D8byzafeSPv8cjc5STlh8FQWrTGm15gcIc
	2NQ9+3DxtOsKYPWxGrx7HT4qaawKs+w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-r0ger4WmN_SN3Nb2RT54qw-1; Tue,
 10 Nov 2026 06:28:38 -0500
X-MC-Unique: r0ger4WmN_SN3Nb2RT54qw-1
X-Mimecast-MFC-AGG-ID: r0ger4WmN_SN3Nb2RT54qw_1794310114
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9824E1955F02;
	Tue, 10 Nov 2026 11:28:33 +0000 (UTC)
Received: from pabeni-thinkpadp1gen8.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ECE793001DA0;
	Tue, 10 Nov 2026 11:28:27 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: jensemil.schulzostergaard@microchip.com
Cc: UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	woojung.huh@microchip.com,
	linux@armlinux.org.uk,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	edumazet@kernel.org,
	richardcochran@gmail.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next v16 4/4] net: dsa: lan9645x: add basic dsa driver for LAN9645X
Date: Tue, 10 Nov 2026 12:28:21 +0100
Message-ID: <20261110112822.235243-1-pabeni@redhat.com>
In-Reply-To: <20261103-dsa_lan9645x_switch_driver_base-v16-4-781c96d735cf@microchip.com>
References: <20261103-dsa_lan9645x_switch_driver_base-v16-4-781c96d735cf@microchip.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
--- Patch [4]: [PATCH net-next v16 4/4] net: dsa: lan9645x: add basic dsa driver for LAN9645X ---
commit 2bc50b43f8638df7f8c7d09bfad9a789fecdd370
Author: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>

net: dsa: lan9645x: add basic dsa driver for LAN9645X

This adds a basic DSA driver for the LAN9645x switch. It covers switch
init, named regmap requests from a parent device, NPI, CPU and front
port setup, and phylink MAC configuration. Only the internal CuPHYs on
ports 0-4 and RGMII on ports 7-8 are wired up, and the parent MFD
driver that provides the regmaps is left for a later series.

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> new file mode 100644
> index 0000000000000..f91e825343353
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> @@ -0,0 +1,453 @@

[ ... ]

> +static int lan9645x_tag_npi_setup(struct dsa_switch *ds)
> +{
> +	struct dsa_port *dp, *first_cpu_dp = NULL;
> +	struct lan9645x *lan9645x = ds->priv;
> +	struct phylink_config c = {};
> +
> +	dsa_switch_for_each_user_port(dp, ds) {
> +		if (dp->cpu_dp->ds != ds) {
> +			dev_err(ds->dev,
> +				"NPI port on a remote switch is not supported\n");
> +			return -EINVAL;
> +		}
> +
> +		if (first_cpu_dp && dp->cpu_dp != first_cpu_dp) {
> +			dev_err(ds->dev, "Multiple NPI ports not supported\n");
> +			return -EINVAL;
> +		}

[Severity: Medium]
[Finding: main-1-1]
[Sources: opus-5-5]
Can the "Multiple NPI ports not supported" branch in
lan9645x_tag_npi_setup() ever be taken?

dsa_tree_setup_cpu_ports() runs before .setup. This driver has no
preferred_default_local_cpu_port(), so that function gives every local
user port the first local CPU port:

net/dsa/dsa.c:dsa_tree_setup_cpu_ports() {
    ...
		dsa_switch_for_each_port(dp, cpu_dp->ds) {
			/* Prefer the first local CPU port found */
			if (dp->cpu_dp)
				continue;

			if (dsa_port_is_user(dp) || dsa_port_is_dsa(dp))
				dp->cpu_dp = cpu_dp;
		}
    ...
}

That makes dp->cpu_dp != first_cpu_dp unreachable. A second CPU port in
DT is accepted without any message, and only the first CPU port goes
through the phy_interface_empty() check.

If the second CPU port is port 5 or 6, probe would then fail later in
phylink_create(), and the driver's "Port %d has no usable interface
mode" message would not be printed. The commit message says:

  "Declared as a CPU port there is no such fallback, and the probe
  fails, and our driver logs an error including the port number."

If the second CPU port is port 7 or 8, DSA sets it up as a CPU port and
attaches its conduit, but lan9645x_npi_port_init() is never called for
it.

Would it work better to count ports with dsa_switch_for_each_cpu_port()
and reject anything above one?

> +
> +		first_cpu_dp = dp->cpu_dp;
> +	}

[ ... ]

> +static int lan9645x_reset_switch(struct lan9645x *lan9645x)
> +{
> +	u32 val = 0;
> +	int err;
> +
> +	/* The parent must reset the whole chip before instantiating its
> +	 * children, so the switch core is disabled when we get here. The
> +	 * sequence below must not run more than once: initializing the
> +	 * memories on a running core corrupts pointers inside the queue
> +	 * system, which eventually fills up and stops passing traffic. If the
> +	 * core is already enabled the chip was not reset, so skip it.
> +	 */
> +	if (SYS_RESET_CFG_CORE_ENA_GET(lan_rd(lan9645x, SYS_RESET_CFG)))
> +		return 0;

[Severity: Medium]
[Finding: fable-5-1-7-9]
[Sources: fable-5-1, opus-5-5]
What happens here if the register read fails? lan_rd() discards the
regmap_read() error and returns 0:

drivers/net/dsa/microchip/lan9645x/lan9645x_main.h:lan_rd() {
	u32 addr, val = 0;
    ...
	WARN_ON_ONCE(regmap_read(lan_tgt2rmap(lan9645x, t, tinst), addr, &val));

	return val;
}

If the read over the parent regmap fails (the intended parent is an SPI
bridge like ocelot-spi), the result looks the same as CORE_ENA == 0. The
RAM_INIT sequence would then run on a core that may already be enabled,
which the comment above says corrupts the queue system.

lan9645x_set_feat_dis() uses the same pattern:

	feat_dis = lan_rd(lan9645x, GCB_FEAT_DISABLE);

A failed read there gives num_port_dis = 0, so the SKU port count check
in lan9645x_setup() is skipped without any error.

Should these two reads check the regmap_read() return value and fail
the probe?

> +
> +	lan_wr(SYS_RESET_CFG_CORE_ENA_SET(0), lan9645x, SYS_RESET_CFG);
> +	lan_wr(SYS_RAM_INIT_RAM_INIT_SET(1), lan9645x, SYS_RAM_INIT);

[ ... ]

> +	/* Setup flooding PGIDs for IPv4/IPv6 multicast. Control and dataplane
> +	 * use the same masks. Control frames are redirected to CPU, and
> +	 * the network stack is responsible for forwarding these.
> +	 * The dataplane is forwarding according to the offloaded MDB entries.
> +	 */
> +	lan_wr(ANA_FLOODING_IPMC_FLD_MC4_DATA_SET(PGID_MCIPV4) |
> +	       ANA_FLOODING_IPMC_FLD_MC4_CTRL_SET(PGID_MC) |
> +	       ANA_FLOODING_IPMC_FLD_MC6_DATA_SET(PGID_MCIPV6) |
> +	       ANA_FLOODING_IPMC_FLD_MC6_CTRL_SET(PGID_MC),
> +	       lan9645x, ANA_FLOODING_IPMC);

[Severity: Low]
[Finding: fable-5-1-2-5]
[Sources: fable-5-1]
This isn't a bug, but this comment in lan9645x_setup() doesn't seem to
match what the patch does.

lan9645x_switch_ops has no .port_mdb_add or .port_mdb_del. Nothing in
this patch redirects IGMP/MLD control frames to the CPU either.

The comment also says "Control and dataplane use the same masks", but
control uses PGID_MC and data uses PGID_MCIPV4 and PGID_MCIPV6. These
are three separate PGIDs. They only end up with the same value because
of later writes in lan9645x_setup().

Is this comment left over from the bridge and MDB patches that were
dropped in v16?

[ ... ]

> +static int lan9645x_request_target_regmaps(struct lan9645x *lan9645x)
> +{
> +	const char *resource_name;
> +	struct regmap *tgt_map;
> +
> +	for (int i = 0; i < NUM_TARGETS; i++) {
> +		resource_name = lan9645x_resource_names[i];
> +		if (!resource_name)
> +			continue;
> +
> +		tgt_map = dev_get_regmap(lan9645x->dev->parent, resource_name);
> +		if (IS_ERR_OR_NULL(tgt_map)) {
> +			dev_err(lan9645x->dev, "Failed to get regmap=%s\n",
> +				resource_name);
> +			return -ENODEV;
> +		}

[Severity: Low]
[Finding: fable-5-1-1-2]
[Sources: fable-5-1, opus-5-5]
This isn't a functional bug, but can this driver probe on any in-tree
configuration?

lan9645x_request_target_regmaps() needs 17 named regmaps from
dev->parent, and lan9645x_reset_switch() relies on the parent having
reset the chip. Nothing under drivers/mfd/ registers these regmaps or
creates a child with the "microchip,lan96455s-switch" compatible.

The commit message says:

  "The MFD driver will come in a later series"

Until that series lands, this driver and the tagger it selects can be
built but never bound. Would it make sense to merge this together with
the parent driver?

[ ... ]
-- 
This is an AI-generated review.

