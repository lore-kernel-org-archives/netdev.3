Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794167332;
	b=v7A8/JDAd7K5L0hq6OCWltxohb4ecHDTscQGPfwF2BJ/M5uqU0udKTXTf/34lv53h0A7
	 DsFzS9X7EZczYATFei4dKdUSoNr7h+WtMFPnzelepfCB/1sR5g+/I99lJHWTFd7qU/X48
	 8KPgPemFK/r9jba8u4urVpQ6E1yTP4YTX5Mhm2qAjxv8YS9ahlXixdDv0HHz0ifmyRZ7Q
	 lZY9G3OYQJxCBV1I3wHtGt3e1DMFEpE2/Gq64PDC3Fzr1CIc0SpYv6c5SIzzVlj6gKcQt
	 UgENKKekQuSbrhYcXwGCmIbRbFRw9+v1Z+AWbE4ctN3E60Tx3AP4rbnBMGlADyzh0xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794167332;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:Thread-Index:Content-Language;
	bh=70zQaTidZegJHL8BTv/OZYMfTi+NPOAhkseasQT6l4c=;
	b=2XQKRvIkiJOaTcOZZf/qH8dyHVw3K1qgm3dUA7Iurhour05WUMhR4YhRcOViwNxLo82D
	 kaailunO7ZVKqky8OHv3ZCcd4Ow03+ReHhnRgg64Fc2P182I3KawMBfvFJgAkUfLhzAmw
	 /mRtKplmG+Byqo8yQDhpg7Yaq/ETiiVlPqMHsIKn0MGempm1XZHdu8DEyolJmJHMS7anV
	 MZBOJ9Nx9f0L+DRfwhiUrQGzFHmT+H+uuNd50ekOANJjtDxQIFPq8eRLX+Ez9hBARty0F
	 clRZT8rcJjZCedRtl9mVx7JzBsJX6FNo7acbQaEdAS9XdBlLTBeoH3EOH2hM25AbTSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jXyBRKdJ;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666FB606A322
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 19:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 666FB606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jXyBRKdJ
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91e9309f171so2352936d6.2
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 11:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794167330; x=1794772130; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=70zQaTidZegJHL8BTv/OZYMfTi+NPOAhkseasQT6l4c=;
        b=jXyBRKdJkp6XXvNTVIP2mXjuKPdYX1DWsFl9pcjjUplrb32KrShGQams2/5jR6g9B/
         iYuUFgoWKkSRHJlK9aABS/6k7CON3OhlRylQDZKvG5/GpLNAR5DoaH+ndUFPLzWHJCRG
         aFvjcLhjmVEuIN2jkZXDiOK4BcFmxQVMhg98YqvRxcr45aW2dKpfHNPel5FVskOaqbYv
         YGaPgrqrJM0fwl9k0MPvARz5ufMpydgf3kzHR1o0HdAV6jq579EcNHP+dDBmlYuRqqae
         XgbHIsBg3FoK7GzT/bLE35d0fYOeDUpzlcVKEcGgxPfhyT1F3gYnyiTUwZlaRXpXHBte
         KU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794167330; x=1794772130;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:cc:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=70zQaTidZegJHL8BTv/OZYMfTi+NPOAhkseasQT6l4c=;
        b=mC9Iq5iED5t1oQUI1+pUWHOkERbYFoc0WD+oc2Mf695sW3L03gVvIloIbOs0iewO6L
         qVuwhM8qgxOPIcKouXFIBqTSzYwHn3OPEiX2ZTi1PimRLfRloUjVl3GJDLvE6aHryfkm
         G4hLKWoearihk6gROdVYpvvXp6KAoOIpz93Km/moc3YzpWB9wxEBnei1uN8nsgE/PKh5
         6qzc2o2RHnBtlPA7qvYgo4V4DbOVg9mjj8ypN28qtucKU0nUD3CpVKCiyckQ4aMSu9iO
         0+qczr0OP4zt6ShehSXJOuKmpbOuV4BsMFM5jLY/XVeBK5R34OsD29usXuYqtY5LEku/
         mmgw==
