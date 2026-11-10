Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320746;
	b=UNdSWLfSO3EtuaN7hYUVlTmhw6DgrfAS6OXh8FKGdNhiNo3va7Gyq4Kl9D1u1zT0phpj
	 VKAsymFmEvb80zzCmwO9cJw7vOMv9bpoqUCsKsqs2AE2RYamCPdY2zRYdFKEGsFKls3AR
	 FIvf3KrY2Y3MTgBZMJ17dIME1xUhHIrOkgPBe/ragx3T2MyW+Pe2eb6VRJzL3alWLV73S
	 P1MiCNa1HKuVAipTPA8h3+/aQJ/r9WFLZ98mp9vRdSFNRLwcKrB975cQ3UvK819Tz/kLw
	 oaka2v23v2fa6ToGIZAvEZHdeMNsASLOtsLaCZRgoImqOPnHCGLW+Rq4/vR9qQspuKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=0fRNQDVGjJgk8redEbZ04GPomv+Aw6pJ0y4vpAEqqJ4=;
	b=r1Dz1Dza6UnVaG1N3HyUSRex6JW/qrWX+hvclCilIoao/9rgd3a/9Yds5OV/HVEwMGiH
	 /r/KUzMesDJ8pt8hvPDF4apDHhYVhuex+QhgJIv6QMtjUrhvvXIm0TvZrAwKuX4YH9tCT
	 i8GowJrKJbjjlIpUhXjp5sT6OWG+6S3nWnpQab+lf4dBLooxwTxzTvMRnzciNY5CU3X1m
	 13uTnq4hEEjawHtwANbWNaeE9T5PDLBCH7B1UoFWD5AtJ4mRwfvkc+ZKMmjWsOPp2C2pN
	 Pe77ZZMqqm7+53TMdQSjJvOk0hcmPNEtnW4OspYhGAtA0ChMPjuX8dikyF6oRDJ+Klg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L57Wy4gb;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BCB60A2627
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8BCB60A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L57Wy4gb
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-14394530ec6so2736539c88.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 06:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794320745; x=1794925545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0fRNQDVGjJgk8redEbZ04GPomv+Aw6pJ0y4vpAEqqJ4=;
        b=L57Wy4gbToD+KekgKABd8bwcOXvgoecKsLqapHyxRFRCn8TD74A4slYjZAwBn0m8YU
         ziXbA6LWt2DfNHm4ESWOIPDHAVzY34BXn7rK9J2fykjk0tr1VTQ7VZqE0w7Eq30cG8Ku
         fAwBajul5tXCMLhkeeWePbipGb1VkvGgGQByqdUJzZpCl1vHB62ADJIVw+uVIwkNxLQa
         3cIVGfpPfQ8FxTT2jkTjCzQjOOPj9QrD8MOhwx/C3zK2NuOQnRK8WVVClV1nmRYKzH2T
         tJTt40GoQ6IRHJfTc5r5qCvnW1t3ieje+FquF6uzAu1TYnE+NoFuIT4hoWGzQuKGBbmZ
         GRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794320745; x=1794925545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0fRNQDVGjJgk8redEbZ04GPomv+Aw6pJ0y4vpAEqqJ4=;
        b=n4OFqeqIsaxalB/Cvp9afuwVN0dK+NYNW4QFWsKdiKHsyrXJBWrW+lW4IAO/0/AERK
         X25k+btQ9QhkR5SyzDv1dl5Orx/2HrMEMa5JfoWiCQ0M3twrWZAlGEnY/gVnJzwoMuLN
         5HjXrnTihOxHSU991HDPemekzEFs2YCb8VOqAO54bTrqaRPsNjeOAks3A6Mfbb1YZB9p
         nC2bH7SuVPyT9ZRbu24m7q04MTjI0bHaFx4MPTflZfmWetdzQ+qm7n6ZsnkLaiQeCcuQ
         X/SUsaVMTeWcpgcjlwnSGbzX9lDn0QzZXQVeBCsHFOyYtr0KDUPH0+iKr9yxhWWeOjpI
         r3RQ==
X-Gm-Message-State: APuU4Z/Hx/NJHUg2nnZCxS0K8SwyfWSqZSaXhRmw3pv5aIEKyHU9wT4t
	QyIcVkvbmNNix98Qxcs7VaoPEkvn/J9ElMVQ8qyqmcU8eckI4nJz+jXxewJj3X9n4Jo=
