Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187279;
	b=5dB2fmSaf2Z2y3Ye1sYdTD+4MZ0oQXcxUneRGiUEiyeiTQX9Dddi49Kk2GM31v1L44hB
	 /s4mkx1jSe8OeGc2xbJQmP04sBI3Fmv0u/lQTt5DLP0dCgNDSkS/C1nGLZpaI6QZR9BNR
	 BCzN4J9zG7NWzhdxKCuGoKrvIdOt4RZk6g4P8FlT/+ugHmU9HS4uOju85eJxAWil7dudV
	 1+vwfpAoCP2rz7ZlvL5kIhs8f/qw5Dfsv17pNJ8oLFd8IZmsmFTOmXJAw4WcOdGNKUFXh
	 cjCGIwAm9O7KNt3XFDEuSzZdK5IjqiQTS+pIUDFMs1f08Qpt5nsZzrfzeMNvW0owjkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=OnvL6swozBye3+FRAzmFOre8tzXZtSOJNRYklMCDrUI=;
	b=46zONfy8WcfdxveI+aNjWz5lPFXWjXSWntdEbq12FapM0dpkdxP4O70c5owKOwZMrZQh
	 vvGSCDSEcTsGR+h9yKT4MiL422jBPCESH6Qnz4nGcZutLyb622nxlx9om2JVfAy1rXI4N
	 Vc/wPrO1D/UgDonOZVrmum6PVvUZpulh1/Bh8l4VoWVlFXDQfFVMWGY1tAgt0BagmzGF5
	 vwHooBBv39sq8j9W43US2OqKgvP8x+gd6uW4/4AsDYo6nB9yNZFKhPol1AIzXbfSJ0OM5
	 t/UxcXL69xXsXU4yCwZN/sZ0mmnK9MspKyhb7zHDsyre9Wkgrj8rkheHHqMIRvRnL2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OK5DT5Bl;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6C4606A333
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 01:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E6C4606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OK5DT5Bl
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b0b3438540so195864a91.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 17:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794187278; x=1794792078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OnvL6swozBye3+FRAzmFOre8tzXZtSOJNRYklMCDrUI=;
        b=OK5DT5BlKd8SFMyNgpB3wp9mfKh6L2M0WkMNscOW5AGl0lgthSO/SbAtBNP5Le1ZmL
         FyIVdOC2HKAXVsd9dHPv6KpwnmQJhGlmJ4+qZ8ubb5B9csxCFAznxJ+yoadR0XER/a4O
         O+MqlI1vmHv54JwvHIICmIyUDZR3e1BUkV+MSnlWSzEfRc2z0i1viS+hxvOA8Sv6hWh1
         JFCJzATD9I5MSyizc/uPPC3wgz3icgqU+poWJQW5sutCnKYkok8QxHEG8LpZXbF/cbvz
         AIVJ1HFO6Fw8e8FZtG0Jx92vh5EzBV24VFK1eZ2SENrMohmAUEuEFLNqDke4FWUZuI55
         nZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794187278; x=1794792078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OnvL6swozBye3+FRAzmFOre8tzXZtSOJNRYklMCDrUI=;
        b=xsqs2u3kPxc+yLFZvVeK3+rpexvgA454UYad9N75AYYKwUa3bBNFuoxCgkp6fVEbfJ
         cHNsI9pOjG7EdbkkIJmZ5so0/uxvgb0IqUTSzctAL2egE0iNY70G1uG++WQFd/yUF0Aq
         ewYK9ocpmngwVBsbkUvc0G71DIv8NYIX1OnubHyyOfrx5+ou1FynVydelV7JDLfklQNy
         7t5VwFf64JUvH/U1tp12b44UIMJ19M0loesxy71UT92UT/qJz9LO8ubIXV1m3wQ/h95v
         /I4gOct40jxUq2x9OcV4WGupV1cWuBIaK+D7ZohYjLzboCxBK3Wwi8wmS0tEPC/MxfiS
         myGA==
X-Gm-Message-State: APuU4Z+VZU16lwmfD4/h499+xHrHTYvYkBIoFPKK2q6tQushVOueciQF
	3e2kR2Yna5fSj1lTlaa9d/T2ilrhSXJDU8zoV9J7dmfJxZHTy0+WA5gpbIo8CgSanvsoUMT/i1H
	E6RElnDc=
X-Gm-Gg: AYBFou3++l2Lpw3iTOdVUIIzJsnMViutWnwSVDY002kCOQsJ40QiG0tHAU1jr1nM3De
	/gkWXanuZpCQGISojaHjzayGFzBgDwhKW+bmec6XYAkL4aoTcBWr15jay8FqwtaEYxczgJlNR+v
	mQWnq/juibwtXFU1Ej1NPyy3zZktGGvza+iIrdTQZ1wkD//8lXD/mGF1BB86p630kNa5vVwSm7J
	5XHVhU6Owu8Kh7V+GNeeGO2cFps9mH3+cI4QE1HOZiGifDQ26yutOywF8xIHnbgbZvI3cBiq235
	xv/rzvmh2U4DRs+bk0WO6WzuNCb0s7gfX7ug0OmVpj5EbZ2VFQgzYvSWlPF0dbwbvbxDOaLTI0/
	9IYl+Id0S6m9u9vLrn8eL50xbel6Xzo4I3nhyk4wo/nVeP2tUMerCIYyIz1XyrtZ+Aif2/tnVpP
	h28O4O0PGU2TGN+Wwzb3xh45KmhUIS+vhmTrookUYPE2lLHwLhR7FB250tH1MkRH8pVnsSHXdK7
	zb84AQC4pPUzJdSUcSVVSn2blLd6Ln6tsc/92ZflfANJEWrq7PmyyLvTDTFSyRP1hVfHfigEPLL
	S4goWrKd21FQ7r8OtFZYIezVR2/EhA3CW+UjM6EcsLTFj+94Pp1mrd+A1mW5FVhMaHpjis4=
X-Received: by 2002:a17:90b:2252:b0:3ad:b8c8:4a84 with SMTP id 98e67ed59e1d1-3b12d4b3e2cmr2546614a91.26.1794187277522;
        Sun, 08 Nov 2026 17:21:17 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b103432e26sm4883217a91.3.2026.11.08.17.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 17:21:17 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net 0/3] rtnetlink: fix silent truncation when first dump entry does not fit
Date: Sun,  8 Nov 2026 17:13:11 -0800
Message-ID: <20261109012115.11898-1-stephen@networkplumber.org>
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
dropped; "ip route show table 100" prints nothing and exits 0 even
though "ip route get" still finds the route. A 500 way multipath route
is enough to trigger this.

The series is broken into three parts:
  1. Fix regression in rtnl_dumpit().
     Do not hide EMSGSIZE on empty skb case.
  2. Fix IPv6 FIB dump to propagate error properly
  3. Add a test for this bug.

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

