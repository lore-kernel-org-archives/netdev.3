Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794529317;
	b=XVdOcF8Em2133lI2Qh6+rCMQvBaBYnrpNOQy6XD3gZ5NfKKHvEFaHepgsmVoVbuQAnFs
	 S+6QxymUuPUq41wqTiBxZNg/XzQGUdvgZTOuo8q38VMRE296YRrcWH1QTjd02QPF/zsf6
	 Dma2X2CF7YTwgi0A+gN4Wm/AY7nBBncNVXglwoKAGO08NTfI78OqvWWmjQ/n1fi2V1oJ1
	 V9R8twr7CLEr6MKcoL1qOq+goVjI6DAq1GI/YsVd1UmYA8c1QnWuSk+wBSEX4HIlmWum+
	 KSI8JCKAKB9TfM5s9lo4qfRTcQ0pa1WUHbnBNn8SL/5rmbVXl9xtfUJ6TRC8XJE9i0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794529317;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=hYYBQcSCY+tpR1F6WWfRwlH3Zw6Kuk71ej0h+l+fM/E=;
	b=Sr3Xn3dR9/VTEiraICOMaaUh6PChDaeKBZo6ZvHv0COKALT1/VZRtT6nbpEbws5wMDvq
	 mOP/LVi+mi4r+O5juAF58TrSGje/AonT/c48jcsBWb1dO0iSI2e/QsUnnSAAxctX7lJUv
	 Io1rM0hdEOg04HcwVD8lgl4LO3p7OeJGn8T5X03+8WAGLfdpMiZ/ygGhvJ49MLMP0HEjb
	 WadD99hb1z8ccAK1FS4yh7JMZt6T24QMWb5CX3w4ejgVudUFANfbTdOah/KYbbJ1FVtTG
	 PBnLN/pbd9iksjVJ92bZFdnr8Yg6YpxMToEpRTwnr3zZUOxujxSJ/g528zdLiv7gK+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=l3sCiEFr;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E892A606A33F
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E892A606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=l3sCiEFr
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-53bb57f1310so6044591cf.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1794529316; x=1795134116; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hYYBQcSCY+tpR1F6WWfRwlH3Zw6Kuk71ej0h+l+fM/E=;
        b=l3sCiEFrnqk67vunX3OT0JXbvQcqySgGExdZPu4HCGimQBv4ZzogdDh62bMzVaCI6o
         GvMIxWKD1SOY6r2o0MDlr36e5ZV176DlKtLoLGPlhz3rmhoT5QNnJRc2Vg6FO1U/cXyd
         m6TzYJLaIfrO8YSQPTH4gyUKRvs8AbvmfXyKAKCLfl/7fop9dzmOnhj15ILWiQYZ3Ulp
         YWCKBi3epDLeXJkU5422Zok8K7GgVFUNPNGhS1Io6X8GIIm/1DF0AwgMGGrJ4xwNWNho
         YUNx1O772CT8RuKM2xjTpXtnueKRL6cQl6HuSTH57BjotEHA2bIS60VqelTJBjm3oU1o
         vRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794529316; x=1795134116;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hYYBQcSCY+tpR1F6WWfRwlH3Zw6Kuk71ej0h+l+fM/E=;
        b=JDrCAhATkQazgNs2TsBzvQGeId2FS5pwbeqgB/EXMP4cZ+5wWmct9wmqw7fhxxHisq
         sJz+tMi4MRodE5nU3ifl7h/i+SwVq+6xBAQn3kDcu8HslwEIfG8/UoFxwinw2HBqE9U7
         lhor9egnZB/NYgPWk4xrpyL8yY7f2U43G38EBKDWoFG2Z3ImDqvfiPg/W974iZQL2O9n
         NK8w4NtPUkiYSIxI4RvaWQ03vksZcbl+BJyDkXKFNN+hYjCklJapiLOTSFiV0c6uJMfL
         klQcVUq2JadNVQcii2z79pDnlRPyhgj66MY/lZqFUBKluMsH0axDVx7TYRiEbD6VKvEG
         WK6g==
X-Forwarded-Encrypted: i=1; AL+hErFQupOkqXWv5Lj59tlsCUSM2ftX5BCOJveICLT6NGNuWMmBEX3LvMQxtBwTnyLFDahN01N5zw0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8kr0WVAd0VE7/S8u6CTuDo9Fj6isx3ZkVnb9SR8W6uO1tg0MXf
	NfoyoTKW9tK+HewLs85BMOZL3UttjK5gz1TUL2r9p3nou2l67ajx/QtMsEz27d5uj6M=
