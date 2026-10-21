Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590456;
	b=qCPjTvh4FFiAdTxt89eyxneoM9uxiDQ74l8H/EctEqzRKNveo75FBv2aiSzZfJ+SJtVD
	 +IXuPBtBeEWBgi9UaFJ/P3KjyXlbkve6SMaRyCGj7GiU8fEO0ge9k9BqiupMCxQpzU6lP
	 AdYKS4mgzSXi09/bJ+zYwDHM050guneXXgine620/ze3baTtsCTqixnc60ev+t2mn34gZ
	 M1lAlYCvwp5zmajCg2rWqHnTNkn/JubB4+UBqqTcuYg2PERuCG5FvcjsPQH4KFshjKQ0P
	 VV7Dsj/5ZmOU5uKSmwfxJXCD0sa46rbCV3X/EEcNoR71vLUZ1eRrH1nauoep/UZG/sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590456;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=i0J3D+b7/r3u1OwRyftYjz/adUeAE/55QZV56gd3GFQ=;
	b=CnsTbWRjqJ7Q0fW/wu0tTvEC9bc4H3fIrMXe+ifB3mnRipCbIsfHGkGrWx834g6SJ1JL
	 mzopBOZLJ9wm4Bd/d03FTnVG02/jSDRrhYC68Rjo3CM6cqIRP/YIjaMalmjPskTF9ZzPH
	 iFds29VOf48BDWkY76CKNswXm8JFgr9rQemOS70bF4vITzMgZNhqnwEu1zeiH4L/XIjCD
	 S2Z1ghSvfMif3iYHPjq91t2d8I6XKt+DuMP7jfZIshszF/4kfhwxExLyaIvq31YxLu01u
	 n5CIMRGZDKNGhaIckcrvqwb3nPPxWUS5fbEIOn9KHfU7yd9cndoV5i0AjgSNfmNkccw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=pSBVvR67;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1528A60A2616
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1528A60A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=pSBVvR67
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b0f59a5fdaso6304397b3.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792590455; x=1793195255; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i0J3D+b7/r3u1OwRyftYjz/adUeAE/55QZV56gd3GFQ=;
        b=pSBVvR67AY4uFXqBt0/5fc4DYOid6hN+6MbZ5mCmfwq0ktJmrq3c3JwySn3l3UYoD3
         j+tTOSl61eLsqMZtrEA7bf2wOm7/j+x7a6qVPnKuort7OKdLB6nDn9j3k+i5SYS+iddN
         20vISYwwWpACACaUVEYY8OaPULTepMNdtM1HNmwlrJ4uysFp2GXl0nTNDpgrq2SqSO9+
         Bj+fiHLb43WRApg79U2tNLxBZEcv1u9lAOxZnLdIokbc5VJkcaSjK2jwi/qmrl+DiJYE
         t/ST5o5fi7Wcd48/zhZ3nhZi6XalClek9q1LTRVOIisNHEFP7z1KuweTGjHf9RlZ94HT
         iT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590455; x=1793195255;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i0J3D+b7/r3u1OwRyftYjz/adUeAE/55QZV56gd3GFQ=;
        b=LVEUhJqDF6AaoOm1RjeRLrYBaXFsWZoeIA1BnR0QxxxMth8s6WYhouTf+08bmH+Y0C
         3FAzSFMf6ixy3HAvSanY+9PzszsB3OXIczIS4vr0k7PVbkQyWZpqee4AUOKSOohRM6HJ
         UFSzWL+FYzI7pbef7Bhw3dnQP59U65XCn5RhSeu50p8jX71SGYCAIhdm9ZluKeF7/X8d
         KkaXU5EcLo01jpvDo/GvRHaoBMG+A61ATPbzVDstqt1C0OUGcFqLmwlWYhq/QjC8wpfF
         wrjMviUASD67wGjHU8gFEhGJKeXo5dBix6yfVH8YRR79cZG0p+KookK03n913nf0sbff
         EY3g==
