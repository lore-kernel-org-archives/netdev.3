Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCDB311946
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 12:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982802; cv=none; b=ruhMZYWcjXn5jNaG7OSJG5nlAXXM1tYNe2NAaVOjeeMDUfBrBSX9OKaf4lYwagj1hWtqjBPLc609XTEAHfZWt49wO3omvNG9f5M5RWVMreVY+Lmk8u3yIVKc4DF5H3KdQuxhqSI6MxDINmFOL0G0z7NM9Zjvqy8awhOo+HukvHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982802; c=relaxed/simple;
	bh=9yk6zMUB9FUlkphNWRIxPU6GBt18cBIBDMGvC3Wc76U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAutQppv1F2TaSTh7RbhwfQPEQkRrQqe5VynlqaoEUoYXWBwKI/BDv4IS+ItHLQRU07md3dJBK58hww1mGgu6zNMcJrt5mCvh9aaKry38GAwcRw7q2ejCd01O35jvfjYgG5HNSJ6M9rybHV/m8bwO8wCXexFAvqd6EqM1TF9vPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0xxH7o0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0xxH7o0"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a16c399641so40325675e9.2
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 05:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791982790; x=1792587590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6OgXMBMEg+uoBGiGA0DSTy1cFGCRIK3xSJyq5hnxZeo=;
        b=d0xxH7o0MQwjSlJemvZqnBlEknt0U/DvdZ2q2/u4gejhAFp4bQlHDp6BH6dXvzbti0
         tOxC6iKhNyfaHpno6rnYRegfAH9WHq2BGoh4jQdj+4e0wZt8ifGaEVxgv1Rh52RrI69D
         Ug4p07Q3EMCZ+ta7RzzCLDciHi8J/GuiOHtJnnRDH09f+57B5r8z9S8qqnDkNrCtjzFq
         kEP17D3A3P+gFgfGmWfScuKJ2px5oevqWeX6fXmhul2H5sIdqHv5vRgHrHcO4fEpcchj
         6yyQWFr3EOin/qRDQkXbuOmqQi4p8i9Eb1yzsWs+SSFhjmU9KfGebg0ZT87TzPB36Gh8
         PtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791982790; x=1792587590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6OgXMBMEg+uoBGiGA0DSTy1cFGCRIK3xSJyq5hnxZeo=;
        b=l2EWHWVGt/AaU7zX0w7O5jAB5FMufTI39McE+PAbfW8W7C5WFi2ABWswMSracO4egH
         B+y+FkYEfOF5+D+q9/JAOlvgJKG31UGlrWPNS1xUZXLg76/dz5FUnL4dLPHpAyPOuvmI
         5TAkg95TCrTIRdhuthMqeU/l4z7+e+KCoy6DuMtxoapEQt9TCgujDIqqj8kSnLh29mIU
         0Y7HSKrm4jPoH16SwFgsTntYrMYIgPdtRCyVAeQJb9NuA4BgikKHV8TH/BDwULdUkZkf
         /f16DBM3dGafyJQTonwmQnjPKtQwkPVdg+GjgW3Lgmo4AzvRhP/bjp01GhvxSIL3GfFA
         ocNw==
X-Gm-Message-State: AFq9FYKDEZPr3OLM2ZOGymCKyBw3OO4VFkV9GUcWBnU2rUksTEhkM4Li
	zulrTQQmhEuWIHiQDLPlE0M/CD+xGOjj2CQKVZHPgJxmvHxgV+RfpLVUX3xEqpBSr6U=
X-Gm-Gg: AYBFou38P0azhs5DbOYwIcvxZitH5RW+v4wx/l7VgzsjnaIt7/jR1IQRmn+txFg+/QA
	40rxkqBDM8c05e54hiP6pBZBKK8ikbVoMrnxWPhx5SP79mMnY07oK7uZzDRLBkUqI9B3WChG61+
	WDgFqmws/sAB7HFskHom37aIWSvXHFLN6L2wrIlBg4iMr+1RGNlZrW+Z5l11t3j40uotK1r6Hnd
	Nrsg1r7jdUa/t/nPj/r9skOfwJWhJVAWGTOBDwRRhmuQ8QYOco0yVZGYDdwLR0sfk2eduxzG7Vd
	NUChZ5kZyt9kuoRzpRGhhjEEMjM7a11ZKs3aoGw2o6qx8efYDbk6vEJRivJVQoaAUDkWVnJszNv
	6H9KxvdUlThG1zo878xgwz3k8lCjgtlpjgSPlg/HgctkhG8jB+epsyh0JyKl5FVwV+W6iLA+Iom
	hRZ6lqgBM+MV2zrjIh6HQat1q+D9UyXsZ8hf3uKLwavnOL9FewAbw+ZKlWKhC+YMMMdhdfmAEa8
	Q==
X-Received: by 2002:a05:600c:820d:b0:4a1:65d2:7912 with SMTP id 5b1f17b1804b1-4a18e47b302mr284790065e9.8.1791982790508;
        Wed, 14 Oct 2026 05:59:50 -0700 (PDT)
Received: from kali ([169.224.126.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b481b7f8sm53105485e9.3.2026.10.14.05.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 05:59:49 -0700 (PDT)
From: Ali Firas <alishmery18@gmail.com>
To: netdev@vger.kernel.org,
	idosch@nvidia.com
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	razor@blackwall.org,
	roopa@nvidia.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/7] vxlan: vnifilter: bound a single request and account per-VNI memory
Date: Wed, 14 Oct 2026 15:59:34 +0300
Message-ID: <20261014125934.413864-1-alishmery18@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179198195143.320699.130100546123857623120@kernel.org>
References: <179198195143.320699.130100546123857623120@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 10/14/26 15:45, netdev-bot+sinfo@kernel.org wrote:
> - How the issue was discovered

Manual source review of the vnifilter netlink path, after noticing that
vxlan_mdb.c range-validates its VNI attributes while vxlan_vnifilter.c
does not. Prepared with LLM assistance, as the Assisted-by: tags say.

> - Whether the issue was actually triggered, or is only theoretical

Triggered and measured in QEMU, from a user namespace holding
CAP_NET_ADMIN only inside it. There is no stack trace to quote: the
symptoms are rtnl hold time and uncharged memory growth, not a crash.
The changelogs carry the numbers.

The cover letter states this is a policy and hardening change rather
than a fix, targeting net-next with no Fixes tag, at Jakub's request:

  https://lore.kernel.org/netdev/20260921150904.65a704eb@kernel.org/
