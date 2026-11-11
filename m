Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367311;
	b=hhCL1mxP+FMS/kSCaQLzK+i/SMRItXhpdIgzHJ5sXwSUeB9Y8D7QNBmtNyiHS76RtiT1
	 l48KGHIRYIzDIb3M0n+ylDcCi0NEkiaiCzlRYfy17DnkQHWhM0z1TAIEg13AWexfov3Sf
	 ZV5WbMqGBoaeZUDVOvpzSoyEsgbU89+WKSs+S2/hIhkmDvQn3XLVDSJB/szzUBhCc+Iic
	 LXVgdYpLPzK7rFQ3D17vCtDF9wJSEehkUTUvhavVjFJWQeamVRJoVvdVlAZp0jVfj8w9R
	 8YelfgCnGr6fwDb4RvQf8xlj88qkBVi91s+nvk7pdUAXk2DyCT0gQ5hpCzhb1TjfTww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HHekPeqyGWTFP/9TlxTpM6xiARKQpfozn60WBx5Zas4=;
	b=i+x5vO4yzXWgRpAuJlTRdJtBAH8j9htll886Ggpeiie0d7ok3jpJAZhFu9K/Vc/zLlkR
	 ev924jMSHVt4vMD6pl6Pyi80qcbDi/id9Lwv4I3N7vEtVQUYwaao7FQtI7lqz3Olhp6U6
	 zRh4c0DVWTbglac6YJ4nZhQamtEeZaoq0SbUmsl7pfqcuLuZ1RyrkelhaKVM5yB1TChHd
	 0Ed8rSsipzCuNXiih2+4SDMBbDXZEXCJmdXNPSvIHYEY4pONHWqTX58nLxRYGrKmzqBYt
	 OPpRArutJCRINr810tA+BdbJW9c85QdEmNSlk2MEpKzICBasA/dr+en4vK6qc4gVl6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nCxf1X6m;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBE0606A321
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 03:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCBE0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nCxf1X6m
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-372bdb942dbso3524183eec.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 19:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794367310; x=1794972110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HHekPeqyGWTFP/9TlxTpM6xiARKQpfozn60WBx5Zas4=;
        b=nCxf1X6msrsrraBBBnOXfN/6taGnH+s/MLA5+HPoXXI+E7nv+EdZCuCv6bOptJwEhu
         xClAJvpHsRiq1/Si55X3QH+ntDagSvTeSR49DqvCulozxuL3DdwPB50PVfle1JA1r8k3
         VyN3DdLRB9NhsFNewq8C9WRuNUbFB/dn8P1xHnQ4InQAMDMX1dmnWmyc2bcKT+/7ZSMk
         hxtXl6dQdD46KD48dzLer+LvI4sl5M9FZqrEH+INLwS1ZY5LPH4iVQ2eqjDa6Mgk43uM
         3eLYVRFfNEmhy6X3UaRbDVtyIW7REMyFKCBIMD5xnhjqJBgNOxIAF/qAnjN+P8r7+Ewz
         i6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794367310; x=1794972110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HHekPeqyGWTFP/9TlxTpM6xiARKQpfozn60WBx5Zas4=;
        b=f0qc6+rlIJNhdqqSnbLBAVmeayNVWRtL/Ks72jEA8wqVXYNgZtda3gmDOsZ+JoMq/P
         god1YwQiSDGyGdZWwLJwJDI12BYU8rHtDk9gWBYR6T5nDUIMnNE35rBbSy7oPNEudB8a
         ZlEmnHWIe8oh1/9XqNgG6MI0qQU8jAMYVJ0UEFdMBts37pjgEwmURsTI/7xup/ejEGSr
         LurXJO9/mvVry7cXrCslZhqBd4eXTs9tugBqp6isUzchAiKtKw52jYUnUhUQHIxtHetb
         hVErTD0O7Bbj4+eXoBFBVgxaYHpBJ1YAbxzCbDCUzxe6BSJ9KRzOBMhCUbCVsKiKmOub
         Twfw==
X-Forwarded-Encrypted: i=1; AL+hErFDtpU0TG/t9NOegRvsKlF9Kqgw1Ihj8d8EVrk68AQ7ohLJrcVwAa8O5BWlQQJTsrOQj1QvW2U=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hlcYYVw5XnEnJ86MmtTlR9S8lRvIy+oVqqa3NBnI+WVK6Z+Gh
	PjeXRiGGgSeHvaKG6d3nfvluqdpEN9NsW6QkHNLV8Nvzix+yWtP2wyBU
X-Gm-Gg: AYBFou1RhZ3rz15RRtrnZIDzoHZIJwzGgQgf0ORoLaeoNcd47qD3ZOUsZH34Jy2zwri
	bIFUIDvZzDUH9b+VF1LiKnBsZdfdKcNX2B9tO6MsE/1uDV4O40zC2xntzyVFvcOkP/xPBxLaUrN
	SyMtsxZP9cpmF+UAQebanG2sG2zWQ7i5jr836Lx1FtH6LXj5gu5uS38Pseg7Y7Ew4K4hqNoSm9n
	5qLOh6D8ADqDXnyW21PWkxx0m0vmW7nH/5idf5eTtfRqL87jKQC9kvJgGxQiKN1VOfiKEIu8TDt
	i6AtJnd5OT63OvjXOjP4U3VWI97dN7Z7HdGfAVfanGKiwPy8FQBQRae1j8epxdUuc6nxaqkgkfl
	82z97+R/aWvTjyRPBAt57lEWjTt7mBxLCc2DNfUhzxFmc8n2KAUen8z0E/J+5TCFuPtAyZ6/FED
	0hmqvd3D3Wjkhi1HEsaLRno2eoYKwTbnAN1MdD4EMfHBb08MJ+bhTxJlq8Eg3vrxQWHyZiafy+u
	VjsE8b2alY1xbGI3Swx+tnCk/nr09oxsv/T0zexe9AhI1HaHWlpSP10uZDC7qXoHBddjrnYA6KZ
	Kr14MicqO3xBHShTyUmQAgbB6iYPSwWvi3IOeRQBG14Rw/NmSj7gD4m2Q/1Kw7KysvF94LL1Nth
	+6xrnz+k/
