Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318558;
	b=bYLKBxGwxhzG5zUszAM1GHF86ia3jHbrBEQ3Lk2f9/CIzH9zir2QJlNL2UVYBMwHKfsQ
	 0yHoBllNM9FtR5EUTTBZvIhGVJ/FfxNMdsacgLabsroL4QvSJgUySlfni+ylCE/XwA5IN
	 LBhFMvvMDamtgvhhbhCVML1/0rYKPghro5DY2gpVn4UVLEW/XALMvOi4/I9nMhPR0CX+y
	 RAbZgSbfKTIY4LtzEsOZHpUCtsugFf6agOCwWIv6bt9s9irLACn8Q4WxyjVqdXhcKKABl
	 K/E0361AFxE3CcoubD6cWBUJfj3HrJ9n0OWXtc99V51yIcwQsEjS+jaU4habkfsaJBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318558;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-ID:CC:From:To:
	 Subject:X-Mailer:References:In-Reply-To;
	bh=WucAi45P7LFqiSe90dwgZKi3069Pbv0dkw7tkGVFfhg=;
	b=lCBs8jSpdZ0tA0+xxBClkBYsxvgojHdCZZ1ADqiw4VFMno+0ua4KJoqVCLW0grxZQu7f
	 jX3Pn/qbRfSCiFSj+NfpszI2EtwGX4Fx++6mxB8LE+DzpTTl4u7k3dOrYcQ6+W0HykiBU
	 9gLvLNb57zka2bEI9WQDFc9QOQTFj9HuoxhfYnlYHBYt0cF19z26Rk0pFSU/5sneA73tl
	 fWLCLVB0zmk0P+PdtJomIld+Alytpa7og7JQs1ZXrld1JNHTJjXQQA8dmLP1hF9Zf4nTR
	 7m7zTT+0k8lPwb7hQVtMDwoobndz4pAoF3UAQLgqUCXkftmdNFuwaoK2pci3AUNyE6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=MmP7E7uD;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF816606A32E;
	Tue, 10 Nov 2026 13:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF816606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=MmP7E7uD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794318558; x=1825854558;
  h=mime-version:content-transfer-encoding:date:message-id:
   cc:from:to:subject:references:in-reply-to;
  bh=4jDqGAE3KXmzi8NszJwL8KHelw3BtEwY4FX/0+qVaEE=;
  b=MmP7E7uDBDQChjWI88OuF4huu/XeibAfLssw0WAEOW960xaEJlgMmQyU
   1x8gUHXCi5Nyj0D8ri+G9mtfid9zGZ1K2e1UvNVkG2Fb5Xn9Dl3SjQW82
   r6mnnDPf7HOSIhmcgnSAg+QeS+dbgji+tb+fYNFiisbRasLJ67yTkAx3J
   yHYoTyfZEk0PI0UPehS2a95wyjBCfIwvVi40D94JTz7I24l7RtUmsw7b9
   6dr0tlRYztY7xMp1MU7ds8ALizmzQPOFgAzZU66deG/UqzssK5n7+04pK
   BGscDPWanGxISRXxnyjEGHHcdIQFWJEsOy1fuv0mn1CHRvRfAjMf4pAea
   g==;
X-CSE-ConnectionGUID: Nm8SpLRoQCKu6bAsD/8N9Q==
X-CSE-MsgGUID: f8n1udbwQq+uOA+ZYLEFBg==
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="66290142"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 06:49:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Tue, 10 Nov 2026 06:49:16 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Tue, 10 Nov 2026 06:49:15 -0700
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 Nov 2026 14:49:14 +0100
Message-ID: <DMRKUCAN92TO.3J516XODSPDH3@microchip.com>
CC: <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <horms@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<woojung.huh@microchip.com>, <linux@armlinux.org.uk>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<geert+renesas@glider.be>, <magnus.damm@gmail.com>, <edumazet@kernel.org>,
	<richardcochran@gmail.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
To: Paolo Abeni <pabeni@redhat.com>, <jensemil.schulzostergaard@microchip.com>
Subject: Re: [PATCH net-next v16 4/4] net: dsa: lan9645x: add basic dsa
 driver for LAN9645X
X-Mailer: aerc 0.21.0
References: <20261103-dsa_lan9645x_switch_driver_base-v16-4-781c96d735cf@microchip.com> <20261110112822.235243-1-pabeni@redhat.com>
In-Reply-To: <20261110112822.235243-1-pabeni@redhat.com>

On Tue Nov 10, 2026 at 12:28 PM CET, Paolo Abeni wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> --- Patch [4]: [PATCH net-next v16 4/4] net: dsa: lan9645x: add basic dsa=
 driver for LAN9645X ---
