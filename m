Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C093B48AE04;
	Tue, 21 Jul 2026 12:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784635919; cv=none; b=GJzgMa+hLWYbtaP758Jf2SrUYrPoJDDtZfoqPXpX6eURaEPf69c1h1Azi/l36xBcjmS1TgPM1WnisXRknHL0SPc4/Pva2Sz6/ulu2y5OJqEd5ZtKRnW70aXqjxejwixd9n+KfRsITeOuCI7pokZnUKiAH1ZAwhw32o3xhPk+dbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784635919; c=relaxed/simple;
	bh=+zHZ5PzmKghukeL8+eHAp5DwJnZO9BWn/3DAJ9VXlpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KI9EbNsnNzn5aXTCDtVZeSwRG0np/f7yEQFM32+p9w7SqPQScOmFWzWEWg8EjIC9qUOEw24VdEAWjg9UAwCXpS/Yo1W5Rm1JuKLMDOkJLKLBe4ol47ji3epvtqtowoa3tmp0tLSXwRtil1cAbAWLxSDOa22LkDxZOqpJjhOuO1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Jv4X/mtn; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Jv4X/mtn"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1D3731A1135;
	Tue, 21 Jul 2026 12:11:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DCFED60368;
	Tue, 21 Jul 2026 12:11:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE78611BD2234;
	Tue, 21 Jul 2026 14:11:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784635912; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=T1tYZTvpzDvMK4rw9RmHIPrKZF4dWTXEwTZdv2ZLscA=;
	b=Jv4X/mtnG7ibsnjwuVog6xUsw2C2LLw8vMlCYMtddRjJxKg5d/8X4erodSaK6ZBPsUE51t
	oZA9WjaUHsPcC7xPM4imRle0MBbvRL2bUSSO+gCXF53DJfX7z544eH6bfa5MWjwJ/6zjAh
	5jz9TNSNbc9tXtraR3ZXCvRimlavknv/j4g0iaBfsYhorhnxoWLQ5+81McFN6IdXmVzLSq
	ka0nTCmfwP9q2lyxQpJtep/zEIkZ3zvTPZFlkzgs8ZypzDW3efnxxC3EgQ0QjhdyNz6bmL
	FReKKqSb0bfp5VZcmt/FB0ExnV+xJZVktmpEuwAAQ6U45hT1iEG57yekwVU2cQ==
Message-ID: <d9ffe027-c3de-4b96-949b-8e9dd4e53dd1@bootlin.com>
Date: Tue, 21 Jul 2026 14:11:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 06/12] net: Document PCS subsystem
To: Christian Marangi <ansuelsmth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Saravana Kannan <saravanak@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20260717065448.1498335-1-ansuelsmth@gmail.com>
 <20260717065448.1498335-7-ansuelsmth@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260717065448.1498335-7-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 7/17/26 08:54, Christian Marangi wrote:
> Add extensive documentation of the new PCS subsystem and the fwnode
> implementation with producer/consumer API.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  Documentation/networking/index.rst |   1 +
>  Documentation/networking/pcs.rst   | 229 +++++++++++++++++++++++++++++
>  2 files changed, 230 insertions(+)
>  create mode 100644 Documentation/networking/pcs.rst
> 
> diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
> index 44a422ad3b05..3fce8f6ac089 100644
> --- a/Documentation/networking/index.rst
> +++ b/Documentation/networking/index.rst
> @@ -28,6 +28,7 @@ Contents:
>     net_failover
>     page_pool
>     phy
> +   pcs
>     sfp-phylink
>     alias
>     bridge
> diff --git a/Documentation/networking/pcs.rst b/Documentation/networking/pcs.rst
> new file mode 100644
> index 000000000000..98592cdee3ef
> --- /dev/null
> +++ b/Documentation/networking/pcs.rst
> @@ -0,0 +1,229 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=============
> +PCS Subsystem
> +=============
> +
> +The PCS (Physical Coding Sublayer) subsystem handles the registration and lookup
> +of PCS devices. These devices contain the upper sublayers of the Ethernet
> +physical layer, generally handling framing, scrambling, and encoding tasks. PCS
> +devices may also include PMA (Physical Medium Attachment) components. PCS
> +devices transfer data between the Link-layer MAC device, and the rest of the
> +physical layer, typically via a serdes. The output of the serdes may be
> +connected more-or-less directly to the medium when using fiber-optic or
> +backplane connections (1000BASE-SX, 1000BASE-KX, etc). It may also communicate
> +with a separate PHY (such as over SGMII) which handles the connection to the
> +medium (such as 1000BASE-T).
> +
> +Remark on usage of .mac_select_pcs and fw_node PCS
> +--------------------------------------------------
> +
> +There are generally two ways to look up a PCS device.
> +
> +1. MAC OP struct .mac_select_pcs (considered legacy)
> +2. firmware node (fwnode) PCS entirely handled by phylink
> +
> +Implementation 1 leaves the entire handling of the PCS to the MAC
> +driver with the selection of the PCS driven by .mac_select_pcs.
> +Custom implementations are required if the PCS is external to the MAC
> +and needs to be handled by a separate driver.
> +
> +This implementation is considered legacy and it's suggested to
> +switch to the new fwnode PCS.

