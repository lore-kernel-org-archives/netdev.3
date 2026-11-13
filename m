Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.76.27.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594383;
	b=IcInzd85yPMaiMBXYyq7vzVwa1IoOvlJQYo7kh8lWdb79w2IeAuApdWV07qQkg9byuSy
	 uSKsTz/Iy6dNy3U+He7srYRQOFFGudtDyiHm2bIdpJY0p1cGP3vg78Yv5p0ZB5iIFSEWi
	 gmhYgjGL0iL79t1RxXRzU5urj/UhiVLyDBBo9Z9CcebaZcZn4kloilrGaZyiV29Qo3iSH
	 DTq2rHN7trBSC6aq1r5dSt+EhBjC8376GETEV4a1MkGoZzhD+OcohiRMW4AkG2oQ6UwDk
	 ez7ku+pH+XllfpDBFuC3e2DQbQHIDvLpKZZ8AT1/RR0yGF00Miz1l3EikSOKs3Rcw4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594383;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=lN6lv10nb8Hj9ZoBc4u2NsxzTta/2A4Lc4QtvNhDqTE=;
	b=nrasmsBwV9PwDbg8TCe3s6RMu9Qh0rgh9qgFaWTBqkSuwcHlAU4oT3Tt+9iblZpZ76Gh
	 sGhvc+fKxc+N2LAN3oelAMvD+E94a0d8Lsi8cnAVkbi5Md8i+MMBz2pFsflTmwsId4rR8
	 eKFV8xsEO1Th9+FgJ8oKpu9Q5LO1UKL2/lvw0T1Yhjxo7b2gyR15nymB0Hy2tEbUokfZy
	 wKl41PFolX6ZX4ySemE2z+HBeVYpxkTqAoUfmlRv/CycfZFcAQyYpjnwVkd7tS/g0Tcgp
	 lzXErLev0t9a2q2ctfYFv+h0oJCG84jlUHM8eIlOQATk9HUbqXTksCZwbAW7prqB8rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=andrei-z.com;
	spf=pass smtp.mailfrom=andrei-z.com;
	dkim=pass header.d=andrei-z.com header.i=@andrei-z.com header.a=rsa-sha256 header.s=sig1 header.b=BFJZkQ+L;
	arc=none smtp.remote-ip=82.76.27.144
