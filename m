Received: from mail-pg1-f232.google.com (mail-pg1-f232.google.com [209.85.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA8A367B72
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792119078; cv=none; b=TJIyunUs7Ax5N9RSsqvstsyg3Tnt5BSOqer+4bnpHBZPo562gDfOEZuNvfI7gzhfWoK2SQVbbkAQ+I3JPgPzZ5n+kU1k60qezDgFGVwnbVcdECB072xKB4RGKS3Y0W1vSEz+q3i+v1L61fvOX1ifY1+dQE7d994Z5jIzVzqWaqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792119078; c=relaxed/simple;
	bh=sAdtKLLaHnDWjzQ0GdP7Kvx1LBbkSwir1OD+oAgVBwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Puo7/3uFYixV/fik3zKQ5e4vUJUAHcQHEg+4JZVYwmknvwzdevxreMF1Irsph5mnqje0cdQWVXaFACeXK3yVGEjPif4kV1iiG0pwnaaU56zWHrMRin7okjvggz9lprjC8GMNqB4WOm7snP+U14Hd/x0ahUSfgPK1pxovv1emR7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KfQJtct+; arc=none smtp.client-ip=209.85.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KfQJtct+"
Received: by mail-pg1-f232.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so1501055a12.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 19:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792119075; x=1792723875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z/AufVhG/q8v5xB27+Be+cyJ9kysBtXwzIEkpk9uqgA=;
        b=KfQJtct+FtSODbculjk3+RBGd3dI9apktf5CBFoP28fKMCeL6d89R4vDwbjbtR/Cqb
         Y6wbTed80JDq7C3Keb4sstY2NRB2ICLqN4b5a7RV5Au0aKnO9Ar5xAzV7FF7u65Eh6xi
         J+uRCsBbsPj+rDiNqokttYFSsYqKKPUyqNQvvZGAN13Z+updUFOIXy15olpNC4nxlX0O
         jTNby1reosZ/njyaV+XDD0RRK/NUJOYDtrZkrRAzEuxlQARYPNnFP0Vk56tQvdTTVbVv
         PwT/OTOQrQtxsoKbwTd0WHxi96l1RiRxqLWTJyVxFj2g39w7oe+AER/6mldqsJOzsMJI
         wQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792119075; x=1792723875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z/AufVhG/q8v5xB27+Be+cyJ9kysBtXwzIEkpk9uqgA=;
        b=TmnYy/S4Avq8yq1mbl7ZSjokaL7XD+5IMF/ZSVwXia++AHRkI8hzvG9vXKgzkIbosl
         Rjx/FROuv23JZ8nhjncNKzKCK2YcySE8efor4ua4jCtTMX7ldQEE1SxvlcOvV3+t1rBM
         6QXoj2ukrFPI41Vre3jyjVJpqF60wqVIQRXXzS3VhnHJuIUNjl+7takCbxuHvQAjM4P1
         VCM8wEoMsrcHC6AAVB+qiuXpCyDXgbBb2UkMSb6U/I3rrZgl8a1onPJAb6oHepDWsHYd
         1J7JRWv+7zZjob3ZwqFePy9XDaph/4ioGuTPGuEk6jGNT3CL6FdBr/DsvTLP2tpO/X6A
         7XJA==
X-Gm-Message-State: AFq9FYKQ1PwL/+KTrVEloZ76IZvx7kZQ8p3VeXcKEnGpn2EMeu8w3Beh
	fIcxdg5DdNYrYz/onaKOLVmqgKdMD8NBHbN9kYuWzkw5vfKzafjj19j0N1UW1MkvZFFvwVuGLjT
	pkg2tkoPcMI02HEda2qZCdnaNApAbDQDf+lNJ
X-Gm-Gg: AYBFou0xZBI3OKE/YaaHzDnXzP4MvTLHWMWGvPPJwkSnDfCoOj/oBox275E7FYDWFkY
	58uHzX5LX+6G3WL2q/f/3FZ6mGiiczTBv0CTXyG0Dcq5ZTgTjKuqD+OCkDHsimEqvdOzv2dQenv
	t01AWcVYmmTpo7sfo1JRlWy1WkkCvrm06yleFuF0N9eODDCxo0Jj3Uix9vFTUU8MhM2soYUq9+T
	OXWaqj//ZILdA5Z5CdyOCqfaXi5W35EWy0GhSQLJ9Fu4MZJWHecKKEW0kjfNh/OlOqeJqH7c/9y
	Xqf28En1LjvpRl8rv+FNI+xD7zq/SaD5kSQ7MiULSwo68pSTIvUSVkiXhLYouDkVEPdkHN1GBXk
	NKFSMIZK5nqE/oySxjpwjaVHfUpGyMRGsT5o=
X-Received: by 2002:a17:90b:55cb:b0:3ac:403d:6239 with SMTP id 98e67ed59e1d1-3ac403d6baamr8413098a91.43.1792119074901;
        Thu, 15 Oct 2026 19:51:14 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ac947ba697sm2696076a91.7.2026.10.15.19.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:51:14 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [10.17.2.234])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 10D34400B8;
	Thu, 15 Oct 2026 20:51:14 -0600 (MDT)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 0B193DC12FA; Thu, 15 Oct 2026 20:51:14 -0600 (MDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH net v2 0/2] kcm: don't sleep in softirq when the lower socket uses kTLS
Date: Thu, 15 Oct 2026 20:44:52 -0600
Message-ID: <20261016025059.289202-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a TCP socket with software kTLS RX is attached to a KCM mux,
psock_data_ready() calls strp_data_ready() from softirq, which calls the
socket's read_sock(). For kTLS that is tls_sw_read_sock(), which can
sleep, and CONFIG_DEBUG_ATOMIC_SLEEP reports it on every run of a
loopback reproducer.

Patch 1 is the fix: KCM parses inline only when read_sock is
tcp_read_sock() and otherwise defers to the strparser work, which runs
under lock_sock(). It applies and builds on its own, including on
stable kernels.

Patch 2 addresses review feedback on v1 and is needed by patch 1.
kstrp, the workqueue that deferred work runs on, is an ordered
workqueue shared by every strparser user (KCM, sockmap, espintcp,
ovpn). With patch 1 alone, a KCM psock decrypting kTLS records in
software on kstrp would delay parsing and message timeouts for every
other strparser socket on the system. Patch 2 makes kstrp per-CPU. It
has no Fixes tag: the ordered workqueue is as old as strparser, and it
only becomes a real problem for KCM over kTLS with patch 1.

Other strparser users are not affected by the bug fixed in patch 1:
espintcp is itself a TCP ULP and cannot be combined with kTLS, ovpn
installs its own ops built from inet_stream_ops, and sockmap reads
through tcp_bpf_strp_read_sock() and is mutually exclusive with kTLS
RX (do_tls_setsockopt_conf() rejects sockets with a psock).

Testing: with patch 1, 5/5 runs of the reproducer produce no splat and
full datagram delivery; without it every run hits "BUG: sleeping
function called from invalid context" in strp_data_ready ->
tls_sw_read_sock. Multi-record messages (>16 KiB each) also deliver
completely with kTLS RX installed before the KCM attach and the whole
stream queued before the reader starts. With patch 2, test_sockmap and the ovpn TCP selftests
pass, strparser work runs concurrently across sockets, and dmesg shows
no warnings.

v2:
 - add patch 2 (kstrp per-CPU), per review
 - read sock->ops with READ_ONCE(), pairing with update_sk_prot()

v1: https://lore.kernel.org/netdev/20261013033920.2069285-1-rjethwani@purestorage.com/

Rishikesh Jethwani (2):
  kcm: defer receive parsing when the lower socket's read_sock may sleep
  strparser: don't serialize all parser work on one ordered workqueue

 net/kcm/kcmsock.c         | 33 +++++++++++++++++++++++++++++++--
 net/strparser/strparser.c |  2 +-
 2 files changed, 32 insertions(+), 3 deletions(-)

-- 
2.50.1

