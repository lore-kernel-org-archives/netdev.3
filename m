Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794265238;
	b=D87iNRLJn+F6oKrwV5MxHkH+mzk4Lj4ILZRYvTONsksCM64xJ/TPpKfuwkxDPE1y+8l1
	 0+ADsmWJrEmvzwgLyzCyPxICSLfHj6geHyorVi3aWLRhU38YCZEnlfSOUEeFyikVkYAht
	 TEkKtmnkPiHOHUZeX7raGycwq6Q6NWbG0+ApDLxUPm9kGQqBy4h7yDPA0IjyhIY0h0cpP
	 fCDiPLjVcVaAEpUv+IfkdLymD6LUX6fb1qbWgvhUm/vzvzL/Mqa9M7QXZrQC4ykuGJgdC
	 TVTvx0xgpDM7+dUQ7SQbFd6gBneSFyfTDfjyTAVC8NhO900kiUroEaOnH1IEBmKdJYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794265238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=q/L8G+eYF1W07A363h374vBZx+sG92miBJ5CImiRZyk=;
	b=RZ4g26RXz6CW2FASXeJeTxkGhE4nC9HrFZuHy+igUwOR+Mp2vJ7EFCcbIsqnjhO/e4iF
	 VXqJGLaffutz9yZk6QvJ+qGzIl/FSjWZeVtdHPcm5Dol8pordlE4wUJ5OoOWvPROT1fr8
	 gVWJ6MF2fqeOJS1pa5tphnZLg7J454yBrlUDqUV9Z0AE+K7Mdu0zhT7pgRXeth6t1ndub
	 gHCx8uoKMftpJ7sU8YhBLW4jb5+N6sCqzMVJ7yFlMMMAxmLg/gaRdiwD5xVEsYh9QUOIr
	 A5se2tFs5msr3Rks0BfhP/CHGcXZkjBGqm8uvv44ccqhcGtwN+x+CwrvCY+0un4dBTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yTP9NfKS;
	arc=none smtp.remote-ip=74.125.82.195
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE7F606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFE7F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yTP9NfKS
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-36fb88ea38cso1732414eec.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 15:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794265237; x=1794870037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q/L8G+eYF1W07A363h374vBZx+sG92miBJ5CImiRZyk=;
        b=yTP9NfKS1OzVB4Wrk70HXAplMUaWBXG+TghqhxF/BIJjHjvPxml3jtpO6FXj5hS3K2
         cdv3Up4B+TmZKVyWDWlmhmoel+DRQNZObbOlYVdOaW50mJ2fBGlBsac57fSqQpLq2Sxp
         PvuTNIY0J6qZTRyVmsHoXCilPr1hYS4hCWtb48/mWeB137ZbWKjOS1M8QxiWuy/E1B07
         f8uKkzBuvFwFnX1ny7YaFbOeHD0POGSPVTY0SJdyl432Uxh4TCTLOs5Wtq5a1euWS9NA
         MzSUoGfSQU10WDgaaYQBrISXQ8w1ahnnQwWOLguqkitg+4xu2gl8QS2zL0DrJ1JBffDQ
         rSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794265237; x=1794870037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q/L8G+eYF1W07A363h374vBZx+sG92miBJ5CImiRZyk=;
        b=rnxQTAvpbpqeT3dgw3LwTzv8ooksC6ZdCeasoi9wa5iY8CQEvWRiEH51j1QZXztuHn
         gtKWdYXD/72rFCMmUpOrUO/NgkjGL50xjG7D+8ZAaqiGmznXZxtRz9wyAAjJI25zhH+5
         msAVA+mZ2B4oRyiM0yIKBkjcpukj43kiQbfETcfQqFFbJy933oaZ3CBY/8/xBHMq9df4
         9YOTgjSzZWm6zzJSsXj1z6CyXsl4+tmytJI+oujR2/N2jLDID/dEU0bfpkn+MH025J9l
         ojywYCvypRW6hGNO/OC26O64bkX7NzMNUGgFhlkOI/A/8mXzzA+wXUTi2MnMQ/1kpovZ
         XEgA==
X-Gm-Message-State: APuU4Z/3AZYyLJ4PP7Qq68ew4sino5N+NxXNDsm0tiaHq9Ttgd/h2Wlw
	unCNn0kIEHl1Fcn6CXVOkQHMd1uxQphpKHDoLKqewi05rGt2oOckAijDLFqpYWXpmRXlpA==
