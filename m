Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929F73F6C3D
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843700; cv=none; b=lRC5HvYIhEpa/cXQDMc2JgrscM+U90L7GJupP7X3kOQsa/BPLau6CiG0IJyURTKXOyfvvzohJ6/h2txEmOoJUljRHO43uz+eTgnYZnK8VMffexU2Ai2HuGY9YUCRXkq0G7UbWr0ieSK5Zi1LIyWC5llKAeP5dLdULJHlSBFC6to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843700; c=relaxed/simple;
	bh=k8f9Ybe0sB3z35sO/LdQgs/kFKGLgZdTLy5Qv48lClI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=teWBUkBvpKWEhvILMYO2RVQfHg0fOibURzNnR6pOGD0rSIOk0TnN6pDclbL+Bp58Lzz4YPCgoe1Rcgx/ja2XLBwUaQPY70vwPMra12haVF4AZlboNwHQ5OmLJG6yr/O6PDBBxyTJD+xubnju1O62Bb42rSIem6TSiWRM6PMSt2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6h24mVW; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6h24mVW"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-c88c8dfca3dso241031a12.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782843699; x=1783448499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypiM/OLEFB9eP/sC6o3RqlF/MIMYqtwsL4EuhWu/WC0=;
        b=B6h24mVWa6A8Nw/dtna6AEZJSQCmbTR8hKxqicvyAv4rKLF1GJUU1VoxKEuvNduWcB
         tAe/aGR82vwB0tNXESdSHxQA2DhpTRjGw6SrDOp4f7vCR4rd5CDb7Fu9QOzQhud6pMlS
         qBdG1OKBZWv0VmKOtK4VTbFohglLgGw+D0NI4bI+K7jXLorSQnmEPtEF7XcUQwWvtK1C
         GMQ/6kKuek0X6COyrCBc/uYP1aGVaqMwMhugQlNxBOeiQpyf13aXY+pPFMBNS+eXpm1Z
         BgudMCpkk9YGAVo47A/wyTyQqbqTD+edUjiJgmkQF3F8+joYhpI0AaZ6xwDwt+otlRxj
         uNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782843699; x=1783448499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ypiM/OLEFB9eP/sC6o3RqlF/MIMYqtwsL4EuhWu/WC0=;
        b=Y5ENPZlVQdHh5D1Hdq/Xr+Z4AbbmzxDsmhqj7B6B1m22qbwm6WC9UokQb2CxjZGlqu
         cYx4Fg2sR/IleaX0skmlvULiB8zMyUhNHJWb7/rvHFSd8SBeTFcdVKAkUVP1C7HeeaXe
         U1WdvmE+joTT0mwfVBZEiYM9akckfiNSfrzv8uvYSIVrrpQG5fLyzDIRm6KPbJpO/VfU
         QtXvfYS1SFGmBFSDMRHv5BWf+m20JLUNjLrap5TZjvoV4g9OKqV7VJ7ug5mjbcxsKdi6
         AZwY/iNm2sTE49QMZlyRi313kJFPjWCcieu6RZbcS3eYlLttfkWlTQ+FjO+TwrWgimi5
         O7hw==
X-Gm-Message-State: AOJu0YwdUkT4zc9wdBC8Q8etjyOWwhOo+95V0v+UyjMt4epNzku0flGd
	2C7ncwyEBocL5EVSIU3/nfkw2k9O8RkW75QwPWdh73xnwGpZJ7ULQ5PymYHQAHlQ
X-Gm-Gg: AfdE7cn+Pe9Gah4r5kJZM8C8eyzr2dDapDHoEeJ58vihjz0XtGrnThp75Kd3Rq36+Cn
	q3vXjZcNm64gJgP6tSxI8O7vZaEHHbsjr4UG0cn6J1IO14dyHAgtWAWDoWv/JDa35IIj06E1I8M
	M6wj+OqiZlvjZyYDb3fTUYhu+zSlpqsTDcpeA4uzl+d/ZxdkhOkl3QB70xBrteaIkt8Wwf0A6+p
	NmamljL4CyRAnSvx8BWVwd8q3J/7rySpixRkBQDPfx1pQzW39xTHw8YprZp1nYXPdvkjtmFEUvZ
	GQRmpySjIr0Ki23H2EtC/v7LWL55EHdkG8xWpBRk4dP2K3EagqvdJgiCJU/M05cLkvJpAPBOkpV
	FLEUpP4Q7l3RKOHSnkSxB6pAKWi2QNUTFgzrHrTpBQr1oEFNwk4LdWxWBd+g9YBoXeOyejQCVSz
	an/2IM
X-Received: by 2002:a05:6a00:4208:b0:847:8f33:b159 with SMTP id d2e1a72fcca58-847a81a36b9mr2052670b3a.10.1782843698886;
        Tue, 30 Jun 2026 11:21:38 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8479fffa65bsm2631468b3a.21.2026.06.30.11.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:21:38 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 6/6] net: document NETDEV_UNREGISTER unlocked rationale
Date: Tue, 30 Jun 2026 11:21:29 -0700
Message-ID: <20260630182129.1601784-7-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630182129.1601784-1-sdf@fomichev.me>
References: <20260630182129.1601784-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lock-state table marks UNREGISTER as unlocked without saying
why. Add a short note that many handlers release the lowers via
dev_close().

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/networking/netdevices.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 1bb68a73bb67..761cdb08bf0f 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -427,6 +427,14 @@ For devices with locked ops, currently only the following notifiers are
 The following notifiers are running without the lock:
 * ``NETDEV_UNREGISTER``
 
+Many ``NETDEV_UNREGISTER`` handlers release their lowers with
+``dev_close()``, which takes the instance lock itself. Holding
+the lock across UNREGISTER would deadlock.
+
+Moving UNREGISTER under the lock is mechanical: switch those
+callers to the ``netif_*()`` lock-held variants. Deferred to
+limit churn.
+
 There are no clear expectations for the remaining notifiers. Notifiers not on
 the list may run with or without the instance lock, potentially even invoking
 the same notifier type with and without the lock from different code paths.
-- 
2.53.0-Meta

