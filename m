Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793475367;
	b=3EF7pWIBZ1CSxjMu+i7sZ8kpjQXYOK58bYN9OzkEq8kNC6/8lJ9xLAvN/Ko8MUhSbkFO
	 9GeF68HQB0DLuFyYc1hjSZpgo2lwBAzsQP5w51r2+1bGpXR+9hoA3x5zvBRW8SeqJBk3H
	 9uT86+htJl7a/IGmMTsuHuw+KmyOQqMkzCVnz1T7q2HLSogShYxOlwebsTMQYk3my4hXA
	 Mjokj1wI4nBPOiZKeO4zZiUBSbq1KzW0MHaGtsRk3+aE1axHHXx8WQPeoTWspsza3Wb38
	 LrFIHma11PeHJvKs32IhjIYQOafv4CpisCjch4U0AxAQhldms6YiyaOHECEPhDqrznA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793475367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VpNFSaEVPIgaitRWclY27M8HtMOzW/v4lrjfw3GGNTA=;
	b=VPt7G4+fdeF2fqbXFN1LpuGOqRCqxrGUq5v3k0nbUXqRU6PwNsWp+ZR1yKnZEiGzU1Tc
	 godz3c3Vcdr/OhAIkkZR+XufdTP+oyJl4E6NYDmGn/Y8dfR9Plo1IkSeE+SoHDth6fyj3
	 OUCaP6lXLq2rO1yWSth+I/87GLc0u9m7KfonOlypLKmMRiW14Z7bLuCFAQSmcNoPL8M11
	 6TGJQrnPIDuwc/uEctFZv/mOHjU+ro3Werm0BqjdhiymjVcmj8Ae4Q0PFvrIlfJX/KTpO
	 o7sXXYbnClrJIVA2xSA1mG1kpKfqOtmSenE85xQYPqODk9ig1lTWN7AjBdHtMRzWWkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=eBCqAneR;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83D8606A32C
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 19:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A83D8606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=eBCqAneR
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93efc0452b5so118671585a.0
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 12:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793475365; x=1794080165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VpNFSaEVPIgaitRWclY27M8HtMOzW/v4lrjfw3GGNTA=;
        b=eBCqAneRFI+RfXKoey8DrqbVsgcPFCFEbextDqCDUvKwj+iI1EAeacEigL8Mj/lE56
         WsZU40Yg0muBrXpN3yHg7WGeJvagMn3vyhKVV7ULktWsY/FxsDMpsWPQKz0rwzlkt9LB
         YffDbH3m5WfEAITuyigOC8Mayjc8OgBWQHAjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793475365; x=1794080165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VpNFSaEVPIgaitRWclY27M8HtMOzW/v4lrjfw3GGNTA=;
        b=RRG6kaml0rPnv2fWbYvYStYOi/+jWcGmfMb/jK6ooexOhmLq0eKNcK2HdX9mF08fZF
         nAldygszz79OghvfJ4f0i2Mw/en7lir01taOm32dzqjqL/npYP/WxiaswqXpTLiJMD0W
         /e4I/IA2R4humYw0Hl8qifkWiExcoX37W0haTywZ2nOwVdd1q5u5mRa5o0skxSjW4ki7
         E9WVvvvjTIu5CHJ4hgPsI4Bd14DQqLN/iyvrIflyrHk9apCwu71U9PE4NvmnS0UFk71Z
         mSRkHtKmnrl8LzqTvpciH8RlaUM8cJNJgvQbI8uHXyapiWz0jCB3I6FTl69FxVTy25gv
         Hk+g==
X-Gm-Message-State: AFq9FYJjybxqa05iOsAfvtXleZBQWRQBq13pXyM5M2tKJ5Gf2FBi9fGb
	c3x0RnVxX3N+FbCDUiO7MIAcRRfInlqdiJ9eR1YVEs5C4MH+R9b63nFS+QtRTZsg+uIxMgiM8RG
	7CUE=
