Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B19633F8AD
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 02:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792030676; cv=none; b=INPZ2EZp69Yrk1YxHsRn2M6VuNkIMRU0/TaFszHg7y6pEychJRWGC1Yr45uqAxT/U7T+L8HQi/PdKuliN4pfBXdkcw0UOMYiH0oQR+bSuAQLZ1ymYMVx5rXOf9MyWpCozFJi60vP+kbZe5wIFXLL9fa1ylwViuLO+JwkPrOwDTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792030676; c=relaxed/simple;
	bh=X+HCnHGvBi9HWjAtNmtWvZ3H76ZTR8nEk/L20woDDe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YOak/S6YOfI010ZstcfL+gPsZqf5jPDYiF6G7SMkI2d87IpOhMrxO+CM+vJKmfMi5fbMYQNexjmZLP9PV5KYqYYvG4bG+Wt0tB5XFSwdQP4/X2uG11AhCkInnO49pL6MVTtbfoIEjQRChLiOlnVMzPn+Xd1GdAbdok5SsX7RGWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eekHr2dh; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eekHr2dh"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso2272406a12.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 19:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792030674; x=1792635474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Uj6IejyI7gw3UH5oRZnmPQkBvUb0bume0nMVbdbeS4=;
        b=eekHr2dhBWSJ7GtQoWJ7SSZN8CXVsoMeHmq2yQHpVxsJWCuQvKnLM89xa7skwgy+lE
         4IHndRB+Rt/wrHnXBG4i9O0v14umx61SjQx2F9MA3FygP27zkBJwhktHQ4/qNolR7Ief
         e1WSrDoI7KBVEY3mZ3/BKd45VsWxaYzrynYco+QuiH1Hx3b0e11joegM1yjz+F11IBay
         Fyt82VRSpdxyexg1T4LC7QHa94+EXmFjbxsoHAN0WYArfHsV98ZM3yipGM4LaBLyEVS7
         +Wibxt/17d9TikBguoqiWZDKBtQdBk27ezvhLR98E0OyKpQCmKS+CL3jyCEZ5y80DD2Y
         Tvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792030674; x=1792635474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Uj6IejyI7gw3UH5oRZnmPQkBvUb0bume0nMVbdbeS4=;
        b=Uu76Km5hVfvsWEjiQ8gvuUHL1P7yWrli+lg8NzZVBmGooJceTGn4ONXru/LzaJarcM
         Lz5qOfZz3st+07+wqCKt4hxUzQ60KTh7aHdvvcRK2FWoh3i2zISgIcCfuNBUWqDWPdd+
         4+elL8WeweIiGrswVTmVGkwXC2k9kPITWZx8rQkyfootPANErmbd9ZwtPWrSVBvo8KwB
         bq77nlZRJkZSiivRT/gfsySgKsGJX2Ef15+PiJQ4riYDeIzk6o808S52grIjaI5er3w0
         4Ux1+JBwjTx4qq4+r0kbv/f+hvHur03Eq+NmOym6gspm2eN7oglZ4O8/nX2ADonlZvvx
         sS4w==
X-Forwarded-Encrypted: i=1; AKwUvByjM4Dnc1lufnea+41oHJ8hLzT8REAMlrXA0THi1OXYS/XtqIQy4o+yx2fNgtXUechFVXDhgaU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLglMhEurqrAdJkf4gwSYKdIb10dMeWvPssjeQqBJHEM6ouzw3k
	czZ1bVKhIKRAWnyBDp67jdt/W2vgCUsW8NXWS0FX97/PE+nzUmir8pmX
