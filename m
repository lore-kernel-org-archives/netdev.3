Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AE83932D3;
	Sun,  4 Oct 2026 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791129396; cv=none; b=qZgHqVABM2C4/UaRXUg0kEh7R4jtQuIMJNxVoc94JXYrN7b6YEnHhEmJjOBjj1cTWk+p0/o608T9G+RFGH6uMh10L2D4QC+MnBbpxeL9rigsZ0FWYruuoT3zHCnNfLoeb+OvTTJEOkOYS2mWmDux2oRO4c0YwVWZgTaZVez2LpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791129396; c=relaxed/simple;
	bh=k47fIkXoIve1EcF/DH9wD0vXMxdWxc2LjnMUZ/9jbrA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fNu4Kw8v62aIt+mvarEwwY7ScFCDvOoGCO6rpfGr5xdTTrLWM9ZRQKPsnn0hMCuDGxywzFu2+KFg6u5c6VPMw93XiyRJD9aHdJB/cnEWm5I9AGpAoYaqor/qPZWh+PvJHumjUJ9AFtODHGZL2mP1JiM9XQvnpAx8lEpJRgPHFdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoJUo41N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoJUo41N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39731F000FF;
	Sun,  4 Oct 2026 15:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791129394;
	bh=7PtX34WXxwpxvlKsphurq4J3D1yIHgbIjqnXI/3vFCc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HoJUo41NwPEHE6ToxwKp6VjBpW2faalVA4IicaJ/W4VDZkS39I9CIblADPBDLW9F3
	 fi8Z6PNBoZGPvpQTDTsBQApAvzznbUKy9tr76jGBX/ZCRaa21DYJx/p/Y9md7cF3ph
	 G9LO3A4hNZyxrvbHCVgWBJpn6y5Z3TV6TJ8NslyYpQyP6fteVmTSnkbvrfmwS5k2Di
	 6xedtfqEq9PWF59X4w9aNp5Cl1ltYKDVTo5hUr/wkpRl32yc5NMmk6WtXJqnEqMig0
	 KHAgji8O3EIsFShi7Aze/RGRzv+2mW65mlrUmB1jaaLkoZWQGZkIm0aJUaITbe9JS+
	 hejGQ9XCv+v2Q==
Subject: Re: [PATCH net-next v19 1/6] net: dsa: add devlink flash_update
 callback to dsa_switch_ops
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Date: Sun, 04 Oct 2026 15:56:33 +0000
Message-ID: <179112939336.434549.10896420930582445721@kernel.org>
In-Reply-To: =?utf-8?q?=3C35450d868a8d1918380481420022b618e3758762=2E1791035?=
 =?utf-8?q?885=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3C35450d868a8d1918380481420022b618e3758762=2E17910358?=
 =?utf-8?q?85=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
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

- [Low] This patch gives every DSA switch a new devlink capability:
  firmware flash through the new `dsa_switch_ops::devlink_flash_update`…

--

net: dsa: add devlink flash_update callback to dsa_switch_ops

This adds a devlink_flash_update callback to dsa_switch_ops. It also
installs a dsa_devlink_flash_update() trampoline in dsa_devlink_ops,
which returns -EOPNOTSUPP when the driver does not implement the
callback. The commit message describes how flash requests behave on
switches without the callback, and the locking context the op is
called in.

> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index 5d12191b6f6f5..1fcf4af6c5064 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -1176,6 +1176,9 @@ struct dsa_switch_ops {
>  	int	(*devlink_info_get)(struct dsa_switch *ds,
>  				    struct devlink_info_req *req,
>  				    struct netlink_ext_ack *extack);
> +	int	(*devlink_flash_update)(struct dsa_switch *ds,
> +					struct devlink_flash_update_params *params,
> +					struct netlink_ext_ack *extack);

[Severity: Low]
This isn't a bug, but should the Devlink section of
Documentation/networking/dsa/dsa.rst mention the new op?

That section currently says:

    DSA drivers can make use of the following devlink features:

and lists only Regions, Params, Resources and Shared buffers. It ends
with a pointer to Documentation/networking/devlink/.

The later patches in the series add only the driver-specific
Documentation/networking/devlink/mxl862xx.rst. They don't touch dsa.rst.

The calling context in the commit message is not written down anywhere
in the DSA docs either:

  - the devlink instance lock is held
  - rtnl_lock is not held
  - the devlink instance is registered in dsa_switch_setup(), before
    dsa_tree_setup_ports() creates the user ports

Would a short entry for flash update in that list be useful to driver
authors? It could also cover these constraints.

The list already left out devlink_info_get before this patch.

>  	int	(*devlink_sb_pool_get)(struct dsa_switch *ds,
>  				       unsigned int sb_index, u16 pool_index,
>  				       struct devlink_sb_pool_info *pool_info);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791035885.git.daniel%40makrotopia.org
