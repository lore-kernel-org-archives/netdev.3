Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F36542ED4
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080057; cv=none; b=BmxVbRWZd66ht140x2EvEsp+tf9tIJa/EfEGv8bxi0fsbmvT5pOwcN+QyAkvEDM+iYNrk00JgPj2kzH/ztwfL1xP4Szt32cTz+Utl6Op+g01d+QWmVBN3DWYsFXOnwscPsa96YJJr7eeJBpLi0gc/CRby6uTKLw5dNYbOVpJCDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080057; c=relaxed/simple;
	bh=0g0LHjg15Tfl10SZAbfnWpxnduP9BK+DbZrnx7yBziA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZPbPnmjSc+50El6+1w2PGMdBpUvpYZyXcqzI+WERDon+MJTNBOFZnUvtsjjxe2IP5j3aGWPzB9vyyqVXmMrpuBSvH8muB//RWQbqGualGTM7QgsEg33jP0ADH4yP6m+kcbmg96VNLlXxUzrq63jYTuZWnvzCe6jjQ8h2vzKQtTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q0qRaexB; arc=none smtp.client-ip=209.85.160.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q0qRaexB"
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-530e0cb072eso62777381cf.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 05:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790080055; x=1790684855; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=38kUxUS9QHfaKJy54zeMHe9E4sOgojcYpTK8hPJNdnY=;
        b=q0qRaexBZGpcg3J1AvsyKUT/WOBXz9DYXryEK67v4z0mk6J3Hg0ZNnVB/YQLwhc7uc
         0W9L6feYOIE55RwQe+9vsWfZ+HhBDkGiHHBS9ApSdXfSvd1Z6JOrnNfGHpP+wefsHdsC
         kf74basBCzakyxgZvVa3KkMKFT4U6a9JRnbaxH2KxheSXwactwNVOd4yrKRVqU5aS2Cd
         h4XUpHmYpRHaRPWpDZ/o2I3wVyi95If0R9QQFQc4gdIEUyT3WmsApXMWQtC8jyJdDK1k
         A7QHLu5paQxBKJTLH5zalIJ5yX+rVAaZ65Qc9pOeZUEj129xoiQwaVZs31vzuPM4jcm2
         J4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790080055; x=1790684855;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=38kUxUS9QHfaKJy54zeMHe9E4sOgojcYpTK8hPJNdnY=;
        b=VIldw7sCNAoP67YWCB31G1R9u14re/YBrAKLQT89ALa04/TZKIRqEl4s9Agq4JWaEx
         eWA92rDAnuAz2wS/YJsS/Zv+hDmOw78XzmtPjwOKD6IDAKPkUDfI2kygXw4LOU374nmU
         DT8xSCzq+w0BzIiyzVB9vy5KulR1VX6txvSPtefoBgEMsidqVJ8SpZJJsumc6B495TZU
         USD5eCUvei2iFskJMCQ7TrZ/GcI/80IbupM1kmGDC67a2lJRDRRlpF6mwjDEOL4t5WlH
         Ah3KvtbzScqvGPoJyLP22FpPiTo/m+JTW4uDjNOxc41FiovD+ucFnz6zbB9NaKRE1caM
         TRwQ==
X-Forwarded-Encrypted: i=1; AKwUvBy57JqQAgqcGAW30+82wVQNFVBFGI5Jy3lI3/XCo2sOv5DfwFb1tYvVENrRACAxwLYB3GyM8nI=@vger.kernel.org
X-Gm-Message-State: AFuF++kDY78wLvuQEdqpMPA6a4YVjNP1gi4OctnSVRQ2NDCvLTnoAp7r
	kGb2Gx7k9sr/nEVcBQAaHeiwZCLx+34361lEVSJHyZdEWf3hGZf9TAe5nmRV2FjqUeWa+Dnniq5
	Uca/pYmnaR60IqA==
X-Received: from qtrb23.prod.google.com ([2002:ac8:7557:0:b0:530:f260:aeda])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1182:b0:532:9282:ea51 with SMTP id d75a77b69052e-532d8e35980mr52544691cf.38.1790080054746;
 Tue, 22 Sep 2026 05:27:34 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:27:19 +0000
In-Reply-To: <20260922122721.3568295-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922122721.3568295-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922122721.3568295-9-edumazet@google.com>
Subject: [PATCH net-next 8/9] libceph: use sk_clear_nospace()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use the new helpers instead of open coding the SOCK_NOSPACE
manipulation, so that TCP can later maintain a cheaper private
copy of this bit.

No functional change intended.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ceph/messenger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 212e7797f9e48edde4a4536bba6f1ff293628b5b..cc7db8c61db37a998b698566caa7c936fa83fe4a 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -375,7 +375,7 @@ static void ceph_sock_write_space(struct sock *sk)
 	if (ceph_con_flag_test(con, CEPH_CON_F_WRITE_PENDING)) {
 		if (sk_stream_is_writeable(sk)) {
 			dout("%s %p queueing write work\n", __func__, con);
-			clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+			sk_clear_nospace(sk);
 			queue_con(con);
 		}
 	} else {
-- 
2.55.0.1082.g2b9226bbc0-goog

