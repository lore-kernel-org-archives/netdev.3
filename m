Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792664821;
	b=cftfI9lbZs/edXjVMrdCw+dQ4Sb+c7bgOUtFwbLHGkOteWUxoSyVFatHOkoBleBEx5Pp
	 XUm2J+UVfNjQonKUifJOfO7DDmJaC9aV6HcEBkgSxKaEGA7EsHSdO+6munTcuLWEq5AjA
	 VR7K/koYBpsIciwFzSQYxXB1FT9otVgQQjCZyCazIwNU1FIsXLDBTHjUrdTfJTIgWdVeR
	 mBcuVFLnidtA4+TgDhjJ5i7vMTPGGGCPxYJ3mMYK8DgcHmrxsg1MsiPDFsyqb6tuUtlpy
	 O4b5FZR0XATE5gpYINk9qk0dtYRio6nMFmtjSyUx2I+j5p3cmKB5M7qYsQPVNA13eag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664821;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=e2KBzrPE0/o2A8dZGSaDZAXFxxxAfZMmxtyqxNNywSE=;
	b=YTRmHSkjAEcN2FsyNekfCehD3uLZ9Gw3528Cy9fD5uZzVlYL5fLZiZtOPl95F5u6uSmx
	 jSdNu/h0Fv/Mo3W8tp3umu39xi2r5aus318uNyPSVMSEmzdC9eoGueGeJleg1yEV302Lm
	 L/Wi4EUryylOND119/2gAApWPFZFW+O0Rj65nYa0J4OMNiYK0G8XIKwEX4BrqCXVg7CVW
	 ybAv5Pepx1KzvKqYG4FHVO0DvxcX8wnhl2o5OsDS3z4FltnF2Q1bZMTVVe6SpooR5K5fv
	 11STamFAl4QnH6naRuAhAlVZT/yScnnvli0BgB0fgTdYXKYfVUiWGTyVq0Z7VYyWeZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e6PJc0B5;
	arc=none smtp.remote-ip=209.85.208.181
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BEA606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82BEA606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e6PJc0B5
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3a60cb94b80so17301071fa.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 03:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792664820; x=1793269620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e2KBzrPE0/o2A8dZGSaDZAXFxxxAfZMmxtyqxNNywSE=;
        b=e6PJc0B5EaSmQK5D/4NzScSFnF+dysZ4DiaVEQcvsRB4n9qruixsu3G9EVtQffmTVM
         cbmf2gScCqWqkqf2x/DAxaEAqnCA1SCu3Br/aqavKZNcek8kYBxgh3BdHHGrq5BpfpL0
         tN1fCZlroTd/7jSHbqYz46YdLSojbk0gyHPbzkw9E01EoPJl2evXcj0aOgGAYe3IEeii
         1hivUzHYjdbTDDkiNMr32vLHqkeBB4vJBqD3w3iOxzfLmCOuCWMEgtWBY0L+AGjLVaIb
         t2oNQOgZKJljcl/oK85MJjeRKbMGSwtWXiADpiTqUd0KRGWbtw9lQfy08gaJ292H/fwC
         pl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792664820; x=1793269620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e2KBzrPE0/o2A8dZGSaDZAXFxxxAfZMmxtyqxNNywSE=;
        b=BB8pstXbAjXx0w8Nch9CDkvMOiYD5qDwHiaXMiDAe/5pAkd4lsDeDVfvDSZPdk4erD
         ZXzhbd6xNGUGV3EDU9ebsp+E7+/DeTUnUbD0xcvOfs7ILQk9gNfuoLCkLE/dLkV7F3Qg
         lRsk7G306koAz/VsufTpAryV7xuU05GBl4AtVzQMlWZKS0qBUFg2cFMPmz8Hyjeeig8E
         sY7DOzmMM9hY1d4tfhQNEYv0OuZ9fv6kykTLMQyqLe96Rjtw3X/ZIi+uI8DvbqWZBOm/
         EG63b1Gh69a1wGV5rG+rvQIOYvWDZNIgGZeN17ruuj/kosEYhRgeIQaBEN1ZqIZGq2wJ
         Jj1g==
