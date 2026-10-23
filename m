Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785253;
	b=q+CXW9EyC6sm9tqq2vUCGgH/CVlVcMuGTD7qZfQl3GZB01Hvc3JpXnGsT5ZAU4ZPyHvC
	 s4pAR2teXPyRgyLovMLRE9UDF+ly7s0b/T+osRo8WlYMEI3bVxznTsAJmWbWYIDMKkyLj
	 XZ8T66gmzNSpwzb1hbIgTtVkSCpw35sSGzYkk28fC9kp7Wt9am5Qtr8PWJrX0gsu4rwCE
	 MgG++gsGOAbOOFyWzkD/upGX76xzTws1g44mfLKBpg61wlA/SRgOCzLP5hTPrZrHi7TVT
	 vWHgBz/3iRRifSUBWYR4q3z+16JKaa5Cvzo63CkG1j0nvyGVMFRBif/cKo7MA85TJXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OXHww7JRwC5sR22/HTGUO5MsP2p4PTlezupZRsfe/2E=;
	b=AdjXC6audLfL62yOcuCx5u3McO5PFv3wP2VHxAz4E0O9pQ+rsNllOubIwjYqLnH0jIzj
	 OxefxK3olJUIbnNpvV481pSYhYosC+0YhXSB8xCNS78g0wcWBVAezLo1qLCgVOAdIj0tL
	 R1WgEPPg7EgflPRdvsjAtnf/L6n5KHf5wB2sJF1FZGrNothv23grh2/V+M0YUjIQt6t9T
	 xHYvLTdkMu7b1py4nclSAuTxyugSiS7NLzyYSUs+q4ZtuNcFCFRdSzNsQiqJp0eUPdcUa
	 8d9HJZBLhspTg/dkH2bzYmdJxrivHO0yv4yZXDpipOb8Lmbnof7WHvzLX5KBi37KfcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kI+bwye9;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88CF606A324
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 19:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B88CF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kI+bwye9
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so8090115e9.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 12:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792785251; x=1793390051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OXHww7JRwC5sR22/HTGUO5MsP2p4PTlezupZRsfe/2E=;
        b=kI+bwye9oXV5c/UPK9Si+6GyiMnjIXPLtvfyZzQpz+Q939kTlUyL6rL86QL5pmt6oi
         g9m+6TZJjPi2qYdf7LSBRW6UXARhfL2QavUv6VLzn9wHYYxiqBwY8gIaHkYQLfoETy4r
         oQFCFX5kOWGs69DQCo5P71VZ0rYS+Z4ZjPjvSpI/+DYMYfpCVfFUjJNkyB0EvZqRU2m9
         m6twM5210z5v4HpDvUk+gsgw/Y42Rs0lGzjcuMxzNniIkVQVZ+pkQLEEiRXMoaKiDBkl
         yiTYjOO69N+Z209H4JgtxK8W8Cz8M4Vqk+hyhjo3SoQ0dmSiD+XuIkjROsQuhQuPmK7X
         P55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792785251; x=1793390051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OXHww7JRwC5sR22/HTGUO5MsP2p4PTlezupZRsfe/2E=;
        b=mlVnKP3ztPToPk1nw7aUDnew97eRwd9KZAc8bo2m16U/sAeVkqHlmC0RRGEHqMWqr7
         BkcXr+SCtOG0L5SiyDMj3odxBwmXoqEdrxA8ypWCsoh2+BtlpuLAEh48cQzG6RFCRLcZ
         +rv8TDnhjX1Jt8/vCvAUNRqRuFO/6G84Tw9Qs/pxKKPeGQfkZU5z6yiFMXFTHBOxM8aB
         LHrodHiyuwmfjrYSQDnelqu0YxGh9dtQfqFhsbkOx48qO0VlTkjG/YnRk+Bo4dHeWmDj
         YT6pzv1hVBtc/p9CzGgUTdJ5NEyQO1dOM9Q8BVWYWGn/363HROrDDOmN/ewv64MNHoXL
         R3tQ==
