Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618904;
	b=HiVvevjTvD8ljVP6Gl0JeeP9rBx6xtHXPGQiPcESO08G3WZBkD/V0axQJua1VzKojrp6
	 yd8SKrM7EP7zS14dtYubCZQvQNsafrQuDtWYnIh7rGsbNpRjnZ/TjT9DLeKyCgI5RtOZT
	 +xZ/kCJgoNLPMGEGc9pQOwWXqKIosR5FqYOSTuQMKJaQSM7+p5tSWum9ANqE4dvvpnfxm
	 dtW5OtiV15kfo1jHkkYVNAzFLBQogh3636mJhb6HyY7eOOoPbybWmSMjm6BzxkJcIS45X
	 yBwOWig/T4tG7Adi2PxiPo2+ioP+17I8oEBcTZwlNgKvchQ88ZnSUUeJFg/hTSYX2kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CCGsR7LPvkczseIhGcwfOaLZHJqDI04VbeyNAiiWj6g=;
	b=vqxh5oe359uwM0npbenOuI100n86EUGFeYDgmUyad9+egOG+K6f71Zfwt3aBQ6HuO94h
	 Q3Lm6iCYRtuejcQSEqld2iyQFq7rOVkuVCJFUtQS3lQOOcSuL6nf0o45Xbydaz8W0CZbk
	 cTIJ8hH9Jnr6Vijb3GQB1LBwVGpd6F82YMQJxordS0MSgxXYiV211IVdeJ1ksSRk5dMJd
	 ualcIwZHL7w/A3ajUCTp6fD1VR+3SKSNOd93lcFTVQEgvBQwMZ5SGXPe8xsT+aJLUvlqq
	 Uoo+s+hlYltPvP9JytSZIuHBVTOa0h9rpcI/fnRx+4unlMocbxu3WNibeooT+MNhqOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FGie+iy8;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E856460A2639
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 11:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E856460A2639
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FGie+iy8
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so17002815e9.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 03:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793618902; x=1794223702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CCGsR7LPvkczseIhGcwfOaLZHJqDI04VbeyNAiiWj6g=;
        b=FGie+iy8XzXCHED6M7et8j+I7bdF3gCSWfq6WEBHz/sNtdWaX3sWQ4MTFa/B0ikztn
         wGvNuhAbPzucFxZ2Xyp9ZsNeMyWk1UCgUwcNkMpEwBr6As3t2v7HngwVudOKycHVBVKr
         SpWT0uQF0Iw8j+NkXMhwdHW8WtRXkSRhj54JpJpAxO74NnE06z2+BzaMf7xK3LNLraTC
         XuX/lWgoCaeeYYM+R9C9S00amfLt1G1ToQUZeXI+lCpztC5SQG178il+SX5Gn9/llnK7
         uLJucWJrrl+xT4Zb8/emi2ym+Rp4R51PR0rM6QhYx3OAuYbuBEFaN3zwN87xFp2gY509
         C7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793618902; x=1794223702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CCGsR7LPvkczseIhGcwfOaLZHJqDI04VbeyNAiiWj6g=;
        b=Qognj7hheUhI9jhYXcO2ruqQhKqXxquTEBWYZ43rIe5DnmeXTZeizhFblNn27gS5Ug
         HNUDGYPU6rqhbe69AV6oiXa/lUh/xUBXVxNYb8l9RlOT389XtnG++Ufym8JUKQxPewPf
         Dig4a8nO01mr27LNZjJDtF6DyzHAZUoOhb39NfRzhhApkvD0qWOCPtXszNaEOFUSMl4i
         kh8goDrKMddk5Lu9JwzHB418XSF1GLUSJz5sZmgvBa9OnywbcGoGg2GP5COOyYg1vIFJ
         +kcJOWI+PlEv2enLg+dwrnXR5ptV8HjrrQxLvpGpUsMZYznJsK+i/GEJ2oN9nl0rdNQ6
         4X0g==
X-Gm-Message-State: AFq9FYJTh+br2SQUvJ8i6g5Iy1Auh+zpJ4Kvy1Lpp+3IKol4twxOe/Zv
	QwHKbiOIUZb2dxQGkT7zWtq5GoV8GIQW2wA9Lr+U2AB0YSuCFRWP3ZFekjJfeCPU
