Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F4A415F2E
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786971279; cv=none; b=Y5eV7xprfc97oyObiyWipYJzyJ56r5rfWWBsel5LLjDHl/SdvAvLrwvrZXxEuteFbjpvCG1ZJe8EJg/U+Y99TRgP3YHaoJZ3MjH/j3WMkSfLaJBX9p/XXrvUvhrgO5LShvioX4er6tkdeOuI/ZJwJBk3tTm10S2nvDq00GoMozc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786971279; c=relaxed/simple;
	bh=HaCHVxvVg5ldS6wjekpM9xVtktyIMz5xR7cAFIK7O4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=MYi0PWh7wsPfZbABgZ7tu1xQ4+xND1TLmncqH8tBdb1d43nv4y5vYX6q4M0KoV3W9EeMmEVsJvUOEgvF/YGa1FEku/+0l8pRdquZhfNoeYxr7ujV9zFrlJCyeIHWICwK+KGEr6uhxyWKiMG3JnbII8DSXFegKGNACWZAMGi5NmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A5vs18pv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+uls9TZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5vs18pv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+uls9TZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786971277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=weWYxO6QSfDP4OHBAWREATIQfE1pgetkGo0ZedVXQfk=;
	b=A5vs18pvR9lK1QWKpKa/OyLbRiDpjXbhFM/ho6xH2iVSnyqVdEeEo1px9DDpK9L2dsq4Oi
	mQhWPFz6Y2mqwLquwC0cpWFd3nnVd0jYMmdg8EU90jEX9pfUM6vzffsPcWCGW8fDMGzRnQ
	5Mh/eT8cdy+nWnzqd1nJrDlJrL3LzQU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643--apRLzNON4mXqi0K85q3Ow-1; Mon, 17 Aug 2026 08:54:36 -0400
X-MC-Unique: -apRLzNON4mXqi0K85q3Ow-1
X-Mimecast-MFC-AGG-ID: -apRLzNON4mXqi0K85q3Ow_1786971275
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49953abe51fso23002015e9.1
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 05:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786971275; x=1787576075; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=weWYxO6QSfDP4OHBAWREATIQfE1pgetkGo0ZedVXQfk=;
        b=P+uls9TZ7u29Rt3sLnmA/mhZi0BtJZKboOtsxoLQ/QDrBWutkKe+Wj+AqssReDHyQU
         3aPUhVpicCxecJ6dQnUB2Tx2NA021gxljaTpd1AEJtG8AOE14a0YsyKkF66n1JnUTOoV
         HwLn27MmnGBD/vpND+jviT7hlu/TWf1D7GQBuBBKXFjUZQhHXkTJG6CH8fX3RfrM8J7Q
         K7azDEMIhWcYAV0q2JUVndqgOIWp1qcBEpIFUbk5SCMn6+W2oDNbjxpYvR3WIKZFLbtA
         A3UQkiAumyHeUwmiNpIP4RumU1PqnSEmtKit7k6l4I8dpS+Mp+FpjqJF9XaSaKfsXTu8
         qLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786971275; x=1787576075;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=weWYxO6QSfDP4OHBAWREATIQfE1pgetkGo0ZedVXQfk=;
        b=r95yEvSmeywfLr8YU5H7Kpz3JmvD2e67d9YyZVpFdIpHi4z7SosiU8a8WhGrg0QiXh
         xQSPyfTeVovWgXQoAbOzI2rvlNELB+mDCgEGzHR8zeg4A+djH5LGYxgfIkkYnKq/bQts
         A0rcOdqTkLfEblFU2JqKJ54v8hnhC+pcPNkNZlqADMNkpnPr3bDZgyZ/6mldvmQpknRO
         8U5FFxptrBSwVBoGFCo8S7kEX8WDF0tXbbwBo+aEIwbnNbCIGtk7dO+ZVzo7G0uEpWVD
         lscPb1yRnl+VzV12+RD5EJcWzI3CFHWkLABo1OTxXm4OqPli271W4qN6TRejPeVl8cL8
         XxWA==
X-Forwarded-Encrypted: i=1; AHgh+RpJERTPlOKRrL2pjG1DJicf1In7AbMMJSjupg+sman40U5Hjf4ObDxpOJyGFxR4kRG9SCmkHj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9hStZThDS9up6AFXGihS37xLGjSh7cb7ZtcyCoIIjeCqgrHmI
	IFaKaV5q3STVoG4yQjRdpFMciki35gIVXKy+TT+MFl5mYk08BCtsEOGEsqRDXavKgAEe/4q31Gv
	edg2MMfaGpPPsVAaAnCDOttykPx1je/l300Pnads/EU8o41P1/7/IZzPNzw==
