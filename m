Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793315868;
	b=FmuwhZEylFeeH+7x/GINMUamtJjTpZeJoo8zYSj8MvVttS4ptbiS/ij+ynLVq5Tf8LGr
	 OFt2WNuowXImMOaD7zjDv8gXfwuam3DefQSxQ+0rfAndwETE1PJ6mw2QY7hdOkTssCNbm
	 V/xDzcKJV5Xwom73KsoPg9EOa4Dqn/wZmUZhOM7XYSH6VVO9bh3PThzjZEfpLgOaiilW4
	 7Ix4g5TKrm2WmuThZ07WQQW3jAPPLT255FM1aAFdV9LuXXuL9x0JhuF/dFJCaYSEBrx5/
	 bmZ4lCY2mCMdHKBys8EHUeMMRlGciiLCNSPC0ce7emhP+skK06yPir3EF+DTa3mGFrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793315868;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=SPEnqdGMpTzdZwWJhFlJuppIlSs2KDhs9MBrZg5NKrM=;
	b=Tn11CQTI0UhFthxtyd2afl5z197FzMPJf/doFp26+ZwR9j5YyGc5+kdjJ59krv1s09am
	 GjYfqrsrs6hMvd/M1FmbULrTrUaPqH8KjKdqATcBPO+mMFITY+36IoSV9LKBJab2Q/imw
	 NRmU83B17/hW1YubtUlB8d5OTp8mmrAETymD6YMkhXFvAIfseaWLIHEEUVBYTikPWyN/3
	 OacGxNCUfcZxocfYwCggQWyPfpzHGZHiQFCg5f+WEvoZni7ZmCiBFuPk03hbRKJsUU+/8
	 yNNJpGWddRy/HhwI50RTkOLQnprDs/YiBXzPmDjqI0zOR7ttflQarixBO4hKIBZU7Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JgtgeSBl;
	arc=none smtp.remote-ip=209.85.217.48
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA20606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 23:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBA20606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JgtgeSBl
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7cc7938c5e9so554353137.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 16:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793315867; x=1793920667; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SPEnqdGMpTzdZwWJhFlJuppIlSs2KDhs9MBrZg5NKrM=;
        b=JgtgeSBl1A7EroYa9zlcO4q0XImL4eeq0uiOQ2b1D+m1V0uKjVyJcBYS5048FZ1L5T
         k1aWaHOiNeL63eNOHDtyvvSLIE+b/NWquOve2n9Mbm4aMUSjP/RFZtj3k66C5xfxrvdC
         gz3Dq5w3PNbWZTsQF3k3OLcoWKUvMMK0zc8/woQF2wgrx/r4XwZVEraLlejkW8QqUzKe
         SKBI+WVYxptAPkhMlXaCq/r8fswAkcDbVmfPIRmlFqb5Xbad0Y7ObPEv9OSkvoQASpF2
         ZPNe9b7e6BtDI/3Q5S74dtF9vqaaRimjVbb8xYcC3ARaHnPGk8IJB3n/QXsL4st5jnD9
         JETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793315867; x=1793920667;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SPEnqdGMpTzdZwWJhFlJuppIlSs2KDhs9MBrZg5NKrM=;
        b=Ms3Iw07eSkSPNe39d9wCbMlJ+aiog6CER00RLzxgkc1N7DOtYDQxEdnrJOoVfrGLML
         PvgnjeORtlwqFUm8RSkkq7li9Smyt5RfPDP6SrTIVTmCCpnqsf9R2uKk0bgdQMeuQ9iB
         5jO+OGR2E8p8pyTbwGRVCKsIG3owqe4uUFrlY00q8Wi5T94jIX+E6VpiWBwtjs4DI0PD
         OIug6csW/axDdXat7E2rT46tBJSesDQ8hRSh8x5W9ymb3/mKRwRQw4xRh65Zk5wopbYo
         r/d37PdYrtwJBrtA7BQai43QMsWSua3z/sLQEI62NiN/5yNkc3feHwLRi6lOKkHAZace
         m5jw==
X-Forwarded-Encrypted: i=1; AKwUvBx4Y2PITUeLNqvQPQDm0CFSlnl0niQxhrKCqklfcPAAOQO2s7jkYPChjmrDH+oWJYQ423FxQnU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLhkZzE/amwOovuO9RwB5YfdrEzabjHsqHCBJLBPGb8iNY7g4Dl
	bVa1w/+oxvCVP7XFPvazIjUKzgMX3AaWr0zhinosUMa8vs/bax1UNLI71UwazAE/VV8=
