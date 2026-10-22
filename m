Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660475;
	b=TrA6Q3YMHkcLTVJsUfuz/S80iQ4IAG/ayEY0xzdZb67EZK6kDeG/AA1Nt5U9pQNbhEJY
	 mz3BuAYChUuqw7wSg3etlKAc0dEGi8QLwyWFn1Z+uxZsyLyNa82BqX3qfPVTbrrbY3aZ+
	 nT9mMUDIDL9eEOO6NOGagfDN67j2S4hHOeicayJxqlARdBhmgzOHygmQtpgzMDIvpVnS8
	 M8QmqTsuPXE/V3nOFVZBKA/k/orCV0ZjTM/9ud7yzybWRCw38DGP8yxHMuU66CKEVkYCr
	 BnL9DH0fRbdpH2KGG3mwiWN05Xc1fPkNzbOrnemS/6PCLnvgsvcHjz2bDjjumu2kpgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660475;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+FdxbDW163sXl7PSrtKq2x3hScBeEWK+b0ZUQ8/Dwtw=;
	b=axtubDvReF5/IwHLafjiH/IPRm1Q5wAF39GrHi1LbCma3mUeqM4194We/HoM8pTkPtPX
	 9aRaKQBQUiQWhkh4MosLZ1K95xVacdy0lg2tsImboJY1fEEmdeZIvQj2w9VD8pWMwGWt6
	 QB5VmH4jUtDy9wD+5rlZ2NX6POYB4rVz1SKdz8FSeBjyntbNR7LntnjzkN8ncM7fSs68d
	 zzs7xHTAPSBOFiHismiq0V4gf9OFfZem6fL2Ct/j1aCxxxzr+DM5P655x1MGAV5IKzU0k
	 vxxHWjMNO7xR6fiuD3jNQwceEHZ9w1oATWDtpuwlmGXibz0GBrb405EpRYzCcDvU3DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=laJovtXn;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0165606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0165606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=laJovtXn
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33fb4680717so3990923eec.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660474; x=1793265274; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+FdxbDW163sXl7PSrtKq2x3hScBeEWK+b0ZUQ8/Dwtw=;
        b=laJovtXnSYFUn2fHAoo9hWJWxpjWrfAl2s7kwQSMXaYBwObYltX7rx7y040ej7nREH
         PLwyGlaBZj3720EWPYkuj3GZU5VUCwfr+f4EmF1XBWXDiFOMgHsv6VeBXljb/tptahtx
         DdDQyOOhWljYrsKPRM6fLg8x0X1EogYFtg7kg6t+38N57AMking25uAwArcZ+qLqLgXm
         vFY0wj09bUfnY1Ia0Lc9fgoqgtr+fMorLPnnC0KNQ/CPYf37HbnGMQIpGxOo1xxtnG8x
         Dj5SV7yjIcH4MVaOBPy1ZlqdkrLhSUrGRjFZuznMfZEbLeuw5KFCBhaEScsdROjKU5gD
         hK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660474; x=1793265274;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+FdxbDW163sXl7PSrtKq2x3hScBeEWK+b0ZUQ8/Dwtw=;
        b=Dkj45HZFqbRAgRCxd+sOSmJ/eFgnIWLZvd5KL1aMSV1Am/tiKy4CLnpBmgwJnqCb03
         5NmoGpEpD2ZwuvsPu/WMS+ECYlN34R9zIhspK7lLbr9Y3ow1PovSM1SOkZ5Xz3StpoVd
         w5PlvgUwX1y3A0z0PwEmzK/BFL/AfQ4vRvNHDItvBTLM84kKBssgeYrPSXRxLUHsU+40
         0yLpuHZ2yxgXjWpoctNbHHIY5IXc4exVX+YeAwB4R74nJp20s0vJncyLmmc20YjFDaZ4
         IIBJVd8Rs1q9JBXFpZF2ALc7kYOnQzXgmj3vlN8bJ2QjKl6CUaW6txRTfN4vGwfYu6kc
         QKbQ==
