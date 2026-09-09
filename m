Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1913D904C
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 23:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788997467; cv=none; b=QPRhJoZT8VULZJoUXT2Q9ZfbaZqam5szdLRNRZpuZy+d+ZFT18Dmpy5aMUwps9k0qykIT7+z5sp8XqYUs6AfUuwq//t9v2mgde+8qWnerYIreqpnh85D1iSy/Lg4jYAupVb00du/KSvZbYtIjyTKR06NYOIoMV5OK7a48S23Tio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788997467; c=relaxed/simple;
	bh=1eXPsTNYVM5qQ5KNN+fG6c0lvQIs0xtvuUndT+F8I6Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lJtrY21wBVon5xoqCHagCTmEbwUKWYuKgoaiQ2BwdhDOZierSZSIgtuc4vrYi66T5p8U/XlPRb+kSYX5BpsXmF1VsO+6ItZ2E8cxKq0I/9G0Ps1YQQiSZJpJbvwyhXc94gKkGYTu3PqKrzhI78fV5WFFzTeAatlAbpLW9ybqRp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sz31HNh5; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sz31HNh5"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc42a07d04aso6975130a12.1
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 16:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788997466; x=1789602266; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1MFRngc/SCkLOCcscCrQUuAZZ/k/qiFhD2yx16c4ZyU=;
        b=Sz31HNh5hqn80BmS+50aWxY1AgnpqfQ9hnmxl+XdZiMdxpO4J9cOFENBrJu+Khxd1X
         qUJYnW05TDfxZfoiSowRlb5tueEhbUMBnDgoC0hWIAikBSVxo3IByojxhhaZyVZ1DsQZ
         aObWt0QVGJwV0ikO9ozuhHxADQYmXXf5T6LGm2ARZQSbdR+3y8hDOu0JFStJZaBGJkZS
         Ko4aCRySNY19IPSCkzZXoUT1C6fGCWgTuLCrT4rio6je4OSlNdMfuSyyTW06VVNE1T0S
         i3k0B38PHRKH6UAQre2d3lXd2qTZNOn+tShdG7ONlTqS+aUlb7u4Hae93XkF8QF9I5Rk
         GyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788997466; x=1789602266;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1MFRngc/SCkLOCcscCrQUuAZZ/k/qiFhD2yx16c4ZyU=;
        b=WZsagAos4kKaiy0plx6UCh9l1gqEn1YPEBhkaPuhr/sVIH74yIvCtc4cGp+/kCXSAH
         tY29tYCN3qZb3EVjjLvrAmYJKzs/m0qp07mg+U4Kx7knaP4OLlz2I6wC4CkkSl7OcIhY
         xX+GTYgel9tj/WvDRi96Qugthx9xglsruMXhIJH1GPhMCiE3W3KNGnNqc63RGO/aGjnp
         J333hrxtpvuD8vcRivZzsu6YbtsU6ZM09ZW8bPWBtW00AErKtfgSGDeQsJhyStJGxC5g
         MbId9CtwX3KgUNgkXTI88ciwZWdC7bJW9s1twG1YqeaqQeLRpFKG1XnbPf25UCnffB/J
         dV8g==
X-Forwarded-Encrypted: i=1; AKwUvByNrN5gUjYUNd5l2KSHLyOVAZ76yb+NsrNRD80+HJUU3N++p5rq/PCGL3XLMil4rL+F11Demw0=@vger.kernel.org
X-Gm-Message-State: AFuF++mLvibJr/A+AwM4dfDscFRVmwCLh/ZYo0OzxnWigFg7kj3+sHeS
	jSj4h9O8qAOHS7DHMaW49mummyCsj7mn3uDGJEMNEKNrPjLMxurZCu4Vwmmcmro1GwPv8PjDtUL
	3PBr1Iw==
X-Received: from pgmk28.prod.google.com ([2002:a63:5a5c:0:b0:cc1:4e93:a6fe])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a92:b0:3d3:b00b:26e8
 with SMTP id adf61e73a8af0-3da3a17ede3mr66424607637.28.1788997465647; Wed, 09
 Sep 2026 16:44:25 -0700 (PDT)
Date: Wed,  9 Sep 2026 23:43:43 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260909234422.2416506-1-kuniyu@google.com>
Subject: [PATCH v2 net-next 0/7] ip_tunnel: Support per-netns device unregistration.
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


Changes:
  v2:
    * Patch 1
      * Correct commit message; ip_tunnel_uninit() unlinks
        DVMRP device, instead of ->dellink()
    * Patch 7
      * Check if (!itn->fb_tunnel_dev) in ip_tunnel_ctl().

  v1: https://lore.kernel.org/netdev/20260907225846.3787676-1-kuniyu@google.com/


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
 net/ipv4/ip_tunnel.c     | 132 +++++++++++++++++++++++++++------------
 net/ipv4/ip_vti.c        |   2 +-
 net/ipv4/ipip.c          |   2 +-
 net/ipv4/ipmr.c          |  12 +++-
 6 files changed, 108 insertions(+), 48 deletions(-)

-- 
2.55.0.1003.g10538fe699-goog

