Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672940;
	b=xr1J3uxhNaJ6j+O9EYktWEzb9dzDiybCDfk04CnN4q/C99VSgiIlpst2R6/Yt0tIjPFv
	 1z0Px5np8L2GOVbG7Crus8PIr+1ghPFZfdUMvwFdRUYv6FcLNaihIkMhWILSyqV4k/+KV
	 nX/w6U8VYRQG3gtlU2tLEywugVleo4YCLWZjO5g+Vc+7sgB6MHJdLS9sJ+YB4brQoyoMp
	 N0aR0rnwz5Cy3sK/SMQUd9bx2ih/KRHOzjUzTWYAu/KVs5gere9TxLey2pF5UzDssYNd6
	 CtOqlcdRrRthGvvFkq49NRNHvUGcjI/7AQQtrrrDg6ihOF7iupM0KKQbsu3l9Mixbaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=DcFo5FOvZmv6l4451K3/sYsoJxTuD/ptYd3JpfIB/vc=;
	b=VGsAfh/5XpRYg073/h3kXCbMSu19VuwxeVbhEHRmswgJBSniydFtEbQTe8EuajH2mZ2a
	 fs07LY8DSpURJYMaoscNLhUstaJAse5X1NEvt15NtdsDVg+IKtvmOOHTm8QsglgzMLap2
	 hjXk0X/T2CrneDjKnZ6MbMqUAnRFlgC05NsZWj0XgX7jvU8GVDzd/c8dKit7F8Lk+VM6F
	 L10uzyl669cKK0TaJxu7Zoog1/P71ip8aDSJcdOx8z+snDrZo4T7ttIWTY9kMD0o2rRHs
	 2dg7yfffXwWlZBkNcdDIyP/iXn8vomWLOngFcVxzpQHTnk9qq5xVR5WxJcWu/WpNpjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=KoDaRGmG;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5260C606A331
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 02:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5260C606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=KoDaRGmG
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5364d86f7f0so52091201cf.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 18:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793672939; x=1794277739; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DcFo5FOvZmv6l4451K3/sYsoJxTuD/ptYd3JpfIB/vc=;
        b=KoDaRGmGqAXRWCovGlsC8dW/OOYtwiyttphjiU4s+y9LdxSHpZoZ1rOHuOE81/TGC8
         KcrTXDe6w10nADS7Kbq+EJ7/818UExuxeAEun5/pkpTrJEexj1YeTLhd+xM/jKnCDb4r
         7X4YfuQB9akIzBPeXO5Z5ACXiX8numfKuXnzMOsHNhmXYWrmI0FDSrYYq4QJlgPcFRcQ
         +jq10pcMjyY+ITlWCXIcRj5ebhFbRY/31xBngRxFByAvgNOnpTf+T6zUlTCHDEvXWUF+
         NyTrEjJdzobLaDb7iGT3DXT4sylVVaJdR+T8hK13UJfQkgLc0Hwf/czpHHs+V7wQ5QWv
         NoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793672939; x=1794277739;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DcFo5FOvZmv6l4451K3/sYsoJxTuD/ptYd3JpfIB/vc=;
        b=uPIgu5egvByVx9NaPVAP/ghdrblDfsrJDBlXo9oZmKCdurAirGJPQ8aqwoAKQ/v+0g
         PUQemzX0kwsHldGldaXKn3x3rAmIk6fpEhODTJF3pbqzoyIruyWZ/uU2FTzTz8aq+qPn
         eXYq2bdQmzUGg9c+0ULKGq07N9JldJbDWN85iKddd4v1A2N6JkzaspQUxDVUBskdYUUM
         JylCPYsgyPx19cDhr2EnsTPwLpdox6G7mhX9qvyGzH6T5zW3Jg84O1Q/9F7pOHMLdE4W
         rUEJGJHiyXS/ogHnb1v+ugdwpA2bKR7eci4u71nw7IfMs+foierotCv2+eIY1AGnxagj
         RTvQ==
X-Forwarded-Encrypted: i=1; AKwUvBzdOKS5YrGziw2iLkDByavXU6gcBLs6rJ3nmPsBlibi5A5oLbhMk6XrNgsDGwi3GVeTf62BiCQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Z9xNCGCvVLlyJwATpu7BbaUuuYGeY2gjBuwQyk8yOh0TfynVH
	G38qedRFUT8ERvSRO8CaVqK3BtslwZYd9HgzOKyzm8zu/aVjBP76wvbOZoJpkBHiLdU=
X-Gm-Gg: AYBFou1UejlqDuMBmoXLHJOSRlVWWsxtWGt4apgn4M8uGSXYs+2fjuQc15ehLnLQX3E
	zWdsRIiG7yqUVKW223rMZRxyO2YLIDdWDmweBnpewehYQ672c4eSHAOca1N3fvGVDoNRfCsgnWi
	hxMm7H8W/kLkGZCEMRzR5K7MLQF3E5cmpPkIAPMzn2ZN4kRWcP9pu/8NHFRHCbd4hrq465ruTPB
	Ye+AiC1ztviVC7PNOuyPppTFPilbfhKDt7YqcHy1ciX1kWT16HmYuHbm6pivLNpBeiHw/CldNqy
	B9X0tmVozJM9xkec/zOlvdLMOm6Kuu6o6goTng+dNpyjz+wxOI4/imKl5bTr3tnhv9q8EqPXWth
	H1JckBu8xa2++j+NVdDCUqLQ7+iF6DnVHtw+gXwWbkeSDH9plTYdif8F/fVNeU7M0Ehl0MIJqM5
	MwjMftDZSHzdMb6UZef+N6PruU6lzxlaJf2Jn3/oZHtUNHnxUm9jBK0Lgv1F2mEM02HbM7Nn10Y
	WgojQQF2fwEZ1o+zHjA7eXdnT1ZQWbTvOlNXC8bLfYp5rojqKdDWCRBoWELhYt/3gjSrGHvksmb
	l+eTFrPwRkvNN55BI6EVRiIu7+4fpOPXoY+MQF/Vqw1kug==
X-Received: by 2002:ac8:5f8c:0:b0:535:15a9:2516 with SMTP id d75a77b69052e-542b75248e1mr201824771cf.53.1793672939316;
        Mon, 02 Nov 2026 18:28:59 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.245])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5498cf4c174sm13684401cf.29.2026.11.02.18.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 18:28:58 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 03 Nov 2026 02:28:33 +0000
Subject: [PATCH net-next v3 07/15] net: skbuff: let skb_zerocopy() copy a
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
Message-Id: <20261103-b4-skbuff-bug-on-followups-v3-7-54ad0ab57614@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793672922; l=3270;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=h0Wqrzd3xqr+PYqL1pPzooJBchVLWNZbZHd25h+Yqck=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QM+Y4diaiiBY8eankmF9aAo6/WhJsaCKYztAziuHXrT++wyED3G5cAIsbBu9yfcjJg9jVGYbpO6
 rhMjmGXTK1wY=
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
index 15d1f4142f29..d79d8463c44e 100644
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

