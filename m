Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF5B4FC8D1
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015883; cv=none; b=FqZ5aCiSjg5Ymzv6TpvrWtsySbXCOScZvk51wCwOzZOKBRmv/hmW/tiFqeHP0QhhM5U6N+Ot+acRZbhmBkAyy/zIdLHnEcwOQX0NAGpdn8Vcc+CAFrPi9R1OlN0wjgBVJJkwyeogt3/51XjoUBvAQlJUIh+h5eqSjcO6nV2iKMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015883; c=relaxed/simple;
	bh=xwaYf6avbdUHGXLYnxRqW5JblVJNwFXqiyXeM++djgk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YZoxwI28eUlJ366VmP4tV4lqPZbCa6dCS1mdH96wloy68P3KDyWJe1YLhlR+FgOqObTHkkxxsmBS7PU94kZQSKR5r5NoLG/icWYJQwVR/Ahq5EDwEBiCkKnTB9MxxRibszoFU1F65ZKkmrTAh0LglnAA+FmWrzBpL4Gi7CZLhUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GPtQssx3; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GPtQssx3"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e82060977so29343285a.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 11:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790015880; x=1790620680; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZxcXn1x/BRBnJhDm33892wfrXyJ+S6gh2EoWBnPzViE=;
        b=GPtQssx3Zgw/bLlzrfBjrjEW1cRMqw50vmllp/xyWBUexS4eJntcAVmgTmjdOd9aFO
         EJZFet5VaKRrRE7fXhON/amK9fgZEGxl7e24UQjxkq2A+EGcilw0a7cKHPIaJTZOsako
         eHzrtKp/BPej6csqugj1LCxdh2EkX07N6JTrmvLqBBqzcX7c1+XvQ8vKXf/iw7pXUBa9
         CBA73YgVOAM0MGaTG193LBHiLTUWyKDl4ENkeHG4utkAHKi/ijMdSo4xdY2ACyIPjcf7
         82XC8XWWisst1et06y1gPj4ShWE9FQzeLkG2gktnJodpBjLMZP7foI2Z3a7w/CH8RphF
         GL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015880; x=1790620680;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZxcXn1x/BRBnJhDm33892wfrXyJ+S6gh2EoWBnPzViE=;
        b=vwbiHfCZgxkaNiITfNBjvlGx67CS95ytxLp1xnRD0mkfVBtQnvc4kfekk6ysmodbmM
         GhZIangh0xg9okRBCMJbHMzEvUS4mmqdSdobAkMPLVknS2ilvQjQ4fmd2rTDcpUiLbZ7
         DF6ZlUip+tyomxUG5qh37y5kyfZkrs41vJ1bXBcLH/LicXtxkXM2Bi4AawAx7gYQZVss
         G2oYllS3JyZBdz+KSOmn8qJ2a/emiB8dco5ojTgwTHrWO6DZHBa0wn7vjeuzQNHbtkZV
         uk3u+Rpjjspph5ijLGz9GmXLaaqjGPQefuf9plvHsQl2/lOq0eHIN8ot1C8yxrvx/0IK
         06pQ==
X-Forwarded-Encrypted: i=1; AKwUvBxqxMm3EnynvXY1zaO2qmLOPB3kP9M8fvuj1cyppuu0N/YzhtQ551OiHqaxxE4o5fMYnl4uNRI=@vger.kernel.org
X-Gm-Message-State: AFuF++lECBLp1PIg1ueeePIeomr5QZyTT20Q95VpIHkLzxCx/5SAJvoe
	b4NdHstPh6uE4A9EbhZgUX2jAtkgrkHdli2At4B37uAur13N7pwUpGSnpKFGr73fBY1Bb7HKYJs
	rYGR86I/hZp+kAg==
X-Received: from qkcbk3-n1.prod.google.com ([2002:a05:620a:72c3:10b0:93a:1c11:ba6b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4891:b0:939:319f:d6e3 with SMTP id af79cd13be357-93c17e14a82mr78682485a.5.1790015880070;
 Mon, 21 Sep 2026 11:38:00 -0700 (PDT)
Date: Mon, 21 Sep 2026 18:37:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921183758.1812310-1-edumazet@google.com>
Subject: [PATCH net-next 0/5] net: ethtool: make netdev_rss_key_fill() spread
 flows over all queues
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

netdev_rss_key_fill() hands drivers a uniformly random key. Because the
Toeplitz hash is linear over GF(2), a random key is singular for a given
header field and queue count with probability 1/2: flows differing only
in the low order bits of that field (such as a burst of consecutive
ephemeral ports) then cannot reach all RX queues. On one affected 16-queue
host, only 4 queues received traffic until the key was replaced.

Patch 1 synchronizes proc_do_rss_key() with netdev_rss_key_fill() using an
smp_wmb()/smp_rmb() pair and a boolean flag so readers of
/proc/sys/net/core/netdev_rss_key print zero bytes until the key is fully
populated.

Patch 2 keeps the key random but constrains 1008 of its 2048 bits so that,
at every 16-bit aligned position and for every power-of-two queue count up
to 256, consecutive values of a field ending there visit every queue once.
Applying the fixup on the 16-bit grid covers standard 2-tuple/4-tuple
hashes as well as encapsulated or bitmap-selected layouts (such as PSP
inner TCP ports at byte 78) without enumerating them in the core. The
fixup is a bijection onto the set of valid keys, and redraws in the ~1 in
5 case where two 32-bit windows a multiple of 8 bits apart alias.

Patch 3 adds a KUnit suite verifying full rank across standard and
encapsulated fields, the full 16-bit grid, window non-aliasing, and
end-to-end flow spreading.

Patches 4 and 5 add kselftests for keys on a running system: patch 4
checks /proc/sys/net/core/netdev_rss_key, and patch 5 checks the live RSS
key and indirection table reported by a device via ethtool.

Eric Dumazet (5):
  net: synchronize proc_do_rss_key() with netdev_rss_key_fill()
  net: ethtool: generate RSS keys that spread flows over all queues
  net: ethtool: add KUnit tests for the generated RSS key
  selftests: net: check the quality of the host RSS key
  selftests: drivers: net: check the RSS key a device uses

 Documentation/networking/scaling.rst          |   9 +
 net/Kconfig                                   |  14 +
 net/core/dev.h                                |   1 +
 net/core/sysctl_net_core.c                    |   7 +-
 net/ethtool/Makefile                          |   2 +
 net/ethtool/common.h                          |  11 +
 net/ethtool/ioctl.c                           | 170 +++++++++-
 net/ethtool/rss_key_test.c                    | 314 ++++++++++++++++++
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/lib/py/__init__.py         |   5 +
 .../selftests/drivers/net/hw/rss_key.py       | 172 ++++++++++
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/lib/py/__init__.py  |   5 +
 tools/testing/selftests/net/lib/py/rsskey.py  | 108 ++++++
 tools/testing/selftests/net/netdev_rss_key.py | 117 +++++++
 15 files changed, 935 insertions(+), 2 deletions(-)
 create mode 100644 net/ethtool/rss_key_test.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/rss_key.py
 create mode 100644 tools/testing/selftests/net/lib/py/rsskey.py
 create mode 100755 tools/testing/selftests/net/netdev_rss_key.py

-- 
2.55.0.1082.g2b9226bbc0-goog

