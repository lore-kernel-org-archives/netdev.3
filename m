Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825289;
	b=gOX5pPgMZOHO/2hbH/ZWbpzsHEbTIt35Io852cUS9cAFEazMImEmrTNp7NDd72DQlo7O
	 BTk9EiaElSBcUq7xgqthgjtW/LxCCzSTdLNIyc0NuNaK/srfWj2kwFhyLU9CBWIGS9eLd
	 Fim85aot/zp2lyZAD5ZFScgiGGKPwL9q/LcBtwjWpHcOHTfUYtibHhItTUwKMbaZ2F+mv
	 0C9kFRPMzF3CgzWEB4sAEj0VSTOlnzaZgqf17dJV4VHV5vvEVKxwok848/bRZbMRUxCXe
	 b9iMHJLi8errmsl/Rpuw22fuoyBINVwuL7JwvItq49m/S/laPh7bvPsnA88g8T0r67Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825289;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=UbSwO3gZAlShSf8y/3JGnXMddTOZvjpIdY8ib59dlm8=;
	b=1NMWoY90ioiLP4AmFfoOsKP/lyhgAPAOrWtjYhxdJifgG4x1QvlL6blm86PeC/tXCfEw
	 wt24kwkEV4cX2OOfG5+ROLn8ojuqcTa0A+S3OZMzGk/x4icMo0IZD/p89vp1m2f9y8Fo9
	 GW5TPtNhwk4FOgHIpfOtK+sB5K1RZnOaM2ZrgtuR74zIKpQnmuakvaZfcPsw6p31tInpX
	 Wq38933pKulAPhaJM5ZPePc90VFee/k2KunBdAXnJosnWDUgM2faY/GCrcbzw3sO9I/zk
	 CF4lQPR5J7GmlJIGRx474ksaFs2up9OfIU7CRH8mcOTWXlFcMO8QfcRJnCTkM4ovzUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=H9Jcaf+4;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD7A60A6F7E
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 20:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDD7A60A6F7E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=H9Jcaf+4
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93f2b8cf037so95125785a.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 12:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793825288; x=1794430088; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UbSwO3gZAlShSf8y/3JGnXMddTOZvjpIdY8ib59dlm8=;
        b=H9Jcaf+4eI4ocvC+KHr9wa2wdRjcg6n+xbh9wnRoU/OIrTtIA4oUIcwuj3VgRsJutA
         rVO4oMAPTPyEwCkg+qwMLZeJyn377J/JMhCOnMmCTfeCQJETUgj1QuGVl9gpyFicubEd
         vur1cmHR9FeNdgBqYOS/NTXboIRwtt6SVtDv5y9APyvVMgUktS+hAilEPIBJXDXF9Dcg
         aN6KJ1C1d3dBBuUf4hI+XHqgLam49kJmiu+PZVEo080/42CBq45olAwCtUtzSF8mWVw5
         zedO9qaph5SKUk6Ubglx26bcRfZL6oxzMVE9DFRbGg3BeXNER1N+OTlWz6g9EBqdDS2Q
         6jBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825288; x=1794430088;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UbSwO3gZAlShSf8y/3JGnXMddTOZvjpIdY8ib59dlm8=;
        b=J5uCDRf4PytZQxAjmPRWtwrQDWxJ39Ux4RbMk+Y+flLiCSTXCN7w/Y6Fzf5rdt1ZQp
         diF5rHFJAGozPn1yTRDmwLSnkbEUVqi5GsLnW0qbvrxCmj2+ERWPBPtUTcAH3PDcmsYf
         jaLShbfhXRwNfzrJ2WmuCCo9CtZmDpaoHwtuAZ3BgLNF2P8uR6d71U6sSu+dvdFMj7yS
         SxbcJFv7Nf02FiA/h9tlVtRqMjo/9LIz79Gy1zariKmji02gzNOP3GMRHrkVT0bUObay
         vavuGhjkC+KOCXtwyUHwKPeBNYcc/1Jaj05VkURIjw0cH8frQKVQSnd1lNHvrFOXyudn
         jA6g==
X-Forwarded-Encrypted: i=1; AKwUvBxnWdx9UjIWF92S5g/S0gxRk9VFXIC53hlpAof8Sm0nLd+/bwa24aFq+NCBEoMe6NM1Mr5Fuck=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Jr7H3GYaG+6clLYvch8eStSX8z5XcYAfcPEC0bKZ0Ur7OHnj0
	njalVz1wN96/lb1phAwlKSP959Pr15ME9ClM8dDk0gG3pKvMaFBx+TDiqiwRJZtcHPI=
