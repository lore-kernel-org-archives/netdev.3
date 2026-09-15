Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050253BE644;
	Tue, 15 Sep 2026 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476599; cv=none; b=PKPhDH5yiP5/8WjB951lyFUJkQzf/YW+EF1D6Qdcf41H5VyRi0505tsmdEgSTSxkmJf5uJhl8RDwjvWGo7xGL8MLcV04dKCbrLdfbOEA9KZCnGPjfE8WWo2Wrkpg+J6tPthX41l9HXyKz5tDZIXiIxccHv0wndwWNUPkm4jNmCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476599; c=relaxed/simple;
	bh=ZReFf5tcTRop/Bh/NCgpio5QaeTuBdN6Hgi/v39o1Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QC3YrY9VkQBXLTqJByM7N7dIKH/RzAQZxOjgVKRuRAbJQkEgclbbL3drPPeRqYnJRY6iqOqy5wbGG+MDPAmaJuGi+ZCeUeadh8b+B9Fg7Muh3MfZPcUMNttiKTV3pIDIbDea2R5ZzF1mOzrLPmdzjFpp+y7ErN+jxs91JBrEFQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=mNRRtvNS; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="mNRRtvNS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1P329wzk3kFFolmkxokCspdX5bpH9Yz4CV4vaCg/5V4=; b=mNRRtvNSG9ad4IQizBPYu8fzbn
	r+4NoFTJIuLdvIrU3XrJZXXc1H/KJE8GAsoKiI1Xa9a0CnQTNSQGPyirGEQV41BVXHGyt9NnqLAam
	OxRrSKPo+EjeW4b2Wv3DHBZdWHB53f9xSMzBpCK/yVHFLNejqVNB/UoZeqrfHBAt+Hs7pW4c9vEC1
	N3WmtUwQdgYVkCZlZ6eY1SJbwBMglFDKygsTEQzCmgw2xK1prHxTk6WW12IpfQwiSiKM3VhB3qWaq
	s3U1JllWz42+9hY/LCI3E06ZaQ0VZPdrz3KKLsEB15JrK+d6jNPAzY8apKW4Hy7gaT2S8FyTVpsQD
	TU5Yap3w==;
Received: from [151.115.150.205] (port=50576 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1x6Sbi-0000000GwKm-3Lo5;
	Tue, 15 Sep 2026 14:49:54 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH net v2] net: gue: reject invalid REMCSUM offsets
Date: Tue, 15 Sep 2026 12:48:07 +0000
Message-ID: <20260915124806.2852293-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hello,

On Eric's suggestion (2026-08-24 13:38 UTC), I rewrote the v1 of the patch
to move the check into validate_gue_flags(). There is now a single check.

In case of backports, note that this fix depends on commit
d335dcc6f521 ("gue: validate REMCSUM private option length").

Actual patch below.

Cheers,
Jérémy

---


The REMCSUM option carries an absolute checksum start and checksum field
offset. gue_remcsum() passes them to skb_remcsum_process(), whose
partial path stores offset - start in the u16 skb->csum_offset variable.
If offset is less than start, this underflows.

A forwarded packet can retain CHECKSUM_PARTIAL and reach a NETIF_F_HW_CSUM
driver which trusts the metadata, leading skb_copy_and_csum_dev() to write
two bytes about 64 KiB beyond the destination buffer.

Reject reversed tuples in validate_gue_flags(), after the existing length
validation, so all GUE parsers enforce the ordering in one place.

Fixes: fe881ef11cf0 ("gue: Use checksum partial with remote checksum offload")
Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>

---

v1: https://lore.kernel.org/all/20260820220210.3122690-2-Jeremy.Jean@oss.cyber.gouv.fr/

Changes in v2:
- on a suggestion from Eric Dumazet, move the REMCSUM ordering check into
  validate_gue_flags().

 include/net/gue.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/net/gue.h b/include/net/gue.h
index caefd6da8693..f37361aab28d 100644
--- a/include/net/gue.h
+++ b/include/net/gue.h
@@ -84,8 +84,9 @@ static inline size_t guehdr_priv_flags_len(__be32 flags)
 }
 
 /* Validate standard and private flags. Returns non-zero (meaning invalid)
- * if there is an unknown standard or private flags, or the options length for
- * the flags exceeds the options length specific in hlen of the GUE header.
+ * if there is an unknown standard or private flags, if the options length for
+ * the flags exceeds the options length specified in hlen of the GUE header, or
+ * if a private option contains invalid data.
  */
 static inline int validate_gue_flags(struct guehdr *guehdr, size_t optlen)
 {
@@ -103,8 +104,8 @@ static inline int validate_gue_flags(struct guehdr *guehdr, size_t optlen)
 		/* Private flags are last four bytes accounted in
 		 * guehdr_flags_len
 		 */
-		__be32 pflags = *(__be32 *)((void *)&guehdr[1] +
-					    len - GUE_LEN_PRIV);
+		void *data = (void *)&guehdr[1] + len;
+		__be32 pflags = *(__be32 *)(data - GUE_LEN_PRIV);
 
 		if (pflags & ~GUE_PFLAGS_ALL)
 			return 1;
@@ -112,6 +113,16 @@ static inline int validate_gue_flags(struct guehdr *guehdr, size_t optlen)
 		len += guehdr_priv_flags_len(pflags);
 		if (len > optlen)
 			return 1;
+
+		if (pflags & GUE_PFLAG_REMCSUM) {
+			__be16 *pd = data;
+
+			/* The field offset pd[1] must not be less
+			 * than the start pd[0].
+			 */
+			if (ntohs(pd[1]) < ntohs(pd[0]))
+				return 1;
+		}
 	}
 
 	return 0;
-- 
2.47.3
