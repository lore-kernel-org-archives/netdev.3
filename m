Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74C4390990;
	Thu,  1 Oct 2026 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860118; cv=none; b=lWyh4Pd6JUPtBikXa6ZoRsImryn02DLjbVtSWOzZYJ7qRubOOI/H8+iWlYeIw9nE9x2y5VU7NkHJ0FCfLG0Uf7f24qf+VZFNhLdEkQTBmQ6PNp9LyvGlJG7VYmjEmqY5wjmw4Pby67c/ijrsfsruxlUzYvgkdX8PdX5WbaA3PSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860118; c=relaxed/simple;
	bh=fTlqf4+Nyn/tQifC+mapDA49GrW+K19DIT4rCvwmEcY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=EHi815VPFGx2lWqvWXsgbIWR/D2HPpivZSysVPum+ldIHKppPYg8PDA6t9at43K3+ujw0gZRP3rHG05aEjqlfXxqtQwIv2Tb8QrBqo+bdjrefrxJufIUxDG+xERqaBIR8G9uvtJOUDexzwAGCX08QB0LQO8pr0mgS624OqXGvco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=NRDodHou; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="NRDodHou"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=qKhmJehNUYRYx1PbfKrOg6rwivt8H45FEIfR8M1LL9M=; b=NRDodHouWbTHTH1lS2IXbNGwsX
	GsseNe2ArsEbPHVlLL0KPbw4RjvYCRt9y/P9uB+oUjZEBoL/LSVV9Oog1C8xF9zVWZbnv1n+0PgSJ
	EhAry1oMdMLssIahXJtNolHPfZuBRjYhy2GWX5sBP7x7TJvx3E6RBooy5I88PWMV+pkBRXAENibSQ
	qpmU5v+FrWsfNvYZ5nWc/sxVKz5oy2rdt0PKm3tBv1bx3jym8+0lWY++xe+yziFzM0xKLdZecodug
	ZTO1d0sSEsjqVzM2EAFEtxB8/YGIMNvPL2sFvznoR/EIfi9qSG+qDxKPne4FSiQwIBR0XGF35fNa6
	MVtFBcvw==;
Received: from [115.246.246.98] (port=23256 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <parvathi@couthit.com>)
	id 1xCGWX-00000000ukE-16ek;
	Thu, 01 Oct 2026 09:08:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 11C5A1A08940;
	Thu,  1 Oct 2026 18:38:30 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 0A6KcLy0QPv6; Thu,  1 Oct 2026 18:38:27 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 84DC41A0893B;
	Thu,  1 Oct 2026 18:38:27 +0530 (IST)
X-Virus-Scanned: amavis at couthit.local
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 2GSBdOmHC8Qa; Thu,  1 Oct 2026 18:38:27 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 6A9A11A08940;
	Thu,  1 Oct 2026 18:38:27 +0530 (IST)
Date: Thu, 1 Oct 2026 18:38:27 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Simon Horman <horms@kernel.org>
Cc: parvathi <parvathi@couthit.com>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	kuba <kuba@kernel.org>, pabeni <pabeni@redhat.com>, 
	danishanwar <danishanwar@ti.com>, rogerq <rogerq@kernel.org>, 
	pmohan <pmohan@couthit.com>, afd <afd@ti.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	haokexin <haokexin@gmail.com>, basharath <basharath@couthit.com>, 
	arnd <arnd@arndb.de>, linux-kernel <linux-kernel@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	pratheesh <pratheesh@ti.com>, j-rameshbabu <j-rameshbabu@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	m-malladi <m-malladi@ti.com>, krishna <krishna@couthit.com>, 
	mohan <mohan@couthit.com>
Message-ID: <1971584479.492761.1790860107401.JavaMail.zimbra@couthit.local>
In-Reply-To: <20260925163933.721156-1-horms@kernel.org>
References: <20260921134343.200426-3-parvathi@couthit.com> <20260925163933.721156-1-horms@kernel.org>
Subject: Re: [PATCH net-next v4 2/3] net: ti: icssm-prueth: Add priority
 based RX IRQ handlers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 9.0.0_ZEXTRAS_20240927 (ZimbraWebClient - GC150 (Linux)/9.0.0_ZEXTRAS_20240927)
Thread-Topic: icssm-prueth: Add priority based RX IRQ handlers
Thread-Index: r7YacLUCuq2B8SnZ+oxSYk80WSasIA==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: smtp@couthit.com
X-Authenticated-Sender: server.couthit.com: smtp@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi,

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at:
> https://sashiko.dev/#/patchset/20260921134343.200426-4-parvathi@couthit.c=
om?part=3D2
> ---
> Subject: net: ti: icssm-prueth: Add priority based RX IRQ handlers
>=20
> This commit adds support for priority-based interrupt handling for the ST=
P/RSTP
> Switch, HSR, and PRP protocols to address port dominance. It records an I=
EP
> hardware timestamp into the receive buffer to guarantee frames are delive=
red in
> wire-arrival order. The patch also converts statistics counters to atomic=
64_t
> and adds a firmware revision field to support different timestamp wraparo=
und
> behaviors.
>=20
>> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> index 6c8888d9d66a6..4a37935b8d352 100644
>> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> [ ... ]
>> @@ -1071,11 +1083,25 @@ static int icssm_emac_ndo_open(struct net_device=
 *ndev)
