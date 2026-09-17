Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955AA54CF65;
	Thu, 17 Sep 2026 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661495; cv=none; b=uoNhzw9STqUg0KEajQIw07xhz7H2IQexrcJ5g0nqs2CoE86yDTRHcVZvP/x7qfMsQY2be8QuiUPVgwgq0p0yLbHoJXEuV/eS8jpqgOnw2k7ha5Y21ObW346d6l9sOM6GlbTVNMI2NEIRsPbaWMuHlqhPnm2DtcVXO+fx2Q4yGEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661495; c=relaxed/simple;
	bh=jJeo2JP9SaWbQPXeXtD3y8zkSj5DZNuU6ZmQwCIHOT8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=caDFr7d9WA22Yq9uJkQPBrQuLgsC7RZlT03NpvEzViqMs6gZaauD97iHtttVEBYHyMFF/Z7z4rE9xOEm4XjnVnNE96xg59XZG7L/gPCqDBVFf6Ejyxm3Uy1/jVliQs5l/rWUYZS2lj2ObPq28pCgV+QAjFZLFYrto5VQWJSH+bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F69TafpU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F69TafpU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C8E1F00898;
	Thu, 17 Sep 2026 16:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661493;
	bh=eI/GoAMQH4rlRkEnQf+Kqi++OnBBHldEeVJUYTOlp7Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=F69TafpUc9kkv70mjNxTrwLdc27mVYSSOXjjEd3xSarRYgDUoarmc/2PkxOS93d1d
	 jMSXx47yzSQJFJA2sRIC+Szpx03XCVUHWdXXwqooB22p/CY737TGxlmVgN2jQltGXo
	 bZ+1pco0HcVtVC/QdJ5h+wbG5isZXqQAo6jpOGLCNcHeIt3hxjdyR50A727rak6J13
	 TiyoEMm5Y551wtywOh7tJa0hNi+gEXSNq2v87hJYfQv534/yISBblT4+X9wNZX5i7Q
	 2XexI4pfVf8ZoNnilvZiw4VTbAeE4Rf1Rcx+3SSvyotMMw+wGbCXBIAHOY4gjfHOY4
	 g1FXficDDaVnQ==
Subject: Re: [PATCH net-next v16 6/6] net: dsa: mxl862xx: document devlink
 flash and info support
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Date: Thu, 17 Sep 2026 16:11:31 +0000
Message-ID: <178966149151.22033.652158876730245736@kernel.org>
In-Reply-To: =?utf-8?q?=3C593c60c6ebaa2526fd1e2d06cd8bd6910cd3ad92=2E1789477?=
 =?utf-8?q?568=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3C593c60c6ebaa2526fd1e2d06cd8bd6910cd3ad92=2E17894775?=
 =?utf-8?q?68=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] The new user-facing document and the in-tree driver artifacts
  disagree on the remedy for a failed rescue recovery.

--

net: dsa: mxl862xx: document devlink flash and info support

This adds Documentation/networking/devlink/mxl862xx.rst describing the
devlink info versions and the flash update flow of the mxl862xx driver,
including the MCUboot rescue mode recovery, links it from the devlink
index and adds it to the driver's MAINTAINERS entry.

> diff --git a/Documentation/networking/devlink/mxl862xx.rst b/Documentation/networking/devlink/mxl862xx.rst
> new file mode 100644
> index 0000000000000..793f3521f505f
> --- /dev/null
> +++ b/Documentation/networking/devlink/mxl862xx.rst
> @@ -0,0 +1,91 @@

[ ... ]

> +Flash Update
> +============

[ ... ]

> +If the driver gives up on the recovery, ``devlink dev flash`` returns
> +``-EIO`` and says so in its extack message. The drain runs once and is
> +never resumed, so a failed MDIO transaction ends it as well. A loader
> +that stops answering the drain needs a power cycle; a completed drain
> +whose reprobe could not be scheduled, and a drain a bus error cut
> +short, need only a driver rebind. The driver re-examines the switch
> +when it binds and at no other time, so a power cycle on a board where
> +the switch can be cycled on its own still has to be followed by an
> +unbind and rebind for the recovered switch to be recognised.

[Severity: Medium]

This new text says two of the three rescue_failed causes need only a
driver rebind, but the in-tree kernel-doc and the log message say a power
cycle is needed in all cases.  Which of the three is right?

The kernel-doc for the flag in struct mxl862xx_priv (mxl862xx.h) makes no
distinction:

 * @rescue_failed:      (rescue_mode) the self-heal gave up or cannot run; the
 *                      loader needs a power cycle and no flash can be accepted

and mxl862xx_setup_rescue() in mxl862xx.c prints the same advice for every
cause:

	if (priv->rescue_failed) {
		dev_warn(ds->dev,
			 "switch in MCUboot with an unfinishable download, power cycle it\n");
		return;
	}

mxl862xx_rescue_heal_work_fn() in mxl862xx-fw.c sets the flag both for any
drain error, which includes a plain SMDIO/bus write failure:

		dev_err(dev, "flash: download recovery failed: %pe\n",
			ERR_PTR(ret));
		WRITE_ONCE(priv->rescue_failed, true);

and after a fully successful drain when only the reprobe hand-off failed:

	if (device_schedule_reprobe(dev, MXL862XX_FW_REPROBE_DELAY_MS))
		WRITE_ONCE(priv->rescue_failed, true);

Since rescue_failed is a plain bool in the per-binding priv, an unbind and
rebind starts from false and re-runs mxl862xx_rescue_mode_detect(), which
matches what the .rst says for those two cases.  Only the unfinishable
opening handshake path in mxl862xx_rescue_mode_detect() looks like it
genuinely needs a power cycle.

Should the kernel-doc comment and the dev_warn() text be narrowed the same
way, so an operator reading dmesg is not sent to power cycle (possibly
physically reset) a switch that a rebind would recover?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1789477568.git.daniel%40makrotopia.org
