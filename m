Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660632;
	b=ZONnwTb9RqMPRO4E9BwBtl1G/UO522NnnMM8sNQX+3pKTZfPiB0zdy2oT5lyNjgP9ony
	 jEIbtQHFp2OR8MsUHNYKWKTg0P9BP+5fs6ooQbwPPD5VR0SFQ1nwNTIVw6NEHNQIwpbJR
	 wCNNnzcod1tSlazlmh1jn/m98mJ/zqQu7OEztJsdx6ATgfH251jKFW79LMl9Yb5pyclB/
	 P2u4JBTQOvkrn3CtiAbVsDxC7AmaeSZ9rj6ziQSmjE9+euT7HcZn8zKevaLHnnHYMmL3w
	 LBSSkppxBdMv+c+JWBcfrcHA7ZtonZqZ7hNmXtbA0BJz7FdHB0c1nd/Ep9ImeU2jBXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=sI+0nhto7gjQ/pA9pTOXfHoPEuc8oDO28HfBE2X7SBY=;
	b=wNmFTiw1TFYamca2ntiQASRBxjSFE9YF3J3xQPE2vy0efJA9nMtHt9aYvdz+jTvJoL1l
	 ZFp2mTigzO6wjmcRSNIOpLALSTBaWllf/V195bOOvQn0Hx4tV59gstQWg85K2PI65fDIl
	 1PTpBUhgY2WV2Ytb/1aQ1+dvrXS6dbMMOpIUNTaaFv2QAnrZLsr1UExS4OHU3SI2wLJgw
	 +XVNYGKqXCalFmCyIGuJxYjx99ID7wiyZ8tzOwH/6HImHKLLEQEdvE8BPz4VxPdZ1tESJ
	 /IEvP0A4gJ0EPP3yd+ZxIX+JEP5NbgUOhPKWjXRrMZ4LW17Mp4glPM8NVcB+CzvGawg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GGeP4B3q;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD096606A338
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD096606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GGeP4B3q
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35d0be18c71so783875eec.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660631; x=1793265431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sI+0nhto7gjQ/pA9pTOXfHoPEuc8oDO28HfBE2X7SBY=;
        b=GGeP4B3qkwTiZhwWcvqnzJSVW0R2IzkWw3Bf7cB64xWCiQndWBRC1DlZ6Ox5881tIm
         1s1waCMODbbT0DlQzy3RvnPxVXvo46TPSiI6opLRtgMv2PvWzBJ44kOtBr6vRsjLvCKI
         62PL3k6Mz+he2q4IW5cEcaZpXwyS3lVg0pML8eruurCZxMxZHkbbRr8Z8ZoxDuw62sR0
         zHNlh9ejWmOC/lTPqmD7fJOwVOZtN7mCSkqJdjrC900qrw73DgNu7W1VNHpET3fZpWJz
         Dtr/ZQPI4hLspTxGSLHAx8weG+fghbOdRNQLeO0aVoitAWz1xKCgxT4JP25FjQzKna83
         athg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660631; x=1793265431;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sI+0nhto7gjQ/pA9pTOXfHoPEuc8oDO28HfBE2X7SBY=;
        b=MRie1Z/vQ0JFcvDGB+ZKWvootFyvjtUHLYCvQqzgUhXHzUY70dim25uTdHZVOwhhqz
         6EKNY1FbiabO2PqX/kU5qk0Zo6Z0LHCIOiASJ0Gi87zUXxWSUDKNWRJSRc3/rSAMODQ6
         ei6/Ap2uqOdMuxJOsyX24fMjw73jXaQi+hWdT8/JwpBiU9YEt/W7vguAipvJemm6n7SZ
         TcoOllfZAY+ckjes6fjiB8G3G9Gr/6RZB8TRVtRrtNJZXYmraTibNINLlY8rOrRxIm4n
         XwNH44OC3yYS2KyfJbberxskQ6QjqEpE0DZoBZgdiKn0VDp3QM3c3C6cwekmJ00zMKz2
         y2Fw==
