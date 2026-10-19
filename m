Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287754F85B2;
	Mon, 19 Oct 2026 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416787; cv=none; b=EUo0XgIsJvcPo+pIoYgSjYjT5PK6/MAKp8ieRcB6E9RYGNymNI9igXSk0oVNrbTaV29TxoJBhGcmyYbUImttwS72ELvhV1oYg97gJnkmgw1Uz0HTID4Fw0VIReXSQdsQzFwv9LYdMY5xwNEwyCwrbFqwn/+4qWKCCtDLoEeS3XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416787; c=relaxed/simple;
	bh=oCnc+4YPFzPrKNYhGZA2Y25UUUEDGrScuQdE5lpNg5I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ep6gHNFPcY7wJzgZNzwbOwt+QktpyaVnZzZZkvGOyTV2Ugdcp2p+SJLFu0g8neGoiX+DmxbT6rJigXh1wo58bDtgPZTdet92wb3hFS2CAqzIrowvtxO6SNiOYCdCToTbamYMB+941FGlaKw/Uj4UJENsuHxxhIQgA/5z+yVSbBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAECk1tK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAECk1tK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45ACF1F000C4;
	Mon, 19 Oct 2026 13:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792416785;
	bh=KVudN3R5hZ5GHsJWzPbxZs/oNeMhhj12/yQpYaNk0g8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fAECk1tKwgI8+NWb2IDM2y+F/rP53NFxzruT3q126KsWXaxqdnxnAFWZfRx5FWHga
	 sBc0ceUCuks/5DBqc5+kHDzk0elI+Uvy8Na7UTQ80J0hxEjVFDxDKE1E7m+U/2XsbB
	 LcgKSPpTgkCgIvuZJ00gAk+Qk0y5Jk7U6P2ODZsjYqllYrzgsuz6DgxSRkhSZosJse
	 G8sC8Xj7htK6ZTFeZJxPVjpg6LapbiVUru39yOMeQ1GaujM21jgjS8/kbA1k5TFeSv
	 Q+ywd2JnxBqIGX2ht1PqhTUXhLDWjXLd2c/RpbeOQojzS7NPP+LYlqEhBoLCtiNrwY
	 0y7h34mcC2zKg==
Subject: Re: [PATCH net-next v19 04/10] net: phy: Create SFP phy_port before
 registering upstream
From: netdev-bot+sashiko@kernel.org
To: maxime.chevallier@bootlin.com
Cc: davem@davemloft.net, andrew@lunn.ch, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, hkallweit1@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, christophe.leroy@csgroup.eu,
 herve.codina@bootlin.com, f.fainelli@gmail.com, vladimir.oltean@nxp.com,
 kory.maincent@bootlin.com, kabel@kernel.org, o.rempel@pengutronix.de,
 nicveronese@gmail.com, horms@kernel.org, mwojtas@chromium.org,
 romain.gantois@bootlin.com, daniel@makrotopia.org,
 dimitri.fedrau@liebherr.com, frank.wunderlich@linux.dev, p.ameruoso@live.it,
 f@lex.la, chleroy@kernel.org
Date: Mon, 19 Oct 2026 13:33:03 +0000
Message-ID: <179241678386.3135.10167013424951855849@kernel.org>
In-Reply-To: <20261016133107.54054-5-maxime.chevallier@bootlin.com>
References: <20261016133107.54054-5-maxime.chevallier@bootlin.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message presents the reorder in
  phy_sfp_probe()/phy_setup_ports() as pure preparation.
- [Low] The patch opens a new window in phy_setup_ports().
- [Low] In phy_setup_ports() (lines 3534-3542), the comment says the `if
  (!phydev->is_genphy_driven)` guard exists because genphy binding runs…

--

net: phy: Create SFP phy_port before registering upstream

This patch splits the SFP setup in phy_sfp_probe(). That function now
looks up the SFP bus and creates the SFP phy_port without registering the
upstream. Registration moves to a new phy_sfp_add_upstream() helper, which
runs at the end of phy_setup_ports(). The stated goal is to let the
phy_port be passed to the SFP bus together with the upstream information.

> We can move the port creation before registering the sfp upstream ops,
> as long as we know the SFP bus is there. This will allow passing the
> phy_port along with the upstream information to the SFP bus.

[Severity: Medium]
This describes the reorder as preparation only. Does it also fix a
cold-plug problem that should be described, possibly with a Fixes: tag?

Before this patch, phy_sfp_probe() called sfp_bus_add_upstream() before
phy_setup_sfp_port(). If the SFP socket had already probed and read the
module EEPROM (sm_mod_state == SFP_MOD_WAITDEV), the module insert ran
synchronously:

sfp_bus_add_upstream()
  sfp_register_bus()
    sfp_attach()
      sfp_sm_event(SFP_E_DEV_ATTACH)
        sfp_sm_module()
          sfp_module_insert()
            phy_sfp_module_insert()

The is_sfp port did not exist yet at that point, so
phy_sfp_module_insert() returned early:

	port = phy_get_sfp_port(phydev);
	if (!port)
		return -EINVAL;

