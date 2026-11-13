Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794529976;
	b=1KLLy/keS+wuOpCmpbjeJkvcgxpps1NeNJLg5/WF4bBokLJlMPdi294htpwYn3VXJdw4
	 A+rdMQlhyWixCO88Qp3WUzSoLrgRkoJLuRVxRI2X8iHp6fc9GOpDvQi8tCbvBYOY47nYK
	 M0oIiGswreAx8ZEeNoASVOBwYA6CxY+rZBuFGNqMjc2e64COFp+tdt5dWHPztXUW2tLM5
	 dYtahZNi04vOo5iaviA2LzKfkiMKJWxLXEuTx00Rud5hLPq41l7UwzVaOm5hfdIPE9AUU
	 ev0EyppOgXNxE2cq1HRG52iMGgonND3fjI8KbOSsymljIby8RPbjx+21DrXTLboDXUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794529976;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Id4cZ/fw9ZnSbEqbTGJ2RwSlS+8eMOnAd+ziuKc7G3M=;
	b=o8nIEzhmbWzBcvWu9PkLivlsKC9IQm5emaHuyChWtPnP4wnotZnnBDoVhN8CeSGaw2L3
	 GBxlBWDSQvN185wmQ4biYBV1w+bXegeECPnNYkhNJ4kH9VbwzSOcali8IxXrBpc+YSLSV
	 IcCINtuJULHZjeoMLZpmdDSiuWWrbBaGh3VvFvmVYs4IHmgh9IgNj1mNQqinGVJVOQiE+
	 bGjM42LjuvcpF0NRW4/+yDkVMk/2uPWj9/Zm+SuW48gMP9SpH0DOgS7wGEmgXWBe7vJSj
	 1DwwAue3DOOTRaGDbHg3a0+rYOtSP/tcHu/fflz7d8bnRxwO7FYqOTDiOMvms/BRxnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mqWYe3au;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29BA606B7C8
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B29BA606B7C8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mqWYe3au
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-492690dd5daso413361f8f.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794529974; x=1795134774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Id4cZ/fw9ZnSbEqbTGJ2RwSlS+8eMOnAd+ziuKc7G3M=;
        b=mqWYe3auKn/1s8/HsyHs5V0iWVBss0epaa5T5mSTUHIhe1UKvc2hxOGQw/dXl+DLbO
         4zCrRjg2upN5tmpDCeBYPmjJfSoVVE6XeuaBAY0+aJQseuqMmAT4X1IYBUOt0rSvMa2H
         ip1gcxEIMTPY+wh8dTTMORfBvrwPhj/Vx9cbmqEXUdfpiPxSiPsNBT+w4yN2N6Y/4G6d
         z7nk0B7iDWXQD04JJE16dMAhVLL0e5Dg6KXxHGp3vsrZ/3M5cRYtsRG5qYl5gODbVHTL
         5I/Xpb8LTBeL/mTY0AEUsivjecAwzVUQbOkZ/Q2r/h6QIAlGtE/dqcFnq8Stb6SnZym9
         vg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794529974; x=1795134774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Id4cZ/fw9ZnSbEqbTGJ2RwSlS+8eMOnAd+ziuKc7G3M=;
        b=YXStBTHE4tN0bJAxCYEzcvTOxDI6OhSnfyy3BHI2ACIecUMnVlO+cDk9ZkNC5roXyO
         iuBdgbk8uLTBV4Es1ImlKNA968vGUq7jL4uEcYHV/LXv51H9bry5bg9bzuIMEfXzuBl0
         deqFchxDyZIPo265OlbxqV89MIIoxu/V/tozd9/Km7xV61fNYFfQvG01EFzUDKdlZyPJ
         h8PA7uIAKTKpXyy3Oyu9Ow0/PL/COya05BI3EYTyQ0nRJ+U8iFXDIN4M0gWkidwSh9r/
         tQhwDvN3M2IXqh1e63u+ytKQOaH7JtARpq7Gn8Ha7uWYJwYyovNLabCDBzVWOCV4/nbm
         g9cQ==