X-Forwarded-Encrypted: i=1; AKwUvByARhWDSXNY7SOzXRzVC0973/X7dZUZi61ZuXmgmRi5VFmD3CV+UhJKXa87PqFlXPVVnLgSrJg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLEP+q9ag82PWscrmC90ZBpQvMKUG4nKKmT4NiwlRAkrpxNegD7
	QAohYf1LiTURkWgGX5R3c5vH4rWjH5jHb93FUMONrBYfaB9FgVK15+tXRZeeYQiGEfM=
X-Gm-Gg: AYBFou35CZI/cJPayndcW7+iRoAFlEZI/WsN57uR2iHPiQfCvh3UrzY3pHEpPXwVjJI
	xt7hEtaprJ45w4OfrZif8n7r7e8FcDGUahBBK5ttzMmsg+T3zDUwxWulvmUf4DjEvfuu8nJhAZE
	nPUVle79VeHbt758s2VBHrLSEbVmTc2dptG6qQ7DdfAlBo2TRPDHjGUIYtYa3DFapXhl4fnekzR
	1P8DZ5qcHmNK57DXnUX97qQ2uagNiNiqr8E0yLN4CEalqKkv81Y3Twu/R5Tx/7DyyUXZNCWkJEN
	jwT05HPiYPaXLM6GDjMUaZ961c1gsJzeaLG65jg9wgIqXURrgBbWJRKh+rHRc/gBXCRXepJgLIl
	MnWWZZ5JoURI2KpPoaQ9H9UPHbmj/g2YpvXutAFIxMPusRHOHWWmeOV33eIi/RfXNMb8smzpUzP
	kMGVeK91xNETLKLDBoWvzjhISc3AKzTZoyoBqU40IXhl9jDDz4y2P8EX7c5fRKrxZJ2ZDIObzx9
	271vieLFUO2f1MIoncdqm2IXNIeAwRk7HLBy40k9Vbu1m0rcN6nO2QcA9DlUsIWi8WLMhO1TfYB
	Xy9GlFvtX6+JYZeRnJc=
X-Received: by 2002:a05:690c:6e84:b0:8b0:d9c9:3fc6 with SMTP id 00721157ae682-8b133cab002mr11832947b3.13.1792590455037;
        Wed, 21 Oct 2026 06:47:35 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.247])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b13010e9afsm11079637b3.30.2026.10.21.06.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:47:34 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 13:46:58 +0000
Subject: [PATCH net-next v2 14/15] net/tls: don't BUG() on leftover length
 in __skb_nsg()
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
Message-Id: <20261021-b4-skbuff-bug-on-followups-v2-14-2aa780a03524@toxicpanda.com>
References: <20261021-b4-skbuff-bug-on-followups-v2-0-2aa780a03524@toxicpanda.com>
In-Reply-To: <20261021-b4-skbuff-bug-on-followups-v2-0-2aa780a03524@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792590424; l=1223;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=5t4cbRJHSGQYLLp/0ImHHFowlzs4pEzQ4N7rNchrePQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEgLrOmYkZSVdXm9PAivGpLFnrgKNrg9SpPHyFwsg+XmCzRKGvvpRNTQOmmSS2AzD9Qw0WBfByj
 Oucz9Cz9YYwA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

__skb_nsg() counts the scatterlist entries for a range of an skb with a
copy of the __skb_to_sgvec() walk, including its BUG_ON(len) when the
skb runs out before the range does.  tls_decrypt_sg() calls it on the
same range it then passes to skb_to_sgvec(), so a bad range would BUG()
here before it got to skb_to_sgvec()'s error return.

__skb_nsg() already returns -EMSGSIZE for a frag_list nested too deep,
and tls_decrypt_sg() fails the record on any return below 1.  Return
-EINVAL for the leftover length too, with a DEBUG_NET_WARN_ON_ONCE() for
debug kernels.

Acked-by: Mina Almasry <almasrymina@google.com>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/tls/tls_sw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 312e51270f29..1c578ea47a1b 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -142,7 +142,10 @@ static int __skb_nsg(struct sk_buff *skb, int offset, int len,
                         start = end;
                 }
         }
-        BUG_ON(len);
+	if (unlikely(len)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
         return elt;
 }
 

-- 
2.55.0

