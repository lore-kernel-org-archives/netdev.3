Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A455136AB6B
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 06:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774938079; cv=none; b=TFhOTlHOWdp/6brpfnm5IQsRW12jJ2dvQvCnTlN/WefsmO1rcs8ChPXqZ+KgW5PR1dL+VSTCoRcKy1FVTo4HP1omzj698PG2XVYhtA50Jl+dkOiqIUzkPdUgAp/TOcSGMOMs7udMMJFvCBETWTS9AyDd0QSohQkOHHpM9JFtRu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774938079; c=relaxed/simple;
	bh=d+BgWTs2LBjFSXlYSbG7Dx22AT17F/RZ9tqj1xZgmWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1JAO8dfecY26S4qOpywvm6YbSwx2I/9YrodcNSbriiG0WJdAR/VbOCb/oP7V93fQi02h2nlxmpXvwvmaMFiZQ6t+h/PyO5MybGZSFu1FLerr+3RcgFgjBpV7O84dx9u8eWldERfKavWdyJkWTLKCjRfatk3UJL8fqQYxJpDrvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyaehuUK; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyaehuUK"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c70fb6aa323so1936568a12.3
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 23:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774938078; x=1775542878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+BgWTs2LBjFSXlYSbG7Dx22AT17F/RZ9tqj1xZgmWQ=;
        b=KyaehuUKMiPsSs0lLGiczKiYeYQxLMkfuk3ie1vMOn8n/BVVswn4HPBUXVX1HkgXvt
         k5UA1vBkPqskDXcVhOYWP1PMVRPJGx96RX1kTkqlEnqP5s0uFm3aEM+YrPvwszKYCqYa
         yGHhW+SO6FgIzzug9RFo5DTLk5srMVJgHNgVpEOjud/AvGRZV5dCzigf95PofIS/vjqk
         UBVhmJMEG7cauXWlmyw95PEI1l7+EnKfsJIOTpmIIEnQEVdzif81LQM7U3rSL0Qwn/A3
         gLLBZJpkkx14N7Q2DrBbx8olSzn79YYCzMR1YOhtEmtAt46BICc5LCnMhxW6pEFDaU1v
         xYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774938078; x=1775542878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d+BgWTs2LBjFSXlYSbG7Dx22AT17F/RZ9tqj1xZgmWQ=;
        b=pCby83+tZ1ssnCiOsJXWeFdf3Sq21puDzxH+zKhuArgEq5TAFszsn41AW2PMDy0/s6
         ao3vZFgWXaoO7iQAIZDJvaalWXGG1QbEozsYPQAhsW0mxyRU900P9x4L9gRxJRUKPMd3
         QYUfA2YcNB35LD4j9Pqa0cc1NTBQzPmQ+9K+LLeUz2GDhOVUUVFGf9E78HGrm2vRfTQb
         9uf2fHbUCobyfHgRHjy7YXwgCaugihbQkhce+GoVFhloyep69Yu07ed1ymoiZrhlYIRW
         Jy3CEmLzEPncD+c8GKTPy23hUugtBKn44dR9Wk3mKPxwFRUWiJXqEiepM/JJuqQL1r9m
         6npA==
X-Forwarded-Encrypted: i=1; AJvYcCVboQvW9yeZjsL9/zSGccYfGrGu+Aqn/dMnoW1ao8pWhwXiW0MqpQdwvdo0jLLcFlct5GRvKh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUfTZeuxBfSOrGMkVnsTrkdwXPlu8UjTBEFwqiYJ/ZL96QeVc/
	GzKf+lolX6JBUK/fWYzVe1vap8tyI+I19/sdlm3WY4SGOLuAXeoau76k
X-Gm-Gg: ATEYQzzGGKjilc7PmuEPebpMQ4G3J+JcxVv5g0URMnImHhVQCSFOl1QcUu0fxtzFasx
	aVBUl96bCybmvON5WppGEDnvIuVrzy7UUGpH+G6EXg1RGWKGgBfi2LslWOUMNIfVXmhGqbEjvvX
	ONAXWhSMscQnXJemwwOQ1Z7Apk3Sj01UXEba2FbgKz1JNCHEKtwhNBFkTzj9N2iH3zTTQkv4rDB
	nItC/L4u/M/Gmin8tNImBeVhA8a5rOy1UGQGSHF/jwcilOCbGknT4aExgcXujlfwdwExYip+Dbe
	zdSEfOutMusZc7smcxviUnJBv69/rt+fSdU4V97OpDTBpSn5A6I+vCReH1TOaTOoi+a+sab/uwn
	5JeQ5PlQh0RzahME5XgTlU3t74v45YaWv2m3tL49i4hF/PkKVGDwp+Jmu/aKVpsOAzGm0Ra3QP4
	K3wcnQvZ9mPN0xwusMwufQvcjpTp/CXxSQ6J8=
X-Received: by 2002:a05:6a00:288e:b0:82a:64c7:8c6d with SMTP id d2e1a72fcca58-82c95e5bd1amr13385091b3a.25.1774938078015;
        Mon, 30 Mar 2026 23:21:18 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85d3a71sm10696398b3a.30.2026.03.30.23.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 23:21:17 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: Re: [PATCH v2] netfilter: ctnetlink: zero expect NAT fields when CTA_EXPECT_NAT absent
Date: Tue, 31 Mar 2026 14:21:09 +0800
Message-ID: <20260331062110.87551-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331061434.84238-1-tpluszz77@gmail.com>
References: <20260331061434.84238-1-tpluszz77@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Please ignore this mis-threaded v2. The correct standalone v2 has
been sent separately.

Qi Tang