The .mac_select_pcs can be deprecated, with the .fill_available_pcs()
mecanism available, we can keep PCS implems inside the MAC driver when
it makes sense, no ?

If PCSs aren't described in firmware (i.e. DT), we have to use .fill_available_pcs()
without using the fwnode API if I get your code right.

The 'legacy' part is the only remark I have, the rest is all good :)

Maxime

> +
> +Looking up PCS Devices (fwnode implementation)
> +-----------------------------------------------
> +
> +The lookup of a PCS device follows the common producer/consumer implementation
> +used by similar subsystems with a ``#pcs-cells`` on the producer and a
> +``pcs-handle`` property on the consumer::
> +
> +    pcs: pcs {
> +        // ...
> +        #pcs-cells = <0>;
> +    };
> +
> +    ethernet-controller {
> +        // ...
> +        pcs-handle = <&pcs>;
> +    };
> +
> +On :c:func:`phylink_create`, phylink will use the ``num_possible_pcs``
> +value and ``fill_available_pcs`` helper function in
> +:c:struct:`phylink_config` to compose the list of available PCS that can be
> +used for the phylink instance.
> +
> +Phylink will then internally handle the selection of the correct PCS for
> +the requested interface mode based on the interface modes configured in
> +``pcs_interfaces`` in :c:struct:`phylink_config` struct and
> +``supported_interfaces`` in :c:struct:`phylink_pcs` struct.
> +
> +A PCS is considered eligible when the requested interface mode is present
> +in both ``pcs_interfaces`` in :c:struct:`phylink_config` struct and
> +``supported_interfaces`` in :c:struct:`phylink_pcs` struct.
> +
> +``supported_interfaces`` describes all interface modes supported by the MAC,
> +whereas ``pcs_interfaces`` identifies the subset that require PCS selection.
> +
> +For the special implementation where the PCS is internal or part of the MAC
> +and a dedicated driver is not needed, it's possible to leave the implementation
> +of the PCS to the MAC driver and just implement the ``num_possible_pcs``
> +value and ``fill_available_pcs`` helper  function in
> +:c:struct:`phylink_config` referencing the local :c:struct:`phylink_pcs`
> +struct allocated from the MAC driver.
> +
> +Using PCS Devices
> +-----------------
> +
> +It's mandatory to either implement the ``mac_select_pcs`` callback
> +of :c:struct:`phylink_mac_ops` or ``num_possible_pcs`` and ``fill_available_pcs``
> +of :c:struct:`phylink_config` to use a PCS for a MAC.
> +
> +The fwnode implementation exposes simple helpers to parse the PCS from
> +the fwnode :c:func:`fwnode_phylink_pcs_count` and
> +:c:func:`fwnode_phylink_pcs_parse`. The :c:func:`fwnode_phylink_pcs_count` helper
> +takes the fwnode where the ``pcs-handle`` should be parsed and return the
> +number of PCS entries described in the fwnode.
> +The :c:func:`fwnode_phylink_pcs_parse` helper takes three arguments,
> +the fwnode where the ``pcs-handle`` should be parsed, an allocated array
> +of :c:struct:`phylink_pcs` pointer where to put the parsed PCS from the fwnode
> +and the maximum number of PCS to parse.
> +Contrary to :c:func:`fwnode_phylink_pcs_count`, :c:func:`fwnode_phylink_pcs_parse`
> +helper fills the allocated array with ONLY the available PCS and return the
> +number of available PCS found. PCS that returns -ENODEV will be skipped and
> +won't be inserted in the allocated array.
> +
> +A phylink instance may use multiple PCS devices. The maximum number is reported
> +through ``num_possible_pcs``.
> +
> +It's mandatory to specify for what interface a PCS is needed. This can be done
> +by filling the ``pcs_interfaces`` in :c:struct:`phylink_config` struct.
> +If the requested interface mode is not present in this bitmask, phylink does
> +not search for a PCS for  that specific mode. (example MAC doesn't need a PCS
> +for SGMII but require one for USXGMII)
> +
> +With the use of the :c:func:`fwnode_phylink_pcs_parse` a common implementation
> +is the following::
> +
> +   static int mac_fill_available_pcs(struct phylink_config *config,
> +   				                      struct phylink_pcs **available_pcs,
> +					                      unsigned int num_possible_pcs)
> +   {
> +   	struct device *dev = config->dev;
> +
> +   	return fwnode_phylink_pcs_parse(dev_fwnode(dev), available_pcs,
> +						                    num_possible_pcs);
> +   }
> +
> +   static int mac_setup_phylink(struct net_device *netdev)
> +   {
> +      struct phylink_config *config;
> +
> +      // ...
> +
> +      config->dev = &netdev->dev;
> +
> +      // ...
> +
> +      // Parse possible PCS and fill num_possible_pcs.
> +      config->num_possible_pcs = fwnode_phylink_pcs_count(dev_fwnode(&netdev->dev));
> +      config->fill_available_pcs = mac_fill_available_pcs;
> +
> +      __set_bit(PHY_INTERFACE_MODE_INTERNAL, config->supported_interfaces);
> +      __set_bit(PHY_INTERFACE_MODE_SGMII, config->supported_interfaces);
> +      __set_bit(PHY_INTERFACE_MODE_1000BASEX, config->supported_interfaces);
> +      __set_bit(PHY_INTERFACE_MODE_USXGMII, config->supported_interfaces);
> +
> +      // PCS required only for USXGMII
> +      __set_bit(PHY_INTERFACE_MODE_USXGMII, config->pcs_interfaces);
> +
> +      phylink = phylink_create(config, //...
> +
> +It's worth to mention that it's phylink code that takes care of allocating
> +the array of :c:struct:`phylink_pcs` pointer for ``fill_available_pcs``
> +callback based on the value set in ``num_possible_pcs`` for
> +:c:struct:`phylink_config` struct.
> +
> +The ``fill_available_pcs`` callback must not write more than
> +``num_possible_pcs`` entries. The third argument may be used to validate
> +that there is enough space to fill all the available PCS in the passed array
> +of :c:struct:`phylink_pcs` pointer.
> +
> +The ``fill_available_pcs`` callback is called only on :c:func:`phylink_create`
> +and is used only to compose the initial available PCS list. Ownership of PCS
> +is held by phylink and :c:func:`phylink_release_pcs` should be used to release
> +them.
> +
> +Writing PCS Drivers
> +-------------------
> +
> +To write a PCS driver, first implement :c:struct:`phylink_pcs_ops`. Then,
> +register your PCS in your probe function using :c:func:`fwnode_pcs_add_provider`.
> +The :c:func:`fwnode_pcs_add_provider` takes three arguments, the fwnode where
> +the PCS provider should be registered to, a get function to return the requested
> +PCS based on ``#pcs-cells`` and a pointer to reference private data for the get
> +function.
> +
> +The PCS will then be registered to a global list of PCS provider that the
> +PCS fwnode implementation will use to parse it.
> +
> +For the simple case where the PCS driver expose a single PCS,
> +:c:func:`fwnode_pcs_simple_get` can be used as the get function.
> +
> +You must call :c:func:`fwnode_pcs_del_provider` from your remove function and
> +release the PCS from any phylink instance under RTNL lock with
> +:c:func:`phylink_release_pcs`::
> +
> +   fwnode_pcs_del_provider(dev_fwnode(&pdev->dev));
> +
> +	rtnl_lock();
> +
> +	for (i = 0; i < data->num_port; i++) {
> +		struct pcs_port *port = &priv->ports[i];
> +
> +		phylink_release_pcs(&port->pcs);
> +	}
> +
> +	rtnl_unlock();
> +
> +Late PCS registration handling
> +------------------------------
> +
> +It's possible that a PCS becomes available after the MAC finished probing.
> +Contrary to the usual producer/consumer implementation, when a PCS is not
> +registered and can't be found, the fwnode parser helper returns ``-ENODEV``
> +instead of ``-EPROBE_DEFER``.
> +
> +This is to prevent race condition with particular devices that register
> +MAC and PCS with USB or PCIe and require the MAC to be registered before
> +the PCS.
> +
> +The phylink logic correctly handle this special case and keep the phylink
> +instance in a fail condition.
> +
> +The PCS fwnode implementation provides a notifier to which each phylink
> +instance with a non-empty ``pcs_interfaces`` in :c:type:`phylink_config`
> +registers. When a new PCS provider is registered, the notifier is called
> +triggering the :c:func:`pcs_provider_notify` function.
> +
> +Function :c:func:`pcs_provider_notify` will check if the just added PCS
> +should be used by the phylink instance. If it should be used then,
> +it's added to the internal list of available PCS and a phylink major
> +config is forced.
> +
> +If a phylink instance was in a failure state, with the just added PCS
> +now part of the available PCS internal phylink list, provided all other
> +conditions are satisfied, the configuration is retried and the failure
> +condition is cleared.
> +
> +API Reference
> +-------------
> +
> +.. kernel-doc:: include/linux/phylink.h
> +   :identifiers: phylink_pcs
> +
> +.. kernel-doc:: include/linux/pcs/pcs.h
> +   :internal:
> +
> +.. kernel-doc:: include/linux/pcs/pcs-provider.h
> +   :internal:

