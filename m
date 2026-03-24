Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5414F3FF8B0
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774362934; cv=none; b=YoONUe+JeBZ56j2ZL2IhYsiR2JVCoLcnPxtCVxTRXGG4+mIAZeYL84AEoJ4S5fiz8iCFvop+1OFq0zBWNk0yYISNo2to4wBG3RrOmOtzwKhe0LRxfXrCx+g4ZqbgmTlFLOj7MTN7wwZP+/vRFFUU+XQxLOqoSnsCIJzeNEgB350=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774362934; c=relaxed/simple;
	bh=wEP0wRbCRZBxROcXg+r+RI888bd1H2e6DUIoY7peRRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEcxRQ0FIwpyRgXe+3YU3P50xya3X5vr1MxyU0KCp3SWxmrx183fdyi9V3979yx1j0HLCHtYhpaeW4tnjtu4Peg+Fq/vwJmf+XLImtccJ90HO26Q8fj7gLj87cXIW++oRWqLFKhY3AVy6Dgjqvt87bD5L/ih8fgTo5sHf6tyzmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AwNbKSiZ; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AwNbKSiZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774362931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYfBLnylasMK/XC970ogaeLH3TRE02allvnfbVnf3ko=;
	b=AwNbKSiZtOv9UYh3NIDJlojaJ3FnfVzkNx1hPRZjikoo7+bmVUE1EsX4RCeHhZidDSSWU3
	HAxqCxjKoHe1INGoAqUgvByx/wwcxsYXCQ+AC5WJA32BB/Yg7ZSij9EThnVQ/GSJeJ3hy5
	H3HcD9Anh1+C0E7935cBpPiv3MuXb6U=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	fmaurer@redhat.com,
	liuhangbin@gmail.com,
	bigeasy@linutronix.de,
	linux-kernel@vger.kernel.org,
	Luka Gejak <luka.gejak@linux.dev>
Subject: [PATCH net-next v1 3/4] net: hsr: require valid EOT supervision TLV
Date: Tue, 24 Mar 2026 15:35:02 +0100
Message-ID: <20260324143503.187642-4-luka.gejak@linux.dev>
In-Reply-To: <20260324143503.187642-1-luka.gejak@linux.dev>
References: <20260324143503.187642-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Luka Gejak <luka.gejak@linux.dev>

Supervision frames are only valid if terminated with a zero-length EOT
TLV. The current check fails to reject non-EOT entries as the terminal
TLV, potentially allowing malformed supervision traffic.

Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT
with a length of zero.

Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 net/hsr/hsr_forward.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index aefc9b6936ba..d26c7d0e8109 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -110,7 +110,7 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
 	}
 
 	/* end of tlvs must follow at the end */
-	if (hsr_sup_tlv->HSR_TLV_type == HSR_TLV_EOT &&
+	if (hsr_sup_tlv->HSR_TLV_type != HSR_TLV_EOT ||
 	    hsr_sup_tlv->HSR_TLV_length != 0)
 		return false;
 
-- 
2.53.0

