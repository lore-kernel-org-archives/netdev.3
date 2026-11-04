Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815142;
	b=kXA2h2Kv7hGmw5y6aXEjEqcd58+2hQzjrprV2sPKcdy39Q5vu/PRGEOUE6OiN+yMoFI5
	 mCbtmUWlUpA8QlUyszJ0i8NVz14IoZ+vF6kLLqTZVAC2PrOx8WhGcVdDUKiO7sJ0hs6o+
	 iKShWCBJ1yFW3KrCm8Wk5vHf7RRpYYXYI9nl0S4w9d4KZE4tCfdJqMupw0yrzcSPhIo2y
	 7G0SACwPOEH1RmT4uLuVRy7Fw/BjyQcIrkp60FF4fcw1KMnba52rYqo8QdgZOAXqzSFaJ
	 +WKgGlPvJl6MkdcN4wk+ve+jHTDqL05kGq6+1z/mOx6vnVqgTnyrh5GcjaM5dKhjX4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815142;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QTmRvblz37PC5NCgNvE/BNHc3Kf6wzzDBVIqvbKgPn0=;
	b=rAMtrSM5SKtjSfaBK9kA/WScvGrNI3hJMO53wYe5de1WsMzjjuEF3cVp7TkQdmvEMWvQ
	 BzjdH37Pc7URJpDhGrUpe543KTofHteR8fAIxkQYtKNBo4yvoNj6XR1hs9HWHeNW8YR2b
	 lFOsBBwfKAdSMltO1zBubOoyMHkqMOi3xsLZfuHmze4YD2dEC6vhli2M0ElqZj+d6W3eL
	 FoHoYV/UQfsZ1tWO8rYXh5lPOw9Gr8y5ZWJqmhqzonwbzd9xf7KVJNBnzTK/5ixFDpEUl
	 8YiL/KAz53v4YVw1UG1SyBr4Rf7ScbQfPAczV3Sp9Nm/fApT964xZmLqezIB7uf+nTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BwZjJYuH;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCEF606A339
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 17:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FCEF606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BwZjJYuH
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e987b4a710so11577395ad.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 09:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793815141; x=1794419941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:cc:to:from:subject:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QTmRvblz37PC5NCgNvE/BNHc3Kf6wzzDBVIqvbKgPn0=;
        b=BwZjJYuHu4C5xRyvxpOt4TmnLLHzPmDzqOIsNcQCemo2wDlGld5Q/lmW9A8MryqQ0Q
         rITH9Bx5qa/CkWy6AJZSxntn4YSM1MU+Kmoci4x9E06v3p7YmoDN6Sr2cVXPg8F4Q0VL
         xyMd88fFmtePHPKaybT3TSqx04llb+9FptfNj9jjdPNzy6ehkl2aKp0hhc2I+Y6J1Klc
         aGcQkL999koiB2n5OjEa/gHB/zlPMBhgEdQB0LQjYXvpoWrzpVBKXeLn7BTAuTM5obdf
         9A1s/xZXXdUdFKhWxG92TlWVIgY5KjG07hTtP/EMFoROP19iWofu+WVxFmyVa9NC8n/j
         86Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793815141; x=1794419941;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:cc:to:from:subject:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QTmRvblz37PC5NCgNvE/BNHc3Kf6wzzDBVIqvbKgPn0=;
        b=C0MEE6WcbhIntkn/cyClVzkGEXkRL4KtPmK5CV2jUMLheDoFataL9b/3WbyIb4e4Ji
         ZseuSCE15BNFWNlQ9J4lrHvdNXUhdUxWO6z896O4Hr2JN3yzABA5vMw9NHdzKAS9OmBi
         Msp8/dcKpXRfMyhokfGshZwZ5vKtNiCu61AFIh2x4ZCDD29dzQ5xUWLnvagrZ4Tz7A3A
         PZAObp4SeDhxgd5r9eQmFWO5RkGtS5Cf3dsefBBQ6goooDlm5HIeKBeLttif7b/fLkMt
         N/6T0cNVbf7sPRWWQOv833lcjZxmAs9W3uEIAmsS89C7F6GvFkVA6gH0ySP/AqbBnsPs
         KvWQ==
