Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672955;
	b=kPLa3hsHDuzvxTL7tmFlPyce+S82C9OJYMb9TWjkd4q9ibhWy22DLB+DMj7HETXvoLbX
	 GWT5MG7QYXfvznuepu79XfgG3QLZcSRNpYhGBgxgyNkDOENN6sLqDDrTDMo40282NqDX2
	 8Zp8r9dBE5EDgY75rGjHhboWaDz+PeHIuBJ48Ckgqh9J/+pjoa7vdV2Y3Ps7PRHcdhh13
	 PEBd0NrVRCfpqdiITlaupxHqILbHEIdhd2zzKV2K1BxQ0f/9C1XYrpyvdecMNB7DPLtE+
	 akDXp5mWfEBcFcb4wIkbEeAEFgwaqsJwofju0P5dX3nSVFLQQVgzWNgvGvymkRLsTxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672955;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=a+hFTEOFR15xhICqJoC3sInecNo3QCMXYhk+gm+DR0k=;
	b=p2RB7qpaPCroN8+jZzFfRFhVg6fiPfMRgyfSrjZb9T6CHhckStvN4AgIZDzt6lIZroLB
	 SnNBCeL/NnM4KSH0EXXld+V4PkKskfFuEoICh25Ou5vf4KtlCUSx00uAfl8bv8RBRkvRp
	 /PIlHxxInLCy7GljdbtCmwEou03fUAzfHuRdnLViWFzUw9sxJKx0PI1YEkhPJoM0E+nUd
	 N5g1V3Yrn4Nq+dul+QJdWcv4liJM+YjeQWAZYM8jVOBAKpdRJFp7Sx238YdfLIHrGOExO
	 PMANQyucoO0AvYlN/S+xAgFyvXbe46Unh2Bp9jJN/aInMshE31KzFQfyh0+MvKFsZhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=NmgotOK9;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C64606A33E
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 02:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68C64606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=NmgotOK9
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-53fdd2fb171so46767331cf.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 18:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793672954; x=1794277754; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a+hFTEOFR15xhICqJoC3sInecNo3QCMXYhk+gm+DR0k=;
        b=NmgotOK9wZQpjJpIpp8kwoqVUFcmilKE10lnihHeqFKmTJevZ1PfkLyxp+jqKB9jgu
         TzSzm+cJoRZnKznMdO4+TY0S+Gx7PuPdQBxt78e6S8oGCwy3kaZaSsZj59ZwQ3bAmvRS
         8/hDO8Q+E5VG5kBNvzeSSGV/WKMkFHLaVBntSLokRBSblTKG0dd9bUStN44G81PN1MAM
         ez4/gdFvq41RABq1l3iEqlAMTOW6sHCd4VkpEFyE92oZ8S+dVuIrhaTrH9smXr0gZ5Wc
         RdWI8Rz6J1OF1hVmqxrahAB+ElPXBzEbpdCKfCWNnP65+SUUgPLJWOP9eICP9KVr3Hc9
         QeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793672954; x=1794277754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a+hFTEOFR15xhICqJoC3sInecNo3QCMXYhk+gm+DR0k=;
        b=BmNdRmq0wMuavQRWPVcXI8dgRqmseWeWm0+w1OwF7tHnsbTLWFcj126tAybrDcSdtc
         aWEHaQl7SRuP3Y4KsqWvGsSEJBuqopzA7qr4fKVJWwrfeoLNOqt3iUcJixr8GUCzVMXz
         BwIlzodjRt4f0JVicTWQBUKJ6j/3ttRtEPZ/8RC68eelAKrDUbd601tAp7ToGpC3ccDc
         rbXPLkxkdUAcN0/OlSGmZP+VSyZNYDKG+hbIRwHqiCqMqKcLmBLwsRUqjrOp632ivA4T
         LpdPFeCm7YgIOg//1ck3ZxJovVxHK6MFeWlUtpoWWc69PKz5P3j4XReYYXGbZsUgM4Ei
         HrJA==
