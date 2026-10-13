Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309EB314D18
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 02:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791860276; cv=none; b=H1gmqZ0d4Q41wmXTJqt4ijfsQwP+zGKVWvTWCSB+2PktAGm+Zl8L9jxROrX3+nGSTHQokVPVPeu6qTU9Jq/7xCKDsHb4rxog8/cePv+dRoqIHZfSmo6AOPTC7FzFHOr1LlZQKaBAB7AwIQGv3x+jR5M3CAKE8v3+js4JgDuqFJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791860276; c=relaxed/simple;
	bh=jFs2ejwyQRoiUFaaaOWLo95jLgIUJD5pi3UvSHe6KKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DT238XN1y5axZTdXEQPCMyOfirNobCaF2P/EwPNaRvpcyEtz4Ct2dXUch+dDnvSLu+26ow08S3T50A24o2MNjUWQOug2u8rpYDoAlAf8GxOP6YkN9t+NCUBOVvvvroamRw54S7oDYbu1/2BaEpKWOFYy2PqG0lQm7uyt1LvpRhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security; spf=pass smtp.mailfrom=octane.security; dkim=pass (2048-bit key) header.d=octane.security header.i=@octane.security header.b=mwTWtItM; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octane.security
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=octane.security header.i=@octane.security header.b="mwTWtItM"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-154e9d2d979so1641689c88.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 19:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=octane.security; s=google; t=1791860273; x=1792465073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VKlzSdYOmHmxNkajBIoZRP6k3zgKUV8Nk9LgZQpvxD8=;
        b=mwTWtItMZIEma8k/cXQ+xJgo+gDTwDliVSFTrpNvTylLLvaFVMNSmCktD4DDyzDC8l
         s9uwMbC2x4D/DsmGvGFukPJbiAjC7Oix+AZPylJ1ujKvsDTmcBofAwFbGg6u1P8aOqVD
         SjwYIZbJO1b3Th7wK9H/p9eqpzDgE7rPcJ3LPWXR62hRJqnayIWZR3wP2dEnTCAvEe0+
         5Vrtu7RZIJ9u5+MbLBMCcVoGJTUVLS6EWVV3aR5qZaS1cMbTXpFMzfkD4u5cLbVL5stZ
         +Mgz/f7qoyTl2coTqgdrALmvHCwxjqBvyvW9sZawyUtuoAI25oP0E4Kj8L9ZX9c+eiYU
         8nuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791860273; x=1792465073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VKlzSdYOmHmxNkajBIoZRP6k3zgKUV8Nk9LgZQpvxD8=;
        b=cQyMwsbPcGyMnV0CQEDlq403Rd8pr+amo3y1f6HTAewC77pS97gV52PRgL8BQgNTux
         xmd9Fgu8Kw7VAAzCOlblpZPLWxm4W+WCnnTwMnZsdLY6uvfJ1iV0ujOG+DLnoPcluCOy
         dSQdBPE+f7gHq+ingWP0VJ1lxGRzP2UHWkRqYn78f/nIYhFhLT3Y7h1i8dkrPWR9/G5I
         NBxvx/7d02+p+mCqtMa3VljO7IyTXfcbpUBVPOAgN+n2cNOmva3fZnX6wiFmzhzhyn18
         Vp9LY9jqgdsRHqVg/bCrEaEnCCFQcNJEsJCJFPqPRDQJkSHv908zyKz/QaZprPyEEqD0
         LxFw==
X-Gm-Message-State: AFq9FYIfj8pqyamKFRwWaJ3EJ2glvwJT1/tAenHo/FSNZXn6uLMsbPES
	c5lLq0lYDUq72rB6GrmZtq5zcxt3fQNgbP63LUprCd49emwimn6fMT8FM+rjT/KEjIDoCiMws72
	NQxJW
