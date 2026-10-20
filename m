Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792455549;
	b=aRZAN/Z4XCXt2aD4Ak7IUhm9Jn8TGxcFrhiSCsjI0r3MyZ9P1Nko4X8N/3ar3SvJnD44
	 zRJRpYwA6oqxRmzuvWJwl9hVWxwhxi5cA+SWjJHR6uLFZCgZ42W8eUCcCnaQhuI8AO/pe
	 cctANh12/lQZmIFYzZH1BDV2HBXQnd96WoaRTKTNWipN9eJJYIGcHDVV4joJ2xOigkppV
	 irJCEp/6eVjKQG5hUKNx2s3DiQo5qqRnlE/aAMUlgHZKhE4M4ShljuBnoLjMd/9vrgBnc
	 wNS/K7yJNL3nL65B7tTjmZ0WV3Sw+o54+ZKMM9as1UtMVL0QCU6iQHYa4ETLPvauV3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792455549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Y/N7egXXa0Sj44BdKsS2Txw/MVlcyRGITqcsndVmdeM=;
	b=ufaY5RsSmJ51+Yl3HutqCzF2LRbnyd8bOtNri7oYj3qN0QyLHEtPrs6SvL7xf82Tx9Ra
	 rGcDVOwAD0dhBLQswC7d50VGyMY3NYBsViyPRXjywEgs+fDVuYtRdalz57g5ubC4SSLMj
	 M9tej4C6W5+9jVau6XXMRdmc+w/ZwSIhbWRVOlD1ejy4tYcT28bXT6MF0ZVGngLRAr9IU
	 vADiUvOB5MDA7LVikAuuhW/WLpxXDhqVLYHiQeNyxZoL+ehxTjcqRWoTi9PKyLD0juU2h
	 46k2eZlv6C/JG1CKmd0QIRfGU8Um8VvByJLWlMlYPvMArSzyLZktHbj/sMoD9UXYHTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gt.tech.gov.sg;
	spf=pass smtp.mailfrom=gt.tech.gov.sg;
	dkim=pass header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.a=rsa-sha256 header.s=google header.b=Rx8unDJn;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF1F606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 00:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCF1F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.a=rsa-sha256 header.s=google header.b=Rx8unDJn
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so2415255a91.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1792455548; x=1793060348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y/N7egXXa0Sj44BdKsS2Txw/MVlcyRGITqcsndVmdeM=;
        b=Rx8unDJn3OHrbuPKB3uN1v7u5AVU79xe3gRaIRde/W0gSe8MKluBgonFrJyOC7FHAq
         oJhGCHx5x3ATrJqszf1CEpLq0qWJHXfXBUquZSrLxBrdM7SFLGFmoFY8SBaTISsqmyjK
         Lr+MM89snnceR6haMaqmUWp6dr1dhmF/fmRus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792455548; x=1793060348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y/N7egXXa0Sj44BdKsS2Txw/MVlcyRGITqcsndVmdeM=;
        b=ZMv16b5wJdgCg6jDqiga4ACrqawSqmA0CqxzuUDqMQ9ra6Y338AomIUWi3sDj4jEhE
         fTUAXTtWgTu8duPYge1652yo8KoSxkTlD2SSCyXoTDOGw1b2unkln9+ETQ563sSKoTlF
         k9c6y1dAqZfVQACnvE/PXBvfB3Jz43aJS2M/ZlU8Uub+3vms65YoS4coe9/jP50RfYpT
         75UXGN/XGRak+6OEF8QSdbuVtqL02dkefUhyI0zXuMfPNCzrcL8ivgc888GnCIcngqcj
         QkSyz7CmB0c54rUUTHhjoiezzRc48Phufej3TCGrxMt6W4aM9WjmPMwE/ILXDxlPX8Fr
         m82Q==
X-Forwarded-Encrypted: i=1; AKwUvBygEKdcnPwVTIGb93p5ehhEUJMOv8jHoquBGMkrvd/hCxRRgzO+kecoKEy6Orn4+nBzJxWTX2o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgGDFNIaHNMEKkOloL5T6GtvFqg2BrSg3H7E/TYbPOfVplYLRG
	lN/5hxstMAZmbuv8jtQTZdKWo7/KmLsmy6DlRKPILAiH+gxXSJ2b8XyEgof7es8WCaI=
