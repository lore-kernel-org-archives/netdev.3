Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866554AF9D4
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 19:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791227558; cv=none; b=KiQ1kwPqIBhZ3y02hLcOYCdOJUkbx0GeOo433aFjb33fw7WOsKTH9WBxPU9O3hqHbTfJGnzcEMqFqTIyBPxVxDZtCK1slaz9Bz6/753Dws6fA0DLJeHjStJ7cTJMoZU/6hhlSoRZxD9YehyBcVwgYecHyP+yRWuyx+qF9DnIdkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791227558; c=relaxed/simple;
	bh=bGuH6rALRBK+sbzj2wBftT7BD2By1a2L0HSgmfvzPt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aBC/ACnkUzjgADJqEVX5QknqEMCoMhlImIqmStbiYDy0Skg3gNDpGGb+tnFmn8Gq8jjWOU3IYwNcmhkRyXioi2lw3BmP/7bQerAu5vOC4ndNmE6EW5Zl7rj+nuUfsfAfoxcx6y6daTY1KbZAoOYbX5FM8yH7s+VuEeO2kPl1Ezc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RELXIVWr; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RELXIVWr"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3a75f960be3so25813281fa.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 12:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791227555; x=1791832355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g3eN2HBqV1SkLIMIkDb0JiBM6JPfW8s3nutw0XArY0U=;
        b=RELXIVWr8gUb18KfvtKZYf8gj/qL46h7GFKNOCUU5wyPmxGnuK09M9G+s9KD+qHfku
         f3Df9ukjDGyavrsyDwH82XVsd8e+G0/aekHU/oEupcICwOeq71cLIHdSGM+qOgl4GE/r
         BpPnlOmR79sUkAmqIX1DnUWbDcdY34G+y7m/7HlsIgjWfrwKz3wnGmH5vF8gv9KT7JTG
         R0fjmKcEW8RRyt4QudI6ZYALFIH2MFpRWoqf5VA2G9weMnrewOW1DwHecozeqG0XMW8q
         jlw2OoLsa8xpz64xC3/nLRAEtzkrghNCTuBRQHRwKwOKwAayi7mxNvj9WQC6BU1HXHAy
         WQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791227555; x=1791832355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g3eN2HBqV1SkLIMIkDb0JiBM6JPfW8s3nutw0XArY0U=;
        b=KguFC2XkIFFJ6noim7bXemO91gAR8YrI4g3NGJZhZLWfpRUeLRWbl3jRrDW3b6ZOn2
         9KceuTaDSuVazCNL+oQSP6R4ZraxuyWPNAcKqNd9oaiWbbE81GXqt7Jm/LiAaljMOvjY
         R8UxvNg8JyZ8SLMV+QcFEMh70PLsxnrFdrGSBGvv0V+OztfKPeFQ/ZYIwq8AR1Sn70Q6
         O20ow3KSx8Z9ZNrlV16rFHvMnVxxbSO3vG2agnIk/hL+xCc33W/gN07mBfkm4U7ZGgv5
         6+Z3DxPR8/ltLkpYL0wlHlwNBVcm7y5i+IMvzmmEortX53HX3o3Pmq9T197O5KcqmOci
         1tFw==
X-Gm-Message-State: AFq9FYJaPCZB9JVKSltID7SbmEdg0eIUdK+os5wPG4Tjrbzrq46NX1/t
	gN56CZ+WuFhltwDeZJWpy0XSdmQpaEQJwjjNX11ZtGo+n2Nt5vF+pLFYBwBIDhe5
X-Gm-Gg: AYBFou3YqjDc9qLhnnGC0N9b6FJz/b9ZJtsOhs+lyNPjK52YVUSiHgyf0ohRjmbRc0v
	yUccoBl9h1D4lsPSJvFy5+p2/0KYqeq8ID6wkRO6SOMm+3gnvpnuj6zrR4PLwfODz2Yey7D9aHT
	Yq9DmjKQHFg9XNk73LNMo4OhiAZOCVIaEGa/rQ/tCRvdpRpI4Ye/JkPYYHj/VQ0mqhu75k1dvoc
	U8oHEhxbn6VZfJ+pu8/jB2RyQ6rWy/29Oqu+9z+/VUhSF/89riSxgkb+RBPHaeL5rU1oIRy3WU2
	6bRxwSArssw+Qk8PDMq4quV8+EQv9bAGlqw4wOROtk+aHpO63U0gwb0yjaeXneC8iqUgV/5fUo1
	behYgZfiro3sNbJgfK2LKkj1GkUbpoXVlBxgWhoe84jjqMb1sDe2QZ8iBlcluJalhhpR9gM8hPj
	aSG3mgu3idk/3fhkbMjLlSgi+i132Vofn2IyjzCsWjNlgme+xRDCwH9BV5DtZk2R8m3GD08LkVG
	INOZye2t8qC/DEZcMkIHT7TFyKkxi4lVA0KtfgmBg==
X-Received: by 2002:a05:651c:b2b:b0:3a7:67ae:1a52 with SMTP id 38308e7fff4ca-3a974dd0abcmr22579581fa.0.1791227554356;
        Mon, 05 Oct 2026 12:12:34 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.161.1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a87e2f81ffsm44107661fa.7.2026.10.05.12.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 12:12:33 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	William Tu <u9012063@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] ip6_gre: let collect_md ip6gretap send from the unspecified address
Date: Mon,  5 Oct 2026 22:12:27 +0300
Message-ID: <20261005191227.894665-1-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip6gre_xmit_ipv6() drops an IPv6 packet whose source address equals the
tunnel remote, to avoid a trivial tunneling loop. On a collect_md
ip6gretap device t->parms.raddr is not the exit point: the outer
destination comes from the per-packet tunnel metadata. Such devices are
normally created without a remote, so raddr is ::, and the check never
matches a real tunnel endpoint. It matches every frame sent from the
unspecified address instead.

On an L2 tunnel those frames are regular link traffic. Duplicate Address
Detection sends its Neighbor Solicitations from :: (RFC 4862, section
5.4.2), and MLD reports are sent from :: while an interface has no
link-local address yet (RFC 3590, section 4). Frames bridged into a
collect_md ip6gretap device, e.g. with tc tunnel_key and mirred, are
dropped even though they carry valid metadata, so DAD cannot detect a
duplicate address on the other side of the tunnel.

Skip the check for collect_md devices of type ARPHRD_ETHER. It stays for
L3 ip6gre, where sending a packet with an unspecified source means
forwarding it (RFC 4291, section 2.5.2), and for ip6gretap without
collect_md. ip6erspan does not run this check in collect_md mode either.

Fixes: 6712abc168eb ("ip6_gre: add ip6 gre and gretap collect_md mode")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>

---
 net/ipv6/ip6_gre.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index e61cb10b50dc..ba1ed459ee79 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -831,7 +831,12 @@ static inline int ip6gre_xmit_ipv6(struct sk_buff *skb, struct net_device *dev)
 	__u32 mtu;
 	int err;
 
-	if (ipv6_addr_equal(&t->parms.raddr, &ipv6h->saddr))
+	/* The outer destination of a collect_md tunnel comes from the
+	 * metadata, so raddr is not its exit point, and hosts on the link
+	 * bridged into an L2 one do send from :: (DAD, early MLD).
+	 */
+	if (!(t->parms.collect_md && dev->type == ARPHRD_ETHER) &&
+	    ipv6_addr_equal(&t->parms.raddr, &ipv6h->saddr))
 		return -1;
 
 	if (!t->parms.collect_md &&
-- 
2.47.3

