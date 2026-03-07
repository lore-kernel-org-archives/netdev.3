Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD42C330659
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772904252; cv=none; b=YskvkNxakLxPk6wBfdPjl3xNp2ajqhJnU/DySzhnVdTXk67JRFXx6RaJEwyI99L8JkyzLH8ZpJNprlrI+r8kA1xFXSOB/r3ZGGGPs4NeNo7YNsFYL+tqP7ee1ptEDoX6w/5QYl6bYN/A4xQeEARNqb/sHF+aShHAugIiErzOZwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772904252; c=relaxed/simple;
	bh=gZ+JzdkG3tpp5v5mkGmBvNixpFXUOmaqnsWndspvqS8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NfL8c8jtLM1xNCXtW//E8kcHolwr0qcXcekZ+2uz2xzKotmRECV1CJ+w9mDq1+ZoTD2fZgOHxLV82bcxIOCqGWhnUFA7OaujHrsXgCaWzYVSPz2du61ZOB8lqat3H4Qti4hPJ2t5QxJnHUeDC6uoUog0wdHTM2A+QRIstSlllvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVzbHH5m; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVzbHH5m"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82735a41920so3902790b3a.2
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 09:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772904250; x=1773509050; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mkxoUjDwyEKhbXBPEFB5Rnx4oGaKmH57R3vhYiR1yRk=;
        b=EVzbHH5m5ph3K673go94pRukmHUCL4U1paVgy6Uqr4XtKOJCDAYay5PQez70MIAi6D
         5q0BZK85nEfrb+C45c35ygA5hFN/ZqBaFIG0y6s3ntnab0HZ7par3Ae7TDtluu5qWaVk
         zJ4CAq/JfLzHXtFvQ2W0QH07gokFQp6pfPeg5ARXnFOYeYm11Y8ECL+dpItbClZD6GTx
         V2Z8SfAfqOVLdGiiR3Y35srzTDfGG9Ovif8mPFESDDzt/nJS1hbYJtAH3YqIoxumc6AB
         bMP5kqKWTJCklEHgKYsVjRBuUvdGMpwTOv27BBGDUNTCX7Vli5h7XfaIqDDlzv49TzdW
         GqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772904250; x=1773509050;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mkxoUjDwyEKhbXBPEFB5Rnx4oGaKmH57R3vhYiR1yRk=;
        b=cHHDBEJteDplNYZ3hz7MBplrq+O3n0kMcECYnENWKQ/1AuJZNKFTVYMo1kxb9gxuzC
         cwGJZaFwD4CnQoULnkZ78anCcdAgJA3s5VMv1h+AemDKUSBM0+ujtdtTiIuFc0fMuqEB
         v7qo8rFuvI5/w7PaYIw7t5FyB39naYQS3yzc2IblvT6TXVpDZKvRH8j24No9u7/EOW5D
         EQL5EhYaie4JQbJUUciQhbX2Iu1K5O4rmc9h/H3nwjtRMHpuDKVeoXd3cNMLf5p4K1JM
         /FT0/LhzdFcTJj4y2GPOalnlY/TmWuAeX6Y15i8gwagbWG9dqUnQ8PjXroc8LNznnk4v
         QkeA==
X-Forwarded-Encrypted: i=1; AJvYcCUcaj7S0ynF80SUnA0GM2/m2Zz/t0tZSKOjI5AZ4ASdnCQTzT6+6Un/Zl2Zh7oKQc7Sk0FIQw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrUEDnRk+GGAVIySXIKPAF/QCUgNzkZghScYBY4h0rwC6Hn21D
	TFxmMr5The69rKDEPlf+DVQpDsNIZ0MlYzjUkfUesfqlJ3zS7f1cruhX
X-Gm-Gg: ATEYQzwMZgCURArl4+4qu4UgW9DvHh0AMIsJn4XrbAoQyYkMrOwjrKgzycxlhf1Y1wH
	bplkbpapht+gEcUvR7XNaHKx+2b5pBnl7HWHLnfuuB3Mbm3tCARXfxoB9AhLpzvbhsNekBF1F/B
	8Ga0l4lX/awJHlnlS4tFWylPce1gldEmaNRwkD8NsAQfS6QPlgTo2Gs1XhmW+EKJF8T1YPnnTiz
	ceosMduQZHrcgmQWnX9zEgfCQ7Ow3bdOtTGiSHP3bx8HcykRaHw3xcqs9lny5eAOeI+TMcUNCjj
	lGesM1ob/8wLC6I0Dvxxx/hd+4G+DRkM285xdjPzMDpMRluQ7Pt4SVcujOctMMfPBMZ9Rcqn/Ol
	1XhDjsBPNDdw/Oe/FP8hhCMocY1Hvu8+wtd3lzLY91xaSO/BmN8SYhLO2Vl7EFnzpGfunRWxhfI
	2uE2EK0NOAn5Ah2+YeUgLS8yTNLKGjcmNodS/WBlQX9A==
X-Received: by 2002:a05:6a00:2d1e:b0:827:3845:921 with SMTP id d2e1a72fcca58-829a2e16119mr4719509b3a.27.1772904250125;
        Sat, 07 Mar 2026 09:24:10 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4636973sm6437528b3a.3.2026.03.07.09.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 09:24:09 -0800 (PST)
Date: Sun, 8 Mar 2026 02:24:06 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: pablo@netfilter.org, fw@strlen.de, phil@nwl.cc, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net] netfilter: nfnetlink_queue: fix entry leak in bridge
 verdict error path
Message-ID: <aaxfNvmoiil_UhY-@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

nfqnl_recv_verdict() calls find_dequeue_entry() to remove the queue
entry from the queue data structures, taking ownership of the entry.
For PF_BRIDGE packets, it then calls nfqa_parse_bridge() to parse VLAN
attributes.  If nfqa_parse_bridge() returns an error (e.g. NFQA_VLAN
present but NFQA_VLAN_TCI missing), the function returns immediately
without freeing the dequeued entry or its sk_buff.

This leaks the nf_queue_entry, its associated sk_buff, and all held
references (net_device refcounts, struct net refcount).  Repeated
triggering exhausts kernel memory.

Fix this by dropping the entry via nfqnl_reinject() with NF_DROP verdict
on the error path, consistent with other error handling in this file.

Fixes: 8d45ff22f1b4 ("netfilter: bridge: nf queue verdict to use NFQA_VLAN and NFQA_L2HDR")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/netfilter/nfnetlink_queue.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 7f5248b5f1ee..47f7f62906e2 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -1546,8 +1546,10 @@ static int nfqnl_recv_verdict(struct sk_buff *skb, const struct nfnl_info *info,
 
 	if (entry->state.pf == PF_BRIDGE) {
 		err = nfqa_parse_bridge(entry, nfqa);
-		if (err < 0)
+		if (err < 0) {
+			nfqnl_reinject(entry, NF_DROP);
 			return err;
+		}
 	}
 
 	if (nfqa[NFQA_PAYLOAD]) {
-- 
2.43.0

