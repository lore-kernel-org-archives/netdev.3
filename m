Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C1735E956
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789828745; cv=none; b=I8KqL6TYOUrxhQRGdtGzoD6ntZCKuXLLWSsYNtDD4vWjmdd2bFiM8zocNIUiIXIzf/TdpSRZ2U5tJhVtsNaw7PWh2rkj6nBoFm9nDbIE9dzFwxZvpep7xsT/FCjJNw/3H4R/9LIrUXgS9aqh+byG2UBE/A4TfFt2BX4Shmth8v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789828745; c=relaxed/simple;
	bh=3taqaGm1ypLYm4mAvBQptlO23tplKlXSCpl0tzfrwa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I6myrUiAsnS364xkxQdvImhWGL+oqiUm1654+B1CLHxVdjwOBW7NfQ6/qdHZkQPIdx0w88/kdNJMbw/6brAQM9OP5BgOtQD5yzkAH2myFdJUdc+FwjiK4l27Uy/wOu+Nhkv5a+Rs4vBEwL/cy8yrp/x/lC3foqoPv+4px4TnbOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQ5IFZbc; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQ5IFZbc"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f0135fso16390045ad.0
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 07:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789828742; x=1790433542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b5WnKN5W09ryykDlZhwE+tuYvm6PWVaJMsksFXoHy0c=;
        b=aQ5IFZbcg1kysD5NqiEQZtSg5tQlWR3HAcS0cfxZG1BPsWbqXDk6KR/tzTf7acD1ag
         veurrvpO12vmqR4FQAsEOTf8IXmUboJn3RHRD68H0Hb1E6DUSEaZulwEgWbhBFI3SqKW
         FwRJ+JXWPwJ5jSicbWekTMyDdIq3K0zGy7tD4FxnxaAQ7dSubqiEisl3I6EK9d3J7MAA
         yWr1jSCYWHej3Ql/5uRSPVkhJmSoVHRXFcUJVz2QsQxERo6qQ9paEJlbnlkX/0nTIjK+
         eFdxullpS5Nnps38h2wQ/xRWWghW6/+W7c/vUtzMCgC+RSqd1RVKVGvgje0yLbotloZ1
         QpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789828742; x=1790433542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b5WnKN5W09ryykDlZhwE+tuYvm6PWVaJMsksFXoHy0c=;
        b=fdLPqRu4iw40JVZrfvZRzUzpQI8UdZjKe6Sijy/afRLpB7BDmSJ/0Zhq6wC+bc4UvQ
         h7i4MEXvlRBTb9LnhQgVJFCWXYRbheoPReK86Kz1s6ApAs8N6PzIEGI9SYGyUoUbfrrH
         oMttroagQQ8CUt1YG0gcEvUatQQuqH6jtq6uElCBpRm2kuOrUMfv4Su8mt1vyBh9/Ax4
         66mJ5nZPmJ2tUk9YP5MBoMBoPx6/pc7esJXThhuNWsO7OAYoZM6JizGrqRdmBRTnhikm
         KRk6CSsI0QfF+8NTVJaYDy/iGyhk304XphutTvVg11hk/XQb76tyv+ZecIjFF2DSyifj
         Zf0A==
X-Gm-Message-State: AFuF++kdyYIvqxh4P4VeSdUHIdbiKc+FgVOEqCHFtkkl4pRkHIvDdXcH
	w+JPPdcQNDZR4DNn5ODdQajmXRCVPy0MzJpG7X5O3MHXg3DywvzJWHax
