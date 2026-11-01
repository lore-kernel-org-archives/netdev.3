Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793551568;
	b=gnAsAmmTRcbA2CCgkhehxUFwHufSOLdSw+yDTgX7I3DAxxyhvMeLevDhZnLjjunxXNY1
	 x/M5sGScZXo1ZsnT6EIq6CxjtzRFvMIx+p0CnoeMJn0km9yMqGCD5nv9tUrZgn5XH+VdX
	 hI/nNXGj+ydyxUo4h6hAOSnJZsQjdmQLq8IfALu0BBT+6B05nr7beLJZ5jIaz3CB+wF00
	 vQKXu3lHpp/2L3kP/OIggKwcLwIKWyYC9QuSv95gb2vZsiK6B283iWBi4k2Pqrg30jTej
	 FOLmGh2D/otsMvqnf5PqMVeMCv0zto7DG0aBDCUcviiJLvE06ZscN4iGRZvBAV6Fp1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793551568;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=iEErhRDl3S56+aNPJWVUQgzwmxLxife0dB/9v8Rdiiw=;
	b=ws1O8IxVlzqyn2nIEbgGj9r/Ac+98BhXiZENsA/l/5LO9GwbWAgEYDFNMokNFJTpIUTH
	 8sbhWZJdVWHjva1nY/ZZwIwYDl6XZNY5F0paR/YF7XQOnBD6LVpZFTJ+biVg4r9/OAszB
	 Zpuh+zFPHO1XJpZf/I/hlKcnjbTtSDTMa+6O0TvUXsWqhQquV+zRWV5lGqjN9d/KTN3z4
	 yFi8A+WFBBJbmDTKN7zyhviHA5gn+7u2ONBv6cHDNePV+GhQZGW3REI2nihUuSOKkHwJq
	 3i6ASna2+cvCnD/XItiq/JoWpctUOmBoacM2PppuCuLTi+NA3UxIFOmVyw8RTtAtTww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=Mo1VfA1Q;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA09606A327
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 16:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFA09606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=Mo1VfA1Q
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c423b145922so293493866b.3
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 08:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1793551566; x=1794156366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iEErhRDl3S56+aNPJWVUQgzwmxLxife0dB/9v8Rdiiw=;
        b=Mo1VfA1QYS7med+7h5C2VSJWUvErjNDQBkiMVwcSRop+V16SphII3OJte2cUBPuAAr
         C8BxL3wPOI3Ky8AhF0wkCfP3ORb3XvxQaceMLD7ffw/UtUYG/wbM7k78/u5Pf4glpx81
         Fqn2aLbG0GQnnQayVcf6JUGvz7OPIfCcBPlIs2FrxS1fSHoHKiDs1OuEuv6z5coc9JB6
         DFpWyK1uLvNXJSZVI4HyUj/iAVHfJSx9LF9rX+JqQXVZDS4vg3Wal83xLp46YguuOWX7
         Pu+f3MhVPkO842hG1GXmkAQt4ghJBd26E/ujEws2yX4c54RnIKcVS1Jngr/RZvIYI8af
         LmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793551566; x=1794156366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iEErhRDl3S56+aNPJWVUQgzwmxLxife0dB/9v8Rdiiw=;
        b=xDwcdhgVIDGs7MkW+PpY2E/G7zDXw1PuNrab+5fizmyUTdAWvpTVTFDZgyGpH1/eAj
         DSMAS80xjrWAt4swroIGej16+UaS1HQ4KpbYJt7YIv5jO/0H38A+uQzlyRPfTh+RSyfM
         NSHgKJdYiRpbE7/twv7od80BVELPw26dYhInvh8Ahjo0dEUyTPGS0qeycNwY+WxTaeTq
         1rGaWLiYk5Hhu9GUg4KowTyc2gXafVe1HHyoQfWWCklcDCIP9Wy+v4zLDRanUzq6W5aq
         LXhVzoei4e7vcpLn/zAbYxYyrjFN240L4xGWs4ok9xZ456kIxImtG+97rlj5fxeMCRth
         gMMg==
X-Gm-Message-State: AFq9FYJJPas/cjNMwgB92ir7rXyqW95ovIPqiA87soI4ekvi5LkFD29h
	iedJ15iLezzXH8Ip0Xf6DOVwUW3gz6mVfc1rNZ/qruhwhJ+R6aS36WyK/xRVHR2WjNvWvpfIEo4
	8+FCnlsk2
