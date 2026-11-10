Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331768;
	b=vF43WguE9yP92z63RvER1OpG8IYguN5R8zzBOzBCWmz42Z02ISbxP8DkpuWtV4tgNOPh
	 FYKy1Qpo5WDXGNsiwd5t9qeejAtHTx/4a3dOa6YHA6LJWpgxOgTX2NgHYBykMHFm09ach
	 PbEtu2HBlxZTmZTchctlHQ/3XIn6tSG0T2x/NQzkj7NUk4j+bhD8aNgsIYZvkU1mrROzZ
	 wBz0uG4wbwxb4hBb7IxrF7YcUxAXU/eEs4SGDKkP7qZdwWzk3uqmqccq4MG6Nas1zjT4u
	 wr66zM8oh1eQa2rFLVyB+jtT9PwEMQCwEBximc4zP2psypTI1iJYYofJntrirKxbrGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=PnoGUBmcCKYpJpTuM/bZynOVu3n/2EAja2xWlLiG5M8=;
	b=cUpf4b8zMKEs8XEv7bikvoZVRyEJU49iPI6R6pWMO3JY0ujrTo8VSdslWR433Lsvdsm0
	 ZYTM7U0SEUkdvbtA3eCHtgSjK92FuD5IC0WJwzVRVCF/RQmQi63E6OJwNNFghe7bdGWAX
	 RVihdU2Vfxr+K5hfEh3Fr7xbMhShQSdrNDQJJb7pAHbQDetcmlxfGTOdLEbuzy+kZHKVi
	 0hyvM012/iTQQOCvCwcAlna6OUpCbjBRk8B1tGLuBWSvmLdrYCAe2OT8pNd3Hc6k1YsRe
	 wdqBDR7CDI3b6jxW0ZlhsscsTT4w+MAeVIGztUvQliX/RKBxO0QFToiTJuCtiborfbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Q2dQG5AO;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6F8606A323
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB6F8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Q2dQG5AO
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a06e79e152so1277014b3a.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794331767; x=1794936567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PnoGUBmcCKYpJpTuM/bZynOVu3n/2EAja2xWlLiG5M8=;
        b=Q2dQG5AOTVHgcOUbsMR3RGaD+Txvpe51iB/VR1cTbbceBpqdML+T/dAQCIfcnMHp5t
         Sc8cl+WwPNTi65okVmFYw9B6RlY+Dk/rKMEOBFf9E+U7Nn+n2kPITQS3/JJyScYKV816
         tSPQbEBfKqrE40eD7VEUUoNFbNXs5bPem8odsBUSsDf2iPwyDaETFCDQp4jMYODQKBvp
         zUakFSZoeYYVotY0Y8Mx0c7WohKZNPGWFz9BPV8kNZu8f2FP4K/N6F7UkoOOdvEM78mV
         GRKC5YtrJAYsYt0yZjIEMoUQgji1tcsFVRnTNzevWEURk6Mq3xCbzhDdjToMMwpqU/L4
         JyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794331767; x=1794936567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PnoGUBmcCKYpJpTuM/bZynOVu3n/2EAja2xWlLiG5M8=;
        b=DQkevlNx+3WtPYaIzXL3yaFSKQLu7Yy3lvMMlcaLaO62IQqVUWrRq1G3NSRHuzGkxo
         nW8/lTK0FZWBg3Tt3rhhNZxCED6YAdjkttK80MQFEPd4nH098eCSQuIqXw0yXENHojPo
         n0MhclucX/OYVscF/fPGSDW00J/M6uzVBMZgunLjI/32/7BMnM8iplroUQqaIHItT2BH
         wQ+9pLPcIM2fnd8aiux2pVV1gUJIMFCsXNMe+gy5uyqEGk+vnMDxsLEk/K1LrQtnKI8l
         V5CGOQu54JoJve6pkeT+eS01a/FQe8djFqrBQz7H3k3pmR+TilnYdYR9ndCZd/TkLPzY
         Dw+A==
