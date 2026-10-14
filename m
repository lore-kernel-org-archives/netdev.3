Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087E93ACA61
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 02:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946575; cv=none; b=S8mgK8rj3FqL9OUEfbLt5SM0wm5FcZ31OzgL7Mb3ru5dGfNvCP1T05ptqbtyuXQaYgQf2f+jY50oOhphYy/5iLLD86y7t/QQWoM5BrrzZYtqYx/NYOK1TLlwMZr3sdTmf1X+5XMJtnJejMfmZ5y3aQmYbcjvqSeL3dfwIregblY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946575; c=relaxed/simple;
	bh=uWMcfyDCxTh3OZr+A544tqFx1pQ3JXPWiQE7qP4mYEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bu2/9jrpxI1E3JPdR3hYyCXeEhC9cIWZt6Fe15jaj/sCvBY4Vrj23gOKvv1Jc9HBLOXYJwqWkv2zVmTw+4yQ/bxDR0o2UkGpX3BAxFFV4+HtAK6izWHK1c7kPCHAWEVJfJT34ZlvrgYzSyJ2KEuzoisSqZUkqHf5Xwv0tDCmYtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg; spf=pass smtp.mailfrom=gt.tech.gov.sg; dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b=nw1ITjr+; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b="nw1ITjr+"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-141395927feso6889675c88.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 19:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1791946573; x=1792551373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=J/qs6ep0AVoGjDnvQwIXmuadkHemtYNAxelWIgIUeeY=;
        b=nw1ITjr+IRyJdkmJXHF/akBOyzkuSwl+FY2VNECx/ZL0swQ2q6q8BhT+68jtGF6WiN
         supFFj7ytaxPaZjps420ynGET6Wm9tY5u+EukCb+ZCzkubkKunkKvXv8Ia+K2S0lluQ/
         jUYcJ4cg8iDBHajZrCG/Kz2mN4SNfXqwGHvm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791946573; x=1792551373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J/qs6ep0AVoGjDnvQwIXmuadkHemtYNAxelWIgIUeeY=;
        b=ZIYJ6LxodQBEeFqfNTZjLZTaTWIPVhwcKHrN6cxll0jP16J8qP1nKpGDilMZSjrgVo
         IYjKpB5v2Ik4ZD8tln7t/9xbv+AYivXvr9qDIaE5+x0OBfOcm1dEMqCfbYiyv4p70Hqy
         BsBswFAxHqLn4hF+Fx9qpl9vrJIyq32fnekCLxPOU9bN63rAQenlsGlULqpiSbTHVf17
         DEngQkMlsTkhPXRo9UIBDF5SLcBSjIceRocV8m7EFdUz4/Z3E5jVVCuXlpANXWvUvAD7
         ZIGskqUmRUz4v6uEYz/YSVQOoLiKsz4BFFX+L69+Sdl8nbTR4JNRUiL3ttBX/9FGGcvP
         AolQ==
X-Forwarded-Encrypted: i=1; AKwUvBxBiHgMoRmrQAwHf4rC1Jw7PAgRQTxgEKhnxsZBSkidRuEAeB2jeWUmtU8h6uxwXG0yQ48gwlI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKNEhsohb43mOBYhn7HHi+JlJx8j4nl09AzRxxlLpTTbpUIdE4Y
	lyAjryWgGJHdOnc3QzRUv2u7To8sy+yab7z4XJzOWfivW3iJMxaGs5V7LAt9hbDgiYs=
X-Gm-Gg: AYBFou06BuDlY9p1ZGxpTkM/jBcjgxNFYeeSzMxO5PfXsm/efZgDTDgv7qLnv66eMtG
	OeYor4opDzuHDiZWwk/kti9+yr52uWt65jwHW05hnEMsppr6Ja4MRd7OaFLruxmpSjcVgQ8xMjm
	Nstw8heEL0yLSp3hlI02HeYU4Z99v98HtIoP0CgpAgpGw1RTSFq0gc13YQw0LTW4IMagdyuoQIX
	Zuc1I3YpeleAUGZMPLYKHHPHGq7aRcC941njAPY1ZEVWUr7XNN8J9Xb0pgNxIwFwlgzqBW3IGvc
	Tyn6G1SuQOdVXHVtjGJ+oCVrPRzkEbtoWniM/gWDh9rAHPNVB8RUYYVbT9frB0mGsPs37I/89zq
	FKJuxiQB2wI33d6AG/uk//r6Zo8EjWCO6HmBiFmdGmJ0Qnj5XqS10QWpZc6iKNwerzegV+yqu9X
	qJi4o971sGOjmFC8+DA4HHClvaRJwQlv2r63S1KnsPJJ+UsWwCYHF6TL1A3X11p4XzcRNZO4BUT
	9md8hs0fSJRHcq13JAr13kO+Ok=
X-Received: by 2002:a05:701b:2089:20b0:14a:d8fe:33a4 with SMTP id a92af1059eb24-16a60de40ffmr22090397c88.38.1791946571104;
        Tue, 13 Oct 2026 19:56:11 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([129.126.57.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-17dc865cbffsm2122640c88.6.2026.10.13.19.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 19:56:10 -0700 (PDT)
From: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Woojung Huh <woojung.huh@microchip.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Jie Law <98lawweijie@gmail.com>
Subject: [PATCH net 0/2] net: usb: lan78xx: do not use uninitialized data after short reads
Date: Wed, 14 Oct 2026 10:56:00 +0800
Message-ID: <20261014025602.26334-1-law.wei.jie@gt.tech.gov.sg>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lan78xx_read_reg() and lan78xx_read_stats() accept a control transfer
that returns fewer bytes than requested and then use the uninitialized
rest of their kmalloc()ed buffers. A device that sends short replies can
get stale heap contents written back to it as the MAC address, and makes
ethtool -S report them to unprivileged users, including kernel text and
direct map pointers, on systems with init_on_alloc=0.

Patch 2 makes both helpers fail on short reads. Patch 1 comes first so
that a failing statistics read does not report uninitialized stack data
instead.

The bugs need a malicious or emulated USB device, which
Documentation/process/threat-model.rst treats as a regular bug rather
than a vulnerability, so they are posted publicly.

Testing: the series builds without warnings (W=1) on net and passes
checkpatch --strict. It applies unchanged to v6.12.105, where it was
tested with a LAN7800 emulated by raw-gadget + dummy_hcd, booted with
init_on_alloc=0:

- Zero-length statistics replies. Before: 40 to 88 of the 235 ethtool -S
  counters are non-zero, including usb_api_blocking_completion() and
  direct map pointers. After: every read fails with -EIO and all
  counters stay zero.

- Zero-length RX_ADDRL/RX_ADDRH replies. Before: the MAC address
  differs on every probe and is written back to the device. After: the
  probe fails with -EIO.

Both bugs were found, and the patches written, with LLM assistance,
hence the Assisted-by tags.

Wei Jie Law (2):
  net: usb: lan78xx: do not update statistics after a failed read
  net: usb: lan78xx: reject short register and statistics reads

 drivers/net/usb/lan78xx.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)


base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
-- 
2.43.0