X-Gm-Gg: AYBFou2hdOVAuHIs9PkQQLnY5vx06LucdRFCsVFFGfS9bQ8S1rFkg0OhWZJM/fxvlAz
	33CHgEyaSGTwnh+mj/BuncdgzWQ7kQdcYq2TmtFcp37KoXOuHhgexSiqhKGyWbH+lE2vXZGvawh
	nx/BNgyFyr4XFeQMjBcwb4iAXC3sgjVzGlYnb7abWMtifRnjBXvgQE575KLNa5FkMG1aAKMeYkE
	9u2SiI2WJ5urgdTHncAHyk2CgP1bg0ZxoLPOJ/ZzP7VXnzl5ZKdb3dFCZXCpe/nJvoZIAmVXAye
	RHVodgqaKgpCNm02y+8SctmTfvbtADZJuCaL+Y6ZSwvoWoZMlxvDWkiiu78FViSMD7ULe1koMe4
	myMQYnn1iP1e2o3n9+mlUHAyEti5mzkOhP5CpDU5pYRbagWGgHhNtq18orDR4idpfVlQafpHnWk
	JsADkKR28kW1mDJwFMggAJ/wCkuuoh/+FwgOkZyPckkySolR77DDER0oupWbSTZUenQQ5eDA2XP
	92HYjhCe7k8oBU2R35VVR9XO4EwcG6ltAR41gnUTtRaKXGjY0V9jeVg9Abr1kDwUogTfcB/3GTR
	1mUhzCtHKv+KX9Xh7SUspSHg5eFospO8hiwt8GFsOF5rIBhRRAPnu7a/Updooh/jFwct68RlZ0q
	gExoSbldw1OINvscmjtSFS2StxHXIfMC2oybnPvISQY0e3CFI9BJj1qy/7kJmOrTVj8V8WA8y48
	nDgJhBa994m267T/D73nWcydeU6rq2pYrxcOmp9gyeYw7a61042/vKZ/QT180azqgdg5qXfogL7
	VrOVRViYjS4AUUDzeNGOJKA+3vV+NR8scobZlTrzFilOB1tifM0bmHDlZWzP3jsLV2a6GYtYXp+
	4maWUMhl3sSdVeK1V9cNoDZrgQ3Yj0CJx5+7KdDe
X-Received: by 2002:a17:907:3e9b:b0:c2d:bd87:7fa7 with SMTP id a640c23a62f3a-c4ca7a88866mr599588666b.24.1793551566094;
        Sun, 01 Nov 2026 08:46:06 -0800 (PST)
Received: from Desktop (p54aff790.dip0.t-ipconnect.de. [84.175.247.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabcfd254sm296928266b.29.2026.11.01.08.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:46:05 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	richardbgobert@gmail.com,
	willemb@google.com,
	ecree.xilinx@gmail.com,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	martin.lau@linux.dev,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] net: keep the TCP fixed-ID flags on the header they describe
Date: Sun,  1 Nov 2026 17:46:02 +0100
Message-ID: <cover.1792857378.git.julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
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

GRO sets SKB_GSO_TCP_FIXEDID for the outer IPv4 header of a TCP packet
whose IDs do not change, and SKB_GSO_TCP_FIXEDID_INNER for the inner
header of an encapsulated one, since commit 3271f19bf7b9 ("net: gso:
restore ids of outer ip headers correctly"). Encapsulation,
decapsulation and the GRE and UDP tunnel segmentation paths do not keep
the flags on the header they describe, so a TCP stream that GRO merged
and that crosses a tunnel boundary is segmented with the fixed-ID state
of the wrong header. Sashiko found this in review of an ipmr series:
https://lore.kernel.org/netdev/cover.1792293419.git.julius@bairaktaris.de/

Patch 1 moves the flag on encapsulation and decapsulation and keeps the
encapsulation level below GRE and UDP tunnels. The three changes are one
patch because each alone loses fixed IDs in a case that works today.
Patch 2 adds a selftest.

Tested in QEMU (KASAN) with the selftest, 17 cases, 400 segments each:
- net (7076f684d513): 5 cases fail: fixed inner IDs incremented after
  IPIP over IPv4 and IPv6 (40 distinct inner IDs), outer IDs repeated
  after GRE and VXLAN over IPv4 (10 distinct outer IDs for 400
  segments), and a VXLAN stream with fixed outer IDs whose outer state
  survives decapsulation into IPIP. The same 5 failed in 3 runs of an
  earlier version of the test.
- this series: 17 of 17 pass, 3 of 3 runs.
- with only the decapsulation part, or only the encapsulation and
  segmentation parts: 8 and 5 cases fail, among them every
  encapsulation followed by decapsulation without segmentation, which
  passes on net.
- fou_gre_gro.sh and bareudp.sh pass on net and with the series;
  gre_gso.sh and udpgro_fwd.sh (3 paired runs) show the same failures
  on both, which come from the slow emulated machine.

I used Claude (Anthropic) to help write these patches.

Julius Bairaktaris (2):
  net: keep the TCP fixed-ID flags on the header they describe
  selftests: net: check TCP IP IDs across tunnels after GRO and GSO

 include/linux/skbuff.h                     |  30 ++
 include/net/ip_tunnels.h                   |   2 +
 net/core/filter.c                          |  11 +-
 net/core/lwt_bpf.c                         |   1 +
 net/ipv4/gre_offload.c                     |   1 -
 net/ipv4/ip_tunnel_core.c                  |   5 +-
 net/ipv4/udp_offload.c                     |   1 -
 net/ipv6/exthdrs.c                         |  11 +-
 tools/testing/selftests/net/.gitignore     |   1 +
 tools/testing/selftests/net/Makefile       |   2 +
 tools/testing/selftests/net/tcp_fixedid.c  | 396 +++++++++++++++++++++
 tools/testing/selftests/net/tcp_fixedid.sh | 291 +++++++++++++++
 12 files changed, 744 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/net/tcp_fixedid.c
 create mode 100755 tools/testing/selftests/net/tcp_fixedid.sh


base-commit: cb284914e749388eef402938bdb3115fe1f6d337
-- 
2.53.0

