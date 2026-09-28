Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73EF469833;
	Mon, 28 Sep 2026 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588838; cv=none; b=T3blh7X4MiysBjnKfNVhnp3s/DxwLDb94fgDSq3vWSAJFtY7MhI39Snw43rWyHnINlDSF65Csk9gvlqW6iS0uOD/VwdpVqGzQV8Qk3BqddNXBLXDGMoR2B+zRBeIXy6KUb9qxpY77/897YsVF78csejRZBUncDQQ2Vnh95lL8gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588838; c=relaxed/simple;
	bh=MkkYU1Hd1r1unVOOoXhMp1YsC1dRZ3KhMg7Sa6XZOaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D53WY8z5pLZVbRqISC3MSHE2glz7nyfM7mBHBBqWSWFcG8KkGpE6ULKCXRb0TtdIVhz5LYUvg2PpP3iwTtMdVN1j8hCDU58lRd4Qv9GtQmcbzbaxFG+Y/p/j2moXOJZgWdKEOxHI4XdwLGWjAQWfCG9O8O7XWzBkcHLK4ixPwI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIYVR/at; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIYVR/at"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440BB1F000FF;
	Mon, 28 Sep 2026 09:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588834;
	bh=XyzAte1ezbztCaoz1uJXtfOyp8FShpqhI2aesNp3CNo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gIYVR/atvwJQ1qeBnlq/ZJrE1XFLvQvNuZ/rjIvI6daq1Bf83DBfJLRMMGwFlYNW3
	 Bj1e/pSUMke0oHHR4l0p2v5ZzkS8nbR52KCX4qIlZ3FM8TdEBR5s2Dk8r5pJPOMobN
	 nfDFkyU+ecQB20OEQvo/dxZRM2R0gX9DpIlD4wvMj3tuIK1aE0dgg3PML09IE/ZN23
	 x9+VQFc4UI8De1Q3cxmgd7hLFLQq+lJiWv0N2ynsj3zQ83KZsv4jdLOKcKjMvlaCfP
	 HDCEILasMRSSkfCinh5QwhzjoB0blzzfL60/djjqZlCpsxlgsbiCT5Ki0VzOsHSYNr
	 ofjkwy3KRo1Ww==
Message-ID: <0ac92f47-5347-4fa6-bb1c-9a47e1f21413@kernel.org>
Date: Mon, 28 Sep 2026 11:47:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 08/10] netlink: specs: Add ethernet port
 listing with ethtool
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
 Frank Wunderlich <frank.wunderlich@linux.dev>,
 Pietro Ameruoso <p.ameruoso@live.it>, Aleksei Sviridkin <f@lex.la>
References: <20260927133619.955236-1-maxime.chevallier@bootlin.com>
 <20260927133619.955236-9-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260927133619.955236-9-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/09/2026 à 15:36, Maxime Chevallier a écrit :
> Ethernet network interfaces may have more than one front-facing port.
> The phy_port infrastructure was introduced to keep track of
> these ports, and allow userspace to know about the presence and
> capability of these ports. Add a ethnl netlink message to report this
> information.
> 
> Tested-by: Aleksei Sviridkin <f@lex.la>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

