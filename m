Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792697379;
	b=U/DgFu8F9IBONWE+ZTFOa52GJQb0BA9TbGJ4UDwktDwp4Z8tv/4W64YJ5Wv303eQBbGc
	 4nGHBymlJvq1J+r9H21Yd4RbsBwtrHoqDdd4AEB5cSZdWGzcnkM9WGWbpCyP+OafH7qnk
	 OGStzp2+i60Hj10Lp7dzGrIE3NgX8gOET3TSZYbK8nPcycSWuvbzwPOl3/fbJvEBt9j/5
	 0aILGhv0DjSlterf3ZUeTg2HIQG5ux6fwF7luWXwB7865uEsPC7fNDido3X3+63DCH5pK
	 d1sZRyXugu70aWyOsyjK2LJ4k85k0BdzM3c0Q73tKx9CnhS03N4YuhJ38xyLfXHDVww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792697379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yfAXIbK1SRMC+v3xqeFE7VFUZairZQeazNmZce7ufqI=;
	b=1aphJAHWze5klbusseNESbL2H8p9732EcUjrvKrZ8iISjnb6vZATWtm4mkVIfsnZDKXN
	 2TMz204bPeNAHTkcW5MWf7vKCth8MXGMwES5ljVBsxnRAjMyfkhEmMFlQrtPUt/Z2+gGj
	 r5BEQ14E+AXYc6ygA4i98WrSInvzpoID0h0zKfSuLNk/l5+ZeSY0KYarohv7sIDFurHPH
	 OXip0ihe16c5sDKqWipH1hJcPCkzfRQsmZmDlwY+e4+CEfGCFAHf9t73wYJe/4XybnVoT
	 +L8nu6Aq7mo2+yQB0hEDJQaKglkGmjt91otM88leeYG12en7aYjYfmV9IGU+1s7O7bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mji6fkiW;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FA9606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 19:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95FA9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mji6fkiW
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1e266fca2so1323275e9.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 12:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792697378; x=1793302178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yfAXIbK1SRMC+v3xqeFE7VFUZairZQeazNmZce7ufqI=;
        b=mji6fkiWi6spHYMCKVYYh9/NxH1B6eU8dSVU+ponAaoRa6h8WzrsB7qEiPB7ZEMpNx
         +cKt+gEvLhw6n2Vh4s6V881kn7lSSuLs2X4b3XUNqEZOzXBnvnNNOCBYx3THpFr5Wuy/
         usEOvXL0BjeES0qPd2f9ntOaykYyps/jemexfkU7ugQ/9Q7Rp8+joJzkRpug4P2RUzBd
         mOuVqcz6H+jhgNwBQjphlKgHbUyUvLXPW46oi3vEBHSOE/tBCXT7llYLoZSHEFyulIuk
         ILmGaQJwdUjVVqBI7rtyVAYeClmssy6fxNyp6AzCJ5NdhV4btshbLqeHLfIFljY4Ld4K
         UtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792697378; x=1793302178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yfAXIbK1SRMC+v3xqeFE7VFUZairZQeazNmZce7ufqI=;
        b=YsngQ9lRPBvCCEvjeDdMAh5sEvJ0J+ihD3rN5l/tQAfibekwA5/P+rM6rCmINUMpk4
         J02cvYf5TQFvFFJ/uMUgtYVXmHlNHF3yNYmLoth5PbF71AIyTRTO5vgjfH0Ij8diw8aO
         ovayKJspt5ppyHhePttL6uqfareHjXzORIVhpnCYnTSJfaUxPZ3AQS5Kfa100UiWwtoC
         a3gUee4wsmkyuAFJBk7xlIXonh4yKBxKmcWW28CsnhTPjNn2QylsKg/sarIKcqI8P4mT
         EFPlWeMcM6pwHiYLSwBx2WlYDQ592viBOnvkWzMvpyhCX5GOuDq/zJHnlianbgbubE36
         bhdw==
X-Forwarded-Encrypted: i=1; AKwUvBw5IRzgQpE4A3Y6JpfZKADdB4e5z/AX8ttQ/LarUgMKEuXAAQfuFv3q2j9AnlDPWT2iLYan1uI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZRfhwLJYcwRMFWKPFuWtXsJs/DEXLSDJwR+bAfgVkIFBoBKeI
	5kRMhHBg4PNgPmxmz/4qLKwGNpJeKF/QpzJyd8x6GdnVOw7Jy/DCHzVF
