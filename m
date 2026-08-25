Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAEF33A70A
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787673714; cv=none; b=JT+Rl71DzFRJUus0diumDlkjPbU7Yep4L8KouWWf5kCWNJ0cChbenVrKCc/bHfm8KO2oEokdFbR4I9owQa4cdUdiJChKdDo5wtX9AML6PmbsYg6PL9YiNpV0l8LlLf8g7pRglNA15wbqg3rX81ht+4zq7grTgWGpFxikW34sqUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787673714; c=relaxed/simple;
	bh=BsTPxyygLXUKMXJAMfGekLm53saVsq5rT05dTlu4Xjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NxPn4v29HajHg0z2XuyB8GtvcpvP9rSb5axoYRI5uQhgvqFC7KbfFILbLC95YDv7PiFUkfmEMk3J5bOg4gGrYFgzklK+9R4pGrgKG2JoXPk+RUZhECNFKoUsLUjOePP1bD7ppUxSgIS3TXEbSO+ZMKPXcy3alBBL4G7Qf1qTGqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVEOtA9R; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVEOtA9R"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7ec49608332so5776261a34.3
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 09:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787673712; x=1788278512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=71qtE/tuNjStbed1ClM4oY0bkXkCzbaUZmwhucnlGc0=;
        b=XVEOtA9RLWsqaZMnMvWCKJ6t5U+F7UkW9IcYUtljztI3rh5+c89Zi5n53A7MYqR4zA
         nJWUDTAcpuXoT5zZ7F501pTbjGRn4T2pnv/hHLLVGjsRhIVvIvrYBOEmiQbME5INNiTy
         075HrkLbREHSP4piQKj5YUjBSqKFxalkzWHO2LRjU8G0+AngV8LfApxgPkdbbjqNV2vD
         eLmlyg/SI7bcFwsiZp7NgP4KL/lc2UV3XWF9QvLp+PSKrKaGGQs876Qo2IvdwkH8tWpZ
         ql6FNmkq4hLe0CxwEqIKfu+o42MhoL2WKoVwXytw8GeSiWzNNtHKeuuGoOyf0mjIXeed
         Klcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787673712; x=1788278512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=71qtE/tuNjStbed1ClM4oY0bkXkCzbaUZmwhucnlGc0=;
        b=s8/iDMfAGCyuMHz9WduplnQe0maYRQ0ot+gcnQx8nOa3Vmx6/mh0CdsIwVcYKIc1rl
         wjGIAeM9X8vRiVijbHA2Kvi0g9ZWRhFe8Ixs+lWqJplUCGtaFCZIDK5ubyCs7QL4GgV7
         j/Al9EIbF07ukfURq8fAiRvIQKrLEr7LLdIRCnlYOzC9Z/hUs1DxiVombQPv6fYplAlG
         pVQfjgddiAtHFJNwKkW6OZgu5GSriM1wIcPxoC07/fhFCA0bJZQyEqlLvaqwxqhiKhv8
         tuW597eHC+/E/gEt7QUFjHVkD6ra0BrGghNWGM7pP30YqAMgxFYf8jl7TeUjPN+cnXx/
         HArA==
X-Gm-Message-State: AFuF++mmpxkkXsIHY86bQtbDr5GSoHEx/+6WlydYOuJ1+Lf39pSej/mz
	BjVTq2IXOzxJYTG8t1ujT1HfK25KM5FFwgpGzanOYgmiNVJLq8wop0fntzd+SigyEkF5HnMF
X-Gm-Gg: AR+sD11cc1Ee/ws4Kz40w+UpfNc7rLk+2Y0VAx2dKXeSLNv65vHNbtBytInN9CYBiaU
	M5kkcV3KBZgAFMQBFbvstNW6MPVL7dUVEnE3kaYRB9ApFKsqMc/nTDrus1gwHKN4fBTlfeZUGtc
	KTjAf0pdk/Nk/6+vKRhuA7ZqNBpr0wfJFmbfS7PCBA9Nn8HbWwehfM8z5k09x4nMjhOOLi5wFGt
	6f1+wg5JUucC2JIRBgSLB+e0TRFrvN45RvRwvDCdEiPN5sBmiFz0TpIAMK7xlAaULuWcu3VCb3Q
	MZmkqO9c/EhMuGL13fUbWMpNtkmlQOsYPQDuvY1IeSgwIYSHiSM1PPZtzV2oMDz/rODuoRh5sjR
	HoVmxJTkmXTxTx3Vvmxk5vs+nJnpgSq4z7MBnbhipR78SOXNa9ZQBY7vrYSH9h71slYD1HHPncw
	Ajqo0jLMlEaPC4xY98XvL3BOQyNpOL4vJma/lKa7Zk0P1XoMIz4JJSYd1bc/Lsn0awCOKKlsQwA
	jFwddLBmAqe/JwGgA==
X-Received: by 2002:a05:6820:2e83:b0:6b1:44e2:9d00 with SMTP id 006d021491bc7-6b15942226bmr22680778eaf.33.1787673711744;
        Tue, 25 Aug 2026 09:01:51 -0700 (PDT)
Received: from localhost.localdomain ([103.210.91.47])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8f20036sm387703c88.5.2026.08.25.09.01.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 09:01:50 -0700 (PDT)
From: Khawar Ahemad <ahemadkhawar123@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ahemadkhawar123@gmail.com
Subject: [PATCH net-next] net/sched: act_sample: reset truncation settings on action replace
Date: Tue, 25 Aug 2026 21:31:43 +0530
Message-ID: <20260825160143.86866-1-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When replacing an existing sample action, if TCA_SAMPLE_TRUNC_SIZE is not
passed in the netlink request, s->truncate and s->trunc_size retain their
previous values from the prior configuration.

As a result, a user cannot disable packet truncation when replacing a
sample action unless the action is fully deleted and recreated. In
addition, the hardware offload state and netlink dump continue to report
truncation as active.

Fix this by explicitly resetting s->truncate to false and s->trunc_size
to 0 when TCA_SAMPLE_TRUNC_SIZE is omitted during tcf_sample_init().

Fixes: 5c56784d852a ("net/sched: act_sample: add support for packet truncation")
Signed-off-by: Khawar Ahemad <ahemadkhawar123@gmail.com>
---
 net/sched/act_sample.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
index 2ceb4d141b..2bdc7a0eb6 100644
--- a/net/sched/act_sample.c
+++ b/net/sched/act_sample.c
@@ -116,6 +116,9 @@ static int tcf_sample_init(struct net *net, struct nlattr *nla,
 	if (tb[TCA_SAMPLE_TRUNC_SIZE]) {
 		s->truncate = true;
 		s->trunc_size = nla_get_u32(tb[TCA_SAMPLE_TRUNC_SIZE]);
+	} else {
+		s->truncate = false;
+		s->trunc_size = 0;
 	}
 	spin_unlock_bh(&s->tcf_lock);
 
-- 
2.54.0 (Apple Git-157)

