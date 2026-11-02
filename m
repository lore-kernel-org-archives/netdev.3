Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656217;
	b=uUJSrVOpypqNtR38cdx8rNmSCJ5UiY2ezMDtFN2TgJupwiuK0fWLJYoRgYWMMMc1xkWz
	 DnIgnaVpIdfiRI5l7eBHJ1dMmirZ5/Kg/7OcZxWy/RD9SY+2svndFVZmeCLGc3+O7NhNL
	 VCskUg2RyJy2ooRy87HJOzi64gUOpPtKFp3RCvmAFwms5QoCANOydSmTzF/0bnquK1cbL
	 pdYcAuBblRQqXyFSxOOfhW1gzq3rZPAMhNt5Kh68nK2nA4rar+H/Qzhc7cQDDyabg1QCF
	 JrmXrBNCG5CGu/nj8DOSMzpNduSVdiF+6aqL1RkDnHXAyv3wigiEFNO/Lv0X53xxQdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656217;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=goWsG59NVC/9uCSE4c2Wnd+eNXP7IRpR0hDp4+YJmBY=;
	b=c4/sio5u6v+F4Bc9fAO/Jtah6sQiw8E/nlHFJRXKi+e/VUbUp1RG35muVXqgTxVL0eZH
	 m5baTB1AQhvH9GeH5jr9K4pANfCyQ89ggBDtdgGUcRjMbXU9lhzV2KT6gazO8UrSutdzn
	 9sb3cgAChFC2VQFf2mLUuGtThHvZFoir9lga6fZX3FHDkrAcO6BMIR1ZTdJlBLebw+UZk
	 KLQhvP99V1HgpE5u/LlcNz7YRJO/0YcwdpLJl4RcBcC/kNEtIKZZxPQq65Q3RUZE0A7pP
	 YWZODcA925LwUpYGKccHXNaEoehCtDc4D6fIVZ21n2n0vYHNAhEvXG6n/PbvhBabMAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YUrvfVEl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8654F606A324;
	Mon,  2 Nov 2026 21:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YUrvfVEl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DE71F00A16;
	Mon,  2 Nov 2026 21:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793656217;
	bh=goWsG59NVC/9uCSE4c2Wnd+eNXP7IRpR0hDp4+YJmBY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YUrvfVElZN1HDYcankiMblU07kXf5An+8j8aq5rgpPBAbTWALVqRAboejSG0ED9qA
	 xdlsyvUQQyD0/u1uWDGji7L4L+85SmGMHlkWr23Hq5EyQby8kDp1+4Z2S/JWiu+aK+
	 I3OiMIJ++zAAOhLE7MRhBTVNAY16p/nEzI4/IeHxAa2PoJV66c4CY8lcNECTdU+sxx
	 954K9a1HqQhj4B+2KtytWMDCbJ+GvgLN0U7yvF/i6EFfOB2wKvfOYJ1knL6fKAI79j
	 CQG/lCikM3FRtw/V+pXQjQdbBmo1CauZyZQxmcJk7CjeAhKtaWLc+ToaSQhxtcZOou
	 nnfrMfGjmaTPA==
Subject: Re: [PATCH net v4 1/2] net: ethernet: bgmac: preserve forced 2.5 Gbps
 link speed
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, rafal@milecki.pl, bcm-kernel-feedback-list@broadcom.com,
 jon.mason@broadcom.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 21:50:16 +0000
Message-ID: <179365621626.3131.8036596501259312595@kernel.org>
In-Reply-To: <20261029211540.4123250-2-florian.fainelli@broadcom.com>
References: <20261029211540.4123250-2-florian.fainelli@broadcom.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] After this patch the speed seen by userspace and phylib no
  longer matches the MAC.
- [Low] The patch depends on a switch-side change that is not named.

--

net: ethernet: bgmac: preserve forced 2.5 Gbps link speed

