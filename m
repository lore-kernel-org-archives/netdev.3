Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911BE34D398
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985420; cv=none; b=CjQVdouNU8AkCJsPDaKYZlNvv61s4QIqOvFprL4tr7xjEsaU5Lt6PWqHc5Cbx5rqAk/bpLG1vPWNrVrueYIIWn1LclvuyUcrCxJnK1lazktqdGNHDrgAihJq76Rn+bibI95gV5ahut/YCnxpEE32bqYnwh8FjN6XkzqzVv6xE9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985420; c=relaxed/simple;
	bh=tm0PUIOO7irF/uPbiShHjbLnW9yJ+osDka6vaKqM2AE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O+EFSjGWRZP1cXntuCr9IFrHQNyEB1zJ7GEQ0NFkqmYoxEA8EjhjaFxq28tMInEfxadsjHb6TpYL2nr9FL6gUEVXpYNqTWanLw3AIVFnC7AdcLTfaN079wNqSKlmyHdkS2J/EeWxnRx4HVQ2ne6eui6rQNKBQk5O4hb5PIac6hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItDpii59; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItDpii59"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7dcdd1b492eso5285154a34.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 05:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777985416; x=1778590216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xfAY/hy6pRZsmaeE2NRKXg3RnVIaQy/IqHfb0ZughJA=;
        b=ItDpii59aT7iYpM/ql+qa9uwdQ19askRUS0Zek6gheThhqSkRAKy3OzSjYQt3C8M8X
         1khQ4uoSf6DmsifrO4PlKANzsgYJcK6uFYg17xXgIsFLr97AKVkOqPOVLGDiC20Xxx7f
         V9t7stSkUOOqWWExH6Q+qbzdxBdmYFyr8yfZRxP3Fuo76se1m2Sm3YLXomiShENp49t/
         87TB7eXScspQ4/LtEwTazbjX8PVMpPkF8L+T0cnrBOcISf6CAXFh+2bNt7xGdzR4Fjw4
         HO95DCAIuHRoBJQk3tpT9eWKg7+dcRThbP+joToBJNBBsNFXqu3AkaOYKCxi7/y+lt6r
         1n/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777985416; x=1778590216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfAY/hy6pRZsmaeE2NRKXg3RnVIaQy/IqHfb0ZughJA=;
        b=SafUD7Q5OybbKvR8Cd7JpJ+WVaU69wSHpgT06MlFW3O23WSmOCydQIdA9gGtXmAAiX
         W3CrHhxpp1PnS6s332bUoVfxkFn6/MzoJ6eQ158KHrKzUJ7gE6ztemDCf3xcyfFCZ0gC
         B7QJt1xWtHlZG9E1ttdPXnviY9WbOUHaEEbpCQU0ahjq2Qz99t8MjwCIpfkaUKC7XH55
         KVEuQ/dltrl0/yZ8iHubNyzpVB1b2aG+vIMkYGCXDyzK1kr6riwvQed4+u+NfE49npaK
         ur/UDqBU6YoWmfgHMTsnSCFycDySZ/hXY2hejl5PBbExRD2YSFDf3WSHdxvALKLuixzN
         gNXw==
X-Gm-Message-State: AOJu0YyO/zlpz32Y/lJ22SC/sVj4PIfjlNLwZqIwVXhbqTFWVObDD7NC
	CK4SieZyXzWL1x7j8MNuwLumQZ79IxBEvXu53o1YOLtTT9cNpP8tIqm+k6Ds3F3BT2g/Jg==
