Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE68C47AF61
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 20:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785874318; cv=none; b=ksKq0iiQ9lRxjHH8zxdu7T8FOu+KWLR18Ou+LvKMuoj7I9AZbSyVU/uKQ3doXgNt5qRaLDqA2HCIo5vR6K8Vj/iDin2ke7/p88BL7Zib4DzZ06nu2B5F8YSRN53EQMiuAGYt9UOhp0xt3cGD1DKKsh0b1V+ACA70JyK2taBMN2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785874318; c=relaxed/simple;
	bh=D5VOEQjUcgxGJV3YUdOgz0ueZlhARhxKU1C9Qnjncnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NfIt63/81iRROtEQhkqLPXnhKzSUx6T5dgm0vSQV1XTpIPtKrWOXveRyaFVZrPLNXBMys8bhxQV/JcAW7W9TKFflAVivlLPcERouwYCNWpuXYaSi1rW8SimX3GoHF24wkK2kUq5GUlrZE8M6XDVvMVFrFwqc+yb9InSTxw9qLf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSEjiaC5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSEjiaC5"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so1834175e9.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 13:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785874315; x=1786479115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JNGIDbwQT+Z5SX6USDQYc1Kl4Aa2uoNxfSsfqj3vOls=;
        b=eSEjiaC5aLQ4aAAJxcWOAPTH/09t8orsJeenz8F8qqUg+9+ADFUkFGRnx8m192aQWM
         +Rh+qGmU5cS4VQEVbcB3W2bM2zpAKcEhmgBnYHrAD9bh5+JDO4qIkb++KD842YLNJ7U7
         aPUabXCL9m62ClpywdFDji4/rxHYSdOepINv/YYLuYDa5EiTVZBvoHjQ+HgSioSne1Nz
         qne1a9z9QfTzSsheMDoja17WvUJfgj9Xf08IprIXBLllxxQdOAhKOQFGWh7BWM1n7CWE
         M6vasPHFu3bsyyTojgM6uZgvnJzxQcFukfFATOEWcx8cAIigEmlOklOIXFJW1rB7qM3F
         EAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785874315; x=1786479115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JNGIDbwQT+Z5SX6USDQYc1Kl4Aa2uoNxfSsfqj3vOls=;
        b=CvSuYUstPhW6PCCEqFPs0UdWM8KNLMcAgEgqb/BMSN0JY3O0q+cf9E+UpVmDlKHeUN
         +JgQOoQEIwXoeThdLKWewACrKyIyWxcT1IjIZbL1bwJfs+8rWLPNuGJ2eTbvQWYF011Z
         cTysaM5RVLHfWvRP6s8j6ORhOGmT3khCbXFyntrSjCAitvc/JC+dAl7jfGXYSGz+1Mqn
         K56XRXwn0EaZWHz2tsWQjFwQHBEWH7WoHHHzB8oerLGCBr2Wxt84Mj/R2yKitp/gkrcw
         e+AlnDu6JLSkJw6TvjYqWxdqe8w4cngoyxROKR1v9lCr/RmNHDCgii3CzKCT6N7EZFMh
         iNug==
X-Forwarded-Encrypted: i=1; AHgh+RoSWZA925j1SSP3uoiEC1ZU+D7FZ/HXuU8vVNx+3a2pgAlyiZLhfCOIyvMJMoejfNckxd1QaRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrS7soX5LJ8AxOlHdRdTgSWnJYDbMnhrKNLGgzjwDmmTGORtgR
	qb0TauUMV3D5sLnUcoyhJQFfz8LHaCdAn2LusiJa+SLEVd4UXPSuJv8F