> commit 2bc50b43f8638df7f8c7d09bfad9a789fecdd370
> Author: Jens Emil Schulz =C3=98stergaard <jensemil.schulzostergaard@micro=
chip.com>
>
> net: dsa: lan9645x: add basic dsa driver for LAN9645X
>
> This adds a basic DSA driver for the LAN9645x switch. It covers switch
> init, named regmap requests from a parent device, NPI, CPU and front
> port setup, and phylink MAC configuration. Only the internal CuPHYs on
> ports 0-4 and RGMII on ports 7-8 are wired up, and the parent MFD
> driver that provides the regmaps is left for a later series.
>
>> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/driver=
s/net/dsa/microchip/lan9645x/lan9645x_main.c
>> new file mode 100644
>> index 0000000000000..f91e825343353
>> --- /dev/null
>> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
>> @@ -0,0 +1,453 @@
>
> [ ... ]
>
>> +static int lan9645x_tag_npi_setup(struct dsa_switch *ds)
>> +{
>> +	struct dsa_port *dp, *first_cpu_dp =3D NULL;
>> +	struct lan9645x *lan9645x =3D ds->priv;
>> +	struct phylink_config c =3D {};
>> +
>> +	dsa_switch_for_each_user_port(dp, ds) {
>> +		if (dp->cpu_dp->ds !=3D ds) {
>> +			dev_err(ds->dev,
>> +				"NPI port on a remote switch is not supported\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +		if (first_cpu_dp && dp->cpu_dp !=3D first_cpu_dp) {
>> +			dev_err(ds->dev, "Multiple NPI ports not supported\n");
>> +			return -EINVAL;
>> +		}
>
> [Severity: Medium]
> [Finding: main-1-1]
> [Sources: opus-5-5]
> Can the "Multiple NPI ports not supported" branch in
> lan9645x_tag_npi_setup() ever be taken?
>
> dsa_tree_setup_cpu_ports() runs before .setup. This driver has no
> preferred_default_local_cpu_port(), so that function gives every local
> user port the first local CPU port:
>
> net/dsa/dsa.c:dsa_tree_setup_cpu_ports() {
>     ...
> 		dsa_switch_for_each_port(dp, cpu_dp->ds) {
> 			/* Prefer the first local CPU port found */
> 			if (dp->cpu_dp)
> 				continue;
>
> 			if (dsa_port_is_user(dp) || dsa_port_is_dsa(dp))
> 				dp->cpu_dp =3D cpu_dp;
> 		}
>     ...
> }
>
> That makes dp->cpu_dp !=3D first_cpu_dp unreachable. A second CPU port in
> DT is accepted without any message, and only the first CPU port goes
> through the phy_interface_empty() check.
>
> If the second CPU port is port 5 or 6, probe would then fail later in
> phylink_create(), and the driver's "Port %d has no usable interface
> mode" message would not be printed. The commit message says:
>
>   "Declared as a CPU port there is no such fallback, and the probe
>   fails, and our driver logs an error including the port number."
>
> If the second CPU port is port 7 or 8, DSA sets it up as a CPU port and
> attaches its conduit, but lan9645x_npi_port_init() is never called for
> it.
>
> Would it work better to count ports with dsa_switch_for_each_cpu_port()
> and reject anything above one?
>

Correct, the check cannot trigger here.

This driver has no tagging protocol change and no port_change_conduit,
so at setup every user port has the first local CPU port, and a second
CPU port in DT is accepted silently.

The next version counts the local CPU ports with
dsa_switch_for_each_cpu_port() and rejects anything but exactly one.

>> +
>> +		first_cpu_dp =3D dp->cpu_dp;
>> +	}
>
> [ ... ]
>
>> +static int lan9645x_reset_switch(struct lan9645x *lan9645x)
>> +{
>> +	u32 val =3D 0;
>> +	int err;
>> +
>> +	/* The parent must reset the whole chip before instantiating its
>> +	 * children, so the switch core is disabled when we get here. The
>> +	 * sequence below must not run more than once: initializing the
>> +	 * memories on a running core corrupts pointers inside the queue
>> +	 * system, which eventually fills up and stops passing traffic. If the
>> +	 * core is already enabled the chip was not reset, so skip it.
>> +	 */
>> +	if (SYS_RESET_CFG_CORE_ENA_GET(lan_rd(lan9645x, SYS_RESET_CFG)))
>> +		return 0;
>
> [Severity: Medium]
> [Finding: fable-5-1-7-9]
> [Sources: fable-5-1, opus-5-5]
> What happens here if the register read fails? lan_rd() discards the
> regmap_read() error and returns 0:
>
> drivers/net/dsa/microchip/lan9645x/lan9645x_main.h:lan_rd() {
> 	u32 addr, val =3D 0;
>     ...
> 	WARN_ON_ONCE(regmap_read(lan_tgt2rmap(lan9645x, t, tinst), addr, &val));
>
> 	return val;
> }
>
> If the read over the parent regmap fails (the intended parent is an SPI
> bridge like ocelot-spi), the result looks the same as CORE_ENA =3D=3D 0. =
The
> RAM_INIT sequence would then run on a core that may already be enabled,
> which the comment above says corrupts the queue system.
>
> lan9645x_set_feat_dis() uses the same pattern:
>
> 	feat_dis =3D lan_rd(lan9645x, GCB_FEAT_DISABLE);
>
> A failed read there gives num_port_dis =3D 0, so the SKU port count check
> in lan9645x_setup() is skipped without any error.
>
> Should these two reads check the regmap_read() return value and fail
> the probe?
>

Dismissed, intentional.

SPI itself has no ack or checksum, so an unresponsive device or a broken
bus can complete the transfer successfully with all zeros or all ones,
and checking the return value of these reads would not catch it.

The parent verifies the register interface when it initializes it, by
reading back the interface configuration, so a device that does not
respond fails the parent probe before the switch is instantiated.

What remains is a transfer error reported by the SPI controller itself,
a host side failure, which lan_rd() reports with WARN_ON_ONCE().

>> +
>> +	lan_wr(SYS_RESET_CFG_CORE_ENA_SET(0), lan9645x, SYS_RESET_CFG);
>> +	lan_wr(SYS_RAM_INIT_RAM_INIT_SET(1), lan9645x, SYS_RAM_INIT);
>
> [ ... ]
>
>> +	/* Setup flooding PGIDs for IPv4/IPv6 multicast. Control and dataplane
>> +	 * use the same masks. Control frames are redirected to CPU, and
>> +	 * the network stack is responsible for forwarding these.
>> +	 * The dataplane is forwarding according to the offloaded MDB entries.
>> +	 */
>> +	lan_wr(ANA_FLOODING_IPMC_FLD_MC4_DATA_SET(PGID_MCIPV4) |
>> +	       ANA_FLOODING_IPMC_FLD_MC4_CTRL_SET(PGID_MC) |
>> +	       ANA_FLOODING_IPMC_FLD_MC6_DATA_SET(PGID_MCIPV6) |
>> +	       ANA_FLOODING_IPMC_FLD_MC6_CTRL_SET(PGID_MC),
>> +	       lan9645x, ANA_FLOODING_IPMC);
>
> [Severity: Low]
> [Finding: fable-5-1-2-5]
> [Sources: fable-5-1]
> This isn't a bug, but this comment in lan9645x_setup() doesn't seem to
> match what the patch does.
>
> lan9645x_switch_ops has no .port_mdb_add or .port_mdb_del. Nothing in
> this patch redirects IGMP/MLD control frames to the CPU either.
>
> The comment also says "Control and dataplane use the same masks", but
> control uses PGID_MC and data uses PGID_MCIPV4 and PGID_MCIPV6. These
> are three separate PGIDs. They only end up with the same value because
> of later writes in lan9645x_setup().
>
> Is this comment left over from the bridge and MDB patches that were
> dropped in v16?
>
> [ ... ]
>
>> +static int lan9645x_request_target_regmaps(struct lan9645x *lan9645x)
>> +{
>> +	const char *resource_name;
>> +	struct regmap *tgt_map;
>> +
>> +	for (int i =3D 0; i < NUM_TARGETS; i++) {
>> +		resource_name =3D lan9645x_resource_names[i];
>> +		if (!resource_name)
>> +			continue;
>> +
>> +		tgt_map =3D dev_get_regmap(lan9645x->dev->parent, resource_name);
>> +		if (IS_ERR_OR_NULL(tgt_map)) {
>> +			dev_err(lan9645x->dev, "Failed to get regmap=3D%s\n",
>> +				resource_name);
>> +			return -ENODEV;
>> +		}
>
> [Severity: Low]
> [Finding: fable-5-1-1-2]
> [Sources: fable-5-1, opus-5-5]
> This isn't a functional bug, but can this driver probe on any in-tree
> configuration?
>
> lan9645x_request_target_regmaps() needs 17 named regmaps from
> dev->parent, and lan9645x_reset_switch() relies on the parent having
> reset the chip. Nothing under drivers/mfd/ registers these regmaps or
> creates a child with the "microchip,lan96455s-switch" compatible.
>
> The commit message says:
>
>   "The MFD driver will come in a later series"
>
> Until that series lands, this driver and the tagger it selects can be
> built but never bound. Would it make sense to merge this together with
> the parent driver?
>
> [ ... ]

