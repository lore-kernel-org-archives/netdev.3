Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2114B0E4B
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791386760; cv=none; b=ZyAtTn0UxH1gweWivc542NEtmrF4CA7wh0YMMzUxOKiewMwC73t4wrNtLAwu/onkcXa/HNWpydiBJu/vkt6KfpKQ4THUAwmAL6CEv8RhIXAg2WsI6I6mY5MdW1tXvEO6T5y7chJf4cgOlBRTkfVEs0ht3XBRmnCVKXiLr37BHaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791386760; c=relaxed/simple;
	bh=N6Mwje/jk5LkEVovjy6c4cdZNQ2w3u+xqBwLIGCWajE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gzK0vLtW+2shN+FTUhIm1lBJrYW0c05etAs0+dvR7/Xpe9xcMpa7dKQ7zP9e1yD/NlLWH4YzulACLaI58vZMkUCJTNQbJhjES5vReHm1ECUF2e46eDk0YI0sdQHHv7Z12Fjxx+yeIsfmMRg1aOqC+eM3RTc6kot346ganNiUag0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hk8IwTG2; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hk8IwTG2"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3515f9a5d25so2050835eec.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 08:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791386753; x=1791991553; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r5LK61z8EbTq0+O4wcf4iS1SXssqVs9NYokbeiW5mo0=;
        b=Hk8IwTG2SvkVjlZRIKp4PHnWIJTUHCcReTUvDmkuaFiFu4vZnjm85YHyPDC7P86eaR
         NiH065m5EyFv9e5rzppvR/hbTIHkBm9YsqlUEYFupqP8M7cuhAy21YStdkgC3MRXNEua
         sBeS7fyaQiRQogX6xfcRE8cGRri8bjx6gLm8biAQN1bE2Vv+RetMr7xM+a2OPWOjXC58
         Ch6lvjmYFxaYrZ0N2xtoBn9Fyb66RQ6YxIeafbeRqeVNUCxEj0GUmki04KktntNEuCe3
         XigkyJUqhIJuEy+mV2873amZr/ARidCDrO4UNRzkCbnOTnxSs0PAFa72nVjvoSNcishe
         F+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791386753; x=1791991553;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r5LK61z8EbTq0+O4wcf4iS1SXssqVs9NYokbeiW5mo0=;
        b=aBp07ewQAhh08A1Y1dsb1Xc3Rcc+8E2S1rvGdYywSR5yFtE/6fQ8CTEqInwRuXVA3W
         OMIuJg55SeQQngNfNch1mQSH1EF7DX0OnQW4QT/8NURmfyOfIAjt+tdsb8n/BaOMhbDb
         ncNcBNojpd6yQsAKTlvmsGAEInoNL03JVxPhzSYvpkWpRfOKEx6BhpVBLJAGAp5IqRBa
         BuLAhkzlmEVk+t50lhatztlqdILTqTmF7ny7iS0e0eubDb1Al8H2nlO6+prN7akVDd7u
         1pwXs0cPH236e5rDR41f95gvBy1F/adEp/fMGB0MRjD9uezzM4j2ILHEceOKj/0NTCUw
         Gzaw==
X-Forwarded-Encrypted: i=1; AKwUvBwDhlrVht/CfnXJfsBWyidh+kSDGw7ZpSF2JQfBxIx2tAF4Q8bCajX9M/zjBqZnBOnRBcAhJRw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJO+kDpnBnlIYUY46ihuVZDiEtY1BxltqyCWJlnRm7JumU03kEp
	YLVozQYQeWY4r/m5C/zYWt4m2wakIcnNHw9UQKa0SMTBK9Hpr7H2Zwz7
X-Gm-Gg: AYBFou2Hdu0qyTW0AVQliEUSiRiHrSvrw/+FkoHXBPQ0qXYAgHd7BIm4ngq5M3197b7
	xMVjPniy9JJ/CszL+UykfcJpnUuCgmZZgyk35Hari1qKdNbJB17KRP+ttTynbdHh4Xy+ES47+Ot
	hdjiN7DFcfajcVzegElr+VdgEcVts+0aokFm/RYSYHECrb19MOi01xFaUabF+g38aytiHCyyUlK
	EWmmt893pz0vsArFP/O6dzzZJjt4g/PM0ZMKts54+r3cn4at7jUDn7lSWKnxNeq8WtQ2duAADIV
	/1b/X57uQ2q/VE3v+QlqDrkvf3lPzALHbkugQvTa3uAneYqUXF8NsaFXBw7LGcFMnvct2OKOAG2
	Kg4JCNLCbhY+n7SUussQpW/oBCoGyIS8eiF1lFF7S9hHXpitJg1PdQ65UplzMKeGxE6Y7IOU23i
	acgZn26YJsFB6SQ2cUpXkTWEb7fvztfG6GYhHyTn4wnfsJ55UR6hYo5U3qrcj5yir7hMyZr3+jD
	+RH7qiFIBwtMy5NtnuMfJJ0sCGZUBbu40unma0QEkO0mL8qlS4Gsv1rCjXsgx7OhKX+dsc/6dxt
	lTY6ts5couqH5s3XMRNLmjOR+YtY0Ngva+LwEGDIz17Cu0TpOzQR
X-Received: by 2002:a05:7300:e9cc:10b0:34c:1692:f2d0 with SMTP id 5a478bee46e88-3515dd8201dmr3203304eec.8.1791386734242;
        Wed, 07 Oct 2026 08:25:34 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([95.173.223.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515af26f10sm9234416eec.13.2026.10.07.08.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 08:25:33 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org
Subject:
 [PATCH net] calipso: update payload_len when removing the CALIPSO option
Date: Wed, 07 Oct 2026 12:25:00 -0300
Message-ID: <179138670045.80227.16292613517250896744@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

calipso_skbuff_delattr() removes the CALIPSO option from the hop-by-hop
extension header, or the whole extension header if CALIPSO is its only
option, and pulls the skb by the removed length.  It never updates
ipv6hdr->payload_len, so after a successful removal the header still
claims the original length.

calipso_skbuff_setattr() already adjusts payload_len by the length it
adds; the delete path was missed.

This is reached on the forward path when a packet carrying CALIPSO is
sent to a destination mapped to an unlabeled NetLabel domain.  The
forwarded packet then has a payload_len larger than its real payload
by the removed length (8 to 264 bytes), and the receiver drops it as
truncated.

Adjust payload_len after the header is moved.

Fixes: 2917f57b6bc1 ("calipso: Allow the lsm to label the skbuff directly.")
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Claude:claude-opus-5-5
---
Found by code review.  Compile-tested only (arm64, W=1); not runtime-tested.

 net/ipv6/calipso.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index c6a34334e..c072eca50 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -1428,6 +1428,9 @@ static int calipso_skbuff_delattr(struct sk_buff *skb)
 		skb_pull(skb, delta);
 		memmove((char *)ip6_hdr + delta, ip6_hdr, size);
 		skb_reset_network_header(skb);
+		ip6_hdr = ipv6_hdr(skb);
+		ip6_hdr->payload_len =
+			htons(ntohs(ip6_hdr->payload_len) - delta);
 	}
 
 	return 0;
