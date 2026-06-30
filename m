Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BD8248F64
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 01:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782783861; cv=none; b=AuMIffGKdKpycINkj6M+dodYQpO4rBuQHzS4dKfAtSgavoJ8Ga71ionNOj5qsNIHNf28J4geQcet9sNfgJZhI+ZGByL9i0Gf0+QhMGpuof6aJLXqiAx03saCmw4UFRGUQ5EtTLvM4jGvGvWMg50+5Xq4IjAcM1DQaI5lE1GJzIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782783861; c=relaxed/simple;
	bh=Vvt/56gy8G8/h1bEPGg954eTCgoQLln1hfdkZhLsSDY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YhVmUsBhdLxkQZmro9R6juWMUKRdMsyNdMee+Mlt3tDVuNgn1PHsItWobu+IRpZzyupCdPmCINGvSoDevi7dSY3OkVG6n1anBeJ9vJYuMI/rkEbOPHfzQSGUcB3kI5WifbtYs41r5OxlG0gr1+GVQw0SpZuBmiEoUNPRz795/BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZosgIJpp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZosgIJpp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E741F00A3A;
	Tue, 30 Jun 2026 01:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782783858;
	bh=oZjMZHJiDHz+w25IYGC9p7Z1RAZDQsxO1VxwuLW+Q/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZosgIJppFsBMcY3e+7NAQHjC+byOxDD3kbLJRZmLnPkm25SXNrQW8rtZG83Bcro3B
	 gDNJXe8FHUf0pW4nShsUD+kwiiDK7DyzOKSVJLIoXukHNI3F6sPXH6WB6J07mh8s7v
	 34lCaQH0H3YZ/G/Ds+R3rBotkLgdQbmOn6XEYkP6V5L6sNRINLGD1FdbbZwF0E6hR+
	 9aci6RZLjjHYIrQcCGo0SN7LfpPbdnFiymzOHhLb4RgqVpw9lFF1JSYwlF5R/j2Yvz
	 1j516NDX5enOEW4ZwZ/wmzVa5beP779Pk+jMe02KbRVMKm2aicFEVFoz3QHBmydUvz
	 oSp0icNVAFPcw==
Date: Mon, 29 Jun 2026 18:44:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Harsha M <h.mahadeva@chelsio.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com
Subject: Re: [PATCH net v1] cxgb4: flower: fix 802.1ad VLAN TPID matching in
 tc flower filters
Message-ID: <20260629184417.31b21223@kernel.org>
In-Reply-To: <20260626134848.91281-1-h.mahadeva@chelsio.com>
References: <20260626134848.91281-1-h.mahadeva@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jun 2026 19:18:22 +0530 Harsha M wrote:
> +		if (be16_to_cpu(match.key->vlan_tpid) == ETH_P_8021AD) {

nit: put the byteswap on the constant to let the compiler do it a build
time

> +			struct adapter *adap = netdev2adap(dev);
> +			u32 ovlan_reg, ctl_reg, val, port_id;
> +
> +			if (!adap) {
> +				netdev_err(dev, "%s: adap not found\n", __func__);
> +				return;
> +			}
> +
> +			val = (be16_to_cpu(match.mask->vlan_tpid) << 16) |

Looks like this is changing a per-port register. Presumably the mask
must be the same for all filters. Why not enforce that mask is ~0 and
program a constant?

> +			      be16_to_cpu(match.key->vlan_tpid);

you compared tpid to ETH_P_8021AD above, why not use the constant?

> +			port_id = netdev2pinfo(dev)->port_id;
> +			fs->val.ovlan = vlan_tci;
> +			fs->mask.ovlan = vlan_tci_mask;
> +			fs->val.ovlan_vld = 1;
> +			fs->mask.ovlan_vld = 1;
> +			ovlan_reg = PORT_REG(port_id, MPS_PORT_RX_OVLAN0_A);
> +			ctl_reg = PORT_REG(port_id, MPS_PORT_RX_CTL_A);
> +			t4_write_reg(adap, ovlan_reg, val);
> +			val = t4_read_reg(adap, ctl_reg);
> +			t4_write_reg(adap, ctl_reg, val | 1);
> +			t4_tp_wr_bits_indirect(adap, TP_INGRESS_CONFIG_A, 1U << 9, 0);
-- 
pw-bot: cr
