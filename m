Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825279;
	b=uycMMrEqlsM2Zz5LHVSfmYJVqDVJsNPQl8Z3/UTTeskMdCI4NtSk2iNpneAM+deHnYWY
	 HWEndwEkXjkakXL7g8tpJcyJY5nPhZwbgC08AALbGI+wLaTikpuCS5A8qXbqXG5tRBSen
	 99NjhXNCv4BjWD0fCR84SUTf0P34xGqOeKDE4PlsbCkzMDFKeO29PMwnBd1tJD0CnJiGM
	 WdkT7UJ0A/w0xLZsfopYstRZ+rXVTWJ9olqGkE86gy9TAnwehYsZugJNj6/uO/hVhhy/8
	 soqowIqt4nKiPc14rdyG2b/BYiBicK4lhK7b9snjW71TLb9I/IdDAUQAXoOx/fjpKMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=umuQbJBZ+T+/ul5GPlAUT8hdRrJpMBpkwqdC6QE4K5Q=;
	b=DQ+riVWgeZDb0fWeSOF/vU9yQhHQd6T5Fy1v/kJT4XxuXcHyzeI+bAbOkkbC3Q+mDpLE
	 shGxhlNcTWf/OJ+C623hWYa+FgZaPGzh8SGMuwskycl58YsLcopAko0Sdhsf89YkT/Kz9
	 O4Rx4XCzbfW3n8Y727P7peQTnvS+1UaE6vAl2rYQt3W59/TinVMxh/sq0iRXOHgyYE0Iw
	 Zp1tP19UDLL5gVQDpO2AHXu+02y6IuLSn+noEqP+qEprlocfGxtzccYR1qcnjWNyQ7M3/
	 6TwkKLwvnYhUqfa/e4WZDCpoVztH2+83lze6sEl/WeVU+F2sVQSBK1B7pQu02Ho9lDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=cNm8m8+c;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5139A6097316
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 20:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5139A6097316
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=cNm8m8+c
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91e929178a6so91906d6.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 12:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793825278; x=1794430078; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=umuQbJBZ+T+/ul5GPlAUT8hdRrJpMBpkwqdC6QE4K5Q=;
        b=cNm8m8+cGy4FXwmnVZg3IF4Zr8h74sfoLqcPvkeub/3B4cygSQevknvdDWotpVElO8
         2WuI8yhcfOCdJWF0ZW7K1qV49od+Tjsw6BVsqv3GQb1OLJhFmymxEm2Ul07F/kxePws+
         rttSrKYF+OOwm70a7GO0JDIauDUtaoBIMwb29FYQDOeCsHnK/V2/79kB0z/dGLVxJJxC
         7M0iySiCnUVCP8/mjWtKCcwv368DeQSyct5SDnHIOIlZxikPm4etdzcPx7nwcYJRaReD
         i9FKEXAfM/FZ9Vg2p869nWBnehpWopnx43KewNfzjtcmRP1M/h1vEzBF4oMJy08zCSOl
         NGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825278; x=1794430078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=umuQbJBZ+T+/ul5GPlAUT8hdRrJpMBpkwqdC6QE4K5Q=;
        b=mBlG+r/pjYdmppY2MoTxu4UVlsSumJHgPRmQc9SIrG/QdcEaqbXivrAxN1rVWdzfrj
         GeRZXFcyvuKGxMNKL4Nv973kDdsuPYN7X/mM8sHnOx3gVz1O1ovS6B1Ra9+hliPluw8H
         Cdg7pvduWBy8o5M5Fm0ttM6YlnqbU67CTKul0vkBrZpIkYcBCZt+Yis2Cl2Ea9yur7PJ
         OPn2VOFH9IvTsQXHfkFbqQV+9U4n9O2MN3n6wJssiqZhiBwSBj0XCWPBjZSmpH9XcT+B
         7emVv7QrFbPxe7HHzlggY6AEPFf8niRVd0tuKE1w6N/hzMm9zfYbFieIKAQ9nEtt3F4I
         tJvg==
X-Forwarded-Encrypted: i=1; AKwUvBwd41Fp0J4BFH0pex90igKmRPbpf0JEl1pGHUeqOY/+RFJTtFoLPfYiffbErRIpzH8QUVmjlzc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8I6zL1J8dbc01rAHHjyyMhHbWqEEWowlHfG4Jet68y2WFBS73B
	D9iS8TyWtFty4gf7wbYnM5pg92H3dwJXJ1ggfE89JEpZo4gx5ntUUVO2wG1KFRrFr+Q=
