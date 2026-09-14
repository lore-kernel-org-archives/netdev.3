Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7436E3E5A0E
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 21:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789422156; cv=none; b=D+v9DWsSqQCI160v3SoVS7Q1I278EnnSns+J3yhfflmaKgSvLgOe11mYK7nkPOMge9+/vMoQHPA6edsDuBKThxj1wIe94Ds0EKPBKFZWiE3xL2ebwmxBK0Gd7G6FHFzFwLeFw5rpnHfOzxVOGV9lu67lkOB09zXcbPY3opBT//s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789422156; c=relaxed/simple;
	bh=UjKqshOgpHAIYZEjD7N5AWSfVp/EWOQyDAkiSAYlr1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cXKQxCwvrxuw8T9x0BNtgmwK9g0c9N6J3RXSazMqjVyG60qKRLuM7BwoTxQ4wu28pyr1f7INwBNiAh+XTOJw/ZZHJZfV+QiRcWbaJHoZBPFaGhO7g75oHV0KdRWm2frwWlQmA+mTZmy6VLt0vSUEhTM8YzHRzF2nIpBBZiHSDfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWctVKRN; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWctVKRN"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66f943b286fso2178293d50.2
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 14:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789422154; x=1790026954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uxYinkEwssvzjFVX2u1W8zfXk4d57rfWa+loWk5wyes=;
        b=GWctVKRNs9W0DaAjVznpopk3XqDPDXwfCmrksi0LJIiIzAmyS0pmV+bfujcm4FnAZp
         X1lVc8+gm6Siotyry1cgLHIPuBWCJWavB12IIbDOKsaZTVT/Xn7vzpOLtU917qceuuDn
         pJ/z/h1VLh2OTinmyHAR6r0Vn7o0TJ5m1NH6CDDQcSSlB8tW6qnA8DLDvkW8cS4tdvFL
         X8VUdO8CKKeEZxHLOVb3ifyh9LhdiavB6/xPwA5MXt7my878kqwvu70u3IGBbFJYgvOi
         n4ih/gP7dWlgkO6OkZFWlnZpptgQ95xUa6aW8Dn0cy+oBqCYoPHvAMWD1wBvBLZwu6hZ
         4hNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789422154; x=1790026954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uxYinkEwssvzjFVX2u1W8zfXk4d57rfWa+loWk5wyes=;
        b=0PtXSZdyCkhEERLxobcxljBmlW8pulkA6vc72E8E4vbY16UCIawbwVX08Fp2qDcsTE
         zfeVyOVF85Qce7OjiopMpLEWaNu0yXkx8kjbJJfh/UxaEjWTQLS2/YYY1qaUCFQaqAcV
         NnFPHnB4tfiSbCsIMxK1bZba9KqieVmjAkRvzbMzu/Mwtrn08rwa9IUVFKd9wEAtdcW8
         oLcE5Pv2HLtOTG1Y79A6BtaxCXo9f4pv3ZuxhsnPhqo+dzK+ESL7e6VaEceM/mxgj54S
         Sf6jrtTrhh8QJ8NL6aeYgu89LTKtbP2oHfLYVWuAgKAVtTq6pPKxS8cqaM0UjmbnYikl
         +I1A==
X-Gm-Message-State: AFuF++kTd6oFORKkOAgYpFOyMdQLzxn5D/V3UPHUcC/7djS5mSfFM60I
	TbMDug3mgEPQsZEyRdJ+HpTxGv9Sp49Zhz8vc8rLHvVqJqar9eLSHxMXyPjdjQ==
X-Gm-Gg: AYBFou3WSpp96XZ2Yn9A6IGwY9eqIDBAhAumJdw6xqHGY9qaOGLeUeYt2/Uyb7ARkul
	hQYX2w8nwlkvLsah3PIx56QQPXnWRgVqzSCrhifPwhupFN4410cKYcj1ZH0BOmzdIBfQuyXt/u2
	vkNg261QlQ1nget81X4tqiIFPQVppe47/9xI//tM3qKKTtcQZDi7WftV2OGHoj40RxipL04/WDM
	0iCSj+ZohgRNMONIKJR0MtRr5yQEAxJ0Dua2li7t2AyEVZHQYFI8XvT3mSeSI6Y6tJHJZCcu2tU
	+jIbISJJMsX1Hwgp6SSLxNZQn0fFaszL7xoj7ktVVKCYt+AjWxuvfvsqgqsDhptMuYOHd9bEqRr
	ck7Ys2c5OH1RQ5deLr+d5Hxuwkkcwg3Guv6/lLvvC1qSStTex5uKlMO3oOiGAujkoC+Ppn8Fxn0
	D645L3iB1Jw3Lka5pfBoGbJSgY6fDNixk3sJWBljVZOlV5BYo/0nsr3EZHLKIqgEexLKzpwzenT
	En4RYgcqKcZn47BfImOOTu8ilI06qsfB4u02vKIRtBFJ6SFU9al0/Iqb88c1HU8d8mnsFmIbhU=
X-Received: by 2002:a05:690e:43c7:b0:671:1ae4:995a with SMTP id 956f58d0204a3-6714e03f648mr1095906d50.29.1789422154414;
        Mon, 14 Sep 2026 14:42:34 -0700 (PDT)
Received: from willemb.c.googlers.com.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-88486086224sm41718997b3.10.2026.09.14.14.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 14:42:33 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net 0/2] packet: fix PACKET_TX_RING data corruption on skb_orphan
Date: Mon, 14 Sep 2026 17:37:41 -0400
Message-ID: <20260914214229.1674102-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

When transmitting packets via PACKET_TX_RING, tpacket_snd links user
ring buffer pages as skb frags and releases the slot on skb->destructor
(tpacket_destruct_skb).

skb_orphan() invokes the destructor while the skb is still alive.
This marks the slot as TP_STATUS_AVAILABLE prematurely, allowing
userspace to overwrite the slot and causing data corruption.

This series fixes the issue by switching PACKET_TX_RING to standard
ubuf_info zerocopy completion, ensuring ring slots are released only
after all payload references are freed or copied.

Virtio-net needs a separate solution, because deferring the release
can cause deadlock in its !use_napi mode.

- Patch 1 addresses the virtio-net special case.
- Patch 2 converts tpacket_snd to standard ubuf_info completion

Patch 1 must be applied, and backported, before patch 2. Both carry
the same Fixes tag for that reason.

Willem de Bruijn (2):
  virtio_net: copy zerocopy frags in start_xmit without NAPI
  packet: use ubuf_info completion for TX_RING packets

 drivers/net/virtio_net.c |  7 ++++
 include/linux/skbuff.h   | 19 +---------
 net/packet/af_packet.c   | 82 +++++++++++++++++++++++++++-------------
 3 files changed, 63 insertions(+), 45 deletions(-)

-- 
2.55.0.1032.g73a4cd73de-goog