X-Forwarded-Encrypted: i=1; AKwUvBxiA2KmKLwk3zCh6gAAfA18N8u5W/ThfCh5OfZW0ZIWFhwV0RKq/s58lAQnlIflzGkK0tPshxo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJp73E3+Fp1e+Kgsq5Z88PBuybd+dNOfIOXd2uAyZJQWGGz8dX
	VIMzXKT+R1wJpp4WxrzgvABfcQc3ZqWWst2heYno2jfSfvmo31LEm3D6sqM1gAIndrM=
X-Gm-Gg: AYBFou3NmhGtteH9MmMtv4Ql38Y12WNvWsaCz6/REDh0I1nR1wj/AFmlTH54ydxwxZt
	Gp2/UJ3zPx+Gm7WFK8xNO0oAaMQ5QPnKE7vyFKplQq43FsGzB2N3uuG4DpikW1ivDSwuuesEUB9
	XKdlHQm32oe+lDpstXsUwI6XrIdc0MOafi6q7CDzmFpJ2AnD2GgMByZQivzABOH8ZQNXUdEhVXn
	D6GrgD1GrSanvwN+8l+7ik+tM/Fqqf0vLIhANUaaUqf+tFdt+oVTVxgaNWouziGZG2XXcd/IUxw
	rRL8vxzbldFPNxyYpouzxUzmlMHPcbuc1TqJuLyJeIUijr95/AcOVE0O8D92Za419sTwKNYARPy
	lSJOfkWP5qnVBOvGDqby79PZEtQM+ucMLnvinS1cmPbKB1AFRI0PRsNRlVPfP9ep+9DkPYAgF4Z
	e7pKw72xQMIK1O3aXES46hc8vDeNE63LJOgbKA6nEI3D1mcFLyNZmwTZ+2oCN2/fTkAnOtI6wfy
	aw4r4TI3j8XzOT0pZ2/0zHX0kfSFkp0V6fub+5WsLwG0ijt5esSn4qv8cBohOkNxUGtQtL5umDg
	U61+7cOrmt1IPqJyQkazVHanXb69DCw4m2+6WxMZE7++uQ==
X-Received: by 2002:ac8:5a84:0:b0:53e:35dc:9bd7 with SMTP id d75a77b69052e-542b7cfff77mr195623591cf.61.1793672954512;
        Mon, 02 Nov 2026 18:29:14 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.255])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5498ba831ecsm13704131cf.12.2026.11.02.18.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 18:29:13 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 03 Nov 2026 02:28:41 +0000
Subject: [PATCH net-next v3 15/15] net: update comments that still describe
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
Message-Id: <20261103-b4-skbuff-bug-on-followups-v3-15-54ad0ab57614@toxicpanda.com>
References: <20261103-b4-skbuff-bug-on-followups-v3-0-54ad0ab57614@toxicpanda.com>
In-Reply-To: <20261103-b4-skbuff-bug-on-followups-v3-0-54ad0ab57614@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793672923; l=2967;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=WCTT9uC4bs2258XiDJAzFc52TKyNHZGhkrwOY27WXg4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QE8kdpAIr4r/3KnRyoQejERf3bZuv462xd61M/4SF+RLGK/b0ul1CKeaOQhtpoJOgJfKTHf9Nhb
 J8aQzKvI8igI=
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
index 298ca240104c..7bfafc826b14 100644
--- a/net/core/net_test.c
+++ b/net/core/net_test.c
@@ -1466,7 +1466,7 @@ static void netmem_ref_test_skb_segment(struct kunit *test)
 	/* 5. Linear head_skb (nr_frags=0) + mixed pp_recycle frag_list where
 	 * member A has linear + frag (pp_recycle=1) and tail member B has
 	 * linear len == skb_headlen(A) (pp_recycle=0): keeps SG clone path
-	 * synchronized without hitting BUG_ON(i >= nfrags).
+	 * synchronized without failing the i >= nfrags check.
 	 */
 	head = alloc_skb(64, GFP_KERNEL);
 	list = alloc_skb(64, GFP_KERNEL);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b2c44a58db23..bca69e8b3582 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5639,8 +5639,9 @@ __skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset, int len,
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

