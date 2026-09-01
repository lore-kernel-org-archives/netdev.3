Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2C839A04C
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 21:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788298790; cv=none; b=CycDFBnpHcDxfbvy/9B+09CWeRdGrb5bwvHuxTijA09EpuaVzQBlxips4hy7ihp4e0exK2TKIeghs9VYScqwtQzPQ0Vgnt2l6zFtjNEgKXR0CTx3tnvleOFsCcNo+OQAp5VqyNA0KD8bwXqlc+Ggb/nmi3TYlo5dY90gVv7DeiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788298790; c=relaxed/simple;
	bh=9FqPS+k7JKhvFCFdnH8HIjLKrKaAHXx+oG7QZwE+O0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KcvMQcVc048LpIouOBMxoJCjD0RrWPvKdZt2FWyib1T9XqE84hHMLpVEvL6BU2P4WSyl1By1MpNJAekeCyuKli9GA/dPEFZKZ6jz69DIzfebLN0w4YGajrCRHBp6fJ34LoU4DRDfF7231yVD5Kp9xCZOdCWzxOWtR3+UlBMqLro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Tj0jiRoy; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Tj0jiRoy"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-90e95a18c92so5460816d6.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 14:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788298788; x=1788903588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O5pAJW8DmVEb5ANMKOnlvHif2hpH0B/XNQqRPoLQANU=;
        b=Tj0jiRoyZB87FbAp/LFXMxWzSCJhBiuNlJNjLFiDWyertosxNn6xD87dYd1153KwUH
         zFYddHAMmtv0ejbA7T2BwjP4DBppsvjkkb0RAEmNs6oHkcK6MB6HfTNhiMzniMDiUPN7
         q7BLRaXGs9dYD7RcXoViaEvyDtLRPMxr6XEcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788298788; x=1788903588;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O5pAJW8DmVEb5ANMKOnlvHif2hpH0B/XNQqRPoLQANU=;
        b=fFJt0qujTrMGHQDd4cF+dveN1R6Kcj8bHDN4cwdU5Hs2jjedzSd4WC3vBFPTKMv0Xr
         zhSZlmAeKfUPjU4hrmCwr+0kO9b5zDP6uTSZActotEpmfUWuTWHifkmvQZ/Db5gzaYvB
         Eh/GGyocemDiDsSB8zCAuJijMZRlDbX/rsP18n62Ve1R2mB8DKWtKRZo7SRSrsYsD59G
         O2GkVFLRZ68dVkFOsjOeH8Ih2JrCVFivQMuYTtOGQjAAHYfD2QRrywbqe4z/EQnQMZ37
         8vrxUflAYaop1av6fxwbvBAdRyKjJ4YkeQAwKw2ep8A0o4fUBUs6CqgER0ea94BsPgUU
         p6eQ==
X-Gm-Message-State: AFuF++keaRBHR3l/uW+rTLUE9ca8YaiodC8Af/mD/D3XEFljLKxpZ40z
	j1Pqp64jz2Fikd5I+6g6gsqcJu3Vusf30alCGuSzdtWVENtgzuWwXvrKQbYxU2d3uEtGZ2mCtXv
	YUA0FwA==
X-Gm-Gg: AYBFou0eA5IWJVEQJkxmKnxil8YY8Yc5YQeHYNd7/CltBE2pPi9MZya5DxsYFvUcLnK
	oZUiaDwrvLy4cwz68fXO5foxcS6g+lZlrCVPVP14z0EOVZLGOzAHuydZRk6+0h94nLcbkAD24/T
	CLA450lEoRFGU7joUQIsSnCAjv7ylrqlf338Wn5qdXznL5j9n73kmWE1gklMi0ArMCZvCA9w2U8
	bDKznnBjOlNHcbCFQa8QXTRktfLBaRWWeXXs/k/R9nLbBhO2xidsjqK+aRIvEWgvyp1Q4v54+dm
	PKSXUDjAGU/sxDlsm8f6xoxiVnC1viCl9vYC8SleLpGYyKvn5ltxUWyUHWhN/C3oGGDF8P8bOeq
	4EZwUP5xZ7w5VmFCkSLoFS6P5unlejH4sBMrlbKSpcY5qhuRd0Ovotr8XakbYEfpUHGo1lWhYjN
	md5hWs/BT1XWA73SRXTVCQiD6zC8L4rfD6Z+jhE8fG3OiXPHoJQlUOyHWztym6AGIDxQWzW1vxE
	2kW/L718IbwVRzcGVZfC0chTTKZ5dBS1GtHSQ==
X-Received: by 2002:a05:6214:3982:b0:90e:84aa:6e4b with SMTP id 6a1803df08f44-90ebaff1379mr9272626d6.11.1788298788090;
        Tue, 01 Sep 2026 14:39:48 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee08710sm3458426d6.2.2026.09.01.14.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:39:47 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	Vega <vega@nebusec.ai>,
	stable@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Vijay Subramanian <subramanian.vijay@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net v3 2/9] net/sched: fq_pie: clamp quantum in change path
Date: Tue,  1 Sep 2026 17:39:23 -0400
Message-Id: <QDISC-0CFC.v3.20260901204856@mojatatu.com.3>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-0CFC.v3.20260901204856@mojatatu.com>
References: <QDISC-0CFC.v3.20260901204856@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fq_pie_change() accepts any quantum value from userspace, including 1.
With a crafted size table qdisc_pkt_len reaches ~2 GiB, so quantum=1
makes the deficit-refill loop spin ~2^31 times under the qdisc lock
(a soft lockup / denial of service).

Add max(256U, ...) matching fq_codel_change().

Conditions to recreate the bug:
  CONFIG_NET_SCH_FQ_PIE=y. Requires CAP_NET_ADMIN (namespace-local via
  unshare -Urn suffices).

  tc qdisc add dev dummy0 root fq_pie
  tc qdisc change dev dummy0 root fq_pie quantum 1 stab data 32768 size_log 15 cell_log 0

Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")
Reported-by: Vega <vega@nebusec.ai>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_fq_pie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index b27d95418707..5982847df8f8 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -341,7 +341,8 @@ static int fq_pie_change(struct Qdisc *sch, struct nlattr *opt,
 			   nla_get_u32(tb[TCA_FQ_PIE_BETA]));
 
 	if (tb[TCA_FQ_PIE_QUANTUM])
-		WRITE_ONCE(q->quantum, nla_get_u32(tb[TCA_FQ_PIE_QUANTUM]));
+		WRITE_ONCE(q->quantum,
+			   max(256U, nla_get_u32(tb[TCA_FQ_PIE_QUANTUM])));
 
 	if (tb[TCA_FQ_PIE_MEMORY_LIMIT])
 		WRITE_ONCE(q->memory_limit,
-- 
2.43.0

