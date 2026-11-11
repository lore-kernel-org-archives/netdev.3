Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370752;
	b=GKbmNhHMgIjH6fuN+04cAg76B18E3SqG80W/GhKu2ANqeIVHnMwedjQzRrV0/Rb9+p10
	 MtEpQVqwgfKo+8lf80C8dRlcm3p2dnRZ3djpaKTkFPjlgydwOzi6ley30fREzLF387UQ2
	 BHhChnWVN1BoP698zEZkak7axad3y5uvZ1JFdvlTtuFTH/tyGQBvbj9S88HR433OZMatY
	 cs+sxT4p6ZeM5lqTu4CM0zQL0jVAiCdPChcGkZkcR8hekRMHCL3YOjNOQveKucxObHw0+
	 fmUxQv/r2guveANq3t2XaDRtR+/puz1eR2pV0eJ/1WKjRgz8kQ+p3jtooMPv/e0UrIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=vu++8Ba/Bm4EE7sdE3e4HVCSisYhXOFP70NUkQ2QJtY=;
	b=4pucOQXJ36ijlunlkXd7OYMS99tmS7IrOPb6kYayo62xWhMM6Mv2GrKsXIbvAJkBTWW/
	 eIokTNgdaGFj3H7sg+OlxyUTetG4U93NB2pbePq0dwd+B8bTO5/B8e/gQmDQj+FhZ2EVO
	 zsMiAhsbn75fj0kPw5fuSevCcCCYjAaqWiBGDKHiJrrZ8VJLcQrwCIT+B4gaVXQUZOEKC
	 CZXTknqpMcYwjPprrZHylM1cGun5siWG/jQeT3Lp7RHRduq+2L2liOKIF0UjUU4R5itgz
	 Pko0qp9yd6mY7eflRHQz7PXFal6agTkMzUTlIK+WP5Gm5fAkPU0NuHRQOei+AkpDlDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=btOAr4KX;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8A0606A321
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 04:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B8A0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=btOAr4KX
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36dbde64409so5776564eec.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 20:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794370751; x=1794975551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vu++8Ba/Bm4EE7sdE3e4HVCSisYhXOFP70NUkQ2QJtY=;
        b=btOAr4KXKOXZYd6QGYDneGd727rwdK3NisYiebGEWByer2tQ7AqTluKE+W1Q+0bZ43
         og52mf+TCcVjX7LTOzJDiXB3C62cdthQEUjUnucOLOfz0o+wLrt+wcxRFjPzkjT89fD/
         WhuEb0DqxKH0IKhe0Fq5b8MFiJsKe1UfWfJJJhuMdFAbAgnPkRGLyTadSc3AosrmW5W/
         704YQv9/F5ogaXmMWjYgIVdyxhIO+TsGXqp+aBbZfu4ZK1KdOuAjVQPXBvy73R0PGFCg
         DeTNbbpBGInZHIB9lUJa4yX2pb9vh0Q5FipvPAaWd7JQJjwDGTP0heYOvcSPPRQ6LGzE
         Y3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794370751; x=1794975551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vu++8Ba/Bm4EE7sdE3e4HVCSisYhXOFP70NUkQ2QJtY=;
        b=0yYverQdSi5+O0aSMavaljhunIla/uSPlMobzSIXVgQo9xpgVrIA2kILSF1WZBxNgX
         is+vcNlRSiT5snoc8C9mFOatirIwXqbFV8YwJmmwsCZnGgaCGc4KMj52EueIhKA+CoBj
         1nPXkHyDEiaEOuz4DPRunOR8gqbCv08btCY4CuF9E5oCZ0H/vtbofCbuX0SzXv4swNG9
         ubl8dmgy79O7fSUtQ//m73P/RxpUEg5LKZk847aWmDUpWWCp17+Lx6FzlXR1baSV9Xq+
         4OIbLAHddHKAiQH2GpEFWUlEwaO6uu7EtEBnoiAaBtqx68GPnjoNaoeCO9BAry+dPETe
         3L5Q==
X-Gm-Message-State: APuU4Z9ZISgy2kNAHRUh9p+/Turjlsykb9bKP6mB1Vkx3VoHontwXTfs
	4rcYEHIapOuLCbqGnijI75DT/WtA2o/hGwucaR/H9IFlCwSH7DPkl2ZgVF//rU4c
