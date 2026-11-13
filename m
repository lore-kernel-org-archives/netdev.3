Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602499;
	b=3YiQHl+noQWofXFJcp1Q3yVYZc/nyxsu7OmY/NQzsPdLeQDZ4daK9KtyuTpZX5FLqgsx
	 MpkCSYIxoBySxH4dGuFn80RIliMIXmi1lA64G8AX3ZTPtEZB9yJ/WyTnYPLFpmwz6uVma
	 4rsbEUG4VqbYqR/aq9eQmIF/bHWWQc974/cWa8K5rExxSXHcJQ/BfqOpurSKLSvLtGSnw
	 SIe7mwtI8DixLhRvvD28fh99eGXFaudKGXQan/uqQSDjOSgYI82RXvrBPYUNrh8ZOfIQA
	 ZXF1L8UoolwWkAzU8CNH6ujvsT0OEABzmN9iEaDtVprSFwWkB74/CXnG/JjTrHg98qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602499;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=0W8Q/2IDohjcscLdGdiEyomgYN1e2OSBtMs8vChF6Gc=;
	b=ewFtQh0Kb95fBT0oRaRBxIVHaelDtIK6VC8vgVTcxGD+C1vKhNJ1rDk93dMc1rLwsIzh
	 ch6P4vQuytScLjdk68i9gic4kgx4Bri1pvENbr3utgAzrptJR7R5aduCjlkgZKtkgTlpm
	 z4bnjqOFiWoSI17Kw+BuVSdjoMubXaot5TDfo5oQ5BKPZC43sL6o8G97TfrG/seBGrYOO
	 jDTEuyw7ar1iDU12IHTVBE4HmA/wn0mEOViH0afsPQn246k0zrXbGCbG6KV9iNWRtQj82
	 CQxsS71kIOtsNfCQ6Pjpy+SjO8bM5C1/zCa/knNDnbi/6mV7q+Qf1XHF7ArYH79r5Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZMihUsck;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369EE606A885
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 20:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 369EE606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZMihUsck
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ee2072d1e7so2593755ad.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794602498; x=1795207298; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0W8Q/2IDohjcscLdGdiEyomgYN1e2OSBtMs8vChF6Gc=;
        b=ZMihUsckkYarx2xIyxH7ofsGTlC7lPF30aKI+p5C9mNHO4tvnkyN5Q/UvAqWE6Ax+C
         0A3//sdKK1MN2ezBuvahcZAOqQF1n8XP//Ilup3ITilDTQVp/5/LiZ8+l2dHUiPU8sGv
         qT/Rd/af7ARAqPely0krCSpuL/k+p1a6oSVz7yCgNE57cw9sfmfm9TwpKrTR4ikmB9Qs
         SxFFMyy6zrAFyKRCLF5Nrcuh2uqvn9P1NbU2m2mVuFScjelQZjwxOcRK1cPw9fxrbvXX
         Y5q/HyZQzMM7QaFgxRGphcVQsWLlZ9K5yeHT0DYPuIQi5v1DSfqRvebc4Ou1F0u37cH9
         LIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794602498; x=1795207298;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0W8Q/2IDohjcscLdGdiEyomgYN1e2OSBtMs8vChF6Gc=;
        b=vxBeNMM8AH3XoUkoO4qpYMVladtG0rE0mobz9sT3vNpxfMXmufkXR/nsVJ9C7stBwL
         wY44uIDoPpx5B42pcD2NTp8W2EAIaM0C0ZK2WIc33Y+dvghYJLXg7ykHpyzM+cMdBlRV
         eOuL18Tp6oU8MVNSLX/5smkG7xj4xtmaHXMrHV6drzWJRLA7iW1URlgLZIPsdy1Oq1RH
         hEy7xZ1GNSZPVZgyNz7WLfec3wm/kDNkWqSSNptc+qNtXBrz2GwmBnb+hzrH2ERig4yH
         exnzErSD06Lj8bJEqFanFvwc6z0pFCfLNL8wEH4fG/11q2omqggk/x7dP3Q61YCZnxyP
         VADw==
X-Gm-Message-State: APuU4Z8om6Uipb1+ih16/U8S4uV3PUDQFgY9kxdrPCXernljqyIhig8A
	we94/jdJwABXj6V2vyfRSd+YtTPjKY/G7XQ8HeAsD63NGRaRa5WHSOVa