X-Forwarded-Encrypted: i=1; AKwUvBwfqv425mh5KUVpnBzWnc5CWehF3tspWGiUe7PvhPVC0A42eKpD7RYPGSVrHZWCjcuY60SFTWA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKRR0wJuVKTXNiyWggJvPDdx3Mz8yMU1q6ErpPmUIEW9FD7oq48
	ipVzUvrSll1cZnW7zBUxrY4CCeeuvGdFw8YmV8xQMH0uYZy9+WdXe2GG
X-Gm-Gg: AYBFou2nphI5TQeytxOQwYSXHBlHJ7lZy4oIN+SU6fYuiYQhc5Kbis15UC/DsbRp/OG
	/b6aHd7bqdc7gVY08SDHgSUH9/XAGVtSf7hiQJah1haZ4IvrIwXQ1aZez2jDRZ9HBT/rqKTiM//
	2bK9vobfAgVKLKvNdtIviXcbqa5cFwEO7Xqlqz0LCntZQXtI/Z43wDMeK3QFQMYAS0E3p20Allp
	VxbjevHJSzD7g36j+kzD+yIOSafNUi2CHCOAAO2YG6jYPjP93DcZHmWE5NC2v3IaaE6fXxbytNC
	fvDsDwgOSSwYFj2zSKZQCSapyTMC1ic3qrN2lpa8IZShCcYhd61Rj0ZtpseqmhV3isOQGJZObuS
	Nb1mzV6cng7RzIdhk6Su0mi3zHC4vBgSPtz6QFeeiHw5xfHXh2E7m2C46m2jnfSTgc9H0ZvERjA
	hTJwhLj6X4hspIA9MwnljeIlAzM8Muf5Hx3r5MFLM4bOt9FmQAQVxVLWy261Mw//S1kpOYQbyKe
	+WfmTe75EsxNS4IkJ+Ppbd1SiIcG3qJQytr+HNh02PoKIIw+cOaMjgBpAoFms6zClYLjqxJMQ==
X-Received: by 2002:a05:651c:547:b0:3a6:622a:2cad with SMTP id 38308e7fff4ca-3ac4416e587mr12026331fa.10.1792664819457;
        Thu, 22 Oct 2026 03:26:59 -0700 (PDT)
Received: from linux.tail9b532d.ts.net ([196.240.54.42])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ac4f67a8c8sm6643221fa.33.2026.10.22.03.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 03:26:58 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+f3f4fce0609f8e91b540@syzkaller.appspotmail.com,
	Eduard Zateev <hackerowskiy@gmail.com>
Subject: [PATCH] xfrm: disable state hash resize work on netns exit
Date: Thu, 22 Oct 2026 12:26:41 +0200
Message-ID: <20261022102641.1429128-1-hackerowskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfrm_state_fini() flushes state_hash_work before it inspects and frees the
per-net state hash tables. A concurrent state insertion can queue another
resize while that flush is in progress. The resize worker may then replace
and free a table while teardown is still walking it.

Disable and drain state_hash_work before flushing states and freeing the
tables. This also prevents a new resize from being queued during teardown.

Fixes: f034b5d4efdf ("[XFRM]: Dynamic xfrm_state hash table sizing.")
Reported-by: syzbot+f3f4fce0609f8e91b540@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f3f4fce0609f8e91b540
Assisted-by: LLM

Build-tested: W=1 ARCH=arm64 net/xfrm/ (out-of-tree build).
No reproducer was available to run the teardown race locally.

Signed-off-by: Eduard Zateev <hackerowskiy@gmail.com>
---
 net/xfrm/xfrm_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index e45aa1ed5b9..8a2e465bd73 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -3392,7 +3392,7 @@ void xfrm_state_fini(struct net *net)
 	unsigned int sz;
 	int i;
 
-	flush_work(&net->xfrm.state_hash_work);
+	disable_work_sync(&net->xfrm.state_hash_work);
 	xfrm_state_flush(net, 0, false);
 	flush_work(&xfrm_state_gc_work);
 
-- 
2.55.0

