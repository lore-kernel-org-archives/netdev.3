Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334237;
	b=rLrowX7lJYFjpCF21CqO20BdiIFYIn7lrHRHdCoqqw4fpfx/ePknbkNVHWCgZ6tG/pAJ
	 PIkqxYiTmkaPsNwP3Lc0zG1bgkeAKr1njf/1WOad/9f8JFaJihN81XJqEPhkUA1ia/je9
	 0UbdHuoYuI0/j4qDGIH+T4wuYTNCKT9w//0Fpb968vjWQM1Qh2xOd+S2hQfm5fo1cOhbk
	 I6iWPYBBRr8B5+fqIQlPZqmKyJ6WpL4hloyAhcXIpOfpMe38b3VNV5hM4TABJAU258zpV
	 DMMA9kBfMtNxRH50RVdP59ie3RNJY5/vqukSbviJkJmkf3RQaWvVuofnvxpY37tckhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=RfmKHAdchvYOHXCySZuZqltZmMbPaWi+EET0Jg95xlI=;
	b=z1S0fkjQmZpxVLi9KSVGcdcRp64hW9jul65ma7wTfdtQJCV20Ykv6/U7eKAI2Ee/2vjI
	 Mcb2+iUwnUhy9ksk6GMCvpb/05doizZGosh4MdHzhG9LJPXX0dCAWYkPRl0fyMIHErqdN
	 r7SK8Pu+l4BlqwoCCbGdBxWylL7rL/T7hVZFDYy9PFXwFl+ucKWqichN1m+ivH7zRa4aB
	 /bHY9hpBCp2//V2zOAr+XYiCafe4WfsDwBzgidNhtIhKcqF/Sr00jIjJ92C18bKg20EM6
	 Nm3RHZu9kGqEVBNCIOcmAh9BS3xGxQgeto/XLFSThAEHWsyf5p4onGCBLfQxKEFxP1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=Uf43vrHO;
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63F6606A32D
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B63F6606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=Uf43vrHO
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-702fd86d674so183706eaf.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793334235; x=1793939035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RfmKHAdchvYOHXCySZuZqltZmMbPaWi+EET0Jg95xlI=;
        b=Uf43vrHOpujmfbCf1JhLmSAnNn73CszTnAWFJtS6hZr9W9yuEmdD9OIfRZwBaMGkjM
         obaGsFNR6Pd9PtDvAWv4w81adS4+S+e48LAaI523Tc2ks7O8N1PO+d8T9IIYkrNRaLQL
         EsUnd5Z0a74CNQgYgB7XffH+WLTPilsfRa41I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334235; x=1793939035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RfmKHAdchvYOHXCySZuZqltZmMbPaWi+EET0Jg95xlI=;
        b=nqjWaAiI5qK0H5h75YgjzYXP7YUVd5CvQkNmFh/ZxH06Z4t9hRw/ET8Rsm76753N47
         3OsQiav1DA6h1n8xQ5hztciVBFeT99Qidid64mmbG/Deu6nkUtm2svYe9FrFTyoFe11p
         h44v8BygRibI6684QzP5MFxWq01vjwycgRJGejUwo742wsWS0Ul3L96DqQsXEOcFGlx5
         W3vgx4qRs6iy36X9KTtJcaTC8oStAH47VFl8EhQB3lAA2hQNV9xatDglp9fk08AiUDJb
         nRvsUyM6/uT6YV+k3fL2TF0a361BMZuJMh+AY8+PHq1zhPJcJyXcJ4vFtPlalvNUrJNr
         XaCw==
X-Gm-Message-State: AFq9FYKfgGEaZA1I0lXhjZe3Fqgu09/ZvlFhUX4PVlGpBHei4mg6Tbpj
	NFGIo+rU6ZE/2hIdDcwO5YYUxcrIhrtAoWtZpZHwEY8VT2Q4w4YxdMrwY6u91tZNkFnL4CXK/hh
	EJAo9DTw=
X-Gm-Gg: AYBFou16aAs9PDsf9N9+siKbm28An0Jov/5ryPbWuAcXVIJfFDtNwXZjv1qobaMPANX
	yoLmfSDH525ROuwfsGAjEIowoH64zYARXYZyXZJo1Ycy01HBcuM5OZYtaFdXRVw9CMH9J48ihq0
	nCb8TDAN/xZ4SIQCwUq2goAM3DT3l9/w+y/U8n40KxojaAs1BRBzAmxWHpxVvS7AFupmbqgNZaP
	yGw5KQAlCd4UUvyWS56RqZu+8eKnbm9hCIdNefEQE8nHwVdpjGhU2Xq641vbpWO1VN83cVVfiMh
	SrKN6fEWjxIFZmNkBMYmHicqC0IYZ2bMbhdsAHfpEEa8WnPbAKS3PbWCBRXHf00Xv5ThdwHP9Z7
	deiwB04KNAmj2O5U17yJ3RuxLfRcuGGnRpKWmAbGQ3D64OUVxk1XBwxuA6jezqR6S0S0kl1qYFO
	F+iCxt47jDwmIOGUdmhlRijwyoDvKRSWHzbdpyHv1AJ8jZAKDJfWsO/PwBuqwb1/nzyHcXwjmZB
	qtTc96xwozQreDnT7EUQ24SIQxGtW9djJ5LvgxxSC5cGGJyd7sVYVFMu3B4r3khUjmoEHGiJjCp
	gYIEi9BH0fV4ZetmvwUVEwJwjKMlVgjg5Bci0T++o7lJ0zMcLG1TuX/104uWaOK+8zmjkDKO2Jh
	H4fCmDNd6e0wPDEQDugmJeDm5UfaD0RLa2T/Lt3eUpB7IiM135hY=
X-Received: by 2002:a05:6808:6508:b0:4e7:851c:23f5 with SMTP id 5614622812f47-5640de97eacmr799218b6e.59.1793334235579;
        Thu, 29 Oct 2026 21:23:55 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fc49880sm783863b6e.2.2026.10.29.21.23.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 21:23:55 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	outbounddisclosures@openai.com
Subject: [PATCH] xfrm: serialize SA activation with state deletion
Date: Thu, 29 Oct 2026 21:23:53 -0700
Message-ID: <20261030042353.74606-1-kylebot@openai.com>
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

xfrm_add_sa() publishes a newly constructed state and arms its lifetime
timer before marking it VALID. The final VOID-to-VALID test and store
are not serialized with state deletion. If hard expiry deletes the state
between the test and the store, the store resurrects the unlinked state.

An input lookup which found the state before it was removed can then add
it to the per-CPU cache after deletion has removed the cache entries.
Once the remaining references are dropped, the cache points to freed
memory.

Take x->lock around the conditional transition, with bottom halves
disabled as in xfrm_state_delete(). This preserves DEAD if expiry won
the race. The same protection covers UPDSA when it installs a replacement
for an ACQ state.

Fixes: cc01572e2fb0 ("xfrm: Add SA to hardware at the end of xfrm_state_construct()")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
I have a reproducer for this issue and can share via DM

 net/xfrm/xfrm_user.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index a2587c7e796b..b47e5952f619 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1068,8 +1068,10 @@ static int xfrm_add_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto out;
 	}
 
+	spin_lock_bh(&x->lock);
 	if (x->km.state == XFRM_STATE_VOID)
 		x->km.state = XFRM_STATE_VALID;
+	spin_unlock_bh(&x->lock);
 
 	c.seq = nlh->nlmsg_seq;
 	c.portid = nlh->nlmsg_pid;

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.56.0
