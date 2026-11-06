Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793951112;
	b=bK/grBDgM8RpwIDpyEa30IyLuxus7WfIHyH7D3K7RmEz6zUYoH7Dzll4lgFKnDS/fw/Z
	 +kmlhpsRCUO2BAOZE1J+ZehHuCkcjzzFbgmdJcn2pfiLHHXZ253y/6TUSE/DvEKWE+Qrg
	 imMrHG+hhISCUugnwju6gXlcu9dKVIYNj7vy26+0BUQX3BsfBHM7tCPi4QZE4d5zyvUS4
	 rfvk1G7HNYYFnYa5fvpfYixrMp9Vq02ZcAdOdJTk5I5PAu+nvnsW5SMMq1FDG7gQGbm0u
	 OM9opypa6QJ8FI8nALsMdJ4Um6fFeARPAfeHGR8H8p7NidVXUe381zSzaYwin0RNT8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793951112;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=OH+KjGflK0pa9S6bl+aaJSvNp7JIv99InYmBasyu8aI=;
	b=PGGN2nyEcJXJbQe+NHIL+L7l530qwZv4HtfO2x4v0QNYMyeJULBqbfvdi+h5FEt35KVr
	 hhECepsbD05qZ9llQUmupCmsM1M1qHndVd3bObMPb4dobLlssE4wuXjFbvy1M/VvpsLYk
	 bSdc8SK8wETOkwMB93qBV0HvU5zTU5++hMId6N0dLI+/YDKcIClmkDOV4av4BZJRlnqYW
	 dMaGpfU/SpFD5+iZsiUvzXLNEyjhue9vYdrOqlhnho537ixjlydgHlXSX/El0b84pigjA
	 520mzbohR4embldmbT54X9JxVi2o5/JincPIa6IB8ACtXl4Sh1pgrc1w4lGGqGXWxog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=oApPi6zS;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C058A606A329;
	Fri,  6 Nov 2026 07:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C058A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=oApPi6zS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793951112; x=1825487112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0pNtQXJqJ7OmmWdT70946/9FrTP+QyhlDpspKue35AI=;
  b=oApPi6zSxO/f6R9cu2mCKbF0US/HrW5GRd3Z2mkxGYaz8xxm1+fVkJUm
   AkvRkPBlNWYmE4S3DY8ZgTnT/HKgIOxpYE31N+bZKWaWnEWxiPfgII6Tp
   Kv9EZyDw0Vd0GiEZdh+Aanrp37I6lSVHHuHl0zHdTo8IOp4cAhmo26fqH
   0v9W0QwYBGkCwpOzc1w1+DjbLOB4BnyFknE4af6v7aQULRg6AWSCKLN4j
   pQGPkSO99UQzqgeV8npGyH6SR1ESBJIVRZ+Ajpcfc2Jn0L93O3HsEvOGQ
   9PztkEmZoEk3idnEXjy00d1QxKf61fPoksO1n1JySWw8LhEzAM9W4rAAS
   A==;
X-CSE-ConnectionGUID: SV658n+RTHylF9Bkh4zsEg==
X-CSE-MsgGUID: nAJ1lYAOTJiyOicUXjomnA==
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="66122530"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Nov 2026 00:45:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 6 Nov 2026 00:45:10 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 6 Nov 2026 00:45:08 -0700
Date: Fri, 6 Nov 2026 08:45:07 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<robert.marko@sartura.hr>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 4/5] net: sparx5: Add hardware programming
 for the port policer
Message-ID: <20261106074507.desq4nbvpio3v3zr@DEN-DL-M70577>
References: <20261105-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v3-0-b45a3a26bed5@microchip.com>
 <20261105-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v3-4-b45a3a26bed5@microchip.com>
 <619a4027-0709-4b13-9367-866a06d2cd02@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <619a4027-0709-4b13-9367-866a06d2cd02@gmail.com>

Hi Mohsin,

Thanks for reviewing.