X-Gm-Message-State: APuU4Z+pq8frBWhQrO1YIrNJlTtQSvvKNtPNVSfksyi2rrFDGnA/ND0S
	LiHeMS7h12zZQecSGcN7FIfGvm0Da8MZBRycJmy+p+BghmIj7cVYt2yU
X-Gm-Gg: AYBFou35HTAoJloJ8vWy1K2tJxZLkkw4haiH5LJ3LnRp9sZ5fTqDuuHgVmS1hoCn+yy
	blV9NlUZWxFhGU9f/NSgD+exREy86i8ryq9pkfagDENGmA5K89wStkF/sJor7X2hn5LV71XO0i2
	g4JXviSRyuNe2rPIIRPRQjtAdYLhvp6gDuEXNk04lrt/Vnln48aDLY1gVrirc3DT6DmMKN9v7gy
	zRUpCdjOiUKVNOXpKIYDbJOxNlcN8veGXDAopaowRL9bg9ys2BjK3J0gFkpeupjE4ZAnGdDO3iH
	Ad/KlPWNjXXikwcYHH9BonW8k/aixxP8/6i67bzgivE6e0B6yFVpkIJExh0oqWpfNaEvLEI0SI7
	p0Zx8xZoxQpSGtReh7FCizrmIO6rsrDqoTA2V+5wiSTM+znl4L6k0UeHAP8Iwg6fx5+rXFqheyg
	a1ELelQkHxi3hYBaNBVsDaHQmyCtGjiT3dtC7DpgQYj68pBXj/6R1L9xH2Ebzhb/w9J58Ieb0Uv
	ilsuvcUT/EvLecpwBcaOin8iAf5MkgVdMGuBflvHEpXPKljMY7uUbZq/Q0n49igqI9GOhwrgULZ
	Ww6d1ucqZ1gQahir2avVSKsugyMAQzvOrRDIaeusNtpLy/HjhqhsAyrXqXqwMshEPmQ8
X-Received: by 2002:ad4:5745:0:b0:91e:76a7:187 with SMTP id 6a1803df08f44-91ed24acfe1mr32302126d6.43.1794167330178;
        Sun, 08 Nov 2026 11:48:50 -0800 (PST)
