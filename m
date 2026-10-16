Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22773DA5DE
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792133436; cv=none; b=OW+8Aj7mcqNBcgbhoRHyqoKgsOam8vrjcJ038c9i/dqHDkStcGQDxjl48RTvGweEbaK/n7pzZKk0aW7D3zgoDzgpBB66z6uqFRK27eFu6jouqDvJrD50dT/4lfk63tiCPbO+Fr/heAiOQBlDXzyU6Fg7HyODsZg71zJrMbT9Vxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792133436; c=relaxed/simple;
	bh=nWS7eCEStH+2VUXKhiM5hi4kpoYoUmJU/RNxaOVuHvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TTcJqHlAhW8oxjSeFAj+bJpOarZk6ErUeqgE5eNZEeEiZa8hYYuh7ePpYHYCqMcUF7F9vM7SP0SZnaEKri2jxDj3MlQ4hmhsWtsxt/1pcuUklaABj2tmD0imktI/XJz29lczyx7VLX2Vlb3HSfc6IEq+LJIkO0rZ5OD9ch6zHjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfGtHaDJ; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfGtHaDJ"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-504ae5941faso1355050b6e.3
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792133426; x=1792738226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7tqFVMOcFuLbqHFucc5Mz93XTsxhDa2QOdht/FJo6ZQ=;
        b=IfGtHaDJd6BuV4cVt6E+giJCV524nSAX83dB4423CFLJtPUvZEqDNiqgkTAajC9C/X
         pl8vbeItHcjObvHzmxuFJVNdGnyJ6QcejjKInxvhKPo/Xvzo4YGqtl58O4pbGZit/daW
         Cxdpgep7dYSH4VKDTt5H3ZGcvbKR+0Npf70M+vtPwnHvMXeCFdHFGFsHkuy3Gon1bb3A
         0xK9hobMGF4AQ6H7D6Fp313aUloZCtU0oSOgrwGgFhshn5PDqZD1jIVpyIFvTC9aAVZ6
         LcwjnUjJOmaw5m/+9cCpiI7sV/9VR/gVJumF4dKmYMLea0t3qz35rbE0JqDwAOXv4vp5
         R+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792133426; x=1792738226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7tqFVMOcFuLbqHFucc5Mz93XTsxhDa2QOdht/FJo6ZQ=;
        b=whowJdVtF7e055EporpkNlpWD1HaIY9FmMPtVbAyO0am2nUTqRuFjH1XqEqAGXMp+/
         YLOlmafEleM8LdCnEKoLqioI7zSMDjZ5QNDZvMtFlc6Aj+5pAr2ocDMoi//mUK7G769a
         M+rCDZjBuoVlhkF4Uf+EH/33py3BWkMrnrVNYvpOfp5Mz+ljeh5BZ1AJmhdvIh5o/bj3
         uA30QWAfZdLMFpIFwPkL8GdJI2vauijFGWGdzbr9pALob0E7skU/OnPSbHL0+gQWagD7
         +SudgVptfmcNyk5Hd5AwDGDJZ8LSGNdnfC15hL99KBh3CUo2MG/BPia1w8zdj3kdpVaF
         1jEA==
X-Forwarded-Encrypted: i=1; AKwUvByDDkknrOSWu4junzXXpwhfbhcipQU1NWCfEfPPZSb8BQKIgvIDy0TTJbI42IeTb9J6+A+SgIo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLO1zYt2zBSoakUujZMeD+YBa2Bz1Vg0StgDvpskf5uoSGAlONM
	4em0PkrGdGqlXLFncg5FT7NLQQYVzNZ85Jcle8BF3Sr33YMSvFiBd0tmz6GudB5d+QE=
X-Gm-Gg: AYBFou05kaJm8pGaWhAJ9ePN4JUAJdW3AHCTdaGqYJUBIPbOYdN3u40EwBIfCOsb+aW
	g9BW2Y/H2RI6rJ0TxhDNwd4AR1qRCDQ+E5F8LOys35u7hTSzjumztbPnI+kkxCS+bYzcAedhVIM
	YM0WWvBL02eD6mvQYYdThM7SApRHriqLQr6Txy9StR+nlByZk5iLowmvPK92LL1XIwEQ+O9UIuF
	t/tS6//HDczEgZGO+wGQJUsY1kLvV5prh2PKf0C5TuLy93aRkP9diejG+RaACsIaW/DELsODZth
	b7w6M21kAsecqw0bPy+0YHCpSX+EzHP4JmGay9JyIJkycSi4NRW329pQq8KOeMkH/suRmqnH+Uj
	U7RQ9wPEGIVMvMb2waiAuHT6vi0DTkG3cFHo3rWfAIhVyuMuFl1FHISKNamZFgS2SuVwm8SXAfi
	OdwwzgUJP2gBHTY046EJ304wsmJZI8jw8Y0Qcnkc1Bdyc57WxGBAAo2sDZ8VZbw8YglfhclvVHb
	SW8zM0EBnAHw1ySa1TgZpSg3nwro6F96PVfVBsSQW8WU/lpNTgDj5VUiR08Uw==
X-Received: by 2002:a05:6808:3a0c:b0:503:dc14:8b05 with SMTP id 5614622812f47-50c45c674dfmr23799690b6e.5.1792133425917;
        Thu, 15 Oct 2026 23:50:25 -0700 (PDT)
Received: from cr-x-ubuntu2604-client-2.dev.fyre.ibm.com ([170.225.223.17])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388c16d862sm851214b6e.9.2026.10.15.23.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:50:24 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: dhowells@redhat.com,
	marc.dionne@auristor.com,
	davem@davemloft.net
Cc: edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH v2] net/rxrpc: Simplify rxrpcpeerseq_next()
Date: Thu, 15 Oct 2026 23:50:11 -0700
Message-ID: <20261016065011.105764-1-chelsyratnawat2001@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the redundant initialization and conditional handling of n,
as it is always set to 1. Use the constant directly when updating
*_pos and starting the hlist iteration.

Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
---
Changes in v2: 
 - Remove n, as it is triggering unused variable warning.

 net/rxrpc/proc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index e9a27fa7b25d..5b780fc3f289 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -352,7 +352,7 @@ static void *rxrpc_peer_seq_start(struct seq_file *seq, loff_t *_pos)
 static void *rxrpc_peer_seq_next(struct seq_file *seq, void *v, loff_t *_pos)
 {
 	struct rxrpc_net *rxnet = rxrpc_net(seq_file_net(seq));
-	unsigned int bucket, n;
+	unsigned int bucket;
 	unsigned int shift = 32 - HASH_BITS(rxnet->peer_hash);
 	void *p;
 
@@ -367,19 +367,14 @@ static void *rxrpc_peer_seq_next(struct seq_file *seq, void *v, loff_t *_pos)
 
 	for (;;) {
 		bucket++;
-		n = 1;
-		*_pos = (bucket << shift) | n;
+		*_pos = (bucket << shift) | 1;
 
 		if (bucket >= HASH_SIZE(rxnet->peer_hash)) {
 			*_pos = UINT_MAX;
 			return NULL;
 		}
-		if (n == 0) {
-			*_pos += 1;
-			n++;
-		}
 
-		p = seq_hlist_start_rcu(&rxnet->peer_hash[bucket], n - 1);
+		p = seq_hlist_start_rcu(&rxnet->peer_hash[bucket], 0);
 		if (p)
 			return p;
 	}
-- 
2.53.0

