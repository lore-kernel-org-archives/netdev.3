Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6643BE175
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 04:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790137237; cv=pass; b=XqA2X9BifWwpXdu7ig9rkp9B8RG/m86Bccext75n04xDtKgg7teK0FEBQUECe10kmpMCAuVTjmJwQeBzZXviwowk8lQ6C2m3+lSOR2YMG97WnpTAMkduN+8swW2AADAGjM3dBJXaD5TtU5zzw88aIvh6ElJRx1LvXpthqMedr8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790137237; c=relaxed/simple;
	bh=Cwfh6nfa/UOLSAK3QY/khC+MQR1CKVHT9WrzBxS+zXE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XeITAvwnN8mMTiiVWiLzaRKUcjVd7hFqvbfWNHEnGEs5OcldIdz+8p042cwYH2b2xh3PJ05PjKQzV3k2+U8m3A0o7uXfVR75cKmCcdchvmTqob3okV0gMc4h1OFORzE6dWNzMg+gg4E+7CIXafvPSmNY6fsNsil6TCmynlXksHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjecdJLG; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjecdJLG"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9ab2a135dso731402a12.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 21:20:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790137234; cv=none;
        d=google.com; s=arc-20260327;
        b=PiPVpzYgCAXFiAdS+/NKZPOcXLJ/zOEbU22PHG/BMDcKRLlkkux4laJIdsB7d7APnB
         sYN/eFg6DbcJndBYk5U1gSU/hvZ6I84+begItx6wgEHNFeoa3aWHPi/Bnh1oauviLw7T
         U4sfVy64ZqVHoo72+OtektnRpELEdZbfNQOlbjb8MqaIqFQGza4GJq/1QOKx5jBCP45B
         P26HYNZ/ZkIcebY9yZ2b1gJsodvQ0gwrO6JzsoK8mQp8WqoRqu4kWRMtQC+YbQ7pPgZ7
         i0ZGtX82fYNzyS8mPGhO3cX9GD+0LWqNLBcc8p+eKA7VwDJ6tBTsw7zk7hkfgK/LoXPI
         Wd6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=hxbmvmkdJ5bEpGwujnz7ixCTU04WOXkGt5rmGXxVVrk=;
        fh=iJZqS6VDfPlXCD0GJaLtQ8SXKW1iEbzOlYeU3ZOPqKk=;
        b=DdTsZDUaE8czwa/S2io1YgYxk8mSqFABbaY2V0vbhg8nEk6k8/9k0jbAyhTnavUWPH
         pibAmqc0tyyd9EqsP615dYw5DfAYzCHu/BQ+KcZLcclpmS+f9MfvuJU+0ONO0HDZRCkA
         SA0gUprYuA5UoYFiFKE7QkcpAOyxkkQzaL+jMuIZQMXDKiYCYYJOmorfZ9TvNKKm+tFD
         sp4nudSmOe44H+SILOH/jCQvlsS+3SCqqA6if985O2agHSO88aOIsIdZMTUS1BYBNrE0
         ybhh/JOLuCYrjswbEjCOjeVbYQBEv9J5elogr97unffx8OW9kBNxKzCvL8yD/vk03JjT
         O/zA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790137234; x=1790742034; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hxbmvmkdJ5bEpGwujnz7ixCTU04WOXkGt5rmGXxVVrk=;
        b=OjecdJLGniwn5ixF3L7m25rBu/x3lyzCN1jN7BNAas8lsSMvHxhhtk7vaeqIZsdibw
         yLyz2Lty3JGbGBCtgEW8Mkq91YrIrEw5+TzzKgixyUccV5cR70ds2HPgssnMc8Vh5F3G
         ltH0zR2n3iisQCLbJ5fxIC5TILhIbGokglBakR0Zzd4vH6A9Yc4xYPIJCdP5xv1ju/pC
         2Qq4S6Zv7FPXRJaSnS91b5tTGoUUWHeuSLhZkI70iXkoQYbaNfK5lAi/4nd74bSjWuoe
         HLMkXWVDbwginrskGF5mfAFcDTPlLhl1Eh2dfg+7fh+zjwPlqWpK7nkyv9uLHr5wbTCV
         9dEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790137234; x=1790742034;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hxbmvmkdJ5bEpGwujnz7ixCTU04WOXkGt5rmGXxVVrk=;
        b=SIcre4+nJoHylfxeLE2uOwGBDmIPJxCiV5wp1xsTg/NFbiphGW1tD58HwlQMbKJdAf
         KCDI2lMvrvxIaLguUJz9i+S3HVtGFYOwHo9Imh2zTY4S7KpLdbGvEuFSaJzSPEcoVhFt
         Wsn/hjvn9P0jgSwnAbNegJPl2oiVdru7qcAbfQ054iOSaH0+gIQmdoNMQw9FOOtOJSnp
         khVNBlOlOXcdV7ZuzRgQmWZ7m0fAQOUYhcaNbhaCWCDjYv1g5TURq+tYWUnyuCCiztee
         Zsy6vN1z1pLylNh7PM5EdKB/T9I8mc0J7heAT6xQQRwWHt0rMFQKnBI7POlHi2QJMvnq
         lwCQ==
