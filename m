Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878B04582C8
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 22:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784672375; cv=none; b=nLY5FuhGeA3y/lYeyiGRlQZ2S08AX6jHp63JHOieXEqm8hbeCfWL3xeszx4eTTv/eNYB0BJMEnG+AwV+jdaa7Ck2wKvPzyDpQ7JaqLh4bz7YpPSB4Y12o18mY7af4qXCLJqhFLrwQK2cqi0fcSCqox6cvnu/YknLznXqTNrAMGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784672375; c=relaxed/simple;
	bh=QpCX8azIXj4ABviDg6v9qs6X2uYp/oseaKFqTRuyM8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CH4oPj2CvKvjOhrFsQRrbik6OH9Keby1qwwuZVHl6Zh+OVyyKtPEI7sFKUXxV269k4iA/LzuZjf+tjKgexc7xC8hmh5R2t6ypvbpN4kEDo3vh161ZG8A3+wD8mkfxxt/bnB49jMyk3DWya1PpoJjHtLcHcG/x2gg/HL6JMO/kOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzJbtMTE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzJbtMTE"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cc61541f8cso67334165ad.0
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 15:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784672374; x=1785277174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TyVLTo1bi5pX6fHnYlWi1OtT5uRPiTlT6gDMTqFxmt4=;
        b=RzJbtMTEhiZ2CyfQJE/vUr4jk+Mv7kS3LRT0s8nQubNXPWykU8eZZxQAqwsQtbUyj+
         kEwZzAVrsi9d6J2jp3stP3aGko7wLDcLp8JqMiPLitp1+1HP6sJCNa4vpy69LgnD7L6C
         J66HFpPN5DvgDw2dLtWbw/f4Ic3gfUOFKdpCGASkOWxzsdIcUKJT8a9JfDrB6ir+TmOG
         HGpHIum3XZO7Hr8zok4/muyXsc3KuzNUpR7eX9JQzlCK/Uw8Ic+yaAlovhQTWKlRnAto
         rwSFG4m7RVkD9jQiZ9AFmjXUV1c+tRLFC+LK/+DfwEF37/69ZdLTHomS4IWNmt5+Fx9h
         Q6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784672374; x=1785277174;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TyVLTo1bi5pX6fHnYlWi1OtT5uRPiTlT6gDMTqFxmt4=;
        b=d4UgpgpSPiLclHzb2w5qPcu/xGChR4rMBfnsN2yOSiUOmrhUucrjcHvk/J37L4D+Zz
         oTWdnJZ7oenChHEL//YZQ2bizQtPhN+NeUqP+Mur9Rtq7+tSeffIcJl1z16bITiJ+L6N
         F8TA3Abwo1yUDfh0zZkQZVdw2ooVEJ9UQE1iFNdhJeuvVnTj7Nf31qxec2vrGQtehcGv
         nAmDOXzUUZ36OSuGx3xnL8DNzb0H0j1jBKOJFc/TTi05iwqfubJHcBqubjdnloqBNhif
         nblAzs0juWoxlwRFW3p6WbUVv/ihsz5Zx5rK/hPvs4PwnZiAHIezcUtPInmq0rMsFGcZ
         KAPQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp+lSVYCoYZra0rhKQpAn7oC4YEUS6Kc7k5i4itkmWUE1ibsqEMpCHA2ccOfamaECRU3R5el6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0/kvW+j0qu9RQKvOf+zfibjOD2Vr2tTqptsDU98/LCRBkSZ7O
	N0vcgo/5al83WJwaf2t+BB7FG9169jApXtAYavuQZ/q6swPE/fcEubG/
X-Gm-Gg: AR+sD11gkTnZ14LgjhZLN0eDfSoS9vW5LrTlRySPMcM1QlnfVOABQdDTx5bR+UC13tq
	WDsC5j/RUQWFFvIxVAbekBTh5yWDBEJzZbRhF39xQeAm0jDXv210uzL9wkaLNn5C4uhPvBk+59z
	5WBP6ywciWUhU5W+k0+bNDL/DEPMWmrr//tVVrRiaERdEP03d7frK4T0ctZxjAQ6/LI0xC+OUTw
	obURrPj/MjaNZi3lOc/R8GOGZY1T+WE1iS+tEXi9oVs+8CDYP89ktwhknXgIiAiP9jzmADhmdjU
	+l613OGeJiBjo9NUwM8Sj1nyyaMUCeFx8ignz5nP8JMT+7BEy1jQdiJC8d3WW2hSICNSUM8OIJM
	LwuHTC6c3QqVnKbEvb65FOclWxRiaV5WSFtxE9SMTXqXPMSUSwnyKVZftmEBV8SRQfxh/SqtLC5
	bDEQtkbgYNFjWQlpHw2AodPsjMfKz1k6lmStY=
