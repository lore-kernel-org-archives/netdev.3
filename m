Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDED3806D9
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 06:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791614272; cv=none; b=DtT5MW/4DCQoinV8XUdXzVStuOWNf0fkIMfQ+pwzWZjTkT2/RkFWYhZGHlQgjg//v9h79KGRv1g9z5KT3DAww5SLfMOzJ+XOsF4gS1XtJlEzJhOSL9VXjQ1GDs0xHkwo1wUXacZLAOYxcOn4HZENGAc8l7OISccwX+3RLjD0HcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791614272; c=relaxed/simple;
	bh=sMKf6UDT7/vaS+7Li4uwAz0LP+Q/4d5o0YcVL/T2Uqg=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=lhzXokDhgYiHuM4LG0v3e2feDaCz66PUVualDSQJglvVuK3gLnAzsanlENIOOdEIdRBsiQ2PNoFuffdgWUwrSJyBWadeBj65hTp94tcqjvbI2J1cBcUhxlEm3PXPKD4TOflJmIrn8UAxxR+xCSYJsCewmj1j+8MPBWoOmWzl4Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=scramble.tools; spf=pass smtp.mailfrom=gildred.net; dkim=pass (2048-bit key) header.d=gildred-net.20251104.gappssmtp.com header.i=@gildred-net.20251104.gappssmtp.com header.b=TBlL+Jil; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=scramble.tools
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gildred.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gildred-net.20251104.gappssmtp.com header.i=@gildred-net.20251104.gappssmtp.com header.b="TBlL+Jil"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33fb4680717so1340995eec.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 23:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gildred-net.20251104.gappssmtp.com; s=20251104; t=1791614270; x=1792219070; darn=vger.kernel.org;
        h=message-id:date:content-transfer-encoding:content-type:mime-version
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/yV0lwwuniGUnn1moAe0URUcCaHzm8fGoXLy9SraqIo=;
        b=TBlL+Jil6S9Bhdh/1fBX1ESRpNEA7CwWzPXT4fClIxxxtH6rXUtbuZAfGnC7oHWUPr
         VPwR3R24TeAe/kPcM1W6c1T0B4DUAKU2Des4qbMdsxbNzRcfp+mfjeNSc5n30FEjIwbd
         O3bNSsf/VRx83WWwnbF0Mdo2/7ua9SWqRklmuJQg0uaXJYkeXZzjb1N3FRa7GSfJUMR/
         DuVPEiiX0pL2F1aUu5VpDz/yYNJth2qyW7dKmTqfyOZE+HdaMNstdIwi5ouwbmC/vBGK
         G1MBVLwajRirsrKl3aSRfI53HKkWfmg3plk454J88KFQZs7GyJgVIgcK/H4bilEkLu+R
         ueLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791614270; x=1792219070;
        h=message-id:date:content-transfer-encoding:content-type:mime-version
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/yV0lwwuniGUnn1moAe0URUcCaHzm8fGoXLy9SraqIo=;
        b=nBUXscrPZTT7GjNdWYHut6gGdoN6xHfdP85ZaEzzKNAYWVtjpFPFWTO5YbpTzb7RM0
         S90pq8Utu3O8lOzIK+J//IqiotgbfSd+ySQljsYrWy6pKqE8NGJVRFaP/VPDwEKrVFjB
         O0UGCk4eqNXM4IZqKkjFfrR0MKSVzEaRE5LCZpd77vaJ/RTEuPE/JTqV7pIe4qYg6U9O
         ZRrqq0ddlrXP3++wiHm0er1gbpFkV+kDVg1xkcKc2or65aNSabJV69OPX7e8P9zMYh/V
         DOdisLN/aRX2PHP8mM3CZfrhDr9rn8XRrYsp0YxEujSvb/ICzAiZ6/ooHE2E2ibmrktw
         NXXQ==
X-Gm-Message-State: AFq9FYLI9kz5VPZfaeNlfkDsBix6X89zr4zyiDFYLIt+b7lM1w3HPaph
	d1QQ/KxBQmNMZ+ncHAsrh1dlMK9cBdye1j186K/g4gRNjffIsAzssxp0V0zd/JcEhDAoWhj9cEL
	wBz51AjY=
X-Gm-Gg: AYBFou0uBd7srTTozaqL6RKnut1mFFB0YRE1oaxazF+w5cTh8kg3gk/NtN6nVksJSwO
	cFxv/vLBkbj4FYamP/llEpgSoiDUb1DkDglgRSdYr+qwpvjO9JUajXmvARjwx59MNeErKaoq45a
	/6KeaJq93fQcQXQQxmtqwxdJhGZyTECHAt8fZbIoiudhBoe0LUE0FqKExMnczvQkNyBrRhCab/T
	VOPHvOhL6xY5RNo/hNqQ0auUlsSfsnVRKXiNhIpEd2f+MVau9Msc2k0S7vEetRgWJgWPJ2Zv+rE
	fp2TCW5W4A5eA1HKeRZwhq43N3oDrbj4Psf4KXp2hLVQFEYA8UxVG7ZkeTaccJ6ZOSO65Cw+NJO
	3lit/uH0cV4lNbsWSSGYkUchsc7Tf3rrCB6Axm4lMBr06cnYlxPYZ5HnaN42t0X1a58ETJyW/J0
	TxDgqK1k5Z5EzG7IRWNpQnt+PI1oolR3pqan4WOBxgOKPW5r1hei2KV7pe8Vbjb69Qh+8NQ57yt
	w==
