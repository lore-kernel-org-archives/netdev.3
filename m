Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E063FA5CB
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363623; cv=none; b=HuisEmqssRP6BErfpPnmL2w24UvUCyw9dhFlFJr/lmuY5koOYgIwZNTG0KCZa5qtj5QnAosDKburR11DiBatQpusyM+MOtXD9LTa8Qn3qKid+MrDAgL5/t0kDa/On/3+cf+gN0RYkEk03Xo1sfeLN1zKwGHaPRWWhIGAsiBKeN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363623; c=relaxed/simple;
	bh=Ayl+OLx/i5ZWc8NtQPBdVrs0HLr5T9vgoMdXbSSWHy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AiUyJYsY6IyZvunDKcobAznog+8bmnO7N6mFkLQztlBNruvtWR1UnOypzoDwAxm0rmpuOoRVO2La5alM9atZAEuLAQcyutBbeu75TrX5lN9c55eBA0gsewkoFI1pJTzvZtymp858rp6RBgnzlC4igLOxB0If7BAeckXm68cGNy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qX9cKex/; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qX9cKex/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774363618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEP5bbaUGSX6Caw1GbV34m6S6/Z3qANCDebKYe4MrmU=;
	b=qX9cKex/ukGG0bSmEEquoTdiFy6ctYJz7dQKbPYZ27x7zp8q69cbbUeHM3tymHmlzPM85s
	IentBQB1HrmrQATyH0EdU4iRDCDly/k7LYbi8k3xTsK9FOy81XtJ88spdYkh8ALL3Rnhq0
	2ekK9R7R521B96lCd6aF1Jz7UQKReCQ=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	fmaurer@redhat.com,
	liuhangbin@gmail.com,
	linux-kernel@vger.kernel.org,
	Luka Gejak <luka.gejak@linux.dev>
Subject: [PATCH net-next v1 5/7] net: hsr: remove unnecessary braces for single statement block
Date: Tue, 24 Mar 2026 15:46:28 +0100
Message-ID: <20260324144630.189094-6-luka.gejak@linux.dev>
In-Reply-To: <20260324144630.189094-1-luka.gejak@linux.dev>
References: <20260324144630.189094-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Luka Gejak <luka.gejak@linux.dev>

Remove the unnecessary curly braces around the single statement
for loop body in hsr_add_node() as per kernel coding style.

Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 net/hsr/hsr_framereg.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 577fb588bc2f..9c3b7381788e 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -182,9 +182,8 @@ static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
 	 * as initialization. (0 could trigger an spurious ring error warning).
 	 */
 	now = jiffies;
-	for (i = 0; i < HSR_PT_PORTS; i++) {
+	for (i = 0; i < HSR_PT_PORTS; i++)
 		new_node->time_in[i] = now;
-	}
 
 	if (san && hsr->proto_ops->handle_san_frame)
 		hsr->proto_ops->handle_san_frame(san, rx_port, new_node);
-- 
2.53.0