X-Gm-Gg: AYBFou14OTxcPT1NGdOt2oBq3QNykNT5CCk4GFAs1EDy8mgAET7HtT2kZ6Fz/z1j4re
	n464Voc4Ox2h02JF9WJpkF4PyRDGVJ5MqMrxF/IrPQ/20LA2UuVU7UkUGgGGxWuaXiS9JVUkIMW
	nfx0kGEOqYoqqPf/AK8N2z0cHK+7LcEk3ham3ByyR7xvHXJIjoNWq3e3skzemawxxoE8+jbzFFH
	OU/A0wQuCMwLfyw6CA+Qll+yE/WiYiPQVJ+ullwFPMqs03qdc7AK40lNNaO1QBpbeVMRoJyITDm
	t+O92edknArf5p4C/kgJgQW1behxuiSMBFMaRPIPe/+bP5fbTNZ8aB4vdeeWCtd9QpMTZoK4ENG
	wKcWDQMiqKkb1A7KyPQubTk7t1/pu6me7GWkcBYAoAtkeHOmXwgiT89VPaI2NqlPju+aczgXc9v
	hkHG0zSWrKkGh//xG9s4dBqcdvUa0njxJrrlrfMPoOrJs/zhWhgRAcXBNAa2i0ura1tiFsMSlwy
	DPErG8wdZ3PCF/FHzag+wgA9QRq1xa/TodSJwQW/9OXzJP1bF5HpYHeDN3Ox3OegFLBvM1nxf/h
	0eINdt1J9VYCXTCktNxqheHVE3nCUA06lRjmC+RYeEscC/3lBhHk2eR01aM=
X-Received: by 2002:a17:903:44c5:b0:2d8:d4ce:7e40 with SMTP id d9443c01a7336-2ddb1ba3606mr70334305ad.21.1789828742306;
        Sat, 19 Sep 2026 07:39:02 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc179ed79sm10711715ad.43.2026.09.19.07.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 07:39:01 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH RFC net-next 4/9] net: reuse skb_shared_hwtstamps for BPF Timestamping v2
Date: Sat, 19 Sep 2026 22:37:27 +0800
Message-Id: <20260919143732.11772-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260919143732.11772-1-kerneljasonxing@gmail.com>
References: <20260919143732.11772-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ultimate goal is to find a place to store the start time per-packet
basis for different protocols.

It's almost unacceptable to add a new field for latency tracker (BPF
Timestamping V2) for every nornal skb because the space is so precious
nowadays. So what left we can do is to try to find a field to reuse.

The principles are 1) it should be a safe place to store the start
time, 2) it can traverse across netns (candidates like skb->tstamp
are not appropriate due to the clearance by skb_scrub_packet() in
the container scenario), 3) it works in dual directions. Detailed
comparisons and reasons can be found on slides 53-60[1].

As we discussed at Netconf 2026 in Rome, we eventually chose to reuse
hwtstamp with considering the above reasons. Now this reused field has
three meanings.

The two uses between 'hwtstamp' and 'start time' are deliberately ordered:
a real hardware time stamp always wins. The start time is only generated
when the hwtstamp slot is still empty. When hardware timestamping is present,
that means we have a better value from real hardware than the software one,
so choose the hardware timestamp as the start time in the rx path.

[1]: https://netdevconf.info/0x1A/sessions/bof/network-observability-bof.html

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/skbuff.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 55ae1653a1cf..c5347be72ff9 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -447,6 +447,12 @@ static inline bool skb_frag_must_loop(struct page *p)
  * struct skb_shared_hwtstamps - hardware time stamps
  * @hwtstamp:		hardware time stamp transformed into duration
  *			since arbitrary point in time
+ * @start_time:		Start time stamped when SK_BPF_CB_TIMESTAMPING_V2
+ *			is enabled; shares storage with @hwtstamp. A real
+ *			hardware time stamp always takes precedence: the start
+ *			time is only recorded when @hwtstamp is still empty
+ *			(no hardware time stamp available), so the two are
+ *			never needed at the same time on a given skb.
  * @netdev_data:	address/cookie of network device driver used as
  *			reference to actual hardware time stamp
  *
@@ -462,6 +468,7 @@ static inline bool skb_frag_must_loop(struct page *p)
 struct skb_shared_hwtstamps {
 	union {
 		ktime_t	hwtstamp;
+		ktime_t	start_time;
 		void *netdev_data;
 	};
 };
-- 
2.43.7

