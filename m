Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317C741834E
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786971281; cv=none; b=Mcs77ubKos+HLzF9Jg3BBN4mGWO3dod3ddBVSJeIz24xncF+w4NCvAKwfcR/OoF2fj1x0YDfavUZ70lSw/yrWfuizH4N/Cla60GcMehai50/IvLsl3Ztgms+JVm3M9b2H/1omd8hmj1SjCV7Yh9A9wN+7wvV853gJkWT05Mt/UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786971281; c=relaxed/simple;
	bh=8Lhbdr5jz9DTQ5npSIEUUJWe1IZHPYYlNcJJTwl8W60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EpPgIuOq1DC74ZrE3UmugYaEfMCjpz2Qtd+LS+ODGep3ZMpyq+tTKBnf6r83U9aG6NX9dpnhE4tJy4yqWhc5rFliFXjVQA8SZFEfgdHxDXrowKf9BCwzvKZ1nxg+DFQ3D1gmBpt8iMwwzNZP+t3e2HRCkH9o/5HGuK3Lyx9N+j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFQg5cpF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MoJoUO97; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFQg5cpF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MoJoUO97"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786971279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U4feg6unoYFmGibQoUa0CNeMzZVOt89SMSrr7EFcQlk=;
	b=ZFQg5cpFUSHZpvwid2kp6cZXEJqMo0IqEqds56mdd7Vn4VGwZPlbJxaRQn5XesG7fCQ5RB
	OGcRfFggZckfHnE4ebcH3cDptSyLOZomlkQt6+6/YEUprvBfvGq57bmHvdCLG+FQCjHWxW
	A+DR+BGG2li9sHyphsxqyL7Z0jegh04=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-jDlPYFBDOFmkrdstTRQRNA-1; Mon, 17 Aug 2026 08:54:37 -0400
X-MC-Unique: jDlPYFBDOFmkrdstTRQRNA-1
X-Mimecast-MFC-AGG-ID: jDlPYFBDOFmkrdstTRQRNA_1786971277
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-496c06ba017so19023245e9.0
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 05:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786971277; x=1787576077; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U4feg6unoYFmGibQoUa0CNeMzZVOt89SMSrr7EFcQlk=;
        b=MoJoUO97fnrZMGvKuKvzoOVDIvEuSjeAk/nn5zA7fesBXc+AebiFxsrESHMPLNEc4u
         eZpC5FOTaueFbN0G3PMgTq4tbkWE0EYhneNwkOmyO3Vp/vuBbqTDxOUz+742fXnuEWeI
         LjjhVaSj8T+iHkfLVJ0xIXV0r8TILEj7jUQOYwjhW2AjahETDp9KPLg5yQg4BMqZ1PaP
         rZb533DvqrJ/CX7KfCpwUJeZQA5rc/iVCohUBi08nRcSM2YUwvVPB6/oAAqgwcbihEVx
         OWwYbkB4LXv89el1k9Myom5TILtRxjJ9G+j/+PS9A03lTssTjlHQNUcf8L1t1OdGmYzO
         TJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786971277; x=1787576077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U4feg6unoYFmGibQoUa0CNeMzZVOt89SMSrr7EFcQlk=;
        b=i0RxaCAULcvuqPlTzO8PTzjwskNX7lwGBhEtZVySAai/8baVkWSUtsSk06x6sk9qVk
         rwR3q7j4PjE++uZ8F0l3GdqbS061OIVF0ewqxSKpG7FqndI9fHrEheXQ3Xk9GXX5nRDI
         R9FH+IyN4K/42tqAVyaA3rU7zY6WcoH5wNm51zzOhBc8Tv1egsx/3ltKuravlumg5sxD
         JYLrg9T0vJRUUKNSSe0kqT19I58ZoeetgIEW5u6kG/1uLtaOnwNhfBwVwFKIVjP7NI4q
         yDh8xEa+bim4lqtzCbJPeN6SkaaZh7ladt7aBKoQwy97yJozhwlX9BEkJPVSCgtGh4A7
         vzsQ==