X-Gm-Gg: AYBFou3MW0scogQqjb2f4pxHLbGXWQ+HkGrwlD7pGLy00zg6eZQ84R6+40bPmDRqyIA
	Jus2H8jMgSjIkQu24L8uPTtrQ6vK5pK4r4V7ZqU0Oz7RKs1wF+O2B9D7gA4uYq3O/kKTzgPi/sg
	SWj0Df2O3DET2K/Otmlf4lFd1p3IXnGx3uVdn/HCfQ6fSACyDJWwQmFBqaNRczD+Go8RcPLF2zL
	xY06VF58WX7WPBTZCAhxxChKX1HANbh2RhciBbgycs6UintE+1MgmAZS00DMlOGuqq0SELljrLX
	zA4Sv57n6kP4gcYCxpxdAt2cvGbZKeVoyxuJJc0cBjR82MkCEAFqZG/UY+9oKy17oY76WzAuh0n
	XSmLjgnvabAOH/qoMTPFpVDqWjLC+Cd5bhe2jlHKCxz0Hgew2aY4pX+BvWeyZVQnxIL+by9VikW
	6JU/WCUNbxl9lXwkh++Kj7GTAAFjvh07LkfK5Ze9XX/fzLHP9Kvil41kyTdVD38S3ata3M2Duqi
	G9ANJ7VyOFJ4n6hEcRvxc8cCzXG1h5QCEmxFLLOw/WRkCs+wXo9oHyhbztCujgStA==
X-Received: by 2002:a17:90a:d2cf:b0:3ac:9c37:9430 with SMTP id 98e67ed59e1d1-3aceeb91898mr7922087a91.21.1792455547951;
        Mon, 19 Oct 2026 17:19:07 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad5d6df89fsm1694273a91.11.2026.10.19.17.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 17:17:56 -0700 (PDT)
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
Subject: [PATCH net v4 0/2] net: usb: lan78xx: do not use uninitialized data after short reads
Date: Tue, 20 Oct 2026 08:16:19 +0800
Message-ID: <20261020001621.2920-1-law.wei.jie@gt.tech.gov.sg>
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

lan78xx_read_reg() and lan78xx_read_stats() accept a control transfer
that returns fewer bytes than requested and then use the uninitialized
rest of their kmalloc()ed buffers. A device that sends short replies can
get stale heap contents used as the MAC address of the interface, and makes
ethtool -S report them to unprivileged users, including kernel text and
direct map pointers.

Patch 2 makes the register and statistics helpers fail on short transfers. 
Patch 1 comes first so that a failing statistics read does not report 
uninitialized stack data instead.

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

Changes in v4:
- 2/2: drop the examples from the commit message and move the note that
  it depends on 1/2 below the --- line (Andrew Lunn)
- 2/2: also fail on a short transfer in lan78xx_write_reg(), for
  symmetry with the read helpers (Andrew Lunn)
v3: https://lore.kernel.org/all/20261018062419.21921-1-law.wei.jie@gt.tech.gov.sg/
- add the missing Signed-off-by; no other changes
v2: https://lore.kernel.org/all/20261018061734.19488-1-law.wei.jie@gt.tech.gov.sg/
- 2/2: the commit message now says that with patch 1 only a partial
  statistics reply (1 to 187 bytes) still leaks, and that patch 2 depends on
  patch 1; the MAC address paragraph no longer claims a write-back to
  RX_ADDRL/RX_ADDRH, which happens only for an invalid address. The cover
  letter gains a partial-reply test. No code change.
v1: https://lore.kernel.org/all/20261014025602.26334-1-law.wei.jie@gt.tech.gov.sg/


Wei Jie Law (2):
  net: usb: lan78xx: do not update statistics after a failed read
  net: usb: lan78xx: reject short register and statistics transfers

 drivers/net/usb/lan78xx.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)


base-commit: 7ec48f396a1d89532c0537bc38b408b8c31ee37f
-- 
2.43.0

