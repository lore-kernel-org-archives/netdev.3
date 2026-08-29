Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7289530D3E9
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 06:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787984716; cv=none; b=TYRkMIdb3gt8Ggwxe+IO2mTChRCt+B0tVErNx/fURpThjH8+3EVNk4S80RQ+ronE57gVjB2cvIk6nx/0a5EUhDtqg1WJezHytbxD/MvVUww8wRCxEcnu+UZGTGLdtUALiz43qDuLGttZ7vfcqR5goqy8NM4avlJq3RgcRewUGts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787984716; c=relaxed/simple;
	bh=5+qNSuBfaI7rfZ2mss24vGAI3qaKMMf3Acwprabefjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfdNODgJJZ4yYYQ8Ox3idORDeobSYq0dCIYOLrK3bcYLdutOJVVqMSZm5jxduuKSGN2vuAg5z+Q4nT1wkZ5QKtWjgn7YtU9H89XXTNqUubAcpJQWMg/QvNNkLUTsy70/RzdrrdfCWnNduXG9+KEzAbdfhfEBGMDtzg7jpiKLEKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Wmb7UL8Y; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Wmb7UL8Y"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d5335cf904so16909105ad.2
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 23:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787984715; x=1788589515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YQpGeHFpF6hM3XAcJaWyHzxH1K1KBhOVpeax6pWgUcI=;
        b=Wmb7UL8YWrPHOOqlAza3v9D6jmHXo/E25qKtIONgMJfwb1fFSObDhV3N6ajCv42qji
         lW/SBEmFXgSRVBPEn0F75c3qrgj6gKEd81rPTTVE6LTwyD87nWME3oUI3hUf+wH09Nq4
         QoEL7NX2Ww7LHZcWhqyPUatFxhNiWosRJpLB9Jr0lvKGW55PGGAxDY8Q611UwGHFYhbK
         5SdoJ0PQrzuaAGP+wX6Z9V9MNM5BibKTY17ZGhfrA3YoUFicR6pW0jlIoO4aSNOFGsnV
         iGOpEq/fWml4mDWtcyfa4IT3jpuSN2k9N0kFZvuDde7LirQP0tAw1zLwCSLbZhtZOMir
         ApHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787984715; x=1788589515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YQpGeHFpF6hM3XAcJaWyHzxH1K1KBhOVpeax6pWgUcI=;
        b=gqbPI2ZnhaYQW8g/ke2mO8ZkYZQyAlGUQDg7L9QIP+grHTdFfAWGrP30+gEGGaPd5U
         63Ym9MOF78vqBZQAqjmHbCk6NOEY8AZAQrJoz/VFQqbRJVezKJQmcKsm7v9TaGbu7v/2
         GUdm74FmjadO7CDQaWCMOOxbY9+QrqSdmdMKMAztctiIm0dXppHXKJg9XlMxbVQsNOs4
         Sof21xNDpbaAkwJRvtIjWbYHG8EF+PNpNzrp00MogKbH+b1QcGegR0YJw7qePeT6OIXi
         Y99DYfTR1bc3nSKCWImTKkzK7yqU31Qx+7NBfZbFVS/7b+Q9xhaf2sAUxf83EcOlEAvr
         mIbw==
X-Gm-Message-State: AFuF++lFZ13TI1hsqenH8ETLItLFLr+sKe6HiR6P8qQyaZOQqZOxNDAW
	317MitH0xJCrfkDBwvA+nqpXhu2UkmHy5x9y4Y5DJZ8H0n2Eeb5Ld+psm1pdTkkzKHhuoBwZX9a
	BL0Xu2tGLaMo=