X-Gm-Gg: AYBFou0epfh1Fv4I5Rfx/j6nUZ2i5Wb/QeX2WKdjhEcTOLgPuFzb8G9PwkZ15hurezO
	/rABK8RD0lZcPV5CGPoTDZeZkK2cPCFhzo5GmvKlPTk352dvbVczncVgVo74KKRXESLF58Zeh4m
	dJWdDILzqT/aTYPkNm9PEC3foZiuWHpY/vlrSDIiASuv7GKkYlIXm9JvRQyA04e4vK/tDst/Q34
	C/+eohzGT0SKnw0f3h3HTxILU5vXcOVnytfTL4v8+vXKlqYGFC+wUV/v/aXQuAo3i/qB5ddd645
	czHfmqoAyecdw7ZDe921gTFddbs69Ku9/Ws4pW4IsOtAMkoFzF1JyCXAgQGHzO/I1d5a7D0vA0s
	iT0yIoKN2CXr2x0msnOemy2xx1HLjUDYrAannnKRMBGMKAWvGnS++qJMoEilaV1/iGG6FRcrHaR
	BB+ZwMlW2OcTTxTyZUshkuz+nO+alpBXqVaULWoQrWVs/w3QyZTf6x4L6SGvoxyK/WsjGUKf+R0
	mY9/R7Iz7QiVfY1w6LWTZ04YXO2QEJDrq8w2p77ubEzfnLouwcF/SZuN8ADUMmEqlnoC+35oUek
	DM+Hw7qj8nMBkixI/5/SM1Ij1e6BbgVW96eKOCzPMbJHUITy1MLg8nVW/feDHxMXEgLhidI/bCE
	rsmMX1UUJ62xHUJzT7+Lnfrp1H3NqEDX2dqjt9Q==
X-Received: by 2002:a05:7022:211:b0:1b2:581d:5dc7 with SMTP id a92af1059eb24-1b3b5e6084bmr1512349c88.25.1794265236538;
        Mon, 09 Nov 2026 15:00:36 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b79649sm2177332c88.21.2026.11.09.15.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:00:35 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] dql: Reset the adjusted limit when resetting the queue
Date: Mon,  9 Nov 2026 23:00:22 +0000
Message-ID: <20261109230022.10729-1-dennylin0707@gmail.com>
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

dql_reset() restores limit to min_limit and clears the cumulative queue
and completion counts, but retains adj_limit from the previous queue
lifetime. dql_avail() therefore uses stale credit until the next nonzero
TX completion.

Reset adj_limit to limit as well so that adj_limit = limit +
num_completed also holds immediately after a reset.

Found by code inspection and reproduced with QEMU virtio-net TX ring
resizes, using identical reset/completion tracing in both test kernels.

Fixes: 75957ba36c05 ("dql: Dynamic queue limits")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v2:
- Target net-next and drop the stable Cc, as requested by Eric Dumazet.
- Add validation results; code unchanged from v1.

v1: https://lore.kernel.org/netdev/20261020230358.6649-1-dennylin0707@gmail.com/

Testing on Linux 7.4-rc1 (6628e7d4c6b):
QEMU virtio-net, TX ring resize 256 -> 128, and real UDP/TCP traffic.
With a low-priority UDP burst followed by a high-priority probe and
QEMU tx=timer,x-txtimer=5000000,x-txburst=1, median probe RTT was
349.15 ms before and 12.09 ms after the change (12 trials per version).
No consistent TCP throughput gain was observed, including 64 MiB
transfers with normal TX service.

Rebased onto net-next fa5196392691; the ARM64 W=1 DQL object build
and strict checkpatch passed.

 lib/dynamic_queue_limits.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/dynamic_queue_limits.c b/lib/dynamic_queue_limits.c
index f97a752e900a..acef6a35ba3d 100644
--- a/lib/dynamic_queue_limits.c
+++ b/lib/dynamic_queue_limits.c
@@ -191,6 +191,7 @@ void dql_reset(struct dql *dql)
 {
 	/* Reset all dynamic values */
 	dql->limit = dql->min_limit;
+	dql->adj_limit = dql->limit;
 	dql->num_queued = 0;
 	dql->num_completed = 0;
 	dql->last_obj_cnt = 0;
-- 
2.43.0

