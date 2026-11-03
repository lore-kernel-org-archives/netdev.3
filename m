Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725161;
	b=2nZQYj6LEYXiT7l2oSoWu2SexY2c2sRnfdLR4K1a5w0UKehixrWeLTeiKC9UOfaJqRp2
	 1uk6EGByD+ByfdEEt91EVJgpI0et8zOjDBmi6F4iDEBTiFEqFHwZr6/8oXmHwnpjJvJn6
	 A9MrNFbWLwDlow3kL1jyOiBJqdiB6a6AuZVRUrq7c1olwxQ6eyRgdbvsF0xYzaCVqtOl0
	 /28aJ0aQPLT0b27TvRqQAVvyKB2RbrWQ7wyS/flam8+Ati3jDWgpDpSODAtkPysWJ7Iem
	 at71ichjLTqdUEX9tnx2ySLjnwgU94YiYXceXx9xZvUu5wVfaaZ/AnXzvK5k9FKUfAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=x1NI3skowoAtNdcXptzYo27srndyE5ZnDqWHrHmy4U4=;
	b=ddtu5+GwEXHmXqH8V4OIOJrJ69VGpm/LWFWpq5Iv/Abmsy0iVlKTo0GouiDHN/jVoOLx
	 8cSmgDiKd3UPC+y599pEHANpZEp6GUQafQH3BeKllOojeehZwDnqVyXhwP6AlM5Nrd5gU
	 rXg4gPuu5pNceKQ//mmAWutcEU9orUQrpNDLo5IXd9zo1l0nmsAT75Myc8zY/ruIr9xgU
	 +LcUWy++KxMKaHfCJgrEbmLCws5hZDd8lp6DVjr9JqTmx30Mm3pyV2/M7omfI2kGLTfYu
	 JlOQUeUy/N8+DaNydYGKKoSvNtuMqzW3OZ3k63hkUqCUGh1pqbPP69nESll9Nz2z6FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1password.com;
	spf=pass smtp.mailfrom=agilebits.com;
	dkim=pass header.d=1password.com header.i=@1password.com header.a=rsa-sha256 header.s=google header.b=HvE6CnDk;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A62606A329
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 16:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5A62606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1password.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=agilebits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=1password.com header.i=@1password.com header.a=rsa-sha256 header.s=google header.b=HvE6CnDk
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93f20c3aaa5so462461485a.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 08:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1password.com; s=google; t=1793725160; x=1794329960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x1NI3skowoAtNdcXptzYo27srndyE5ZnDqWHrHmy4U4=;
        b=HvE6CnDkjqXySwNnSQZMyeD4DSmhSNJZ5RuJy5b40IJ8vc3t7iydK31t81eeeIpz0e
         ZBLyyMJH+Z3iDY+sb0OebSLGqPrZy9R9RhUXkFrBvJT0VjU+YQ6c1S/inFLyGnz3EY9t
         Bdaj8s+/76t7301785EuSYGoocmPSroSPJJNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793725160; x=1794329960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x1NI3skowoAtNdcXptzYo27srndyE5ZnDqWHrHmy4U4=;
        b=iw5aHsA1L2JoE2tsGWPBwG+uXHb1xAT8D5IJojne1yOxU3Tbdo78drpBPG7S+sOvWd
         Oaj+eSLCjPkq22MF8Is0skkcw3aag3hGul6np/4LL2NktLRjDQHHHMWMnThT8C5UKtTL
         82Kf1sFI6MNnEBWAyZi34eZNjZicb5aWUc4uIwZjHw5RsQI+9+JxEscRzLScR/2A2wZt
         nwZXmNT9NFjjOQa7cALdvH0v6VhAsACisDutufcdwvtdkC7YnIFmZDIxT3p5WtZk8vfI
         99jYxq3Z0i0FZP/V6g9EMrdUqVpE/ZmImixTZizqYE8WA7kUwZK7w/JbthW9xcKUtbKd
         OWLA==
X-Forwarded-Encrypted: i=1; AKwUvBz3Ze0bFUjWM80KPeVEqoLMZ83FWi0DoepN3f7EY1IlFht0UsKnuE9rvdYvcgQFdzAQh4tufXc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/EDpqZR2TyrsjINDz8zdvu5zVlPf0VF1DVxa904uZjnLg/RlwG
	GaT4z5fvInk1Q8ZoC0zw/rbmiOeTYpV8myC57AuUgSqx7Ht/bd3kf5y8fr+XtAvhFrs=
