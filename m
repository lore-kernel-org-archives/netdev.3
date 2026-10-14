Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6044B1468
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980670; cv=none; b=etzM/jk4p4i4QY1MbkfmEG6Wh6SGozTxE6ClKu0d2DQcOH2lDsVukR2mUxpfO8u6cQslYrjoTSfab/yP1dzzy6iJd8DK0O/2sTQ+4fNWG2MRaCyAbz4UXwo3wYo6ODOtmASWYN7p0VKwvoEeVXiu9MboGhknc2Gxj0h/nBHfxC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980670; c=relaxed/simple;
	bh=krNlRx7LWfz/eytdqpmzY0MvXdkYvcEi0uORY137LHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdfg7lszqU8k0P9yLu2qFvcIrYmepVwBNwnjV1LANzZUnVhP/gbXfrrxD2WPFhMdpfoBGDpzt70Jhb4cZ6Nd9zKM9J1jbU9sdBjxaeZ/U8q2i6wTmqgfZnWcgqPIiB8dti3ZCweCepDZ6AJzpQwEmH3IBjLP6OajqLdwbKHZ6qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=rdhF4f1x; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="rdhF4f1x"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3535a54bed9so1291010eec.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 05:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791980669; x=1792585469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l6i5RL9EhIEkzGd5o1z6sDf7iTmDAEE0DknjVLQl/+s=;
        b=rdhF4f1xNNEolpukEM/XkZgVGg2df0U7nF5Lg7hsnoxEX9tN/ruNSIqxXpKeFz3sRY
         ekdx5GPbPmBAwSxUtvWnfM8yVQuKJ9GkjzYCTLuYwvUdEE/bzwUXqqVdjCHCg1Z5FhZk
         Bh5TZ0hNBmw2CjdNOEL97ynFdrb0uWg37PumqNSeJF+ArePT+nw5Uz0/zEMiVwDTv1ws
         dRRADVNodSeRy9kE96S+vy+ZbSiPW12m51H1TyRrFTAWz3CusBr+0Y5CnIwRy67tVFB0
         zOkvgFYxbB+LyNv92EXdpNJ3lvYvbuLwtICqWhjLh3KGit30x3chj3Tu97dckl0FGFkG
         C0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791980669; x=1792585469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l6i5RL9EhIEkzGd5o1z6sDf7iTmDAEE0DknjVLQl/+s=;
        b=P3/byPCQPTuTG8vT94BtfV4/gKmlKWmLR+9r6Ah0o1jZEkPO1l7i8NJB0zz3QRkmcD
         bt7xynjpWxt07OH02In42pnHDeX0mZpNdNizb20b7E9DMxLr0hHerhEoTdDSlGDtp2Ul
         LVCRw9ou/mL9LtVKlktU5YBmPC6GA2eEqsHj3/TPOPbDBpTAnIqqX4U3Wy67LBMahEEv
         DC+kbKGchPl/D3LMrQS38bPODUGcIc24dfq09ilVGYAWVL/43+aVsi5VJglGTrJEwRDB
         Y8z3MPFxMZ6lJm6N3UV2P5bfn0GjIyjm/PP7m//rBaHB/836/hG097I7P8tMVgxznDQn
         Jp4A==
X-Gm-Message-State: AFq9FYJq3SAuQFMlMptEuLXbTU0pfC3T8r2YzDZ8LBQ5JHvyqJHY0l0Z
	6X+AappNOsD/NJ/6AuA/3xV/rptNfRs6Yay1z0ioXRNYF8nY2NDA54O6Dr3oWCn/NS1pYXhhJaF
	HcJKHTQijfQA=
X-Gm-Gg: AYBFou2KqXmqpBvf7xB/bf/CZlsxXlbidnSLFDTGCfhbKuHb80ipN0xpocFrTcqu3cF
	OTDrf5pBsKjO9DlzsXslW8MPLpNxTV9SdW+gYtqmOHXamq16Vd6VFx5ImNy9JzQbUcjLKYzOfgE
	vBcf1No+8b1Ov046hc/GURAgWcLlDh/q0PKBvK8kspEnrBfHaCnv2GY6Ms5LaIlPfnjddZp9Znu
	PIs2Hl7ct1sS6V7yQOYerJYyMldC/ayID2xbMqp97Uxu0ekQwVYaDRpaZvu/ZdevksaaQVgscon
	/GBRTVCQ5cwEQ4h8c/HQl/Zx7KlrG9zYIpPFvu1y+GdC0dTORs9QNdRuORJMsJwQl93Z4R+2iI1
	p9b/YFEnIyxLNQjVmSikE77NJO9m0XgOOt8lVSG2uk9rjiZhLSCnRyjZYImOJmPB/EaFnqhTS2t
	qbju3JcTrdkDTKh8B83ZpVKk4lnN+o+cr+S+bkcefXn8MAm4SYpLLDjFOPVzgO99BIxj4qTJvBb
	j0fVBOrD+5p/pb+Hw==
X-Received: by 2002:a05:693c:2289:b0:34b:5ab2:e200 with SMTP id 5a478bee46e88-3537e0788bemr29312073eec.14.1791980668633;
        Wed, 14 Oct 2026 05:24:28 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([2602:feda:30:ae86:295:dff:fe84:68f4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-358ee8a3387sm43357994eec.15.2026.10.14.05.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 05:24:28 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ameryhung@gmail.com,
	ast@kernel.org,
	martin.lau@kernel.org,
	daniel@iogearbox.net,
	leon.hwang@linux.dev,
	mattbobrowski@google.com,
	zhilinz@nebusec.ai,
	menglong8.dong@gmail.com,
	kees@kernel.org,
	bestswngs@gmail.com,
	memxor@gmail.com,
	vega@nebusec.ai
Subject: [PATCH net 1/1] bpf: reject raw iteration over managed sk_storage values
Date: Wed, 14 Oct 2026 20:24:07 +0800
Message-ID: <1fa798d444efac579e91ee0716e228902a8f9afe.1791980149.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791980149.git.zhilinz@nebusec.ai>
References: <cover.1791980149.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sk_storage iterator exposes values as raw PTR_TO_BUF memory. Attach
validation checks only the maximum access against value_size, so BPF
programs can read or overwrite BTF-managed fields such as __kptr without
the verifier's ownership checks.

Reject value accesses when the storage map has a BTF record containing
managed fields. Iterators that do not access values, and maps without
managed fields, retain their existing behavior.

Fixes: 9db44fdd8105 ("bpf: Support kptrs in local storage maps")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/core/bpf_sk_storage.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 1d295a8769fa..b54fd90d4bde 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -863,6 +863,12 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
 	if (map->map_type != BPF_MAP_TYPE_SK_STORAGE)
 		goto put_map;
 
+	/* The iterator exposes values as raw buffers, bypassing field checks. */
+	if (map->record && prog->aux->max_rdwr_access) {
+		err = -EACCES;
+		goto put_map;
+	}
+
 	if (prog->aux->max_rdwr_access > map->value_size) {
 		err = -EACCES;
 		goto put_map;
-- 
2.55.0

