Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4C3480DC7
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 13:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791205736; cv=none; b=K380u2YRnjgFKLGGHgir7VViYsqlq7kFRaHeL0mZ+fpGFr7IjI5C+gaRSZgNHchSd3f0eLEoXM68sG84l3E1v/7fs8eyC2nunSzaralp+tuuVD8mru6a8hSun3bNcXHOMKLmYV6NHlckbS+t1Rg3GxxkriWNx9VGODluIUraU4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791205736; c=relaxed/simple;
	bh=uTR7vGzEmIPD7bRE8b650ZWfWiO6EfEmpDypUW3oZQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q9ipP6oMzmmAsuV86A2Bp0XABlopG7UqF4O1OTFdY+kuWawDUf4Yzeytt9XSYZQwnCok9TXfPWWb9yqLsDydiQ8+IfLqjbZaMQCWtopSBVtG1aVXxiCxiJ+1pJ/uVE3L7xyzwIZ4ySqWrQFx05s+PG+jYhfpZrUtWH41oB8pV1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bo5u0KWq; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bo5u0KWq"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so840928a91.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 06:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791205735; x=1791810535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pzGSAE/R9LcQ+GhEQ7PEouw8tTP8F2nUBfFpq5GSKUg=;
        b=Bo5u0KWqeS7jmVwDbnoqXv0/4XlFzlvz/j+vd/IJ06tpNBDKSe5QNImemm4z9ts3jl
         0NJs+zGpIYLUaEgO6VG+SrxQmgQihN+bJBl/TeX4ySBtUm9AQdKK1zPVPGDDhQ7JinKc
         rmjBviMrESTwYY+/HdzPAPeyxopujAkhOn92AoAnUdS4LIRqwfy5MtYUslliZG9Od58P
         nEY9YWp8plDCRzsFeD+SmKuC0BV8nCW5bsKdhjM2h3RHC0HRMB4G6uW5ACiljbJshomC
         K89oaKOJarh2urR7BIm+9+yX49nj9upxX+DgcgImVrsAfNOlEw4qTsdLL/6qyXUNr/mT
         Nwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791205735; x=1791810535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pzGSAE/R9LcQ+GhEQ7PEouw8tTP8F2nUBfFpq5GSKUg=;
        b=neFSruL5STtGhYn9WgFibcCO1AxGC6jnydPorS4C8Lty8OdVJLD4du5aqO9nLTAoQ7
         K6iZTZCgZ+BpVtIvb6W2cm+7zBdmRIqUYvPttfmG/1fhuOlung6HLOH+49091iSXdEUR
         B1x6qXsg3CNltfCjTSCTdRxV/Uqgce+69IzXe1DCtRq/iXMnyCKMzgSrudFVRRcukZnZ
         g3rE5SPuM9R7j+sRJuJJvio8TKSQtWay3s4Yab02Ptb6F9pD0KuqeG9+wCE5J5fBfwZj
         D3yz2XzE/mvrESaBRSjZzM9rVQ4ZfyJwnHS8k2r/TSqxSJ/CY6WybP3xac9Tbkt5R7w5
         kuHg==
X-Forwarded-Encrypted: i=1; AKwUvByBCoRMdMcrxRQVwZH6v/z2/dq3jZ8T2Ib1OzXnOldLJojRSB93aFc2qxud7CVdmdorqOy0tOQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSyFqVYETaZXIp0KQP9FX0hcayTVJHQzqoLncBt4qtgXQwTwQF
	/uYtgELNq8QEl7TvEcZI6v7n96/zzRkyANtdxRzKagVOvOY3FYkktnvrIpR66PgpKPE54w==
X-Gm-Gg: AYBFou11BcAX8afwqzN4EozaJhPejNj8GWM4YeGzTqZQ8G8A/TeYHpTs9XYhCCqEbnF
	RviEdgybb9mZ4fy9gOw1+ID7OB+7Lw+rhaEMYhYzOp4mieZs62MNcZAWxu8uoLTZbe5KBursHXn
	bZAHxYODDxUo+C8ILNj/3qNxW6vm1KzwWhey3jwOP8x4RDJVoz1suKmIyjZhpeyIXgmXNRPc36u
	jwe5AHlU80tDUGx1wNevmwoh8GNCFzXSWKRG67xqGzq3XqwcmZJ4c/qIABObb8A7y+qqD81um9K
	RhxySISuP3aGdaESpQNoNB1a5VFX7CIu8lJEp/wbM/3gmxUn8NStNEDqnBxn06TnE3pMYrnDi8J
	IT5mvOlRIjSGmleuqKNVi+ZmuaDe0EK33HCWFN4wCsPL9qYxqjbRTUkUGGGvTxkggTj2q4MH3m0
	obtpzPCOSLPm8LZTmU6ybStjleOZHrgGuOomylp8Co26di+UoEa2F3BBfvnPcdzgZFn2UXgGaok
	vMoopee1wr2sg==
X-Received: by 2002:a17:90a:d606:b0:3a7:ada8:c18f with SMTP id 98e67ed59e1d1-3a7ada8c957mr3782621a91.24.1791205734543;
        Mon, 05 Oct 2026 06:08:54 -0700 (PDT)
Received: from localhost.localdomain ([112.49.112.188])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cce6d429dcfsm829741a12.7.2026.10.05.06.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 06:08:54 -0700 (PDT)
From: xiaoshoukui@gmail.com
To: edumazet@google.com
Cc: jmaloy@redhat.com,
	tung.quang.nguyen@est.tech,
	netdev@vger.kernel.org,
	w@1wt.eu
Subject: Re: [PATCH net v2] tipc: fix memory leaks in bundle and fragment paths
Date: Mon,  5 Oct 2026 13:07:29 +0000
Message-Id: <20261005130729.36294-1-xiaoshoukui@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <DU4P189MB3750FD6F099BF5A2FFF92F05C6962@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <DU4P189MB3750FD6F099BF5A2FFF92F05C6962@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Eric,

Since you previously provided helpful feedback on this thread, I would
appreciate your guidance on the appropriate way to address this TIPC
receive-path issue.

To summarize the current situation:

1. Demonstrated issue:
   Streaming 30,000 crafted TIPC UDP packets to a 4 GB VM reliably triggers
   unconsumed skb memory leaks originating from
   tipc_buf_acquire() -> tipc_msg_extract() -> tipc_link_input() when
   tipc_data_input() returns false. The memory growth eventually results in
   an OOM kernel panic in 14 seconds.

2. Benchmark results:
   I re-ran the benchmark for 10 back-to-back rounds with strict CPU
   affinity. The results did not show any measurable throughput regression
   between the pre-patch and post-patch versions with unlikely().

3. Current review concern:
   Tung rejected the v2 implementation because of the concern that adding
   caller-side cleanup checks may introduce overhead on the fast path, and
   because these malformed inputs are not generated by compliant TIPC
   senders.

Given that the remote memory exhaustion issue is reliably reproducible, 
I would appreciate your thoughts on the preferred netdev/TIPC approach:

- Should the TIPC receive path defensively handle such malformed wire inputs
  to prevent unbounded skb memory consumption and remote DoS?
- If the current caller-side cleanup is not the preferred approach, what would
  be the cleanest way to ensure that the unconsumed skbs are released without
  adding meaningful overhead to the normal receive path?

I am not wedded to the current v2 implementation. I would be happy to explore 
a cleaner, more effective fix based on the maintainers' guidance.

Thanks,
Xiaoshoukui