X-Gm-Message-State: APuU4Z/10O1qB5FQHqtdTqEzjAtJXwr6t21glnIqHYyTnDJaj5jUVvZE
	cpAVLIFsFZ93zvskmnlPUO9z8pn+Gp/8O+hDODIJMX2zwdP4MgG5R+rfdNdLvQ==
X-Gm-Gg: AYBFou3+4ZfMMloxnifG8OshxJLbvM6Mwwd/7+xc1IppjJFXOQLpVX1GjngI5vdTOhU
	DyKCVpFIVvMUEQXhwNwAmwf1ge8+rr7SNXia/XNeic7l9KoyDuDAIDHE/2svHmaNO/XP4KkUYAo
	y67281SSCUvB2UBPQFT1PkRKJUTOjHLF27KftHLWxHzET8oftzKDSMr2SNowdIMJiH5N4uWyOhj
	yQT/HQBZMwUVeoxbTNBNX11lh01MTYaVXVozl1hnzTMyX8/tp0nuTNYDHLlXG1HNCfuYN0Tz6jC
	1WsRUXWieCaZVv2oEoSJee/lpDyTGOOXUsYOk2RSzg+eLhkTI7jUHbHmhxBe0umCvv4sm81LHUq
	tTgAcg0+rvqGFCKXAp5ybWg1N2+ZwH47tLHcTHwzAU940TLsUeMnYLmzXhe4krJit9yLiO8ogWF
	GLAHJ4QjPxl5ZATkV7muwH3cbaRrWfSi2rFZXlDTTgwunmXGrt3lEp65ykcrTFbK2VcNUN8K2tz
	DYCBZswZ5RNZSus7uh6SBO3AtY5M61yoBxS3UXP/8rVrkO+xXaEaOg+JqcDLtSYv+E/AMn68ow9
	5moVST3iCbmF6DHMTqr2cs9AJWIsTZA7ykPYn8OEzfxVBWDebf66wVXyMYzq7pYLalCzwz2XqII
	lA2eFhNvVbSqm85jfwyqxWa+ZWk9CVUx1PJ+r/7L9TWA2ag==
X-Received: by 2002:a17:902:d50a:b0:2e6:e9a:eb48 with SMTP id d9443c01a7336-2ed24050bc2mr1066155ad.41.1793815140726;
        Wed, 04 Nov 2026 09:59:00 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c1:38c:400:22f5:2de:b9c3:f27c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed08fe1e4dsm10474875ad.21.2026.11.04.09.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:59:00 -0800 (PST)
Subject: [net PATCH 0/5] fbnic: Fix FW crash restore,
 stop path and mailbox teardown bugs
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 04 Nov 2026 09:58:59 -0800
Message-ID: 
 <179381496288.9644.9775319757787890210.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Fixes for races and ordering problems in the paths that take the datapath
down or rebuild it: the FW crash restore, ndo_stop and PM suspend/resume,
the Tx force-flush, and the DMA flush on mailbox teardown.

Patches 1-3 were found by code review or inspection; patch 3 has not been
seen to trigger. Patches 4 and 5 together appear to resolve a hang with a
PTP Tx timestamp left in flight. The series was tested on fbnic hardware
with firmware 26.09.14-017_h7ab84d2ef68f, cycling the interface through
DPC/AER recoveries for a full day, and under QEMU with the fbnic device
model and live firmware.

These patches were previously posted as part of a larger set:
https://lore.kernel.org/netdev/179322311834.40667.5383039334126572422.stgit@ahduyck-xeon-server.home.arpa/

---

Alexander Duyck (5):
      fbnic: Take the instance lock to restore filters after a FW crash
      fbnic: Fix service task races with ndo_stop and PM suspend
      fbnic: Disable PTP completions during the Tx force-flush
      fbnic: Suspend phylink after taking the datapath down in ndo_stop
      fbnic: Wait for the outbound flush to complete on mailbox teardown


 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  5 +++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 16 +++++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  4 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   | 43 +++++++++++++++----
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 10 +++--
 5 files changed, 64 insertions(+), 14 deletions(-)

--

