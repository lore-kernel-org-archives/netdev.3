Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660513;
	b=qkwyo6EdkOOR0dqyVwAmmBsPuDmowTuIqkVF8PsUIZxiu9+tPebbUBDDr8WTzALU6tnx
	 BGo6MxZ61TPsWTrsyIU3sH/qUhf6YRWcaSd4s3lQ55coS4GLbUl59DXzx/QNKAteE4XZ8
	 CxNJ7gbNHqro+k7UqAQqtGFNDUljCvYmGPGj5k/ddGJD2yqm9An9qDD1j8XDQZ4/Y2oXa
	 cFbGVK4rbJlzQQT8vow2dElexw1MAI3SGS+AFVQSMXkGSELAGcAC6OzmWAWB/puX398p8
	 isBmzFmOulM34O52XIOIot3IjQR8YT6nfQtsK8MarTLqM8bXMUusPb9INID/guMzYqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=e7NVZjs7NMYnhNT7+IbNDUXDeXgt96yTHJb2bsDwWM4=;
	b=zjIwc06G6zl17P0+Dwg1OxAs7NSCJsbcsu5s5EWMaeGglnekDT6jzrfkhdGOc69jKG0T
	 hCweKpcH2lY/4fJryjsrebJxxLvUGe3vOmnlydxEtY0LZ1CpYFkYuFeiqztspSY9J7P0X
	 TITMNSSonynR+o0Hfogd8g1Zgk4crBevkM1OfvIqZWNjKVAbqR+i25xEmFxyjZgLWyzDh
	 Ly+BxD3+notmMkLeGHlgR2ctqUGm5MjwQKLy9KURSxCHsdooC6Hnv1BF91t3tngXzxt5K
	 NRXDrfbg9CliaYC25rUvg4LqIN2h7wdTV06WasGxA4i8ui7hSUvmaubnPd+6qCNib7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QhriTMCq;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5585B606A320
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5585B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QhriTMCq
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-33baa8eb238so947443eec.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660507; x=1793265307; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e7NVZjs7NMYnhNT7+IbNDUXDeXgt96yTHJb2bsDwWM4=;
        b=QhriTMCqanFSHGj1/mrQRgaQJRQT0WGi/+TulRag7c9OqGnMfhLtzqL2CQSYXPG6Oq
         2oXDyR0DXl0LFIusx1pdmqEn8ORXXo3WHfTKUJkOTpqyQ2l4Lo7nAJ7cdorxLVTMt419
         bBErp20v5DH8EY/5Uev9R9XizbWPirgqzHl+Deo4lLIXIC3YR/FFIidiPdAFsPH+tdL6
         FsSFXG36ym2ubJdn8vDk2n+2J5jSlBlidpM/Fz+5IsAGCMBT+nZtrCjbWVadua/1zQHk
         pBMwq5kn1ZMVnBMMLWvcGu+or+/yplXBh0AmfpP7Ew4YpLYohlDAzgJCfDJrzJp05Wam
         mMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660507; x=1793265307;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e7NVZjs7NMYnhNT7+IbNDUXDeXgt96yTHJb2bsDwWM4=;
        b=Q3GDmAmcoBmfu7iW2OvbxO0mRzkhLt86Zozyu+zaghzAHud4S46MWaqhEmZNebQ1ek
         vzCT8sp+HSS793DV0CvD8Uo4IvMlTr6pLJ4UahEQMw8R2PKv08mb9ZgpVJz8P+0BLB0F
         lGnzx2DfLVbNqGyoaLkXoep0R7VPsgz0f6Cwb9/f1ZZj7wP7hw/jTlz1YX72pONA3vH8
         +8oq54sLSJrbYsAZ64wXcsRoNL0dRW3XQTIHGKQTQPq+M70iT2a8lYzh+R3/OIBe4zO1
         4M7sfbjp2F6AYs7TPGNA27sQ0gz0cdBM1Lq/qgyazYJYRo33LTsM6Axi4F0nxmYfWL5Z
         +FjA==