X-Gm-Gg: AYBFou2Urj8aMvs0dL3EYjcVo0aDr/t+R3FbA48mKfJzsaI4uYVWusFhgCX+P2WycDQ
	cwjnW3Ml1ujCa5whM18t7hYXFI35Et1oZZD3IrRxhcn2OGLkw4pMDAsBDGVXQCccaij9EJVPzxx
	HGLhDcSCKV4NyVEUNmrm32yf1J+eXsaRCZNMyPbrELhVKDO2Oqjsr2qX6Fozd/sUzObGQN8ZiEZ
	ns3eMJg7ULPCu1PnDn7LYdsCtYK+baoEAXzRvpV2fNZuQBCK1Lm2cWbeHRpO0qp7O7ATN51g2Bv
	p3vi8422qjDE5WQZrYwCi/VXTJovR5NhoWdaLD9g86IXX7Qb+8si504RU2/cinTNyhvpXQwr5OY
	L0J1TamqPb11IwCgXalpvYrkCa0E89u6j7bojlq6UY6WkOm6iMVEFXJcJuvmIEdvmGF5bC4e8u5
	P91aL86Lz4N3Kw+evOf5748VObG2IFgOIXl0axI70tqVlOqhJH79bGB7/HO+z59uHUFKIClZCva
	leHBGP8YQ9B2Scy8o/i6wH+dDiGgDQwQJd1gPp7GcaaetNVdKEKPnBGceYlQco4KH58p4v2g4GK
	RCnygM9ACUbK8nqsglZ/hT+BHS50dZrR1aT/aTgXJjjuyPB+Gw+1s6vV6BY+LalEv/xUg55SaJD
	Jt1n/Uz+RKLMgHVvXOLd+E43ZRxI3q3i0w/6qaiJ2U8sHIaFW8hUczJ1tl1iSo5209PJnu9Qy8t
	DpYQ+bFXjUA36oemZhng==
X-Received: by 2002:a05:7300:6dac:b0:369:f9da:a70f with SMTP id 5a478bee46e88-37685b7f916mr2766572eec.17.1794370750970;
        Tue, 10 Nov 2026 20:19:10 -0800 (PST)
Received: from Mac.localdomain (198-27-228-154.fiber.dynamic.sonic.net. [198.27.228.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060c4b6sm11820704eec.15.2026.11.10.20.19.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 20:19:10 -0800 (PST)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org
Subject: [PATCH net-next 0/3] ptp: ocp: support the WiWi production Time Card
Date: Tue, 10 Nov 2026 20:19:00 -0800
Message-ID: <20261111041904.48916-1-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.54.0
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

The WiWi 2163:1008 card has a Celestica-compatible register map behind
a LitePCIe bridge, but subword MMIO can cause a machine check. Teach
XIIC to use aligned word accesses on request, test both access modes,
and bind ptp_ocp only to the verified 0x800f production layout.
Other boards retain their existing access modes. WiWi devlink flash
updates are deliberately unsupported.

Patch 3 consumes the platform-data field from patch 1. Can the I2C
maintainers Ack patches 1 and 2 for the series to go through net-next?

On the hardware-tested base (4dd16e31135e), the driver bound with
64 MSI-X vectors and registered the PHC, PPS and three UARTs. The PHC
advanced 3.000429460 s over three one-second reads, within the host
monotonic brackets. SPI NOR and two at24 devices bound. The card was
UNSYNCED at probe; no PPS lock or UTC accuracy is claimed. Rebasing
onto the base below did not change the driver sources or patch IDs.
The rebased series passed x86-64 module/built-in and i386 module
object builds and four XIIC KUnit cases in x86-64 QEMU.
Full W=1 allmodconfig and allyesconfig builds encountered the same GCC
format-truncation error in lockdep_proc.c on this series and the clean
base. Neither full configuration is reported as passing.

Codex assisted with the driver changes, tests and changelogs from
the supplied board layout and crash evidence. The net-next series
does not include a firmware update or front-panel LED policy.

Ahmad Byagowi (3):
  i2c: xiic: allow platforms to require 32-bit register accesses
  i2c: xiic: add KUnit coverage for register access modes
  ptp: ocp: add WiWi Time Card production image support

 Documentation/networking/devlink/ptp_ocp.rst |  35 +++-
 MAINTAINERS                                  |   1 +
 drivers/i2c/busses/Kconfig                   |  14 ++
 drivers/i2c/busses/i2c-xiic.c                |  60 ++++--
 drivers/i2c/busses/tests/i2c_xiic_kunit.c    |  88 +++++++++
 drivers/ptp/ptp_ocp.c                        | 198 ++++++++++++++++++-
 include/linux/platform_data/i2c-xiic.h       |   3 +
 7 files changed, 374 insertions(+), 25 deletions(-)
 create mode 100644 drivers/i2c/busses/tests/i2c_xiic_kunit.c


base-commit: 97ced2c090bfc2156db31fca9f52cf253e4bc186
