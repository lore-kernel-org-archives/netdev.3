Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793860626;
	b=f5iB8ma2H141NSJT0WmWfLP/q8ImXA5LIhErTqYSKC8DFponHRuATxaE4bOgSG4bLH2y
	 Kgv/kUj6KxXShFKsmG0AhCax4kDDuNwGTQLbOFP7jp/eaDvt0T06PsIuKS1X/Ppgx7m7l
	 e2Q9uwFA2Cl8AtK7VrfYkaUEM/VtYOtmXeRspedv/9WJlXkvP1aGRLTSpmNqEJR7TgTBJ
	 ZXPc5Vi1HTbjijHmtY2WQP7/sECsEQAhli9ZlKRC5h6qxnX8iailMwmS4Grg9HMYweKEc
	 f8Ja5fPdtK8asFnE9bRAdpkLTai4PTZdxWhhfEDtoaJAEBPDOixiqNpjp0Kui4fNTCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793860626;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ri6QhTI7eIqC2wOgZnfY7LlsXr+RKpA1hIBgc4QsOtw=;
	b=lZrXsCilVnSPiaZ4XXGxR2kSS9t2KGx3xW186lIRikg+lwUy7vrdkItJ5NzaAwW0N6da
	 QJ12DP5xwEJKjNuwY3hT3nCo/M39+wrMNUNCF9wMshhMtLqHSFoHP6Ofquy/a91YPpZwJ
	 d+tpmmxLBi/YT6F5zs0NFRKDNhcW3bX6pyvtLIx5SsdIDezJtvRd40fGjjl2JcAg/gng8
	 XWE1e0Mdf7UMRERfUVuleuavF9cG1EFDlUxvEA5pvh74CBjxUqhGvMk+CR0pm3sBJAY81
	 hzZDQT9oLk4AzWL2cCw2h0NA+nYwpY04ynBstvDg6wpVS0OoA3m210yOVqf9fMAVjmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xivW+ZvK;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDCD606A328
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 06:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BDCD606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xivW+ZvK
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b244fb7fffso2085527c88.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 22:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793860625; x=1794465425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ri6QhTI7eIqC2wOgZnfY7LlsXr+RKpA1hIBgc4QsOtw=;
        b=xivW+ZvKGqGXv9ZTf3/jIQEbyfh8//YBBmqTy5ejfOMUvGL7/u6Ccyz2to63bHTeSO
         vqfdblXuM8uNivTnQCrLTkswwS0s1tJeGcX+BJJMCfTxAtokNHbDQxK28ggaEHHSVOw9
         mhmUXNY3SOEGgxD2XLrxnfUqwoP0UfQ6CIYxlxijHcpANYqT9jzDKaUcpsvRmTq/8IAC
         KCTarXhax613QulIdNZFhUFZiFpNID24EN/K3KsDRMqQegnJ/m6wQyRMpTMU0b9A8aD8
         KHmDmlWUX5aX+E8u725FPO4SjRMj8BHf738JWHnbVBTIGEtZFdf47RB8z/jvI52SCLkt
         vztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793860625; x=1794465425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ri6QhTI7eIqC2wOgZnfY7LlsXr+RKpA1hIBgc4QsOtw=;
        b=T/o38BwsCIvMcOrk6NUtuK8xhTOMqUqUcI+DeO8ckxNmYH6ZRZguK2QEShyaTUWQs+
         TvzpmcOhOUaBWgQECO+lVOkfX18TLMdMCBB5lJIUpmH+CEFw1uonPvkGOcjgYDe+xFSF
         JYaSSPZpDM0M/Gk54vj5pWad/4Km9vXjgMkAJoAWcfcc5RGd5ye+FYFxVgcVgahL1g6m
         oD/boMQrMO5uYn4eAu4tjdLNqpnqxSnp/xydwfPHv2CXERn9nLfnTmBqcIh0B+VfSFbf
         LItC8zBYr6AWoAmsZfuF4lq/DrSpRW2sPl9xx7N5ULhOEYdAAUD8TZz9sg3pAFG6Rgfv
         mPAA==