X-Received: by 2002:a05:7300:81:b0:353:81a3:9032 with SMTP id 5a478bee46e88-35381a391eamr4996691eec.39.1791614269497;
        Fri, 09 Oct 2026 23:37:49 -0700 (PDT)
Received: from [192.168.4.107] ([2600:8801:de00:2a5:5f43:aedd:35ff:e547])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c843079sm11917076eec.1.2026.10.09.23.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 23:37:49 -0700 (PDT)
From: John Gildred <john@scramble.tools>
To: Sukhdeep Singh <sukhdeeps@marvell.com>
Cc: netdev@vger.kernel.org
Subject: [BUG] atlantic: PTP receive time stamp left on, or cut from, frames
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Date: Fri, 09 Oct 2026 23:37:43 -0700
Message-ID: <179161426357.982836.14940819580364358369@scramble.tools>

Hello,

On an AQC107 (TP-Link TX401, PCI 1d6a:07b1 rev 02, firmware 3.1.100)
with the in-tree atlantic driver, received PTP frames reach user space
with the hardware receive time stamp handled wrongly, in two ways. The
kernel is a distribution build of 7.2.5; I have not tried net-next yet.
It is tainted only by NVIDIA's out-of-tree graphics driver (flags O
and E), which has no part in the network path. The recent mainline
changes to atlantic (AQC113 PTP support in June 2026, RX and TX buffer
fixes in August) do not seem to touch the AQC107's receive time
stamps.
linuxptp's ptp4l 4.4 runs on the port with hardware time stamping and
the L2 transport, so the receive filter is
HWTSTAMP_FILTER_PTP_V2_L2_EVENT. The frame lengths below are as
dumpcap captures them on the receiving port.

1. After the link renegotiates, multicast PTP frames keep the time
   stamp.

Changing the pause parameters while the link is up
(ethtool -A enp2s0 autoneg off rx off tx off), or unplugging the cable
and plugging it back in, renegotiates the link. From then on every PTP
frame received for 01:1B:19:00:00:00 or 01:80:C2:00:00:0E arrives 12
octets longer than before: a 60-octet Sync arrives as 72, a 92-octet
Follow_Up as 104, a 104-octet Announce as 116, a 68-octet Pdelay_Req
as 80. The extra octets follow the PTP message and look like the time
stamp: one of them counts up by one each second. ptp4l takes them for
a malformed TLV and drops every message ("bad message"), so the port
never synchronizes.

Restarting ptp4l, which sets SIOCSHWTSTAMP again, does not help.
"ip link set dev enp2s0 down" followed by "up" does, until the next
renegotiation. Taking the interface down and up does not itself cause
the fault.

2. Unicast PTP frames lose their last 12 octets.

With the link in the good state, a Delay_Resp sent to the port's own
MAC address (ptp4l's hybrid_e2e, IEEE 1588-2019 16.9) arrives as 56
octets. A tap on the sender's link shows 72 octets plus FCS on the
wire: 14 octets of Ethernet header, a VLAN 0 priority tag (PCP 7),
which the port strips, and the 54-octet Delay_Resp. 56 is below the
Ethernet minimum and is exactly the 68 octets left after the tag less
12, so the driver appears to remove a trailer the hardware never
appended. The Delay_Resp loses the end of receiveTimestamp and all of
requestingPortIdentity, and ptp4l drops it. Multicast PTP frames
arrive whole in the same state.

Both look like the driver and the hardware disagreeing about which
received frames carry a time stamp: after a renegotiation the hardware
still appends it to multicast PTP frames but the driver no longer
takes it off, and for unicast PTP frames the driver takes off 12
octets the hardware did not append.

To reproduce, with the AQC107 port linked to a PTP grandmaster that
sends L2 PTP (any 802.1AS bridge, or an IEEE 1588 L2 grandmaster):

  # ptp4l -i enp2s0 -f configs/gPTP.cfg -m       (syncs)
  # ethtool -A enp2s0 autoneg off rx off tx off  (renegotiates)
  ptp4l now logs "port 1 (enp2s0): bad message" for every frame

and for the unicast case, ptp4l with "hybrid_e2e 1" and
"delay_mechanism E2E" on L2 against a grandmaster that answers unicast
Delay_Req: every Delay_Resp is dropped.

I can test patches, and capture more (frames, register dumps) on this
card.

Thanks,
John Gildred
