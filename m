Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF49A468C37;
	Fri,  2 Oct 2026 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790930266; cv=none; b=S7gtaBow9CQunX+iMsfVOUtIqOSdDnZq1dAhk4X8pL0FSPZq/i4RJPL1+L4jDnhMAgH44u6RZrU+B7UFHB7FULW1qBQIHWcN2mF70Hb0ym6K717xyV0wA4cQqUlQlvkmamSs9vSMNGAc25y0bb4RsZ7Q9HOGcER2ggSFBO9nTpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790930266; c=relaxed/simple;
	bh=u4QavItz0ccJY/tZp+FSmDyORJUbXpAglQBfzmdCjgE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ggErN5DbtXoSFqYe+Iip9veLzDFFFhHrqUkRzHSE+bObsDNO3YNTlT4jr3RyLGCdnsLlDNorkdMxxOSrXXFjjIon+xrbZNQ+nXpUGl86+gIUj/o7Cln7POh/F6HUuG3tK7mZ3L466QUYGHbWNJtyJlR9UjHvO4wKoSPCUCTX8KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/4IgrQc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/4IgrQc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49471F000FF;
	Fri,  2 Oct 2026 08:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790930264;
	bh=3cZoWWwPM7c4295sa+RXkoXcRWR5SogB4LZu0Q52UIs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=e/4IgrQcYHlcUmdIQiE9A/XhTWasECD91vHaRYCXkiiIepAr75j4W8zDQJVzJx9D6
	 haUMIVvM3l584kg0U/+heCzQ97SQ0w/2BCC3/LNqg3vZyw1mlRu8RpLKH7vX+JGXQL
	 j4nBA7lcEErBzfOnwHs4Sun1mKCypH+6C6PEcEMsYYOFcyMmCwG783fH7sHQnrEbgJ
	 HsEahdivH1lDlR4tQSna5ezw2ogHqzT5xPzBT0tOaFRxIk91a5s7+CJzol+Slsmrm2
	 NGgd15lAxLZ5FZj2u0ViTTgM9I3Tm5ywyjL6e6w+V3y9E3REUlFO4LMhwLtn0rnU/P
	 41qJFE8VFECVQ==
Subject:
 Re: [PATCH net v6 3/5] net: stmmac: Rename double VLAN references to svlan
From: netdev-bot+sashiko@kernel.org
To: ovidiu.panait.rb@renesas.com
Cc: maxime.chevallier@bootlin.com, recv.jo@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 jun.ann.lai@intel.com, yi.fang.gan@intel.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 08:37:43 +0000
Message-ID: <179093026338.434549.16397575185437884627@kernel.org>
In-Reply-To: <20260928203441.34876-4-ovidiu.panait.rb@renesas.com>
References: <20260928203441.34876-4-ovidiu.panait.rb@renesas.com>
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

- [Low] The self-test renamed to "SVLAN Filtering (perf)"
  (stmmac_test_svlanfilt_perfect), and likewise…

--

net: stmmac: Rename double VLAN references to svlan

This patch renames the "double VLAN" identifiers in the stmmac driver to
"svlan". It covers the VLAN hash callbacks, the num_double_vlans counter
and the selftests. The ESVL and DOVLTC bits control S-VLAN tag
processing, not the inner-tag double VLAN feature. No functional change
is intended.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> index c25dc9f89270..c485217ba880 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c

[ ... ]

> -static int stmmac_test_dvlanfilt_perfect(struct stmmac_priv *priv)
> +static int stmmac_test_svlanfilt_perfect(struct stmmac_priv *priv)
>  {
>  	int ret, prev_cap = priv->dma_cap.vlhash;
>  
> @@ -1171,7 +1171,7 @@ static int stmmac_test_dvlanfilt_perfect(struct stmmac_priv *priv)
>  		return -EOPNOTSUPP;
>  
>  	priv->dma_cap.vlhash = 0;
> -	ret = __stmmac_test_dvlanfilt(priv);
> +	ret = __stmmac_test_svlanfilt(priv);
>  	priv->dma_cap.vlhash = prev_cap;

[Severity: Low]
Does the "SVLAN Filtering (perf)" test still exercise perfect VLAN
filtering?

This test forces perfect-match mode by clearing priv->dma_cap.vlhash
before it calls __stmmac_test_svlanfilt(). An earlier patch in this
series, "net: stmmac: Remove VLAN perfect matching dead code", removed
the fallback in stmmac_vlan_update() that used to read vlhash:

    if (!priv->dma_cap.vlhash) {
        pmatch = vid;
        hash = 0;
    }

At this commit, the only reads of dma_cap.vlhash outside the selftests
are the probe-time feature check in __stmmac_dvr_probe() and the
debugfs dump. The filtering path never reads it:

__stmmac_test_svlanfilt()
  vlan_vid_add()
    stmmac_vlan_rx_add_vid()
      stmmac_vlan_update()
        stmmac_update_vlan_hash(priv, priv->hw, hash, is_svlan);

stmmac_vlan_update() always computes a non-zero hash for the active VID.
vlan_update_hash() and dwxgmac2_update_vlan_hash() then do:

    value |= VLAN_VTHM | VLAN_ETV;

so hash matching stays enabled throughout the "(perf)" run.

That seems to make stmmac_test_svlanfilt_perfect() a repeat of
stmmac_test_svlanfilt(). It could pass even if perfect filtering via
stmmac_add_hw_vlan_rx_fltr() were broken. The same applies to
stmmac_test_vlanfilt_perfect().

This patch renames the test but keeps it in this state, and the
remaining patches in the series do not touch the selftests. Should
these two "(perf)" tests be reworked or dropped?

>  
>  	return ret;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928203441.34876-1-ovidiu.panait.rb%40renesas.com
