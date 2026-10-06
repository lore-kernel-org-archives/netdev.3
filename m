Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A67A25C818
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791287741; cv=none; b=tIE4tGMFrJo/dsQ6BmsEc6XO51vmoG4ahdE/Nm8D4neaAgukGRqScb0gSSVQaQiCRYt0lNBr0cL0bBABlfO5x9yHf6Ku7F8+SuaRjoiyQqckroktsA0HRKg9dK43t0SxQcM1WES1OqEq8JiBiRXThXrKSehNA+xRYX8aEa++4D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791287741; c=relaxed/simple;
	bh=kXgW3qjo3KY6zHiH5OrCddi50NW2IkFEEVqHnddhBTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bWdK5I89MH/2OfX9YnrG1pNrPcNbgjhrq323svSNz9pwfckAZz5fBxkB6W0pMZdSjHBrcdVDhhpW2Zg9Q5BURhNZLCnZGGDgUROEEEAFsF9Rm0Hd40UehuDSu1zefpVbyDGDv5ykDoSEcWRVsBLn0r2BC6TFZWKfMRfvjLFe62A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security; spf=pass smtp.mailfrom=octane.security; dkim=pass (2048-bit key) header.d=octane.security header.i=@octane.security header.b=Jc7flFlr; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octane.security
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=octane.security header.i=@octane.security header.b="Jc7flFlr"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35120d43ecaso3975488eec.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 04:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=octane.security; s=google; t=1791287739; x=1791892539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=84Dq146BpPlH5Vbiz9syfTsSyl6UfDOj/cgMWw94ckE=;
        b=Jc7flFlrFsOL+rxAAQN1qcfPTdf6eoHOSaJezx0s6kU1O7Ln5ve+mLq6UbVCy2tTyq
         EExAf3Kc0SL60VA4GSvYhVzcTLVLVMAXeqKs1M2ONXL8+/Bcdo7JUqVKDyBsIejG1pMw
         vovYoLEj8NRWFm5RPYnWF4lLY2rLIyjz+SlHe/Ume2HsxZ7kCON32td+eSdcYG/3A73I
         qmvSjjVDC1+HTNWPNBgo70QL3C0PfgWP5PMBDq2hu+cWPGzzFqPrWGysTEhr7z/9pOzG
         ATdzTKZOqvj7u3WBM3F3sU/zQ3vwz4T2XHQWPdk03F5Up4e4X9Hq8OXdouHz8jzzR25J
         Tg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791287739; x=1791892539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=84Dq146BpPlH5Vbiz9syfTsSyl6UfDOj/cgMWw94ckE=;
        b=amI5HEaUucmL3ZNL5ggKqg+UANZLCmMV60oJqR+0/bARymbqve6SB7DTMa4KZ94EcQ
         eMCo1buLRqHUqTK8wgyREMOk6plWsKKAVne69E7bLwecfj4p3QK8DD+oRwdRfWeier5p
         /ZOAx8Tlel+jqO/OUsYIlZUberubUoRBwuObnBF1h9DVZ/663/G0RZudOOvbXhP8uUO2
         OTTei2P8KyyH5/fWbLPasRARDWlKf+C3FHf9WyvPxC2whqJziSlka5BbnGBN443xV1UO
         o3ffSRV++q9l3XWJxZBnz6Ynxn6v47zzd5C1GabEpvh2sh+0tlxBn77zRUQKqR04kipR
         fUeA==
X-Gm-Message-State: AFuF++lGJx7BWtS4OkfjYQOYT4mSn1+KZHRvB12gcyt0VtSw8EAl8JnM
	6t81LM5XsaxYm6t2ZG30k/KlTaAmasaxQm9LOSB5/JZGMUjbI2iyrGErge6L7qN0BmrgH2qXfTB
	KFwuV
