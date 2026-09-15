Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D1149553B
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 23:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789513909; cv=none; b=DPkKKD72t9rUYUg86kNsD+uvca0sxiZXPp6Ts0gauWdaruDA62bHJSmYkh1KG4iYtDwMJMR5UmJfQGEElfvAagV0sh+QOps6gQi+EnYgXq3SVuKU3rS/V6YElyQfAnQWmUV7391f9rpUpUCh7pdE/sWbqoKwmCo/sfsCJvzMCe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789513909; c=relaxed/simple;
	bh=eLY850UsuQ+Evp+x0UEhaZgYKr4IhiMJmvs2OTuixIU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tnjT8zBcSpcCWb5Z9o3dX+Z/nLd/56fvYxgeX2vG6cGtwkIzldIMzgHmWz5bx6qjqEcjt7UgrWyX/Zg/VUb0r3WtIddXMfL8b9gITOcaCuRIjbO3vC2MOwoso21WZqXsLEWi8kW2mLqduPIfde39jtdLYBhqClWqwWuu8JgpGoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZtZwqoT; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZtZwqoT"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6b1ae6f1637so148375eaf.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 16:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789513906; x=1790118706; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m9RVSLO7zgrPbxXav/0bBnn0dj8GNqIO7QvejQ6D/5E=;
        b=TZtZwqoTCm/p3JV4G6WJ9eWwDM0Ynj1n0HMF7tuvxgwKnDorazgSVzVjh/c3/t6oZN
         kCDQUL8t6+RBh35h7kmnNCViR0xP2s4ktDJw9enRxvGV4hSloZBO3AjPNM+P/nXFg6FJ
         bGFHEZjfmJsnRJQjAxrUd9H7p/IG938Uvb1pU/mubyp5aab94tk7LkWjPkJ0TBEmIr+a
         ex32x4DVYP5EFGPHOEuSu7/M/OGFYLzyeq0LRN/aCs080XAhaJrBrBtfZhnj6MsIt6mt
         qa41vv4Y6Avh6CJX5bGsMt+XyijP9yvMkEUv6amYMNG63Z4gZuAazU0R2ZhnTwFWIr4A
         NPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789513906; x=1790118706;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m9RVSLO7zgrPbxXav/0bBnn0dj8GNqIO7QvejQ6D/5E=;
        b=Ntiur2aMTPsQ9H9+tM8/ZJITYpRX3WH2KnlX9SDxV2tcu8lXyKo9MAVO68IMybw/7G
         2fI3ba+rRXPT1FcwKzKbV6VROmyCaxV1/KLzMcgP8w9orY/hFQo0+CfEOabVE65KgFqJ
         SM0BVCCk9EGo2QM04PxROZuwpMlLF8s2teMhSM6jMdAZGo2GmIJuZR8A7JaLD6qUQPvx
         tdzcyMR2rSI+i+o+9iZZ26Zfzc3TTzXl4jzB7EXdQlkHLMBVg4re3QmOhfY/aVv0wvSa
         Sz0rxvnktLkOxIrEWJLslrww86SCiPdTFWFDtXT9cIgDqN5++hSKsfLw4EIVdPSURTGb
         IwFA==
X-Forwarded-Encrypted: i=1; AKwUvBzxttbuivyp0tbKaGM3rNBlxhe+y54Iw6kQhuiQelBzG+xsT6qjDgiNNGhA3orgxhdGN1rZQSg=@vger.kernel.org
X-Gm-Message-State: AFuF++mUzGEyUuVTP+wJFFfenrNGjwgVmhufVJ5otSkfO3QfIrF9OUAN
	pUsbL8KmL/FzRmkc6Dgenqs3W/6bzYekkdpUHGK38ccktWvHN6FvVeac