X-Forwarded-Encrypted: i=1; AKwUvBwckRbJ6ACjNbOKEsRRfNN6Sh/eQv6aH2hjkjvpncNqbehQgDbYL4XhQBp9KsbtNYYHunoiK1o=@vger.kernel.org
X-Gm-Message-State: APuU4Z8RZKdyJZzHJkmySoVu4cizBI81bRVJuCcxZTz1VNVO4Bs40I4q
	LWyh99LmqiVmng0mNQAKpGpZzTwBp8sowJB8ImCpQLM+tcv5zFuoM3DG
X-Gm-Gg: AYBFou3L+/7E9Qm1EbxfA7KIhIHTb/NYSL8zJhyE/oQ0ZdkWckza1qmgJwxCEpmb7yP
	Q07ytt6T2N5ckAd2wDhUyMklzfER8yDY+dGtHtT1LqTXn1SvVz1VuX16GkmcCXlnHYPrMraFxQW
	Dj6HK2i9/QYB4sCmYWSiTlk4OfEXPATBXq2Kp9IFNHCwM/mq65OWYt9aLkqWRedIFiDgEnDCYxR
	azh7RK2KYrAg/oO48pP1PE41QLtoPZXs5h+6xR+JLXjnD8+q0A+0B9/B1/ksC4ikAx602zWeHKr
	77iB4rlEp1YAk01Zr+LUNTU5KMmtltwWjlxRcJgNMNa+qinD3GI29F5HyyY5fRVlfQPUjZuBV1S
	F9xDL7kG0hYA3BFyQEE57yS652kG+Oz7mIm/MAm0snp6lLRDnZwdd+9c7qmjKJTdjn16u5AByGI
	rioz35pm677ucmhP5upTg8YAcM4igHqoRi0+tYPVMTmGLPK1KFy+YxWiI8Q2tcYqpArvPdq4zhu
	4vCzXHab102kFQX90qOPic8vAru6VCRrkOG9nji8d4LpSQqlheJkuKXm3RyPyxALDOFPzMD2Sm+
	60eDQ/BOT3xT74oDk9MSpXkkGMx4zMZ9HE/iPkA9LGa6QNwkEKhZl7HthJQ/Q+lO/hbc99sLImh
	W
X-Received: by 2002:a05:701b:455a:20b0:1b2:42db:8a54 with SMTP id a92af1059eb24-1b242db8f29mr8683525c88.23.1793860625118;
        Wed, 04 Nov 2026 22:37:05 -0800 (PST)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36d34d5960esm13148900eec.5.2026.11.04.22.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 22:37:04 -0800 (PST)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Xiong Weimin <xiongweimin@kylinos.cn>
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] vdpa: alibaba: fix typos in comment
Date: Thu,  5 Nov 2026 12:06:53 +0530
Message-ID: <e68b7938e19affe2b18ba0ba9711e079fe1f7084.1793860522.git.hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1793860522.git.hemanth.selam@gmail.com>
References: <20261102043526-mutt-send-email-mst@kernel.org> <cover.1793860522.git.hemanth.selam@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment above eni_vdpa_set_vq_state() misspells "specification",
and "ENI is build upon" should be "built".

Link: https://lore.kernel.org/all/20261102043526-mutt-send-email-mst@kernel.org/
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/vdpa/alibaba/eni_vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
index 1288402d3dd8..af163b4f9259 100644
--- a/drivers/vdpa/alibaba/eni_vdpa.c
+++ b/drivers/vdpa/alibaba/eni_vdpa.c
@@ -276,7 +276,7 @@ static int eni_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 qid,
 	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
 	const struct vdpa_vq_state_split *split = &state->split;
 
-	/* ENI is build upon virtio-pci specfication which not support
+	/* ENI is built upon virtio-pci specification which not support
 	 * to set state of virtqueue. But if the state is equal to the
 	 * device initial state by chance, we can let it go.
 	 */
-- 
2.48.1