X-Gm-Gg: AeBDieuKE/X/XBqt0P1JCpq0+9Kv0VI0sDom5SpS7dPEzkZyVqOsZDWsQLvQ+hBcgN2
	gJKHqVSFvugmKFKKsx/+OzmZlyHRtlLjHlWbIn01Bj43EzayN+KPhkFdQ8p6Dklf/LNClvigYWG
	pKfm3ueOhqQ6RB3Br8q+OoNqqtZdIX7oOC+Bl/zGjfTikk8Jy9UUVgRlXlcSJV2xAfK4LHyW83o
	0oSSd7bi1y5w9HpHZqcLDpirwbMn0zyV7/JBbbyW0Gogkokpc8rfNDfx7QGZG0wtfSzWcy62Rao
	sVtCBPOVWf8mvVd34BX1LtQ3bk5rDqwfzfBa2pDX/SisbZhf5a0Z3kL8MOjo21H5VZD3CWMPvHo
	9MA+Q5VnjipSAi9qA40iudso4uHT4KufTUdqGzbK8l/So452cvQhhtjPl9CwCFVpypW2Z7aSyGF
	XL5YY7dgCzGPxjA4/LH/7lKg8Aew==
X-Received: by 2002:a05:6830:4423:b0:7d7:e3d7:e200 with SMTP id 46e09a7af769-7e0bfce9c38mr1942793a34.6.1777985415715;
        Tue, 05 May 2026 05:50:15 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7deca7a5e75sm9884812a34.2.2026.05.05.05.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 05:50:15 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v5 0/2] selftests: openvswitch: add pop_vlan test
Date: Tue,  5 May 2026 20:49:55 +0800
Message-ID: <20260505124957.1239812-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add test_pop_vlan() to verify OVS kernel datapath pop_vlan action
correctly strips 802.1Q VLAN tags from frames.

Patch 1 extends ovs-dpctl.py with vlan(vid=X,pcp=Y,cfi=Z) formatting
and parsing, plus an encap_ovskey subclass for safe ENCAP NLA decoding.
It also adds push_vlan action support (parse/format with range
validation) and removes the unnecessary MAX_ENCAP_DEPTH limit.
Patch 2 adds the selftest using purely ping-based verification with
a push_vlan return flow for symmetric bidirectional testing.

Tested with vng on x86_64, all OVS selftests pass (including new
test_pop_vlan).

v5:
  - add push_vlan action class, dpstr format and parse with range
    validation (vid 0-4095, pcp 0-7, tpid 0-0xFFFF, CFI forced to 1)
  - remove MAX_ENCAP_DEPTH constant and depth tracking (bracket-depth
    counter in encap parser already handles nesting)
  - remove start_capture/stop_capture helpers and tcpdump/pcap
    verification — use ping success/failure instead
  - remove modprobe/netns pre-flight checks (other tests don't do this)
  - remove ethtool VLAN offload disable (unnecessary for veth)
  - add push_vlan return flow for symmetric bidirectional ping
  - use ovs_sbx wrapper for ping commands (consistent with siblings)
v4: https://lore.kernel.org/netdev/20260504123713.555461-1-houminxi@gmail.com/
  - fix all checkpatch line-length warnings in new code
  - fix pylint W0707: use explicit exception chaining (from exc)
v3: https://lore.kernel.org/netdev/20260503120946.51869-1-houminxi@gmail.com/
  - encap_ovskey: MPLS type "ovs_key_mpls" -> "array(ovs_key_mpls)"
  - encap_ovskey: PRIORITY/IN_PORT set to "none" (metadata, not in ENCAP)
  - _vlan_dpstr: cfi=0 falls back to tci=0x%04x for round-trip safety
  - encap parse(): check return value for unrecognized trailing content
  - vlan parser: boundary check + raise-from for exception chaining
  - start_capture: || return $? to propagate ksft_skip correctly
  - on_exit: moved after resource creation, not before
  - ping success: changed from NOTE to FAIL + return 1
  - VLAN interface creation: added || return 1 error propagation
  - netns probe: distinguish EEXIST from missing CONFIG_NET_NS
  - sbx_add: || return $ksft_skip -> || return $? (match sibling tests)
v2: https://lore.kernel.org/netdev/20260501133924.3100680-1-houminxi@gmail.com/

Minxi Hou (2):
  selftests: openvswitch: add vlan() and encap() flow string parsing
  selftests: openvswitch: add pop_vlan test

 .../selftests/net/openvswitch/openvswitch.sh  |  77 +++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 322 +++++++++++++++++-
 2 files changed, 389 insertions(+), 10 deletions(-)

--
2.53.0

