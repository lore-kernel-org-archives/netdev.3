Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.103
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792701971;
	b=Oy69obxaKPm0bMyH2cjduPJcVoj0NBzCOP5u98epMTSBK3QE0ESgkfws2NYchsSneGNw
	 Qa4+bIp9VIYuh3UxXIrUub34SDm2elKqanmq8XJKmZQH1Qun6MskeU+T77Ghr7R/Xgw9/
	 vWL2nYneRipuxp+Xuj+UXswEaOIiwmtRRm8LS0kWw4AXxZEGbMEnXZxC/bCDr5GnS347x
	 az1Jfoqo+LP5/6SMNEE/FmcIxNz4eGs8RFErCca2EKAp+OPE2GxEuyWCwaJnOanOKqn2s
	 8J4Ud3jv180nHGkaplOrZdOcvzcr55Bn4Z8QTLxvg58xrFzUk/cftcILRoa+/IK85FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8VFeLzFjs+1tyD1verKIzxz+44wrmpBf7b+eGipJ3so=;
	b=5tUrcQNjroesNDVZs4rGHjdA8AxKYGY8n3Za3aAiT1x1sOQz+1vm7dTDfxG0akVZIc3k
	 NY5Ofd1CMJeZKRsEEux80KebY19dP1CRcwSLsr8NkB1+am7RUNTBOqGsewqqbGAwvmIJk
	 9XWkEM1h0P2zCWPWrDVTheMIVkq4wgsOQWwsbuJRQYPAT13R9XuwbGAY26b+YlaBfwItf
	 r0Koxfuq0uRpTdhnFmrtYcRTdYESsH6a0NsjPJ3QLRvx/InRyJd7eVl0EW9S8k0YYgbao
	 PBv1btXtYzIqb6KRvlJHPPmkhaGGU4E8rIkDDaIFpVrT8Yv0oniMX6nMaFYmG13WopQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=fYT7SBde;
	arc=none smtp.remote-ip=209.85.208.103
Received: from mail-ed1-f103.google.com (mail-ed1-f103.google.com [209.85.208.103])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03F5606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 20:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D03F5606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=fYT7SBde
Received: by mail-ed1-f103.google.com with SMTP id 4fb4d7f45d1cf-6b408f2d936so205793a12.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 13:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792701969; x=1793306769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8VFeLzFjs+1tyD1verKIzxz+44wrmpBf7b+eGipJ3so=;
        b=fYT7SBdeOZeo+ihFjBF8Exz+Mz3l48gfFHALRKJF7c827KIdEP50eGavD2h74ZY5G0
         8yqlu0pbeqW8SV9RHRDLMqNkx5EcAn/fAxu0MnpzWYICR/7uRkKC1VbOq/4fun7kHeG4
         pwYlW7KBsHTqXQMzkMclhOZGvE5kuQqStTPh2yERXs8rSFCZyPNNEJw45JxBUn4R+hHd
         EUA1P4qXl3ay4J8++r4YlE2NwTLlDPAjuiKGBFZriON4zlHq+tLYj8mAY7Bd7TfQRrqO
         6hWPc2oCwLV0fZKlpl4fvp3lEtIH5mCYQZSNoRpIousnJL5IAugjfzvqqZh6UHX6CEv9
         BzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792701969; x=1793306769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8VFeLzFjs+1tyD1verKIzxz+44wrmpBf7b+eGipJ3so=;
        b=iXbsvu9HbhEUfy7m6+DQvKxbHhxf0+UrQkYnEBFH5CqsUwosZ7H7Rdmza29VR+eeDL
         Mop2l+nQwCcX0X8sl9OwJAc0PgtlWXdRgU9he8jwR7zYKM7pXYjExhsPjsKi76CJ/mCI
         mKRPofl/k7ESdaPNNMaEdetmn5xcnjJ2A4tarebDiCMDJMhk2rHhIljr/8gsHOBCcEX1
         xqo7Q9RueePEEpGPjbfQZ7+AbOhw2i5B6io3Y6aB08Mvn1gDfR5l/GXo7+dofJQxr/9G
         hROVuguFxaH5XxjZYhmI8jTwGO6eIf1qfoTcphIWCyrvGr1CpNqV59q8gBkzCAAWJlev
         /MEQ==
X-Forwarded-Encrypted: i=1; AKwUvByw/eSRYObrnTX6A6SWMAGwUNuC1XkWbU/yfBSY/L0tnEeh1iq82Y50Z6Eh4zNVjcHC2Bd65LA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvJZlvb2SvAhKxfzOByRLgkp6MS4B0EU2WPtwxZ7f7npgjwY7v
	Gw452oJB/twSVIhRTlKsgiNh8lwlhPn3s8d/QG0nV2J8+DfSEtV/KoWQYWaSrIZP+kaaIffPOcD
	jIXGE6hdXTnzS0DFnRzUWWlfPx0pwDU6/CgOqNA8+cuezs3H1/EEf
X-Gm-Gg: AYBFou0x2taQXumJznd9LMSe1YaNIxz2u2EbOsyXApOTwId/kFHSUVIOhhxRlXD+TfR
	vbKDddGA5a2jcscsGP5w+3gdzlSqe2xjvs9vFqmB0d/pnz7kjjXI5nqTyFRZJMXqt6tYCoiFxbP
	iFX411gLwFn9S9Fs2LERGDSm2UZ4XjL3MW+RYh1Om28KzItGEluvdAx1ad/G/ObWzO/MkmGwzBo
	o+hq3ftOzeG1rjnRU2YmHgokYmmFd/qYq8HDZQ5RNMz5XIK7CfSEzbQO8hN40pgxoxFejYidUIK
	5VvGlH+SkMxetEAtYEW6ropFvO9qcHRNxGwuGXDAfZ+fmZwGEm7fBJkFP9lKQu8Rzms7LyQSqH0
	+vNlQWdzwYAZryslz2Os=