> 
> 
> > +int sparx5_add_port_policer(struct sparx5_mall_entry *entry,
> > +			    struct netlink_ext_ack *extack)
> > +{
> > +	struct flow_action_police *police = &entry->port_policer.police;
> > +	struct sparx5_port *port = entry->port;
> > +	struct sparx5 *sparx5 = port->sparx5;
> > +	struct sparx5_policer pol = { 0 };
> > +	int idx, err;
> > +
> > +	if (!entry->ingress) {
> > +		NL_SET_ERR_MSG_MOD(extack,
> > +				   "Policer is not supported on egress");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	if (entry->port->tc.ingress_block_shared) {
> > +		NL_SET_ERR_MSG_MOD(extack,
> > +				   "Policer is not supported on shared ingress blocks");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	if (police->exceed.act_id != FLOW_ACTION_DROP) {
> > +		NL_SET_ERR_MSG_MOD(extack,
> > +				   "Policer parameters are not supported");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	if (police->notexceed.act_id != FLOW_ACTION_PIPE &&
> > +	    police->notexceed.act_id != FLOW_ACTION_ACCEPT) {
> > +		NL_SET_ERR_MSG_MOD(extack,
> > +				   "Policer parameters are not supported");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	if (police->peakrate_bytes_ps || police->avrate ||
> > +	    police->overhead) {
> > +		NL_SET_ERR_MSG_MOD(extack,
> > +				   "Policer parameters are not supported");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	if (police->rate_pkt_ps) {
> > +		NL_SET_ERR_MSG_MOD(extack,
> > +				   "Policer parameters are not supported");
> > +		return -EOPNOTSUPP;
> > +	}
> 
> Curious if we can have distinct messages for several unrelated checks
> sharing the extack "Policer parameters are not supported";
> 

So the rationale here is that the checks with their own message are
about where the policer is attached (egress, shared block, another
port, a second policer), or a missing rate, while the shared message
covers police parameters the hardware cannot offload.

> > +
> > +	if (!police->rate_bytes_ps) {
> > +		NL_SET_ERR_MSG_MOD(extack,
> > +				   "Policer requires a rate");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	if (police->burst > ANA_AC_POL_PORT_THRES_CFG_0_PORT_THRES0 *
> > +			    SPX5_POLICER_BYTE_BURST_UNIT) {
> > +		NL_SET_ERR_MSG_MOD(extack,
> > +				   "Policer parameters are not supported");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	if (police->rate_bytes_ps >
> > +	    div_u64((u64)ANA_AC_POL_PORT_RATE_CFG_PORT_RATE *
> > +		    SPX5_POLICER_RATE_UNIT, BITS_PER_BYTE)) {
> > +		NL_SET_ERR_MSG_MOD(extack,
> > +				   "Policer parameters are not supported");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	idx = sparx5_alloc_port_policer_idx(port, entry->cookie);
> > +	if (idx < 0) {
> > +		NL_SET_ERR_MSG_MOD(extack,
> > +				   "Only one port policer per port is supported");
> > +		return idx;
> > +	}
> > +
> 
> Any reason why police->mtu isn't checked? In software, frames longer than
> the police MTU always take the exceed action. Is this intentionally skipped
> here?

Yes, it is intentional. The port policer has no frame length limit of its own,
so it cannot enforce the mtu. It seems to be very common for other drivers to
ignore this too.

> 
> > +	pol.type = SPX5_POL_PORT;
> > +	pol.rate = police->rate_bytes_ps * BITS_PER_BYTE;
> > +	pol.burst = police->burst;
> > +	pol.idx = port->portno * SPX5_POLICERS_PER_PORT + idx;
> > +
> > +	sparx5_init_port_policer_stats(port, idx);
> > +
> > +	err = sparx5_policer_conf_set(sparx5, &pol);
> > +	if (err)
> > +		return err;
> > +
> > +	port->tc.port_policer[idx].policer = entry->cookie;
> > +
> > +	return 0;
> > +}
> > +
>

/Daniel