X-Forwarded-Encrypted: i=1; AHgh+RqG0IIJ/jOyvZpLHmrHhk2IvyNXtJ0nDlVxWncRolUSyfY3ED14zKY553sxl3+tAtqvS994lD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ5HOwUS7JOo93gyi2qaLU09UG6H5WxG7apFhfzb8t9f3zG0xp
	JnOqLIkhQu33zcPfSraWq71Ww12w91NiKfp2jwKRpzFRsDsHC7FqoUqdyD6bdcUjVN+8lomyVhy
	haUGQ8hpQEZEAcD2gVJOsXLb5l3ekLzg3VzZGML0lvsnskeegGvSQuNR6Cg==
X-Gm-Gg: AR+sD11362vC8A0/Ip1P63WTcfWrREKPA1mYReDOq/+azr8bsxPus02Yk2oYabIesT+
	5U7mowK/M1y1IoXgDEIMVxmV8sLl9k0C1KoChi5wNChq+GL+6FglFT20riVcufnb+P0RtH0D/yQ
	/W63a/4WxlRCkwMnws7WDTKJGTjWYDyt/WV+frAieQBX86ouuRXzOtNNgzy9v4h2S4E2dNcEV3d
	yt1SjslsY9ECUZwKVSGHjMtbMZTtnunLG2TPf2LJs7IqDwno/on0vxKNge6T9h6C2reFjuLO7/m
	wPV3UNzh5HGPA1C09TljyMvYRea1zx97PhiLCpUNn00PMnb6T2P/8GzknmfsSouWHglgYoclhYn
	7ERG2jTuP+qJisXfEl2P69tn/XeXM0hMQ03kDeFGcqw3VWN/kDgDk+hMZd2XJKiztHyd8QCCyaC
	C7/cn9pWZ9ZtnEa/BALwqYDtn7Bdrz4N/IXv6PhRpE2cX/
X-Received: by 2002:a05:600c:3145:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-49987ab45famr347947355e9.6.1786971276788;
        Mon, 17 Aug 2026 05:54:36 -0700 (PDT)
X-Received: by 2002:a05:600c:3145:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-49987ab45famr347946485e9.6.1786971276331;
        Mon, 17 Aug 2026 05:54:36 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb (host-95-247-118-130.retail.telecomitalia.it. [95.247.118.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499961767f5sm126998835e9.9.2026.08.17.05.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 05:54:35 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Mon, 17 Aug 2026 14:54:21 +0200
Subject: [PATCH iproute2 v2 2/2] ss: fix vsock port filter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-fix_vsock-v2-2-47e544221eae@redhat.com>
References: <20260817-fix_vsock-v2-0-47e544221eae@redhat.com>
In-Reply-To: <20260817-fix_vsock-v2-0-47e544221eae@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, netdev@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
X-Mailer: b4 0.14.3

parse_hostcond() initializes aafilter.port to -1L (0xFFFFFFFFFFFFFFFF)
as a sentinel for "no port filter". When parsing a vsock port it called
get_u32() via a cast:

    get_u32((__u32 *)&a.port, port, 0)

get_u32() only writes 4 bytes, leaving the upper 32 bits of the 8-byte
long set from the -1 initialization. For example, for port 27354 this
produces 0xFFFFFFFF00006ADA, which never compares equal to sockstat.lport and
causes all vsock port filters to silently match nothing.

Fix by parsing into a temporary __u32 and assigning it to a.port, which
zero-extends the value correctly. When the user specifies '*' the if
block is skipped entirely and the -1 sentinel is preserved.

Fixes: 012cb515 ("ss: change aafilter port from int to long (inode support)")
Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 misc/ss.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index ff1a88de..a3570715 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -2322,9 +2322,13 @@ void *parse_hostcond(char *addr, bool is_port)
 
 		port = find_port(addr, is_port);
 
-		if (port && strcmp(port, "*") &&
-		    get_u32((__u32 *)&a.port, port, 0))
-			return NULL;
+		if (port && strcmp(port, "*")) {
+			__u32 vport;
+
+			if (get_u32(&vport, port, 0))
+				return NULL;
+			a.port = vport;
+		}
 
 		if (!is_port && addr[0] && strcmp(addr, "*")) {
 			a.addr.bitlen = 32;

-- 
2.55.0