X-Gm-Gg: AR+sD10VRsMakwr4bXgN4CayAlnAivd62YNoXaqEikgYDQYLGJiV+um9WyMPR0ruurr
	riTw8Fh62U5JRdDQ70KnNKIk5hu2BfsShFCTvPIhP6d4iumTghIpXxpW7/jWlOCskJ9BmwFGCjs
	9MAlghctNVqq/8sSORRCvC8S2lbiAUmoRc0LPD3IwDXziZzothMGvvUEdbsXfCPoAIDdogHX4Jt
	xmS0WFtwQF2CHfv/p2h5fVmGhlgUgEFTiIE8C1NTA9m/JlHLodtaPpqg9MSOg2an/uSYAJGQ5v6
	jwaX2ZGpkOPD6eQYdlqPgiX52SrzpSBMHrWtJ/K8sEv+oWU3TWx0smk18bhykOPJCnPyW3/Nc/u
	MK78eR5yOtKtAIQZzntT1wIbNNByFch/xzuOyVfh1mVJLaMMuRscQ7Y9hqASqdkv0FqLaiE3yUS
	4Kolugx/Tm5eSG+Ad62LyBV6Zkuz+NiYn32KlUtRfuJrJE
X-Received: by 2002:a05:600c:4924:b0:495:503f:cf9a with SMTP id 5b1f17b1804b1-49987971a6amr238583355e9.9.1786971275148;
        Mon, 17 Aug 2026 05:54:35 -0700 (PDT)
X-Received: by 2002:a05:600c:4924:b0:495:503f:cf9a with SMTP id 5b1f17b1804b1-49987971a6amr238583025e9.9.1786971274808;
        Mon, 17 Aug 2026 05:54:34 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb (host-95-247-118-130.retail.telecomitalia.it. [95.247.118.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499961767f5sm126998835e9.9.2026.08.17.05.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 05:54:34 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Mon, 17 Aug 2026 14:54:20 +0200
Subject: [PATCH iproute2 v2 1/2] ss: move lport and rport in struct
 sockstat from int to long
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-fix_vsock-v2-1-47e544221eae@redhat.com>
References: <20260817-fix_vsock-v2-0-47e544221eae@redhat.com>
In-Reply-To: <20260817-fix_vsock-v2-0-47e544221eae@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, netdev@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3

Commit 012cb515 ("ss: change aafilter port from int to long (inode
support)") widened aafilter.port to long so that unix socket inode
numbers larger than INT_MAX can be used as port filter values, but left
sockstat.lport and sockstat.rport as int. This means large u32 values
(e.g. vsock ports or unix inodes > INT_MAX) are truncated on the
socket-stat side, making the comparison against aafilter.port always
fail.

Widen lport and rport to long and update the sscanf format specifiers
in proc_parse_inet_addr() and unix_show() accordingly.

Fixes: 012cb515 ("ss: change aafilter port from int to long (inode support)")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 misc/ss.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 14e9f27a..ff1a88de 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -809,8 +809,8 @@ struct sockstat {
 	uint16_t	    raw_prot;
 	inet_prefix	    local;
 	inet_prefix	    remote;
-	int		    lport;
-	int		    rport;
+	long		    lport;
+	long		    rport;
 	int		    state;
 	int		    rq, wq;
 	unsigned int ino;
@@ -2490,23 +2490,23 @@ static int proc_parse_inet_addr(char *loc, char *rem, int family, struct
 {
 	s->local.family = s->remote.family = family;
 	if (family == AF_INET) {
-		sscanf(loc, "%x:%x", s->local.data, (unsigned *)&s->lport);
-		sscanf(rem, "%x:%x", s->remote.data, (unsigned *)&s->rport);
+		sscanf(loc, "%x:%lx", s->local.data, (unsigned long *)&s->lport);
+		sscanf(rem, "%x:%lx", s->remote.data, (unsigned long *)&s->rport);
 		s->local.bytelen = s->remote.bytelen = 4;
 		return 0;
 	} else {
-		sscanf(loc, "%08x%08x%08x%08x:%x",
+		sscanf(loc, "%08x%08x%08x%08x:%lx",
 		       s->local.data,
 		       s->local.data + 1,
 		       s->local.data + 2,
 		       s->local.data + 3,
-		       &s->lport);
-		sscanf(rem, "%08x%08x%08x%08x:%x",
+		       (unsigned long *)&s->lport);
+		sscanf(rem, "%08x%08x%08x%08x:%lx",
 		       s->remote.data,
 		       s->remote.data + 1,
 		       s->remote.data + 2,
 		       s->remote.data + 3,
-		       &s->rport);
+		       (unsigned long *)&s->rport);
 		s->local.bytelen = s->remote.bytelen = 16;
 		return 0;
 	}
@@ -4638,8 +4638,8 @@ static int unix_show(struct filter *f)
 		if (!(u = calloc(1, sizeof(*u))))
 			break;
 
-		if (sscanf(buf, "%x: %x %x %x %x %x %d %s",
-			   &u->rport, &u->rq, &u->wq, &flags, &u->type,
+		if (sscanf(buf, "%lx: %x %x %x %x %x %d %s",
+			   (unsigned long *)&u->rport, &u->rq, &u->wq, &flags, &u->type,
 			   &u->state, &u->ino, name) < 8)
 			name[0] = 0;
 

-- 
2.55.0

