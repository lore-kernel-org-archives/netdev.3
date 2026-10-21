Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601356;
	b=0ymM50BeWknsfeqR1JYKml29PLDxYg4EoGz3kQ6uOLzjFg43a8rutptbNjqlGZvl8Tvj
	 tEY94uZQlOpsS8BpIgKFQNClwEHH+XIlvPKkKLgsCTBfR8/qR22XetQ9v0+irBRDOQXS/
	 uFqLJ0gUMqhhBfogbuT4u8du91bf0k7R08AkJs8c1zPHz9KgqGOL6OrlLhqBw9iehUAOw
	 mfjmUXiKo1Yjs44EAIcy8MtQgz5klDiR0lUVP78nQZYGsO+mvniBdKUxV1E/pNlnTpDYY
	 5Vx3lw7pH+ln2dln6EQVnqNL6shjCtDTAMSDLSBn6BoH85PzSQZSgIBXIbZWrMKP6bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=KIQ4ZqYz7cbk1WpqhsyeBWWR103C0oZ7ZXL7of+RMlw=;
	b=aj8il+aa0XsLmjWEnqGddWFK9CXIGeSivcYDsBJQdnvxJk42W2G90/SdlvluwUh2U1kY
	 GYi8zxDc10Bw4lvjxASXcPvn7U+uvLK0VPFSkry0AkA217qo85NfRP+m6tXHJp35EWAup
	 BfhFVsuLvdFCQWBo5m7+Fhr7PksYUL2XTLL1lB3yqmPwh1fWmxDTrGUoqnkey+CwBMusx
	 YlP+RUqkLi8oUPAWuBljMjcv4xRWDWU1nbHpf8VrPy4Ht8MkpGJ4ZJahAWDOOG6pCAsKg
	 ntNG0fkZKFIkOlb+5ZrpdicoP258aczwhVQ2noYxbLbPk/Pk0spKi8UpyCc5HgGGaDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g3ArpmUt;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4727F606A31D
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 16:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4727F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g3ArpmUt
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3a7cfe8f761so27416a91.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 09:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792601355; x=1793206155; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KIQ4ZqYz7cbk1WpqhsyeBWWR103C0oZ7ZXL7of+RMlw=;
        b=g3ArpmUtemRDXn9NQEm94F0hdVHhOiv0ZuJaCx5uSGUxQVweKsEwXtcqJxfA84aNFk
         OZ6JwCSsz6kaHDHQMswYeRY6wuBTnS6rG1PhlBHD2/bIBXCJgjLuwSEkcq4vDp5iETnI
         mCEY0xOP8mFZUVmIp3/9UlrHArGSbiPvex6ywHhHktgOVAaV8G33PLHvt9M94P0qCdSZ
         ixlKFiXVMyyJ3r9qg0mzMFTGnbWL4Iq1uVQKcyBuqeJgmi/moeRik5Q2zoYV/DzEg3VZ
         4mAPiF2xQCrXCJkUmhKZIqbpa5tdu2Xh4gZC94fVEff2wuwu6Kzlx4ylEdwrA5bHxthu
         Wwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792601355; x=1793206155;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KIQ4ZqYz7cbk1WpqhsyeBWWR103C0oZ7ZXL7of+RMlw=;
        b=VlmWS4dgwClbPZwx87NNgpdf2YyB5Kmh5l28kSrHqqkbqmxvFJ9wvi9A5HFzeev/kk
         id1IkFI2XoM+KBY64BpSywBL7olMY9a38OTuPT2M3TAC4yaO1gKMxydKazaSl23poZHB
         nNqg7i4WB3s1hgJdlK+DNcyAJ3mQi7aPiDGEqJ74rE4B39yJjaOnVPXv+0eD7Vx7oR7Y
         GoOIY7f70x5sEPnyFvdRGEs2bWOmwnyQXz+ZVmhl705e5KWkgT1xYZJuLX82/HVv8eYK
         pnLvQEE8FFcA8FAjIpuc2p17wzIeVhKiW/YXZQCPbI3eGKj2BYzD7jeo8NK0vol3duRT
         lN9g==