X-Gm-Gg: AYBFou1fvSZdOqj3JMAJUxwmFnfdF4tMfya1Ho4eysYp2hcv+mTOqkdF40mtr85jj0a
	+s1AIR1X+nPeriHmDMIA3zaxXXxkeDgDlaxGzFWaJpGPul3fAUcXg3JHIgNM3TdFbgu0Sz2CcR+
	LFVumQh8UaSCymL5dg08P6KYaTEkrU2kncX3jJu720cawBFLon+qAv4m4MjBSx2Eo7aGrPRvVi+
	opZagxjRDqHeGRmp0HMKVgg00wrEJBcJsLLg8q9BMh+AoRfxtpAQOOXiItIvF52k6rTHaN1gs0s
	hYcWGc14BfWZqQ4vbcplimq1qHzJOF2h6eO3Rs7O0OO25Zx7NcmqMXtxwX4CEeCrLnlq/DQKTaB
	PKDZYa1txm5LjcpFsqugnWZjzkWqqhc3BItdJMzeU6AEpbF8Iqi9o58t+RlQ+Ndln5re/j/UkK+
	rDkcv5vgW+6x5+PaRjbdn2GQZ58OPUnMXXBY+9IqPX7LHNYqDJqlJRJ4/gu6zLWXsjiIH9dbEr5
	zombwd6QYfFFJM87m5PH+b0+SR/rwCol5CRpZCKbt4F7KZQTXggovFz96MDUz8Sa/T5cgLhslyt
	oxBz244o8vFbjsLWqCp1cpzTNu091gUO6Eock+iQraGnUsfUTvgwfDAWtRW3
X-Received: by 2002:a05:620a:4385:b0:93e:5eaf:dd87 with SMTP id af79cd13be357-944217c1057mr2138536485a.62.1793725159609;
        Tue, 03 Nov 2026 08:59:19 -0800 (PST)
Received: from localhost ([2600:4041:59c3:300:a850:2af1:eb93:4121])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca8066ba4sm120593986d6.33.2026.11.03.08.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:59:19 -0800 (PST)
From: Axel Mierczuk <axel.mierczuk@1password.com>
To: ja@ssi.bg,
	horms@verge.net.au,
	pablo@netfilter.org
Cc: fw@strlen.de,
	phil@nwl.cc,
	netfilter-devel@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	w@1wt.eu,
	Axel Mierczuk <axel.mierczuk@1password.com>,
	stable@vger.kernel.org
Subject: [PATCH nf v2 2/2] ipvs: skip cport 0 connections in ip_vs_conn_out_get()
Date: Tue,  3 Nov 2026 11:57:46 -0500
Message-ID: <20261103165746.39516-3-axel.mierczuk@1password.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261103165746.39516-1-axel.mierczuk@1password.com>
References: <20261103165746.39516-1-axel.mierczuk@1password.com>
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

ip_vs_conn_out_get() does not filter templates. A template with
cport 0 is matched by a packet sent to client port 0 that traverses
the out hook, and handle_response() then runs ip_vs_set_state() and
the timeout update on a connection that must never see packets. A
backup server receives such templates over the unauthenticated sync
protocol. An ordinary connection scheduled for a client that uses
source port 0 has cport 0 as well and is matched the same way.

Apply the rule used by __ip_vs_conn_in_get(): a lookup for client
port 0 matches only connections flagged IP_VS_CONN_F_NO_CPORT, which
still wait for their cport, and a lookup for a nonzero client port
matches only connections without this flag. Test p->vport, which was
already compared with cp->cport, instead of reading cp->cport again.

ip_vs_ftp_out() relies on the first case: it looks up the data
connection with client port 0 to find the IP_VS_CONN_F_NO_CPORT entry
created for an earlier PASV or EPSV reply. That lookup keeps working.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Suggested-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Axel Mierczuk <axel.mierczuk@1password.com>
---
 net/netfilter/ipvs/ip_vs_conn.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
index 94f25fb7d87e..29cbe797bb86 100644
--- a/net/netfilter/ipvs/ip_vs_conn.c
+++ b/net/netfilter/ipvs/ip_vs_conn.c
@@ -579,6 +579,8 @@ struct ip_vs_conn *ip_vs_conn_out_get(const struct ip_vs_conn_param *p)
 				    ip_vs_addr_equal(p->af, p->vaddr,
 						     &cp->caddr) &&
 				    ip_vs_addr_equal(p->af, p->caddr, saddr) &&
+				    (!p->vport ^
+				     (!(cp->flags & IP_VS_CONN_F_NO_CPORT))) &&
 				    p->protocol == cp->protocol) {
 					if (__ip_vs_conn_get(cp))
 						goto out;
-- 
2.50.1 (Apple Git-155)