X-Gm-Gg: AYBFou2eWG8ctM7LMp28H49B0eIAJLoggzq2kHhvG9JF0yRSh21hK4CtIe08tVkIt5q
	OcuIZEjYFlPUeJtZfT+ftH6ATJ6fsQSqvGj5sBJg4DptFCoMoFRulul/GEtVKzfE9D7dVVLM1tK
	5p/kpUbXeD7diTLXO3/rwaXTOgF3+4ieFbFcCh8zl9htn11/tlijn3zLEfiecMci/nNH2zGZqgw
	hi1RBTkdwq9md/yW6lQVLxZTwsa3Cf8gj4obVn/x0/4ETytdg9QCihFYbfvAv+i+uO171gn9uGA
	uk58e1sn1UphDM99UXOPphvNOyLWWFkJ41uVYsBxzSbZdTbykKH3XqSqTyndbWEkFFWM3ODX5K0
	yLkDbHff6jBusRlvwR9NAxIM9uJORJbxUFmKN/AIqaN+7xsT9/9rPNaWy5p0RrRXlXjuP83CWcX
	PwBGKX+0IJDhlwJU8hu8DMMjqseRjIw1pl9D2tbxZGNVOyBkCqk+yAeHKKjCRGVBrbCGxD2g8FY
	buYpIFJNoT4rInS7hPv7cZqVe7HlX4lcgq5BQlwMdfZpG/7nAAvgSyajx8O0ItXFJiCQEesSPfF
	lgdu/7dyxTwKgg==
X-Received: by 2002:a05:701b:42d3:20b0:156:d588:c881 with SMTP id a92af1059eb24-16a0adc14acmr15455735c88.2.1791860273055;
        Mon, 12 Oct 2026 19:57:53 -0700 (PDT)
Received: from localhost.localdomain ([103.207.175.177])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1becefdsm34223721c88.7.2026.10.12.19.57.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Oct 2026 19:57:52 -0700 (PDT)
From: Shubham Antil <shubham@octane.security>
To: netdev@vger.kernel.org
Cc: david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	cuissard@marvell.com,
	sameo@linux.intel.com,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	gio@octane.security,
	Shubham Antil <shubham@octane.security>
Subject: [PATCH net v5 0/2] nfc: nci: uart: quiesce write_work during teardown
Date: Tue, 13 Oct 2026 08:27:44 +0530
Message-ID: <20261013025746.41292-1-shubham@octane.security>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes the NCI UART write-worker teardown ordering without
blocking the controller reset which nci_unregister_device() may transmit
during teardown.  It also fixes the Marvell UART state-publication race
reproduced while exercising that path.

Patch 1 publishes the Marvell UART back-pointers before NCI device
registration can expose the device, rolls them back on registration
failure, and establishes the controller's initial halt state before
registration.

Patch 2 serializes producers with the write worker's final state handoff.
The generic close invokes the transport close first, allowing the
unregister CORE_RESET transmit attempt, then blocks new work and cancels
the worker before freeing the skbs.  Marvell performs that barrier after
NCI unregister but before it releases private state.  The failed-open path
uses the same barrier, and the transport module is held while its open
callback runs.

The tty write-wakeup description has been corrected: a wakeup may queue
or run immediately before close; it does not run inside the close callback.
The same spinlock now protects producer scheduling and the worker's final
SENDING/WAKEUP transition, closing the reported lost-wakeup window.

Both ordering issues were found during an LLM-assisted source audit and
reproduced using a pty-backed NCI UART under KASAN.  With these patches, a
61-cycle regression run and a 56,690-cycle registration/hangup stress run
completed without sanitizer reports.

Other concurrency concerns raised during review are outside the scope of
this teardown series and will be handled separately.

---

Changes in v5:
- Preserve the unregister-time CORE_RESET transmit attempt by closing the
  transport before starting the generic worker barrier.
- Quiesce the Marvell worker after NCI unregister and before private-state
  release.
- Serialize the worker's final state handoff to prevent a lost wakeup.
- Correct the tty write-wakeup race description and close-contract comment.
- Take the module reference before ops.open() and drain work on open
  failure.
- Publish and roll back Marvell UART state through transport callbacks.
- Add the LLM-assisted audit and KASAN discovery details.
- Keep unrelated concurrency follow-ups outside this series.

v4: https://lore.kernel.org/netdev/20261006115532.72100-1-shubham@octane.security/
v3: https://lore.kernel.org/netdev/20261002055620.18339-1-shubham@octane.security/

Shubham Antil (2):
  nfc: nfcmrvl: publish UART state before registration
  nfc: nci: uart: quiesce write_work during teardown

 drivers/nfc/nfcmrvl/main.c    | 18 +++++--
 drivers/nfc/nfcmrvl/nfcmrvl.h |  3 ++
 drivers/nfc/nfcmrvl/uart.c    | 32 +++++++++++--
 include/net/nfc/nci_core.h    |  3 ++
 net/nfc/nci/uart.c            | 90 ++++++++++++++++++++++++++++-------
 5 files changed, 120 insertions(+), 26 deletions(-)


base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.43.0