X-Gm-Gg: AYBFou02ds8YaVDORd0CyPhLcGRfkNgq/Ngkn3beJz26Z4/7EeL1uqO2iQ5rrshaYU0
	T2ofjcjlC69UXmwVAiUPNNYBY0yZMsjCRLJoJhxAFcdjCrr7+GYZpHV56M28IQe5a1+vRxSsukT
	7l92e5xyv4fRrFbr9Iv7zwGJjRKmU4rK5jZoH7ck4u6BJUBis4OAJpVRQUClVUWM36TXRxnVBnD
	WaJuKCw+YxYVJJJcAfIUtFh4Lq7viaOAoAXzmv9Ay/lm4Si8+4ZsQd/eElKw5VfHTU+lj4yL4gl
	JxLRQwrxsDykZ4LgDNSesACT5C31Vut+fL7dhVeQhqnCJHztq6mqv00DftihuxayV9sBkEL15TV
	D13Tcy1NWgzBQNY6u9BE6yFvYhXlKhG8Apj+EqQW81D2JddQY6ZH9dJn7wh6IOlWnQjJpjD3aCq
	bHva5zdtfHHtjCjRfAg7oB3TbfHTdi/KKLCH3E46T3IwizkC7Mt+R0IsgPCI8B0JIRqV8=
X-Received: by 2002:a05:6820:1c8d:b0:6be:4117:ae1e with SMTP id 006d021491bc7-6c7d15cb063mr627279eaf.14.1789513906368;
        Tue, 15 Sep 2026 16:11:46 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-48429a9213fsm1194432fac.3.2026.09.15.16.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 16:11:46 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Subject: [PATCH net v2 0/2] net: psp: avoid conflicts with skb->decrypted
 and sk_validate_xmit_skb()
Date: Tue, 15 Sep 2026 16:11:36 -0700
Message-Id: <20260915-psp-ktls-fix-v2-0-0eedc3b148ec@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKjQqWoC/1WNwQqDMBBEf0X23C1J1Io99T+KhyVudKkaSSS0i
 P/eYE89zhvmzQ6Rg3CEe7FD4CRR/JKDuRRgR1oGRulzBqPMTbWqxTWu+NqmiE7eWDVEpunbunY
 G8mQNnPGpe8LCG3QZjhI3Hz7nRdJn9bNp9W9LGhVy6UpFxJYqfgwzyXS1fobuOI4vO+B9mK0AA
 AA=
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.13.0

Sashiko's review of commit da630d1da2b1 ("netdevsim: psp: drop tx key
ops") [1] showed that there is a hazard between PSP and offloaded TLS,
where both can clobber what the other set in the sk_validate_xmit_skb
callback.

It was discussed further on the mailing list [2], and it was pointed out
that there are conflicts with PSP and TLS ULP both using the
skb->decrypted bit.

The simplest fix is to make psp and tls mutually exclusive. This series
goes a bit further and makes psp exclusive with all TCP ULPs. The PSP
implementation that we have is not designed to be used with any TCP ULP,
so don't allow a socket to have state for both.

I will send a subsequent series to net-next which will remove the
ability to perform the rx-assoc and tx-assoc psp netlink calls on
sockets that are not in the TCP_ESTABLISHED state. This will close the
remaining quirk that a sk_clone() on a listen socket with psp tx-assoc
state will leave a stale sk->sk_validate_xmit_skb call back on a new,
non-psp socket. I do not believe that change needs to be regarded as a
fix, because it only stands to add unecessary validation code in the tx
path.

[1]: https://sashiko.dev/#/patchset/20260903-psp-prep-v1-0-d47e9c4c375d%40gmail.com
[2]: https://lore.kernel.org/netdev/20260903-psp-prep-v1-0-d47e9c4c375d@gmail.com/

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
Changes in v2:
- remove check on sk->sk_validate_xmit_skb in both tls and psp setup paths 
- Link to v1: https://lore.kernel.org/r/20260910-psp-ktls-fix-v1-0-e3f30aaeca4e@gmail.com

---
Daniel Zahka (2):
      net: psp: avoid conflicts with skb->decrypted and sk_validate_xmit_skb()
      selftests: drv-net: psp: test PSP and TCP ULP mutual exclusion

 include/net/sock.h                         |  2 ++
 net/core/sock.c                            |  7 +++++
 net/ipv4/tcp_ulp.c                         |  4 +++
 net/psp/psp_sock.c                         |  4 +++
 tools/testing/selftests/drivers/net/config |  1 +
 tools/testing/selftests/drivers/net/psp.py | 46 ++++++++++++++++++++++++++++++
 6 files changed, 64 insertions(+)
---
base-commit: 83a945a529d6e002dd7339c532288a931f463dba
change-id: 20260909-psp-ktls-fix-47aa27d955f2

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>