X-Gm-Gg: AR+sD10nSiZ2KC6Vm33wPEh22VkbY5PJc3UWb0dMbA6WAzpUmlFn0tvdgzyyttepNri
	TWXujZq/Wr60iA8VXy1bz+UDdK+lKVe0qmrror3Ft+9wLDTzWqtax/7JTMLPZ8kz6atXCXZT6q9
	Re/MfEnTlwDRVfSqmQ6isKm+NLaKNMppeCn120+W0I/lOk9aKldBZJ+St3jWgULKs5+MOl2GTqr
	NxBnrIxAnk0r+NzZ9qeiLCy20j4zYHyfWDZVIH1ehKs7AXwbioj1KFR/OZfUzoHTft33N18TUMX
	nL02wHgKElIx4/xPzUjzZQ5bPMX3xylIhZTgZxJxQsyG+bN9kkV6PYr6x1hQX/b7F/e4CfOJUSi
	vYVw+lyP55XPMdgK125RORt6qOP7/GM/jfNIBbf1DyMyd/L2t7t7yJq6OPnpysMWR2INGIXW2H8
	oQc0AFQQXEO/qojgLhrQGpbQlc73aOhgc1EPqyTq9axGeYJMzoZbFxYWPLywhejkarrWhFxC0eC
	da/5cjLUOp3vbah/0cy+QCFaIIoLtel6hUAeyi4fjtkLOnwKWKXiBwFolFM/2ZJZqO2MGSbuAiq
	L7z0VVRkAN4mlMeMl912jgQ4tpXoU6whi3MMm1C6tow=
X-Received: by 2002:a05:600c:37c9:b0:495:4b24:1b64 with SMTP id 5b1f17b1804b1-4994e6eacc1mr13592935e9.0.1785874314990;
        Tue, 04 Aug 2026 13:11:54 -0700 (PDT)
Received: from thpalex.rd.francetelecom.fr (2a01cb08943588009f8850ffc9c1993c.ipv6.abo.wanadoo.fr. [2a01:cb08:9435:8800:9f88:50ff:c9c1:993c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e0356d4sm25752775e9.10.2026.08.04.13.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 13:11:54 -0700 (PDT)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
To: coreteam@netfilter.org,
	netfilter-devel@vger.kernel.org
Cc: edumazet@google.com,
	alexandre.ferrieux@orange.com,
	netdev@vger.kernel.org
Subject: [PATCH net] netfilter: nf_dup_netdev: scrub duplicates to preserve the direct path
Date: Tue,  4 Aug 2026 22:11:50 +0200
Message-ID: <20260804201150.16364-1-alexandre.ferrieux@orange.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nftables 'dup' action clones the skb with its full glory of
metadata, including references to its destination and conntrack
information. As a consequence, a link failure on the duplicate's
egress path ends up doing the same as it would for the direct path,
for example invalidating the original packet's destination, which
typically breaks all TCP connections to that address.

In other words, the "dup" path has the potential to wreak havoc
in the direct path as a consequence of secondary link failures. This
is very bad behavior for a monitoring tool, which is the most
obvious application of 'dup'.

This patch fixes all similar scenarii by calling skb_scrub_pkt()
on the clone, severing its link to precious direct-path state.

Note: the second argument of skb_scrub_pkt(), the boolean "packet
is crossing netns", is intentionally set to 'false', as a 'true'
involves exaggerate scrubbing, e.g. of the timestamp, which a
monitoring 'dup' typically wants to preserve.

Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
---
 net/netfilter/nf_dup_netdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_dup_netdev.c b/net/netfilter/nf_dup_netdev.c
index c6bd5c29bed6..0f47a2135955 100644
--- a/net/netfilter/nf_dup_netdev.c
+++ b/net/netfilter/nf_dup_netdev.c
@@ -63,8 +63,10 @@ void nf_dup_netdev_egress(const struct nft_pktinfo *pkt, int oif)
 		return;
 
 	skb = skb_clone(pkt->skb, GFP_ATOMIC);
-	if (skb)
+	if (skb) {
+		skb_scrub_packet(skb, false);
 		nf_do_netdev_egress(skb, dev, nft_hook(pkt));
+	}
 }
 EXPORT_SYMBOL_GPL(nf_dup_netdev_egress);
 
-- 
2.47.3

