Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324062;
	b=GWKNtZI6v/mdUT8cICIwQ9r2Y6+aWU49NODKLIQ/Aq0915YjqGMVaC6Xm8sTWRAKYzhe
	 2eynT8dYjtfWKqcsVjJlrgtNNnCBarYLwzkxwwu9UsVWZ2z2OgJllGffZIPPRkguKqShW
	 CQNstNztKKXphp3/NoSYMMifdUNiO4PCwLZZXA/RLWiemmDj1hSacJF9fW2/7LXiUWr+N
	 5oZI/V6BZG4IHED51WQX4+RoddEL6pSZt21vDCZa1QRNzsh5xrXxRTdx9aYFR4QooNs/2
	 X7fWtvtoOtc2AXUtm497v3tDepTHQieS+jDOS83BicOL75QsQ70MWUHyUrSE9HcOSqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324062;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZVBYgEQBx7S36JBdqc/gGq/Up2XFDyxjqi8JwFWQLPU=;
	b=hvuXhySInJBkra3oBen57AUvcG1XW7EZ6e9+JtwaENRoi/+zBmAmuGwASN5+Dqjf6wcU
	 ekBWS/H8KgGWeBg6Y5mg14eENOLstH48/qBn6gveINrafF79xG+wpUZD5Ys8xrfdtfEGm
	 waCVt9MytvwkQmXFP45PSmE69Su+KbJ6zenw/CptmCrja8bj5WwdoISuBUgaLQm7UVOBF
	 fIPUgcHs0Wsm7b6Pi2Uv7E0yhuV1Vi8A3bwyv+9yT/zdITyUR/jzYL4o1V2Jh54WdmXkE
	 w7NDOesnEL924gRPh8+nPFvpNCVq43hcIjsbddgic1oOii/68YXax86KM7OPj0hHGBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="g7w3hOs/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32E8606A31C;
	Tue, 10 Nov 2026 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g7w3hOs/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7251F0089F;
	Tue, 10 Nov 2026 15:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794324061;
	bh=ZVBYgEQBx7S36JBdqc/gGq/Up2XFDyxjqi8JwFWQLPU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=g7w3hOs/9ZDzwB/syYr+ROi/BctaeuECd9bptLycmt9GiDKLB15Hh34oTSHS/fesM
	 DA07KxfUCuFKbGytlwX9v6BuazmDeSuOhYm+50fqZCxTLMthTHp6wVKnsN0oG1z8YX
	 Zo68/95wuKDLiUzD6s5lzGeIzE1BFfJu/kaKEt4nHJUPoHi52pEG01mrihEFrSPSVI
	 lMveTpNZ7qN6LcgnYc39qLnk6Pn75KFX+j1y3lpe+gQt1nNWyQ4prEyD8A7ldUZ1YN
	 Q34BIFoWA1bZom3n77Y4Zu+gOmE6yGjazsmN1gJ+BFNvlZilarTPCGBrbMBCyBqk0o
	 +KGpCFjCCAyvA==
Subject:
 Re: [PATCH net v2 1/2] net: dsa: realtek: rtl8365mb: use IVL in VLAN 0
From: netdev-bot+sashiko@kernel.org
To: stijncleynhens@gmail.com
Cc: netdev@vger.kernel.org, linusw@kernel.org, luizluca@gmail.com,
 alvin.sipraga@analog.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 namiltd@yahoo.com, linux-kernel@vger.kernel.org
Date: Tue, 10 Nov 2026 15:21:00 +0000
Message-ID: <179432406021.994134.1889530056154978088@kernel.org>
In-Reply-To: <20261106150225.3700205-2-stijncleynhens@gmail.com>
References: <20261106150225.3700205-2-stijncleynhens@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message says the patch has no visible effect on its
  own, but that is only true for standalone ports.

--

net: dsa: realtek: rtl8365mb: use IVL in VLAN 0

This commit sets up the VLAN4k entry of VID 0 with Independent VLAN
Learning. The goal is for the IVL-keyed FDB and MDB entries that DSA
installs with VID 0 to match frames classified to that VLAN. The commit
message says the change has no visible effect on its own.

> DSA installs the FDB and MDB entries of standalone ports and of
> VLAN-unaware bridges with VID 0, and the driver writes them with
> Independent VLAN Learning. No bridge VLAN sets up the VLAN4k entry of
> VID 0 though, and it defaults to Shared VLAN Learning, so the switch
> looks up and learns frames classified to VID 0 by FID. Lookups never hit
> the IVL-keyed static entries, and a learned entry for the same MAC sits
> alongside the static one.

[ ... ]

> On its own this has no visible effect: standalone ports do not learn and
> the driver does not control host flooding, so the unused static entries
> only meant that traffic was flooded to the CPU. The next patch, which
> moves VLAN-unaware bridges onto VID 0, depends on it.

[Severity: Low]
Does the "no visible effect" claim hold for VLAN-unaware bridge ports
that have no PVID?

This can happen with a bridge created with vlan_default_pvid 0, or with a
VLAN-unaware port whose PVID VLAN was deleted. In both cases
rtl8365mb_vlan_pvid_port_clear() points the port at VLANMC index 0. The
rtl8365mb_vlan_mc_find() kernel-doc describes that index like this:

 * Although 0 is a valid VLAN MC index, it is reserved for ports without PVID,
 * including standalone, non-member ports. It uses VID == 0.

These ports do learn, because rtl83xx_port_bridge_join() turns learning
on:

	if (priv->ops->port_set_learning) {
		ret = priv->ops->port_set_learning(priv, port, true);

Before this patch, their untagged frames were learned and looked up in
the SVL/FID key space of VLAN4k[0]. The static entries, however, are
always IVL-keyed in rtl8365mb_l2_add_uc():

	uc.key.ivl = true;
	uc.key.vid = vid;

So unicast to the host was flooded to the other bridge ports. Assisted
learning on the CPU port also could not override learned entries.

Once rtl8365mb_vlan_vlan_setup()->rtl8365mb_vlan_4k_setup_neutral() turns
on IVL in VID 0, those static entries start to match for these ports.
Learned entries then use the VID 0 IVL key. That changes forwarding
behaviour and the FDB contents.

The first paragraph also seems to contradict the "no visible effect"
claim. "a learned entry for the same MAC sits alongside the static one"
can only happen if some port learns on VID 0, and standalone ports do
not learn.

Could the commit message describe the effect on VLAN-unaware bridge ports
without a PVID? The later patch in the series that keeps the neutral PVID
in VLAN-unaware bridges does not mention this case either.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106150225.3700205-1-stijncleynhens%40gmail.com
