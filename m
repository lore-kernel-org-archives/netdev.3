Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814224;
	b=xoKsQKMhvbY9fzrAc4CI1S1AnRZvxfsCKxP9rd+/Epmas2ZdiYoy0c7LaV4k3tRElGea
	 QeLLGJnBKzhqezrIQ6X+pg3doPe3eVUQraW6TRkWklNYYI4qEYbRjZEe4PF1bE/rQ+j/N
	 8eHdNJhgwNTg65GkPm9oF2GXGfp4TW/9BLgM2hwWNUhuvSYAPemXpKUC2fYrfezqxXSuR
	 cmXmzemS1KxQXNCfC1i2XOqtEM1EKHT/RjTN2g8C3bwwN3qRugw25x3slCXbPScZf+23h
	 UYW/+VtZHgkbypcPrqW63Ws3NELab06ufEZoTcjwxhapr5XbdB2nqLTeIYkaTEgXa+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814224;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ItZUs4rAkttw16yN200Z8k0fdOnF5WAA/wo1XxPg2KE=;
	b=BN8so7LA3n7G7Cig1lwZOtSmN5Zdmv5bnY7cGo+8NNK3JzI3Z6/2mI7uruapJDI41v5a
	 9DFDQQkZYBCXDn7yu+Sbp+aa3ZDsu5shIe+ihmjwkEoRHI89ZuGIxNiCdZ6niK68GYjjv
	 GbxG3S2WKuWeNap2OWZcE2sd0JwMAy6r3ePBWd8zYWnylu30MXsxyXW+vnyzxagRRBOt7
	 5cCZnXCTiFfASFBtGk9BWa+r0bmZrm9gWGnpShw8pqExYWwkj6tx4zg1yOznvfM5TQpT3
	 VkY3BwV1IDzEjHarO0Afpl45s+1jwiFuehG7ukZGFst1yp+aALwG9oGugHfaqh5uRfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AmIaoUeL;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEA0606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 17:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CEA0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AmIaoUeL
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-15dd124bbe7so1976731c88.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 09:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793814223; x=1794419023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ItZUs4rAkttw16yN200Z8k0fdOnF5WAA/wo1XxPg2KE=;
        b=AmIaoUeLi2Q/TlozqiC/bjSSYDzbLHl3l03iQ1msp4uho0ZFTjEwWOCEuNY0zLkul0
         LCIVaG73rhShZ31dT6u+MnMlfLzErl0oCsrZslfVrVnkkAjBwpVCrA2CBIpmQ2E2OkrW
         rEENQ/Axdfwbts4w5VeGsJ4EsmWIek1NH7VGh74FGREfEYZfrQ14Vtu9CgQ2J854o1tJ
         ZweqEcYTY2VJW5bNbZX38mmlMKRb27eSpBWK/vJYuSMCkpEz9+TL2dUdiI5alawv6tie
         u2Hw5NFBOJ5noHXBKWWCkLAlNITOTMehafsvlhcf4bcOtvlDc1hUjByf4TN5tEMuOt1T
         u0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793814223; x=1794419023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ItZUs4rAkttw16yN200Z8k0fdOnF5WAA/wo1XxPg2KE=;
        b=Fsz3bZKdcMvCvhqcYirDEmFNCJufMIssRLPaE/hKIRixqL1Oi1ND3UjvrzmqBWW0r/
         SJQjE1yFfNAeAnJLyidV16aKQoR7A3xo5u0zwmWN5Dq0uAUcK9vnd9u0umydqUfGWq0p
         rYFalauwvMs2946O0ogyGXZfrx0E/c1NtbSBIAfwqKpGHjPVKC0Lp/LLgHI5OWvghWKu
         LVWrPIldHzeOwZnCbYdF8ZulwScqDZIJBwwPypOys4FtDB8yXaqFbCHg8Ac1cyQLU0+S
         xulAcix4MHzzLzYrpzGLkZ38f9tuP906EgAxMUtW4oGBMlLyymm9cDE7qQDy/pHz1ERC
         pnwQ==
