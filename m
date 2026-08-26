Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF91937F322
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740637; cv=none; b=iwBDrQYJS3wAQDCbuaEAkcAPwUki/yFaj2Rqcrc3bbudeqpvJPOwroZrWJlNfXX2/RGJ09hRMMCU+APAFAD4MxxFmuRimgeDwdTILGAljznJ/xVUEIKni7OW7N16znzji6HGT3zoC5LX7Z/IOhCk5o0BoqMez+9ehvsknoY/qH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740637; c=relaxed/simple;
	bh=ebbMoevaLu/dMp7zBThJwBzLB1QcoVPoSIYt6lHSE0A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kBfr97pZUEnCRb42maUSvxSaOUZv22jKHi9Jteoi7c4S07evFZITzCEC08ek5Ol/EvFub7QlECuQi4LIzrN5Ao19InyvzCLzuyGJpQVXS9JnhKMIKQVnyhD3Zae5JhsdQ+BcCBWhZFiZIhjcus+UbUM24R13sfscf/V4QfExEt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ByNNiW2M; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ByNNiW2M"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e52306621so69273385a.1
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 03:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787740634; x=1788345434; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ta4zoCVktnAVDYiQmQs9XnP7VseaL3z2ZmITKdFhRyo=;
        b=ByNNiW2MTOv8HHzE0oPDQ6rNQ/GMEp7Z3b7nRHoHRVqrb7jk4P9/pVkxE4EiPHP0n+
         St4bnvZYxzdNjEBUD98fJDmGeAc/pTnlNllGb8Jo0hOGMJ81B+iQhZjEa59O/A3pTA15
         gDsIExdz+R0kWl9DivfaQlMuqNqBNq2+gt18fgKcmJQxfTIX8+JPEmzvDOOwyHMIVQos
         FZv3jWxPZgZ1xcq9WSq/DpAkvO42kujqcj7F2O29eyMEVBPBYycHjRxdjptZJaeIIc2h
         BleDwddtMdD6erKm3qeJ8jMHX6plfGXlG4vzASUb2rWyY8mfTY7g0nPFkSi+drsVMP7i
         ydAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787740634; x=1788345434;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ta4zoCVktnAVDYiQmQs9XnP7VseaL3z2ZmITKdFhRyo=;
        b=bYbrlpICvg+UajsfZqcdaSB/WLE5w9iDrYPOSuynonoSXlRHmAKo8+hCWFj18iXvhG
         WDLmZqLd8z+TbQ4p/DB6T00vtbIWrqOXz6el022Be0wOjh75xefb+yOBeBRkScXrHQNb
         AC44x1l+aueugIE3O6XVuS5uBSUVrtn3Kty311Wi1XggxziHQDCUMuUXW26z98KfImyL
         nE30nV5sJ9IKeoPEzWHcRTKTme8W/2S4odWI42OX8s23AQwGu0oEqKzIEQ6axiXje9vY
         RUQMBeCvsJBlFr1ukWpQrlKRgvd3wOmcrD2tR4Bz3Kr5USSCnyDfCNZg0OrCzgEZ68ZJ
         Ue2A==
X-Forwarded-Encrypted: i=1; AHgh+RqskK1A4jWPoDhV3C4TdH143Sg9zK2TVB4U0ine/IuvH/Ci9m5I14CAQmx50cHXw5ALCm9JjLk=@vger.kernel.org
X-Gm-Message-State: AFuF++lgbAy+HgCRMHD3LWFE3pMRn5SWfxRGnPc2eFdr1yk24S02yPhI
	lU+lKOVNp8nlCyqyX96gobSH2PVEhphpDyn91Uu+tOoWZj8juhZw47OJZEdomvDewjqthnj8zHs
	vfY9iMthlREDGXA==
X-Received: from qkjx16.prod.google.com ([2002:a05:620a:14b0:b0:92e:5c93:7d3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:198c:b0:937:80a9:94b4 with SMTP id af79cd13be357-93780a999f0mr473281385a.2.1787740634044;
 Wed, 26 Aug 2026 03:37:14 -0700 (PDT)
Date: Wed, 26 Aug 2026 10:37:07 +0000
In-Reply-To: <20260826103711.3302915-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826103711.3302915-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260826103711.3302915-2-edumazet@google.com>
Subject: [PATCH net 1/5] ipv6: mcast: fix RCU list diversion in ip6_mc_del1_src()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Taehee Yoo <ap420073@gmail.com>
Content-Type: text/plain; charset="UTF-8"

When removing a source filter whose count reaches zero, ip6_mc_del1_src()
unlinks psf from pmc->mca_sources. If the filter was previously active,
the code moved psf directly into pmc->mca_tomb by updating psf->sf_next.

Because pmc->mca_sources is traversed locklessly under RCU (e.g. by
ipv6_chk_mcast_addr()), mutating psf->sf_next before a grace period
elapses diverts concurrent readers to the tombstone list. Consequently,
readers miss remaining active sources in pmc->mca_sources and improperly
examine deleted tombstone entries.

Fix this by allocating a new tombstone node for pmc->mca_tomb (as done
in sf_setstate()) and retiring the original psf via kfree_rcu().

Fixes: 4b200e398953 ("mld: convert ip6_sf_list to RCU")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Taehee Yoo <ap420073@gmail.com>
---
 net/ipv6/mcast.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index aaba4c2aae23ef378e6328e6eee880ee1e52a76b..ec7fac511c8d50da7125ff1c4cd23af46875791d 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -2351,14 +2351,18 @@ static int ip6_mc_del1_src(struct ifmcaddr6 *pmc, int sfmode,
 
 		if (psf->sf_oldin && !(pmc->mca_flags & MAF_NOREPORT) &&
 		    !mld_in_v1_mode(idev)) {
-			psf->sf_crcount = idev->mc_qrv;
-			rcu_assign_pointer(psf->sf_next,
-					   mc_dereference(pmc->mca_tomb, idev));
-			rcu_assign_pointer(pmc->mca_tomb, psf);
-			rv = 1;
-		} else {
-			kfree_rcu(psf, rcu);
+			struct ip6_sf_list *dpsf = kmalloc_obj(*dpsf);
+
+			if (dpsf) {
+				*dpsf = *psf;
+				dpsf->sf_crcount = idev->mc_qrv;
+				rcu_assign_pointer(dpsf->sf_next,
+						   mc_dereference(pmc->mca_tomb, idev));
+				rcu_assign_pointer(pmc->mca_tomb, dpsf);
+				rv = 1;
+			}
 		}
+		kfree_rcu(psf, rcu);
 	}
 	return rv;
 }
-- 
2.55.0.860.g4b6b3295ed-goog

