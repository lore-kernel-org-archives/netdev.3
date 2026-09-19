Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B4437BE9C
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 21:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789854765; cv=none; b=NyJX/HrzI/tu96LCr09sYYLFV3jvdsEZmTW+kLgCDzeOh8CoPPpA+l9e1O0SdBcwaaQW8iVGvTcApXPs251tBOs/8xahcEuVamD+BqbYTo77ZNZY8qXXPV207oR+rw7TocCnLVPAiRfG0r3Px3DR8QeYA/SGhVkA3K8D5nFIreE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789854765; c=relaxed/simple;
	bh=SSPkRM0WzfBTi0eIJHbJXjPIs6gJOKdjQWdjuukdecA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L2VYrDBlZ2AwgbzLHoyN6D3a/DogNOXlpNxeCI6kT+EwNap5QzpggcgUKH5MWA91792x8xeh17KqfIP/ktMpF4/O0hYd6RdW8+OavpAMqmirO7I4+kmSxpUciPjVBVvTJAvMK6b6QeqeDKa8zhy0mYEWC1R1baPtXkLRw+RcEms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+eV4opM; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+eV4opM"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39e03468a5fso1665299a91.0
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789854759; x=1790459559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FiIS2HG9Xt+NjPTHwM6X6IVVzmDXuxKrK9MYOq1fq70=;
        b=Z+eV4opMXp4wzh7l1hVsNLYidrXkGzoZSrV/zvM27yW8ktr9MKiSXD2zXH4Py5DWB0
         XnZxAIC5y1jB+GyIpiynlfIsoDG4hDCZcZ5RKP+29ArF2eXS9tLIxuyBLISThpnySmWa
         ZbmIYgkCJkYtnY26vp+PhN9o5ica0Kk02YqiqYG/A2HJbdMyZvOJJrJABPOZ0E24X3t4
         LvuodhNKEIXeJwyBfkLEmvIvyFza0LM1MC5/3MomOAa8oLvISXu4Yyq0yzAIyGBrxf3z
         G5paFMujPvmzG9Mbh8htkGRjs1q2sjJaRunLDKd8mSI6gtVjmdbOsXC05VpzWEpPrbqk
         nrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789854759; x=1790459559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FiIS2HG9Xt+NjPTHwM6X6IVVzmDXuxKrK9MYOq1fq70=;
        b=PN0ecQzk23JN9Efb+FvEpbsOrmfNCmlxgkvt0kPaQwd03JxK7OHfAllU0VQSiuYzwo
         oCU6x/K7F1w6Vul3LoQH7IEWukdOivz8P5wRhr/agwOb4JOLyew9uk85OkblXPQM0Pou
         06aU2+isveBwpk374phgKDDsuBrodhDjR3PwpsdH31YBBW7z4WBHqMiX9e5jGteSgIpj
         cknjV1hVqRgc13MOvCMMOeCRFUFLscxTCph5prGmh+KRmCte+B9EyXqLKEFyFDcoe1G0
         S7TO8iqsfnxUh6rKIjGAv4p5leMmsHT5xZOEvm8Bv+eJJ+gSwkJ1LRdGUuRMJawxLt+C
         LfBQ==
X-Gm-Message-State: AFuF++k0MEDKyZVDf0cyXiwKuwwK6VBgD4KtgW2O+SI/t5PMqcE1Xedc
	fFz3YHkU7elBvkrylIAxBtOlU9zNumUdz1EVUtHyjiVMr5qlTuy+kuA/
X-Gm-Gg: AYBFou2f6PW+xKxVIl9zpVh7Gnf2jAQyOk4M/NZ0mNsQW2kPYjEDdom0es5AbR2vH7T
	3ta6Hp9ZjaHI677HwqozlV3rpGV/OjZhLGrrWmeGTytYBLkhcSnb9HgViPrwd9f/UBn3hQ2QiQZ
	651GIRw6hZN2ySOi4W1AGjFbeboNVV9AOWXvL8T4oT2yDlxaAiiGNeZdVbiYlRCtFJMxGv4swVW
	inI8tfOUHw3wG3troI6xfvneFpPjIqbCHKo7govzRzcnEjVy0AYGPDGxqMGwa0DoKVet/LMlyHf
	MT7LKPRQeD8H4tR0axeP4mJ3jvBuJ4DWC1dm+xJV7r9d3/WsJ+gullFpFaqOQJf/EclBhk8TWJj
	4zAM2UtpKPZK9tfENWZEAz2yJYbvDBchi+Ubi+nefNoeWJwA2/MptZ4hQuAOS1IDxKMv3gxC7uE
	skdFhrC2VrJsfZB9jXaX8afh8Ytj2ZvGfEKe9lpgZdoOMPszpBSrUmGIuEj7gqUz4zbHOUzlJK8
	cqclSoTanyC8u6lpx93WkhhayaRPeWBXF3DPfd4Nwa4wRTv45LNcHTBTWAK8kA2SxSGxyFzVX2y
	26n9t5fwSQ==
X-Received: by 2002:a17:90a:1c96:b0:39e:6bec:9eee with SMTP id 98e67ed59e1d1-39e6beca109mr3160708a91.12.1789854759475;
        Sat, 19 Sep 2026 14:52:39 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a023e44854sm1830886a91.4.2026.09.19.14.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:52:39 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fou: reject FOU_ENCAP_DIRECT with protocol 0 to prevent sk_buff leak
Date: Sat, 19 Sep 2026 21:52:38 +0000
Message-ID: <20260919215238.3471141-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In fou_udp_recv(), returning -fou->protocol to udp_queue_rcv_one_skb()
triggers IP protocol resubmission when fou->protocol > 0, whereas returning
0 tells the UDP tunnel layer that the skb was consumed without freeing it.
When a FOU_ENCAP_DIRECT socket is configured with FOU_ATTR_IPPROTO == 0,
every received packet returns 0 from fou_udp_recv() and leaks the sk_buff.

Reject FOU_ENCAP_DIRECT configurations with protocol 0 in parse_nl_config()
and drop packets if !fou->protocol in fou_udp_recv().

Fixes: 08d323234d10 ("net: fou: rename the source for linking")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 5e867f1b5c1d..3fc087c808bc 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -77,6 +77,9 @@ static int fou_udp_recv(struct sock *sk, struct sk_buff *skb)
 	if (!fou)
 		return 1;
 
+	if (unlikely(!fou->protocol))
+		goto drop;
+
 	if (fou_recv_pull(skb, fou, sizeof(struct udphdr)))
 		goto drop;
 
@@ -696,6 +699,9 @@ static int parse_nl_config(struct genl_info *info,
 	if (info->attrs[FOU_ATTR_TYPE])
 		cfg->type = nla_get_u8(info->attrs[FOU_ATTR_TYPE]);
 
+	if (cfg->type == FOU_ENCAP_DIRECT && !cfg->protocol)
+		return -EINVAL;
+
 	if (info->attrs[FOU_ATTR_REMCSUM_NOPARTIAL])
 		cfg->flags |= FOU_F_REMCSUM_NOPARTIAL;
 