X-Received: by 2002:a17:902:f688:b0:2ca:2390:ff13 with SMTP id d9443c01a7336-2cf8dc97414mr16152175ad.5.1784672373828;
        Tue, 21 Jul 2026 15:19:33 -0700 (PDT)
Received: from CPC-mjac-HKWGEZ.redmond.corp.microsoft.com ([70.37.26.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efae5aesm3657535ad.15.2026.07.21.15.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 15:19:32 -0700 (PDT)
From: Jack Ma <jack4it@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jack Ma <jack4it@gmail.com>
Subject: Re: [PATCH net-next v2 3/3] selftests: net: add coverage for fdb nexthop dst port
Date: Tue, 21 Jul 2026 22:19:07 +0000
Message-ID: <20260721221907.2702-3-jack4it@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721152059.GC2667735@shredder>
References: <20260717-b4-vxlan-fdb-port-v2-0-f4862e8fe867@gmail.com> <20260717-b4-vxlan-fdb-port-v2-3-f4862e8fe867@gmail.com> <20260721152059.GC2667735@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Jul 21, 2026 at 06:20:59PM +0300, Ido Schimmel wrote:
> We already have control plane test for FDB nexthops in fib_nexthops.sh,
> can you add the new test cases there instead? Probably fit in
> ipv4_fdb_grp_fcnal() and ipv6_fdb_grp_fcnal()

Done for v3.  Dropped the standalone fib_nexthops_fdb_port.sh and
folded the cases into ipv4_fdb_grp_fcnal() and ipv6_fdb_grp_fcnal()
in fib_nexthops.sh: accept a port on an fdb nexthop that has a
gateway and echo it back on dump, reject it without a gateway,
reject a zero port, allow a group whose legs differ only in UDP
port, and confirm that a portless fdb nexthop omits the attribute.
A check_nexthop_fdb_port_support() helper SKIPs the cases when
iproute2 lacks the "port" keyword.

> vxlan-fdb-port-integ.sh doesn't exist. We have test_vxlan_nh.sh. Can you
> extend basic_tx_common() to test the new attribute? Don't change the
> existing configuration (we want to test the configuration where user
> space doesn't pass a port) and instead add a new:
>
> 1. FDB nexthop and a group that contains it
> 2. Flower filter that also matches on the destination port (not 4789)
> 3. FDB entry that points to the new group
>
> Run shellcheck (preferably via ingest_mdir.py [1]) to make sure you're
> not adding new warnings / errors.

Done for v3.  The stale vxlan-fdb-port-integ.sh reference is gone;
basic_tx_common() in test_vxlan_nh.sh is extended in place instead.
The existing portless configuration is left exactly as-is, with the
new coverage added alongside it and guarded so it SKIPs on older
iproute2:

  1. a new fdb nexthop "id 2 via $remote_addr fdb port 4790" plus a
     group "id 20 group 2 fdb" that contains it;
  2. a flower filter matching udp dst_port 4790 (the vxlan device
     default in this test is 4789);
  3. an fdb entry 00:11:22:33:44:66 -> nhid 20 that points at the
     new group.

The test then sends a frame to that MAC and waits on both the
nexthop group stats and the port-4790 flower counter, so it only
passes when the per-nexthop port actually lands on the wire.

On shellcheck: I ran it on both touched scripts, comparing the base
tree against the patched tree.  test_vxlan_nh.sh adds no new
warnings.  In fib_nexthops.sh the added code only reproduces idioms
the rest of the file already uses -- check_nexthop_fdb_port_support()
mirrors the adjacent check_nexthop_res_support() helper, and the new
cases use the same run_cmd / "log_test $?" pattern -- so no new
warning categories appear (the SC2086 / SC2181 notes, and the
SC2317 "unreachable ... or ignore if invoked indirectly" notes, are
already present throughout the file).

Thanks,
Jack