X-Gm-Gg: AR+sD10BOO//FmbFRfIwYJrUqNM8DxUaBY06Swg4oryeh9kR1M/sc04eOCA2smaYGhE
	8oGhuFvgEHketKDivwHvp/EQt3ywAp6TBq8Ns3K+bpJm8T0hS8j9MLFO4T5syJXDWnDdYlud65G
	u46G4LidN4AybtuAwbHJtSNSe+EsoCYBkHJ5nQEhi5CgdwdtJsbR2aAOb3bVkqi6bOWY3HB7VMO
	Sz4k+32ato4jLerBl/pMm8fePiBdX7tldBz4ptuV0PQZk8DA7A+mCMSe0rjM63KfVqOdUhWOYsn
	pOdTxTIw8+TUVriYkiIoKDU2mvmOuMiID5vBn0TXODpCajLGLPQnpZFWS04fFHwrjC6HrTe4QTy
	RRX6UMYe0L+8K9eXB22wPUUJ3e3deyjHyqScX4h6wZGSASPgLDS02Dl7Anw2qmvx+3Q53ggGfEQ
	0E6t7KXoPKeU1jYatBKcWj80aTEaPYKfiqjWvxA0iOGhPXPHPnLWrFmOszp7ggGz5slNFyHaxH/
	+3tZHA4m4zGCg==
X-Received: by 2002:a17:903:1ae5:b0:2d8:d4cc:be62 with SMTP id d9443c01a7336-2d8d4ccc940mr72729095ad.15.1787984714542;
        Fri, 28 Aug 2026 23:25:14 -0700 (PDT)
Received: from gmail.com ([202.201.12.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d7594fb48dsm12354185ad.14.2026.08.28.23.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 23:25:14 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Patrick McHardy <kaber@trash.net>,
	Zihan Xi <zihanx@nebusec.ai>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>
Subject: [PATCH net 1/1] ipv4: fib: avoid quadratic table ID lookup
Date: Sat, 29 Aug 2026 06:24:57 +0000
Message-ID: <0a00492a13038b268c1e0a219c138d07cfab92b3.1787982246.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1787982246.git.zihanx@nebusec.ai>
References: <cover.1787982246.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fib_empty_table() probes every table ID from 1 until it finds a free
one.  Since IPv4 tables are stored in a 256-bucket hash table, a dense
set of IDs makes the probes repeatedly walk growing hash chains while
RTNL is held.

Count the existing tables once and use a bitmap for the bounded range
that can contain the first free ID.  This keeps table-ID selection
linear in the number of tables instead of quadratic, without changing
the lowest-free-ID behavior.

Fixes: 1af5a8c4a11c ("[IPV4]: Increase number of possible routing tables to 2^32")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/ipv4/fib_rules.c | 44 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index e068a5bac..55751b0d1 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -16,6 +16,7 @@
 
 #include <linux/types.h>
 #include <linux/kernel.h>
+#include <linux/bitmap.h>
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
 #include <linux/inetdevice.h>
@@ -216,16 +217,45 @@ INDIRECT_CALLABLE_SCOPE int fib4_rule_match(struct fib_rule *rule,
 
 static struct fib_table *fib_empty_table(struct net *net)
 {
-	u32 id = 1;
+	unsigned int h, count = 0;
+	unsigned long *table_ids;
+	struct fib_table *table;
+	u32 id, max_id;
 
-	while (1) {
-		if (!fib_get_table(net, id))
-			return fib_new_table(net, id);
+	/* The first unused ID is no greater than the number of tables + 1. */
+	rcu_read_lock();
+	for (h = 0; h < FIB_TABLE_HASHSZ; h++) {
+		hlist_for_each_entry_rcu(table,
+					 &net->ipv4.fib_table_hash[h],
+					 tb_hlist) {
+			count++;
+		}
+	}
+	rcu_read_unlock();
+
+	if (count == RT_TABLE_MAX)
+		return NULL;
+
+	max_id = count + 1;
+	table_ids = bitmap_zalloc(max_id, GFP_KERNEL);
+	if (!table_ids)
+		return NULL;
 
-		if (id++ == RT_TABLE_MAX)
-			break;
+	rcu_read_lock();
+	for (h = 0; h < FIB_TABLE_HASHSZ; h++) {
+		hlist_for_each_entry_rcu(table,
+					 &net->ipv4.fib_table_hash[h],
+					 tb_hlist) {
+			if (table->tb_id <= max_id)
+				__set_bit(table->tb_id - 1, table_ids);
+		}
 	}
-	return NULL;
+	rcu_read_unlock();
+
+	id = find_first_zero_bit(table_ids, max_id) + 1;
+	bitmap_free(table_ids);
+
+	return fib_new_table(net, id);
 }
 
 static int fib4_nl2rule_dscp(const struct nlattr *nla, struct fib4_rule *rule4,
-- 
2.55.0.windows.3