X-Received: by 2002:a05:7301:6589:b0:369:e8b0:af85 with SMTP id 5a478bee46e88-3768701ccdfmr2376910eec.36.1794367309538;
        Tue, 10 Nov 2026 19:21:49 -0800 (PST)
Received: from build2026.lan (67.230.168.206.16clouds.com. [67.230.168.206])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751ad6f11csm9801896eec.0.2026.11.10.19.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:21:49 -0800 (PST)
From: ThisSeanZhang <thisseanzhang@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	netdev@vger.kernel.org,
	Nick Hudson <nhudson@akamai.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: [RFC bpf-next v3 0/3] bpf: Add PPPoE encap/decap kfuncs
Date: Tue, 10 Nov 2026 22:21:38 -0500
Message-ID: <20261111032141.525444-1-thisseanzhang@gmail.com>
X-Mailer: git-send-email 2.47.3
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

Hello,

The motivating use case is a TC BPF PPPoE forwarding path. When such a
path forwards a GSO packet larger than the negotiated PPPoE MTU,
inserting the PPPoE header manually leaves skb->protocol set to the
original IP protocol, so the stack cannot select the PPPoE GSO path
and the packet may be dropped.

The kernel already supports PPPoE GRO/GSO for ETH_P_PPP_SES
(introduced by commit 55a5d8fca836 ("net: pppoe: implement GRO/GSO
support")), but a TC BPF program has no direct way to update
skb->protocol and the associated skb metadata when adding or removing
a PPPoE header, and bpf_skb_adjust_room() cannot decapsulate PPPoE
packets either, as it only accepts ETH_P_IP and ETH_P_IPV6. The
current workaround uses BPF_F_ADJ_ROOM_ENCAP_L3_IPV4/IPV6, which
marks the skb as IP-in-IP even though the wire format is PPPoE. The
BPF program must also adjust gso_size manually [1].

This series adds bpf_skb_pppoe_encap() and bpf_skb_pppoe_decap(),
which insert or remove the PPPoE session header and keep the skb
metadata consistent with the kernel's PPPoE GRO/GSO handlers; the
encap kfunc writes the PPPoE session header itself, mirroring
pppoe_xmit(), and the BPF program sets the MAC header's EtherType, as
with the existing BPF_F_ADJ_ROOM_ENCAP_* flags:

    bpf_skb_pppoe_encap(skb, sid, flags);
    bpf_skb_pppoe_decap(skb, flags);

Based on the v1 discussion about whether new UAPI flags were
warranted, this version uses kfuncs instead, following the existing
bpf_skb_set_fou_encap() interface. No UAPI changes are needed.

Since the kfuncs may reallocate the skb head, patch 1 adds the
KF_CHANGES_PKT flag so the verifier invalidates packet pointers after
calls to packet-modifying kfuncs, analogous to its handling of
packet-modifying helpers. bpf_xdp_pull_data() and dynptr writes retain
their existing handling.

The selftests cover IPv4 and IPv6 round trips, the PPPoE header fields
written by the encap kfunc, rejection of non-IP encapsulation input,
non-PPPoE decapsulation input, unsupported PPP protocols and truncated
input, and verifier rejection of packet pointers held across a kfunc
call. All 9 subtests pass in QEMU/KVM.

[1] https://github.com/ThisSeanZhang/landscape/blob/80bc43eef7143ad029283fe2a8d510718c22af12/landscape-ebpf/src/bpf/tc_chain/tc_pppoe.bpf.c#L38-L47

ThisSeanZhang (3):
  bpf: Add KF_CHANGES_PKT kfunc flag
  bpf: Add PPPoE encap/decap kfuncs
  selftests/bpf: Add a test for the PPPoE encap/decap kfuncs

 include/linux/btf.h                           |   1 +
 kernel/bpf/verifier.c                         |   1 +
 net/core/filter.c                             | 192 +++++++++++++
 .../selftests/bpf/prog_tests/tc_pppoe.c       | 269 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/tc_pppoe.c  |  77 +++++
 .../selftests/bpf/progs/tc_pppoe_fail.c       |  36 +++
 6 files changed, 576 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_pppoe.c
 create mode 100644 tools/testing/selftests/bpf/progs/tc_pppoe.c
 create mode 100644 tools/testing/selftests/bpf/progs/tc_pppoe_fail.c

---

Changes since v2:
- Replace the proposed BPF_F_ADJ_ROOM_ENCAP_PPPOE and
  BPF_F_ADJ_ROOM_DECAP_PPPOE UAPI flags with
  bpf_skb_pppoe_encap() and bpf_skb_pppoe_decap() kfuncs.
- Add KF_CHANGES_PKT so the verifier invalidates packet pointers
  across calls to packet-modifying kfuncs. bpf_xdp_pull_data() and
  dynptr writes retain their existing handling.
- Make the encap kfunc write the PPPoE session header itself,
  mirroring pppoe_xmit().
- Rebase onto the current bpf-next.

v2: https://lore.kernel.org/bpf/20261003193347.1137527-1-thisseanzhang@gmail.com/
v1: https://lore.kernel.org/bpf/20260926210757.2152159-1-thisseanzhang@gmail.com/

base-commit: 0fb18ce8a2e9de830433923cf65838933d615359
-- 
2.47.3