X-Forwarded-Encrypted: i=1; AKwUvByqOVkgieMunzPJR0Lsqo28meqtw2mfv4o/3FPCTxP8EjUoYxONZPIzhqTsHR7DlgOd5kifNLY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIcihWdNyoX+nHTbWTIZMdDep1XH6Kpk0wOtSRdDKrYm8jMT8W5
	8J5p7/A43B406/e971AST1S4K3MojdNclQXTCBh90K/jO3qcBo2emP6C
X-Gm-Gg: AYBFou29zB2VdAUf23x1hptAHXTsptT2/2vKT/7gYlKDxp6W+FupJCbq2jGqfW1CKK/
	zjRte2SwHxWBox4mzVO7zGza8GlRBVlY88jMazt6JmTcUVLQnpOXivTRNC0aw1DG5dA4bT/RHlr
	QDqhjDsRGrRCcPGgUkclOqoQpy6CKZoWm2qn9T4kezS2ySsxWFmBrcJ5LcLU8Wy9lMOMuGSvoB+
	E2G1Iw3zKjLdLkj9DqHaVxeDcm0dDJ6JNubYq1ab8dBRBaSbSBny061PDjI5t8zgIkQX6l1rtTT
	lG07oLkOLUbp6fdEetYVMSvWXLRVJYVtUwGdM7GquFrE1dDcJvhL3ISjCPT7ufqg97SGYRKXZ70
	/6bhR+N9ouY5KcTYp8wcazweBtfQS0ITmBb9g+XGrLhg5Nddd0TmO8DrQ9peod6d52MxUZn5sfz
	SeXShtmUEL0lBjtn2GUg0RcdFcecOAuVNyyol57cRqJwovChQ+i2hfd7Kcg0fkCwM3K2XtHrCbe
	asKH8x8gPDUM4Sj0kQ8F6qHO9b1dqivv7LyPxcPePbhsSE9rrgQ8IhZIDUgceChbt2mft3f6drK
	fein0D8ASX+NjcC5gRBM9mIpDS1XKikiSy2X593MkSMayIrhM9vZd46w8WbjjJL8dU/5v7+amZ+
	5j0q1kg==
X-Received: by 2002:a17:90b:2ec3:b0:3a0:e568:ed63 with SMTP id 98e67ed59e1d1-3ad86e96c23mr1512780a91.8.1792601355483;
        Wed, 21 Oct 2026 09:49:15 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4896c71sm279247a91.6.2026.10.21.09.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 09:49:15 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 16:49:14 +0000
Message-Id: <DMAO59MCJM9Q.19D7DBRQEDHLE@gmail.com>
Cc: "Willem de Bruijn" <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Rusty Russell" <rusty@rustcorp.com.au>, "Max
 Krasnyansky" <maxk@qualcomm.com>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH v3] net: gso: validate transport header before computing
 segment length
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <52b8bfe4ee848aff8ace47752352de486171d45f.1792596586.git.mst@redhat.com>
References: <52b8bfe4ee848aff8ace47752352de486171d45f.1792596586.git.mst@redhat.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 21, 2026 at 08:31 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> No unprivileged path is known to produce one - IP input resets the
> transport header to the parsed position, local delivery pulls data
> exactly to it, and tunnel decapsulation clears it altogether - but a tc
> BPF program can leave one behind through bpf_skb_adjust_room().

As Eric said it should be fixed on bpf side.
It's a bug in bpf_skb_net_hdr_pop().

Something like this (compile tested only):

diff --git a/net/core/filter.c b/net/core/filter.c
index b7ac145..ec47f26 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3417,7 +3417,6 @@ static int bpf_skb_net_hdr_push(struct sk_buff *skb, u32 off, u32 len)

 static int bpf_skb_net_hdr_pop(struct sk_buff *skb, u32 off, u32 len)
 {
-	bool trans_same = skb->transport_header == skb->network_header;
 	int ret;

 	/* Same here, __skb_push()/__skb_pull() pair not needed. */
@@ -3425,8 +3424,12 @@ static int bpf_skb_net_hdr_pop(struct sk_buff *skb, u32 off, u32 len)
 	if (likely(!ret)) {
 		skb->mac_header += len;
 		skb->network_header += len;
-		if (trans_same)
+		/* It was the same as network header or it was popped. */
+		if (skb->transport_header < skb->network_header)
 			skb->transport_header = skb->network_header;
+		if (skb->encapsulation &&
+		    skb->inner_transport_header < skb->network_header)
+			skb->inner_transport_header = skb->network_header;
 	}

 	return ret;

