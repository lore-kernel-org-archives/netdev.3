Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0C63612F3
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 02:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946407; cv=none; b=VWbj1bVc1ksGbgHAaDj25Vgr+0XHzFETklJ2dEj2Jh9IWITicwC9iMHOcGGQY2t4CVk7oHEVuZjiZb8ufNoguD6m0B+WYtjiy6D8G0rN6LAnfRwodam30zc8Gbk9uICBQtvzrVjxqvtypy6vvHPdcRicoJAb7LtKfLD8vov/7KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946407; c=relaxed/simple;
	bh=21pyKGK+IKg/zTXev+HEz90+q9KFZmImFzV+iA62bcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XemsI4oOlgRwGRIr4xn8cAh11v2ubdHdDIDafLZg0GHxD9qpkWDlVodXGaoBwZzhAPSV7cbYee4X8W7p4Ab12e6CYqmuz45AUwDD69ArBfltugfVrDK6fbhpSr2MMyCD8q7aIizTWaMGG1FrTx2wqfBkgGNqiS1Gnz3GS0xNv3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg; spf=pass smtp.mailfrom=gt.tech.gov.sg; dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b=KUF0FXw9; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b="KUF0FXw9"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3535a54bed9so720185eec.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 19:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1791946404; x=1792551204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oY2fKx8mXWxNmYV5ihzs1KI0duZG3Xnqm3LRIyGvrJU=;
        b=KUF0FXw92jXFptAE5i8/1mzTQvnyqKxTbcLrQYlwi4zXVdVyTcDdf9xsZcVzH6JsSu
         7Mpe63/xZ0RsYzLZMfjTZ0FmsuCIO5/mpEEGQgLRAhAYGVT6mRKWuqMY6nFLEVl5DvE4
         1N3pE69QFJtdIY2On4zA3sW4Jq5x0nqfJdnl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791946404; x=1792551204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oY2fKx8mXWxNmYV5ihzs1KI0duZG3Xnqm3LRIyGvrJU=;
        b=ajFlERX4dtnDUH4/FN1+2a/2TM2sRz2FIg3YmuY/0kEKLPcnQOH6XW9WusDaQ/FDHf
         k8G0G3rfnCYdEK8fox8BZwtPjc35W3wHdpfu+FreAye8iXAdBBXjKhqC8UjkXlkFb+oJ
         Xut5zihMj9SUgWgZ+l8VHNkdNkKyRYlCu3hT2GSke4KhN97Xdllua80pni0KXMKvR3I+
         F3riL53TL/5U93UtDNbW2y3E9G6R6NpIYeRi9K6uZvFl6omwid202kyg+nK3WCrIPX14
         /9gcv4FBiXydwdY8RZAYj2qUuVOCdSRYAsm+8omIs64HHGPyjOTEZdR5whHS6mx+yHPa
         a7xQ==
X-Gm-Message-State: AFq9FYINAhqx6FvRPfyYYVdaIoJ7IAK3ozNxzp3Q8M3GVxg0pq7ZLdlW
	/WzHZ5bLewYgOCKdwW4cKRSfPC9do5n+f7IyxfWF4MNbL83MV2tissP/xZzigxETJ0E=
X-Gm-Gg: AYBFou1w2zUiS7aq1Rm6vvzMPXAEfmaveG+/fREK4b9/9QrFzENb0uCdOwo1o71QOwK
	Zrg/CO+0RltffWvW2Pm9ZLkunBpb5wr5aPyUdk6mhD6qM9C8ahNLx3Qu7m2RkHJMpc03cpUGRTh
	a99OMCNFZPK2KK18iyHZ/b5oYbYvUsDu7gMKCf8ZEYhR+DsUpRySN8fJp9Rae2e53l76XNgLIjZ
	BXTMOstgUBep2aMewmOMMDdip3/lRHfx/wKhElAAtyF+IULvJXapMXwuQY5ZXjHyO5K6aJbM8eC
	05kucYELpLTzA1HOB6Ehsc1PowAYmquUs7wxc85wRgylFzD4JT61cmgrNI7LbXZMo2IDAzIsnlE
	iQBWAH+9ch8cjbg5y45O9KkXIP88k1VBbRzT3GTP6ba7GvyuzBLvCCuh5UdiwWqycHu81VlB/ue
	dmfEQ4Oc7nnjCFktnPh0UBLQZe/0M8QLVATrZCQlJe2YkPxFIdv13UJQsI9z52hQ7Kg1d6NpkKa
	wdW7YD8+trx1aK+tZvaATMPLcw=
X-Received: by 2002:a05:7300:8256:b0:35b:782c:aa29 with SMTP id 5a478bee46e88-35b782caf17mr7301083eec.33.1791946403882;
        Tue, 13 Oct 2026 19:53:23 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([129.126.57.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2fd33sm46522557eec.28.2026.10.13.19.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 19:53:23 -0700 (PDT)
From: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
To: Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Jie Law <98lawweijie@gmail.com>
Subject: [PATCH net 0/2] net: usb: pegasus: fix receive length handling
Date: Wed, 14 Oct 2026 10:53:05 +0800
Message-ID: <20261014025307.25233-1-law.wei.jie@gt.tech.gov.sg>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two fixes for read_bulk_callback(), both reachable by a USB device that
identifies itself as a Pegasus II adapter.

Patch 1 fixes an out-of-bounds write: on the 0x8513, every frame that
is dropped because of an oversized length field advances the receive
buffer by two bytes, until the host controller writes past the end of
the skb data area.

Patch 2 drops frames whose claimed length exceeds the data actually
received, instead of passing the uninitialized remainder of the receive
buffer up the stack.

Both bugs need a malicious or emulated USB device, which
Documentation/process/threat-model.rst treats as a regular bug rather
than a vulnerability, so they are posted publicly.

Testing: the series builds without warnings (W=1) on net and passes
checkpatch --strict. It applies unchanged to v6.12.105, where it was
tested on a KASAN kernel with a device emulated by raw-gadget +
dummy_hcd:

- 3000 frames with pkt_len 0xfff, then 20 valid frames. Before: KASAN
  slab-out-of-bounds writes and a general protection fault in
  skb_release_data(). After: no KASAN reports, and all 20 valid frames
  are received.

- Five each of: 1536-byte transfers with pkt_len 1534, 1535 and 1536;
  101-byte transfers claiming 1500 and 97 bytes; normal frames.
  Before: all 30 received. After: the 15 that fit are received, and
  rx_bytes matches; the rest are dropped.

Both bugs were found, and the patches written, with LLM assistance,
hence the Assisted-by tags.

Wei Jie Law (2):
  net: usb: pegasus: do not advance rx_skb->data on dropped frames
  net: usb: pegasus: check rx pkt_len against the received length

 drivers/net/usb/pegasus.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)


base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
-- 
2.43.0