X-Received: by 2002:a05:6402:78d:b0:6ae:fc0f:e19 with SMTP id 4fb4d7f45d1cf-6b432c25d8bmr550501a12.42.1792701969107;
        Thu, 22 Oct 2026 13:46:09 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 4fb4d7f45d1cf-6b432c75cbesm84237a12.18.2026.10.22.13.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 13:46:09 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [10.17.2.234])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id DD1734029F;
	Thu, 22 Oct 2026 14:46:06 -0600 (MDT)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id D7619DC48A1; Thu, 22 Oct 2026 14:46:06 -0600 (MDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: tariqt@nvidia.com
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	John Fastabend <john.fastabend@gmail.com>,
	netdev@vger.kernel.org
Subject: mlx5e kTLS RX: what do DECRYPTED and ERROR guarantee?
Date: Thu, 22 Oct 2026 14:45:41 -0600
Message-ID: <20261022204544.1380263-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
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

Hi Tariq,

My TLS 1.3 KeyUpdate series (v17 [1]; v18 in preparation) needs the
mlx5 RX guarantees below, particularly for the decrypt_failed patch
under discussion in [2]. Please identify supported devices/FW and cite
references where public documentation exists.

Tests used ConnectX-6 Dx, FW 22.46.3048, TLS 1.3 AES-128-GCM over IPv4.
The load sender used one write() per 16 KiB record with TCP_NODELAY.
Targeted cases included 622-byte records. F is the first new-key record.

Observed packet shapes:
  - F spans packets: DECRYPTED prefix, ERROR on the tag packet;
    transformed F payload, untouched following-record head.
  - F fits one packet: ERROR with transformed payload. If KeyUpdate
    shares that packet, its encrypted payload was transformed too.
  - Host drops the DECRYPTED prefix: pristine retransmitted head plus
    transformed ERROR tail.
  - Bad tag without rekey, 16 KiB or 622-byte record: ERROR with
    transformed payload; software authentication rejected the record.

The two small-record shapes and host-drop case each passed 4/4, with
correct data and offload reinstalled. Payload comparisons and CQE dumps
found no additional transformation discriminator. No tested ERROR case
left the failed payload untouched.

1. If every packet of a record is CQE_TLS_OFFLOAD_DECRYPTED, is its tag
   guaranteed verified? Can the final tag packet be marked DECRYPTED
   before verification succeeds? The stack skips software authentication
   for fully DECRYPTED records. Is ERROR only ever set on a packet
   containing a record end, or can a header-parse or length error
   produce ERROR on a packet without one? If a tag straddles packets,
   is ERROR on the final tag byte's packet? Tests did not split tags.

2. On ERROR, are encrypted payload bytes of all records through the
   failed record transformed, including preceding valid records in that
   packet? Are later bytes, headers, explicit IVs and tags unchanged?
   Can the failed payload instead remain as wire ciphertext? Does this
   depend on NO_OFFLOAD/AUTHENTICATION or SEARCHING, and what metadata
   distinguishes the cases?

3a. Can the old context transform anything after F, including later
    records in the same packet or speculative work?
3b. With F incomplete after loss, can hardware skip it and resume at a
    known later record boundary without confirmation, as described in
    tls-offload.rst?
3c. Can pending RESYNC requests, GET_PSV completions or resync parameter
    updates restart transformation after F? Are stale confirmations
    discarded or applied at the current position? Is there a distance
    limit?
3d. Does mid-record loss without KeyUpdate stop transformation without
    requesting resync, and what restarts it?

With KeyUpdate processing delayed, dropping the middle of 16 KiB F,
followed by a small L (separate or sharing F's tail packet), produced
no further transformation or resync until context replacement. With
an old-key header missing, a late confirmation for a later old-key
header after the device passed KeyUpdate produced no DECRYPTED/ERROR.
A control before KeyUpdate resumed transformation and failed on F.
All runs delivered data correctly.

4. Is re-add supported when next_record_tcp_sn is behind the stream,
   with rec_seq naming the record at that anchor? Given later traffic
   and a valid resync response, is SEARCHING/RESYNC recovery guaranteed,
   and how far behind may the anchor be? In the load run,
   all 90 rekeys resumed via resync with the stream 2.3-3.4 MB ahead;
   the first DECRYPTED completion was observed 6.4-9.3 ms after add.

5. After the re-add in Q4, while the tracker is still in START, are
   retransmits wholly below the anchor passed untouched as NOT_DECRYPTED
   without changing tracker/record number? For a straddling packet, are
   below-anchor bytes untouched and tracking begun at the anchor, or can
   old ciphertext cause false framing or loss of synchronization?

6. With basic/enhanced CQE compression, are TLS-status CQEs excluded,
   or do all packets sharing a title have the same TLS status?
   mlx5e_decompress_cqe() inherits that status from the title.

7. In mlx5e_ktls_del_rx(), after steering-rule deletion completes, can
   old-context packet DMA or CQEs still be posted? Does completion of
   the DESTROY_TIR command rule that out? Are old-context packets tied
   to the RQ selected before deletion, or can their destination change?
   Can later RSS/aRFS traffic use another RQ and be polled before
   pending old-context completions?

Please note any ConnectX-7 / BlueField-3 or firmware differences.

Thanks,
Rishikesh

[1] https://lore.kernel.org/netdev/20260917224355.2288021-1-rjethwani@purestorage.com/
[2] https://lore.kernel.org/netdev/20260917224355.2288021-11-rjethwani@purestorage.com/
