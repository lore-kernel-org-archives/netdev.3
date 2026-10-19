Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5354EA38C
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417890; cv=none; b=B3Utl8UOzWxD6SoOhz2sXN9BU9UMxCg9MEIu0jr++VVoiFeDSwPoUD0kYYHBUkeaxQ5Fj8Yc7oVI8VxLcv/bdx+LtJ0VK0c0zbZB4T72QiVFWggVaF2+1W5y0Ak3dmTQvG/P2ErCyG3lUxaifT8KCr6EopWhwVjZmDNxOTRpe/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417890; c=relaxed/simple;
	bh=sxMOxEm7hnqJ4JHjLlLYqgrWX5cOQpVgaNwl3bOsGCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=URWPBOWxHJGk3/XsO3BDIo+ryVGi7v3QR17QMjo536Xt3cczewMmXddYcHAuAFHFE+WA2ev/XA2jGrNOzNDnUBkO+chibvd3QyZ92++1V6eEiSCKMFTj12qU/YebWRZMIa4at1RUUFbUQY1lR9PwkDIE9lL0qgNWVkncK8JOLpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=MR0lj0G1; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="MR0lj0G1"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-533861a59b8so28774251cf.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 06:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792417888; x=1793022688; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i59cwFpnwV4ZWelO27hAghlfIgiy6O8zXnZ0ftvy/nk=;
        b=MR0lj0G11Pmd0IaUJw0idOOMcATbVYdp/qdhuPIxMBOtfu2Meo0jZ0BUlcQ94RPg+k
         SVYXCZ8oDjy5BK7NEixc4vFG/vBvh0QRlkrb5zFk1ywgoSnGkzbeNse6I3XkMQec4jsr
         xVsWJv/nlH/1LBfhUzNJydbhmZ7WDbZgyg36ZBB+SW542Gbb9fTCo+rR98UHXq+Nqm+a
         8eH5cYYyx86BUAzq8CNnWTV2ZcW+lE5gwvu0sqZ/lHDlGquuzJ4aeO+qJRwWq8c4K3aH
         I21mPiq7hZ4RRQA/ew4MUieSPVACNOm/oKRjExjN2PtsQf1uG07LtSmx/zcGfyJK2wKD
         /Stg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792417888; x=1793022688;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i59cwFpnwV4ZWelO27hAghlfIgiy6O8zXnZ0ftvy/nk=;
        b=zIrzxTugio7IEHmnY9NXs8LCC8JO22GGBZb4tbtulhpdGacsps3d0wAxpJcBYiCCvF
         UXJx6Mn0LXXivAukXZguFVGmKLVYPzGioejGBAtdiiJqp3JjxNVW1JDbdpTQewB2/5bV
         cT1MQjJY9mhVFOUPRcgPL2vh99QrfQsxXwe2bIkhEvHHWRBef2rshkv2wijWwFTGHGMi
         lOuyMHlxRC/+MkFyxriafLdH3Y/75WbgvyKJGTeT4I94pUFpYXVlBIP7baz3ZJTmq/9m
         Sky26VmXsaB3p5VhA98/UzuwkrKsZgCF0jAevqMJeOp17+w+H68PQDRs17gYWRrOKRny
         qKtA==
X-Forwarded-Encrypted: i=1; AKwUvByFXt+aKQzlIlsjKg7n7knvhQZaGV8se3JShfFdyIbC7rKbBNXIY7e1bkCZ5XgvNzn44CPNJNo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAWbG9Go3d0RdBsIPME+ysLcV27SCosqCuVAOzkmkYDQg/IbQo
	HlhGcHPpTzDxRRIkA4IPmElSQknIxhfBI/sMZqHXZfwW4NxavXDjeAEDgkuq3VdYhpY=
X-Gm-Gg: AYBFou1ACp24q9gXK98nX/uW+CUMAQQ1ECg/jX3zp1UcdRxrg/j0fMAibiteVWZ/4da
	XknK3+atx8euRgQqGfSpfnbQEDs8V08LBOOguGnKgVtfKHUwgc4NyqaCNMM6uO/zP1mIYaVvkXr
	v5se9AZ5O9VOJmY6okWheQPQMnTfVG5qoNSUo8CeaFpohHDpZg26bxaJ0e4GMYa5h4II2x8W7Gf
	DdKeftD/v0k+77TPreL/FpsPLkhm6q0nzpEJ4I24cgtmFaAqVG/8IgbpsSGdIgT7EaDX7q6/FWH
	AqjJFX8+tEMu1Le5S6NuAGIyVt8qcy6Mknq4mS3HCLcLqCMpI2SSHVjcfqljeu/Dhy/t6gT2Q40
	9snUGJXUj2/v2KSOGcsunzran4CtsobD3unwZ1YVoxh9GvxHQcXqKccl0vSY7IQezY8ufzLoL7V
	NcB7CabgGEoHvdxPrJyqLjFzc2AvnpdeNg0+3LQ0q24LGfklqCzQw++qxlENsAI++QGN+uXNzW2
	VZKVdhplPD/lFk=
X-Received: by 2002:a05:620a:7309:10b0:93f:322b:2209 with SMTP id af79cd13be357-93f322b2321mr606237085a.28.1792417887551;
        Mon, 19 Oct 2026 06:51:27 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f3cb855a0sm338770685a.4.2026.10.19.06.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:51:26 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 19 Oct 2026 13:50:43 +0000
Subject: [PATCH net-next 09/15] net: skbuff: check csum_start against len
 in skb_copy_and_csum_dev()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-b4-skbuff-bug-on-followups-v1-9-41dbef50b9f7@toxicpanda.com>
References: <20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7@toxicpanda.com>
In-Reply-To: <20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792417849; l=1647;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=sxMOxEm7hnqJ4JHjLlLYqgrWX5cOQpVgaNwl3bOsGCc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLHbIa3sdMEeDl3ey/+03pKmEjvdf6OVqCc90eTylLEjn32s0tlhlr2FYQHUU3Yl4h7USrA20K9
 UzEGPZt5vtgo=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Commit 56453199d28f ("net: skbuff: don't BUG() on a bad csum_start in
skb_copy_and_csum_dev()") checks the checksum start against both ends
of the linear area before copying up to it.  For an skb that isn't
CHECKSUM_PARTIAL, though, the checksum start is skb_headlen() itself,
so the check compares it to itself and can't fail.  If data_len is
bigger than len, skb_headlen() underflows to about 4GB, and that
becomes the length skb_copy_from_linear_data() copies into the
driver's bounce buffer.

The old BUG_ON() had the same blind spot.  Also check the checksum
start against skb->len, so such an skb takes the existing fallback,
which copies at most skb->len bytes without filling in the checksum.

Found by LLM review after the series that made the change was applied.

Fixes: 56453199d28f ("net: skbuff: don't BUG() on a bad csum_start in skb_copy_and_csum_dev()")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 5c89c463f234..782a6bacd568 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4103,7 +4103,11 @@ void skb_copy_and_csum_dev(const struct sk_buff *skb, u8 *to)
 	else
 		csstart = skb_headlen(skb);
 
+	/* skb_headlen() underflows if data_len is bigger than len, so check
+	 * csstart against len as well.
+	 */
 	if (unlikely(csstart < 0 || csstart > skb_headlen(skb) ||
+		     csstart > skb->len ||
 		     (skb->ip_summed == CHECKSUM_PARTIAL &&
 		      csstart + skb->csum_offset + sizeof(__sum16) >
 		      skb->len))) {

-- 
2.55.0

