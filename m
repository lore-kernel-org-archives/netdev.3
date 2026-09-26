Received: from mail-ua2-f42.google.com (mail-ua2-f42.google.com [74.125.226.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C57353A7E
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 19:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790450918; cv=none; b=Y/8y55cPsp9ueMqurnjoIdv3/0AYY9XKumzoLY8Kp/l8AkQbXJc7/CKwg24gWziYfgYvr5mZ9RS5stRJqBpFlrAu52mDOsFFbGyP6+stI6Q7yp99aIf/q0EYPAAIVC3Fa0aawyUvSca2x632OY88SZeWJzfn6CyEnjsi524YO08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790450918; c=relaxed/simple;
	bh=jWbaatrlzr2tvPpahgACpdIDGjc7vCJhTcIQi0LNFnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZrLD77KDnPOS6HuqhDZotPopGuMIhBO0vxAK74lIMZX6fvAy3RWPAWF2cMQTA6BKl0RUUNRAFP/2oUE31/39MxxSIPrvkVed7cRZwO5SK99o8z8eITs804EpVbagwT004dMfpfV1Ey4nmSkFuVX3bXdHVs2FViksA5zNVYllfD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rOL0YX6X; arc=none smtp.client-ip=74.125.226.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOL0YX6X"
Received: by mail-ua2-f42.google.com with SMTP id a1e0cc1a2514c-9863292a2e9so574050241.1
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 12:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790450915; x=1791055715; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WNWlvkXwdZY4JRXL0We+UH8xpfJmnJb7TTAzq987yDc=;
        b=rOL0YX6XADbACNtAKpmucoQ33dpnDaj71dWQD8wErdlFP5iFp3cxkJUgSZMxQsoTXM
         dX6kRSVuGh5wfLPTrV3tNnHm1ZPTXCzjmyVrG0IvoXhZdwRhT0LmxNlWbXz/2YwVhmoQ
         QC2IpxRXYJfdV/D67jNojolsvpr355jrM8eRkNCqsIhpPmS9wrptoEbe1O3u9My0ZugS
         3nUU1P50QjFO8gRdPCfLbiu6IdGl3R2elkRXufIiplzZbeT0WYpg9qzPpq3OMHq4tjzd
         DxkI1YO/10qpzoSL7O/Q2BetIRRgy5jvEQAJcFs/pdjB/YX/ZMH0YgAiO5esp9zuMhHJ
         /PoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790450915; x=1791055715;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WNWlvkXwdZY4JRXL0We+UH8xpfJmnJb7TTAzq987yDc=;
        b=O1em6JJ2HqW/2CqSXgQraVEtcJTgOEJCdkpxlzaLiSwiPGrFSOQiqH7f7o2gKPPyRs
         YT87cUAgS5gd5qVFvOW7xe4HnGIJHrt1DtpM40T5kqFtpqabw0v56zTL63dOjSCHc+/8
         3zLVs6hOyHA8mNDn0bDu+y5Xlbkh1pbMNgghvRzDSx0EUnPaFoYGI9ZzCPsPzN/GjMOa
         3lxPmxt8EeaV1B4NQ1ejChkbsfyevk4+TLkyntzUr+3qMAWc/6Mr2LFEDF7FshtE+MxP
         L/bnntCo4og+dxruE0mjbFhuI3/O4Wg+4lRRhqJ0tYyQEf1uuf07Gc5K2shjTpLDXkMd
         EJHA==
X-Gm-Message-State: AFuF++nr3u8RD5/efTjcfvEC2PQh9TR1Weki3qlHkMFtaKi0Uwnv3g+Z
	4vavNp2LBZg4vGKp7ybNOyiW6PCLJSt/BBMRYeLDuhH6SrzbIsmkqDw+23FELO+8hA==
X-Gm-Gg: AYBFou232BsNKoFNfJFt12y3Yjvpsvdk+pVaJhTLLr9tL0fSLYyftXu8JEkn0iBEsLN
	xZgy5GMM1YByFLltkcyRwgNyOEIRdYAl9MIXdeiiTCXjQmDOeW8oMUxJ4fLKi4stVy3eVuhubBk
	g8khgZPuq0YzT84sZN2ajWlA0Zsv/QwMrwjQ1ErSzhjNjAV2lSRYoV1O96E563M1MAVM8CMF/se
	X+L4Kh0Y64CQI7rrbdzjTvsQlmGKcpQf+gxxuyDhKEAI7b8+2kXf18AcQj3/EQji3PeBsmj4LNK
	188rx6rT+aiNaa5hJNcMdYXUA67G37mVYvrD7zD8mEAftb/TrxLY/uyBdLXXwrEDvtbIllMU5l4
	oqC7EQgfBlXyOx5C2+/znfVBGSopWsVa5dwNZoLyAdrDxIfXoMQMYoDmzU0V7zcIuOu5LCHDVjf
	0hR4YIG5O04Bq/nsk3caIdKIr70mgX0al1CS9pfozPQkDb9nCcSwEjBaceCWfTbtheYoRT/4ftI
	GYnO1fKZT8HDmGSHX5Eyf4EiWW8ptBPRcRmcdWuiL2x22Y=
X-Received: by 2002:a05:6102:1620:b0:7b4:6d48:d8b7 with SMTP id ada2fe7eead31-7b46d48dd14mr154933137.28.1790450915053;
        Sat, 26 Sep 2026 12:28:35 -0700 (PDT)
Received: from matheus-note.localnet ([2804:7f0:84b3:2201:fb27:8354:17d:2bcc])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9861afb8343sm7316373241.5.2026.09.26.12.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 12:28:34 -0700 (PDT)
From: Matheus Sampaio Queiroga <srherobrine20@gmail.com>
To: netdev@vger.kernel.org, Gaoyang Wei <yhyxwgy@gmail.com>
Cc: pbs05 <xuziyougm@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King <linux@armlinux.org.uk>
Subject: Re: [RFC] net: towards a generic PON framework
Date: Sat, 26 Sep 2026 16:28:29 -0300
Message-ID: <WL64BmXtQq-YjPSMpmv81w@gmail.com>
In-Reply-To: <20260926174601.1675-1-yhyxwgy@gmail.com>
References: <20260926174601.1675-1-yhyxwgy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

> Hi all,
> 
> Several efforts now support, or are working towards supporting,
> Passive Optical Network (PON) hardware on Linux and OpenWrt.  I would
> like to ask for feedback on where the kernel/userspace and
> generic/vendor-specific boundaries should be before any implementation
> hardens its own userspace API.
> 
> This RFC is about the ONU/ONT (subscriber) side only.  It is not an
> attempt to design an OLT subsystem.
> 
> Background
> ==========
> 
> PON devices which provide Ethernet user services commonly expose an
> Ethernet datapath to Linux, but the hardware below that interface has
> concepts which do not map directly to ordinary Ethernet networking:
> 
>   - ONU activation and line state;
>   - PLOAM or MPCP;
>   - ONU-ID and Alloc-ID;
>   - T-CONTs and GEM ports for ITU-T PON;
>   - LLIDs for EPON;
>   - encryption/key state;
>   - an OMCI or OAM management channel;
>   - a burst-mode optical frontend.
> 
> Vendor BSPs commonly expose these through private ioctls, private
> procfs/sysfs attributes, vendor-specific libraries, and userspace
> daemons.
> 
> There are now multiple open implementations or implementation efforts,
> so this seems like a useful point to discuss which concepts, if any,
> should become common Linux abstractions.
> 
> Current implementations and related work
> ========================================
> 
> One implementation currently targets Airoha AN7581/AN7583:
> 
>   https://github.com/pbs05/openwrt-pon-drivers
>   https://github.com/pbs05/openwrt-pon-userspace
>   https://github.com/pbs05/ponwrt
> 
> It separates the Ethernet datapath from the management plane.  The
> kernel handles the PON MAC, line activation/PLOAM, hardware GEM/T-CONT
> state, and the hardware datapath, while the G.988 OMCI implementation
> and service provisioning are in userspace.
> 
> Raw OMCI PDUs are exposed through a dedicated net_device without a
> synthetic Ethernet header and are received and transmitted by
> userspace with AF_PACKET.
> 
> pbs05, the author of that implementation, has reviewed the description
> of its current architecture in this RFC.
> 
> There is also ongoing EcoNet/Airoha work for older PON hardware,
> including an xPON MAC/PHY implementation and OMCI work in the OpenWrt
> Airoha target:
> 
>   https://github.com/openwrt/openwrt/pull/20104
> 
> Benjamin Larsson previously raised the closely related question of the
> API between an xPON MAC and a fixed laser driver/BOSA or an SFP module
> [1].
> 
> These efforts do not necessarily make the same architectural choices.
> That is one reason I would like to discuss the common boundary before
> turning any one implementation into a generic kernel API.
> 
> Goals and non-goals
> ===================
> 
> My current preference is for any generic PON layer to be deliberately
> small and to reuse existing Linux subsystems wherever possible.
> 
> In particular, this RFC is not proposing to:
> 
>   - implement the G.988 managed-entity model in the kernel;
>   - standardize timing-critical XGTC, FEC, burst timing, or DBA logic;
>   - replace bridge, VLAN, TC, ethtool, hwmon, thermal, PHY, or SFP
>     infrastructure with PON-specific equivalents;
>   - require different PON MACs to implement activation in the same way;
>   - define an OLT-side architecture.
> 
> The question is instead whether Linux needs a small common model for
> PON-specific line state and bearer resources, and how that model should
> interact with existing networking and optical subsystems.
> 
> Possible layering
> =================
> 
> A possible split looks like this:
> 
>                          userspace
> 
>                  +----------------------+
>                  | OMCI / OAM software  |
>                  +----------+-----------+
>                             |
>                      management PDUs
>                             |
>   ================================================================
>                             |
>                           kernel
>                             |
>                  +----------+----------+
>                  |                     |
>            PON-specific            Ethernet
>            control plane           datapath
>                  |                     |
>           vendor PON driver        net_device
>                  |                     |
>            MAC / PCS / PMA     bridge / VLAN / TC
>                  |
>           optical frontend
>              /         \
>            SFP       fixed BOSA/laser driver
> 
> Where the user-facing service is Ethernet, its datapath should remain
> an ordinary net_device.  Linux should not need to understand XGTC
> framing, burst timing, or FEC in order to forward Ethernet packets.
> 
> Hardware which implements those functions should continue to do so,
> with the vendor driver programming the corresponding hardware state.
> 
> A PON-specific kernel interface, if one is needed, would then expose
> only concepts which cannot reasonably be represented by an existing
> Linux subsystem.
> 
> Potential generic concepts
> ==========================
> 
> For ITU-T PON, possible common concepts include:
> 
>   - PON protocol/mode;
>   - line/activation state;
>   - ONU identity;
>   - Alloc-ID / T-CONT resources;
>   - GEM ports;
>   - management-channel association;
>   - security/key-slot state where software must program the MAC.
> 
> For EPON, the equivalent model would include LLIDs and MPCP state.
> 
> I do not think all protocol state necessarily needs to become generic
> kernel code.  For example, one PON MAC may require software to
> participate in PLOAM processing while another may implement most of
> the same state machine in hardware or firmware.
> 
> A generic layer could therefore expose common state and resources
> without requiring every driver to implement activation in the same
> way.
> 
> OMCI and management packet transport
> ====================================
> 
> For ITU-T PON, I would prefer to keep the G.988 managed-entity model,
> MIB handling, and service provisioning logic in userspace.
> 
> OMCI is a packet-oriented management protocol.  The AN7581/AN7583
> implementation mentioned above exposes raw OMCI PDUs through a
> dedicated net_device, without an artificial Ethernet header, and uses
> AF_PACKET in userspace.
> 
> This has some useful properties:
> 
>   - the kernel does not need to understand G.988 managed entities;
>   - operator/vendor-specific MEs do not become part of a kernel ABI;
>   - packet capture and protocol analysis are straightforward;
>   - retransmission, MIB handling, and service graph resolution remain
>     outside the hardware driver.
> 
> I am not claiming that a net_device is necessarily the correct
> upstream ABI.  I would particularly appreciate feedback on whether a
> packet-oriented network interface is appropriate, or whether another
> existing interface, Generic Netlink, or a character device would be a
> better fit.
> 
> EPON OAM is a different protocol and need not share OMCI semantics or
> userspace code.  The question is only whether management protocols of
> this kind should use a common packet-oriented transport model where
> the hardware requires host processing.
> 
> Reuse of existing subsystems
> ============================
> 
> I would like to avoid putting functionality into a PON layer when
> Linux already has an appropriate abstraction.
> 
> For example:
> 
>   Ethernet service traffic  -> net_device
>   VLAN/bridging             -> bridge / 8021q
>   packet classification     -> TC where possible
>   Ethernet statistics       -> ethtool
>   pluggable optics          -> SFP infrastructure
>   fixed-front-end telemetry -> hwmon
>   thermal policy            -> thermal subsystem, where applicable
>   factory calibration       -> NVMEM where appropriate
> 
> In particular, temperature, supply voltage, laser bias, and RX/TX
> optical power from a fixed optical frontend should not require
> PON-specific ioctls merely because the sensor is part of an ONU.
> 
> A fixed BOSA/laser driver still needs a way to communicate
> link-relevant events such as LOS, TX enable, and burst-enable state to
> the PON MAC.  How this should interact with the existing PHY, phylink,
> and SFP infrastructure is one of the questions I would like to
> discuss.
> 
> Datapath provisioning
> =====================
> 
> Another open question is where service classification ends and PON
> bearer configuration begins.
> 
> An OMCI userspace implementation may resolve managed entities into a
> service relation similar to:
> 
>         VLAN / priority
>                |
>                v
>             GEM port
>                |
>                v
>             T-CONT
> 
> The GEM port and T-CONT are PON-specific bearer resources, and many
> implementations represent them in hardware.
> 
> The VLAN and packet classification are not PON-specific.
> 
> It therefore seems undesirable to create a new generic PON packet
> classifier if TC, bridge, and VLAN offload can express that part of
> the configuration.
> 
> What remains unclear is the cleanest way for an existing Linux
> classification rule to select or reference a PON bearer, especially
> on hardware where that mapping is offloaded into the same DMA/QDMA
> engine as the Ethernet datapath.
> 
> Questions
> =========
> 
> I would particularly appreciate feedback on the following points:
> 
> 1. Does Linux need a struct pon_device or equivalent at all, or can
>    the required concepts be represented by existing networking
>    objects?
> 
> 2. If there is a generic PON object model, how much should it expose?
>    Are T-CONT, GEM, and LLID appropriate generic objects, or are they
>    too close to individual protocols or hardware implementations?
> 
> 3. Should OMCI management PDUs be represented by a packet-oriented
>    interface?  If so, is a dedicated net_device appropriate?
> 
> 4. Should PLOAM/MPCP activation remain driver-specific, with only
>    common line state exposed by a generic layer?
> 
> 5. What should the interface between a PON MAC and fixed optical
>    frontends look like, and how much should be shared with SFP,
>    phylink, PHY, hwmon, and thermal infrastructure?
> 
> 6. How should classification into GEM/LLID bearers interact with TC
>    and existing hardware-offload APIs?
> 
> 7. How much should the ITU-T PON family and IEEE EPON family share in
>    one object model?  It would be useful to avoid both
>    protocol-specific private APIs and an abstraction so generic that
>    it no longer represents the hardware usefully.
> 
> 8. Which configuration belongs in a networking control API
>    (rtnetlink, Generic Netlink, etc.), and which state should only be
>    observable through existing kernel subsystems?
> 
> Next steps
> ==========
> 
> I am intentionally not proposing a UAPI or struct definitions in this
> mail.
> 
> There is working code which can be used as a reference implementation,
> but I would prefer to get agreement on the subsystem boundary before
> turning one vendor implementation into an API which other PON drivers
> would later have to follow.
> 
> If the overall direction makes sense, the next step could be a small
> RFC patch series containing only the minimum generic model together
> with one real hardware consumer, rather than attempting to upstream a
> complete PON stack at once.
> 
> I would also be very interested in hearing from developers working on
> non-Airoha PON hardware.  A second independent hardware family would
> be particularly useful for determining whether any proposed
> abstraction is genuinely generic rather than an Airoha interface with
> generic names.
> 
> References
> ==========
> 
> [1] Benjamin Larsson, "[RFC] Question regarding api between xpon mac
>     and laser driver/BOSA"
> 
>     https://lore.kernel.org/r/1c774b8f-3e4d-447c-9a93-be554811cbf0@genexis.eu/
> 
> Thanks,
> Gaoyang Wei
>

Hello everyone, in my implementation part I have a system controlled by the kernel, without userspace for OMCI, everything being handled and controlled by the kernel, and having a Netlink Generice and some links in sysfs for communication with userspace for OMCI configurations with an abstraction based on what we have defined in the ITU.

I'm creating two new subsystems to control LDDLA (optical) and xPON, with them we have a way of abstracting and maintaining a standard among other platforms, not just Airoha, but all others. my OMCI follows the standard we have in the ITU and for configuration I keep a large part of the subsystem independent. Until now defining GPON and

In total, I have tests on the Airoha en7523, en751221 and en7528, tests with the en7580 family are coming as soon as I managed to test on an SBC in which I can upload the kernel.

this is my implementation:

                         userspace
                    sysfs / Generic Netlink
                              |
                              v
                    +---------------------+
                    |      net/xpon       |
                    |  struct xpon_device |
                    |---------------------|
                    | mode: GPON / EPON   |
                    | registration state  |
                    | carrier             |
                    | signal / LOS        |
                    | notifier / LEDs     |
                    +----+-----------+----+
                         |           |
              GPON       |           |       EPON
                         |           |
          +--------------+           +--------------+
          |                                         |
          v                                         v
 +-------------------+                     +-------------------+
 |   GPON PLOAM FSM  |                     |   EPON MPCP FSM   |
 | airoha_ploam.c    |                     | airoha_xpon.c     |
 |-------------------|                     |-------------------|
 | O1 -> O2 -> O3    |                     | discovery GATE    |
 |    -> O4 -> O5    |                     | REGISTER_REQUEST  |
 | ONU-ID / ranging  |                     | REGISTER / ACK    |
 | Alloc-ID / OMCC   |                     | LLID[0..7]        |
 +----+---------+----+                     +---------+---------+
      |         |                                    |
      |         | set OMCC/GEM                       |
      |         v                                    v
      |  +-----------------------+       +-----------------------+
      |  |     net/xpon/omci     |       |     net/xpon/oam      |
      |  |  struct omci_device   |       |   struct xpon_oam     |
      |  |-----------------------|       |-----------------------|
      |  | in-kernel OMCI agent  |       | per-LLID state        |
      |  | G.988 MIB / MEs       |       | 802.3ah OAMPDU        |
      |  | OLT profiles/quirks   |       | Information TLV       |
      |  | T-CONT / GEM / UNI    |       | remote OAM info       |
      |  | VLAN service graph    |       +-----------+-----------+
      |  +-----------+-----------+                   |
      |              | omci_device_ops               |
      |              v                               |
      |  +-----------------------+                   |
      |  | airoha_gpon_omci.c    |                   |
      |  | transport/backend     |                   |
      |  +-----------+-----------+                   |
      |              |                               |
      +--------------+---------------+---------------+
                                     |
                                     v
                       +---------------------------+
                       |     Airoha xPON MAC       |
                       |      airoha_xpon.c        |
                       |---------------------------|
                       | GPON MAC / PLOAM FIFO     |
                       | EPON MAC / MPCP / LLIDs   |
                       | GEM / T-CONT programming  |
                       +-------------+-------------+
                                     |
                    +----------------+----------------+
                    |                                 |
                    v                                 v
          +----------------------+       +-------------------------+
          | digital xPON PHY     |       | optical_frontend        |
          | phy-airoha-xpon.c    |       | BOSA / laser frontend   |
          |----------------------|       |-------------------------|
          | GPON / EPON mode     |       | protocol / wavelength   |
          | SERDES / CDR         |       | TX enable / rearm       |
          | burst timing         |       | TX calibration          |
          | preamble / EQD       |       | optical telemetry       |
          | FEC / signal / LOS   |       | temp / bias / TX/RX pwr |
          +----------+-----------+       +------------+------------+
                     \                            /
                      \                          /
                       +-----------+------------+
                                   |
                                   |
                                  OLT

in Airoha, GEMs and PVID/VLAN are handled by the PSE/FE/QDMA itself

in en7523.dtsi have this nodes in dts:

xpon_phy: phy@1faf0000 {
	compatible = "airoha,en7523-xpon-phy";
	reg = <0x1faf0000 0x5000>;

	pinctrl-names = "default";
	pinctrl-0 = <&pon_pinctrl>;

	resets = <&scuclk EN7523_XPON_PHY_RST>;
	reset-names = "phy";

	airoha,scu = <&scuclk>;

	tx-disable-gpios = <&pinctrl 16 GPIO_ACTIVE_HIGH>;

	#phy-cells = <0>;

	status = "disabled";
};

xpon: xmac@1fb60000 {
	compatible = "airoha,en7523-xpon";

	reg = <0x1fb60000 0x10000>;
	reg-names = "mac";

	interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
	             <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
	interrupt-names = "mac", "dying-gasp";

	resets = <&scuclk EN7523_XPON_MAC_RST>;
	reset-names = "mac";

	phys = <&xpon_phy>;
	phy-names = "xpon";

	ethernet = <&gdm2>;
	airoha,scu = <&scuclk>;

	status = "disabled";
};

eth: ethernet@1fb50000 {
  ...
	gdm2: ethernet@2 {
		compatible = "airoha,eth-mac";
		reg = <2>;
		pcs-handle = <&pon_pcs>;

		status = "disabled";
	};
  ...
};

in devices dts:

&i2c0 {
	status = "okay";

	en7571: lddla@70 {
		compatible = "airoha,en7571";
		reg = <0x70>;

		nvmem-cells = <&en7571_bob>;
		nvmem-cell-names = "calibration";
		
		#optical-frontend-cells = <0>;
	};
};

&xpon_phy {
	status = "okay";
};

&xpon {
	status = "okay";

	airoha,gpon-serial-from-mac;
	omci-vendor-id = "TPLG";

	optical-frontends = <&en7571>;
	optical-frontend-names = "pon";

	leds = <&xpon_status>, <&los>;
	led-names = "pon", "los";
};

&gdm2 {
	status = "okay";
	phy-mode = "internal";

	nvmem-cells = <&macaddr 0>;
	nvmem-cell-names = "mac-address";

	/delete-property/ pcs-handle;
};


