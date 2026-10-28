Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206055;
	b=IFLxmJHEoFu9C3sPVkWKrIxlPzxhWd8BvrrPQ0kTidJaMQbz5K2glSS69ocZrOvQ4/s7
	 fsXBzZ+FvK5ovWpHmD5V6mibkxc5JeYBdho5HKIXxF05yHCUOldfOCMIFh/XjWADNL1dq
	 VFusRAcfPkF0GV0fZfVTHzWbdpfh/QZarBS73iEzaVpphCXyvxNTYa/6KEIDaJr/8GRn2
	 QoURz6vOitUH/rt4KAAw0r7eOq8aPdHOq26yyT6rrP/EhEusjuBqfAFiZLM4o2Mq0nA1s
	 pqF3IoX1f1fOAM/rlsx4M7Zd4Ersg0VKjASWEPGoOSArs7jcfTrKstIH3Eua3x3xYcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hXQ5AtLbtETfyYAi8CVU1bdEjN/xUiyW0YYpN9HOqkc=;
	b=zx48U28KSMfAU4mAxZClpw1IzRfeRzFjXXo1B1ALWpGBiNQea+efAtuNBSibp7iP8cB2
	 hFuBdLipQZfKFjwLePKJBLtABI7eZM+RvZ4rJyUVvtk2u0Gm9TxwdQ0IMTjbHEI1VBaXC
	 nxy2uy3F1WlAPyThAfg1iPdPGm/uDmj00FBDkTUKB+XPIINf9yPmAj1tU+QpZwUhC6QiE
	 zgUVT5jr2i3hFhHtsrD3pvpSOwzOJxOo/2pO6zHIAb7/wWIArtH4v6lgk3n0bD9vDSIUl
	 irSAFZCL7MA+LNv4s8IIPml4iV9u4gRqqLIkvoSwdt4+qWIAQoDb0EEQWkKIa1gPwOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="tZqd/5Zc";
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0596D606A31C
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0596D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tZqd/5Zc
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd61a2dfd7aso454561a12.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793206054; x=1793810854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hXQ5AtLbtETfyYAi8CVU1bdEjN/xUiyW0YYpN9HOqkc=;
        b=tZqd/5ZctCbxMs1eSeArkxV/6Yk8QYOU200v8aPUBd4k+sUr0zgoPNPHCiY9a31ngD
         gns6UZwWrMJNXTVzKhcVhZMb6F9fvMWXjAUgyuqPUB8GdNC/uij/msuxHgxXGDXrKgly
         CSHMSlmpjfyrrOANMGrLr8oaAAMetCgfX7vA5SmknjqRrvTHz3YTSlaJSAKd22Az96/b
         1CFbWwIGFdEurhKh4wzON/31ndk2aAcs113W4EE4HC3oXaI2QHAWCOOB/d4cjPgVhxEY
         AzxcmEQ/BbfzcZtH7PfgjPvaeYWCVY70q7VB9lCRG3LeLPN60Zc4HPF3kXaUs5OWSW4j
         uFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206054; x=1793810854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hXQ5AtLbtETfyYAi8CVU1bdEjN/xUiyW0YYpN9HOqkc=;
        b=xJ0BlKjXIK9PeI2YwAPiLh7ur+2F3nsgqxECaYQNJwRY7vc2ZSgSdyJ83IlSlgbOl3
         OL2X7PaVoGZGYZ11caWsanO+nyKcFwZQ0G1VPd2e96RGsbBpSUSnM05GYYUdOdbRdKfR
         dkjPjcskog+X4utXtNNMCZnyEibSBVLD5tVDmT+Zklgup8k5F7PB/pJ0kQUFLN84Psnx
         nEOc6iBbqlGoI/9s31uh1Awm+K6D0ImSPV+Clh9PJDQXQrBsadE5xTe+heJKNYWgUQ+u
         opUbZinjOXv5JK3hf+KfB4jEAUGc04rRxFC2G24DX/+WuFFceOV9t+3MJEO91XFlC+U1
         02dg==
