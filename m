Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590442;
	b=gW72gd+mgDCs0f5o7qakOeF9E4iEVPmXx21EkcRrlgBQBZj/xCClKQ9iIEvDdbVWNT8z
	 sPfHLi5T844E52TmtMZOlehIIHJMiLcVLAnt0c33YxP5luo24mOWMOLSVQC8Xy579Z1Jn
	 GQVswGdM8gyLwvpup4SpYEWOXLpiHgffss1WrGmzfTmFxP02sLhaanlo0marWAfNYmp4b
	 tMEJEcOdMGZI2fvXZsetlLWX7oTcvh/vFs0KKXZC8VSSN3eY5kk6brk/8J9mSG2dnp7qk
	 pqU14hOMN4x6Sl0dN2WRvcjQIINMKaOFex+ki8WTgHdwZk1k9r0brEClfKba2k8w3Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590442;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=YbXvQLGgZpsimSrfs+W8d8Jbr4mc/fISMihOBkAlu6E=;
	b=wu/Q4YKjE2Y1p7z7oflgN23dSGyZk4rNcHwxJHqJBte7JpzHXiOOiSpZm9xNojcvVIsR
	 xHeL5J3+LW9NrjojuWpQ430rONYigcJTamemhG8ycIVojcRKORmN0/SNJukrxKnY1B2HP
	 sOqwvof6Z4ODRTodwjlx2u85kxEiz+h+ULy1fd6w8n1XO7rW+x//ZmLx7D/3ChNdhr/Hr
	 m7/c5f/BvBkMccmayqPbrzOpR0FE5XgGLMMmur0wBxqP4JjxigGnsrAVACFFYKCgzUYlq
	 PL5iMCTsCXsqzjI++6K3Ic7fq23BJUSIAfljC4WzR+0BC1W+YEMb3mNax6nTGGFMzcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=nP1k35NF;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F3C60A2604
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0F3C60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=nP1k35NF
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53648215f9dso6083841cf.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792590440; x=1793195240; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YbXvQLGgZpsimSrfs+W8d8Jbr4mc/fISMihOBkAlu6E=;
        b=nP1k35NFaawkKzouM3+/BGOSEqB5dbv3yH5MfvEk8wfy09JySEYZVij9q9X35HBIiq
         fTNwQ5k+XuIQJ+SjJqohpaAVKpDurLHWUf1HCWXKzqsWEIbwJGGe4A2SGt374I6/sG9m
         OZgZ92jvIFtoz7GaX62LUuyl0t9r+PS4IudSoJVqUqapL5ZqxXvo1hCuvPtq0VnwzCEX
         WN5lUYSKF7d3U/dv6lv0oGeNeNxCY9BY5GmatNxSQHvwveFS81jK1TJyadIyMJwnZHPD
         kB14YqnWeXDiRQYVYT3AG+YH8bHG4G48N0wkti5H81tN4YtMt2Mc3npZ2xZf7yupS71C
         Wc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590440; x=1793195240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YbXvQLGgZpsimSrfs+W8d8Jbr4mc/fISMihOBkAlu6E=;
        b=IuXMPQcSewJCbUm8oKHCot7Wg2X+p+QhnJwr44iTK67KZ1RcnN879CTY4DAqobs6Vo
         4NBopcSmGgKdLvdX4NvtdmPp4iZMbAvWURQ+5DuNep2Yl3D4MfdR28/FK8CAudU6BCtK
         UaAtK3S6kK8MlRj0jB4x4Rv86LifxjPqlXYFSeKNmBRTpplLSzDMEeyX+wpC02UfxRVv
         uyjm2UsW49EQ9bFHL4I8GFWeX2oL69Ce37tThsIeAQLYIN4J57QKQKp7GmpLxmwgiigd
         Qas2sm24YucCk6hKue2pwpdBnkdsCiX/dOJQ7OaIPodNRIYeczxPC8w3NiWAmgKY3Btt
         21Uw==
X-Forwarded-Encrypted: i=1; AKwUvBz2lajg8LhPIor73HNKPmeZea1aWTYzEzHXAEHt8NbCJJlcdy9BGRUbg3MqN3b+o7dX97kfMb8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9iKD5RUPFByxv9GAygYb/vOfM+TpL8yO9nWaXZM3rfA23sgz1
	jCkR4AEqQWJ3eT74z2fwuZtFPue42tt6sqbow2LaA/MfTZzK7vXc3Qu1JKWmxc2DAf8=
