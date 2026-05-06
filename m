Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DC927EC7C;
	Wed,  6 May 2026 01:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778031980; cv=none; b=WKYr2fuk5R8uVjf0x4VamfyfpWwNcfJYvqQzkSoykArBt1fIqwo8R5RAtZ+WO2OQcDxbOYA05LTQKz1MRrESqiwAY5ypegtB63wqcVk8ddLD01JpZO9a00k85rLWFXYYei/QSqwsxptIf11gvOBrMHkLM1DTIIQQ0OjtCkF+OWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778031980; c=relaxed/simple;
	bh=ZLOiDvZ7qnes+s24C7ROdE31FjmztxsFrFSBewYxFeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMi71F6ZttpWnG5nipxVKsRFvEpjR+QOWaMOxqJwb3YjFwutVBiZbGLzFOLB0cpok8REjQGthiRCHcode9GzDBwb/Y6uIZIo6aI7alBxravqu4ahwwRqJmwQsT9M6rj8wHcggCTd/+ZF42jUR9gIRj3qxPF66TyNFTfMXyYZX04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxF6xJks; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxF6xJks"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BA8C2BCB4;
	Wed,  6 May 2026 01:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778031978;
	bh=ZLOiDvZ7qnes+s24C7ROdE31FjmztxsFrFSBewYxFeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WxF6xJksyJfEVFTE/o865vqOQ23m4jbNzPSKRPY0foHXb6VARbCsGsYdbP7nIjGhl
	 usfsd1+nH1NjYUP+bYVCitCCAsrgwkOH0Bn2T9LdPDimnc7bSRSuSpqeMVdyEcaqrf
	 KloNWMm3N9IqclZu481gc3C6vMrKFWvv5x9k61L/YfTL4YZ1A9JabB4/OWkpUpmpHD
	 LEfyNjVUzTMbZ0/6bKY+Ivy2zV7kPyvAMK7d7xfsNMwEw4zJBJwSyD9NRlKrhwsan6
	 vW+M2YA+jcUh2XblTDxApDzw1VnzRZEX5dTyWouv4PWFnJutKDOPZO6M1Ia1pArw7a
	 L+1ZwQs2GXiLA==
From: Jakub Kicinski <kuba@kernel.org>
To: jensemil.schulzostergaard@microchip.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	woojung.huh@microchip.com,
	linux@armlinux.org.uk,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 8/9] net: dsa: lan9645x: add mdb management
Date: Tue,  5 May 2026 18:46:16 -0700
Message-ID: <20260506014616.1616843-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430-dsa_lan9645x_switch_driver_base-v4-8-f1b6005fa8b7@microchip.com>
References: <20260430-dsa_lan9645x_switch_driver_base-v4-8-f1b6005fa8b7@microchip.com>
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
net: dsa: lan9645x: add mdb management

This change adds DSA mdb callbacks for lan9645x, with distinct handling
for L2 multicast (PGID-backed) and IP multicast (port mask inline in
the mac table).

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> index b21e1bf25b0c..15a493c1f215 100644
> --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> @@ -70,6 +70,7 @@ static void lan9645x_teardown(struct dsa_switch *ds)
>  	destroy_workqueue(lan9645x->owq);
>  	lan9645x_npi_port_deinit(lan9645x, lan9645x->npi);
>  	lan9645x_mac_deinit(lan9645x);
> +	lan9645x_mdb_deinit(lan9645x);
>  	mutex_destroy(&lan9645x->fwd_domain_lock);
>  }
>  
> @@ -141,6 +142,7 @@ static int lan9645x_setup(struct dsa_switch *ds)
>  	if (err)
>  		return err;
>  	lan9645x_mac_init(lan9645x);
> +	lan9645x_mdb_init(lan9645x);

Is lan9645x_mdb_deinit() reachable when lan9645x_setup() fails after
this point?

lan9645x_setup() continues after lan9645x_mdb_init() with operations
that can fail, including alloc_ordered_workqueue() near the bottom of
the function which returns -ENOMEM. On error from ds->ops->setup(),
dsa_switch_setup() in net/dsa/dsa.c jumps directly to the notifier
cleanup path and does not invoke ds->ops->teardown:

	err = ds->ops->setup(ds);
	if (err < 0)
		goto unregister_notifier;

Since lan9645x_teardown() is where lan9645x_mdb_deinit() runs,
the freshly initialized mdb_lock (and its lockdep map) is never
torn down if setup fails after lan9645x_mdb_init().

Could lan9645x_mdb_init() be moved later in setup (after the steps
that can still fail), or could setup-time error unwinding be added
for mdb_lock, mact_lock and fwd_domain_lock? The same pattern exists
for mact_lock (from lan9645x_mac_init()) and fwd_domain_lock, and this
change adds mdb_lock to the same class of resources.

>  
>  	/* Link Aggregation Mode: NETDEV_LAG_HASH_L2 */
>  	lan_wr(ANA_AGGR_CFG_AC_SMAC_ENA |

[ ... ]

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
> index 661cd00465e2..5dee92940f89 100644
> --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
> @@ -189,6 +189,14 @@ int lan9645x_port_setup(struct dsa_switch *ds, int port)
>  		ANA_PORT_CFG_PORTID_VAL,
>  		lan9645x, ANA_PORT_CFG(p->chip_port));
>  
> +	lan_rmw(ANA_CPU_FWD_CFG_IGMP_REDIR_ENA_SET(true) |
> +		ANA_CPU_FWD_CFG_MLD_REDIR_ENA_SET(true) |
> +		ANA_CPU_FWD_CFG_IPMC_CTRL_COPY_ENA_SET(true),
> +		ANA_CPU_FWD_CFG_IGMP_REDIR_ENA |
> +		ANA_CPU_FWD_CFG_MLD_REDIR_ENA |
> +		ANA_CPU_FWD_CFG_IPMC_CTRL_COPY_ENA,
> +		lan9645x, ANA_CPU_FWD_CFG(p->chip_port));
> +

Should this block be guarded for the NPI (CPU-facing) port?

The IGMP/MLD redirect and IPMC control-copy bits are enabled here for
every chip_port that lan9645x_port_setup() is called on, with no
check for whether the port is the NPI. The VLAN host-mode call a few
lines below explicitly excludes the NPI:

	if (p->chip_port != lan9645x->npi)
		lan9645x_vlan_set_hostmode(p);

In the related driver for the same family, drivers/net/ethernet/mscc/
ocelot_net.c, ocelot_port_attr_mc_set() toggles these same bits only
on user ports in response to SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED.

Can CPU-injected IGMP/MLD/IPMC-control frames end up being redirected
or copied back to the CPU with this configuration, or does IFH_BYPASS=1
fully suppress these classifiers on NPI ingress? If the latter, the
bits on the NPI are at least wasteful; if the former, duplicate
delivery or a trap loop seems possible.

>  	if (p->chip_port != lan9645x->npi)
>  		lan9645x_vlan_set_hostmode(p);
>
