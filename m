Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1913264E9
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 05:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785821777; cv=none; b=H5PqAP0b0TDdd/lLIpVwf4ryGrRvoH6TehQ2q+4+29Vbl309agfD0II4/Eht/pyoJI544NmGMCCbOX/cXtQVRgQoK4d7whqzCWnP8894fes2VS92a1aaR2lvObd45JgMkHIFvpJDdt+tGT+7+9ca9NA8AO+tESYtcYY/7t2FkkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785821777; c=relaxed/simple;
	bh=uUVoKRdDlnx2bbN6z4zltsxVi/aVw1j//qSChX3LVLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/NujaZh8c5e9X4aOXbrrFZbwUwxQHzoPVWv+hJOAf3A43mLITfGQ9+gCbMTeMLs+J9/9iJUDH+i/sPA02M7Fr7gp8BG9/iRHz7aBssesZM5SzyqYkOiXGa3C/x5bbZeZLsghTIauJsDQ8HhQVGG+m7nWYyrY7ooOrUBjqsCv9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3bEgGfF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3bEgGfF"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so28836595e9.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 22:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785821774; x=1786426574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uUVoKRdDlnx2bbN6z4zltsxVi/aVw1j//qSChX3LVLg=;
        b=O3bEgGfFh7uKNeCd/IEzoSNvyLoAx6qPZGu6A0UOD8B7Ftc3H2bfAWCeBlbdoIJvc3
         FREu78sTQD1dkdke1jpcKdnf/zKd7068+PJiSj5WhqdSsoHz9L4XYFEmVkWPNDieVdBm
         tr7eW995LRSwf+wwBNYUb50y+rNQcroVKdfsCU0pS5VQl3HFeiXDk8OVs/HP9kHCwEoX
         r0JHl5PRJIvzVhFxDp/LrKZ3PX3yrm5wn7AI6C+QkkVr/9D5gzOsgQWNLBy3EXxNpIU4
         Q+5yHmRR/zG+trodQF+nu+k/7YZDsSF8jIoD9kQ40PdmN/IyCWeeMfglkfd+KZKdnAl1
         AILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785821774; x=1786426574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uUVoKRdDlnx2bbN6z4zltsxVi/aVw1j//qSChX3LVLg=;
        b=ab8wfhkGFtnKXQhCL86OrIiIuIRYjxW9LJnC6McCzcl8mxuC92j0uBOqUiu2acjZiA
         zStwbS7NTANPDR+x/uG7FoYq3jtl/ThUx1WI9ioqhUkYMCgh8udYr/a6+ZQNuOuxgm0w
         p5/iHKLr5x4p6oFSTrNNCM0orbq9dXSXg1ja8KP0r5abn2XMfJt5Y7GRz1PPpmM9Y2t1
         a2VNPBD/u90sKcHLnEDpFxVAxlWRlS9Cs7QnwNQnuLVlhX7Xjs+9Tr6o/97o5dPU4PMG
         GQ7YOzWQmGGCnjtZA5x4NRhMQNIotLUKV/3FqJj7zSoflp+x+QmxdcKhIezmRi5CjQKN
         L9Ww==
X-Forwarded-Encrypted: i=1; AHgh+RqienGId6+yk02Ci78o17hrNjKU7D62fRm/iM/eHSbPzsP/yYl7i8onQKHUP/8p0onxMQjH0JA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIsBwq1D+/OyGe5Ia3+I0Nvywup8I/EKAWVGZ+aZ3ET3zgVgap
	7/4ObFgfZCn+2csXZHYmFCh0DVE/EPsMCE9TnEQvormAkHx0IXhtQuEDyfx2eVwx
X-Gm-Gg: AR+sD13fjopW/UyEosbEkYyU54JauibPRTn8TaJ9avLDBMrbEgtsoVOgRqInPS3Cx++
	Jc3cep4QeyFMxCU1UwSrGPuCzGxclzCmosDK0bpyjMg9tRmeFZ3LtXj+si3XR9gDBXFnea/Jrk3
	/F8XWHkPhlPFqO0Uf6eI4dybXUlYkIhSQDP+PYA1v7NSKMbudiGlVuFjEOJ+dIWz1z2zlHNUn+2
	32dCo7f9JSgLiwQ3r8RWw55/jSXrprU9MnO8DPvzs8LeMV5YZP+nfZMSrazXKbM8Kpo8a490dRG
	SK2JioRxuXYBVmOQfpJT63KF6vLMTwLpfv9wHWI8nwrJhzA5lC2F4C4cW186/fPwY1k2YTAwRRo
	nSBOmWO8OB2RizjIWHouH+7kGgFgme7Ne2q1uozwlSMaTmF9DHLMUPOzo2PTVvhvuaCD5NXlQNQ
	+wjEklhoaCdEfTpLq2yiNm48ebMG3riW5Pda49Dun3DPa3AerlYsnJmQppzuBjhA7Bz/0=
X-Received: by 2002:a05:600c:154b:b0:499:49a6:4388 with SMTP id 5b1f17b1804b1-49949a643f9mr61634265e9.17.1785821773878;
        Mon, 03 Aug 2026 22:36:13 -0700 (PDT)
Received: from grower.astralinux.ru ([81.9.21.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a0fca55sm58641705e9.13.2026.08.03.22.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 22:36:13 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: sashal@kernel.org,
	lvc-project@linuxtesting.org
Cc: alexevgmart@gmail.com,
	davem@davemloft.net,
	gregkh@linuxfoundation.org,
	gustavo.padovan@collabora.co.uk,
	johan.hedberg@gmail.com,
	kuba@kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	luiz.von.dentz@intel.com,
	marcel@holtmann.org,
	netdev@vger.kernel.org,
	oss@fourdim.xyz,
	stable@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5.10/5.15] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
Date: Tue,  4 Aug 2026 08:35:55 +0300
Message-ID: <20260804053555.945430-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803203505.stable-0006@kernel.org>
References: <20260803203505.stable-0006@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Did you even build test this?

Yes, i did.
