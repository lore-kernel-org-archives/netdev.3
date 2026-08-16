Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1863D954F
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 06:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786863322; cv=none; b=DqUNnZ11jsA/TSE1lUxWThuUCAle5RVsjW5fRaRfr/C3dsMJh82D3KJbS05SciK1644fb74zqhS8ytNP4xv81/RR8dV60UPO0HJ3oHQ/wLv+ePxmYAbgI8Vs9kA060pEv9tpzQcfQmKNdfDtBovnTGJN0keZm/WUVSLsmchT9+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786863322; c=relaxed/simple;
	bh=GF6Hd3Wu9d+8+v1Ikb5K7KWhUHhKY0lsI7cCBM13xgE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=oi9mR9IbiDArjMn0xsKtHhSpGBGILkauF1SE+GVQzOe8NIjvEfr5UZQ9iBKuPoWtjos32HfisLNIPzui0n4UfJOlc0o+zJ6LEQgaNIXWhH5tEjJG7A2wpcykbUPjBM4XHjBjOOswUHhcLMx6YrPoa6mkGS67CVrM2SL3F8ddtfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=F3YSAOzp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="F3YSAOzp"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so22031155e9.1
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 23:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1786863319; x=1787468119; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8MlFAE89dEyHP879JePBDi2+i6NFCJ7ZsUV+zmtCqYo=;
        b=F3YSAOzp+WAn4HRa8At+q+cvoeGMvtUvemSRNjQMkyxlaQ2O+cpd2goMglN9zzrh8C
         caCMwQG923UZPs73VyOclMGl7ZnhV8KY9RYgLODnyN7CI94/HcDjdI5zCCVQNpR77yJT
         C5aIGrmHfPMuMkvVhy5VoPmY04LRv5WBRTnLEzYKQ029G70vYWk3EXbkkHN/RgNcQxCS
         bMoPV6gjPg4G4owu3cnkRDgwCxf20/7qJiplzyHIgQ0cgFrApK//a6oqqCWpB1eUeAON
         AaTrifzF/Gy7wonYBRH5KmAT2lKppTbL/6ZGXs3ecj9Ew0wnRAksoX/9BDb6xL1y664G
         O1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786863319; x=1787468119;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8MlFAE89dEyHP879JePBDi2+i6NFCJ7ZsUV+zmtCqYo=;
        b=HfI9b6rtN7YzTgsxe05cukmU1KpJDzMr1d6wD/tr5fGtxrYYcBl6VOqcJYTmCxEvax
         sovqsjBkShJLsXaTQcgOdF/4ZbP/A3qf2HJHiQdFLrZVLM6x5NEnt+F1zfir5M06Dc21
         4t25PIJOeBMp2F2SKrhEKmqm+NiMXcgqjEUaTS4Q5XelHLBK+6zGf2HSmRFXl27K00sT
         Iqx740e0HNayfK2Fyob0ZveoIjRpFwfXSzQMrUhbtfZbMb1Vry2G3AsZvx0S2OySdniy
         CBc3VvrjaR6uai3dqvPYqCKKsGgjmDM6yIGO/sJJn73q7uMW3adTm8xCUXZ9FXE+jQNK
         8UaA==
X-Gm-Message-State: AOJu0YxbvNkVIBspN9Lknae757l/4sQXymigigV2rmxgWprRW0jt+fsw
	A1PN5ynjM4pK3j4d5jidJoGpMn7/FU67vnox22ZT3cnd6xPWXjtBjOjTKZz9vkEIVfNH+H7NTfM
	DEt415TECjA==
