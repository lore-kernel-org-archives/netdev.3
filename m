Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F66336884
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 22:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788821935; cv=none; b=b32mwOAzAZclNs7hHqzUcwxM1MD7/rOfr1MxJRFjK7S24OhIJzkZ9VpnAsmnixcjtpcTn3FfdHT1UIjsSQrxrFXAthO3iv300VHvnCxoAHjpMFDwSZwUgfAOypmIfrSvYCdGF5zABLxPBSNIayrKR51uKXgC1uIrq3kVMPS9XoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788821935; c=relaxed/simple;
	bh=O1wRdOK/4FV/s60XoKZi4nQynGL+G+aK0jn00MdKTNU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=U3bpG61gREVd7M3ZwHCjs3R2b9iLPJwyIhEjniOG+hD+WlffqdWjxWm/aX/j6CUkycYQgC/E2a7PzaqZ8KaPGG0Egdcm4DKh/MCoP5X3nmfOYyQfoCHjcYWuSP+lOPouOpFitj2pu3yBg2uV1j1v7UdU2z1Yo6v6VdDfW7MR8oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UAynYC4q; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UAynYC4q"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f5ac7416eso4754586a91.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 15:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788821934; x=1789426734; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RDK7pyNygcWJr0LsujOFGCPe6Vs8aQ6Fi0qEXMAYmMY=;
        b=UAynYC4qwg8jtqirAt9ZJZeXzbB1nToIMZES0XvOx6pDiDRMWbiMe8pZpcBmvkP58z
         osrwHuF5qyd7+oQeoC6RBb6mS4xFp9KSyBZmViu7LCcooqyXTrqIZhU5jrl9khOwjAob
         QfkkCbDVueVWMivkhdeC+0DWMoMELLVoD/Ft9FybaxUu8glmgxWvJpx/22rRnQt1qtBi
         IWjcg8gHgIHNT7PucGngZWV3smnZO9Zio1u//aTTosQXBhn2b1asV1N7NeUHhsf/7zPI
         Jw5GgMBqJrFVcf8R7mnfNem2DHURITwUbeHCDXIGydHXj2RgiEVj8kLn+5GsqoxT1LsX
         qV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788821934; x=1789426734;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RDK7pyNygcWJr0LsujOFGCPe6Vs8aQ6Fi0qEXMAYmMY=;
        b=r2lDNsyOQIg3lnfcgVqRoSO2L6U0F4nq/+Wkb5kFVXd9wB+PwKTEVUObxMnKDzZzCi
         nkJF43urp5mL9uhZ87g5GetonQAJI9+3kH0wqKxv/P6T0pz/EPLZJlqjF2/Zy4/MCGzZ
         w8Jbu9KVdKjY4/HKW46LaHcEO6SC2Ar22hsa5oqhYTS3+Rp2A3eZdX6R0J8ifrsbFI22
         ypUTO/9+jfSSorRUGwEklOILo3+OgvadIxx5AWW9FMsqn8bodO6xqCQKt848hS5pLjas
         As8c4dAs9O+FVeQ32sP6yJqZ6iMVvYaIkE8SmGZjUE80OXMHc+kI12RJulC8bg9/JINN
         l3tg==
X-Forwarded-Encrypted: i=1; AKwUvBw7LeSAVeKPYQmfkPhKmXWOJSg0/7HJpu1ugpMPJxeLPX8Wk9r+liE10s7LvqLP9owNuAvegqM=@vger.kernel.org
X-Gm-Message-State: AFuF++l94lWrsFiDhxJKJVxdiJgE/IVzmVTaFpeuVc8D7hx5hcxuSam+
	sCRGykq+ARnqgH+dj7e2Z6j3cKlj7u/HtJO/d4rWVntqK51ItnT8DIUG1FQojnqfUKX08TrMPDY
	iBNrmlg==
X-Received: from pjbfa9.prod.google.com ([2002:a17:90a:f0c9:b0:39b:7c8f:db9f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1643:b0:380:21b7:e727
 with SMTP id 98e67ed59e1d1-39b26272f04mr36866808a91.14.1788821933816; Mon, 07
 Sep 2026 15:58:53 -0700 (PDT)
Date: Mon,  7 Sep 2026 22:56:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260907225846.3787676-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 0/7] ip_tunnel: Support per-netns device unregistration.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patch 1 - 3 are prep patches to unlink ip_tunnel device from
the hash table in ip_tunnel_dellink() only.

Patch 4 removes ip_tunnel_del() from ip_tunnel_uninit() to
ip_tunnel_dellink().

Patch 5 & 6 adds mutex to protect the per-netns hash table.

Patch 7 uses unregister_netdevice_queue_net() to support
cross-netns device unregistration.


Kuniyuki Iwashima (7):
  ipmr: Call ->dellink() to remove DVMRP tunnel device.
  ip_tunnel: Set itn->fb_tunnel_dev to NULL in ip_tunnel_delete_net().
  ip_tunnel: Don't pass rtnl_link_ops to ip_tunnel_delete_net().
  ip_tunnel: Centralise ip_tunnel_del() to ip_tunnel_dellink().
  ip_tunnel: Unify error paths in ip_tunnel_newlink() and
    ip_tunnel_changelink().
  ip_tunnel: Protect ip_tunnel_net.tunnels[] with mutex.
  ip_tunnel: Support per-netns device unregistration.

 include/net/ip_tunnels.h |   2 +-
 net/ipv4/ip_gre.c        |   6 +-
 net/ipv4/ip_tunnel.c     | 127 +++++++++++++++++++++++++++------------
 net/ipv4/ip_vti.c        |   2 +-
 net/ipv4/ipip.c          |   2 +-
 net/ipv4/ipmr.c          |  12 +++-
 6 files changed, 103 insertions(+), 48 deletions(-)

-- 
2.55.0.1003.g10538fe699-goog

