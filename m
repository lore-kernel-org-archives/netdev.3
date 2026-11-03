Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672944;
	b=F8xT+7DQHOcHNhgZLGzjgSc5xDziqgHosmnj74HjA0eeoDMliQU7BzRB9D+r5c8yz1X1
	 6HERWP4EuQp4IGLz4LFlsen9/t7mgEFUT4qAlR/aIzsaai27ANtST4spT+DW6l5a8459h
	 AYjidaNcRoNKc3bIM02mxzrnMqPX5r0QE3XcO7F83vmpj3v5Shr6S00qE5Va9yoaNMZSI
	 VlU5RAmGtDDw94KKm320KzEeH8uU/574vTY6Jlu0SFF4X1bb0VWddaQNTfBFtObuIPgZ0
	 08xT2vnPmTagdlyFRTuaBh2ukqaFSyWGaPdABqLALlkHiEQ9a8K85oM3OtltXQ3rk4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672944;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=YMQaM+kfeGbudokxSYshH02k0TvoZ+jUfxqiHHa4FNU=;
	b=fpY9m9sQJIHrgApw9VB1UVA9pUpTDM2krG+XWc0LJ9f9bEF71UoOlT85vbLQq2h/ljRi
	 nIwDo6sy/Qumu8V9bzt0dg/3PgbAKgBHZApXxEVh4VOAOjVIoiJyiI9zGzoiXgsM4TFd4
	 XZdNqJ6aumtq2sQ+IvnWpnRJPOANnGhRVfWRVaCp94za/Km/Frm5FNW9fFnnJ4qE+R1Kr
	 zA7AXw2pxdYzk2t4YYnXaoWARFSAz6JGGm9tX4g+6c3Vm/ZvyxqA6Fd3XCT5H8+GcK/Wq
	 mC2Chq/PYk4ZgugG44K/MM8dEfu2ZYH34K28Y34v9Ov9aK7IB76K9r5GgtzD6TIsMMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=fP0mr200;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF5E606A331
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 02:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEF5E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=fP0mr200
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-537548b811aso30168391cf.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 18:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793672943; x=1794277743; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YMQaM+kfeGbudokxSYshH02k0TvoZ+jUfxqiHHa4FNU=;
        b=fP0mr200XLSqOCjq6o4UFrkE51YVgECkB6hqYxwn+jhwl8F/bSru/16G5/oh4RmpOQ
         HoBbRhzRsSeyWjFQh+2g04AqkwmVZkHTPSsYaY4fsyd/1nZmUEi3ye4ILp3Pym0bqzVb
         17ZletF17tydWT4H9f6PvzFCPdl/3fBvmEK3yom8Ko5aImT3aPHbdtJ4cuDqAw4eJbrM
         FIZqZ3+b3+xUDu8WXCB5yRfjN4OWN4+Gnd9CQRbdTe9YU+LorhTSrizr7I+XUNe/h6IV
         Ck+u2EvNFMVBJFr4Zjq7HqE6uTcrKPqYQOixupV5MoNLs25fKPEfDdgWUtqylvTjmkuJ
         3aMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793672943; x=1794277743;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YMQaM+kfeGbudokxSYshH02k0TvoZ+jUfxqiHHa4FNU=;
        b=Zx+Ma8Ii3MYmqmYC/7f8xqOMT9tLQMDDz1DG7FVwb4fjUCxehKVt9BTbuxjdGHwbVF
         3ADHIWCx//0oV7FoPPJH8xGZdllIsYy9mNmHTkSPsVfqDAE6jovvhz1UPqdxfi7+5iuk
         NBRkwWOfRWZ2ffvIkGZl80rullK/Ojufp7mbLPwzennSyzZcOq82F1bdHXB2MWDZcWIt
         dUsBhtyHk21Ph7+1hJKwuN8v4ezU6ET1Z71tn0qRN6CJb0AKUmb5gxvAZjsZL4PiEq/o
         jE4Wmin07Moz7rFUSpSr70Ek6H2q6ZFOWVr8XUbTCY8aOVJugcYg845SJHxnKJqfytHE
         WkqQ==
