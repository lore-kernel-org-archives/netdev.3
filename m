Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672937;
	b=RWqgripn0XyLx47cC1zaJnIofmTKDoVgnnbyAqcZt0vL3Gy4SQOWOim+EaL7EdpxbQlC
	 FlcoyyMZJU2WjrLxuNUfxrQGKPVBJSsxYhITNVrAVUmLapxAbLVgnSDf+5a+jt6XEVo3Z
	 qFhxh5MBZ887MqAkxkdh9NkqpiMte3xWh7FyrBNI+ziMNo2quSIVq7HiN51lqdQRcsrHV
	 T9lVd/Mu4LWYy9LK5sY94U82AmKRjf5e90afkrZKKu7dW0gXM8NVqF7EvVhE3LgxfIG7x
	 eKW4ID5lAJT9tecvOWRL2/MZL7ovrBFfHaq13dRIOpepZgCq8j5bLCbjPsoazcMgVbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672937;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=sPhoPgLC+8GlCU41+5ydGuziU72t8bYzLKeHnMqsGwE=;
	b=TwMc+q3KK6ycgnfn8J8+rN9/ujFk8gaPtzx4lJ7NRz+X+ku/Y1wgsXEoDcmV3q8xXhfd
	 ULCodU+FdjlzHV2Ve56aW9DVdBkvEivPJjVposAp0A/5vqLB/hwlZi8r/se12nbyKnGGW
	 KoianDRg06TRcR10J0YxQA0xIOxyhWZaPkMcDa/xzCUQChzK0AwLUYkT9170FBtsUX1wr
	 4DLcUycxUUWgQYDkvFYCbmApsD5kVzpD2bTAvZt4WqJqdJOWGKU7oqYewpQHkTO2r5jjK
	 SRgkVn5CYLLB7/td0R/JjHNciFm00tc5H9pFClxcLGw65tzVaNIHfSX2g/3NrfaQIYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=G4+ranUY;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C33606A329
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 02:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95C33606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=G4+ranUY
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91b89c6caffso28702306d6.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 18:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793672935; x=1794277735; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sPhoPgLC+8GlCU41+5ydGuziU72t8bYzLKeHnMqsGwE=;
        b=G4+ranUYQl5gGGhTBX13GLNcQhZb51KGZXrbBaG5L7cgQnTZePvVysA5c+LFHky07t
         dEhlE4cwohfiYarKjWiOCeFEB8IAMpxium9b5ToHvTGvXiopHahLEN5cfCnXoQqvp9/M
         Lkv3XJVbS65XHGbchA5gJDiM3sQVjRUTy3mIPBTvajxWmCvx4PwBED5KbeDgpKOOAEpE
         ZpJIyb1p8P/VyPw6KczBmWvDNoQlLZYn1SiVsC+bNCEyc8KIbKtclRISzh+vNEkaARgi
         3D5PBXW+r3jta/Z9aIwIxKFq5cqOWEuVrgUMYRpTKcCOS2yc5g5y7ZbtwMN8bufw+Mn9
         VS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793672935; x=1794277735;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sPhoPgLC+8GlCU41+5ydGuziU72t8bYzLKeHnMqsGwE=;
        b=GpbIcESVBDB3sXdMQbIAMntL6u0HIZAMVYvPlt2kjJ+Tsu9OXsr++yp33dyCx8KXer
         uxYX05rbeU43VQKgdpDmj7ilN5yU323WriMyrCZH/fJrwAXhqQ/EM1p7drpkk7I9B2ik
         gItVpN4XMvCzKDP5/aFVicfDwajK3r3WAKuqtX97k17dTAt5wBTkGkGUpGleB+NmoFiA
         jUzuyrGv0BnkMV+s8nRio/QAToUpZxuplQ/Zmd7gpSY/6G4iXeVcO/wDZtKsAkGq/aLo
         GNbcHnddE1ab+L9/k0LgarvgCmLfG3rW7oC0oTqpxsGE5muD8nTcNtLPHDvgaM1wmVa8
         AQzw==
X-Forwarded-Encrypted: i=1; AKwUvByA4i5WOVbfHtAUMAl8AjIABs2BoipjlcP7bbkW4Bs3lU/zHUZJTUqpOp1HIRW5RWqC+w+GYpQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8GgdVisG/RbuNYOdNOZ6FRAu2L94oEbBVAevwFnX6L/ORPrmam
	wtjrtjM/W3fOl78REAfdnzWZPOS7BabUW4iCGWD4Ck6xGjwhoxOn7WMfVmsCvT529vk=
