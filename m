Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D483FF88E
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363621; cv=none; b=sBDo4j9SoTHQ9m6RuIrFKnu9TYLMDnEKQHR6ByitRNMvk4l4Ns439Q8pG7aHdfdL7L63jWK/qjBs32V2Z50gdX8Bso7Gy0KhSNbfgKaur3nxzTMVbUUtbXE7XDuK5HkWRBwqVeE99w1vsvlmjKIlEj1mVcTPc+kOPQ+/LjUbxcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363621; c=relaxed/simple;
	bh=AlLiZPGPdutZRZ5ykWkI80lYrQnEw/kcOcoZpXjLCJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdM/0bYv+ZUIVoteJC+FAfzjW56SS1DeePUXCZvi22YC1xgoVuKiKQWUN+LgcMDWWbUrDMMB1SVt5KiusL1NIjt/g82O96YIw75uV3AG/H295Ynt//eFYts6nMFKzgLFcBvtmhziMp0lo3CyyjaYd3zijEABOjMqNVH5XO5tBLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=niOiWhF6; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="niOiWhF6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774363616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4n5vM5kA5+y7gQTAZ8iS52yr87eahEjxM7+DmRQqiE=;
	b=niOiWhF619Uvnr2WgJdD8O8ebwlTSVXf65Ddhm6ApiD2CSDdLMdHSuOkYLRANPfeLTFn/a
	sRszAVLnOqmjtwuAOTS20OnISvaDg6/sn8E7NbJgOiNa3mrFXfs6QG+vfNEzccFKNDyGMb
	5cloDZsHtlQDQ+JhUPsl4+zXNQgfy3A=
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
Subject: [PATCH net-next v1 3/7] net: hsr: remove unnecessary void function return statement
Date: Tue, 24 Mar 2026 15:46:26 +0100
Message-ID: <20260324144630.189094-4-luka.gejak@linux.dev>
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

Remove the trailing 'return;' from the end of the void function
send_hsr_supervision_frame() per checkpatch recommendations.

Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 net/hsr/hsr_device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 90236028817d..6ffecc3f0004 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -363,7 +363,6 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
 
 	hsr_forward_skb(skb, port);
 	spin_unlock_bh(&hsr->seqnr_lock);
-	return;
 }
 
 static void send_prp_supervision_frame(struct hsr_port *master,
-- 
2.53.0

