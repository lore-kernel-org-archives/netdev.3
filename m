Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF2830C177
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791056039; cv=none; b=SqcZOH70CvriHSFDRLKyMHXpudlZ1IwYRCfLq75ni336rIO7kgVSOD/YgCBUTf0Telxr7gjIEx4ypyPohXB2PDLlfHF9ZcXtGXlwAgnX/aHS+aDAde+KMoJ8H48DElxCVauL/6CvoErtCdqY2Qm6GLZ1v9JCVJokzxs+61ChZ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791056039; c=relaxed/simple;
	bh=ix7iYj5vqPHM3CUJiIH5p0aWVSdqoqvsaDt0N+5v9oI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FA35pVtG1Dma9HXpvNaTmFWOeOmWUKoa2nrNnYNYzU6O9KkQadTnszm+AczIXybNkuHFS5rGcPD+L8MeRTF6xQcP0HY47XCNhkVAtwpC7IywctsLqcEtkzd/i6BpChU8m0YKFvhrnsjaZqY5HWLlsQlwAFOpWCtC5uVQdWqW/oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfV75arM; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfV75arM"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-34ca2d54925so873647eec.0
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 12:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791056037; x=1791660837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HFSXxSxjT8YQsr4YZZMaSpISRrIbJpif78a//e16BNQ=;
        b=nfV75arMjzjh2D4nOb4u4NSo2ay4/E7xYdmbkkU3YxXYptaPofj7gIHifFCvepgCXC
         bIk+CscoTkqjHyVCrRHUvMM8hWWJAlSGbG0SJSvVvltwmsjM85+emqIguP3V+v/2FTUV
         R2Rxbg0orlUmAEbBxWfRV9nsx677LGRuV+LYNMkYczCxmCTpGxzGyn9HF+JElA4fxRUU
         Q45GOG1lhH319gppkGomN4OtZUgdq3YCSOX5jnKpu49fqShpmN5rliCqCplY0e6Y8tV9
         9lE4dFUNh1sCxc1PowVb1ZLTcWTTMv9zalVE1jwLg+Tr+tErVxyAeFKm8b/qwFflXu6f
         MWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791056037; x=1791660837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HFSXxSxjT8YQsr4YZZMaSpISRrIbJpif78a//e16BNQ=;
        b=C/6Uai4gXzeIqfUs/XOifriObTKc+8xIxntBGysYoxIuIsWj+8QIOXw3HFlsCgQrag
         xemrue9qhobJ47eMXvw4ukcwx6Fe1yzlZ+sSoOg/AN8FMUjyl2OSKmBicYtPYGwxCN5/
         cUeODDug04kX7hhtVvPrImzUmseNCAVUvWW0Fp7e1Lw/jE4bxGNlyl5wpsI9HUD4ErXv
         AZmRVYNZ+lnx2VNZ3L5lv0Tr2X+g+seafROdqOcSVtb2bWFJSHEjW+T5xN+p/KSiyNBQ
         biF6nLr8pKV89pujWgV0F3pJjjMa7M69o8g/Rws+bUZSF2SyOutX9V8neZ+AxahjFCOw
         jamQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJq99PbFkQI9/SFUp5jTNnN+UZeU+TkUTZWfhJb3y9msHOY6cnksu+9QF3tR1aHCu3tuwbRCw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdcu0A5uiipnm4GZTupOeawGVSxs+3Wj+mpWj5upMgrS0rzf+b
	Mu07iFVwPRyLuRn9th4F5Sv/x6feP2f6lJEWtLYEzcYOikdvdglK/zGI
X-Gm-Gg: AYBFou1ATMfB4afzWLLWubM0MLmsy8Vlu9cLyy2sGoUL+bFeqxPXhR3XCzqUoNJs5Z3
	4UBVMBXb3u/LUG07wb9xR2MFCgwHoT2gmyXT7S05cNQdYPO4vvOc2QPuvbDUMdmzXBOn+Sz7GRM
	RPO6BuRwMxfx1H+1A0buo12VwL1xzqd57NwgGOZZoYQLj3FiycQdKErx/FB4oGPMdvkHqBxcsy8
	nNuPml6NkUEbgkRyPO/ju+up5rGeDmyvg+8eduCkkhpOhi1tD716CN70HKP2r2KtHU+k67l8USw
	/45lTfUNVSCXp3Fsg2Jj857zlR66HfD5LI1CAPfy2akRCneXe5byZsOK5CP/+si/em2NJVnvt4g
	pzPpFp1gbx9rp8obWhfKFiY2xsz4FwSGYOUFLBqm9M3T4RJD/2vFggUJ+FEZLJHMUXZOB3PZc8Q
	O/wPiKmhVLpsR+t2q3MhMAZLkrS/Edj03g68+/2wDrsJ2dWsBsWT4oplwVzBp3UtS7SR5gDGw4z
	neXBGiEciqXJ8+NbztUAKgeN+pswc6b
