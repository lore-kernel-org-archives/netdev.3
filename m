Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BD93CB2FA
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791979098; cv=none; b=F7BND9Bf7VEuAdt8zamO0cynGMxoqWxX343fwnXWfCFcldITug7VV2tBHdEaT1UY/nGkQkYiqPaPBYoQyNEkl3flxwEw4+EnrLZqFPuiQ22qjNYxGS+vkkLSvryPduS8Z+f8tP4SBThM/Wu3qc870yEDvTHn0FgK8nhOLv/ke24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791979098; c=relaxed/simple;
	bh=x4/JSKwPdawieLVNdXlh9IM+37VIL0f1d3Im45Xk6NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8Mbt3uVIpnrdiNcBS7DGR3ssexL7dUaxzjBnG58/og9Or0tuXUpnfzmue9k+8rHdBZ4uvJsh7tPxrOxf4goq6Xd53EQVRgrq+dbqhRAnSX4eHLIFrU0f1+7mAbAYzli1mL+xqBl7aGXHjDc+znO6Xf+FYWbUxSferBr52m4hRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=DW3yEtUj; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="DW3yEtUj"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30b6dad2382so9281993eec.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 04:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791979096; x=1792583896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NiyPn/AszpmPaeCiQUAJFRlFHnxES35jjFpllUD/s/4=;
        b=DW3yEtUjcchi8sjPJA7tvhlZi/9vwnwQHKPoIOwTtXr7WnhAj9dvrF8eZv09E3jLRL
         lix3I49cpZY9WzW1O7d1dFN+LVCsVWRH7L0qJ2kxBD51fwVCgaBhQ+prL0aHtO6HZoe1
         uO6DnrS5Av1btG3UI9VDszXrYMpgIIOCVqf6AzBy9xNmaEo5b/JyUjrY1+34ETOHN4mN
         hxuWZBKAsWOka9jOWuh8BycbuSxnZJmxFFjV5iGJ+Td+Q5iCGrrVM5udeG/bKp80O3XI
         pZLpFO+cvRqkqQpyqnbUpN6RMY0QwyDe1r+ZxQDL8DBk/vYWpEeTwOCNvRQQ9ZKqBJ3p
         LAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791979096; x=1792583896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NiyPn/AszpmPaeCiQUAJFRlFHnxES35jjFpllUD/s/4=;
        b=OvvMQAwdXTKeME7CwP/hgRgk4iwPcJWuLsPe61dJ6+rgvBE5n++sr/jIju2FKkrhy0
         AgdPLBI+Hwvm2gMsu0XihotaUb1MW7HbbP+mOQntdPCVd482KcQIca3jVR+DdaNVfLRz
         P9hEgSMbN0hYqywd7OyNCNZkzGdrPEXDv/u861hMaAb+MwBOwnV+A+t7juTnYVVNNkWI
         nl8w0Zdobj5a+2TU1qs/pxeieXfqQt4HKa3g3objd3XggxUSxblru7IBdlnynm7JsgHy
         lYvSy5wGsSsuT1wEGgbGaQ2VnB4Ovu/FAkGnz56+kkcbM3OUk5UAOAWnTCboIKCqzo23
         O8Zw==
X-Gm-Message-State: AFq9FYKKnqAdhIZk0ky6CkqNCUp8CEdznNu3MltCneJY6qO5jBppwru/
	EFQn8rhjWMSJlTTl3LFyzSd+/zJWl6Jzp8wBd1olNXB0LhQvO1mqHVG09BysVLENEe/wOPVHwRY
	Cv/KCev/Pq1w=
X-Gm-Gg: AYBFou3cAixdgMSX7DLRfyzEslCIuQ9ktveQugNf5T0IcsHOIaYEh2kxTRjoNP13sfz
	sBUwhMJB7tUkq/fQ3YsWqTl+ff34Sc0T227VZxDxh5aHwrOCJBpJ3U08AeWsG8ltqs3qZhf+jm0
	SbocIRMpl4TPXdjka1LJRLeDYfV4jVwJHk0aNxtoU8RI6CJPjknXuPxdYZ4q2Xi6YMzs3FcqNnh
	MFEitJwc54sn3iDPZ6AnCKA/iF4bE0ooKHTiaJxzWYlBdZ95459a5ZZ7ZvOEEf1nXz6NtZ6RNIh
	k/VYhBUsuSayxlakBzDTqedqyvWDj7wemTnEmLUzVCbammlXTChalJAKJfbvCdbHdltWLMgLUoZ
	npoR7j1/lcbTPm2+gC8UlpALXTc+tC1MMrnwkWrDv43UylZE7oy2LkiY5q3g+lnPLqeI4Z/V706
	zrtcG+3KfAwa/JGKrrvIQlaztO1AaOLzCxPvVlhtNXhW6IuUluCM1wGwYhRUTFO8mE8OV4W8kQn
	1qcNII=
X-Received: by 2002:a05:693c:66d1:20b0:35c:9ef1:a1 with SMTP id 5a478bee46e88-35c9ef107bcmr5898849eec.5.1791979095733;
        Wed, 14 Oct 2026 04:58:15 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([2602:feda:30:ae86:295:dff:fe84:68f4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35977229a6esm37796346eec.8.2026.10.14.04.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:58:13 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	zhilinz@nebusec.ai,
	martin.lau@kernel.org,
	kafai.wan@linux.dev,
	yhs@fb.com,
	ast@kernel.org,
	vega@nebusec.ai
Subject: [PATCH net 1/1] bpf: reject unsafe pointers in TCP congestion control access
Date: Wed, 14 Oct 2026 19:57:57 +0800
Message-ID: <ae0f5aedfff54432f75c7bd4d369166c028497b0.1791978740.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791978740.git.zhilinz@nebusec.ai>
References: <cover.1791978740.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_tcp_ca_btf_struct_access() authorizes writes based on the BTF type
and member offset, but does not check pointer modifiers. A BPF program
can use bpf_rdonly_cast() to create an untrusted tcp_sock pointer and
write through an allowlisted member, bypassing the read-only cast.

Reject pointers with unsafe modifiers before checking the type and
member offset. Trusted struct_ops context pointers retain the existing
write access to the permitted TCP fields.

Fixes: a35b9af4ec2c ("bpf: Add a kfunc for generic type cast")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/ipv4/bpf_tcp_ca.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 791e15063237..252cbfe11e69 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -65,6 +65,11 @@ static int bpf_tcp_ca_btf_struct_access(struct bpf_verifier_log *log,
 	const struct btf_type *t;
 	size_t end;
 
+	if (bpf_type_has_unsafe_modifiers(reg->type)) {
+		bpf_log(log, "write through an unsafe tcp_sock pointer\n");
+		return -EACCES;
+	}
+
 	t = btf_type_by_id(reg->btf, reg->btf_id);
 	if (t != tcp_sock_type) {
 		bpf_log(log, "only read is supported\n");
-- 
2.55.0