X-Forwarded-Encrypted: i=1; AKwUvBxX/Kh60vI487gw6zsQIRPpyOPYTXNl65EzQJj+GolK1bcsNo9C9FnOYKUzt74MqWWo+jP2Bxs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJoHZha33/YT9wm+nn/pFftRKZV5G7TWe7cVwVQmXZXhjkSr1dV
	CoitlLIRKKVcIcdvlUY3sBDW/8AS7eI63uNru54mIrwcGIoqrachhlaO
X-Gm-Gg: AYBFou0Xe0OJcDcJSG/ZZ0wTkpQAYxO6pqoCAvHh2NvdkSgr67dHK85DZzWBoGfFpkD
	tM2WC8ukNMepK3g3ipls7v2khj6wl5O+uJ5gf3Yppw3ultehLxAij28al1oj0sdFWxwLv5oKgY7
	HnnfcBsrV4r0hCzVPfC2HMGrAPMy3sWBA2h89kkZHMAIT2uqIKgQYgDXkN3PP+Xj/VBYHVTaUho
	uaCGl5HOTEGJTlY0FsKQs+N9czCEkhxa1pCBSSNMGm3h1FLBQJ4LmFHPX8uLzUnVkIMys2b0x6+
	XbYRbXLfEd3iz5lISnzuOPhMeyV84yOhVsJ0l+0K76gn+jPMRRDNKK0wCCEGmWJglJ6NlvUoPd6
	lbcwh37tEbGBPGo2BEHXfIjzBo5q8UG+cjWtdD58sR92JegPuvOlM0R7OUk/gR2y4V8jXlRklum
	T+2KrJHslAbnNIgxABugoKxeRwxeC+nwND/sGboIGEh/J26wFK5mx/J9nLmZRD5jqNRSBvcEXWC
	lRX8RUS5FXFMDzh6XXrn/mZpQsagpz2+3Tazfsm0AgZyTvD43lu35aIAKrO55h9FfagkWDA7TBV
	GvJV5SpildR/ruQs04eKTlSIsTB3pL861qzcrpjq
X-Received: by 2002:a05:7300:7aa5:b0:360:8a6e:640f with SMTP id 5a478bee46e88-3674e64d8ccmr5989884eec.39.1792660473992;
        Thu, 22 Oct 2026 02:14:33 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367416a1fb9sm12845003eec.20.2026.10.22.02.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:14:33 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: tun: queue detach leaves stale flow steering indices
Date: Thu, 22 Oct 2026 02:14:27 -0700
Message-Id: <20261022091427.3650281-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

The TUN flow-steering purge after queue detach does not remove all
entries affected by moving the last queue into the detached slot.

__tun_detach() decrements numqueues before calling
tun_flow_delete_by_queue(), then uses numqueues + 1 for the purge.
Entries recorded with the detached queue's old index, and entries for
the queue moved down from the old last slot, can therefore survive.
TX flow steering subsequently selects the wrong queue fd, or selects an
out-of-range index that netdev_cap_txqueue() clamps to queue 0.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1, with a three-queue TAP:

  learn F1 on queue 2
  detach queue 2
  send F1 reply
  tun0 selects TX queue 2, but real number of TX queues is 2
  packet is clamped to queue 0

  learn F2 on queue 1
  detach queue 1, moving queue 2 into slot 1
  send F2 reply
  the flow is read from queue 2's fd, not the no-entry baseline queue

The second differential directly proves wrong queue ownership, not only
the expected clamp warning.  Candidate BR-027 is the same off-by-one
purge root.

The detach path should purge both the old queue index and the moved
end-slot index, preferably before their meaning changes, or rebuild the
flow indices atomically when queues move.

I found no matching upstream fix.

The PoC and complete program/console logs are available on request.

This was found with a multi-agent workflow; the
behavior was reproduced in QEMU.

Thanks,
Cheng Yongkang
