Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794459238;
	b=SVQKvXLaHTRvI5sACL0F2kqGAJ6Q/G0CisqZoJIuEXfYCkvqQj8rvNvxHaO7yCfhjsXL
	 V/e+R6+0REWDt8hF17+TjIxvsAtcRuOgJtlz6bFtknAqGDkTToHnTOU1kvmHq40nYybu7
	 iWMXuIAxcPCCZIYBJARk6L6MXSPBGAjcynsN4YMPTY+BPH7mVLwFLjHnvuS3fZvcuNDwc
	 wJVoYNpyDObaqoufWqrDEun38WvS3gG9vhveqtdy0eiYt+2GFGX9I3Y6ULss9wqbkZKdW
	 BFJaG4EaWV5TRsqThjMvtlcafi1gPo8NA2+GDwCcbxCQcbpfGpqS1noibQDMPu/PYbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4jn2601OzEvO8sbqF6xpAZyXFL063l49lfq4W6eXEhU=;
	b=czC7TD6ZipB5U457cGSqeH83pHzuNuAM9ltsG9uIMYzCkTSXJxRebgQ08W8zVkYooXU1
	 n2AhV8YCvC6neYU78GDmr9t1NvYalIkmbGJ0BW6LvAZZ4b3yZCKmpoWbVl8l+MUur6+Vv
	 vR6SLmLmReKgxaK/doVMCh82yDwzHLZ9wlT22d1kl5Ff5WT5an5qUSdLOu4GGwh5hw5Ci
	 hDgdQJZ9uqZ05wCYFQ/Nfd6T9Mf89uCICpkPBhro8Cs+7g/QQoyUUYab61t7Cu01X4XO3
	 daa+LwnoxR8fwomSMrDlv+nQMGmiIJmJk0qDMXYZW8RrJ2EsiwScNhVI9yKB+OrZa6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="KI/Vl4Lr";
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B246606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 04:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B246606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KI/Vl4Lr
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso3048603eec.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 20:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794459237; x=1795064037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4jn2601OzEvO8sbqF6xpAZyXFL063l49lfq4W6eXEhU=;
        b=KI/Vl4LrvvRBt4/mAUSdgGnjjqFJXwYtrPhXz9+z6Ui+qAKlsuRCXiAiPmzWP87f/K
         6IyV9r5RsM6oQK4fmxQOLnTHc1ujvznrU6xpGQDahIGaiHSbm7m0pZ1ynPxhSO/PR3QZ
         4VXgFd57h2H4ewkHSpZM/Xf5o0G5VojSb6WG6VDgvopfGZk3ztAV0/J3nEvsS/4i4YOy
         yqXux9myQ+jkj3WK64quIJFQ++U3oyxA9xQ8a67CINirAnyyHtvcdyv8vf45FPfdDduv
         zgAYrgf1GMTW91L/VrmT673crtyfSt6uL7DgyRuQ8TaYlfLVaUYzS0bwO6W2NagjJu6t
         R1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794459237; x=1795064037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4jn2601OzEvO8sbqF6xpAZyXFL063l49lfq4W6eXEhU=;
        b=bbMmi/ZT5ML3FC4VH3RNNof4FLEMI4QL5zDe4nMd3DOxO7WN2PfSRcoPd4jlsSP/i1
         WZ9wqKxgexsQzbhk3BppgUo1naLU+bhKWUTvnVJiqyIXKrqSwILnvzX8APucewo4pRW4
         qgi8gY1ymWprq23FaoVIXYSpGQMHCDF42Yr/ZBx0Z4ALb8xZw4/OsOpIfJsqGTNK46Cz
         x9BNwFcO0oZQN8mXz4McB4783kMdF/8RSczGuPSopNQDgzZkD6DBPtmR9IsjMS7V2wi+
         Q+US1Daq2f35rJcNbddZyX6yYBxts3n9GancyCsxQjO14d/MW9ztf1A0aHMj3If8WBBG
         xjew==
X-Gm-Message-State: APuU4Z/QrNj9ZsLpKaQT621PpjVnQlfoBIv1OsTd3N1xq0tUZw0FRNyF
	5Nt9vUbGjKqpdZIanvSUPMiiE481kbfZr06iDE9wHGypxf96F3aAqwQ3zyRtDQ==
X-Gm-Gg: AYBFou02ZWn5JbZUehqjji++vXzYsBXZwWjNueSHH8Z5oPE6LX3YbLKeR1/015ia3fJ
	i9tboNxnxTLFgoCpPgnxA0odr/7inytXWv6Kv8d66NCqvV3hBQgjtctSb0E+MOuwmWm/SpRJIqw
	W26SAp0pPrSRfTR224WstvxDvVIy7S1xPrgKbnGj4uOHfetospaO2OWzHLQsyxJYRdL5CrgpqG/
	73Zgd/b0fOHQBF26Pr9v/DBHSztJvRN9Kdw92HvfnDvSLfZt+9ZryrDHZP6fxnT2U8dY3Vb7Lhk
	7UMC2OKjhXN2zDvNDAbZb2QnytQdt6FkfFNA0NnTykUHDwGba3EsTQeG5dcPCSkOpq5QyXZ0Svl
	XMCzaId7lKmxKEvnEtWb5O7XREniLBZuurHbsg/buiyA6H6/5wr0C9HdTzm43ohn0ybP3XpfDqC
	q921JA7g2zDKLX9ybxpyjoWHmbXZA4qGL+fAtusDiJ7YKZfmSme0E6BK7pjqwCJ7wRdpWCDgE72
	u2Z9YUR1eJKqkja6CFpv+AKBQRCP54bGNVBmOd4kIyE4v7LLHSw7psG5FHVy1omLJwsMo0Nii5D
	peQU5Hb4cw==
X-Received: by 2002:a05:7300:e512:b0:36a:1bd4:628a with SMTP id 5a478bee46e88-37685d72ae6mr5684131eec.9.1794459237170;
        Wed, 11 Nov 2026 20:53:57 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm23921585eec.17.2026.11.11.20.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 20:53:51 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jijie Shao <shaojijie@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	David Yang <mmyangfl@gmail.com>,
	Herbert Valerio Riedel <hvr@gnu.org>,
	Jeff Garzik <jeff@garzik.org>,
	Danny Kukawka <danny.kukawka@bisect.de>,
	Mugunthan V N <mugunthanvnm@ti.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH net v2 07/12] net: au1000: fix buffer descriptor free list insertion
Date: Wed, 11 Nov 2026 20:52:49 -0800
Message-ID: <20261112045301.3669532-8-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112045301.3669532-1-f.fainelli@gmail.com>
References: <20261112045301.3669532-1-f.fainelli@gmail.com>
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

ReleaseDB links the old head to the returned descriptor and makes the
returned descriptor the new head without updating its stale next
pointer. This loses free descriptors and can create cycles. Link the
returned descriptor to the old head instead, matching GetFreeDB and the
list initialization.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/amd/au1000_eth.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index ea8f7787dd5d..f127c0184036 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -581,9 +581,7 @@ static struct db_dest *au1000_GetFreeDB(struct au1000_private *aup)
 
 static void au1000_ReleaseDB(struct au1000_private *aup, struct db_dest *pDB)
 {
-	struct db_dest *pDBfree = aup->pDBfree;
-	if (pDBfree)
-		pDBfree->pnext = pDB;
+	pDB->pnext = aup->pDBfree;
 	aup->pDBfree = pDB;
 }
 
-- 
2.53.0