X-Gm-Gg: AYBFou13VcPnudVUB62xR+GXzKtQ6zQxMcS4HvRLwNTrgXooZkefyslaM6KNuq1E5dV
	UjcVzR61YeuU5/0nqkXIlflhPkTA2DJi9UaS1oTkHpB/1YSrgBbHwo3uaHvsWMzYWhsVFn/UvB+
	XbDjnHXLJd+EfmaZ/RPaZrxBmb+5kLz2h09Qd0Ioa0GYWynarjr7gSqYd4g7BFN2Ev94xL5n89+
	VOzhKMV6L0k2g8XaDs8dkANuVoi9RZZvy4HLK4g4RsR2oCVkX17KDvtgxFPIYMGip9EHaEgRTq2
	q2IsVh0n08EKxNCd1ubWk0c3lUgYaBdhxJkL4he4hoFV1JI6egncmrQQYpXxB8oh3kyxvMflbg9
	0O91rk2a1Qxa57VH4zEAfiGxZiGa7MzYg1D8O/IV589DhC8V2e2bfx2BvFrt3iWTbM6se1/zojJ
	kwGsZpVVOkln/m/NkDZw7dIY3hrBHwc/FHeQgXvpcH4lYeX7eITW0UqNNI9IVEoQGda2kOQnna1
	QQzTMedMkdy4nY6L9jvkalJDOWbtsKAG62dZ6XvvW8OFS1CtwVq/3WOaUYdFMYUSU+fVvoG/ukI
	vLHXmqSUKIQwiBhdRS31r8V+HmXTBMpflAbpTrNvUVM6ae3KiuYDF2IbROJfArp8Wr6kkLPY6RQ
	fdbf/pSDqwY/d1lxYxoyau7XmX132t0Db6urdcZmSTSUv5A==
X-Received: by 2002:a17:90b:1d4c:b0:3aa:fc22:8aad with SMTP id 98e67ed59e1d1-3b1b0ba4b47mr3453007a91.54.1794602498446;
        Fri, 13 Nov 2026 12:41:38 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c1:38c:400:22f5:2de:b9c3:f27c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0fa3df69sm14893365ad.74.2026.11.13.12.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:41:37 -0800 (PST)
Subject: [net PATCH 2/6] fbnic: Do not accumulate HW stats from failed
 register reads
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Fri, 13 Nov 2026 12:41:33 -0800
Message-ID: 
 <179460249371.8819.4646491882671802455.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <179460241885.8819.7179935130629202331.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <179460241885.8819.7179935130629202331.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

The HW stats are kept as a running total that the driver advances by the
difference between the current counter value and the value it last read,
and the fbnic_reset_hw_stats function only rebases that last value after
a reset so the totals carry over.

When a register read fails, as it does for every read once a DPC
containment event takes the link down, the fbnic_rd32 function returns
all ones and disables CSR access, so every later read also returns all
ones until the device is recovered. A stats read in that window adds the
difference between all ones and the last value to the total, which
subtracts the counter's whole value since the last rebase. Hardware
testing with forced AER recovery while reading the stats showed the
64-bit PCIe counters wrapping below zero on the first recovery and
dropping again on every one after it.

Skip the update when CSR access has been disabled by the time the read
returns, which covers the read that failed as well as any after it. The
last value is left alone, so the next good read after recovery, once the
fbnic_reset_hw_stats function has rebased it, picks up where the total
left off.

Fixes: 25ba596d137d ("eth: fbnic: add PCIe hardware statistics")
Fixes: 4eb7f20bcf06 ("eth: fbnic: Add support to fetch group stats")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c |    8 ++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c      |    8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
index 8b9b2076beec..8084a63dd807 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
@@ -22,6 +22,10 @@ static void fbnic_hw_stat_rd32(struct fbnic_dev *fbd, u32 reg,
 	u32 new_reg_value;
 
 	new_reg_value = rd32(fbd, reg);
+	/* A failed read disables CSR access and returns all ones */
+	if (!fbnic_present(fbd))
+		return;
+
 	stat->value += new_reg_value - stat->u.old_reg_value_32;
 	stat->u.old_reg_value_32 = new_reg_value;
 }
@@ -68,6 +72,10 @@ static void fbnic_hw_stat_rd64(struct fbnic_dev *fbd, u32 reg, s32 offset,
 	u64 new_reg_value;
 
 	new_reg_value = fbnic_stat_rd64(fbd, reg, offset);
+	/* A failed read disables CSR access and returns all ones */
+	if (!fbnic_present(fbd))
+		return;
+
 	stat->value += new_reg_value - stat->u.old_reg_value_64;
 	stat->u.old_reg_value_64 = new_reg_value;
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 16271c717a5a..2aacbf0a6af4 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -405,6 +405,10 @@ static void __fbnic_mac_stat_rd64(struct fbnic_dev *fbd, bool reset, u32 reg,
 	u64 new_reg_value;
 
 	new_reg_value = fbnic_stat_rd64(fbd, reg, 1);
+	/* A failed read disables CSR access and returns all ones */
+	if (!fbnic_present(fbd))
+		return;
+
 	if (!reset)
 		stat->value += new_reg_value - stat->u.old_reg_value_64;
 	stat->u.old_reg_value_64 = new_reg_value;
@@ -417,6 +421,10 @@ static void fbnic_mac_stat_rd32(struct fbnic_dev *fbd, bool reset, u32 reg,
 	u32 new_reg_value;
 
 	new_reg_value = rd32(fbd, reg);
+	/* A failed read disables CSR access and returns all ones */
+	if (!fbnic_present(fbd))
+		return;
+
 	if (!reset)
 		stat->value += new_reg_value - stat->u.old_reg_value_32;
 	stat->u.old_reg_value_32 = new_reg_value;


