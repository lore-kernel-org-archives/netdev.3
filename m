Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA101DED76
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178672; cv=none; b=NhW50ziqbAc+O70liMyLh9ZlRGBYDlxKRwLJ3k0ZnPUJSHKuTb+jSsjTgR5Z1+4k+HO8//OmjUnZHvUoTQ3Pcqf2Qsh/zCh8n2nebdslwYUdMv7bgckQmyUj3HI137XYjAuuXM1bOUnw7HzkPo7rm3NqxyHaZejZhWbYWawzBr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178672; c=relaxed/simple;
	bh=vddhhLfJFoNR/Pudv6TWiHyZGFLfBiLpicAF55+Y+o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uh8XkWB7SYULYHoUfLaZnoJGE/7iS0i5gU1f/4FnhQLbuku0P8uH2fB9wyo+P0z+8u8yYuLbXwXDww1YKJEe0WtQFbqaqXvlD6iC+JwK1iDURTQm2IgSaF3wmbpMYqaOEQEsd2mfyv0yoIA3ODGjOJAX/yrA4oLKjYrJOk/oOdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCaGz+jo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCaGz+jo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699E3C4CECD;
	Thu, 17 Oct 2024 15:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729178671;
	bh=vddhhLfJFoNR/Pudv6TWiHyZGFLfBiLpicAF55+Y+o4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gCaGz+jomWGz32HCS5UZGFVM9ueBGgbjE3iUCl6OpgBEC5Zppy+KIytIgOIqsQJgI
	 SgM5SITMfkmDPYpaG76O7KccLKKlaOOtfOH3Cnzgi3aIKyzXc0m1n3OJ34/VGcplVr
	 WdJXtC0FqpeYEqJxgE4/fDSgwzqvWPovGuv2ok+HaILqnqZJ0scRRxlCyVcw6DrALJ
	 MNhLv8fhW7OeHpfcZu9b+uffubr+9sj715sNQCcYzkCjHMtR0kXYZHNsbs+kO0CzmO
	 romxaIp5ZP651pap3QPioIXDa+lxa7ZDu6mFbzNwpOmsSewAseRr09CFlAmWzo0en1
	 soIoyGmsbIB+A==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 2/3] net: sysctl: do not reserve an extra char in dump_cpumask temporary buffer
Date: Thu, 17 Oct 2024 17:24:18 +0200
Message-ID: <20241017152422.487406-3-atenart@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241017152422.487406-1-atenart@kernel.org>
References: <20241017152422.487406-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When computing the length we'll be able to use out of the buffers, one
char is removed from the temporary one to make room for a newline. It
should be removed from the output buffer length too, but in reality this
is not needed as the later call to scnprintf makes sure a null char is
written at the end of the buffer which we override with the newline.

Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 net/core/sysctl_net_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index e7c0121dfaa1..8dc07f7b1772 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -62,7 +62,7 @@ static void dump_cpumask(void *buffer, size_t *lenp, loff_t *ppos,
 		return;
 	}
 
-	len = min(sizeof(kbuf) - 1, *lenp);
+	len = min(sizeof(kbuf), *lenp);
 	len = scnprintf(kbuf, len, "%*pb", cpumask_pr_args(mask));
 	if (!len) {
 		*lenp = 0;
-- 
2.47.0

