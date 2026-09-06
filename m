Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A852B18C02E
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 16:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788713584; cv=none; b=Qn+/YEXpPJy5DU78NOY281qNsIi2/OA8MGSfc4NBOmzNlvEYjUfCRE4Zl9goiQqUekJHHwKIBbT0bAmXElVQk2nZU/ciG58dqGjm7FvUM4tndAzvcze4MfEcBh6LuNzwAbEluWHIhApI/S0YkQz60buvnyYJuv4IFxld25+X0fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788713584; c=relaxed/simple;
	bh=Y1o7prPsiOOnR9gJoZf64ajdgPOEuaeBeujpnKqGw/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AOjosQnupurk9crfS6aMRBlWZ/JB7cVDUXrjtrXMByiCtssH0YPGB1m25vT6boHxH7PfI3C95CCuwCYjUVs10Kb+3DzefNbgtpHLLKFS+bkTEjbWfwoNb/hNObKBm3gJEmfu3NtyyX+7e9YFv66ArX06DL2FqiEzl03u3bJ1PV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UliYkwH3; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UliYkwH3"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5306d609317so10193141cf.2
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 09:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788713581; x=1789318381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uaFPieMIXFxyhJRkKzrWeo7u09RZ8WDjBQwGWeTJRi8=;
        b=UliYkwH3/wGXl2cIyAaX6ObXeA5hNAnYAMJ5Uva+iFVFbmvOCE/dbP1cbQxJpZGRwB
         EuAYEcFoqHR9CVQu2pwEefBU9HQ0tXcw6q2vwdjMgs/gEXNyssfVnnOxB75ZKvn7Nfcm
         z+hYEQCpKQ6Jfb8jWGyTsYz7Gf5lkdwCg54on1t3utsMOAxj+QcmTEF53FFks4lHnd91
         VZVXoWwo/q34CL45UaovScTh+0un8GAkHoc0QVF4ltqO5Yr2aG1J9pyEzD56k7TDowMU
         PbIWT9nQc0CoIvdjnYUyDdhnattLEHSbPIVbjXYG6Opw0wjXgCUVkebHeLQedWReKo81
         27lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788713581; x=1789318381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uaFPieMIXFxyhJRkKzrWeo7u09RZ8WDjBQwGWeTJRi8=;
        b=Zv9SO573EG5E/qlFeA1DimzEk6GG+suLf/1pnLbVUBrjRoFAqjBofuaIUZAtRBgzQ/
         AAc2/BajXtlfg+xMAG6ne5MsFM9pZgjuuXiX3R0rmRAr2+0keGiInzUvlMq2LUPA3A1X
         XC9GTnRI/HyJkBFsi9OxniBOdlG99837dMxm4UTgbR0RiJIdcCBcl/TFzWk8V1h8Esl3
         piU7QHQepQIMaccLTMdkMDWN99QOgIK7+vqNnxISh28Kkrz3d20LkM7Gu2+qt5F0MXdh
         RTOVAKYxFnQZIONMuCWpq+DJIQwJnWghDYt2ZR/D009AlDrpfqzG2Kbt2mEPev//6j6e
         xYbg==
X-Gm-Message-State: AFuF++nETbNUr0XRw7uDABJ0AWhWAoeMfXVj7tTdQMOi4Vw/j3W9bmnY
	/fP5KOLzBkP/AU6GnlfcnLLOoeJHlKIsxyS8yTf6DAd/K7zEKOwBuUMJuYrK2VW0
X-Gm-Gg: AYBFou0rsChhL3ORJhfCxw+wjQyBNYQFu+w/W0DQyZJZmkOmqMlHn6D1RfwEvFgcvvE
	PWHaLzxvVe5q/HIPY6V/pr1el6pU3trbKzNbXxKl6J5SvQjmFxGEWxYtb22ojfFQYjMF1EAylB7
	LqIiwMcCU49PvnUOye2d0vsk6cI5Zsszxye+x2HBS0c1OR4h8vhwM3FCcyFRhsU+ByhuJ172TGn
	sihr+y/lNOOp8PPwsIESBEh5k+9NmOrvZPYgB67EYbJ+3zw6IcElQdEQyVEe1j/Nu1Iti7mLJPZ
	Dx8mrklHMlMTIdJ/cJml2M84LKbRbTIJCOnoUElcLgD7BL2ajhXn1u8S+sj7cMBvipNS9PpRFq1
	dMGaKWMabRh2smVu8UtILUAgh/GpuMQ0crOa0fxFtQY1gheHtG12VuBFQCAgAilp2F0jjycY5A2
	ghdUfooEjYFTD1KQ/cjnTi8nmiAMVGwykhhR/+wgx8jFNLu2OVl+I85l7h7HZcSR4=
X-Received: by 2002:ac8:5c85:0:b0:52f:eaa8:c584 with SMTP id d75a77b69052e-530547fe64cmr203211761cf.8.1788713581390;
        Sun, 06 Sep 2026 09:53:01 -0700 (PDT)
Received: from houminxi ([163.123.141.225])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040595f81sm72195696d6.2.2026.09.06.09.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 09:53:00 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	dev@openvswitch.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH v3 0/2] selftests: openvswitch: add SCTP flow key and NAT tests
Date: Sun,  6 Sep 2026 12:52:49 -0400
Message-ID: <20260906165251.1176875-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two new OVS selftests for SCTP:

- patch 1 adds an SCTP flow-key test over IPv6: a client/server
  association is driven through three pipeline phases and the payload
  is checked on the receiver, so a broken SCTP key extract breaks the
  match and the delivery both.
- patch 2 adds SCTP conntrack NAT coverage with port translation:
  DNAT rewrites the destination to 172.31.110.20:5555, the reply comes
  back through the CT inverse tuple, and both post-recirc directions
  are matched on the translated ports. This exercises the SCTP branch
  of ovs_nat_update_key(), which a plain address-only NAT rule never
  reaches.

Both tests probe for the kernel features they need and skip with
$ksft_skip when conntrack/NAT support is missing.

Changes in v3 (review findings from the Sashiko pass on v2):
- restore the tab alignment of the new usage() entries
- wait for the receiver payload with ovs_wait in both tests; a bare
  grep can race the background socat writing the file
- add CONFIG_NF_CT_PROTO_SCTP to the selftest config fragment; without
  it the conntrack table never sees the SCTP association
- probe with ct(commit,nat) so a kernel without NAT support skips the
  test instead of failing when the real flows are added
- translate the destination port in the NAT test (4443 to 5555) so the
  SCTP port-rewrite path in ovs_nat_update_key() is actually covered
- correct the commit logs: drop the INIT/DATA chunk claim (the flow
  key only carries the ports), drop the parse_ipv6hdr coverage claim,
  and point patch 2 at ovs_nat_update_key() instead of
  ovs_flow_key_update_l3l4() which only runs on the defrag path


Minxi Hou (2):
  selftests/net/openvswitch: add SCTP flow key test over IPv6
  selftests/net/openvswitch: add SCTP NAT test with port translation

 .../testing/selftests/net/openvswitch/config  |   1 +
 .../selftests/net/openvswitch/openvswitch.sh  | 182 ++++++++++++++++++
 2 files changed, 183 insertions(+)


base-commit: d0ec95a8a4e79f2fd6063fc8932415db8c227689
-- 
2.55.0

