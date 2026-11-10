Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794345984;
	b=bTZR0R/WmKZkC1+fgMs637qNHlD434IyGTuaJY+7XtSPqt5gSMXwBM/Si+yqLJ9opm9B
	 M5RNc8Fjdc6GwBwrfBJkzyewMMAF70y+6jewEeK1ApOagCnZS4TwXG3OmLyNUxANIExbX
	 Gs0tj/z7+LcRY2mE9XZUUOZY0exFmFamUN9NQz2n1JoKiUHmhsHYMfsf8vaReMc6HDKr/
	 agLP7jGKih7ii9q9yeh+2pkGjlWVfRnVbBvUqeWvkVoM61UdRvFk46hvwuDcDaRqghZoq
	 /sldhIw+CgsAhTleuAIvLlJcB2jrHJBfO6IYMWGW8SNMAeETjnu/KScTRgr55z9QUKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794345984;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=elJEGniw8cEJtzpkd97Q8eZqRe+d4waTPyywaEqRiGk=;
	b=Hjcx25pmcaWzoE9hl0wf1w4b8L4J2NjBoMLUfnctzZNPNKBbUpSZ6ePdzMj3p+in4msP
	 d1lq1EyL46wiDuSGB48Gdt8gwNrLqjGqYY+m61piF3SE25PaUjQZ6/2FC+lCeZNMurHy1
	 JAgXDVhsTmcpaMctYDOECEM97UsajnGPiiS7V+nTuea8gejGoY12t5SmpGvkS76U2lYsz
	 jCGOe1lD+jVIhGabsvPViusVrkGhbyNKU/Hw+FY+m5JeXQtvAu5hXGgplqgUjQA8ajDbM
	 iI8cp66/pn1L8sV1LRyQ/HGvLzW4ExDAvQBSmg0+sK0wWWSbkJitBvIay37c6Rx0TTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pb247x3h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A87606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 21:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pb247x3h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4001F0089F;
	Tue, 10 Nov 2026 21:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794345983;
	bh=elJEGniw8cEJtzpkd97Q8eZqRe+d4waTPyywaEqRiGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pb247x3hBIoJqL+1D1ws6EHQLZlr3CbpjSxsI/Imtw1X0GT/wZimXmUXNee35vq6f
	 vIQP+ZMTcM2Xw1GeinJBT56gmNH6WRKl3r0QjHPjQ434ajBLyit4r04NhkhV9pkQXM
	 dHYNxngTAnE5t2O4y90+D5Zl7YoY4A/CMbxXB6kWRnLf7wIgQfCm/dBO4DyxT86Gu4
	 1L0kmOrunnFcDorLdVHE+1K6XDmhYZpD7rbep4gycUbl8G++KbkDX+3pXiWHRuJIE7
	 mgHco3bdkFtdOSV4Ax6cLtnxee4PT3cElYZZBs6qT36w/Qyjs3wyQghO0YCeDuBBTr
	 QzO9RwU08rUJA==
From: Jakub Kicinski <kuba@kernel.org>
To: eric.joyner@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	brett.creeley@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	nikhil.rao@amd.com,
	edumazet@kernel.org
Subject: Re: [PATCH net-next v3 2/5] ionic: report the configured FEC mode in ethtool_fecparam.fec
Date: Tue, 10 Nov 2026 13:26:21 -0800
Message-ID: <20261110212621.2294782-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104-ionic-get-fec-stats-v3-2-b261fd53d0a7@amd.com>
References: <20261104-ionic-get-fec-stats-v3-2-b261fd53d0a7@amd.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ionic: report the configured FEC mode in ethtool_fecparam.fec

This patch changes ionic_get_fecparam() so that fec->fec reports only the
configured FEC mode from config.fec_type. Before, it reported the constant
Off | RS | BaseR. The commit message says supported modes are already
reported through ETHTOOL_GLINKSETTINGS by ionic_get_link_ksettings().

> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> index 119ac720c0787..317dbf96964ef 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> @@ -427,17 +427,18 @@ static int ionic_get_fecparam(struct net_device *netdev,
>  	switch (lif->ionic->idev.port_info->config.fec_type) {
>  	case IONIC_PORT_FEC_TYPE_NONE:
>  		fec->active_fec = ETHTOOL_FEC_OFF;
> +		fec->fec = ETHTOOL_FEC_OFF;
>  		break;

[ ... ]

> -	fec->fec = ETHTOOL_FEC_OFF | ETHTOOL_FEC_RS | ETHTOOL_FEC_BASER;
> -
>  	return 0;
>  }

[Severity: Medium]
With this line removed, does any ethtool interface still report FEC off as
an available mode on ionic?

The commit message says:

  Supported modes belong in ETHTOOL_GLINKSETTINGS, which
  ionic_get_link_ksettings() already fills.

But ionic_get_link_ksettings() only adds BaseR and RS to supported. It
never sets FEC_NONE:

drivers/net/ethernet/pensando/ionic/ionic_ethtool.c:ionic_get_link_ksettings() {
    ...
	ethtool_link_ksettings_add_link_mode(ks, supported, FEC_BASER);
	ethtool_link_ksettings_add_link_mode(ks, supported, FEC_RS);
	if (idev->port_info->config.fec_type == IONIC_PORT_FEC_TYPE_FC)
		ethtool_link_ksettings_add_link_mode(ks, advertising, FEC_BASER);
	else if (idev->port_info->config.fec_type == IONIC_PORT_FEC_TYPE_RS)
		ethtool_link_ksettings_add_link_mode(ks, advertising, FEC_RS);
    ...
}

When config.fec_type is IONIC_PORT_FEC_TYPE_NONE, advertising gets no FEC
bit at all.

The device does support FEC off. ionic_set_fecparam() maps both
ETHTOOL_FEC_NONE and ETHTOOL_FEC_OFF to IONIC_PORT_FEC_TYPE_NONE and
programs it through IONIC_PORT_ATTR_FEC.

After this patch, GFECPARAM can return ETHTOOL_FEC_OFF as the configured
mode, but GLINKSETTINGS never lists it as supported. Userspace that checks
the supported modes before configuring would conclude that off is not
available.

Should ionic_get_link_ksettings() add FEC_NONE to supported, and also to
advertising when config.fec_type is IONIC_PORT_FEC_TYPE_NONE? Drivers such
as ice, i40e, mlx5, bnxt, nfp, hns3, otx2 and fbnic set FEC_NONE in their
supported link modes.

A related issue is pre-existing and not introduced by this patch.
ionic_get_link_ksettings() hardcodes RS and BaseR as supported for every
transceiver and speed. It ignores the firmware's per-port list in
union ionic_port_identity.fec_type[4].

Because the commit now points to GLINKSETTINGS for supported modes, that
list may not match the hardware. As far as I can tell, no later patch in
the series touches ionic_get_link_ksettings().
-- 
pw-bot: cr
