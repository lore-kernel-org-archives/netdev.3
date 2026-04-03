Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08971F3D56;
	Fri,  3 Apr 2026 01:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775179051; cv=none; b=FG5CG5Azx4qEyZFjO/SUs2mzhaHBOqoVFoWeKXO4B7wQgJNh16PS+jJcdZy1+6hTG2Y6PGnk7ZLcJuCSBRV0zt02WnObdDtdalohdxYVmfUvn3cGfL5TZtgfnzt9zkl0VAmM77epN/fnosYVIg/lOngYi/bRXmTaufp7aQtZQnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775179051; c=relaxed/simple;
	bh=z2oeBslkWxXFxUEpEWFwllAfQCf4n0yeC2tozbEVTlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPVcPs+jf3vowD5/eVgYhwV2PkyDM9pDX5x/pZCfRnjDzL6EonxFWAXKXn/jVJRxwrDCd8XdQcJColgYGIkTMLsu8tzv5ZccY2myjBOsboSC3k/Zg04RTFUAOMPnkFt/WAIVNwe8FHEpvrLILc4ILukiysgDaHtdqwLmvDIksxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdV9augW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdV9augW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F30C19423;
	Fri,  3 Apr 2026 01:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775179051;
	bh=z2oeBslkWxXFxUEpEWFwllAfQCf4n0yeC2tozbEVTlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MdV9augW1jHZqVwnMVXugkgpU/OawSUTlXxgNHgItjcvmIUEWW2w4w5xit2HBBHif
	 0fr72BN15tfROcp/toAKBSg3iE65TFpJFCcgkJUUaNiLqsV4WKBJDI9DCEXedvzy49
	 FTgxWeo/a4aqiTElWJ/eegm2i4dVWVTQE1H1yvhkR3wBVxXxKBkQOuNPC/XC/yU+vv
	 LbxdimGIxIU1xU63GXKAh67M9AkUVRJmZa5OIJiisn/mSYglYqNtSwW0QWjlM82RXp
	 xYJe9TtgRr/AmJ3hxt7+XnkZQzPJqiUi6t+IFzrNdoJAoCmx2OSwm3w5oqP4a+TuDy
	 UcQy18A1RR15A==
From: Jakub Kicinski <kuba@kernel.org>
To: wei.fang@nxp.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 net-next 05/14] net: enetc: add support for the "Add" operation to VLAN filter table
Date: Thu,  2 Apr 2026 18:17:29 -0700
Message-ID: <20260403011729.1795413-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331113025.1566878-6-wei.fang@nxp.com>
References: <20260331113025.1566878-6-wei.fang@nxp.com>
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
net: enetc: add support for the "Add" operation to VLAN filter table

This patch adds the ntmp_vft_add_entry() helper function to support adding
entries to the VLAN filter table. It allocates a DMA buffer, formats the
request, and transmits it via the command BD ring using netc_xmit_ntmp_cmd().

> diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
> --- a/drivers/net/ethernet/freescale/enetc/ntmp.c
> +++ b/drivers/net/ethernet/freescale/enetc/ntmp.c

[ ... ]

> @@ -652,5 +655,52 @@ int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
> +int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
> +		       const struct vft_cfge_data *cfge)
> +{
> +	struct ntmp_dma_buf data = {
> +		.dev = user->dev,
> +		.size = sizeof(struct vft_req_ua),
> +	};
> +	struct vft_req_ua *req;
> +	union netc_cbd cbd;
> +	u32 len;
> +	int err;
> +
> +	err = ntmp_alloc_data_mem(&data, (void **)&req);
> +	if (err)
> +		return err;
> +
> +	/* Request data */
> +	ntmp_fill_crd(&req->crd, user->tbl.vft_ver, 0,
> +		      NTMP_GEN_UA_CFGEU);
> +	req->ak.exact.vid = cpu_to_le16(vid);
> +	req->cfge = *cfge;
> +
> +	/* Request header */
> +	len = NTMP_LEN(data.size, NTMP_STATUS_RESP_LEN);
> +	ntmp_fill_request_hdr(&cbd, data.dma, len, NTMP_VFT_ID,
> +			      NTMP_CMD_ADD, NTMP_AM_EXACT_KEY);
> +
> +	err = netc_xmit_ntmp_cmd(user, &cbd);
> +	if (err)
> +		dev_err(user->dev,
> +			"Failed to add %s entry, vid: %u, err: %pe\n",
> +			ntmp_table_name(NTMP_VFT_ID), vid, ERR_PTR(err));
> +
> +	ntmp_free_data_mem(&data);

Does this code safely handle hardware timeouts?

If netc_xmit_ntmp_cmd() times out and returns an error, the pending
transaction is not explicitly aborted before ntmp_free_data_mem()
unconditionally frees the DMA buffer.

Could the hardware eventually process the pending command and perform a
DMA write of the response to the physical address of the freed buffer?

This might lead to silent memory corruption if that memory has already
been reallocated to another subsystem. Would it be safer to explicitly
abort the pending DMA transaction, reset the device on timeout, or
intentionally delay freeing the buffer until it is proven safe?

> +
> +	return err;
> +}
