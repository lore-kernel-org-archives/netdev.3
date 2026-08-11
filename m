Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B2C64
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 04:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786423582; cv=none; b=UJTl7KsekN2m6xALyadM4Ism1/g9mV0H1LJM0aoRHXje79LBf1MnSMCXdpT3H2nM4zdY8DjuezbiLhWJ9+ym7A9YpIcI8IXjNz8/ZkEYgHzyXu+xf68HJ1UxXMzVw/C3ZL9ebyQCbzRsk9k14xmDaxbsjifudScib+6qxfU9MGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786423582; c=relaxed/simple;
	bh=B/HD8Bp/oG5QVAO8ZP1em58UM5cOHMj+I4bCMjpwcUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rbxv++mOg6R3SSXHKzyvB9O+RoUi/8mTy5bgsM18rjebr4Vt4CgDJV5Zi4bnOUcbEBBa2zZONG+gpf65F5JEurK2Ho/8thJbVa8n1onZb9hzvAzlxGmpZDFGJ4qfBP0AlBW5gkABnU3pMDk//RyoBj6VqfSvtRiTapk2pjHSV1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQZ4163m; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQZ4163m"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cf50c6f235so4823535ad.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 21:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786423581; x=1787028381; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B/HD8Bp/oG5QVAO8ZP1em58UM5cOHMj+I4bCMjpwcUM=;
        b=MQZ4163meWwVvFjKnw8GYscoCW3boX3IsjS8Cpw/Et0gZmANS2+2EEhZ/RnHiOYPXV
         3TzTNW9orBYyru7gE16yAPasxaom7lM7pWx9r3vh1ssCksE7WCZZpT92TkmmqjRRSoV6
         9BozLwanENGeUGw1XhxX7xDSIAaK5NOOaHQ54iPegLl7cVd1WVuXM1Z6ERtAIRRaK6eI
         DR6SLksscXWD0n8MVwF72Xt6XIHNHyDA75sNDSUNNQCTOcj9hKfVP8lFrMudq5efvzl1
         7sDIwDQzkBJxZl+6uTIanivbLQEqkZGjCU+x9BwuO2DB9G0Gd45HeMZBmV5WOyTJGLRx
         m8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786423581; x=1787028381;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B/HD8Bp/oG5QVAO8ZP1em58UM5cOHMj+I4bCMjpwcUM=;
        b=oY7B8715ZXaUi5jb9vQPZxytBFXAAf4djrPXU/Lo9TSiemIvZRkOmF7hnpm4PtVGU8
         ump/beuHlB+DU3+uLTwVdZy/ysilcEuxhRplJ41ZvcWMqd/26yoNdnxEnKBEaDLsPKjx
         prhdXyEUfFwDRgzCKOp3xQj0wSUvYEj+vJ3b+KXfO9xKWLPKGRoo6kppNWczjRRtEVZl
         q14rMDqF4UdjoYPiCv6PPyIUj35m5pqesDrZFtb0F2vR/c+vnQpqLfyWExReMK5eLJPn
         iuZyLGUspoWaGLtZoDWdgdlR5fOg2eXunB2ild00Hzpsh3qLgOYZMbHwFcHxbcki5wQ2
         VIQw==
X-Gm-Message-State: AOJu0YzglFZpFx4ERJpGGCG0p+p0c9wXiwQvuUHJ29HCrZ61zQvTedfL
	MJyPsWMLyQ7tUvc1/sRqkw8qd8padA1mm7U0erwRNIp1w5/mAZlO0eLagy1mr7pV
X-Gm-Gg: AR+sD11nkLGhVfZKpyzB3BWx++33m7G7A9Z8rgniRLz3sV7sjYKpF/8CkzbqSfaT50C
	b0PWNdPZCFZZbZmZ7v5epNuzG1dXvQ91mqrRJRASBQZel9PaTrDaeZbkpfA97VqxbUxCUnXO5QB
	HPiyffO5FS0/2g3bt9t5IXAqT2X/snpYEITaeoAyi7WqA7V2xhEV/mFKZKlGfy/hIFAV2k+UOiS
	3Q8Vcjqw8ErSmrbqcc3xMucoHUGq3Nh3EdGIntnpcgMPSdFcGRWCVTvJpE1sY/Q3cqrxHHABEgO
	KG/R/D/KUjbcJCCtesP1aK4zqaNU6fsVdofvi/AE30UPR4VGhPMTBo3g/XXsl9gFvr4M8E7eAPL
	x6MYWaUbJC2/mmuMDxCYs5YOsM2knV802pSPCNwPwP5OI15+nSgOwvK4SrzoNAQRHtISZHekHEG
	RZR7oKrIrKDEmh+96pUClvcJvbPWzKbiMrJhBKVSO5l/l2PGe5CTScfpsLt8GVYokcEQRTuSmEg
	Yv/30Oj7Bhx4G0ECrDAmn5Wrf84jVkCKqETZX2EWt7sIm7CJw==
X-Received: by 2002:a17:902:cecd:b0:2c7:f2c6:89e0 with SMTP id d9443c01a7336-2d3177d62b6mr8527975ad.4.1786423580617;
        Mon, 10 Aug 2026 21:46:20 -0700 (PDT)
Received: from WR5220G5-Peking-BMC.labs.lenovo.com ([103.244.59.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d315ef0e37sm1326665ad.7.2026.08.10.21.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 21:46:20 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	vega@nebusec.ai,
	tonanli66@gmail.com,
	enjou1224z@gmail.com
Subject: Re: [PATCH net v4 1/1] openvswitch: Fix CT limit teardown use-after-free
Date: Tue, 11 Aug 2026 12:46:15 +0800
Message-ID: <20260811044615.1458463-1-xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810224356.927424-2-kuba@kernel.org>
References: <20260810224356.927424-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jakub,

Thanks for the review. You are right that the CT-limit netlink command
handlers cannot race with netns teardown.

The handlers derive their netns from sock_net(skb->sk), while the
userspace netlink socket holds an active reference to that netns and
delivery to the kernel receiver is synchronous. Therefore
ovs_ct_limit_exit() cannot run concurrently with SET, DEL, or GET for
that socket's netns.

For v5, I will remove the unreachable NULL handling from SET and DEL,
including the uninstalled-allocation free, and remove the GET NULL check
and its new -ENOENT result. This restores the previous command-path
semantics and removes the corresponding teardown-race explanation.

The RCU pointer replacement and grace period remain necessary for packet
processing, which can access ct_limit_info while netns teardown removes
the state. GET will retain its RCU read-side section for traversal of the
RCU-protected limit list.

I will also update the ovs_net::ct_limit_info kernel-doc to document the
RCU protection, ovs_mutex serialization for updates and teardown, and the
transient NULL state during teardown.

Thanks again,
Yuqi