X-Forwarded-Encrypted: i=1; AL+hErFNgENVgTTx9LA8VY7nI5ms8NShASccBKkoUnOMe5bZZ4xV6QLshCciBcbxKsVxkHITqNIStnc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ObBMvWSHGgcyiyxnDZ2xVwrNq/X9u1yhgdnZMOwk2b6nusLF+
	xh7IjQBbsRLGsTM1BvEiWkOXdIuXt/Lr1w/G+E1dfdCeYx3bPRI8Owno
X-Gm-Gg: AYBFou2ts/T7LUjEfb6Xw2Eyi1jdgOSEg3dhkAQqmxerQK2ieWYBOj+NwLSNW5UqXHZ
	ksjA3nEZnA0jJGfrR44RqoBy4zwMFWEHGOaybtOHvxkk4a5J30Bg28lNDjc2H7fE4y9lqTb1+oE
	HUwfgVv84JjAJ/hCDe8OyUA5MvpQ6phPy2u4fg6lWQsDCevR9Q86SPVxhYhiOslIDPeshq/eDGs
	l8dsgOunu+903vdwQEYRddsVC1l0jYu7ULF9l3YveriljOtNn0zuQrWAmEVfkVObPialazdk5ni
	mfUxK1Jvr61nhkYHGAVBY2GuonPMSsrOpk2i6zGdHzpioSioF8Pe8EDjqwaxlFOkKn3YOWqwR+o
	JXzQLspZvTVa8qSN9QaiARA1ssnZOQb/eshuphyl4JL0Mg7F58OuqxTnMqm0Yx5PiZ/wU2B4iwb
	2h3iobc8bY0uGb5yOWR5shTte5HxcPh2Y4Cfij3NgFiOK6ukT3fW2fD3E51d0I5KqraK4LkQSVB
	P2iYSG861t2PX+i0/L8JstXLdi3HcXR7htmyDONxDoSYQpA22papOUghiQqV9EBhTTQLhQfyjsy
	inmj9vf9iab++VO+Ue9rwtwsVvw8GSwMizEcXy5eJaSiLVhqgimgsNsEpI6aZvNdNnez8xzJtSQ
	YlbBEuTOcoQnhcMPuR/DXv6ccfhgv0ov8ymq9HNwZbs43ja1ZiHONlR6frFv68BvLPA34zJxC2g
	c=
X-Received: by 2002:a05:6000:491c:b0:48b:118e:7454 with SMTP id ffacd0b85a97d-49c70a0f0cbmr2053309f8f.31.1794529974084;
        Thu, 12 Nov 2026 16:32:54 -0800 (PST)
Received: from Ansuel-XPS24.localdomain (host-212-171-11-167.retail.telecomitalia.it. [212.171.11.167])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5f7828a4sm2029768f8f.23.2026.11.12.16.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:32:53 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH net-next v19 10/15] net: Document PCS subsystem
Date: Fri, 13 Nov 2026 01:32:00 +0100
Message-ID: <20261113003217.197757-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113003217.197757-1-ansuelsmth@gmail.com>
References: <20261113003217.197757-1-ansuelsmth@gmail.com>
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

Add extensive documentation of the new PCS subsystem and the fwnode
implementation with producer/consumer API.

Also update the sfp-phylink migration guide.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 Documentation/networking/index.rst       |   1 +
 Documentation/networking/pcs.rst         | 234 +++++++++++++++++++++++
 Documentation/networking/sfp-phylink.rst |  35 ++--
 3 files changed, 246 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/networking/pcs.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 44a422ad3b05..3fce8f6ac089 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -28,6 +28,7 @@ Contents:
    net_failover
    page_pool
    phy
+   pcs
    sfp-phylink
    alias
    bridge