X-Gm-Gg: AYBFou2DZXEG8zkU9u6v/9qY8dbl1bcALvMAcnSchMYNWdXfwqbKpsJVGhq3Kr/2jki
	yQ+AyS98D2YI3rxl/KNqfTuxgdKKhjNp6X51t9/orPLyjrtoCb6JPkcIv/eiH5r6HAMiOyo9BP8
	cUr+A/FFSXZSJ42UGhH2WDZbv3HdfCW8LpQqcrexI3i6BEHyDRC8v/RePp0dgImEHUF+85I/irk
	lOAyO6tnlCWZNq5+ZU01RV6/fHT47IJiF9oIUi8OrH8NuVesui7rrDF5DrcAAxf/hhrMqGHCTIs
	0ufc9MTamjZdkitVrINt5GDrEmOTyfIk72SKCMmfsNpGKyY0PvgY/UTxwfvnINYq4xwQe3VEfeG
	PKX9GE7UNBFovOTshtGn5Vh+fg3yEBg3W1j0pLxWdQ1Aj5q8ctdPZQJxfH2htARJkNb8CrkritV
	1k/iIOCXOEjmmweHJjiH6cC7L1tsAc4F/5EEW/GX6Fl+1SQQ0LdlrjSVHLIF96O00NFUBxhxoxT
	QEqdK1qu8MyQ0XGpIbD9xVmINuWXhpRifsbw9bwL4qVonlt60Ej5yROJ7Xm5ghUw3YYTNSYuckX
	dcSswRNniErHGADvQkn6cOg/LyYhC+/YI3/vs6CpTmT71bwqydAaLexUmhSREt9Jf22bdBpBge/
	75I9BJptgWCLGJ57DDBIB8hjHlN/+t/ITmvgMyeTuTcz5sXR4RoDAphJI6XsIwN415SJpGxPpln
	wJY5xADK+GyxC1BgGalz55wWf086gfFPaXzSufQta8cpaWP+Pks4wzHA==
X-Received: by 2002:a05:600c:8b2c:b0:4a7:a5db:a93e with SMTP id 5b1f17b1804b1-4ac150b3dbfmr233776465e9.4.1793618902177;
        Mon, 02 Nov 2026 03:28:22 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-f91d-46ab-c9c7-94fc.ipv6.o2.cz. [2a00:1028:8388:a84e:f91d:46ab:c9c7:94fc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ab61d8b9f4sm311382215e9.12.2026.11.02.03.28.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 03:28:21 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: netdev@vger.kernel.org
Cc: marcin.s.wojtas@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	w@1wt.eu,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/3] net: mvneta: fix the removal of the mqprio offload
Date: Mon,  2 Nov 2026 12:28:15 +0100
Message-ID: <20261102112816.12322-3-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261102112816.12322-1-pepe.schlehofer@gmail.com>
References: <20261102112816.12322-1-pepe.schlehofer@gmail.com>
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

Deleting an offloaded mqprio qdisc leaves its traffic classes and
per-queue rate limits in place.

mqprio_disable_offload() passes an all-zero configuration, so qopt.hw
is 0 and mvneta_setup_mqprio() returns before it reaches the teardown
code.

Check qopt.hw only when traffic classes are set up.

Tested on a Turris Omnia (Armada 385) with 10 Mbit/s limits on a
100 Mbit/s link. After the qdisc was deleted, only TX queues 0-3 were
used and the link carried 19 Mbit/s. With this patch and the previous
one, the queues above 3 are used again and the link reaches 94 Mbit/s.

Fixes: e7ca75fe6662 ("net: mvneta: Don't force-set the offloading flag")
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 9b9efac2846e..79711a117c39 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -5251,11 +5251,12 @@ static int mvneta_setup_mqprio(struct net_device *dev,
 	int rxq, txq, tc, ret;
 	u8 num_tc;
 
-	if (mqprio->qopt.hw != TC_MQPRIO_HW_OFFLOAD_TCS)
-		return 0;
-
 	num_tc = mqprio->qopt.num_tc;
 
+	/* On removal the qdisc passes an all-zero qopt, with hw 0 */
+	if (num_tc && mqprio->qopt.hw != TC_MQPRIO_HW_OFFLOAD_TCS)
+		return 0;
+
 	if (num_tc > rxq_number)
 		return -EINVAL;
 
-- 
2.54.0 (Apple Git-157)