X-Gm-Gg: AYBFou0aHIzlVg+YtZNu4TIHTq6Lv5G7gCC2fBWI5/SYKU//rxyXpwLLpdCxb10sK3l
	IzrSeWRJEuLoIPOTebVyVB1/ueTtU7enrQgiZTYY0Tra5SmVCnCjqFswKqKxe4Ej8tt2xCCmeR1
	FBrC3ygGnb5/trENjatyPUturkQXGFG9oUggMSJ+0S7aBxzAbB/KWnoFTYs9hPKYlnhec4pzWcN
	d+6sm2XD7yzNjX5K2lUGOShTlwB8CC85aHoN17laMIXUxU1lFg8JePMWXXDvRUV6K2rjQkuc8Ok
	X27CG+pVaeU1kURjA4CNvgAUYGGbd/QW5u9b0RvxvHTrl51jZr97BWhpF2JxrX180Z54DG/EhNO
	pcKTCokXXozKonULNcUqm5DrunhKzsp1yyaN6g5pFHaokSNzACzyjMlFqNrgwK9nQVQrHna0vCB
	8X7y5i1h4EEKhKRFk5z3EoBgMkkrp6ZUUJbW39Ya5tV6xC6x6u+Jo9+Q+Fl8u7fXtRkOw343MbY
	3bKmGyjDSCJKX4pCj4h78PHyNi+RApLGB0yi9fqo+ec7KbtDRgu9w3mRuOXPeWAAOSV53BVWVlK
	87/IWQOhtdTATSidma3QgClQhgtVRVZaVpvwOwzgYErxyA==
X-Received: by 2002:a05:620a:a905:b0:945:b9c8:de5a with SMTP id af79cd13be357-945b9c8dedbmr1356158885a.20.1793825287918;
        Wed, 04 Nov 2026 12:48:07 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d483d762sm294338885a.27.2026.11.04.12.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:48:07 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 20:47:27 +0000
Subject: [PATCH net-next v4 15/15] net: update comments that still describe
 the skb BUG_ON()s
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
Message-Id: <20261104-b4-skbuff-bug-on-followups-v4-15-b7ffeb364f5d@toxicpanda.com>
References: <20261104-b4-skbuff-bug-on-followups-v4-0-b7ffeb364f5d@toxicpanda.com>
In-Reply-To: <20261104-b4-skbuff-bug-on-followups-v4-0-b7ffeb364f5d@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Fernando Fernandez Mancera <fmancera@suse.de>, 
 Mina Almasry <almasrymina@google.com>, 
 David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, 
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793825269; l=2967;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=EAJ0bQj/Oj/in9lIWu/G1LG29YPEIg8lFuBrNd3Sw5Q=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHf4WC7tdHNHClwRAYr93iv9/GKE9HPJjZnVhEDjCwlX4VLZbqFYVp2C6I1QijW+aNqGzDet3wR
 d30tDtFHCMgo=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The skbuff BUG_ON() conversions left a few comments behind:

 - bpf_skb_net_grow() says skb_segment() BUG()s on a frag_list with
   head_frag set at the downgraded MSS.  It fails the segmentation and
   the packet is dropped, which is still why the skb gets linearized.
 - The skb_to_sgvec() kernel-doc doesn't list the -EINVAL that
   __skb_to_sgvec() returns when @offset and @len run past the end of
   the skb.
 - A comment in the netmem KUnit test names BUG_ON(i >= nfrags) in
   skb_segment(), which is a check that fails the segmentation now.

No functional change.

Acked-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/filter.c   | 6 +++---
 net/core/net_test.c | 2 +-
 net/core/skbuff.c   | 5 +++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 09c60a58c82a..9881ac89e94c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3723,9 +3723,9 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 		shinfo->gso_segs = 0;
 
 		/* Due to header growth, MSS needs to be downgraded.
-		 * There is a BUG_ON() when segmenting the frag_list with
-		 * head_frag true, so linearize the skb after downgrading
-		 * the MSS.
+		 * Segmenting a frag_list with head_frag true at the new MSS
+		 * fails and the packet gets dropped, so linearize the skb
+		 * after downgrading the MSS.
 		 */
 		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO)) {
 			skb_decrease_gso_size(shinfo, len_diff);
diff --git a/net/core/net_test.c b/net/core/net_test.c
index 03203454cd19..976d14896251 100644
--- a/net/core/net_test.c
+++ b/net/core/net_test.c
@@ -1524,7 +1524,7 @@ static void netmem_ref_test_skb_segment(struct kunit *test)
 	/* 5. Linear head_skb (nr_frags=0) + mixed pp_recycle frag_list where
 	 * member A has linear + frag (pp_recycle=1) and tail member B has
 	 * linear len == skb_headlen(A) (pp_recycle=0): keeps SG clone path
-	 * synchronized without hitting BUG_ON(i >= nfrags).
+	 * synchronized without failing the i >= nfrags check.
 	 */
 	head = alloc_skb(64, GFP_KERNEL);
 	list = alloc_skb(64, GFP_KERNEL);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 45cd77e153f1..29951ce11850 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5641,8 +5641,9 @@ __skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset, int len,
  *
  *	Fill the specified scatter-gather list with mappings/pointers into a
  *	region of the buffer space attached to a socket buffer. Returns either
- *	the number of scatterlist items used, or -EMSGSIZE if the contents
- *	could not fit.
+ *	the number of scatterlist items used, -EMSGSIZE if the contents
+ *	could not fit, or -EINVAL if @offset and @len run past the end of
+ *	the skb.
  */
 int skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset, int len)
 {

-- 
2.55.0

