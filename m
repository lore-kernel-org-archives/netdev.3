Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91CF361977
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 05:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788931223; cv=none; b=gGnv1hp0aJurHSKC8VZ7+cyyYZ/gZUvWTMkhKC0WmSTH18ybaKDxGlRgcrJ+JJ9oDyFMJ4zlFocBodNUw1gJqiyAdMTL2cbrw/ojxIubmjPA21sNRFtfK1sUKmicSbPWcI3uUwvvRa7QcJ5bgkFWZTIPfY4v50EF609C6HPrsB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788931223; c=relaxed/simple;
	bh=6GRgVD5TlHUcB4Yfs3UD57oj6nYQ5AAP1lZaClmnwuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RSXRGqcj8Eu+h7lKTIFXCS0L55kUPCyBt//wA/EAjkrWpYm1Cydu825ATHO1Y7Bw3QcHJnggERtyCTMKcS5z7TXS6PbS89aEwvHguHDcHlKW59Vnero0M/yEolV0VPuheosQSg2RrFDfmM3sQIhhbMz6YdfA5GqE2BIbLqBEgLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=pDZZZYZz; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="pDZZZYZz"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3964dfb5b9aso6559013a91.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 22:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788931221; x=1789536021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dFArgWxamKhfPZe43+V+EkvskIUCY9GoJkM/i4cqerY=;
        b=pDZZZYZzVAPvx7/SOYXLSnDPdfqAqC4wrSn7SeBLZLT5iJLriT8NR9/I8/pD+eGFzS
         zWMz/IlaV4cri66BbcQXvXs7fV/8vhaR2izAnnZ5OV8gRvWaNnVoa3sA5LkYjKifXvV5
         pZWVxgjwack+Gt206ezOLbetlOe7zMn1GgtKuFgT6v1Pme6etlYbeYHx+BJSQr0Pzs+R
         FXrzJL2ITzMd2vmdPRq/+5H5Y+G6JCdtex4taKc0HFqZBUVSvHcq/8aBOdZB9D3OlaKu
         eyVOVvzSLTCRkoIZk/33U4bo4NMJdDAuCr1uQXya58mnrcs0LZzxTFJ95Hq+5aZ/zcQe
         uA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788931221; x=1789536021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dFArgWxamKhfPZe43+V+EkvskIUCY9GoJkM/i4cqerY=;
        b=SsOZGCAp4RhRtUSrXcE2lLcw4NVjhWqkCq2aAFK7ojhkdRt5EANQmb4LQ4gvwPyX2+
         aD5H8Pw65/7z+grjqIrCUYxIKsLfk0nc+8/joNyS8MZ1bwDLxqbGHKA7624OybZnwARY
         Saz2MzXL34sjmFGr17tLdITwHFVVcpQjsUzYsXPTz2O+kAwqUirzDuxwvoMvwTJIFbfr
         dIQHoUYpTyP6ASc+YXdjo3djfYVWI+pGBLMBaF+seXgVphnG+KtW51x3a/+oreZTZbLX
         IjqGifdjSkTwetXleMlS1iv6SBUyvc1R4dWOIM7sVeo78uQC0IVmZVj3RZt21CYID7CW
         DO0A==
X-Forwarded-Encrypted: i=1; AKwUvBzIFHKL3hd3DlzX/ZFJ10zZDueK+mfKqCrCBg2TRNjJ2SWENECfVb8gO3+i0+JoRKpgp3lWn28=@vger.kernel.org
X-Gm-Message-State: AFuF++n0zpxl9N9ZiSRlXQU4x7WzHwksoXpUUkd07w4fsXlBb8tkCGRk
	7s8QcEK5AHmmi2rfaLUb1Jdvhc00psh0fD4katb6p5QQ/JM8m1TYB2RnuH6HFEVFpC4s
