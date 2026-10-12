Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC365386C18
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 04:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791779003; cv=none; b=AouDe9GqoZyVKXVtqLP/N6xDHsf7AsuXI52JuD2Y52dQhJGkiZfLvlAcVQtvnZgRSUMXFt7NG2w0Aze3W+pd2L2t2oy1RhZORKa9LEW30yb/JPYuiJfSLgXlvrb8qhGICEP8lxZ5Vj/bplJ8+x2HEzhxUIVYDWW2TlmHNt7OYVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791779003; c=relaxed/simple;
	bh=lPCfJay/62/aqSCtdYw6Mj/fly70GzFauxJDKqH6fbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ix2cyPvBf7oWboDXhMJvf8Wl1Wi4HAABA4OXGQPZd7QOQ/SCVrXQJxYW/lzxwMPvo/WuX/qvsTqImgwVBxXiSWG76KhztEJS7j4xLKc7VZX1kUTjrJMX8mkV2rlCnI5PGpwByKi188Idl4un0+i0+SBpxUWEAeRHIHMtH4th3b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=BlxmtSrm; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="BlxmtSrm"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd5cd8d89a7so394137a12.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 21:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791779001; x=1792383801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lPCfJay/62/aqSCtdYw6Mj/fly70GzFauxJDKqH6fbU=;
        b=BlxmtSrmH7cn1/S+LP0TEfR92I7gedMMyGH5KYuJfDihYIG4DIM1JTz2TE+pvR3eRV
         aL8uV0cK69E39t9GjBk/0YGqq0BwdokG0eySP1zKUY3XK8HQdp/dIJBYbVmZFQ+gmKWS
         ZyJ1Ubb6c8M81U/IZc4BodZxUutiQf0STW+2rTumHXrVOp8ZA+jT07muz7yQGd83uoXw
         lafwT1tZFZo9/MXJd9gHoeSvVNS0V+IR9P2inH9y25NTP/AMQMGnVxXYCroobO75rgBI
         zvEa3RGEJZ4ld/ChBOC+n705NdUTui6StuAgbLCS6WuBTB1uTk7YCwy1fsj9NKApxihY
         tE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791779001; x=1792383801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lPCfJay/62/aqSCtdYw6Mj/fly70GzFauxJDKqH6fbU=;
        b=FcZGpcMU+2V8Sr5/a1YX1rePFgzqDXpmESqplCicUyZh2NIQbdSOwWZoJA4HJ8UIRP
         hp2YTOvliwPyAoyNCni9HjfpGW1IRdVzNph2dOmG1JhqnrwMeIdrFqPQxJdbM82eN4kG
         pcOU8qb2ub4FW3jl4sJb3WTIKbyORYDTY2z6idlzBQ9JA2BIQsICHjqcCzQSNSvbLvKh
         +QK5XcaBsUerVaMlbVVAooLpS3+r0lZfr5NF+zk5FuOyO+BcTqE9yqmQRrkcfDjG1TTT
         xPlbV0jzb91PnXKxsLkDYMPj5O3cu8Z/cGsL8olJ5+M+aIkiGaEO5DiNyIOAmvWzB2jQ
         7QbQ==
X-Forwarded-Encrypted: i=1; AKwUvBxFZRi0TOUjC8UHBfPsboWOp2ULamygqKPCQwVJXNxD46OSfJCLNfEx9OMFOH6wN+UB2mTmaFU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKuAVzSdDDA042ZFcwuJ5LyX7HIF/WT3KHaADaVrTBa5xInIh6y
	59dw5Dh3wADUx42PZ4Vf0HteOZSqFt6P7A4R4fMEgAvAH2ZjFPQVyCB2GCzV3UcQCDE=
X-Gm-Gg: AYBFou2h+cupNgxdjCmnTW8qa/Kqbaj+wn9Uefcm4JF2BEujPXqeoxABmG/zmj3z3HT
	alRhkIDHrbbhc+oZ4xAhc/ZI4UdyZG39+jazdTGnYN/XonM+fPRvlplp/gQms1p4K7uKBIAcput
	ExDjLkpCNk/vXJU+Qzxs7/YclXRWNOtqLvqs9ny2n1Hw1bAmmbgijSeChqa8qATBPIwHaUaWbpK
	nnlWcpJfmz5KQHN9iM4GxrdwezhWICDnBi07c9muYSfTZ4jBA6ooFH29JwPV7BNszcncmUn5t9D
	2QPO1Y8DsAoj3DcyYatG/fPXf78Vk27MRPQPFr/iBXxC/NDx6RYCk5TT+ftmEOmdJrGARsasoEH
	9mbAVe+15wB7DrnhclZOUXuLLxvWKbfNAQjv3Hckg0V///QyrNDMiADOXv+fBIMF1TNPMhCmFVb
	vxwPU/Dpl6TAvBrjU2Vsk30xd4CiGCi0bNNMA0MaJuZLI2jaGDNTfkG9AxXu50qlgGbTvv1li9e
	6fXRwEty+p1V9U3
X-Received: by 2002:a17:90b:1d4f:b0:3ab:c80:936f with SMTP id 98e67ed59e1d1-3ab3a94ffa7mr6274668a91.16.1791779000936;
        Sun, 11 Oct 2026 21:23:20 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38b9639bsm13989543a91.4.2026.10.11.21.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 21:23:20 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: Re: [PATCH net v2 0/2] eth: fbnic: validate the Rx completion path
Date: Mon, 12 Oct 2026 13:23:10 +0900
Message-ID: <20261012042310.2167618-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791659860.git.yhlee@isslab.korea.ac.kr>
References: <cover.1791659860.git.yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pw-bot: cr

Superseded by v3: https://lore.kernel.org/netdev/cover.1791775409.git.yhlee@isslab.korea.ac.kr/
