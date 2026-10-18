Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50E93E49C0
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 06:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792304673; cv=none; b=PQdHz2xaXJDW7W1fCFQzLcss83TpKxC3+pY9sD5XnH1frw70b2nRNPX/XZAwkEGMljUdxR1Ny2z+GjXTyPDMG8m7imFkRejMD4N/jHTmA/4m4q4qBRSuwnltWjDa98gKH/xXmfjFvJJ6QmhrJ6fW10yfPLQ5eCVEjau/QztyHuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792304673; c=relaxed/simple;
	bh=u60/h86UtCV0RHUmtNCYmhLRPiuBkicoYzvb6oTOgXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P3tswWMCOVZGtjqaxhR3XV8JL/ebnfxlA5pm6xyOdMNUHPmXCfJCfBhmMbd6ts6pC/rqpFum1skWg/fIUB40+3C+gtzLZoyZS6CtUDu7EyoXyfgeL+8bL6yUom3Pk9QjbvhRiFIcoTTosYaWieUXADlV8hMfZMeMgMUZuZU4X5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg; spf=pass smtp.mailfrom=gt.tech.gov.sg; dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b=sP5FjZ6A; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b="sP5FjZ6A"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso741726a91.1
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 23:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1792304671; x=1792909471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q5RPMRI/Z07lJ0xDImPcnvLDgkc0YFq5cW2OslfyXR0=;
        b=sP5FjZ6AP55RaaNfHtG6IPu9Tot9po2x6OnJDLU7+n2LhOFxC6CejgUGRboE/Vq6fB
         CPg+LjHXPxuofU3UVQR3jgaIa77V9ff/9Ldo8+JWqRofhOxltttDU2X25nEG2MYrNIBb
         0EANDKv/mmwxP6qIFPcmxij4ll5w1EnvCGDBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792304671; x=1792909471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q5RPMRI/Z07lJ0xDImPcnvLDgkc0YFq5cW2OslfyXR0=;
        b=yBOEXGnaGsxcjqgWgYdD3QMK0j6Y9mJFVKTRCIeOr4Z6mBEOVW4zDaqsc6UmfboVQu
         B4xnqdspSrWKJe6CDf2MfVbwjCX/3RjaFh+pnYXdNrrCgDGiru5NJuqoEY9npD2YV2P8
         qtbNQ6BQbMGLaY29qs0CEx9mN8B6aAcZCrpY4uTKy1dqU2AOlHirRU0EnAw57izGbaqe
         XFniv3+qeNPBW9F8k7LbEuYF++O5sgQiX4/5bXYOHPJ8azZHndyhizi5mTqUP6VFt4/3
         BYeodgZ5raangzcByqNYv+7cyojjR/tRnqHdjJLzy+DUULmgA2scKW/V6nnRK0ToeQdW
         y27w==
X-Forwarded-Encrypted: i=1; AKwUvBzNgEcxzDuBnEGVqiZexXUL91TG32bNJrbpXp+CfiCFDrz2VrL6qi2Boz5yOkJL/eM9PTecMEU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7M8qb6Zp0YQBV58Tla+kjuSoLy3b7jVBTbtXhPBVNPk6cKchd
	V4mbKofC9ESlwtHWQvR4HbGn0ymD+qPfu5z0Bf0SN8RH2YNJZINP18cg7sFNMp06REi1ChVu9n+
	PSAA0
X-Gm-Gg: AYBFou2vsLSK0b2RjkQ3o1G/lQ7doObfguTy/nffpI3z51Tf3H1/etmMxp3R/CFtKAc
	Mvk6pORDof3A5TaWutKkiYMK55kby8grcIZrW9yzE2baGFVZfXYTU3sRuUt1dx5hAfrKe/0uN9l
	6kSERA0xJQCREvNH5h8enqVcVjdtblnXP+CisoIsDsSlFAdt4mJhYq684bSKvByOor57jbvczSr
	JoDLis7bjo4oQNNO0oWXoPkZFCoIy6/3sPyT0b1pD6nWgZ9OPPLh9eGjROf3YzThBN580e9rEk2
	PhTaS7q2Vb7JBGMQBcAIy8TsoRpPCrpUIeVv5oeU1axkQW/cTjg2CKx9qYtUkff5SYG5JQK2GLA
	fpCNUPNiHrVtiNdujupmXPHj1ZE76yrgnn19LDBg4pYiL/TKZK4wpzxVV04DrdRaviM7fysuZqX
	G4lJvfarQZrPxMlgKvqpbdjQnkZ+HDP4q7FWi5DDHotLMcDQjE43r/Ycv3su6lNAdb+VLrGI9PN
	lrRa4fculNe6QNVRGjQGl9WWi0gz7GiNm2PeDpAoAd/pwlgr/DJsAg=
X-Received: by 2002:a17:90b:2708:b0:3ac:80dc:f409 with SMTP id 98e67ed59e1d1-3acef5dcbe4mr3210265a91.61.1792304671066;
        Sat, 17 Oct 2026 23:24:31 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc46ee274sm10513293a91.4.2026.10.17.23.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 23:24:30 -0700 (PDT)
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
Subject: [PATCH net v3 0/2] net: usb: lan78xx: do not use uninitialized data after short reads
Date: Sun, 18 Oct 2026 14:24:17 +0800
Message-ID: <20261018062419.21921-1-law.wei.jie@gt.tech.gov.sg>
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
get stale heap contents used as the MAC address of the interface, and makes
ethtool -S report them to unprivileged users, including kernel text and
direct map pointers.

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

- 100 byte statistics replies. Before: 110 of the 235 counters are
  non-zero. With patch 1 only: 29 are, so the stale tail of the buffer
  still gets through. With both patches: the read fails with -EIO and
  all counters stay zero.

- Zero-length RX_ADDRL/RX_ADDRH replies. Before: the MAC address
  differs on every probe, is programmed into the MAC filter and is
  used as the address of the interface. After: the
  probe fails with -EIO.

Both bugs were found, and the patches written, with LLM assistance,
hence the Assisted-by tags.

Changes in v3:
- add the missing Signed-off-by; no other changes
Changes in v2 (review by Sashiko):
- 2/2: the commit message now says that with patch 1 only a partial
  statistics reply (1 to 187 bytes) still leaks, and that patch 2 depends on
  patch 1; the MAC address paragraph no longer claims a write-back to
  RX_ADDRL/RX_ADDRH, which happens only for an invalid address. The cover
  letter gains a partial-reply test. No code change.
- v2: https://lore.kernel.org/all/20261018061734.19488-1-law.wei.jie@gt.tech.gov.sg/
- v1: https://lore.kernel.org/all/20261014025602.26334-1-law.wei.jie@gt.tech.gov.sg/

Wei Jie Law (2):
  net: usb: lan78xx: do not update statistics after a failed read
  net: usb: lan78xx: reject short register and statistics reads

 drivers/net/usb/lan78xx.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)


base-commit: 7ec48f396a1d89532c0537bc38b408b8c31ee37f
-- 
2.43.0