X-Gm-Gg: AYBFou2/2rybbwqM0Pbl1fFwVc/vPSMyVg3Y5aMYcRAHlEn7NCrk8X6QTvbrMhbeeoG
	JIZccGWSeGoorZuE90OxGcfGjAIoTE+AzEibL9H7ebXdxZ8ojMoljJx8bWkODj+t03ll+8j/Wpi
	J7z6mm1tR5zXDszde0x+zNnvZvIPeKdUrzF//6fSG/2LTJEJEdTYjyf5Ti4SlLIR5lK8FHnkNtd
	UfSHA3XDj6/TmIb2s0O6Y5hVZkkpyZeUly451G8L4DmDE8sza3JqFjKQun9bMIX2InLHfUEF7D0
	k/TqTjBjtmA44lEFee8gbxBV0xZZ+ubP+t9Vc84+/JwhN0WBSSNqG2ZJtkDWWzj6D1D/s7lOisf
	BRFpcpVEho78YIsXBdiKLy6AUNpH+sVs73a95x+zpLjoi8b7DOZVIKyMlskgm8fxOF9sRur+8ms
	olp4HX8L3y/49JY4ajl4p7HQPPkZaoD1NINF/ErOaEeQRXwRpoKgQzuGYVyoEpWGi8NsSlKubY4
	FhJLZUh
X-Received: by 2002:a17:90b:5106:b0:37f:c22a:c188 with SMTP id 98e67ed59e1d1-39b260feb03mr48275601a91.4.1788931219655;
        Tue, 08 Sep 2026 22:20:19 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b314cfcsm40920142eec.19.2026.09.08.22.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 22:20:19 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	horms@kernel.org
Cc: david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kees@kernel.org,
	pengpeng@iscas.ac.cn,
	raoxu@uniontech.com,
	rosenp@gmail.com,
	dddddd@hust.edu.cn,
	joe@dama.to,
	ian.ray@gehealthcare.com,
	kuniyu@google.com,
	linma@zju.edu.cn,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH v3 0/1] net: nfc: fix use-after-free in nfc_get_local_general_bytes
Date: Wed,  9 Sep 2026 13:19:23 +0800
Message-ID: <cover.1788841682.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

This series addresses a use-after-free (UAF) regression introduced by
commit 6709d4b7bc2e ("net: nfc: Fix use-after-free caused by
nfc_llcp_find_local").

In commit 6709d4b7bc2e, nfc_llcp_local_put(local) was added right before
returning local->gb. However, if the reference count drops to zero, the
object is immediately freed, causing callers accessing the returned
pointer to trigger a use-after-free.

Using dynamic allocation (e.g. kmemdup) to copy the buffer was evaluated
in v1, but it led to memory leaks because all callers consistently treat
the returned buffer as borrowed memory and do not free it.

To solve this properly without lifetime issues or leaks, this patch
refactors nfc_llcp_general_bytes() and nfc_get_local_general_bytes() to
take a caller-provided destination buffer and maximum length. The bytes
are safely copied before dropping the reference via nfc_llcp_local_put().
All callers in core and drivers (microread, pn533, pn544, st21nfca,
digital_dep, and nci) are updated accordingly.

---
v3:
 - Include <net/nfc/nfc.h> in pn533.h to fix build error in uart.c
   caused by undefined NFC_MAX_GT_LEN.
 - Restore nci_request() in nci_set_local_general_bytes() to preserve
   ndev->req_lock synchronization (avoid unlocked __nci_request() via
   nci_set_config()).
v2 Link: https://lore.kernel.org/all/cover.1788157545.git.rakukuip@gmail.com/
v2:
 - Use caller-provided output buffers to fix UAF instead of dynamic
   allocation (kmemdup), avoiding memory leaks.

Luxiao Xu (1):
  net: nfc: fix use-after-free in nfc_get_local_general_bytes

 drivers/nfc/microread/microread.c |  6 +++---
 drivers/nfc/pn533/pn533.c         | 14 ++++++++------
 drivers/nfc/pn533/pn533.h         |  4 +++-
 drivers/nfc/pn544/pn544.c         |  7 +++----
 drivers/nfc/st21nfca/core.c       |  8 ++++----
 include/net/nfc/hci.h             |  2 +-
 include/net/nfc/nfc.h             |  3 ++-
 net/nfc/core.c                    | 15 +++++++--------
 net/nfc/digital_dep.c             |  8 ++++----
 net/nfc/llcp_core.c               | 17 +++++++++++++----
 net/nfc/nci/core.c                | 10 +++++-----
 net/nfc/nfc.h                     |  3 ++-
 12 files changed, 55 insertions(+), 42 deletions(-)

-- 
2.43.0