X-Forwarded-Encrypted: i=1; AKwUvBy8BgolzjJzSGy7YjeT2CkIsFJBkdATddfMEwSVCYz50QwCBJulZgoLYb95fwvU3q4XazGyluw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsdY4DUofdE5TOgRL5APyaEl5bp7i1y5c+6t8dS6mcZr0eMEIl
	erySrNlSV7BdvFMhSZC1/QarkHTlGBjBnvzlzxS7rf5eprQZcb0+EfhtKC3JBTBY6OM=
X-Gm-Gg: AYBFou0uFFlOKT8AIrPlXUAvqsPKkLtPLiK7BWQlJXPFzF/h0v8jVvEGk1PtVWd1n+q
	fSrMolUofAKWQvMDEKbFQtVQg1mHYENMYx4gRC3+0+XtDp52w3LxDVlxkvG0hUi/yAKQsgM2ndO
	Grmnq7JlqTIFSvLVDWsDqQuwRjOk8oqSsKb8rWEB/pIv8+6uytzpt/FzyZrT6dvZXLOUs4tCDaH
	x1gVhs5GuWlRJwODltE+RaSGjhxpJYUuHXJDxf3P2Gz36hsXKsc83E0ODVBrPkS6hTWb6l0fYyj
	NABSlyHZMLnIos3BfPNn94rvxSlGe69uPDwi8DfbRfuWEvz2dXLxtMyrRXhBUrzPBddG3T6YnGU
	u/f6b89ZRtrP0FetfsiylGmQ9Zf0m7Ad845PwPx7VPQw6HuLO8WamLioJXoas8UwfMBq7biBQzi
	PHy5hTWPbKOjYw6wI2EgkoeXFZRsOGt5nVv2k7SRD+RYFFZd65M5MUwsF1fH85u4QQxFnV0dLdV
	yVCCOnoJxmD0xrxnVBK5AuoMR6ttltK/4Sb/NAME7OeKBVPSXma/1RyoF+3Lk6xgnKojAz+oiPR
	CavQle4RHOjacNfWjWRgaNhG+aFieeIAfrcSsmwB
X-Received: by 2002:a05:693c:4199:10b0:35e:1807:cedf with SMTP id 5a478bee46e88-3674a405bbamr7360868eec.1.1792660507440;
        Thu, 22 Oct 2026 02:15:07 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cca3d8sm14612471eec.14.2026.10.22.02.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:15:06 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: bridge: MST bypasses blocking when VLAN filtering is off
Date: Thu, 22 Oct 2026 02:15:01 -0700
Message-Id: <20261022091501.3650765-1-teel4res@gmail.com>
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

MST can be enabled while VLAN filtering is disabled and no port VLAN
entries exist.  nbp_vlan_init() still installs a port VLAN group, so
br_mst_is_enabled() returns true even though BROPT_VLAN_ENABLED is off.

With that configuration:

  ingress skips the normal p->state check and forces forwarding
  br_allowed_ingress() accepts the unfiltered frame
  br_allowed_egress() accepts the unfiltered frame

A port in BR_STATE_BLOCKING therefore still forwards data in both
directions.  STP/MRP loop protection is defeated.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1, with
vlan_filtering=0, default_pvid=0, mst_enabled=1, and a port whose
IFLA_BRPORT_STATE read back as BR_STATE_BLOCKING:

  MST on:     egress=3 ingress=3
  MST off:    egress=0 ingress=0
  MST on:     egress=3 ingress=3

Each direction sent three matching broadcast frames.  This is a
deterministic configuration/state mismatch, not a race.

The MST fast path should require both MST and VLAN filtering, while
retaining the existing non-NULL port VLAN-group lifetime check.  The
MST configuration itself should also be rejected if it is unusable with
VLAN filtering disabled.

CVE-2025-40297 used the same broad predicate for a port-deletion UAF,
but its fix only added the vlgrp lifetime check.  The normal data-plane
forwarding bypass remains in current source; I found no separate fix or
CVE.

The test used a diagnostic switchdev endpoint only to establish the MRP
ring state.  It did not replace bridge, VLAN, MST or packet-forwarding
code.

The PoC and full program/console logs are available on request.

This was found with a multi-agent workflow; the
forwarding differential was reproduced in QEMU.

Thanks,
Cheng Yongkang