X-Gm-Message-State: APuU4Z+ODIO4Jg8i9N0UZAyiH3nV9Z3oaRO8ATDTnB3jWHPkHz7hvQh/
	ctn/JRPSML/LZiJpO+Q0RY7DV7CUBfZYOrGJfdpLwAAq9rCnFfWL1ZmPGfhJFWdC
X-Gm-Gg: AYBFou3exeZZoz0fEh8M4KlQWg3wIFIbPWHX2DQsNChokOiA7Q0JZPYpXqw1zcAELdG
	r9y5sSGOImWMlSQM1KyEjZPbkj+abDDybANzfTJO5Ai/SPCYPmpYvrpMTmd8F7+IkPHiwx7JEcL
	9U/60+2Tx9o87ILQsH6aAqcPah7DpKc6rvaTkOTdJBhEmG4XaJuW7N43qwni+9MohfRC0ZiW5bK
	3v+KqJebuntV9nIsOGGT8sgdnPg1y2JP3/Lm3lIUzwy7wNIMDSFDT4AWR3a5AVmvn1IOVm13v4H
	MFO5ivpOBZlXaL8u5RmU18X7PJIzXxf4B53VkReCuQhGQ770yJKuKBIAl36BnZr0XChmw8YE/sN
	n6SGTacmM6yss7eEiCH6ha3orMippDrf1XAQv6hQp9qV6h0djpSyAidw3eUWSuUdrOAju0Hsng6
	O/qxe4GjTTwkflN9IBQH4imfeACIGES37zh13EmU9O+wug2hokIfLwTbOMy3Oz0riCD199weShQ
	rIOAWsgNbCA65PK3r1P5rNWDEpPIBkvabP/SMjdGPBj4LKm0PCo4MNdCLsql1KN+F1GbNoHSS0Q
	gh87y7xSxJv3Ybt2gqkHkWbYIrzptnoApIipW0T+8cd88S5swqXb
X-Received: by 2002:a05:7022:223:b0:144:f089:b189 with SMTP id a92af1059eb24-1ac5c369250mr34671500c88.36.1793814223214;
        Wed, 04 Nov 2026 09:43:43 -0800 (PST)
Received: from umang-Inspiron-3501 ([2401:4900:1c60:e7b2:735c:e3ea:7972:e818])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3989670sm11988565eec.25.2026.11.04.09.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:43:42 -0800 (PST)
From: Umang Pokhriyal <umangpokhriyall@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Umang Pokhriyal <umangpokhriyall@gmail.com>
Subject: [PATCH net] tun: delete the flow entries of the moved queue on detach
Date: Wed,  4 Nov 2026 23:12:40 +0530
Message-ID: <20261104174240.138491-1-umangpokhriyall@gmail.com>
X-Mailer: git-send-email 2.53.0
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

When a queue is detached, __tun_detach() moves the last queue into the
freed slot and decrements tun->numqueues. The flow entries that point at
the old index of the moved queue, now tun->numqueues, are meant to be
deleted, but the call passes tun->numqueues + 1, an index that never
exists, so nothing is deleted.

Until those entries are refreshed by a write on their flow or age out,
tun_automq_select_queue() returns an index past the last queue, and
netdev_core_pick_tx() sends every such flow to queue 0 and warns:

  tapq0 selects TX queue 3, but real number of TX queues is 3

Found with an LLM while testing how a VMM detaches tap queues when a
guest lowers its virtio-net queue pairs. With four queues, 30 flows
learned on queue 3 and queue 1 detached, all 30 went to queue 0 with the
warning; with this patch they are spread by hash and no warning is
printed (3 runs each, in a guest booted on net).

Pass tun->numqueues.

Fixes: 96442e42429e ("tuntap: choose the txq based on rxq")
Signed-off-by: Umang Pokhriyal <umangpokhriyall@gmail.com>
---
 drivers/net/tun.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index dcec7311e..3b292bce4 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -615,7 +615,7 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
 		}
 
 		synchronize_net();
-		tun_flow_delete_by_queue(tun, tun->numqueues + 1);
+		tun_flow_delete_by_queue(tun, tun->numqueues);
 		/* Drop read queue */
 		tun_queue_purge(tfile);
 		spin_lock_bh(&ntfile->tx_ring.consumer_lock);
-- 
2.53.0