X-Gm-Gg: AYBFou1gQNyiQS7xGGgPYOrveXYDRNqgs5NBo3yibPZ4R5luj8dvPjNwlr5Lp9FDLUd
	0MTLMJJ2iCCxZfNyydaudfThEOkB2hWzA1yBMYqI6eWDvAo+qL7/Vu4UiqneZ2CIJykf3ddzyqN
	/QXudGZ/cN+rrbnlgiDkcnjsOqrbMxQW7IR+ctgSpCx7USTm2UeFUGPUAmEdXH4pVYhF1yse41U
	kGKIyPl1xwbaZTx/FtK2HlBo7683fbQWmpbnO2BsYRpn2owcDOMrsHANR68Z6fP6dgkxjJ0peXV
	Xy1fc6NsADWX8/kfOWDbZAExI04wWNYdNr+Nm2e8CLGWHfvckxRTXMxwdFHNOt1ARJvmaDpNOfN
	uX/VqrBRoTzBdYpP/z1nlTIaQY84Y1jBhH4tp1wCSknRp8UDrVcMZTmewkAs2jeS4Dg39BZn+yQ
	95ly/pVAKzbaYe7NiN10JlHqU3OkVzJ9NAP+pStuIFxku299QIhP/0zjGVLlN2EMcat42hLyNm2
	SYyj5T+b3PWSw01FZ9L/7+h6q6JvInpBqg50GCUa+U9ZwSfB+FGr8g1uPK8Gf2FlKyO13UMU4SH
	FtyZzsEwP/hfEgSv/HtCJ50IR3XLmqBVykW440S3tvswtqyXlzebeFeQ0Z2HIVSwTRA=
X-Received: by 2002:a05:701b:2718:b0:15c:1679:1cc7 with SMTP id a92af1059eb24-1b3b6176166mr4166861c88.37.1794320744677;
        Tue, 10 Nov 2026 06:25:44 -0800 (PST)