X-Gm-Gg: AYBFou0F1oJ5dZ3N93J2emeT8/WV1062UfQODMhQilzoST8BeoJS+Q/RDtiTGb+goNu
	03NVS2F2zREf574HpuG5PSFq4x1I4rwaNhej+LiBMdA+n1AyyZu7QvaOpOz3l+baX7DGeO7SpGd
	PJLtCHuikqiJ2okEJaiAABCKD/xLy/z6DJkxHDnV3tTfwIU8nMmL4ulkhcfpXyTrWvcB9BOpyBN
	U0UMRB+nEJHFlzDUYCp4RjPyzWAJxMzby3T/2izKzM8QI8rbCHo1z+FxuVNogyCL28gl8LOtQ9R
	j+0qjds9NPyIUuvLvXpIqld9dLn10qCXKLwIu3/apSAP2sNltYktpXJTR4zocN4Pk+ICZ+pGPyS
	RK6io+zPmSH7U+5L5mgDV0AJ0JKtGpmzn0iuFHVMlwV59+bFf4ixGfKUhc6Y95d1npMGOIA0X5p
	Aj6f71WfdrFoKhbThKzVAWMlMf5baJVe8aIdYtk2lMg5AV58cpB4tn5TdZMQSQmc1CptLsDhXAo
	si8QN7NEdeFNdkKGb7USnmjuc4jf1F2EtOFYO0AKEWFmEKLN+yw3TL5WmqZm4/Vp+p+qvWTV/te
	yF1uQ2Uoge/ZlmhTKqdr3ydwcvXs8lR6INLEsiqnU3Ka4xdviFsPCXnVdFekqB5lsKPcY1fbwVb
	OwdVS/AJCUIQa
X-Received: by 2002:a05:6102:950:b0:7c2:b741:2391 with SMTP id ada2fe7eead31-7d0542f8019mr1629209137.30.1793315866785;
        Thu, 29 Oct 2026 16:17:46 -0700 (PDT)
Received: from [192.168.15.16] ([2804:1b3:a2c1:77a1:5cd:8fee:f3c:4da7])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-992ee4e7453sm319509241.11.2026.10.29.16.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:17:46 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Zhenghang Xiao <kipreyyy@gmail.com>,
 Sanghyun Park <sanghyun.park.cnu@gmail.com>, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 [PATCH net 0/5] nfc: fix HCI over NCI and NFCC loopback response handling
Date: Thu, 29 Oct 2026 20:17:35 -0300
Message-ID: <179331585573.30322.4049957541187612575@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Patch 1 fixes a regression: since commit 8265a626cc14 ("nfc: nci: fix
double completion race in nci_data_exchange_complete") every data packet
received on an NCI logical connection other than the static RF one is
dropped, because only nci_transceive() sets NCI_DATA_EXCHANGE.  That
breaks HCI over NCI (st-nci) and nci_nfcc_loopback() entirely: every
command times out.  The commit is in mainline and in the 5.10+ stable
trees.

Patches 2 and 3 fix the handling of the stored response in those two
paths.  conn_info->rx_skb is never cleared after the response has been
handed to the caller and freed, and a request can be completed without
a new response (an HCP event or command received on the pipe, or an
unrelated NCI response).  The next command then reads, modifies and
returns the freed skb, or dereferences NULL.

Patches 4 and 5 bound the controller supplied pipe ids used as an index
into the pipes[] array in the st21nfca and st-nci load_session
handlers, as pointed out by sashiko.

Testing:

- Patches 1-3 were tested on arm64 QEMU with KASAN, using virtual_ncidev
  and a userspace NFCC emulator, plus a test-only ioctl in
  virtual_ncidev (not part of this series) that drives
  nci_core_conn_create(), nci_hci_dev_session_init(),
  nci_hci_get_param() and nci_nfcc_loopback() the way st-nci does.
  - Without patch 1, the response to the first ANY_OPEN_PIPE is dropped
    and nci_hci_dev_session_init() returns -ETIMEDOUT; with it, session
    init and HCP commands complete.
  - Without patches 2/3: slab-use-after-free in nci_hci_get_param()
    (HCP event instead of a response), null-ptr-deref in
    nci_hci_get_param() (no response stored yet), and a
    slab-use-after-free on the skb returned by the second
    nci_nfcc_loopback().  With them all three return -EPROTO, normal
    responses are still returned, and KASAN is quiet.
  - tools/testing/selftests/nci passes (8/8) with the series applied.
- Patches 4 and 5 are compile tested only (W=1); I have no ST hardware.

Sanghyun Park's pending "nfc: nci: Fix conn_info use-after-free" v5
touches the same functions in hci.c (it adds a NULL check for rx_skb,
but does not clear it); whichever goes in second will need a rebase.


Joas Antonio dos Santos (5):
  nfc: nci: don't drop data received on HCI and loopback connections
  nfc: nci: hci: consume the HCP response exactly once
  nfc: nci: consume the loopback response exactly once
  nfc: st21nfca: validate pipe ids in st21nfca_hci_load_session()
  nfc: st-nci: validate pipe ids in st_nci_hci_load_session()

 drivers/nfc/st-nci/se.c     |  8 ++++
 drivers/nfc/st21nfca/core.c |  8 ++++
 net/nfc/nci/core.c          | 18 ++++++--
 net/nfc/nci/data.c          |  9 +++-
 net/nfc/nci/hci.c           | 83 ++++++++++++++++++++++---------------
 5 files changed, 87 insertions(+), 39 deletions(-)

-- 
2.43.0