Received: from vtj.irix.systems (vtj.irix.systems [82.76.27.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFE860A6F5B
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 18:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBFE860A6F5B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andrei-z.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrei-z.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=andrei-z.com header.i=@andrei-z.com header.a=rsa-sha256 header.s=sig1 header.b=BFJZkQ+L
Received: from MAILGW-DELL.dell.vtj.corp.irix.systems (localhost [127.0.0.1])
	by vtj.irix.systems (Proxmox) with ESMTP id BD2061A3FE;
	Fri, 13 Nov 2026 20:26:14 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andrei-z.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=sig1; bh=lN6lv10nb8Hj9ZoBc4u2
	NsxzTta/2A4Lc4QtvNhDqTE=; b=BFJZkQ+LOFCpFRt8TzjHVkt13Mtf3YgnCFx8
	nkW+TVCLm3TjlTK4HLb8RhnACf0YmPBFUuJesLXZEPhKM2wA/3sea8O+sPdjoQS7
	4c7t+X7hCSKMZ2/azPGT1KST3Y5z3GcjIy3dMuKmBYR1O/BWinOr3cQuwByO4NGD
	048515s5quJOWYXfzpbbT8pblrMwoIAxuiOaSjhJXjhIltrJMV47CUeJ5oAYxa+d
	uF+rSE1lPp8hVTiQ9+b1GFkYm1l2s27jx6szyLTN5xIuQOti24X+OM3JkWwhw4jp
	J+NyTynXHPj8UT0bptionlKenmQt6Qkbs+GKkueROQQxoGgK9Q==
Received: from VTJ-MX.corp.irix.systems (unknown [10.57.36.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by vtj.irix.systems (Proxmox) with ESMTPS id 21F3D1A523;
	Fri, 13 Nov 2026 20:26:14 +0200 (EET)
Received: from workspace.corp.irix.systems (2a02:2f04:1:9c23::c) by
 VTJ-MX.corp.irix.systems (2a02:2f04:1:9c24::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 20:26:13 +0200
From: Andrei-Alexandru Bleortu <me@andrei-z.com>
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [BUG] e1000e: I219 with jumbo MTU: RX CRC errors for unicast DAs not in the RAR (promiscuous/bridged ports)
Date: Fri, 13 Nov 2026 20:26:08 +0200
Message-ID: <20261113182608.24628-1-me@andrei-z.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <87fa6cd1-9a98-4c9b-aab3-6ac782c413fa@intel.com>
References: <87fa6cd1-9a98-4c9b-aab3-6ac782c413fa@intel.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VTJ-MX.corp.irix.systems (2a02:2f04:1:9c24::6) To
 VTJ-MX.corp.irix.systems (2a02:2f04:1:9c24::6)

On 12/11/2026 16:21, Ruinskiy, Dima wrote:
> Would it be possible to ask you to run a few additional tests, if you
> haven't yet?

Hi Dima,

Thanks. Both tests are done, on the same two machines and kernel as
before: host 1 = OptiPlex 7060, host 2 = ProDesk 600 G5. lan0 was taken
out of OVS for the tests, so it was not promiscuous: promiscuity 0,
RCTL 0x06038422 (UPE/MPE clear), against 0x0603843A as an OVS port.
Traffic as before: 1 GiB of TCP over ssh, MSS 8948, from a 10GbE
sender, rx_crc_errors counted per GiB. Unless noted, every run
delivered the full 1 GiB, rx_errors rose by twice rx_crc_errors,
length/align stayed at 0, rx_missed_errors at ~0, and rx_smbus moved
only by its background rate.

Test 1

The upper is a macvlan with a distinct MAC on lan0.13 (a VLAN device
on lan0 that has lan0's MAC), created after lan0 was up. Its address
reaches lan0's unicast list through dev_uc_sync() ("bridge fdb show
dev lan0" lists it). Adding it did not set UPE, so it went to SHRA.

                                                  host 1     host 2
  control: DA = lan0's own MAC (RAR[0])             0          0
  d. DA = the live-added secondary                418, 418   387, 390
  e. same, after ethtool -G lan0 rx 4088            0, 0       0, 0
     (e1000e_down()/e1000e_up(), uppers stay up)
  e. same, after ip link set lan0 down; up        427, 416   394, 385
  for reference, lan0 back in OVS (promiscuous)   416, 424   395, 398

The live-added address behaves like one that is not in the RAR at all,
and a reconfiguration with the address present fixes it.

A plain down/up does not, and I believe that is down to how a
VLAN-stacked address comes back. lan0 down closes the VLAN device, and
vlan_dev_stop() unsyncs its list from lan0. On lan0 up,
e1000_configure() runs e1000e_set_rx_mode() and then e1000_setup_rctl()
before NETDEV_UP reopens the VLAN device and dev_uc_sync() writes the
address back, so it arrives live again. (The workaround runs in
e1000_setup_rctl(); my first mail said e1000_configure_rx(), which was
wrong.) A fix that refreshes the workaround only on reset would miss
this case.

Test 2

lan0's MAC changed to a locally administered address while up and not
promiscuous. The VLAN device carrying the host's IP keeps the original
MAC explicitly, so the original moved to SHRA as a secondary.

                                                  host 1     host 2
  b. DA = the new MAC, changed live               422, 423   379, 399
  c. after a reset (ethtool -G), MAC unchanged      0, 0       0, 0
  d. original MAC restored live                   nothing received
                                                  until the next reset
     after that reset                               0, 0       0, 0
  MAC set while lan0 was down, then up              0, 0       0, 0

So updating RAR[0] in e1000_set_mac() leaves the old CRC seed and the
PHY's copy in place until the next reset.

Step d is worse than CRC errors, and it reproduced every time, on both
hosts. Once the original MAC is written back into RAR[0] while the port
is up, nothing addressed to it is received on any VLAN until the next
adapter reset. A tc ingress counter on lan0 for that DA stays at 0;
rx_crc_errors, rx_errors, rx_missed_errors and rx_smbus do not move;
transmit carries on. The host's IS-IS adjacencies time out on their
hold timer. Without a reset it lasted 4 min 19 s; with the host
resetting the adapter 30 s later it lasted 26-42 s, and a second
secondary address being present made no difference. In that step the
address does two things at once: rar_set() puts it into RAR[0], and
dev_uc_del() removes it from the SHRA slot it held at the last reset,
where the PHY's copy still has it. My guess from the outside is that
the PHY matches the DA against its stale copy and crops it, and the MAC
then finds no valid entry in that slot.

If the analysis holds, the PCH_RAICC and
e1000_copy_rx_addrs_to_phy_ich8lan() refresh looks needed after every
RAR/SHRA write while the jumbo workaround is on, in e1000_set_mac() and
e1000e_write_uc_addr_list(), not only in e1000_configure(). I can test
a patch on both machines.

As before, I ran this with the help of an AI assistant (Claude); the
numbers were measured on my two machines.

Thanks,
Andrei