X-Forwarded-Encrypted: i=1; AKwUvBwRk3lHHJ+MkwSJqW7JU6wBbcRsY2o0lTKCzbCFQjZE25PNjUl8ruZrsPocbUm9+S0CF43nw40=@vger.kernel.org
X-Gm-Message-State: AFq9FYLB0NA7Lty6ulAskChHngWczpYetWpYUL1S7UJtkkCzm5S5Nn5B
	qu5aT7ok45hS2WFC6WLvRaWi+ZmKDOuIgZuCusEBfOi/yK4U1HcSf94d
X-Gm-Gg: AYBFou33aWxYMrpvmheI0BK3g5Bg6gAbE5SxnrHzJXWzkCXBdt6zPgV0Dw7RJT1R2GE
	zGmGRECTS1zKb0okOiuBhPc9Nprlv6TkWUpEbhQITOd7mV+u5XiTZRpRW7hynqs973R1Ja9GqFg
	FFG6TC4gXRvzmoMSW9HAzU0FmYuFs6EDX34yloD2Jen7VD4wJxszWxcNzBE/J4cn1COzfOLmdbQ
	5osuoDekId8L1wTC5LdEMayvsXxhZbwX92eXJ+90UizfPDN8TPF1tZMShAGT4srRJ8NNT09wwwX
	AZ9QaIxqHXL6RBwzdpvv+J6sWgR1M+fFushefhZWdpw0fn/X5nQgxjjZphgaZEVFyuFQ3TwYR3b
	ukA07I2WGV3CTa7Lbnw5F2js16YzCEJKlpTwtyVdS+xY6lvl8o5yK692UuDkJn3SqS5ubxlzzWC
	VlfNhiMUqZxCMvoaIVJJ3Xa/JgctMm4dUH4UpLhbbY1tiIY0ci9GDIJ6geZR/+BjYsX/mJdMaf8
	MhyGi0+A3RhigLMPrlvy+6EOrzhB1fTkndGoeC12ZFt+9CDUn9UlUCQagqDJTshG4FekcgSBFS1
	fVej978TrLVvG6BczgI=
X-Received: by 2002:a05:7022:ed0d:b0:182:d0a8:d1a9 with SMTP id a92af1059eb24-192e88a169dmr2506797c88.0.1792660631101;
        Thu, 22 Oct 2026 02:17:11 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3673e15353csm25692692eec.2.2026.10.22.02.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:17:10 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: ipvlan: failed newlink leaves shared port state changed
Date: Thu, 22 Oct 2026 02:17:04 -0700
Message-Id: <20261022091704.3652547-1-teel4res@gmail.com>
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

Two failure paths in creation of a new ipvlan slave mutate shared
ipvl_port state even though the requested device is not created.

1. ipvlan_link_new() publishes the new mode/flags and existing slaves'
   IFF_NOARP/L3S state.  A later do_set_master() failure deletes only
   the new device.  The existing slave keeps the port alive, so none of
   the shared changes are rolled back.

2. If L3S hook registration fails inside ipvlan_set_port_mode(), the
   per-slave IFF_NOARP change is reverted, but the newly written shared
   port->flags value is not.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1.

For the first path, an RTM_NEWLINK requesting L3S+VEPA with a nonexistent
IFLA_MASTER returned -EINVAL and no second link was created.  The
pre-existing slave nevertheless changed from:

  mode=L2 flags=0 noarp=0

to:

  mode=L3S flags=VEPA noarp=1

For the second path, fault injection in nf_hook_entries_grow() made hook
registration return -ENOMEM.  The failed request left the existing
slave's shared port at mode=L2 flags=VEPA while correctly restoring
IFF_NOARP.

The newlink operation should be transactional: defer shared-port
publication until all generic netlink steps can no longer fail, or
restore the full previous mode, flags, NOARP, hook, and l3mdev state if
the outer path deletes the new device.

The 2026-10-01 ipvlan review thread notices the narrower flags-ordering
problem, but does not cover the later do_set_master() failure or the
complete L3S/mode rollback.

Candidate BR-011 and BR-012 reproduce the two distinct failure sizes;
they are presented as one transactional-state bug here.

The PoCs, failslab runner, and logs are available on request.

This was found with a multi-agent workflow; both state
transitions were reproduced under QEMU.

Thanks,
Cheng Yongkang