X-Gm-Gg: AYBFou1LYPZQsxoRgMXUnZ0bX1LiyncGOvVwqZ/lABGHoIq8zMQXFUKPZtc+jI3sdLk
	MoraiXqbgaVt8lYrha5+zDWXqBML0aqoxFQAaK01qEQvGMB8a5EXRs9Uz7HBxyNe40brxDDvM6n
	KMIbYwpIQqOr+XsbgCgH6vUtv+uPvUoUIp2Kus+n646NmObaw1QVT2GjgqOOQMcmiYAOlTkJ0CI
	yrVyc44J8W7JFWpGkefDKfM9f/ZmPoxniPTh3NL71yyjKHqY48E8qDV00/TyrkHZTAfiMsiDoeL
	CX98M4XRGt63o6CCiuLTZHZCgD6+UGWi/BYaGjidRQFtRAVtXBeZDTD1Op2KziaxTEeUjcdMHeF
	tZ1O/RoVyfzcA/tjsZaWljA8FjfEtovGWJh3ra6FmjSSYOrunsjGWd5hfnxVuWfGRg4O47yLvXK
	9x0mQwbf3jbLs8KTezXQkyBoWKtlfdpnnwxqOMqSNcFBwQMP7e14ne9/lSNiXJ2C6CGaL/ozD7z
	MR4+sM56mEyyyUogXvQ2BDAPMyRKsWdoE42eqD+e/tXBg==
X-Received: by 2002:a17:90b:268f:b0:3a8:59d3:5317 with SMTP id 98e67ed59e1d1-3ab3a778a55mr15692854a91.32.1792030673922;
        Wed, 14 Oct 2026 19:17:53 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94798212sm1881727a91.14.2026.10.14.19.17.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 19:17:53 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	chopps@labn.net,
	netdev@vger.kernel.org,
	Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>
Subject: [PATCH net] xfrm: iptfs: do not seek the sequential skb reader backwards
Date: Thu, 15 Oct 2026 10:17:31 +0800
Message-ID: <20261015021747.30346-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Yang <junvyyang@tencent.com>

iptfs_reassem_cont() completes a saved runt by reading the missing bytes
at payload offset "data", and then reads from that same offset again to
fill the inner IP header, deliberately re-copying them.

skb_seq_read() is forward-only. Once a read has stepped past the current
segment of a non-linear skb, st->stepped_offset is larger than the offset
of the re-read, and

	*data = st->cur_skb->data + (abs_offset - st->stepped_offset);

underflows in unsigned arithmetic. The companion return value
"block_limit - abs_offset" stays large and positive, so
skb_copy_seq_read() memcpy()s up to iphlen - runtlen bytes from about
4GiB past the skb data.

  BUG: unable to handle page fault for address: ffffed1025327a04
  Oops: 0000 [#1] SMP KASAN
  RIP: 0010:kasan_check_range+0x1bd/0x220
  Call Trace:
   __asan_memcpy+0x23/0x60
   skb_copy_seq_read+0x13a/0x150
   iptfs_reassem_cont+0x363/0x1780
   iptfs_input_ordered+0x673/0x880
   iptfs_input+0x5f7/0xed0
   xfrm_input+0x332b/0x7960
   xfrm4_esp_rcv+0xb3/0x290
   ip_local_deliver+0x1c3/0x600

The sibling parser __input_process_payload() already restarts the walk
when the reader has stepped; do the same after the runt fill. While here,
pass 0 rather than "data" as the new lower bound in that sibling, since
every caller keeps handing skb_copy_seq_read() absolute payload offsets
and skb_seq_read() adds lower_offset to them.

Fixes: 075694765446 ("xfrm: iptfs: handle received fragmented inner packets")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:hy4-preview
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
A KASAN reproducer for this issue is available if requested.

 net/xfrm/xfrm_iptfs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 597aedeac26e..c614f3483f78 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -845,6 +845,12 @@ static u32 iptfs_reassem_cont(struct xfrm_iptfs_data *xtfs, u64 seq,
 		 */
 		memcpy(skb_put(newskb, runtlen), xtfs->ra_runt,
 		       sizeof(xtfs->ra_runt));
+
+		/* The re-read below cannot back up a stepped seq read. */
+		if (unlikely(st->stepped_offset)) {
+			skb_abort_seq_read(st);
+			skb_prepare_seq_read(skb, 0, skb->len, st);
+		}
 	}
 
 	/* Continue reassembling the packet */
@@ -1038,7 +1044,7 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 			struct sk_buff *save = skbseq->root_skb;
 
 			skb_abort_seq_read(skbseq);
-			skb_prepare_seq_read(save, data, tail, skbseq);
+			skb_prepare_seq_read(save, 0, tail, skbseq);
 		}
 
 		if (first_skb) {
-- 
2.55.0