X-Forwarded-Encrypted: i=1; AKwUvBxlVvweuyuhCPmV/sg6WvTZKmi63qYPPFLXuChpj2+hAQv4a26D91nevg9C6gKC97PIswrkpQc=@vger.kernel.org
X-Gm-Message-State: AFuF++nN6LxEv4Ge93oJ2M08CJgLQFWqURUMhgn9N3dT/QKkkprXXdBL
	zoMfYFnHQpMohRCNsJVHg0cvk0AYw9Ql4W9D/hQZpHnmj4U2UYYTfR+Z6myw2n0AFc722pNIMID
	wNNszo+9XQMQjdSla+vELn7Xg5lBg4kY=
X-Gm-Gg: AYBFou3iHtjllYdWxNhNXudn5oJoupZoawQo1k9Li8+lqs68l9AUMwW406PIoJSJIXo
	sr2oM5bRpySQRzQL48ZgKeTqSC+RmQwrbhOQfwZS9ilvtm/xgF81S7aoRdI/LDj/uzguj8zJJ8A
	hgaBmHsxOHWpRrPz+U1sEmdCxc5In+J9AWlj95KWEtgnbgl4WJyy/Vq7UY1616VNd5Fuzk+rPt0
	yqKzn7mR01GrpDz4im+RHLFBU16+WGopi2Ff1NYYP8CJ55Y63vvclylQ5YLpvKI8nZI7MMAZk7O
	+j/I/litUO+wRYUFbos8mSczV5yX+1x8oAQpjuTqnqTF7UOB/nhuHhJ6
X-Received: by 2002:a05:6402:3222:b0:69a:928:9405 with SMTP id
 4fb4d7f45d1cf-6aab3af7ef2mr1139431a12.1.1790137233714; Tue, 22 Sep 2026
 21:20:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Subham Pal <subhampal789@gmail.com>
Date: Wed, 23 Sep 2026 09:50:22 +0530
X-Gm-Features: AcwNN1WXi-EB5cWWmSS8F_wi0QtWAsORHAgh7vtdg2rXyF8E9Vr6ZcKlLvthKgQ
Message-ID: <CAHeizqHDqx3ue1=0QL92ef+6C63Ur+v1Z=d93smgdD5zTj_-Pw@mail.gmail.com>
Subject: [PATCH net 0/2] netfilter: nf_conntrack_h323: fixes for NAT bypass
 and ASN.1 decode
To: pablo@netfilter.org, fw@strlen.de
Cc: phil@nwl.cc, kaber@trash.net, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series resolves two separate issues in the Netfilter H.323 helper:

1. Overly restrictive tuple comparisons across expectation helpers
   (expect_h245, expect_rtp_rtcp, expect_t120, expect_callforwarding)
   that bypass NAT payload mangling under DNAT, hairpin routing, and
   reverse/reply traffic directions.
2. An ASN.1 PER decoding bug in decode_seq() where absent extension fields
   are processed before verifying their presence in the extension bitmap,
   leading to packet bitstream desynchronization or premature aborts.

Subham Pal (2):
  netfilter: nf_conntrack_h323: do not bypass NAT helpers when tuple
    source matches reply destination
  netfilter: nf_conntrack_h323: check extension bitmap before decoding
    components

 net/netfilter/nf_conntrack_h323_asn1.c |  6 +++---
 net/netfilter/nf_conntrack_h323_main.c | 24 ++++++------------------
 2 files changed, 9 insertions(+), 21 deletions(-)
