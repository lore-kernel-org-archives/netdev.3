Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660664;
	b=Wa9j9PTNiMQqmFbFFu71GeoBXiYfkbzWGe5jkDcAfa3C43d6jlzW371idxtzg7US0rhY
	 Fu4NLEinP0zvIfz6TZESLs1O/QksZtueGdVISkD4hflgmYpYQaLArVMqcoKf8YjoEMnb9
	 6v7ohlW7hHFpKq9KMHcii9WlQ0UE+yUgKPS9HEuPgGAFcio6gdPsY7KZL2N/qmS5GCCBF
	 +QL/B7z+f7OjXnbumNnEssPxLj8mDlnCqqbO5R9vtfn2nDCdcuKoFMo8KouwjQStDsrK9
	 HwSxHnKp0NQxotcnsLanTs7DoxewcZvkHvsAH1T4j7CBrjIdoTJnMXpQFLO/n2MYl2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ydSllVnxJwUmROhHxhg7pIdiTiTIT+tFa1S9Tfrhzkk=;
	b=PipMnN62HsFz2I4JWBlcJM+w5QI/qjoDxIOLKmcUvqjSBaYdDQp53zaV9+9w8UzZAFGd
	 sODJIV4Kmnf9oeW5l5z9LszZdim9T2sTcBM0/1omSENS97g3WyxnAPADmRaT2w3JoHK1P
	 cZszHg5TnOSVLXW/cQE9C4UuzPAQvreb7SXIrDqDBBet9rDxLinNB59OuRSzh5FjI4wsa
	 Y5qitL1J7HHCDV2Z6ejeekxywscqfsZ0lWv3Zvco2xiAhNpAqSF5XvfHkReDC0e323tUt
	 vkt/PNrHWKGKYC8mqOP66PMZbG0EOdn48tBCnsgCAwWaedpYWWn8wT3JehcYdnoaunw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kPiKtKO5;
	arc=none smtp.remote-ip=74.125.229.135