sfp_sm_module() then moved the module to SFP_MOD_ERROR:

		err = sfp_module_insert(sfp->sfp_bus, &sfp->id,
					sfp->quirk);
		if (err < 0) {
			sfp_sm_mod_next(sfp, SFP_MOD_ERROR, 0);

SFP_MOD_ERROR is below SFP_MOD_WAITDEV, so no later DEV_UP or attach event
retries the insert. The module stays rejected until it is physically
re-plugged. This can happen on boards where the SFP socket probes before
a media-converter PHY such as 88e1512 or 88x2222.

After this patch the SFP port already exists when phy_sfp_add_upstream()
runs, so the insert succeeds. The old ordering seems to come from
07f3ca9e092cb8 ("net: phy: Create a phy_port for PHY-driven SFPs") and
d7c6082f7e7771 ("net: phy: Introduce generic SFP handling for PHY
drivers"). Without a Fixes: tag, stable trees that contain those commits
would not pick this up.

There is a related behaviour change too. The cold-plug
phy_sfp_module_insert() now runs after phy_setup_ports() has computed
phydev->supported and phydev->port. As a result, this assignment now
persists, while before the cold-plug path never reached it:

	if (phydev->n_ports == 1)
		phydev->port = caps->port;

Could the commit message mention this as well?

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index ab1aa8981c00c..7713418a6734e 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

[ ... ]

> @@ -1619,32 +1621,48 @@ static int phy_setup_sfp_port(struct phy_device *phydev)
>   */
>  static int phy_sfp_probe(struct phy_device *phydev)
>  {

[ ... ]

> -		ret = sfp_bus_add_upstream(bus, phydev, &sfp_phydev_ops);
> -		sfp_bus_put(bus);
> +	phydev->sfp_bus = bus;
>  
> -		if (ret)
> +	if (bus) {
> +		port = phy_setup_sfp_port(phydev);
> +		if (IS_ERR(port)) {
> +			sfp_bus_put(bus);
>  			phydev->sfp_bus = NULL;
> +			return PTR_ERR(port);
> +		}
>  	}
>  
> -	if (!ret && phydev->sfp_bus) {
> -		ret = phy_setup_sfp_port(phydev);
> -		if (ret) {
> -			sfp_bus_del_upstream(phydev->sfp_bus);
> -			phydev->sfp_bus = NULL;
> -		}
> +	return 0;
> +}

[Severity: Low]
On success, phy_sfp_probe() now returns with phydev->sfp_bus holding only
the sfp_bus_find_fwnode() reference, and no upstream registered yet.

What happens if phy_default_setup_single_port() fails in phy_setup_ports()
before phy_sfp_add_upstream() runs?

phy_setup_ports()
    if (phydev->n_ports < phydev->max_n_ports) {
        ret = phy_default_setup_single_port(phydev);
        if (ret)
            goto err_sfp;
    }
    ...
err_sfp:
    phy_sfp_release(phydev);

phy_sfp_release() then calls sfp_bus_del_upstream() on a bus that was
never passed to sfp_bus_add_upstream(). The documented precondition of
sfp_bus_del_upstream() is "@bus should have been added by
sfp_bus_add_upstream()".

This only works today by coincidence. bus->registered is false, so
sfp_unregister_bus() does nothing. upstream_ops and upstream are already
NULL. The final sfp_bus_put() drops the find_fwnode reference, not the
add_upstream reference it was written to release.

The kernel-doc of phy_sfp_release() is also out of date. It still says it
releases what "a successful phy_sfp_probe()" set up and that it
unregisters the upstream. phy_sfp_probe() no longer registers an upstream;
phy_sfp_add_upstream() does that now.

Could sfp_bus_del_upstream() be called only after the upstream has been
added, with a plain sfp_bus_put() otherwise? The kernel-doc should then
be updated to match.

The end of the series ("Documentation: networking: Update the phy_port
infrastructure description") still has the same err_sfp path and the
same kernel-doc.

> +
> +static int phy_sfp_add_upstream(struct phy_device *phydev)
> +{

[ ... ]

> @@ -3551,6 +3569,10 @@ static int phy_setup_ports(struct phy_device *phydev)
>  			break;
>  		}
>  
> +	ret = phy_sfp_add_upstream(phydev);
> +	if (ret)
> +		goto err_sfp;
> +

[Severity: Low]
Is the comment above the genphy check in phy_setup_ports() still
accurate?

	/* We don't support SFP with genphy drivers. Also, genphy driver
	 * binding occurs with RTNL help, which will deadlock the call to
	 * sfp_bus_add_upstream().
	 */
	if (!phydev->is_genphy_driven) {
		ret = phy_sfp_probe(phydev);
		...
	}

sfp_bus_add_upstream() is no longer inside that guard. It is now reached
through phy_sfp_add_upstream() for every PHY, including genphy-driven
ones.

This is safe today only because phydev->sfp_bus stays NULL for genphy,
and sfp_bus_add_upstream(NULL) returns 0 before taking rtnl_lock().
Nothing near the new call states that dependency.

Could the call go under the same is_genphy_driven check, or could the
comment be updated to describe this? The end of the series has the same
code.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016133107.54054-1-maxime.chevallier%40bootlin.com