X-Gm-Gg: AYBFou1NV+ymFJ4HD4XYIV0m5BwzRDtPCNNzgUFqfvD6phElQvJg9070YRtcfKrTqI6
	cdwq3GSD+1k/BsH913HI+2mhC2sfUTYVyIiCu7SVTtbTpxbvE4+r7ZuT3G/d+JWTCv7cV3Mpx7q
	w3voT7LML5r8RV1nESsaUvR6/jtm/uFCsCbezyhW1LoJk7tLBth+0kp/o0UIxmnMNMK6UO7OU/O
	e0A01lAdfPb6wKSd2709JfywOy5kQVL0jMzi+cVReBvRxIg+8Mj9PsRIc7J3JvbCXh/XZzI2itb
	TKMW+D1X8zSWI3tq9dB5cW0Fo7dL8xP1bPHZpvZ/PM7s4SXL8lBnCKZEb6lKeFjUo9bGxQvbAQX
	LjiT5DVxphiPgQd7cdp47ShHxHHodmJKF6R2m3k87Z3WhKMX1Kks2KmGuHAMb7+2fazw/YPZfFa
	UiqGjycu2+L2Dd5TX5ZpuBYzw4dEnoOBFySfBIdmmhewvYCimCvb0hww4+bD3yVWdeXg2DHSaR8
	eoLLVSvzQPnY3gqbp5vzNIlD9qFmwukEgrQdNT2kJT1GvQ7jq95T6TptHx6VKwqSSkPDLbKIkSH
	3UDWZmqF54+m9Y7jPtKWsthH28nmgQOkFido1AAAltPKtg==
X-Received: by 2002:a05:622a:4205:b0:535:8518:374e with SMTP id d75a77b69052e-55ac4390e89mr18841241cf.8.1794529315820;
        Thu, 12 Nov 2026 16:21:55 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad0a2006csm6668951cf.10.2026.11.12.16.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:21:55 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 13 Nov 2026 00:21:29 +0000
Subject: [PATCH net-next 2/4] net: skbuff: don't clone a stale frag_list
 member
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
Message-Id: <20261113-b4-skb-segment-clone-fixes-v1-2-f777fb06f3e7@toxicpanda.com>
References: <20261113-b4-skb-segment-clone-fixes-v1-0-f777fb06f3e7@toxicpanda.com>
In-Reply-To: <20261113-b4-skb-segment-clone-fixes-v1-0-f777fb06f3e7@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Fernando Fernandez Mancera <fmancera@suse.de>, 
 Mina Almasry <almasrymina@google.com>, 
 David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1794529294; l=2504;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=9eG2DXqHsJy91TFrk45jz2PJShz2SN49/r7nxzkXyFI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCNYH+k40kmDa2D0Ee/78EnMR5wMvcIwaH/sW3v4iLC9tAjLk7H5uUxNx5YNKPDisfF9hEH5Y+/
 sftjJLNK9bQQ=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Without SG, skb_segment() copies a segment out of head_skb by offset and
doesn't move pos, i or list_skb along.  It still clones list_skb if its
linear part is as long as a later segment, although part or all of that
member has been copied already.

This doesn't take a broken skb.  Take a gso_size of 1000, a head of 500
bytes and one member with 1000 linear bytes and a frag of 700.  The
second segment is a clone that starts at the member's first byte again.
With a head of 2500 bytes and members of 1000 and 500 bytes, the
segmentation fails with -EINVAL instead.

Only clone list_skb if pos == offset, which says that the walk is where
the segment starts.  With SG that always holds once i >= nfrags, so
nothing changes there.

GSO_BY_FRAGS is left as it is.  It also takes the length of each segment
from list_skb, so this test alone would turn a segmentation that fails
today into one with the wrong boundaries.  That needs a fix of its own.

Found by the Sashiko AI review of commit e447e46ce976 ("net: skbuff:
don't run off frag_list in skb_segment()").

Fixes: dbd50f238dec ("net: move the hsize check to the else block in skb_segment")
Link: https://sashiko.dev/#/patchset/20261104-b4-skbuff-bug-on-followups-v4-0-b7ffeb364f5d%40toxicpanda.com
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 7c232c5c8883..f63946604674 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5247,10 +5247,17 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 
 		hsize = skb_headlen(head_skb) - offset;
 
-		/* pskb_trim() would drop a nested frag_list from the clone */
+		/* pskb_trim() would drop a nested frag_list from the clone.
+		 * Without SG the copy below doesn't move the walk along, so a
+		 * copy that reads past pos leaves pos behind offset for good,
+		 * and list_skb is then stale.  GSO_BY_FRAGS takes its lengths
+		 * from list_skb too, so that test alone wouldn't help it, and
+		 * it is left as it is.
+		 */
 		if (hsize <= 0 && i >= nfrags && list_skb &&
 		    skb_headlen(list_skb) && !skb_has_frag_list(list_skb) &&
-		    (skb_headlen(list_skb) == len || sg)) {
+		    (skb_headlen(list_skb) == len || sg) &&
+		    (pos == offset || gso_by_frags)) {
 			if (unlikely(skb_headlen(list_skb) > len)) {
 				DEBUG_NET_WARN_ON_ONCE(1);
 				err = -EINVAL;

-- 
2.55.0