X-Gm-Gg: AR+sD13TuBcdG+2b4UGdKRBbFY136RctOZy2yTvS/dJNBt86KWEVkTnzB3sO0wDILLx
	c1NMm2yxU7Z9HGBifc0PspJAB1Gqt5+dTYqm//z6UaCRp41ovbfiKKDb5C7/jF7/W3DpTk16Pw3
	vIuF0C0iJlVPEvCm7jExwBvFTgUg+SEebLNbdLmxnEeyFFRkDTDCYN+vkF0O9ewoL0enzTRJNhZ
	7Qd7dbCpYGHin6g5b2dgxLRQAtoce9QIdQXSGZqb/TFA+WXKjpLB9SFpRJinYQjO/wAeR840hVe
	b/gmiLFqZtAP03LUE9k014qEa9UsvS48CAilDC9ze6SfbkilG+qWbGsMJtbyrD+7QokFRWeUYJT
	3kZ7AdcjomzUacrPb2peLUB195PqLuCtjC5alXGKq3ouUB+xz2y++PwitRe0TTrzoSiFcCmt9gg
	J/JHhpdgE4hf5v3EH9L2Blr/5JcIuLcdk6RVGCPUFtNg9vV9zSOJ5XRcmoWAfvHc+5EHG6OsA7m
	UKQgI6JODhh6kwCN1SKz1SBt5M3C2MiR/31l1R9tWfo82eV7bOB99EizO2Uffj/DTi4CojVjyGc
	qtgZ+cVfm6czC60A6bb+eQ==
X-Received: by 2002:adf:e193:0:b0:47f:25db:8161 with SMTP id ffacd0b85a97d-48160763c02mr26506732f8f.28.1786863318795;
        Sat, 15 Aug 2026 23:55:18 -0700 (PDT)
Received: from smtpclient.apple (78-141-71-213.dynamic.orange.sk. [78.141.71.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2b1d9bsm21992046f8f.24.2026.08.15.23.55.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Aug 2026 23:55:17 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: [PATCH net v2 2/3] net: skbuff: don't skb_tx_error() the source skb
 in skb_zerocopy()
From: Norbert Szetei <norbert@doyensec.com>
In-Reply-To: <AD1B7BEE-C04C-4A1B-982C-8385F1908911@doyensec.com>
Date: Sun, 16 Aug 2026 08:55:06 +0200
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>,
 linux-kernel@vger.kernel.org,
 dev@openvswitch.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <807F55C4-1D4E-404F-9564-70639E931A26@doyensec.com>
References: <AD1B7BEE-C04C-4A1B-982C-8385F1908911@doyensec.com>
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.4)

skb_zerocopy() copies frags from @from into @to. On an
skb_orphan_frags() failure it calls skb_tx_error(@from), a destructive
operation on the source skb the copy helper does not own. That completes
@from's zerocopy uarg and clears SKBFL_ALL_ZEROCOPY, including the
SKBFL_SHARED_FRAG page-ownership marker.

Both callers already report the failure on their own drop path.
nfnetlink_queue does it at nla_put_failure, and Open vSwitch does it in
the flow-miss drop arm of ovs_dp_process_packet(), so nothing is lost by
dropping it here.

On Open vSwitch's OVS_ACTION_ATTR_USERSPACE path the skb is not freed on
this error: do_execute_actions() ignores output_userspace()'s return
value and, unless the upcall was the last action, keeps forwarding the
same skb through the flow's remaining actions. The uarg is completed
while that skb is still in flight, telling the producer its buffers are
free, and SKBFL_SHARED_FRAG is cleared on an skb the rest of the stack
still handles. That flag is what makes esp_input() call skb_cow_data()
instead of decrypting in place, so a later local ESP delivery can
decrypt over frags the skb does not own privately.

Leave error reporting to the callers.

Fixes: 36d5fe6a0007 ("core, nfqueue, openvswitch: Orphan frags in =
skb_zerocopy and handle errors")
Cc: stable@vger.kernel.org
Suggested-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/core/skbuff.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ba3dbac80fb4..db62ed6e04b9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3907,10 +3907,9 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff =
*from, int len, int hlen)
=20
 	skb_len_add(to, len + plen);
=20
-	if (unlikely(skb_orphan_frags(from, GFP_ATOMIC))) {
-		skb_tx_error(from);
+	if (unlikely(skb_orphan_frags(from, GFP_ATOMIC)))
 		return -ENOMEM;
-	}
+
 	skb_zerocopy_clone(to, from, GFP_ATOMIC);
=20
 	for (i =3D 0; i < skb_shinfo(from)->nr_frags; i++) {
--=20
2.55.0