diff --git a/Documentation/networking/pcs.rst b/Documentation/networking/pcs.rst
new file mode 100644
index 000000000000..2cae70231948
--- /dev/null
+++ b/Documentation/networking/pcs.rst
@@ -0,0 +1,234 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+PCS Subsystem
+=============
+
+The PCS (Physical Coding Sublayer) subsystem handles the registration and lookup
+of PCS devices. These devices contain the upper sublayers of the Ethernet
+physical layer, generally handling framing, scrambling, and encoding tasks. PCS
+devices may also include PMA (Physical Medium Attachment) components. PCS
+devices transfer data between the Link-layer MAC device, and the rest of the
+physical layer, typically via a serdes. The output of the serdes may be
+connected more-or-less directly to the medium when using fiber-optic or
+backplane connections (1000BASE-SX, 1000BASE-KX, etc). It may also communicate
+with a separate PHY (such as over SGMII) which handles the connection to the
+medium (such as 1000BASE-T).
+
+Remark on usage of .mac_select_pcs and fw_node PCS
+--------------------------------------------------
+
+There are generally two ways to look up a PCS device.
+
+1. MAC OP struct .mac_select_pcs (considered deprecated)
+2. Internal PCS handling with ``num_possible_pcs`` and ``fill_available_pcs``
+
+Implementation 1 leaves the entire handling of the PCS to the MAC
+driver with the selection of the PCS driven by .mac_select_pcs.
+Custom implementations are required if the PCS is external to the MAC
+and needs to be handled by a separate driver.
+
+Implementation 2 makes the phylink core code to select the PCS
+provided by ``num_possible_pcs`` and ``fill_available_pcs`` either
+via internal MAC handling or firmware node (fwnode)
+
+Implementation 1 is considered deprecated and it's suggested to
+switch to implementation 2 and where possible switch to firmware
+node design.
+
+.. _pcs_fwnode:
+
+Looking up PCS Devices (fwnode implementation)
+-----------------------------------------------
+
+The lookup of a PCS device follows the common producer/consumer implementation
+used by similar subsystems with a ``#pcs-cells`` on the producer and a
+``pcs-handle`` property on the consumer::
+
+    pcs: pcs {
+        // ...
+        #pcs-cells = <0>;
+    };
+
+    ethernet-controller {
+        // ...
+        pcs-handle = <&pcs>;
+    };
+
+On :c:func:`phylink_create`, phylink will use the ``num_possible_pcs``
+value and ``fill_available_pcs`` helper function in
+:c:struct:`phylink_config` to compose the list of available PCS that can be
+used for the phylink instance.
+
+Phylink will then internally handle the selection of the correct PCS for
+the requested interface mode based on the interface modes configured in
+``pcs_interfaces`` in :c:struct:`phylink_config` struct and
+``supported_interfaces`` in :c:struct:`phylink_pcs` struct.
+
+A PCS is considered eligible when the requested interface mode is present
+in both ``pcs_interfaces`` in :c:struct:`phylink_config` struct and
+``supported_interfaces`` in :c:struct:`phylink_pcs` struct.
+
+``supported_interfaces`` describes all interface modes supported by the MAC,
+whereas ``pcs_interfaces`` identifies the subset that require PCS selection.
+
+For the special implementation where the PCS is internal or part of the MAC
+and a dedicated driver is not needed, it's possible to leave the implementation
+of the PCS to the MAC driver and just implement the ``num_possible_pcs``
+value and ``fill_available_pcs`` helper  function in
+:c:struct:`phylink_config` referencing the local :c:struct:`phylink_pcs`
+struct allocated from the MAC driver.
+
+.. _pcs_consumer:
+
+Using PCS Devices
+-----------------
+
+It's mandatory to either implement the ``mac_select_pcs`` callback
+of :c:struct:`phylink_mac_ops` or ``num_possible_pcs`` and ``fill_available_pcs``
+of :c:struct:`phylink_config` to use a PCS for a MAC.
+
+The fwnode implementation exposes simple helpers to parse the PCS from
+the fwnode :c:func:`fwnode_phylink_pcs_count` and
+:c:func:`fwnode_phylink_pcs_parse`. The :c:func:`fwnode_phylink_pcs_count` helper
+takes the fwnode where the ``pcs-handle`` should be parsed and return the
+number of PCS entries described in the fwnode.
+The :c:func:`fwnode_phylink_pcs_parse` helper takes three arguments,
+the fwnode where the ``pcs-handle`` should be parsed, an allocated array
+of :c:struct:`phylink_pcs` pointer where to put the parsed PCS from the fwnode
+and the maximum number of PCS to parse.
+Contrary to :c:func:`fwnode_phylink_pcs_count`, :c:func:`fwnode_phylink_pcs_parse`
+helper fills the allocated array with ONLY the available PCS and return the
+number of available PCS found. PCS that returns -ENODEV will be skipped and
+won't be inserted in the allocated array.
+
+A phylink instance may use multiple PCS devices. The maximum number is reported
+through ``num_possible_pcs``.
+
+It's mandatory to specify for what interface a PCS is needed. This can be done
+by filling the ``pcs_interfaces`` in :c:struct:`phylink_config` struct.
+If the requested interface mode is not present in this bitmask, phylink does
+not search for a PCS for  that specific mode. (example MAC doesn't need a PCS
+for SGMII but require one for USXGMII)
+
+With the use of the :c:func:`fwnode_phylink_pcs_parse` a common implementation
+is the following::
+
+   static int mac_fill_available_pcs(struct phylink_config *config,
+   				                      struct phylink_pcs **available_pcs,
+					                      unsigned int num_possible_pcs)
+   {
+   	struct device *dev = config->dev;
+
+   	return fwnode_phylink_pcs_parse(dev_fwnode(dev), available_pcs,
+						                    num_possible_pcs);
+   }
+
+   static int mac_setup_phylink(struct net_device *netdev)
+   {
+      struct phylink_config *config;
+
+      // ...
+
+      config->dev = &netdev->dev;
+
+      // ...
+
+      // Parse possible PCS and fill num_possible_pcs.
+      config->num_possible_pcs = fwnode_phylink_pcs_count(dev_fwnode(&netdev->dev));
+      config->fill_available_pcs = mac_fill_available_pcs;
+
+      __set_bit(PHY_INTERFACE_MODE_INTERNAL, config->supported_interfaces);
+      __set_bit(PHY_INTERFACE_MODE_SGMII, config->supported_interfaces);
+      __set_bit(PHY_INTERFACE_MODE_1000BASEX, config->supported_interfaces);
+      __set_bit(PHY_INTERFACE_MODE_USXGMII, config->supported_interfaces);
+
+      // PCS required only for USXGMII
+      __set_bit(PHY_INTERFACE_MODE_USXGMII, config->pcs_interfaces);
+
+      phylink = phylink_create(config, //...
+
+It's worth to mention that it's phylink code that takes care of allocating
+the array of :c:struct:`phylink_pcs` pointer for ``fill_available_pcs``
+callback based on the value set in ``num_possible_pcs`` for
+:c:struct:`phylink_config` struct.
+
+The ``fill_available_pcs`` callback must not write more than
+``num_possible_pcs`` entries. The third argument may be used to validate
+that there is enough space to fill all the available PCS in the passed array
+of :c:struct:`phylink_pcs` pointer.
+
+The ``fill_available_pcs`` callback is called only on :c:func:`phylink_create`
+and is used only to compose the initial available PCS list. Ownership of PCS
+is held by phylink.
+
+.. _pcs_producer:
+
+Writing PCS Drivers
+-------------------
+
+To write a PCS driver, first implement :c:struct:`phylink_pcs_ops`. Then,
+register your PCS in your probe function using :c:func:`fwnode_pcs_add_provider`.
+The :c:func:`fwnode_pcs_add_provider` takes three arguments, the fwnode where
+the PCS provider should be registered to, a xlate function to return the requested
+PCS based on ``#pcs-cells`` and a pointer to reference private data for the xlate
+function.
+
+The PCS will then be registered to a global list of PCS provider that the
+PCS fwnode implementation will use to parse it.
+
+For the simple case where the PCS driver expose a single PCS,
+:c:func:`fwnode_pcs_simple_xlate` can be used as the xlate function.
+
+You must call :c:func:`fwnode_pcs_del_provider` from your remove function
+on driver detach.
+
+A devm variant, :c:func:`devm_fwnode_pcs_add_provider`, is available to
+automatically release the PCS provider on driver detach.
+
+It's worth to mention that xlate function MUST reference already allocated
+:c:struct:`phylink_pcs` pointer and MUST NOT dynamically allocate new PCS.
+The returned pointer is used to identify the PCS across provider lookup and
+removal notifications.
+
+Late PCS registration handling
+------------------------------
+
+It's possible that a PCS becomes available after the MAC finished probing.
+Contrary to the usual producer/consumer implementation, when a PCS is not
+registered and can't be found, the fwnode parser helper returns ``-ENODEV``
+instead of ``-EPROBE_DEFER``.
+
+This is to prevent race condition with particular devices that register
+MAC and PCS with USB or PCIe and require the MAC to be registered before
+the PCS.
+
+The phylink logic correctly handle this special case and keep the phylink
+instance in a fail condition.
+
+The PCS fwnode implementation provides a notifier to which each phylink
+instance with a non-empty ``pcs_interfaces`` in :c:type:`phylink_config`
+registers. When a new PCS provider is registered, the notifier is called
+triggering the :c:func:`pcs_provider_notify` function.
+
+Function :c:func:`pcs_provider_notify` will check if the just added PCS
+should be used by the phylink instance. If it should be used then,
+it's added to the internal list of available PCS and a phylink major
+config is forced.
+
+If a phylink instance was in a failure state, with the just added PCS
+now part of the available PCS internal phylink list, provided all other
+conditions are satisfied, the configuration is retried and the failure
+condition is cleared.
+
+API Reference
+-------------
+
+.. kernel-doc:: include/linux/phylink.h
+   :identifiers: phylink_pcs
+
+.. kernel-doc:: include/linux/pcs/pcs.h
+   :internal:
+
+.. kernel-doc:: include/linux/pcs/pcs-provider.h
+   :internal:
diff --git a/Documentation/networking/sfp-phylink.rst b/Documentation/networking/sfp-phylink.rst
index 5bf285d73e8a..306505118eba 100644
--- a/Documentation/networking/sfp-phylink.rst
+++ b/Documentation/networking/sfp-phylink.rst
@@ -311,33 +311,20 @@ this documentation.
 
         priv->pcs = lynx_pcs_create_mdiodev(bus, 0);
 
-    Some PCS can be recovered based on firmware information:
+    PCS that should be recovered based on firmware information should implement
+    the external PCS as a :ref:`PCS provider <pcs_producer>` and reference it
+    with the use of PCS fwnode helper :ref:`PCS fwnode helper <pcs_fwnode>`.
 
-    .. code-block:: c
-
-        priv->pcs = lynx_pcs_create_fwnode(of_fwnode_handle(node));
-
-12. Populate the :c:func:`mac_select_pcs` callback and add it to your
-    :c:type:`struct phylink_mac_ops <phylink_mac_ops>` set of ops. This function
-    must return a pointer to the relevant :c:type:`struct phylink_pcs <phylink_pcs>`
-    that will be used for the requested link configuration:
-
-    .. code-block:: c
-
-        static struct phylink_pcs *foo_select_pcs(struct phylink_config *config,
-                                                  phy_interface_t interface)
-        {
-                struct foo_priv *priv = container_of(config, struct foo_priv,
-                                                     phylink_config);
-
-                if ( /* 'interface' needs a PCS to function */ )
-                        return priv->pcs;
+12. Populate the :c:var:`num_possible_pcs` value and
+    :c:func:`fill_available_pcs` callback and add it to your
+    :c:type:`struct phylink_config <phylink_config>`.
 
-                return NULL;
-        }
+    Refer to :ref:`Documentation/networking/pcs.rst <pcs_consumer>` for
+    further details and examples.
 
-    See :c:func:`mvpp2_select_pcs` for an example of a driver that has multiple
-    internal PCS.
+    Notice that the previous implementation of populating
+    :c:func:`mac_select_pcs` is considered deprecated in favor of the new
+    described above.
 
 13. Fill-in all the :c:type:`phy_interface_t <phy_interface_t>` (i.e. all MAC to
     PHY link modes) that your MAC can output. The following example shows a
-- 
2.55.0