I'm not an expert in documentation language, but the content makes sense 
and looks consistant.

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   Documentation/netlink/specs/ethtool.yaml      | 55 +++++++++++++++++++
>   Documentation/networking/ethtool-netlink.rst  | 36 ++++++++++++
>   .../uapi/linux/ethtool_netlink_generated.h    | 22 ++++++++
>   3 files changed, 113 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index 5dd4d1b5d94b..35e028c0be29 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -210,6 +210,11 @@ definitions:
>         -
>           name: discard
>           value: 31
> +  -
> +    name: port-type
> +    doc: type of physical connector
> +    type: enum
> +    entries: [mdi, sfp]
>   
>   attribute-sets:
>     -
> @@ -1905,6 +1910,32 @@ attribute-sets:
>           name: link
>           type: nest
>           nested-attributes: mse-snapshot
> +  -
> +    name: port
> +    attr-cnt-name: --ethtool-a-port-cnt
> +    attributes:
> +      -
> +        name: header
> +        type: nest
> +        nested-attributes: header
> +      -
> +        name: id
> +        type: u32
> +      -
> +        name: supported-modes
> +        type: nest
> +        nested-attributes: bitset
> +      -
> +        name: supported-interfaces
> +        type: nest
> +        nested-attributes: bitset
> +      -
> +        name: type
> +        type: u32
> +        enum: port-type
> +      -
> +        name: upstream-port
> +        type: u32
>   
>   operations:
>     enum-model: directional
> @@ -2859,6 +2890,30 @@ operations:
>               - worst-channel
>               - link
>         dump: *mse-get-op
> +    -
> +      name: port-get
> +      doc: Get ports attached to an interface
> +
> +      attribute-set: port
> +
> +      do:
> +        request:
> +          attributes:
> +            - header
> +            - id
> +        reply: &port-get-op-reply
> +          attributes:
> +            - header
> +            - id
> +            - supported-modes
> +            - supported-interfaces
> +            - type
> +            - upstream-port
> +      dump:
> +        request:
> +          attributes:
> +            - header
> +        reply: *port-get-op-reply
>   
>   mcast-groups:
>     list:
> diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
> index 393f2b6d3863..eba226c79ec3 100644
> --- a/Documentation/networking/ethtool-netlink.rst
> +++ b/Documentation/networking/ethtool-netlink.rst
> @@ -247,6 +247,7 @@ Userspace to kernel:
>     ``ETHTOOL_MSG_RSS_CREATE_ACT``        create an additional RSS context
>     ``ETHTOOL_MSG_RSS_DELETE_ACT``        delete an additional RSS context
>     ``ETHTOOL_MSG_MSE_GET``               get MSE diagnostic data
> +  ``ETHTOOL_MSG_PORT_GET``              get port information
>     ===================================== =================================
>   
>   Kernel to userspace:
> @@ -305,6 +306,7 @@ Kernel to userspace:
>     ``ETHTOOL_MSG_RSS_CREATE_NTF``           additional RSS context created
>     ``ETHTOOL_MSG_RSS_DELETE_NTF``           additional RSS context deleted
>     ``ETHTOOL_MSG_MSE_GET_REPLY``            MSE diagnostic data
> +  ``ETHTOOL_MSG_PORT_GET_REPLY``           port information
>     ======================================== =================================
>   
>   ``GET`` requests are sent by userspace applications to retrieve device
> @@ -2537,6 +2539,39 @@ Within each channel nest, only the metrics supported by the PHY will be present.
>   See ``struct phy_mse_snapshot`` kernel documentation in
>   ``include/linux/phy.h``.
>   
> +PORT_GET
> +========
> +
> +Retrieve information about the physical connection points of a network device,
> +referred to as "ports". User needs to specify a PORT_ID for the DO operation,
> +in which case the DO request returns information about that specific port.
> +
> +As there can be more than one port, the DUMP operation can be used to list the
> +ports present on a given interface, by passing an interface index or name in
> +the dump request.
> +
> +Request contents:
> +
> +  ===================================== ======  ===============================
> +  ``ETHTOOL_A_PORT_HEADER``             nested  request header
> +  ``ETHTOOL_A_PORT_ID``                 u32     port id
> +  ===================================== ======  ===============================
> +
> +Kernel response contents:
> +
> +  ======================================= ======  =============================
> +  ``ETHTOOL_A_PORT_HEADER``               nested  request header
> +  ``ETHTOOL_A_PORT_ID``                   u32     the port's unique identifier,
> +                                                  per netdevice.
> +  ``ETHTOOL_A_PORT_SUPPORTED_MODES``      bitset  bitset of supported linkmodes
> +  ``ETHTOOL_A_PORT_SUPPORTED_INTERFACES`` bitset  bitset of supported MII
> +                                                  interfaces
> +  ``ETHTOOL_A_PORT_TYPE``                 u32     the port type
> +  ``ETHTOOL_A_PORT_UPSTREAM_PORT``        u32     If any, the index of the MII
> +                                                  port that feeds into this
> +                                                  port.
> +  ======================================= ======  =============================
> +
>   Request translation
>   ===================
>   
> @@ -2647,4 +2682,5 @@ are netlink only.
>     n/a                                 ``ETHTOOL_MSG_PHY_GET``
>     ``SIOCGHWTSTAMP``                   ``ETHTOOL_MSG_TSCONFIG_GET``
>     ``SIOCSHWTSTAMP``                   ``ETHTOOL_MSG_TSCONFIG_SET``
> +  n/a                                 ``ETHTOOL_MSG_PORT_GET``
>     =================================== =====================================
> diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
> index 8134baf7860f..660e0c08a766 100644
> --- a/include/uapi/linux/ethtool_netlink_generated.h
> +++ b/include/uapi/linux/ethtool_netlink_generated.h
> @@ -78,6 +78,14 @@ enum ethtool_pse_event {
>   	ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR = 64,
>   };
>   
> +/*
> + * type of physical connector
> + */
> +enum ethtool_port_type {
> +	ETHTOOL_PORT_TYPE_MDI,
> +	ETHTOOL_PORT_TYPE_SFP,
> +};
> +
>   enum {
>   	ETHTOOL_A_HEADER_UNSPEC,
>   	ETHTOOL_A_HEADER_DEV_INDEX,
> @@ -840,6 +848,18 @@ enum {
>   	ETHTOOL_A_MSE_MAX = (__ETHTOOL_A_MSE_CNT - 1)
>   };
>   
> +enum {
> +	ETHTOOL_A_PORT_HEADER = 1,
> +	ETHTOOL_A_PORT_ID,
> +	ETHTOOL_A_PORT_SUPPORTED_MODES,
> +	ETHTOOL_A_PORT_SUPPORTED_INTERFACES,
> +	ETHTOOL_A_PORT_TYPE,
> +	ETHTOOL_A_PORT_UPSTREAM_PORT,
> +
> +	__ETHTOOL_A_PORT_CNT,
> +	ETHTOOL_A_PORT_MAX = (__ETHTOOL_A_PORT_CNT - 1)
> +};
> +
>   enum {
>   	ETHTOOL_MSG_USER_NONE = 0,
>   	ETHTOOL_MSG_STRSET_GET = 1,
> @@ -893,6 +913,7 @@ enum {
>   	ETHTOOL_MSG_RSS_CREATE_ACT,
>   	ETHTOOL_MSG_RSS_DELETE_ACT,
>   	ETHTOOL_MSG_MSE_GET,
> +	ETHTOOL_MSG_PORT_GET,
>   
>   	__ETHTOOL_MSG_USER_CNT,
>   	ETHTOOL_MSG_USER_MAX = (__ETHTOOL_MSG_USER_CNT - 1)
> @@ -954,6 +975,7 @@ enum {
>   	ETHTOOL_MSG_RSS_CREATE_NTF,
>   	ETHTOOL_MSG_RSS_DELETE_NTF,
>   	ETHTOOL_MSG_MSE_GET_REPLY,
> +	ETHTOOL_MSG_PORT_GET_REPLY,
>   
>   	__ETHTOOL_MSG_KERNEL_CNT,
>   	ETHTOOL_MSG_KERNEL_MAX = (__ETHTOOL_MSG_KERNEL_CNT - 1)

