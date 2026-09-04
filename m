Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501AE5013D5
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788539468; cv=none; b=jtVcNP0N924IzugKFFFVi7TFEbRLNJYzZLn4QcJEraTCoJLeT5zikxH5UXjthA7SVksop1PLhd/mPKsafvSZZSG0ja0clrTCRV8DUX/CDi0QsbULtfWQU4rIBLNzo8fWBwUY+9hLc1uQwLzrWhgRcZ9TFdmD4RnC0MtGRW+9VEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788539468; c=relaxed/simple;
	bh=BRtus3WijRKxop17C3IlkNpfnbhJFmybZrEroOANEU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eStYxt3uAnR4jjtoWxQKtWNC+jDczKsU+BwRGAjFdExtA/fQjndkK1VmtisNm+OV+2GShWqXKNGddhXGCuEyuA46tTOQAXg4f6YkRZGs8ySTQEFPmzumdA17kV4Vo8cr5X7V+AY3cqr3ScXvlw3YRLF373b0jlp5Lyp0NeGGqfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkMyqC9s; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkMyqC9s"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e58034d05so1039067a91.2
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 09:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788539466; x=1789144266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bn24/hQ8WxHkOsr+OJr9JovsNTvE+u6NKHbDOA+BSjg=;
        b=GkMyqC9srbI1v0hDJgBDiTNGgg7bGFyE5AWVwRNWAxLu9exT4alynzHk8O8YAnZlFV
         IIMOFYadMsPVUiTTjUsjpWjyjG8QS/SgIqpVJVOQJ1lryACKAG1BFb+xEcx4MNJ3aUE6
         w19JAwKX7b14jv5Dz9fuosuk9aU6vPjG0r3ANDd8BS6nXFlgmF/QKOOhL/gCOGIaWh46
         NYV71WtmqtXXSGAb2LIFLqtRBoIY40L0OSjNUv2qMl0IjYxdEYqtexzeRWZhhiR+ytzk
         QWuNcnNvNyepgZaQYOrH3ZQM7WaEO5OKZfOD1S66hB7iyXo1AaC2lT8Uz7wMETMzGNYb
         R3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788539466; x=1789144266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bn24/hQ8WxHkOsr+OJr9JovsNTvE+u6NKHbDOA+BSjg=;
        b=NwtYsigfEMDpn1jK/DxLcQtVnXoIpXSTXKXdwx1nLcfO2FiqiPh/1UbXGA77MiMoUN
         C/MEG34/k0613SgLF+N+01zlOivZ+dlkVxFSkWmZoB3E6H8VjL7NXX0hZ8hSyrIGFIGa
         xz5M6lKoBBpP/CXwGE1xuxyPXV1XYtKYNlEuaLNMR2jFLicBWQrgZphMwIu7u0SyHC3N
         qY1mJkYNg69wYH9Whu045IjzZrwTsig6if7ylKF2GDbmPrwBHEC+AZ23OnrFzuGwbrrC
         V2thbVRlfooMuJ3FwlUsq20Kv2YnC6daDraassoavv3C0V24bKi/el8TOF5ewAlvzAPd
         wHtg==
X-Gm-Message-State: AFuF++lcSr2+She+NDN5vzW2IaB4zaVyF7K9P64kX8HccwumtKhn4sB5
	RDV8OwAN3vQC6gOeQukFzLp+1T2GQ9wH6aUOH7B0ckPpwlPVQFK0i9TWxlbJjQGD
X-Gm-Gg: AYBFou3KOtpw+bdmy2YWzbY3Q0TKCxeM90U0KI7L5U5voIfS/jTbtOBHJQumZ0UAFbC
	tJV0WVJgL1HBRH1t+5vUCdN7Z3CnV9J7GkMBL0ZKIgclrHW3uh1oF4gXP5OqPjBCzestFEGOfLY
	xShw7pGY4YToaP1oBBqvRdU9YHwxFrvhYI4J/GKhsHJnFDhEwhJsO3ueQiEcqvEtdcKIDiMt/40
	A5Ux3QcLBN6/NjRNJWs8LcGbz/RZjtoelLtNhIK0iCpjWUFsHFqhbwEvjqXWJgyNtgMq93/A8TF
	m+LV0aSlHWSpEjy01I7ygJab/hse4muehdAuwuEIVHUPSxB/Gw5DsT/0SiWBD+1h/kdqA3pAk96
	mmTWQaso3hpKwAJMDHeSEOJIdEXKf0SKNGtYtqqfi6vEyKwtUXWQWqALQxMDFLqXXvPAz4kwVUL
	z/3uhO7uo8KXuiZKhdvqp/Yv5E1cK20u6moyz/s+XTCSqchybrK4dia/hMRSmqxAkZUsC2t3S/U
	U52FVqiThwnIGo=
X-Received: by 2002:a17:90b:2808:b0:398:b46d:48c0 with SMTP id 98e67ed59e1d1-39b262aaeb7mr11728166a91.18.1788539465405;
        Fri, 04 Sep 2026 09:31:05 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661b:3050::4d0:46])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b25c974cfsm5383010a91.0.2026.09.04.09.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 09:31:04 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/6] net: dsa: motorcomm: MIB fixup
Date: Sat,  5 Sep 2026 00:29:42 +0800
Message-ID: <20260904162952.709368-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix (theoretical) MIB inconsistency and prepare for new devices. No new
features are introduced.

v2:
  - split patches
v1: https://lore.kernel.org/r/20260903143514.532023-1-mmyangfl@gmail.com

David Yang (6):
  net: dsa: motorcomm: Rename MIB stuffs
  net: dsa: motorcomm: Split MIB buffers
  net: dsa: motorcomm: Split MIB module
  net: dsa: motorcomm: Use u64_stats_t for MIB stats
  net: dsa: motorcomm: Fix MIB synchronization
  net: dsa: motorcomm: Use safe 64-bit counter reader

 drivers/net/dsa/motorcomm/Makefile |   1 +
 drivers/net/dsa/motorcomm/chip.c   | 408 +++------------------------
 drivers/net/dsa/motorcomm/chip.h   | 122 +-------
 drivers/net/dsa/motorcomm/mib.c    | 431 +++++++++++++++++++++++++++++
 drivers/net/dsa/motorcomm/mib.h    | 167 +++++++++++
 drivers/net/dsa/motorcomm/smi.c    |  30 ++
 drivers/net/dsa/motorcomm/smi.h    |   2 +
 7 files changed, 669 insertions(+), 492 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/mib.c
 create mode 100644 drivers/net/dsa/motorcomm/mib.h

-- 
2.53.0