X-Forwarded-Encrypted: i=1; AKwUvByrNF5glUa5egb9qzhu7QijE0gRT2OFmT+foUJ3jQqgRVN+ItMsPapmiiNf7CZBJvtu0jj2jck=@vger.kernel.org
X-Gm-Message-State: APuU4Z9kDNtfIfZDKjEc3Ood253Msgyry3BmGIGspNFqjrC/Uf25JoIn
	f7W9IGjoJOP/qKB+4lFqpVge5LAIUU477+5BhLVilbXILtjZq0JrpclZexdJs5oo63Q=
X-Gm-Gg: AYBFou0Wj/DLR1cswj3maXteEdkvGl162L87vH911HU2HvmjVhM97SJdqRQv6iHN15u
	SCBIH+wISqrmj6DxPZ7Qz2eOU2GXgjFW5/oFOZSXZ6IyPMIt/Hi0CzfebEVRUXN2h9YgIMVAyQZ
	N54OWxNPXzwxQ1lCUkduurfBzLMWt3xUXDVqmm55khaUYb8iNid4KIfvWxSHkpC96esPi2evx9z
	1Dktu+dVLbL8rLGjAd0XwgA6ZdSmJWqtYrQqRWjYbvgdPOzCVzFfRxkCO1jr4O3+wE015Pf8w/U
	dM4us0m7zXRQcRgDYCHWWHq8dTzyywILyfFTT1hrLZeSzb5JguB1eyFiBlrn7cqTFvNyzTinven
	asOMG0mt087i9iU2kP1q726kZ9iTxRJrT8ppplT9x8dfcnp9LjhnD4kpKFGKw68ZDnt3dv16176
	8HEq9ndQYnm1EUJtpJ3TEmKkv8mv8ZJXZc0ZViCz5YGql/84o1jNyT+JWx0wNYVTI8HJ2gF+A5r
	W4f9ATr+TYssUpDVmiYTqwxlCWGg1jVXxmXkF5eTiW0IZGM71oxzxh0t/PW51S6G6+ijrD488wI
	DkZlk6x7XuBSwi1fR+Dksy24VOusOZjlOQqneH6bEQtrQag=
X-Received: by 2002:a05:622a:1c17:b0:536:622d:6932 with SMTP id d75a77b69052e-542b62a4588mr193626811cf.23.1793672942811;
        Mon, 02 Nov 2026 18:29:02 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-549893ec3e3sm14050831cf.3.2026.11.02.18.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 18:29:02 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 03 Nov 2026 02:28:35 +0000
Subject: [PATCH net-next v3 09/15] net: skbuff: reject data_len > len in
 copy_and_csum_dev
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
Message-Id: <20261103-b4-skbuff-bug-on-followups-v3-9-54ad0ab57614@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793672923; l=1669;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=BXekQ+0ZZcw4R6M9C7rnaESTyK2ZJqIQSa++cyygjWo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNn8OCjsMCbSYh7N8mCbl9Otj5ltaFziZ7io28rIRlQmVoNauFULhcxK6cWv8CNZSqiLp0sSE2u
 sJ/9L7jVi1w4=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_headlen() is len - data_len in unsigned arithmetic, so it underflows
to about 4GB for an skb whose data_len is bigger than its len.
skb_copy_and_csum_dev() compares the checksum start against
skb_headlen(), so its checks don't catch such an skb:

 - Without CHECKSUM_PARTIAL the checksum start is skb_headlen() itself.
   On 64-bit the 4GB value becomes the length of the linear copy.
 - With CHECKSUM_PARTIAL any checksum start below len passes, whatever
   the linear area really holds.

The BUG_ON() that commit 56453199d28f ("net: skbuff: don't BUG() on a
bad csum_start in skb_copy_and_csum_dev()") replaced compared against
the same value, so this isn't new.  No path is known to build such an
skb.

Check for data_len > len before anything uses skb_headlen(), and zero
the frame.

Link: https://lore.kernel.org/all/179273112823.3134.12241973533522574538@kernel.org/
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index e400990595f8..b74d8a6ef0f9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4165,6 +4165,15 @@ void skb_copy_and_csum_dev(const struct sk_buff *skb, u8 *to)
 	__wsum csum;
 	long csstart;
 
+	/* skb_headlen() underflows if data_len is bigger than len, and then
+	 * the checks below don't bound the copy from the linear area.
+	 */
+	if (unlikely(skb->data_len > skb->len)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		memset(to, 0, skb->len);
+		return;
+	}
+
 	if (skb->ip_summed == CHECKSUM_PARTIAL)
 		csstart = skb_checksum_start_offset(skb);
 	else

-- 
2.55.0