X-Gm-Gg: AYBFou2vC4o+ylEXnCEHhk7OxIoSPRXDWoQz0SSBMX5eO0e2yoecyer5YAhAXQWjlxx
	gmeaKt88kIdYjMtVX2ukM4TiohHz5j94jgfyP1b16Cy2L7BOiqAmbApS1z38ZdvkVAQ9QFOMk6y
	272/J8MSinuPiT+1yPZKhNZ6ZAMoGmnmQtIy9i+2PuoojlxJio7mhi53PpsTNn0+4KOnoeiB2Rd
	5wE3vq9t9SceZXm4EFE2QD6g7crpUc0xKVuO7kBOqvE+drJFVaRRmI667eleFm7OIbs2aWT7y63
	gjl5APK5PN6jQsS4X7njLlH5fanUHVYJwwe5RLgyCUDWdg4xs/XaTArKnpnwKr+1SRSDEEsOW54
	L5TSWBYezo0qt7FBgEsfiV6a6U8woUODLz98GrRwBXROgS04KyV37ZZ1Dbo/9goG3dNhEAWb+G6
	oqxIqneBdVj9+95msqA0+IoygWqDiYpvohWhlOyQySqzxM60Wz9kt2gJWcKa3iRbNba6vAST1c+
	cu/GfpkZwb7m/NXYkJAc5/2DGok0qCGCfjrI4VNgcrWkvQDtG1rJC/v5L8zR9DFspwx1WCV
X-Received: by 2002:ac8:59c9:0:b0:535:1a91:1d24 with SMTP id d75a77b69052e-5369b7f388fmr31766751cf.43.1792590440431;
        Wed, 21 Oct 2026 06:47:20 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536ab6f1cd7sm99741cf.10.2026.10.21.06.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:47:19 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 13:46:51 +0000
Subject: [PATCH net-next v2 07/15] net: skbuff: let skb_zerocopy() copy a
 short skb without head_frag
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
Message-Id: <20261021-b4-skbuff-bug-on-followups-v2-7-2aa780a03524@toxicpanda.com>
References: <20261021-b4-skbuff-bug-on-followups-v2-0-2aa780a03524@toxicpanda.com>
In-Reply-To: <20261021-b4-skbuff-bug-on-followups-v2-0-2aa780a03524@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792590423; l=3126;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=p1EJ3Mjc5nJGteUiFCelu7Pkg91i/fkjkkkh/ts8Tfs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNjL87kVYWUrnftY9mKgbby2CAWEAfeQsOPkOxYJxwdVe1tb8PkhdyoBdSvFLiY/y+B7u4uFDoJ
 YD3tF1Z8SYAA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Commit 433380f5ab8f ("net: skbuff: don't BUG() on a missing head_frag in
skb_zerocopy()") turned the BUG_ON(!from->head_frag && !hlen) into an
-EFAULT return, but left it ahead of the small-payload path.  That path
copies everything with skb_copy_bits() and never references the head
as a page, so the check doesn't apply to it.

Open vSwitch gets there with an ordinary request.
OVS_PACKET_CMD_EXECUTE allocates the packet with __dev_alloc_skb(...,
GFP_KERNEL), which gives it a kmalloc'd head without head_frag.  A
POP_ETH action on a 14 byte frame leaves it empty, and a USERSPACE
action then queues it with queue_userspace_packet(), which calls
skb_zerocopy(user_skb, skb, 0, 0).  That used to BUG(), and now the
upcall fails and the packet is counted as lost, with a WARN on
CONFIG_DEBUG_NET kernels.  OVS_PACKET_CMD_EXECUTE only needs
CAP_NET_ADMIN in the user namespace that owns the network namespace,
so with the openvswitch module loaded any user can do this from their
own namespace.

Move the check below the small-payload path, so a zero-length copy
succeeds the same way it does for an skb with a head_frag, and document
the -EFAULT case.

Found by the Sashiko AI review of v2 of the series that made the
change.

Fixes: 433380f5ab8f ("net: skbuff: don't BUG() on a missing head_frag in skb_zerocopy()")
Link: https://lore.kernel.org/all/179173804997.434549.4450793967361922984@kernel.org/
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 3b2a3747f009..735dd25213bb 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4014,8 +4014,9 @@ EXPORT_SYMBOL_GPL(skb_zerocopy_headlen);
  *	Return value:
  *	0: everything is OK
  *	-ENOMEM: couldn't orphan frags of @from due to lack of memory
- *	-EFAULT: skb_copy_bits() found some problem with skb geometry, or readable head
- *      payload would be mixed with unreadable frags.
+ *	-EFAULT: skb_copy_bits() found some problem with skb geometry, @from has
+ *	no head_frag and @hlen is 0 while @len doesn't fit in @to's tailroom,
+ *	or readable head payload would be mixed with unreadable frags.
  */
 int
 skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
@@ -4026,15 +4027,18 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
 	struct page *page;
 	unsigned int offset;
 
+	/* dont bother with small payloads */
+	if (len <= skb_tailroom(to))
+		return skb_copy_bits(from, 0, skb_put(to, len), len);
+
+	/* Without a head_frag the head can't be referenced as a page, so the
+	 * caller has to ask for it to be copied.
+	 */
 	if (unlikely(!from->head_frag && !hlen)) {
 		DEBUG_NET_WARN_ON_ONCE(1);
 		return -EFAULT;
 	}
 
-	/* dont bother with small payloads */
-	if (len <= skb_tailroom(to))
-		return skb_copy_bits(from, 0, skb_put(to, len), len);
-
 	if (hlen) {
 		ret = skb_copy_bits(from, 0, skb_put(to, hlen), hlen);
 		if (unlikely(ret))

-- 
2.55.0