X-Forwarded-Encrypted: i=1; AKwUvBxI+DKsf9B1RE8P80UZJN/pp6iuuj0tARUeIHybP2BfxMJgQ7QemOGCTpwpPT9whV/4GffIp6E=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3GwXebA11EJ7gvF9sh+fHk833Dpxmz3Fwvytv88qpTh4uefK6
	X8do+JSSBFn2qpu/GOmX656eOKFKxfZKdggr7GseSkbwDlusKEbBGhdl
X-Gm-Gg: AYBFou1wtHrJ9q17YVxC/4OjNl+rDXTURRFkPP1nmp0xdUknCkDaZ82UmXU2H8e4ST2
	p0wDWyUplCKsF8DSQ8OpWGKB2HHvMSxxuF9inWgNZQlUyBbZBMS4csYB8wTjHS2rctPyctMRHXq
	p0rECcKYFRWGbjWlMbTPqz+KqZ077YI9crSU7w4p4R6EQzy+d9l9BnRmEY/gblItknYmVACh3qP
	r/GsXEImhYh4zu6lWxDVYBwbPm7L2TMY/4gygRDdarXrXLDI9HjLoMol/MCJikezK75xJLQ7k+d
	06xkNh9WmSdV28WQYLjZyVyhJYkXfu7knFKy/u+LOx6uRLFS6edMP91k0Czel5b0TrQA6vthw5O
	wx/J2oYaLIAuPfnoXnBy5S2Md3eTSSLXa8Px5vrMwVejE+xEbJHcXVJDb8gCFHVaoYjoacnIKia
	BLbY1nR0r9Ye2Hp5azNjm0/fUuxot1l3Zdzi9+KgOEutKtXdDTDOIxIPP4TRAYo0AkgZPBU3j7f
	a247qXopV1e2mRcUglyW8AlP8UiZPvBHsyCUFJ5iI4a5VEBqHv9aWiHkuKXH1XQSYRD2+coELda
	AG3BhUPK6vlmh01br0rspDmFgEqv77NgccqZP5lWQCH+yQm4kAEWZURRu7iYNK4qCaYF
X-Received: by 2002:a17:90b:4d05:b0:3a7:f4d:b23d with SMTP id 98e67ed59e1d1-3ae5821f346mr2159561a91.52.1793206054280;
        Wed, 28 Oct 2026 09:47:34 -0700 (PDT)
Received: from asahi.tail4da9e3.ts.net ([218.48.198.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae579c5b77sm2173048a91.3.2026.10.28.09.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:47:33 -0700 (PDT)
From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@nvidia.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Baek Kyu, Kim" <pocj8ur4in@gmail.com>
Subject: [PATCH net v2 0/2] bridge: cfm: correct CC receive monitoring transitions
Date: Thu, 29 Oct 2026 01:47:28 +0900
Message-ID: <20261028164730.253238-1-pocj8ur4in@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Two CC transition bugs affect CFM receive monitoring. When CC is
re-enabled with a new interval, the first RX check uses the previous
interval. After CC is disabled, a received CCM can still change peer
status even when its RX work cannot be queued.

Patch 1 stores the new CC configuration before enabling peer RX work.
Patch 2 keeps RX work disabled while CC is off and skips CCM status
processing during that time.

The v1 submission covered the RX work restart. This revision also
addresses the two review findings. The interval fix is a separate
patch because it has a distinct failure condition.

The combined series passed 8 CC interval/transition checks and 3 CCM
status checks under ARM64 QEMU/KVM with bridge/veth. The CCM status
test failed 2 of its 3 checks on the v1 image as expected.

Baek Kyu, Kim (2):
  bridge: cfm: Store the new CC configuration before enabling peers
  bridge: cfm: ignore CCM while CC is disabled

 net/bridge/br_cfm.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

---
v1: https://lkml.iu.edu/2610.3/01364.html
v2:
  - Add the CC enable interval fix as patch 1/2.
  - Skip CCM status updates while CC is disabled in patch 2/2.
  - Retain the RX work disable/enable fix from v1 in patch 2/2.

-- 
2.55.0