X-Received: by 2002:a05:7301:fc09:b0:34d:755b:d60b with SMTP id 5a478bee46e88-35111514891mr4058238eec.34.1791056036900;
        Sat, 03 Oct 2026 12:33:56 -0700 (PDT)
Received: from build2026.lan (67.230.168.206.16clouds.com. [67.230.168.206])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f660f1sm17793271eec.13.2026.10.03.12.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 12:33:56 -0700 (PDT)
From: ThisSeanZhang <thisseanzhang@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	netdev@vger.kernel.org,
	Nick Hudson <nhudson@akamai.com>,
	Felix Fietkau <nbd@nbd.name>,
	Qingfang Deng <dqfext@gmail.com>
Subject: [RFC bpf-next v2 0/3] bpf: Add PPPoE encap/decap support to bpf_skb_adjust_room
Date: Sat,  3 Oct 2026 15:33:44 -0400
Message-ID: <20261003193347.1137527-1-thisseanzhang@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

A concrete use case for this support is a TC BPF PPPoE forwarding
path. When such a path forwards a GSO packet larger than the negotiated
PPPoE MTU, inserting the PPPoE header manually leaves skb->protocol set
to the original IP protocol. The stack then cannot select the PPPoE
segmentation path, and the packet can be dropped.

The kernel already provides PPPoE GRO/GSO support for ETH_P_PPP_SES
(added by commit 55a5d8fca836 ("net: pppoe: implement GRO/GSO support")),
but a TC BPF program currently cannot update skb->protocol and related
metadata when it adds or removes the PPPoE header. As a result, later
networking code does not see the packet as a PPPoE frame and cannot use
those handlers correctly.

The current workaround uses
BPF_F_ADJ_ROOM_ENCAP_L3_IPV4/IPV6, which marks the skb as IP-in-IP
while the wire format is PPPoE. This requires the program to adjust
gso_size itself and leaves the skb metadata describing an encapsulation
that is not on the wire [1].

This series adds PPPoE session encapsulation and decapsulation support
to bpf_skb_adjust_room(). The new operations update the packet layout
and skb metadata together, making the skb compatible with the kernel's
existing PPPoE GRO/GSO handlers.

Examples:

    bpf_skb_adjust_room(skb, PPPOE_SES_HLEN, BPF_ADJ_ROOM_MAC,
                        BPF_F_ADJ_ROOM_ENCAP_PPPOE);
    bpf_skb_adjust_room(skb, -PPPOE_SES_HLEN, BPF_ADJ_ROOM_MAC,
                        BPF_F_ADJ_ROOM_DECAP_PPPOE);

Encapsulation changes skb->protocol to ETH_P_PPP_SES. Decapsulation
accepts only packets whose skb->protocol is ETH_P_PPP_SES, reads the
PPP protocol field, and restores ETH_P_IP or ETH_P_IPV6. Both flags
require BPF_ADJ_ROOM_MAC and a fixed eight-byte adjustment.

The PPPoE GRO/GSO support must be built in or loaded before this path
is used for receive-side GRO or software GSO; loading pppoe.ko remains
the responsibility of the user-space setup.

The interface follows the existing BPF_F_ADJ_ROOM_ENCAP_* family. I
also considered a kfunc-based interface and would appreciate
feedback on whether that would be preferred.

The selftest covers IPv4 and IPv6 round trips, protocol transitions,
and invalid flag, size, mode, protocol, and truncated-packet cases. It
passes in a QEMU/KVM boot of the resulting kernel (11/11 subtests).

[1] https://github.com/ThisSeanZhang/landscape/blob/80bc43eef7143ad029283fe2a8d510718c22af12/landscape-ebpf/src/bpf/tc_chain/tc_pppoe.bpf.c#L38-L47

ThisSeanZhang (3):
  bpf: Add PPPoE encap support to bpf_skb_adjust_room
  bpf: Add PPPoE decap support to bpf_skb_adjust_room
  selftests/bpf: Add a test for the PPPoE encap/decap adjust_room flags

 include/uapi/linux/bpf.h                      |  22 ++
 net/core/filter.c                             |  85 +++++-
 tools/include/uapi/linux/bpf.h                |  22 ++
 .../selftests/bpf/prog_tests/tc_pppoe.c       | 254 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/tc_pppoe.c  | 163 +++++++++++
 5 files changed, 543 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_pppoe.c
 create mode 100644 tools/testing/selftests/bpf/progs/tc_pppoe.c

---

Changes since v1:
- Rework the cover letter to explain the forwarding use case and the
  PPPoE skb metadata transition.
- Clarify the PPPoE module prerequisite and GRO/GSO scope.
- Replace the reviewer questions with a single question about the
  interface choice.
- Fix multi-line comment style in the selftests.

v1: https://lore.kernel.org/bpf/20260926210757.2152159-1-thisseanzhang@gmail.com/

-- 
2.47.3