X-Forwarded-Encrypted: i=1; AKwUvBzRn1PjVFylwGsbqNxbcxJDk9QGQzhHayxFwpupR4otx9u7sB9W1QTPMzftkxutT0+U/d3G2Rs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLO2GA1sorlekHpBCAmV2ulmdOHGuPsBbJpfk4CC3iHzCcKmILh
	8+4CEHa9wxxO/OQUht6BFHjKXNdNYC+5kufBxgmPhEXgwoN9Hwbh7mU=
X-Gm-Gg: AYBFou0PEon6e6ZunQbROD/nl+oJB4g8TwcD1LDyFAEzQAvUpYAmDNL+sqJjwsja9uz
	QijiuRK6GanyuUvTUfTYEm7ZLwBCZ5DTuvyKl/uvvbfAyoUy3e/IKnEo7DJDpyt+cGYyYdSuJJ5
	c2L9ztl8zLvcv3XxjNmuH1BTqOwPGJXz0RoE+zvSdCSIXzopxhP4hS+pRiPAW8pNVdR59Aabdzn
	z9JWr1D29ycQM7o+ABRr6NeVvnfC33XwU02jClIKwirdjNfRLun59LXM5BfGgrGYt38sqpBrOrX
	kif33BdbWAJdVFj4WeCAbArx8irfG2LRmwYHOEPjAxnl4M5lzvmP+aklKq0xRsHILVfpFyrBokx
	n5g0fhYs9AHhGJcEQUzxQAuVg/Dgt+aYfS/W5VuiPLh30fPHzqyxGgFBnVV8N3hhr1+ymvPd7cT
	z+q/qzTvbDNsclJ/Dw1r0o1jsRvRmSwSghd7mreOVkA8pmKYm7K//NXdY5kJ6I/l1usld8oRIRx
	4FHljWY5L9gpNCPV0C3J2xS
X-Received: by 2002:a05:600c:c170:b0:4a2:190f:cf6a with SMTP id 5b1f17b1804b1-4a2190fd130mr29520455e9.35.1792785251101;
        Fri, 23 Oct 2026 12:54:11 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a574088sm3346915e9.9.2026.10.23.12.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 12:54:09 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: David Heidelberg <david@ixit.cz>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	"John W . Linville" <linville@tuxdriver.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH net] nfc: llcp: use timer_shutdown_sync to prevent timer rearm
Date: Fri, 23 Oct 2026 19:54:09 +0000
Message-ID: <20261023195409.3532540-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

local_cleanup() uses timer_delete_sync() on link_timer and
sdreq_timer, followed by cancel_work_sync() on their associated
work items.  However, tx_work unconditionally re-arms link_timer
via mod_timer() when it runs, and sdreq_timeout_work conditionally
re-arms sdreq_timer.  If a work callback executes during
cancel_work_sync and re-arms the timer, the timer fires after
kfree(local), producing a crash via schedule_work on freed memory.

Use timer_shutdown_sync() instead, which prevents subsequent
mod_timer() calls from re-arming the timers.

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/nfc/llcp_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 74bf817007cf2..a098d72a15ba8 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -173,14 +173,14 @@ static struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local)
 static void local_cleanup(struct nfc_llcp_local *local)
 {
 	nfc_llcp_socket_release(local, false, ENXIO);
-	timer_delete_sync(&local->link_timer);
+	timer_shutdown_sync(&local->link_timer);
 	skb_queue_purge(&local->tx_queue);
 	cancel_work_sync(&local->tx_work);
 	cancel_work_sync(&local->rx_work);
 	cancel_work_sync(&local->timeout_work);
 	kfree_skb(local->rx_pending);
 	local->rx_pending = NULL;
-	timer_delete_sync(&local->sdreq_timer);
+	timer_shutdown_sync(&local->sdreq_timer);
 	cancel_work_sync(&local->sdreq_timeout_work);
 	nfc_llcp_free_sdp_tlv_list(&local->pending_sdreqs);
 }
-- 
2.47.3