When BGMAC_FEAT_FORCE_SPEED_2500 is set, this commit makes
bgmac_adjust_link() keep the MAC at SPEED_2500 instead of following the
fixed PHY's 1 Gbps speed. It also restricts the platform forced-speed
flag to Northstar Plus via of_machine_is_compatible("brcm,nsp").

> diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
> index 669eb7ce7d40b..9ef7307edd41e 100644
> --- a/drivers/net/ethernet/broadcom/bgmac.c
> +++ b/drivers/net/ethernet/broadcom/bgmac.c
> @@ -1430,11 +1430,15 @@ void bgmac_adjust_link(struct net_device *net_dev)
>  {
>  	struct bgmac *bgmac = netdev_priv(net_dev);
>  	struct phy_device *phy_dev = net_dev->phydev;
> +	int speed = phy_dev->speed;
>  	bool update = false;
>  
> +	if (bgmac->feature_flags & BGMAC_FEAT_FORCE_SPEED_2500)
> +		speed = SPEED_2500;

[Severity: Low]
Does this patch depend on the b53 change that puts the IMP port in its
2 Gbps mode? The commit message says:

  Together with configuring the switch IMP port for its 2 Gbps
  mode, this eliminates the output queue discards ...

but it does not name the commit that makes that change.

With only this patch applied, the AMAC stays at SPEED_2500. Meanwhile
b53_force_port_config() still programs the IMP port from the DT
fixed-link (speed = <1000> in bcm-ns.dtsi) and clears the 2G bit:

drivers/net/dsa/b53/b53_common.c:b53_force_port_config() {
    ...
	if (is5301x(dev) || is58xx(dev))
		reg &= ~PORT_OVERRIDE_SPEED_2000M;
    ...
}

The next patch in this series, "net: dsa: b53: restore the NSP IMP port
2 Gbps mode", fixes this. It sets speed = 2000 for BCM5301x/BCM58XX CPU
ports in b53_phylink_mac_link_up(), so both ends match once the whole
series is applied.

The two patches have different Fixes: tags, though (f6a95a24957a and
b6a8a5477fe9). If a stable backport or a bisect picks up only this
patch, would the MAC run at 2500 while the switch IMP port runs at
1000? Could the b53 commit be named here as a dependency so both are
backported together?

>  	if (phy_dev->link) {
> -		if (phy_dev->speed != bgmac->mac_speed) {
> -			bgmac->mac_speed = phy_dev->speed;
> +		if (speed != bgmac->mac_speed) {
> +			bgmac->mac_speed = speed;
>  			update = true;
>  		}

[Severity: Medium]
Can phy_print_status() still be reached on these interfaces?

bgmac_open()->bgmac_chip_reset()->bgmac_miiconfig() sets the cached
speed and duplex before phy_start():

drivers/net/ethernet/broadcom/bgmac.c:bgmac_miiconfig() {
	if (bgmac->feature_flags & BGMAC_FEAT_FORCE_SPEED_2500) {
		...
		bgmac->mac_speed = SPEED_2500;
		bgmac->mac_duplex = DUPLEX_FULL;
		bgmac_mac_speed(bgmac);
    ...
}

When the fixed PHY reports link up, bgmac_adjust_link() now computes
speed == SPEED_2500, which equals mac_speed, and the duplex also equals
mac_duplex. So update stays false and the link-up message is never
printed. Before this patch, the change from 2500 to 1000 always set
update.

Also, bgmac_ethtool_ops uses phy_ethtool_get_link_ksettings, which
reports phydev->speed. That is still SPEED_1000, either from the fixed
PHY in bgmac_phy_connect_direct() or from the DT fixed-link:

	struct fixed_phy_status fphy_status = {
		.link = 1,
		.speed = SPEED_1000,
		.duplex = DUPLEX_FULL,
	};

The UniMAC, however, is now programmed for 2500.

Will ethtool and netlink report 1000 Mb/s for a link that is actually
running at 2.5 Gbps?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029211540.4123250-1-florian.fainelli%40broadcom.com