X-Gm-Gg: AYBFou2jUkE6DLG/ry4BcV955Kz36IZMM2sspdBZgNtFONoEtwjh7t8JMoE+MZmykm/
	tKIotGQmMgana1qYSypLH0Upn60upRrzaIU44DWfWzUMtDr8EgGVQUkhyKaynPaigKXx67W2z1W
	qvnEYW4xVb0wdF9Sq1c7XLihA0Cc6v3DF0VM80dohbjvDcZ14SJW0OcQg+RcE+H+4pRQRVVOYKZ
	qFS+j474eUuo2YdvltdPe3WyFLyN0ik8ldfDyglyiFAdMlprinCecJjYYiT08CtL30STGCVeKy4
	PXz5LogWwIxItQ92436CanurQhMhy/JCqPT8cxFAeJPT1JExFzg5SDH3j8dGK0vKaoXA2t4XIqs
	jB8+IwtwdmIBQBvFjlou0OZ7BgfZlv0QOwG+eF4xZy3vyic+olnDtHwbd2PAhkDJwy8w8ZJP8Mv
	geT3ErA65Dty0nJNEEys+VpjSHE98Rb5sIB6VspAJ7SZ7YecO5cn3V86Wl4mT18efUub7+X/bPZ
	DQk6k+X1LbpY4NrB4Pxt1NOiQGnsia5TsC5T+qsbLE8zDOdK+FAs7i03gRDUsrKIg3vMjxKDkNZ
	vTJR35/OXlpOV3zZ4AsEPW4VQG0HdXLZ/QLihKSeGBr/O9m6hDIi8iozA8V58FccEGvmcVleTOK
	8EknDZQLKVLJvrYI=
X-Received: by 2002:a05:620a:27c3:b0:93f:3576:d428 with SMTP id af79cd13be357-944216b0c4bmr918024685a.22.1793475365487;
        Sat, 31 Oct 2026 12:36:05 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425abd317sm446917585a.36.2026.10.31.12.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 12:36:04 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	shaos <shawnq1@163.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Vega <vega@nebusec.ai>
Subject: [PATCH net 0/3 repost1] net/sched: fix short-skb metadata and namespace boundaries
Date: Sat, 31 Oct 2026 15:35:57 -0400
Message-Id: <SER-NSBD.v1.r1.20261030042947@mojatatu.com>
X-Mailer: git-send-email 2.34.1
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

This series fixes three independent boundary problems in net/sched.

1/3 act_ife: encode a configured zero metadata value.  ife_check_meta_u32()
reserves an 8-byte TLV for a configured zero value, but the encoder
returned without writing it, leaking stale skb headroom bytes.

2/3 act_ife: require a full Ethernet header on egress.  An undersized
linear head can make the encoder read past the end of the skb data.

3/3 sch_teql: reject qdiscs from another network namespace.  The global
TEQL master lives in the initial netns; a qdisc created in another netns
could still mutate the master's MTU and flags.

Origins:

1/3: reported by shaos <shawnq1@163.com> with a reproducer, which was
reproduced and verified in our test environment.
2/3: found by Sashiko (nipa and gemini) while reviewing Victor Nogueira's
parent act_ife patchset; independently reported by shaos
<shawnq1@163.com> with a reproducer, which was verified in our test
environment.
3/3: reported by shaos <shawnq1@163.com> with a reproducer, which was
reproduced and verified in our test environment.

The three patches are independent.  They target net and carry a stable
nomination.  They are sent together because they share the short-skb and
namespace-boundary review context.

Jamal Hadi Salim (3):
  net/sched: act_ife: encode a configured zero metadata value
  net/sched: act_ife: require a full Ethernet header on egress
  net/sched: sch_teql: reject qdiscs from another network namespace

 net/sched/act_ife.c  | 8 +++++---
 net/sched/sch_teql.c | 5 +++++
 2 files changed, 10 insertions(+), 3 deletions(-)

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