Received: from mail-dl2-f7.google.com (mail-dl2-f7.google.com [74.125.229.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC0F606A320
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCC0F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kPiKtKO5
Received: by mail-dl2-f7.google.com with SMTP id a92af1059eb24-13985f8229aso1509039c88.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660663; x=1793265463; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ydSllVnxJwUmROhHxhg7pIdiTiTIT+tFa1S9Tfrhzkk=;
        b=kPiKtKO5Rb6lsY5ec6uXIph35wXgBO8niiwzM+/FTJEEmYLw4ZEUibPsKIpXJRP1QJ
         E66wE9fkB/medbvdzQcGd3vgJh4CvZJ42hyutBHAnrtOrpQVBtg5X/CezxuPfJh1xIsf
         YrkH5OSwm+tbcB8fjjuVOhRICDwjuwyqB9TKgWPh8nSv07CcTzH+6HkZUWR5wFtpna/t
         bOWwavwu8o1XsT4KuLig20dRzTEcDCNo4ijxgvdBNQC21VV3+5R8Jtcy2NGyTdsuTYkn
         bBGsbBTo+bKIjVsRs+GxUuasEDGfxRoEQqFuL7Fv5xa6RWhJkInlWhB2uVgYRp33Lo8z
         mQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660663; x=1793265463;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ydSllVnxJwUmROhHxhg7pIdiTiTIT+tFa1S9Tfrhzkk=;
        b=L1L50UoKT1ZyY8n4DXTse2D6yHjIK3+NgF0A0JJO/9JaxKf3LOBkmD9L8+2XuBFSO9
         S+Ggbg8y+znDrVY5eKF+7d1YScCnx3ORZe7tb4fui+aw+dKQg+USigrc6dAG7e/tuqIW
         aMo4FjKfmwtU1Yqt+kg3DH7yAw0wUyDM4L7Gu3G38yY1G1HRcgAs75GQeE3neCodGOqg
         umL8VNPjIO9gLxjfzeF5FWTj7MrhKlAMsr1k1tcsxg1KbIkJcQntsqhgm/MYnNPN6t7a
         /BZpI/dphAikNXG+wFBAfKlgS8l1ZjLgwo/Te5+nMPkSwXuTIA24pbXJ2Q76fdW7pxsF
         6BxA==
X-Forwarded-Encrypted: i=1; AKwUvBzQnd2oIf64YmrVeaWLOFBzWS1WUzz473wB3OVIsMbO3DP59BY2PWydUdRl1JXEKI7fTgFjZB0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJgDRCDnBddIiXxgfhZ3BhlQNRPNTn45Z9o8F3Kg8GFnx4IF/7f
	rMseg1MxrXbQTGd70pVWQeaO3dtXyF6tIE/6OW4HUheIJHak+BRLlWhq
X-Gm-Gg: AYBFou1PiU3wy8b9Fju6tSkZNCINbuZUzmErIPxgOs5R5h6v8EcfHkG2TH43XIdiRSp
	1IrowLj/qhuNaaO6mDgol/9RrwyYi2l9+dQZ5kb0eYEPJPmxKN8l7uy/YBxSSM49+CwMQw/onkO
	tUwwOPUctGLS3kFb7rkpQrW8xmrr4CuJal+3TQsXEyY7qnMNzQ4NYBHsTyQIJeWCe7zqCkSTcMw
	s+wrDJpa50fndfORBDGgy431UCioU9ioxEbp5CZ9uUkQRZAgSzCzw4IESz2LGh61MqFwQevsJlv
	91nhTWkVtpkPxsq9S2M1haNeW591DcFjn6b1kGkwtv0c8np5HQwqpTGioPOX+mk+G/ZR5xI65Uh
	fwC7FeXCoO7aMtlZJ0QI+Ou9PU2kIl5d822+CA2UufYtV71NYP2VTxs/oXBUe2BMFE5e8MMTvxM
	B9TRpc7mvLmYuYNxGVHk3H4fasf1+epCyryKLXO2qpDpVJ83FWsPgqSJPM1iLlcqNozqlM8+VFp
	mS0f08Lfy/0WI3wsElNUuN8xorbRB1It2cZG6xa9IxTrki9jGPiYKHqwQ0LW5Cb1LpjW9TqKvVA
	z1HDf9iq/UO/lr8L9zn2jmKKYbQzu4L3w8jzh4Mv
X-Received: by 2002:a05:7022:3804:b0:17e:6de6:6a1a with SMTP id a92af1059eb24-190a4f064a9mr5160458c88.8.1792660662898;
        Thu, 22 Oct 2026 02:17:42 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a275026sm19890469c88.5.2026.10.22.02.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:17:42 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: ipvlan: ambiguous external multicast frame is dropped
Date: Thu, 22 Oct 2026 02:17:36 -0700
Message-Id: <20261022091736.3652981-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

ipvlan_external_frame() classifies an ingress multicast frame as local
when its Ethernet source equals the shared ipvlan parent/slave MAC and
its L3 source is present in the port-wide address hash.  An external
sender can produce the same tuple.  The frame is then returned with
RX_HANDLER_PASS and is not queued to any L2 ipvlan slave.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1, with two ipvlan L2 slaves
and a veth peer acting as the external sender:

  external ARP broadcast, source MAC == ipvlan MAC,
  sender address configured on a slave:

    parent RX +1
    slave 0 RX +0
    slave 1 RX +0

  identical frame with a different sender MAC:

    parent RX +1
    slave 0 RX +1
    slave 1 RX +1

Packet-socket marker captures agreed with the RX counters.  The frame
is lost only when the ambiguous source tuple is used.

The macvlan sibling documents that source-MAC ambiguity cannot be
resolved and prefers delivery, accepting possible duplicates.  ipvlan
currently chooses the opposite behavior and can cause packet loss.
The same classifier also explains the duplicate direction in candidate
BR-015 when a reflected local frame has an address that is not in the
port hash.

The classifier should use an unambiguous local-origin indication or
make the ambiguity policy consistent with macvlan.  Candidate BR-016 is
canonical because packet loss is the more important symptom.

The self-checking reproducer and complete console log are available on
request.

This was found with a multi-agent workflow; the packet
delivery differential was reproduced in QEMU.

Thanks,
Cheng Yongkang
