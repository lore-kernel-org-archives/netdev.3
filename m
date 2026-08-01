Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C6E331ED2
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 09:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785575559; cv=none; b=nTBjFhoP1069T5mDQ6lQg3GGje8JuG/AujWEP/aN9K8HQjFCpHcoW3Y3J35xt81YTfa4VZGSG2GNClJivvGeVY8mdbpCzhDp0evGrI4if6ry2Z7ZxaQ5OcqnuskwpZUBhOHb6BGigsKWEzTre72Crzr/zO7CfZhkJygVpLDDJ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785575559; c=relaxed/simple;
	bh=WtKwboX1I6TACBp1mPchjcTdLWsllHrSvbiZnJsT49c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJyTxdera6MSM8m64EjULcBLo9aJlialls983oGdRP6g0CIZR2ezfEezogXmXW1xVSEPn9hD0a7ItvyYeW1kWDAx1bQ5B6XB84803fD/oST6N6MO/+/OQjBpKhVdK2WkpGzAcvNX6jlMCZ9gowYv2f5Y738XGQ9Zb0Wgy7XCQHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=kSvakdbn; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="kSvakdbn"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d01663d816so13933525ad.1
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 02:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785575558; x=1786180358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=diW7eq1K5OgM1EddS3mEle0ywoNtUEUmAHB/nUoYXXI=;
        b=kSvakdbnTPxX13Fpn/tWdUQm/L1zgBFHeQP+9rBJ/Z+5GVEdk6SEZ9AUkVzTCLt50v
         oC2Kaf1hsHNNfuGi0CfdOAWueL2qUo8A+NAVW4PZaMfAQ2tnU1/OR9zkbkfh9eawkpu9
         KHEe7kU0bhSP7msuvbpaIwbvLt/fITbGxzFrft+07FVLADbJ3gQBsyJBDbHT/ipDRqmB
         OMkuU2kES6d00ESeMVUwO2lxvoHpj05ERSql8jhl4EpRCoTEBesPBhNTeATpryL2d7cM
         IrJ6XY1vLztQ3Zeg2uyTV8ZjnD/nwZBaQbjT4xQnSjzTeQ3RXawZATKQXMyCytRJBk43
         TbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785575558; x=1786180358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=diW7eq1K5OgM1EddS3mEle0ywoNtUEUmAHB/nUoYXXI=;
        b=L68uGf0ivyrIfFZllWbF1iLkm8gK9LOkg8/Nt7dro4z5/mIarvYgnCNhr+KiXiERqa
         JuUpzWIqTgSd2W1CdvdHPkW2x3431cMV456l4DreIBYex35ikPO14dfethoCOOpSYgqc
         rnleeaEgsaQobNwrs/GRvsmY6Zj/bssoqr9nRpExm1WEC8Qw7ixwLZ3eekulwEwFhJEV
         9E1MJOBiZzIQItzufzCm2GM2m1wpnm5XEyyjGwry3OO8FGQE8ruFMmiA8dnBBcT7vqwz
         R45+Jp8UQ/2dQoIk5TkxCdSzn5ngNjpFtVGo6eSC87DobySsCsSCKmiIlHo8Pd3kTl86
         0IEg==
X-Forwarded-Encrypted: i=1; AHgh+Roee5aIjyx9cc+ivnDbTrZX56w3Mogo8OhAaHLUQpnght1LbsF05Gu/x85dF1C+oXm/4LF4z3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy5c2WCshx6uEV7XsYnVLsiQiMI+yZUm0FDYH4USFt0H0C8H6U
	IyHD/rxRNkuxd5bW7Vf1fwvPtgeig+CEKBqinGw+7LpwvLr8gp3IfKfLypad49pRTdA=
X-Gm-Gg: AR+sD1063U44nF8oAEH+fnL+Z3AfpsZ9GLMLl5ixUjzHapCuYAcnZvy2lGafAxL8Hmv
	mKdLdd+N4SP/5p4pGpdLGyXCsjLP7dg4Ik3Dtw34BCV10WvzePU9JlSsibRznleRbicQYTSbzyb
	VfjBBWgETxF2EhB3PvWMgeDIPEhWHAmvKdgdq7EDralUGvGMnPr8dN64b9FWWswGEYvxY+xzRDF
	c2/KnRt5RkELRUaMTkN0nIGKUpK9tmPSF17vSmPsJMFqwnEG2iVJdN9+DKKlJqjdGxP7EwaoE5s
	QTQsq70yaDKvOlOlQSQaKuqiWAON0ttIEjV0154Wf+R9GeQ8S+Ny08bPGTldVq6bvoiDv2GK1if
	ptq6rH4VkLlGyq6VNa3LJbkDhX768kUbE1kUDbU9NW36/NkToLDYKh1/CSXxY0So4QJFBFlP75x
	zSg64XdO5f4xJepgh2tAhtQjKCGJbl+dKrDzgMkScSbadQpLXmMRc8jW4PFpOF0EmbEWXdBZFzm
	uZW/8FtPuQ=
X-Received: by 2002:a17:902:ebc2:b0:2cf:bf32:b754 with SMTP id d9443c01a7336-2d05219f1cfmr29858925ad.8.1785575557981;
        Sat, 01 Aug 2026 02:12:37 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c329:7b28:fe02:5dc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae60139sm16175285ad.29.2026.08.01.02.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:12:37 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	sashiko-reviews@lists.linux.dev,
	horms@kernel.org,
	mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	guangguan.wang@linux.alibaba.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	agordeev@linux.ibm.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 2/3] net/smc: bound the peer rkey counts in SMC-Rv2 LLC messages
Date: Sat,  1 Aug 2026 18:10:47 +0900
Message-ID: <20260801091109.1933145-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801070548.365231F00AC4@smtp.kernel.org>
References: <20260731070509.1818665-1-yhlee@isslab.korea.ac.kr> <20260731070509.1818665-3-yhlee@isslab.korea.ac.kr> <20260801070548.365231F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sashiko-bot@kernel.org wrote:
> Does this early return cause a permanent protocol failure for devices
> with a single receive SGE?

The buffer part is right, but smc_llc_save_add_link_rkeys() does not
read that buffer.  Without a shared v2 rxbuf its llc_msg argument is
&qentry->msg.add_link, and smc_llc_enqueue() copies only
sizeof(union smc_llc_msg) into the qentry -- 44 bytes, which is where
the extension starts.  Same for the delete side.

I logged what smc_llc_fill_ext_v2() writes on the sender against what
smc_rtoken_set() gets on the receiver, over rxe with max_recv_sge
forced to 1.  Unpatched, the sender wrote four distinct rkeys and the
receiver called smc_rtoken_set() 427 times, not once with one of them.
With 1/3 and 2/3 the path is not entered; with 3/3 as well it registers
six values, all the sender's.

So nothing is lost -- what mainline registers there is heap past a
72-byte kmalloc, which is the out-of-bounds 2/3 fixes.

The changelog is wrong to say "nothing beyond the 44 inline bytes was
received": it is received, it just never reaches the queue entry.  I
will fix the wording in a v5.

Best regards,
Yehyeong Lee