Received: from Desktop ([186.247.175.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91eced95d39sm25058076d6.13.2026.11.08.11.48.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2026 11:48:49 -0800 (PST)
From: <brianrobertjames@gmail.com>
To: <westeri@kernel.org>,
	<YehezkelShB@gmail.com>
Cc: <netdev@vger.kernel.org>,
	<linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: thunderbolt_net: GRO header-length ordering defect on Proxmox 7.0.14
Date: Sun, 8 Nov 2026 14:48:48 -0500
Message-ID: <000201dd6fba$2c726e80$85574b80$@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Ad1vuZ0ajLhI60pVTHeHwa3vcNZzXQ==
Content-Language: en-us

Hello Mika and Yehezkel,

I would appreciate your assessment of a thunderbolt_net GRO ordering defect
observed on a direct USB4 link between two AMD Proxmox hosts. We have
receiver-only original/corrected/original comparisons and packet-order
traces supporting the Ethernet-header/headroom correction already published
by Shun Li.

Credit for that prior published correction belongs to Shun Li:
https://github.com/riverscn/thunderbolt-net-dkms/commit/b18a196bb5ca54246443
e1a29924d6007aa16036 

We independently investigated the same defect and applied the minimal change
to pinned official Proxmox source. We did not install the project's broader
DKMS/RX-normalization modifications.

Tested environment:
- Two AMD x86-64 hosts with one direct USB4 cable; native thunderbolt0
traffic, no bridge, VM or Ceph in the path.
- Receiver kernel 7.0.14-28-pve, #2 SMP PREEMPT_DYNAMIC PMX 7.0.14-28
(2026-11-02T11:54Z). Also reproduced historically on 7.0.2-6-pve.
- MTU 9000; TSO/GSO/GRO enabled; gso_max_size=65536; unpaced single-stream
IPv4 TCP iperf3.
- Stock thunderbolt controller driver unchanged. Receiver comparisons
changed only the network module's header/headroom metadata. Cable, ports,
offloads and CPU/IRQ placement stayed constant within each comparison.
Secure Boot remained enabled with signed test modules.

Receiver-only comparison, original -> corrected -> original, 20 seconds per
arm:
  Original:          30.599221 Gb/s, 620 TCP retransmissions
  GRO corrected:     29.779541 Gb/s,   0 TCP retransmissions
  Original restored: 29.994158 Gb/s, 540 TCP retransmissions

Endpoint interface error/drop increments and receiver FQ drops were zero in
all three arms. The unchanged sender in this historical receiver-isolation
test was still on 7.0.2-6-pve with TX E2E enabled; receiver RX flags stayed
FRAME|E2E (6). Both hosts now remain on 7.0.14-28-pve. This is not a
two-latest-kernel GRO-only comparison.

Minimal reproduction outline: establish direct USB4 IP connectivity with the
above settings, run an iperf3 server bound to the receiver's USB4 address,
and run one 20-second TCP stream from the peer:
  receiver: iperf3 -s -B <receiver-USB4-IP>
  sender: iperf3 -c <receiver-USB4-IP> -B <sender-USB4-IP> -P 1 -t 20 -J
Repeat after changing only the receiver's header/headroom line, then restore
the original receiver module and repeat. Module reload interrupts the data
link; our management connection was separate.

Mechanism and minimal correction in tbnet_probe():
- dev->hard_header_len += sizeof(struct thunderbolt_ip_frame_header);
+ dev->needed_headroom = sizeof(struct thunderbolt_ip_frame_header);

The 12-byte transport header is not part of the Ethernet MAC header
presented to eth_type_trans()/GRO. The original hard_header_len is 26 rather
than ETH_HLEN (14), so gro_list_prepare() can compare 12 IP-header bytes as
link-layer bytes and fail to recognize packets belonging to the same flow.
Runtime tracing confirmed original hard_header_len/needed_headroom=26/0
versus corrected 14/12.

Historical paired receive hooks on 7.0.2 covered the same 18,871,120,863 TCP
payload bytes and 303,590 packets before GRO and at TCP ingress, on the same
CPU. Forward sequence gaps were 0 before GRO and 1,219 at TCP ingress, with
no packet-length parsing mismatches. A corrected capture had equal byte
coverage and zero forward gaps. Retransmitted/overlapping sequence ranges
were treated separately. This localizes the observed ordering defect to the
receive software path; it is not proof of physical USB4 packet loss.

Full reproduction details, source provenance and the one-line patch:
https://bugzilla.proxmox.com/show_bug.cgi?id=8306 

Independent hardware validation shared with the prior fix's author:
https://github.com/riverscn/thunderbolt-net-dkms/issues/27 

Separate context: with both hosts on 7.0.14-28-pve and GRO already
corrected, we also observed TX-credit-dependent fragment-validation errors.
A local negotiated TX E2E opt-in gave 18,604 -> 1 -> 18,601 TCP
retransmissions in off/on/off 20-second arms. This is a separate diagnostic
change, excluded from the GRO patch. Its lower-level cause is unresolved; we
are not proposing globally re-enabling TX E2E given the known controller
compatibility concerns. The related discussion and limitations are here:
https://github.com/hellas-ai/thunderbolt-ibverbs/pull/78#issuecomment-672616
9650 

We have not reproduced these observations on the latest vanilla mainline
kernel, and upstream acceptance of Shun Li's GRO correction has not been
verified. Could you assess whether the GRO correction is appropriate for
upstream/backporting, or point us to an existing fix or discussion? Raw
benchmark and trace evidence is retained locally.

AI assistance disclosure: source review, diagnostic automation, analysis and
preparation of this email were AI-assisted using OpenAI Codex (GPT-6 model
family; a more specific serving-model identifier was not provided).
Measurements came from actual hosts and are not simulated results.

Thank you,
Brian James