X-Gm-Gg: AYBFou3Czkhjsq9b0sAUTJ0FA8L3LNlXxNOJz4nigWRnjs7JKEMQthxdQEAH+kj61vG
	dlnmmhV67Z97Z7diTPZUhn4IsIe2ynDVS6D5W95wONuXgjSfUX1tiTxe9FKt+SnKB1Qbb7mZrgs
	73bMtbf5TTzWBc/eVWh7XhbFYkjjAITFRdByCQfxpj6+mClK42ktRBgEdXeB9RGNS9V6lrn+SWi
	iCqlxP72FRoztRdsgO1XOR9ywDIFchnC4JVEKdZ5U23wz/7euzLKk68eSsY9r16ivWe9XuJCkm6
	dRJIKdcs4/+of2YfQ5oZKgvFdrPqfXRbtRP+Vo8xJdrIyUiXXC5ZbVsgopGrsoo/vNttBVghdS5
	DTb7M6aIx7ZF5vfiF0iLyQ0uooncFmkoQup8CjRhJpuiQbU5rZmhWjNXQE7pH3MbGp5cdxKUR8s
	bLeeR2ASWAdiFE14QwhTYtYAwEqVhOQEMwwOvQTZb+XNk5sf3s8DIM4hIka2GYmeT4q+cNpwhjK
	QxXb6ruZUDKBN4qW8A+TaSBIWttes07+YpHqrX95xnlFnjCvUXyLtBEC51vkFwWHvY8ftGWjTKp
	pw==
X-Received: by 2002:a05:600c:a00c:b0:4a1:e6c8:ff74 with SMTP id 5b1f17b1804b1-4a211f11bf8mr744065e9.29.1792697377635;
        Thu, 22 Oct 2026 12:29:37 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan ([2a00:f44:c12:cf67:2010:42d8:74da:e279])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2101cedcesm20269405e9.0.2026.10.22.12.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 12:29:35 -0700 (PDT)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/3] net: dsa: qca8k: fix concurrent register and MIB autocast access
Date: Thu, 22 Oct 2026 21:29:30 +0200
Message-ID: <20261022192933.384898-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The netdev AI review of my net-next MIB statistics series [1] found
three bugs that are already in released kernels. They do not depend on
that series, so here they are for net:

1. Since the conversion to the regmap read/write API, the regmap uses
   a shared work_buf but is created with .disable_locking. phylink's
   resolve work and the LED callbacks access registers outside rtnl,
   so concurrent users can swap or corrupt register and value.

2. An ethtool MIB request over Ethernet (autocast) that times out
   leaves the caller's buffer published. Late frames then write into
   the buffer after ethtool has freed it, and extra frames underflow
   the frame counter.

3. The autocast handler reads up to 164 bytes of counters without
   checking the frame length.

The MIB statistics series will be rebased on these once net-next
reopens.

Testing: on a GL-B3000 (IPQ5018 + QCA8337, CPU on port 0) with the qca
tagger, backported to OpenWrt's 6.18 kernel with PROVE_LOCKING. That
tree also carries the MIB statistics series, so a work polls the MIB
every 3 s next to ethtool -S. In four minutes under about 50 Mbit/s
of routed traffic, 938 MIB frames arrived after their request had
already returned, and all were dropped. Frames made artificially short
were left uncounted, and the requests fell back to register reads. The
ethtool and netdev counters stayed monotonic, and there were no lockdep,
refcount or other warnings.

[1] https://lore.kernel.org/netdev/20261019191137.307514-1-kuncy7@gmail.com/

Stanislaw Pal (3):
  net: dsa: qca8k: let regmap serialize register access
  net: dsa: qca8k: drop MIB autocast frames once the request is over
  net: dsa: qca8k: check the length of MIB autocast frames

 drivers/net/dsa/qca/qca8k-8xxx.c | 34 ++++++++++++++++++++++++++++++--
 drivers/net/dsa/qca/qca8k.h      |  3 ++-
 2 files changed, 34 insertions(+), 3 deletions(-)

-- 
2.43.0