X-Gm-Message-State: APuU4Z8sytvr3Y6A4C5Ad/n5TqJLXwb3vIiSosEXqrUZKomaxbloBDEz
	ym9WbKuN8aJcBQuv0wx01YFOFP3JEOHgbWkm/tNzzsQbmEMisjduOZnv9Jd6TGtt6e+nxb1S72x
	Ct8bWA2M=
X-Gm-Gg: AYBFou220AxXx28EdXeBszvjVfXGr2NcTsEkWuyhNVMX0HngFpxEpaxz88/VTFf4i0R
	5+QtTIVY4PGFsRvUVRK61C6wBehmIGJMK4O4nHafusPP0iKG0zGInLQwyXleU629Qv9FVXqg8OZ
	E1phjFzuBTNfoS+ignDG1gWogu1KNXcnOfgmsg+qZphTC7rexcgi8VNkBioFPLO7Y6dNbAIglwC
	+NiajLjUIDWKH1EZ0r/3GdBaZ7CC9E7YGdD393lzwicT44oVaCP5T6cFFFZQNRJyLHb8wMo5Jei
	L0BFKjt22BHKD5LuMmhbLSgh0/c34RYtXpzwcCxgO4DMtPDN6f+aQIVj/sn8ie9bbivThtPMooY
	IWLthDfGvz3XjZ6jZcLTVT/eXEX4os0yNOOyDJRpR8atv2MmtG1e+OV9ZYW4HAdPZum2GQJ6xVa
	uvQXZVIrYlpn/lAokZfpG4RoCA74f4uq4wSu9fj3K7ZrjjmzIcD/5sDw9dFH6e3Bzqm/mbg6J2/
	LL5LyE5r66Kea1Way5WVMCbGBakcI2Bw2TE1f6ceXPwjwjTtGZWx+fk2IH9nXth4Cjmmc39agKz
	J1nYzucUFgHMjzBfAKlFi3KHbGnx7xbsIP7ng8kgJoFOQDf5i2pc/9RkFhDIiJbmABrOzwqWku/
	eCJtSVaFtThns7g==
X-Received: by 2002:a05:6a00:1d15:b0:8b1:e8cd:49cf with SMTP id d2e1a72fcca58-8ba88c8faeamr3069042b3a.22.1794331767075;
        Tue, 10 Nov 2026 09:29:27 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab5f1effsm1197939b3a.49.2026.11.10.09.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 09:29:26 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net v2 0/3] rtnetlink: fix truncation of dump entry
Date: Tue, 10 Nov 2026 09:26:15 -0800
Message-ID: <20261110172925.3293312-1-stephen@networkplumber.org>
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

While analyzing one of the OSS Scanner dump reports for iproute2,
a bug was uncovered in netlink route dump.
A route dump whose first entry is too large for the dump skb ends with
NLMSG_DONE and status 0. The route and everything after it is silently
dropped; "ip route show table 100" prints nothing and exits 0.

It takes some non real world stuff to do this 
like a 500 way multipath route is enough to trigger this.

The series is broken into three parts:
  1. Fix regression in rtnl_dumpit().
     Do not hide EMSGSIZE on empty skb case.
  2. Fix IPv6 FIB dump to propagate error properly
  3. Add a test for this bug.

v2 - drop Assisted-by
   - correct commit message about "ip route get"

Stephen Hemminger (3):
  rtnetlink: return EMSGSIZE when first dump entry does not fit
  ipv6: return EMSGSIZE when first route in dump does not fit
  selftests: net: netlink-dumps: test dump of route larger than skb

 net/core/rtnetlink.c                        |   5 +-
 net/ipv6/ip6_fib.c                          |   6 +
 tools/testing/selftests/net/config          |   3 +
 tools/testing/selftests/net/netlink-dumps.c | 271 +++++++++++++++++++-
 4 files changed, 280 insertions(+), 5 deletions(-)

-- 
2.53.0