Received: from ptathe-thinkpadt14gen4.redhat.corp ([2401:4900:8966:ebf7:43d:c928:a024:b9a9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm8408885c88.4.2026.11.10.06.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:25:44 -0800 (PST)
From: Pranav Tathe <pranavtathe30@gmail.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	pranavtathe30@gmail.com
Subject: [PATCH iproute2-next] ip-link: document BOND type options in man page
Date: Tue, 10 Nov 2026 19:55:27 +0530
Message-ID: <20261110142527.257436-1-pranavtathe30@gmail.com>
X-Mailer: git-send-email 2.56.0
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

The ip-link(8) man page documents master-side creation options for many
link types but has no "BOND Type Support" section, leaving the bond master
options (mode, miimon, arp_*, xmit_hash_policy, lacp_*, ad_*,
coupled_control, broadcast_neighbor, lacp_strict, arp_missed_max, ...)
undocumented, even though a "Bonding Slave Support" section already exists.

Add a "BOND Type Support" section modelled on "BRIDGE Type Support",
describing every bond master option accepted by iplink_bond.c. Option
descriptions are sourced from the kernel bonding documentation
(Documentation/networking/bonding.rst).

Signed-off-by: Pranav Tathe <pranavtathe30@gmail.com>
---
 man/man8/ip-link.8.in | 392 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 392 insertions(+)

diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index 719781bd..5fa7c6f8 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -1764,6 +1764,398 @@ Redundancy Protocol (PRP).
 .
 .in -8
 
+.TP
+BOND Type Support
+For a link of type
+.I BOND
+the following additional arguments are supported:
+
+.BI "ip link add " DEVICE " type bond "
+[
+.BI mode " BONDMODE "
+] [
+.BI active_slave " SLAVE_DEV "
+] [
+.B clear_active_slave
+] [
+.BI miimon " MIIMON "
+] [
+.BI updelay " UPDELAY "
+] [
+.BI downdelay " DOWNDELAY "
+] [
+.BI peer_notify_delay " DELAY "
+] [
+.BI use_carrier " USE_CARRIER "
+] [
+.BI arp_interval " ARP_INTERVAL "
+] [
+.BI arp_validate " ARP_VALIDATE "
+] [
+.BI arp_all_targets " ARP_ALL_TARGETS "
+] [
+.BI arp_ip_target " [ ARP_IP_TARGET, ... ] "
+] [
+.BI ns_ip6_target " [ NS_IP6_TARGET, ... ] "
+] [
+.BI primary " SLAVE_DEV "
+] [
+.BI primary_reselect " PRIMARY_RESELECT "
+] [
+.BI fail_over_mac " FAIL_OVER_MAC "
+] [
+.BI xmit_hash_policy " XMIT_HASH_POLICY "
+] [
+.BI resend_igmp " RESEND_IGMP "
+] [
+.BI num_grat_arp|num_unsol_na " NUM_PEER_NOTIF "
+] [
+.BI all_slaves_active " ALL_SLAVES_ACTIVE "
+] [
+.BI min_links " MIN_LINKS "
+] [
+.BI lp_interval " LP_INTERVAL "
+] [
+.BI packets_per_slave " PACKETS_PER_SLAVE "
+] [
+.BI tlb_dynamic_lb " TLB_DYNAMIC_LB "
+] [
+.BI lacp_rate " LACP_RATE "
+] [
+.BI lacp_active " LACP_ACTIVE "
+] [
+.BI coupled_control " COUPLED_CONTROL "
+] [
+.BI broadcast_neighbor " BROADCAST_NEIGHBOR "
+] [
+.BI ad_select " AD_SELECT "
+] [
+.BI ad_user_port_key " PORTKEY "
+] [
+.BI ad_actor_sys_prio " SYSPRIO "
+] [
+.BI ad_actor_system " LLADDR "
+] [
+.BI lacp_strict " LACP_STRICT "
+] [
+.BI arp_missed_max " MISSED_MAX "
+]
+
+.in +8
+.sp
+.BI mode " BONDMODE "
+- specifies one of the bonding policies. Possible values are
+.BR balance-rr " (0), " active-backup " (1), " balance-xor " (2), "
+.BR broadcast " (3), " 802.3ad " (4), " balance-tlb " (5) and "
+.BR balance-alb " (6). "
+The default is
+.BR balance-rr .
+
+.BI active_slave " SLAVE_DEV "
+- specifies the new active slave for modes that support it
+.RB ( active-backup ", " balance-alb " and " balance-tlb ). "
+.I SLAVE_DEV
+is the name of an existing slave interface.
+
+.B clear_active_slave
+- clears the active slave, letting the bonding driver select the active
+slave on its own.
+
+.BI miimon " MIIMON "
+- specifies the MII link monitoring frequency in milliseconds. This
+determines how often the link state of each slave is inspected for link
+failures. A value of zero disables MII link monitoring. A value of 100
+is a good starting point. The default value is
+.BR 0 .
+
+.BI updelay " UPDELAY "
+- specifies the time, in milliseconds, to wait before enabling a slave
+after a link recovery has been detected. This option is only valid for
+the
+.I miimon
+link monitor. The
+.I updelay
+value should be a multiple of the
+.I miimon
+value; if it is not, it will be rounded down to the nearest multiple. The
+default value is
+.BR 0 .
+
+.BI downdelay " DOWNDELAY "
+- specifies the time, in milliseconds, to wait before disabling a slave
+after a link failure has been detected. This option is only valid for
+the
+.I miimon
+link monitor. The
+.I downdelay
+value should be a multiple of the
+.I miimon
+value; if it is not, it will be rounded down to the nearest multiple. The
+default value is
+.BR 0 .
+
+.BI peer_notify_delay " DELAY "
+- specifies the delay, in milliseconds, between each peer notification
+(gratuitous ARP and unsolicited IPv6 Neighbor Advertisement) when they
+are issued after a failover event. This delay should be a multiple of the
+.I miimon
+value. The valid range is 0 - 300000. The default value is
+.BR 0 ,
+which means to match the value of the MII link monitor interval.
+
+.BI use_carrier " USE_CARRIER "
+- obsolete option that previously selected between MII/ETHTOOL ioctls and
+.BR netif_carrier_ok ()
+to determine link state. All link state checks are now done with
+.BR netif_carrier_ok ().
+For backwards compatibility the value may still be inspected or set; the
+only valid setting is
+.BR 1 .
+
+.BI arp_interval " ARP_INTERVAL "
+- specifies the ARP link monitoring frequency in milliseconds. A value of
+0 disables ARP monitoring. ARP monitoring should not be used in
+conjunction with
+.IR miimon .
+The default value is
+.BR 0 .
+
+.BI arp_validate " ARP_VALIDATE "
+- specifies whether or not ARP probes and replies should be validated, or
+whether non-ARP traffic should be filtered (disregarded) for link
+monitoring purposes. Possible values are
+.BR none " (0), " active " (1), " backup " (2), " all " (3), "
+.BR filter " (4), " filter_active " (5) and " filter_backup " (6). "
+The default value is
+.BR none .
+
+.BI arp_all_targets " ARP_ALL_TARGETS "
+- specifies the quantity of
+.I arp_ip_target
+addresses that must be reachable in order for the ARP monitor to consider
+a slave as being up. This option affects only
+.B active-backup
+mode for slaves with
+.I arp_validate
+enabled. Possible values are
+.B any
+(0), consider the slave up when any of the targets is reachable, and
+.B all
+(1), consider the slave up only when all of the targets are reachable.
+
+.BI arp_ip_target " [ ARP_IP_TARGET, ... ] "
+- specifies the IPv4 addresses to use as ARP monitoring peers when
+.I arp_interval
+is greater than 0. These are the targets of the ARP requests sent to
+determine the health of the link. Multiple addresses must be separated by
+a comma. At least one address must be given for ARP monitoring to
+function, and a maximum of 16 targets may be specified.
+
+.BI ns_ip6_target " [ NS_IP6_TARGET, ... ] "
+- specifies the IPv6 addresses to use as NS/NA monitoring peers when
+.I arp_interval
+is greater than 0. These are the targets of the NS requests sent to
+determine the health of the link. Multiple addresses must be separated by
+a comma. At least one address must be given for NS/NA monitoring to
+function, and a maximum of 16 targets may be specified.
+
+.BI primary " SLAVE_DEV "
+- specifies which slave is the primary device.
+.I SLAVE_DEV
+is the name of an existing slave interface. The specified device will
+always be the active slave while it is available; only when it is off-line
+will alternate devices be used. This option is only valid for
+.BR active-backup ", " balance-tlb " and " balance-alb " modes. "
+
+.BI primary_reselect " PRIMARY_RESELECT "
+- specifies the reselection policy for the primary slave. This affects how
+the primary slave is chosen to become the active slave when failure of the
+active slave or recovery of the primary slave occurs. This option is
+designed to prevent flip-flopping between the primary slave and other
+slaves. Possible values are
+.BR always " (0), " better " (1) and " failure " (2). "
+The default value is
+.BR always .
+
+.BI fail_over_mac " FAIL_OVER_MAC "
+- specifies whether
+.B active-backup
+mode should set all slaves to the same MAC address at enslavement (the
+traditional behavior), or, when enabled, perform special handling of the
+bond's MAC address in accordance with the selected policy. Possible values
+are
+.BR none " (0), " active " (1) and " follow " (2). "
+The default policy is
+.BR none ,
+unless the first slave cannot change its MAC address, in which case the
+.B active
+policy is selected by default.
+
+.BI xmit_hash_policy " XMIT_HASH_POLICY "
+- selects the transmit hash policy to use for slave selection in
+.BR balance-xor ", " 802.3ad " and " tlb " modes. "
+Possible values are
+.BR layer2 ", " layer2+3 ", " layer3+4 ", " encap2+3 ", " encap3+4
+and
+.BR vlan+srcmac .
+The default value is
+.BR layer2 .
+
+.BI resend_igmp " RESEND_IGMP "
+- specifies the number of IGMP membership reports to be issued after a
+failover event. The valid range is 0 - 255; the default value is
+.BR 1 .
+A value of 0 prevents the IGMP membership report from being issued. This
+option is useful for
+.BR balance-rr ", " active-backup ", " balance-tlb " and " balance-alb
+modes.
+
+.BI num_grat_arp|num_unsol_na " NUM_PEER_NOTIF "
+- specifies the number of peer notifications (gratuitous ARPs and
+unsolicited IPv6 Neighbor Advertisements) to be issued after a failover
+event. The valid range is 0 - 255; the default value is
+.BR 1 .
+Both names set the same underlying value and cannot be set independently.
+
+.BI all_slaves_active " ALL_SLAVES_ACTIVE "
+- specifies that duplicate frames (received on inactive ports) should be
+dropped (0) or delivered (1). The default value is
+.BR 0 .
+
+.BI min_links " MIN_LINKS "
+- specifies the minimum number of links that must be active before
+asserting carrier. It is similar to the Cisco EtherChannel min-links
+feature. This option only affects
+.B 802.3ad
+mode. The default value is
+.BR 0 .
+
+.BI lp_interval " LP_INTERVAL "
+- specifies the number of seconds between instances where the bonding
+driver sends learning packets to each slave's peer switch. The valid range
+is 1 - 0x7fffffff; the default value is
+.BR 1 .
+This option has effect only in
+.B balance-tlb
+and
+.B balance-alb
+modes.
+
+.BI packets_per_slave " PACKETS_PER_SLAVE "
+- specifies the number of packets to transmit through a slave before
+moving to the next one. When set to 0 a slave is chosen at random. The
+valid range is 0 - 65535; the default value is
+.BR 1 .
+This option has effect only in
+.B balance-rr
+mode.
+
+.BI tlb_dynamic_lb " TLB_DYNAMIC_LB "
+- specifies if dynamic shuffling of flows is enabled in
+.B balance-tlb
+or
+.B balance-alb
+mode. Set to 1 to enable flow shuffling (the default) or 0 to disable it
+and rely on the hash distribution. The value has no effect on any other
+modes.
+
+.BI lacp_rate " LACP_RATE "
+- specifies the rate at which the link partner is asked to transmit LACPDU
+packets in
+.B 802.3ad
+mode. Possible values are
+.B slow
+(0), request partner to transmit LACPDUs every 30 seconds, and
+.B fast
+(1), request partner to transmit LACPDUs every 1 second. The default is
+.BR slow .
+
+.BI lacp_active " LACP_ACTIVE "
+- specifies whether to send LACPDU frames periodically. Possible values
+are
+.B off
+(0), LACPDU frames act as "speak when spoken to", and
+.B on
+(1), LACPDU frames are sent along the configured links periodically. The
+default is
+.BR on .
+
+.BI coupled_control " COUPLED_CONTROL "
+- specifies whether the LACP state machine's MUX in
+.B 802.3ad
+mode should have separate Collecting and Distributing states. Possible
+values are
+.B off
+and
+.BR on .
+The default is
+.BR on ,
+which keeps the Collecting and Distributing states coupled.
+
+.BI broadcast_neighbor " BROADCAST_NEIGHBOR "
+- specifies whether to broadcast ARP/ND packets to all active slaves.
+Possible values are
+.B off
+and
+.BR on .
+This option has no effect in modes other than
+.B 802.3ad
+mode. The default is
+.BR off .
+
+.BI ad_select " AD_SELECT "
+- specifies the
+.B 802.3ad
+aggregation selection logic to use. Possible values are
+.BR stable " (0), " bandwidth " (1), " count " (2) and " actor_port_prio " (3). "
+The default value is
+.BR stable .
+
+.BI ad_user_port_key " PORTKEY "
+- in an
+.B 802.3ad
+system, this defines the upper 10 bits of the port key. The valid range is
+0 - 1023; the default value is
+.BR 0 .
+
+.BI ad_actor_sys_prio " SYSPRIO "
+- in an
+.B 802.3ad
+system, this specifies the system priority. The valid range is 1 - 65535;
+the default value is
+.BR 65535 .
+
+.BI ad_actor_system " LLADDR "
+- in an
+.B 802.3ad
+system, this specifies the MAC address for the actor in protocol packet
+exchanges (LACPDUs). The value cannot be a multicast address. If the
+all-zeroes MAC is specified, bonding will internally use the MAC of the
+bond itself.
+
+.BI lacp_strict " LACP_STRICT "
+- specifies the fallback behavior of a bond when LACP negotiation fails on
+all slave links. Possible values are
+.B off
+(0), one interface is selected to be active in order to facilitate
+communication with peer devices that do not implement LACP, and
+.B on
+(1), interfaces are only permitted to be made active if they have an
+active LACP partner. This option is only applicable to
+.B 802.3ad
+mode. The default value is
+.BR off .
+
+.BI arp_missed_max " MISSED_MAX "
+- specifies the number of
+.I arp_interval
+monitor checks that must fail in order for an interface to be marked down
+by the ARP monitor. The default value is
+.BR 2 ,
+and the allowable range is 1 - 255.
+
+.in -8
+
 .TP
 BRIDGE Type Support
 For a link of type
-- 
2.56.0

