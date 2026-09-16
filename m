Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8034AF9EE
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789599843; cv=none; b=BbHM26AMrA5JWlM+NHF2aNXd65ABUxjPI1SxF4gfKKf555tax86+37CPN8QX4XFZdym1ucLkqiEP561ZgPzJrAyrfIFDrRi3cwIJj+YneWJ4asjMo8c/hU9SpV/TcB/TMNu8giUSh+/ssr9Z1ypvbEwrsrnQpUxZOwZHNFyXW+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789599843; c=relaxed/simple;
	bh=QeZNYTL+MpSWQLOHac0gVoD7DyVUG7n/UR0IvOmgj9w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QZsSOcPuCxGXV9ta979QWp537ftJgFN3bF1irFFr0FwM5uQ0Mgmb4H1n5pC6zJrqbTD0zTSY8XsROcRJ8fe9u4Aw/PLlIXmI3mXKNhhvBrmvV47EjWms2Sc1a6bFB8KaRoJJ7bts5DYzYOEtWLJDUwDZkJ/WmxiATorwxA7XzTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c7Tc670j; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c7Tc670j"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d55d8cd938so4155945ad.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789599835; x=1790204635; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Qa0+tdMzMPA6TuB846ZczAFkYoeCR4iw4k9gBu59oY=;
        b=c7Tc670jBFQELK2TzRoYPT+r/STN8Tkqt/l35HhY5radZd22ea2nf4oedsxvLJNQSE
         CJX+wnEe21hNfnXW0weoh9x2JEX3cYMuetS+ZOt0M/6FG7ek94e6jX5bb1iztqbS14im
         EdMLUaeOMTzbRQclUQSR9ObZM4xTpoYC/XJBtAxWtv0fI1uUWR+ZA3dH9D/MbuKszSMd
         dcKVgHGknUT55dHqC9RzORbnIIIjZIF9pqSGX+L2izQLgP9sdcTnFJf1F/C2JitrQmGY
         yDhEjRKkeQ0H9xUyVMT1Qgggq+8lBxHyDN/OQ1kIo8UpJwjOHiVtcVO5EBNsvEImX/wW
         O0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789599835; x=1790204635;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Qa0+tdMzMPA6TuB846ZczAFkYoeCR4iw4k9gBu59oY=;
        b=Y5hH8i82PXzg2NvZDzndA4fRmVPrx2TXXlQSbxzeX+SR0EKga0kOuy5lrXb88uStL6
         l4XblLGs8vOYUMyeKN9tIdWHggBxGaVcACyowdbvr9dNrd3K9z7Ydh/t1J5IL5p7SfLr
         VloNx44aBFDy/bMNacmaE3pCRM+6RIOH2+n0vnZ7/eyGZQ2woZLkvpbskXyEZzPSAbvp
         CDZ/RgeIfqKNqFt7SqmcqQMFDybhXEJ0ApA9gLxsIk8/npzFEKKk0M8lIvKa7RsBbGZC
         9TSCYgGrtitf3KrBWCHWjHSt6F9SqJpPOG7CG09Rvo9rf5moEJFNoehjX/phebUZ1XaE
         V8jg==
X-Forwarded-Encrypted: i=1; AKwUvBwKQx6E9CvkoH7RfQqZTVO6wmNiCIW/6phY5nwZSoSmv+f5FC7raUOH0VR6NXh4YGJv0QflzHA=@vger.kernel.org
X-Gm-Message-State: AFuF++lWgGsap82bOTTxxRaWga3aA1zVWyM43bH7VT2OlWUTNzow0j2G
	SdRzH7iebmHkC8PmO8FT8z/sK9wnBUssVCbHnhIo8sAweQn6QJEoK8hGrii5/MHzOixZsNwdP/G
	Xxlw7Vg==
X-Received: from plbiw7.prod.google.com ([2002:a17:903:447:b0:2dd:8c1d:5d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:faf:b0:2d9:51db:7eaa
 with SMTP id d9443c01a7336-2dd8e7a3bccmr88968485ad.20.1789599834896; Wed, 16
 Sep 2026 16:03:54 -0700 (PDT)
Date: Wed, 16 Sep 2026 23:02:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916230353.367014-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 0/6] ip6_gre: Support per-netns device unregistration.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patch 1 & 2 convert ip6gre_net.tunnels[][] to hlist as a prep.

Patch 3 & 4 unlink devices from ip6gre_net.tunnels[][] in
 ->dellink().

Patch 5 & 6 adds mutex and support per-netns device unregistration.


Kuniyuki Iwashima (6):
  ip6_gre: Initialise ign->tunnels_wc[0] before register_netdev().
  ip6_gre: Convert ip6gre_net.tunnels[][] to hlist.
  ip6_gre: Clear ign->fb_tunnel_dev in ip6gre_exit_rtnl_net().
  ip6_gre: Unlink ip6gre_tunnel_unlink() from ->dellink().
  ip6_gre: Protect ip6gre_net.tunnels[][] with mutex.
  ip6_gre: Support per-netns device unregistration.

 include/net/ip6_tunnel.h |   1 +
 net/ipv6/ip6_gre.c       | 268 +++++++++++++++++++++++++--------------
 2 files changed, 177 insertions(+), 92 deletions(-)

-- 
2.55.0.1082.g2b9226bbc0-goog

