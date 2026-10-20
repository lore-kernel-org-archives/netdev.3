Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792461186;
	b=SHm4eb18yoc0R8ZskAweTmHZXecroyfNpzhUeB4TjxRYSN1lmrSpD1ThebazVnBFYZmv
	 4khXZRq0T8X+e/Wh7maGbOaVEsM3Kg9ayTc/pzfvfhWExjg5due7IUQrztxMmYCzuEZnl
	 RTWNEtmpvM/potrWgYWQOnA3kffOxVnXH1l71TzZEHDsqMJMnVNe3sqvHauURcvGocw9b
	 0JtuZ02jzUMv8bIOjCmbyQaAefnW+J3xfqLBdocuUt2trtoKKzQ4KvAjyov6MLC1o6TXQ
	 8EuMZMMd3RYiQ2Ky1vZ7GVQKSOBtzXpcdQORrNZg2dlKwDN5MiPs1MVmg9zP6K2os9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792461186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+Yn7QqCwXM8MPvwetBEr3NullDr5Aw8no0EzlhyW/Hc=;
	b=gc3ljoCPhFG79zTX0OuwpZrQHfy3v+jW+FzTRKHT2tCsXnmHsswgzJPLcqT4QW7qaDMp
	 ZZj+gmYKLwNZ0PurZBbsd2gbd2SIg58o6grhnUAREFX5Fz2wJ1jitnow9L59/ke1qog/C
	 dXczsIjE+GWsZI+9FiMxq+RiUKP4OYgs1m3kDkidnvOTslaK5m0oxO0MvUfcCyQaDhVxY
	 CqVxkgv6D9evAbICBvpOfAcBTXe5msKgSNy8XC/50yB7KMFC1muDMTS/KxcWQoa7txS/V
	 v7OlN3wNZ+maKHwY+Hup+LTrxN9UIXFtBE33PrgxuMeliwHS2zWEiNQyFMcSCi8LRQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=vumXSNSb;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18161606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 01:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18161606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=vumXSNSb
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc758830601so1831651a12.2
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 18:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792461178; x=1793065978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Yn7QqCwXM8MPvwetBEr3NullDr5Aw8no0EzlhyW/Hc=;
        b=vumXSNSbI09RrtlcyVULpvJxp0EcPVGVRu33CuFCqb5NorLBDg2EPhJOoHYzUwuz+f
         LxFgMsXL4GijHKtAhN/BqDlE9Qi3p9hYGCIOnGKa88rE5jwPUubOQuBXKPgdeQvryF6z
         cTDvY0P/QacS26B23naXpIrswv4zBJYwfkVlFWmLaxxCSXRy1tdPB68EMsLumnwe4A+g
         G5/PQ9b/87L91T4g2NUgqRe1o38gpLZk5NtO0oQnzCrT9cPThXF1ofoiQPSgJwbByVEU
         RN9xqUVimW85F1iDXLYkovAABIPAD9/xGN42NYO9suCDT3daOKBldwleo0F3DxjtA2L9
         ggjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792461178; x=1793065978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Yn7QqCwXM8MPvwetBEr3NullDr5Aw8no0EzlhyW/Hc=;
        b=H787U6XX2HuasvidrvF2aRbNgVSxS0c/Ox+rChx146j4Zny6QDICSZ41BnKsBqoMBI
         CubmNvmjtZ/e+gkZNX+ODFaComvI1LuZhfA8Meq8Wajv+ONPpBYDVY36s0t4YKuOwyeg
         AEfjYK8ijPv3KJ1guzeoSPdxkHpLs83rWoZBvQ2DsfoZFNvoWyZMPy/xmhy+LHsnSO4H
         azD1ZgCgF+b7pmQraPtWkwjCLTZue+wLx2WaPn+NcRkuOxFM10ysN7tMYpEVORJ63Ppm
         1Sosd+mbYav3Rufb/W42b3E/ZpxnDCB/wkMWZNQ2o2u7hEuT5xa6OYbQ3ZdNdBcP+dLY
         qjYA==
X-Forwarded-Encrypted: i=1; AKwUvBzkjjDPIiLtgUu8wWCphQSaodw+6HpfrNG8ebyuYMnMFLBMj7q6EiSESoHEeJfExImsklMjjI8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLiODaOhJFOvZiXIyZGbS51ocqt3qGJqZIIZd4yYAsz+wIEy5Y1
	MBZC1IhxAhxgcKy7CyEKOttmkByPLG/q8R/Ej8TgVUeVaf8k+CkltxijCBOcVbDuVXU=
X-Gm-Gg: AYBFou2DD6x30Cr8q+albe5NkabzRlGZj07CMiwHTcaB0G8l56Rekxxet16Bvy02+CH
	GWbxKOdtM58CBwLIE6yIiknyWLC8fgf9N7Fc/GbtxQG+P982vtt9lMtlYJo3HFiL6EyxU+lATG/
	V7lvmKHo2TGg+uVk56Oy7GUey3LxFM5wwBl8r5PhkusaMOZxo0+1hiOjVZ+a0w8q8mYYPi8Y799
	xqzH34RDQgK0e2KWEqkzR64NbVUwyp2rvxS9oIQHMqmtfWt0TyYegwO/9j59VwPtcYvdPrqKq0l
	+u9mdtf2VwDmwhKmJSEtgbW8IY7r3apZ6FUD6SHfiB3MWHCLur3mnWCP2gz+krRPEkaJPXGQRPf
	0zG7rJGgiB1kOdY8sj3Ktgz/7brthduoGeQWuoapQjfTy8igPaqDXkF50SZlZ0iQDkU/h8OEDyn
	6GYSi44hY4Xqo2KGGhyIANr9N4Qu44GyWlML12qtTxUYupKLQP89fZ6/16hKQI4B3CfxKKmJUN9
	egz9Q==
X-Received: by 2002:a05:6a21:3947:b0:3e2:1418:aae2 with SMTP id adf61e73a8af0-3e22640bb6cmr7707121637.68.1792461178034;
        Mon, 19 Oct 2026 18:52:58 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654a15c57sm4551644a12.25.2026.10.19.18.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 18:52:57 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Fan Gong <gongfan1@huawei.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Xin Guo <guoxin09@huawei.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: Re: [PATCH net] hinic3: bound the Rx fragment count to MAX_SKB_FRAGS
Date: Tue, 20 Oct 2026 10:52:45 +0900
Message-ID: <20261020015245.1117139-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020011209.13736-1-gongfan1@huawei.com>
References: <20261010030901.1712792-1-yhlee@isslab.korea.ac.kr> <20261018170531.bILLh5Zw@linutronix.de> <20261019001037.3496843-1-yhlee@isslab.korea.ac.kr> <20261019221306.d6dfPY_y@linutronix.de> <20261020011209.13736-1-gongfan1@huawei.com>
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

Hi Fan,

Thank you, that is very helpful, and no, it is not urgent. I found this
by code inspection rather than in the field, so with the current driver
unable to reach it and a complete solution already on the way from your
side, there is nothing that needs chasing.

Please go ahead with your own approach for the larger packet sizes; I am
glad to drop this patch in favour of it. I appreciate you and Sebastian
taking the time to look into it.

Regards,
Yehyeong