X-Gm-Gg: AYBFou2wUvXPDo0xIeYgG/jIdWxmkg5ZnOR23OiChD/0ieqea4POd+8BT/T4r4zQkKR
	eTBBy7J2dq2POYX2nVAsAPLdw4KCCqVR5b63QFnjg141lkXZ5WPFBtW2LEQRtt3TJ4JsSXshMe3
	zvLbvDErCe3Vms5l+KZSOtA2Mxa48ZhBxJynm/cDFVhpIVgGsDcV3EZ6gcjZe7xomI0SDyW9ANq
	YoTbF9yxgPiy7oQgjLbPzazpcqgwKAjtlUqRfcffQfpM8i0EWXj6Quw2mzFnWF2nmHSIastVaKr
	xUJztzrsfGCClnn0r2ByCmjdVKXmGQcxb6NTb8WUzMmOOaAkSKitnrnv/0gNKA4B0Fdi8E4jIkH
	HQtZfCX7XZXC+RkjB0v9unPBJ546kDl5bynbu4yWhAbEZTFs3tqc72KeivJ4wTkYN+AkO1MT28U
	6oL56Gqobuk2dwZQ7EuwUDRMWWhFoJLaycICHn6joAsojSlUQitcknt6AwmR0wDaFbul0n4Y1sR
	nz5xFxUy+NgnkhJdJh5oSimKJ7nPJZV55wwYiM4YQ2rwMNMfbG3m3z/txvuMqePNnSfFQsLMHFt
	3RDp6wKXZVoxU42bRBMcGlI4ZqBlI5hrc6jauMCkbuQ8sg==
X-Received: by 2002:a05:6214:62b:b0:914:3120:b7c3 with SMTP id 6a1803df08f44-91e942fb275mr13978456d6.7.1793825278319;
        Wed, 04 Nov 2026 12:47:58 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7e008399sm28523796d6.23.2026.11.04.12.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:47:57 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 20:47:19 +0000
Subject: [PATCH net-next v4 07/15] net: skbuff: let skb_zerocopy() copy a
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
Message-Id: <20261104-b4-skbuff-bug-on-followups-v4-7-b7ffeb364f5d@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793825269; l=3270;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=313gSpe/OEgGmNrXVMk6Bxzm48vCKWeKxx/RzkLjq2I=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHgvwpS66JnChP5h4nxV7iE4T6sQFYhC59dUOgap4jvS9EDZJ7F4fJ80RgGphM7ipwgq23QtCp8
 fwTiLMJkDtAI=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_zerocopy() refuses an skb with no head_frag when the caller passes
hlen == 0, because it can't reference such a head as a page.  That check
sits ahead of the small-payload path, which copies everything with
skb_copy_bits() and never references the head.

Open vSwitch gets there with an ordinary request.
OVS_PACKET_CMD_EXECUTE allocates the packet with a kmalloc'd head, a
POP_ETH action on a 14 byte frame leaves it empty, and a USERSPACE
action calls skb_zerocopy(user_skb, skb, 0, 0).  The upcall fails, with
a WARN on CONFIG_DEBUG_NET kernels.  Before
commit 433380f5ab8f ("net: skbuff: don't BUG() on a missing head_frag in
skb_zerocopy()") it hit a BUG().  The request only needs CAP_NET_ADMIN
in the user namespace that owns the network namespace.

Move the check below the small-payload path and document the -EFAULT
case.  A genetlink reproducer run as an unprivileged user in its own
namespaces warns before this patch and doesn't after it.

The small-payload path hands @len to skb_put(), which panics on a
negative value, and nothing runs ahead of it now.  Reject a negative
@len or @hlen on entry with -EINVAL.  Neither caller passes one.

Found by the Sashiko AI review of the BUG_ON() series.

Fixes: 433380f5ab8f ("net: skbuff: don't BUG() on a missing head_frag in skb_zerocopy()")
Fixes: af2806f8f90a ("net: Export skb_zerocopy() to zerocopy from one skb to another")
Link: https://lore.kernel.org/all/179173804997.434549.4450793967361922984@kernel.org/
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 96c8835a262b..fd4689cea94b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4072,8 +4072,10 @@ EXPORT_SYMBOL_GPL(skb_zerocopy_headlen);
  *	Return value:
  *	0: everything is OK
  *	-ENOMEM: couldn't orphan frags of @from due to lack of memory
- *	-EFAULT: skb_copy_bits() found some problem with skb geometry, or readable head
- *      payload would be mixed with unreadable frags.
+ *	-EFAULT: skb_copy_bits() found some problem with skb geometry, @from has
+ *	no head_frag and @hlen is 0 while @len doesn't fit in @to's tailroom,
+ *	or readable head payload would be mixed with unreadable frags.
+ *	-EINVAL: @len or @hlen is negative
  */
 int
 skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
@@ -4084,15 +4086,23 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
 	struct page *page;
 	unsigned int offset;
 
-	if (unlikely(!from->head_frag && !hlen)) {
+	if (unlikely(len < 0 || hlen < 0)) {
 		DEBUG_NET_WARN_ON_ONCE(1);
-		return -EFAULT;
+		return -EINVAL;
 	}
 
 	/* dont bother with small payloads */
 	if (len <= skb_tailroom(to))
 		return skb_copy_bits(from, 0, skb_put(to, len), len);
 
+	/* Without a head_frag the head can't be referenced as a page, so the
+	 * caller has to ask for it to be copied.
+	 */
+	if (unlikely(!from->head_frag && !hlen)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -EFAULT;
+	}
+
 	to->pp_recycle = from->pp_recycle;
 	if (hlen) {
 		ret = skb_copy_bits(from, 0, skb_put(to, hlen), hlen);

-- 
2.55.0