X-Gm-Gg: AYBFou07ryUDoeTj9Wh7jSiJKRWiYem58nW39NAhYoi9Tp2T0gz0FL5tMjrrRlg17p2
	H4c5z0Hwyx8QUZlh08HwXXsHB2ZvSzvI62szEV/JN8pklqprpQ+VX0o7mknkeolnYCu+SlRqAPV
	0BqlsZwSLQwQmX0NZ5QuESeCGkVkP9qQEsX8+yYCDZflmF1TOP31ZRhMjTsPp0SCuKKmvS1bUpL
	IunwUBfEQBTLuS3y9YCK795EtiGs1sjvMN8xIEU1Nj4ZeKSvK3BzO8yWySPzvIEYVWVtYCP7SEQ
	Muk5PM7qEOo/YJoTXXwrp5morIQdTvrzbCS19omUzBzIIPthJ+nqUEoRJqhEpw5nVIDITSHYu41
	ACsJqRiHRMbHSlauoBGKuyrshrUfs2QqBZC7hCP4Ci48wlmx81X9ws93gSScCTAHehJTb0lrbZt
	YLhw230OY59g64YTmP0UjV8bSfpTFx8SuMm+Ty3zBoYXh5GBEqJA4+gb6Hbnm3RkenpJcgeYCr/
	MhaCRVwLlZAA4Oe4mB5kS9qNx4PWE0kEYFj1HBynpGF0RYye5EdNCPOjDaO3RjMhQmaWoFvMcTa
	f5BGZ2MNszkjiGyMQK4wUsWmRN/nmkkNEpfD1V45HV+0sg==
X-Received: by 2002:ad4:4ead:0:b0:912:517b:7bdf with SMTP id 6a1803df08f44-91ca4b92850mr197093996d6.42.1793672935525;
        Mon, 02 Nov 2026 18:28:55 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.245])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7b779bdsm105433276d6.0.2026.11.02.18.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 18:28:55 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 03 Nov 2026 02:28:31 +0000
Subject: [PATCH net-next v3 05/15] net: skbuff: drop hw csum if trim can't
 checksum tail
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
Message-Id: <20261103-b4-skbuff-bug-on-followups-v3-5-54ad0ab57614@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793672922; l=2083;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=WIgfTZtqwaWkzQDUXyCO+jFusNbjYdApARwauRRfo24=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKW99vHsClamyUP4X27NpnKqyTYOkfRWB4KW7NXTD/O0D66lYe+SBZBVME9SfN/NW1ccijRiLzr
 0OXJ6VI31mQw=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

For a CHECKSUM_COMPLETE skb, pskb_trim_rcsum() subtracts the checksum of
the trimmed bytes from skb->csum.  It gets that checksum from
skb_checksum(), which returns 0 if the trimmed range runs into an
unreadable frag_list member or past the end of the skb.  skb->csum then
still covers the trimmed bytes.

commit 2e357f002c61 ("net: Avoid checksumming unreadable skb tail on
trim") handles an skb that is itself unreadable, but not a readable head
with an unreadable frag_list member.

Use skb_checksum_full().  When it fails, do what pskb_trim_rcsum()
already does for an unreadable skb.  Set CHECKSUM_NONE if the remaining
packet can be read, so that software checksums it, and fail the trim
with -EFAULT if it can't.

The stale skb->csum was only reproduced with a hand-built skb in a test
module.

Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
Fixes: 20ddd0fd2fcd ("net: skbuff: don't BUG() on leftover length in skb_checksum() and friends")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 5f997edf3519..68801a4f471b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2821,9 +2821,23 @@ static int pskb_trim_rcsum_complete(struct sk_buff *skb, unsigned int len)
 	int delta = skb->len - len;
 
 	if (skb_frags_readable(skb)) {
-		skb->csum = csum_block_sub(skb->csum,
-					   skb_checksum(skb, len, delta, 0),
-					   len);
+		__wsum csum = 0;
+		int err;
+
+		if (!skb_checksum_full(skb, len, delta, &csum)) {
+			skb->csum = csum_block_sub(skb->csum, csum, len);
+			return 0;
+		}
+
+		/* The trimmed bytes can't be checksummed, so skb->csum can't
+		 * be adjusted.  Software can checksum the remaining packet
+		 * after trimming, as long as it can read it.
+		 */
+		csum = 0;
+		err = skb_checksum_full(skb, 0, len, &csum);
+		if (err)
+			return err;
+		skb->ip_summed = CHECKSUM_NONE;
 		return 0;
 	}
 

-- 
2.55.0