X-Gm-Gg: AYBFou1jeqI+jHFxfhwnq96lOPgSN1vnhLx0BtMh5U1VqrZjRcNs2T361sgb18LEIyz
	qMwidZ8TMyTum4KqxY3wazk53LXim3aqutUIWJtBq9Lbg2MSbf3u4nS4U0mI3BFttEgNII3opjl
	RNN2H6ReW8eGiDSWTm4ThCzidVaxLsLLRtRt+i+KTrg/I3ldxUK6jzMSkhiU9lp3HJ9/QI1IFAA
	1J4fH02eTmSIFhlb4ogH2uDw4xVmT7xyJsSQleD27ejfcBkKSiMp/xvNe5Rtk5xNeOx9uaaJN8Y
	JJg9MtgqMPdxt2af6TpPE1k5Gfe16zsBL+wzEC/2getqmJY5chmjI+IDaKrb4//kSiaxbTJjvTw
	tIfUQP8TLjk4Y8CKKSME5fa2aMshSs69esnJScsW/8wGxGSWDKKM5RMCQtE+TXQvhnJLZVfZLwk
	eryc1fLrNd6aoYEfaETxyTpGSqENW6ImtDjn+r5MyBErO58xwI3FpByyJqYDfYEjwF/AnPXSd/l
	3RFj2cxOoBpKQEiIh7WaU2QGmHndxwnmbLo4Xeam6RJVbtnEoWK45GBjH30tX5797Kx80b+s9w+
	2Rfd0rBlUl/F8NA/QCg=
X-Received: by 2002:a05:693c:4159:20b0:345:84eb:7153 with SMTP id 5a478bee46e88-3514df99528mr1348121eec.11.1791287739230;
        Tue, 06 Oct 2026 04:55:39 -0700 (PDT)
Received: from localhost.localdomain ([103.207.175.177])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351469f75fesm8638511eec.5.2026.10.06.04.55.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 04:55:38 -0700 (PDT)
From: Shubham Antil <shubham@octane.security>
To: netdev@vger.kernel.org
Cc: oe-linux-nfc@lists.linux.dev,
	David Heidelberg <david@ixit.cz>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Giovanni Vignone <gio@octane.security>
Subject: [PATCH v4 0/2] nfc: nci: uart: fix write_work teardown UAF (+ nfcmrvl drv_data)
Date: Tue,  6 Oct 2026 17:25:29 +0530
Message-ID: <20261006115532.72100-1-shubham@octane.security>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a use-after-free in the NFC NCI UART line-discipline
teardown and a NULL dereference in the Marvell NFC UART driver that the
same change surfaces.

nci_uart_tty_close() frees the tx skbs and purges the tx queue before it
cancels the write worker, while the NCI device is still registered.  The
worker can therefore be re-queued -- by a tty hangup, or by the NCI core
still sending through the driver -- and run against freed memory.  The
fix follows the Bluetooth hci_uart ldisc: gate the worker on a readiness
bit under a percpu_rwsem and drain it under the write lock on close.

Enabling the worker that way means it must be enabled before the device
is registered, since the Marvell driver may transmit (firmware download)
from within registration.  That exposes a pre-existing NULL dereference:
nfcmrvl publishes nu->drv_data only after nfcmrvl_nci_register_dev()
returns, so a transmit during registration reaches
nfcmrvl_nci_uart_tx_start() with a NULL nu->drv_data.

 1/2 nfcmrvl: publish nu->drv_data before nci_register_device(), so a
     transmit during registration does not hit a NULL nu->drv_data.
 2/2 nci: uart: the teardown use-after-free fix; NCI_UART_READY and the
     module reference are taken before ops.open(), with shared error
     labels and the tx_wakeup trylock comment aligned with hci_uart.

Both are runtime-tested together under KASAN: the unfixed tree crashes
within the first iterations (slab-use-after-free in nci_uart_write_work),
the series survives 56000+ register/hangup iterations cleanly.

Shubham Antil (2):
  nfc: nfcmrvl: set drv_data before registering the nci device
  nfc: nci: uart: fix use-after-free of write_work on ldisc teardown

 drivers/nfc/nfcmrvl/main.c | 17 ++++++++
 drivers/nfc/nfcmrvl/uart.c |  3 --
 include/net/nfc/nci_core.h |  2 +
 net/nfc/nci/uart.c         | 80 +++++++++++++++++++++++++++++++-------
 4 files changed, 85 insertions(+), 17 deletions(-)

-- 
2.43.0

