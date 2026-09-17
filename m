Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C39429028;
	Thu, 17 Sep 2026 20:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789678196; cv=none; b=WS5iw/2WZfLOvEx+Z0vv3cUADoQPZCL0nfx5NeQumcxja0ar90gp38Fny7lq8uBNbHrcHyiHTloY4UWYSAre44abMgPchtT70Z3lQk5FC4RchflNWNI907jAPcIlw1j6xOv8Ib5sRfTTL4sqaT4ikdKWTCkBvk3Xq9ma+7vk1As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789678196; c=relaxed/simple;
	bh=J+i9CNnOJhlMOlifWwg5TX7SBCmKTpcLJGzy2rKks8o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mD+JL4ueJEzKXXs5zdJcFlc+JJeNi2Lx34V2oQ1VafSYxXEv0ZzMRQgD9O5RWbLMfOPHWzyx5jFqhLp4yE8LQLxPOuiZgZ1K0/Q6icYE4/s1N+92kMrnRLnQlBL1iPQiM0Eg5K2DJCM+6hgzDJeTzSaymmA//n98+6SifxqIOCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLhJTx9s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLhJTx9s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374B61F00898;
	Thu, 17 Sep 2026 20:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789678194;
	bh=HqvBEQTON5xtkHghCnEfWwyRNsnxm/fGPw0hb20/kI4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WLhJTx9sI/xQFHKvvig+awtO0wfNIVZmn5vc0XMZEIFzuUEES2McLvlvL2cDzGZiz
	 6NBuNaIuvwJTWKjCnie9r6TXiPyd67Mrp34QsWEGhabUC5/3+pfYO92WizwdSEq02k
	 ophojyls7KdahDOQnZyRoMVKnsFHZBgxs7wRigWJvVB/++U2eIjXwyVre61YkqhY/h
	 vKALh54tanAZS6WAEhvUJshqeuYqqJWX6gXQOC1KQMLoNK19is8tvvAhYyE6TbI5PX
	 xE/RwAj3yRLpRNn01EFD8bqypZ0fGMsINVnu8DRFBGwJR46pjxJEo+CY6iJTQF/IYN
	 yg52CeOJ5cRzw==
Subject: Re: [PATCH v2 net-next 2/7] dt-bindings: net: dsa: mediatek,mt7530:
 add passthrough mode
From: netdev-bot+sashiko@kernel.org
To: cjd@cjdns.fr
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 chester.a.unal@arinc9.com, daniel@makrotopia.org, linux@armlinux.org.uk,
 arinc.unal@arinc9.com, Landen.Chao@mediatek.com, dqfext@gmail.com,
 sean.wang@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, naseefkm@gmail.com, b.larsson@gmx.com
Date: Thu, 17 Sep 2026 20:49:52 +0000
Message-ID: <178967819278.22033.11186084049097912254@kernel.org>
In-Reply-To: <20260915174643.253660-3-cjd@cjdns.fr>
References: <20260915174643.253660-3-cjd@cjdns.fr>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 2

- [Low] The added `description` paragraph in
  Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml (lines…
- [Low] Concern (retained for policy combination, assessed as a false
  positive): the binding advertises a passthrough mode that…

--

dt-bindings: net: dsa: mediatek,mt7530: add passthrough mode

This adds a paragraph to the mediatek,mt7530 binding description explaining
that MT7530/MT7531 switches can be operated in a "passthrough" mode where
traffic moves unconditionally between the CPU port and a DSA link port to a
second switch. The paragraph also states that in this mode the upstream
switch may have no other ports or switch configuration.

> diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> index 90b3582b76190..e29fb86934981 100644
> --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> @@ -73,6 +73,13 @@ description: |
>  
>        Check out example 7.
>  
> +  The MT7530 and MT7531 switches are capable of being operated in "passthrough"
> +  mode. In this mode, traffic is unconditionally passed between the CPU port
> +  and the DSA port which links to a second switch. To use passthrough mode, the
> +  upstream switch is configured with a DSA link to the downstream switch. In
> +  passthrough mode the upstream switch is restricted, with no other ports or
> +  switch configuration allowed.
> +

[Severity: Low]
The last sentence states a hard device tree constraint, but it only exists
as prose.  Should this restriction also be expressed in the
machine-checkable part of the schema?

As it stands there is no new property, no if/then under allOf, and no $defs
entry that limits the port set when a port carries a link phandle.  The port
container in this same file is permissive:

  patternProperties:
    "^(ethernet-)?ports$":
      type: object
      additionalProperties: true

      patternProperties:
        "^(ethernet-)?port@[0-6]$":
          type: object
          additionalProperties: true

so a device tree describing an upstream MT7530/MT7531 with a CPU port, a DSA
link port and extra user ports, plus gpio-controller/interrupt-controller,
still passes dt_binding_check.  The layout is instead rejected at probe time
by mt753x_check_passthrough() in drivers/net/dsa/mt7530.c, added by the
following patch in the series:

	if (passthrough_ports > 2 ||
	    (passthrough_ports == 2 && enabled_ports != 2)
	) {
		dev_err(dev, "Only two ports allowed in passthrough mode\n");
		return -EINVAL;

Two smaller points on the same paragraph:

Every other topology description in this description block ends with a
pointer to a validated example ("Check out example 7." just above).  Could
this one gain an example too, so the passthrough layout is actually exercised
by dt_binding_check?

The per-port reg description further down still reads:

          reg:
            description:
              Port address described must be 5 or 6 for CPU port and from 0 to 5
              for user ports.

which never mentions the DSA link port this new mode depends on.  The later
patch in the series constrains that link port to reg = 6 via the
mt7530-passthrough-dsa-port $def, which does not match the text above.
Should the reg description be updated at the same time?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915174643.253660-1-cjd%40cjdns.fr
