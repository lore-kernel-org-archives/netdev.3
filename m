Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372FA26AE5
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 07:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481528; cv=none; b=SYLKN1nrKOyusnZLQwPfXOtdp/+y5v65raEqY2/LMOdS3XtVSM4nNpfaqpVhnZppfHnO3m+W1/hTnaPpA77D2OOuHqFpGexmyoVyi7/BoMF/l3wpU8tcmeqx029l+ayLJ643YW00+7u7WQlTj4LKNkDIzb+RaYDFCK5U4/xPimg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481528; c=relaxed/simple;
	bh=NqOoRdyRQwEnHaciOW1Lo15WOzVkPW8i+CqT++jomdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KGdwvtkpqJP81jF4bJCeX7mNx+yzIsXcR1CXsJtHwPO92832I/1SAj2BNSlM41UTuCNHPynNCH9wBKKbnqDBboH3s0ddOuPZUH4RRJKVJiTxFcBISMUQiLwdxKElO2bdc06e9Bie2p4EiSJpoUaNtZCy+BDEC6z2uK38Vl4pevk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=c0GuwMPd; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="c0GuwMPd"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so598092b3a.3
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 00:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785481524; x=1786086324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MXV9qH7UyhntE49tPsJBkiOVAaJG6JngpHeIAflWXR4=;
        b=c0GuwMPdOzqJUAGYdqnoaooYfpNFhiXhzAtOfICyJYNDQ0N9GjM/XAyjhTCF9HuiCe
         RYDC1I5LShs4tKGl9fMRjq0JQxROozcHjbT0gQKIi4GeHo1k7IT4N1Wif8CrzqmoaSgw
         lzf0KoAO3KpFlhOyK3gmptoTwOMyR7v2DOXyLS+tDG6KrUZLC86Kh4gry1FEq6gt4HKi
         qZi2cWJcgDtZVKDcueW91EWq8PYtjDkBoRYi8l+M4D0Sd0gODHh9UkGsGAhNBn9jtFpP
         Hgi8sgqDJpVT0Ms45t+OTAcI/RqVnZXZm30rfjIc+LeBPwUZrG/+nu2K5PMZOW5B7i2i
         TRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785481524; x=1786086324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MXV9qH7UyhntE49tPsJBkiOVAaJG6JngpHeIAflWXR4=;
        b=lX8/fHkM4jnTDsPNj7GNbCHmRIQRJJP8v+losmjFYQfDWnW2Y/SH1H8cFztw0okQIY
         j9TKvGzqI0Kr5ZhnbgCr+mRgOyP9H+MEDk7n7jU85fi/h49aT0sDSLN+ciDx6PyP7rb9
         hKjNpcSonKLpcZxtnH/MkfxGtdgGdlhx/iE/gGpuXFugalsyGh6fKpWwGEEUDe3zEYFo
         F1zrycOYgyo6Fss3uR1bNkSYaZQNFsx+YD16lc2iHfXlnBYS3ELNWvyc0oLJFKW6BfEI
         FG0q+7v/7XFqckfF4hxbR2ZmuM6ZjuhwuQStVnH0lCaZgRqdaeUXmODye75Xmcc2/soW
         IxiQ==
X-Forwarded-Encrypted: i=1; AHgh+RrOKVwS7THvwZK5LF52AjEgaednyeLgTs5AMO5Z5F2xRA7uYy99cCFjR4CwySpB03LU3Hft9hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRQgO6XWc3DRG01NgBZ5Oo1yWVJIlZUmMWP7p+6KuEpLLMzgZX
	VQMRWeG7eoXxU1zMhuhzZbyS7tLAmuvizB6QhgYPrRv7u/ScXGGP9xxOLojNNl1oXY8=
X-Gm-Gg: AR+sD13Vx9Q27K3tBhCAuWUMzOAaTYI1Uw7VN6q7Y78GSzMmMS5yKB6clEML2hW424M
	xpx0bVXf+YZKCaxGbIvE7ebgFnPCgs/qUESOmcREZGL92o/bbKLVgipfOsT9OwvosJxx6E9fPkv
	0Qvgyv/PEIRfS3lv7RmrdHPNt55aLdsUD8xx3SFs5rkbhhz4WOPXs+3zW37Pde8wHFc/50QLoL2
	SoQs88gRyxClsPJQAprzrU7l1mjUyPOqB6d0mqIYYQas/mD8AwExBTeNMO9ut/05WNS3IFDQa+v
	RiV9aHogfa59awNLqh8u4vyaAxtKo8/PkS4Uy32WpGlHOPO3eeA8bE9jZ//m9YXh0DOx79566T4
	HUM/Zh+J94DwqQUR0jU5DJ7MelpEKYO/YnmE1WNxR1frw48vhbtHIPz7n1z8Dqf/s7N0j4iancS
	lxgIf4uEJGAodpNnXZ/xvq5jbtmul60cuKMkrcbizckj0VUIQUJPfgQ3LVWo0y31Mw98hj
X-Received: by 2002:a05:6a00:3e1e:b0:848:5935:2e11 with SMTP id d2e1a72fcca58-84ed7266716mr671512b3a.48.1785481524374;
        Fri, 31 Jul 2026 00:05:24 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d4473sm39233b3a.40.2026.07.31.00.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 00:05:24 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: horms@kernel.org,
	mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	guangguan.wang@linux.alibaba.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH net v4 0/3] net/smc: fix out-of-bounds and use-after-free in SMC-Rv2 LLC processing
Date: Fri, 31 Jul 2026 16:05:06 +0900
Message-ID: <20260731070509.1818665-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split of the single v3 patch, in the order Jakub asked for:

  1/3 frees the LLC queue entry in smc_llc_srv_add_link() only after the
      last use of the pointer into it.
  2/3 bounds the peer-declared rkey counts in smc_llc_save_add_link_rkeys()
      and smc_llc_rmt_delete_rkey() by the buffer they read from.
  3/3 copies an oversized SMC-Rv2 LLC message into the queue entry and
      declares the rkeys that fit inline, so both consumers stop
      reconstructing the layout themselves.

1/3 and 2/3 are tagged for stable.  3/3 is not: it does not fix a crash on
its own, and it changes a structure layout and a static function signature.


---
v3: https://lore.kernel.org/all/20260727095833.1079618-1-yhlee@isslab.korea.ac.kr/

Yehyeong Lee (3):
  net/smc: fix use-after-free of the LLC qentry in
    smc_llc_srv_add_link()
  net/smc: bound the peer rkey counts in SMC-Rv2 LLC messages
  net/smc: carry oversized SMC-Rv2 LLC messages in the queue entry

 net/smc/smc_llc.c | 101 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 76 insertions(+), 25 deletions(-)

-- 
2.43.0