>>  =09=09=09goto iep_exit;
>>  =09}
>> =20
>> -=09ret =3D icssm_emac_request_irqs(emac);
>> -=09if (ret)
>> -=09=09goto rproc_shutdown;
>> +=09if (PRUETH_IS_EMAC(prueth)) {
>> +=09=09napi_enable(&emac->napi);
>> +=09} else {
>> +=09=09if (!prueth->emac_configured &&
>> +=09=09    (PRUETH_IS_SWITCH(prueth) || prueth_is_lre(prueth))) {
>> +=09=09=09napi_enable(&prueth->napi_hpq);
>> +=09=09=09napi_enable(&prueth->napi_lpq);
>=20
> [Severity: High]
> Does this code risk a NULL pointer dereference?
>=20
> If MII0 is missing (e.g., absent from the device tree), the shared NAPI
> structures napi_hpq and napi_lpq are not initialized in
> icssm_prueth_netdev_init(). If the MII1 interface is later placed into SW=
ITCH
> mode and brought up, it appears icssm_emac_ndo_open() will unconditionall=
y call
> napi_enable() on these zero-initialized structures, causing a NULL pointe=
r
> dereference on n->dev.
>=20

No, this condition will never occur. The shared NAPIs are used only in SWIT=
CH/HSR/PRP
modes, and the driver switches to those modes only when both MII0 and MII1 =
are members
of the same bridge/HSR device. If MII0 is absent from the DT, its netdev is=
 never
created, so it can never join a bridge/HSR device and the both-ports condit=
ion is never
met. The device therefore always stays in EMAC mode, and icssm_emac_ndo_ope=
n() enables
only the per-port emac->napi, which is always initialized.

>> +=09=09}
>> +=09}
> [ ... ]
>> @@ -1780,9 +1820,25 @@ static int icssm_prueth_netdev_init(struct prueth
>> *prueth,
>> =20
>>  =09netif_napi_add(ndev, &emac->napi, icssm_emac_napi_poll);
>> =20
>> +=09if ((prueth->support_lre || fw_data->support_switch) &&
>> +=09    emac->port_id =3D=3D PRUETH_PORT_MII0) {
>> +=09=09netif_napi_add(ndev, &prueth->napi_hpq,
>> +=09=09=09       icssm_prueth_common_napi_poll_hpq);
>> +=09=09netif_napi_add(ndev, &prueth->napi_lpq,
>> +=09=09=09       icssm_prueth_common_napi_poll_lpq);
>> +=09}
>> +
>>  =09hrtimer_setup(&emac->tx_hrtimer, &icssm_emac_tx_timer_callback,
>>  =09=09      CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
>> =20
>> +=09if ((prueth->support_lre || fw_data->support_switch) &&
>> +=09    emac->port_id =3D=3D PRUETH_PORT_MII0) {
>> +=09=09prueth->hp->ndev =3D ndev;
>> +=09=09prueth->hp->priority =3D 0;
>> +=09=09prueth->lp->ndev =3D ndev;
>> +=09=09prueth->lp->priority =3D 1;
>> +=09}
>> +
>>  =09return 0;
> [ ... ]
>> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
>> b/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
>> new file mode 100644
>> index 0000000000000..9b7b876240b5f
>> --- /dev/null
>> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
> [ ... ]
>> +static irqreturn_t icssm_prueth_common_emac_rx_hardirq(int irq, void *d=
ev_id)
>> +{
>> +=09struct prueth_ndev_priority *ndev_prio;
>> +=09struct prueth_emac *emac;
>> +=09struct net_device *ndev;
>> +=09struct prueth *prueth;
>> +
>> +=09ndev_prio =3D (struct prueth_ndev_priority *)dev_id;
>> +=09ndev =3D ndev_prio->ndev;
>=20
> [Severity: High]
> Similarly, can this IRQ handler dereference an uninitialized pointer?
>=20
> If MII0 is missing and these priority structures were skipped during
> initialization, it looks like the registered IRQ handler will dereference=
 the
> zero-initialized ndev_prio->ndev here when an interrupt occurs.
>=20

Same as above. This handler is registered only by icssm_prueth_common_reque=
st_irqs(),
which is called only in SWITCH/HSR/PRP modes. In EMAC mode, each port uses =
its own
RX IRQ and handler through icssm_emac_request_irqs(). Since the device alwa=
ys
stays in EMAC mode when MII0 is absent, this handler is never registered an=
d never
runs with a zeroed ndev_prio=E2=86=92ndev.

>> +=09emac =3D netdev_priv(ndev);
>> +=09prueth =3D emac->prueth;
>=20
> [Severity: Medium]
> This is a pre-existing issue, but can the transmission path read out of b=
ounds?
>=20
> In drivers/net/ethernet/ti/icssm/icssm_prueth.c:icssm_prueth_get_tx_queue=
_id():
>=20
>    err =3D vlan_get_tag(skb, &vlan_tci);
>=20
> icssm_emac_ndo_start_xmit() calls icssm_prueth_get_tx_queue_id() before
> validating the length of the transmitted skb or padding it. Because the d=
evice
> lacks NETIF_F_HW_VLAN_CTAG_TX, vlan_get_tag() falls back to __vlan_get_ta=
g(),
> which reads the VLAN TCI at offset 14. If a raw socket transmits a packet
> smaller than 18 bytes (e.g., exactly 14 bytes) with h_vlan_proto =3D=3D
> ETH_P_8021Q, this reads unallocated memory past the buffer.


As this is a pre-existing issue related to the TX path VLAN tag check in
icssm_prueth_get_tx_queue_id(), we will address it separately in a differen=
t series.

Thanks and Regards,
Parvathi.
