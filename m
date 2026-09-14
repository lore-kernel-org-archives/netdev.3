Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0198414DFA
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 21:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420775; cv=none; b=en0dxVhmVU7zzNVbZib1OUmaY861HkIeUpXrI8BuR/zV24IVtv6UkvdwV8/+edwBXZMzWMB9TxvKbmWef/hh63Ej3KCb1Zk/1cZLbaGZ6VNOVAXGuIbISdFmHMRVcKuVRJrM8qEe27R4cp+I2gLEL3cirrZhC//UqjnIBF//000=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420775; c=relaxed/simple;
	bh=6S82DVredtucyesmlNsD6LttbkPj4FqwkwqGgMhpDdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fiPwq1b2RP6eXisT/TQTyNK9D+vORciKmhtMPGH49VOv08/Em5YuEauWt/ZY5G//fqXBPtwjJ8pfsG4K1vKvIkTbPgJcB/QuNsHeWWwUG1HXmqRrKGcqZi5xY+zsADurzG5DyhGXqp50cISaQcModpsJ+0faKL283G0qyKQVuIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Gvd+4FWZ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Gvd+4FWZ"
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 118163F332
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 21:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1789420763;
	bh=e9c5Lc0MvQFExiINqSmAM4SmgxHPisXxegde3km6nbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=Gvd+4FWZhoaTqwQHlJasm/ni3IUcSaWOReFynxKr/nZ9U3/WQQO6J4FfzxzQOiivY
	 DaKbCJYY2SlCkyzLYqLxJWQNph9h9D8OHsVwdGAS1MlUgjaaa22a0OCSQdwvoTPWCR
	 WKVVLK2mo+AREliG+DzSIt/WGZ5d7k2c3H37ui3RLQzV1DknqjhMJjQ3g8gnmsDFuG
	 A/zV6B8+GwNaMOg/cGJgY/hMmOi7AB6qQzMcXHxI+6zsAuYKOe3Y9CkkNddL9lWb5m
	 13+OXr8Usfpe2llZobfzIGmPbkPA8+Oz6F5bbh//5xAZao4FgwLiaeqWPTK8ODxiI5
	 GtYsoQvGv/CvTnTLlBhLSEQdqdKOswbbRMJAO8ARHat2/UjryltDOIOQkL8+sKJRDc
	 VITfGGsPNS9YYqEvOKFqnBjfrD8hgtDI0Sn5jWIKr/2nNd4jgN0jbyH48uOCjMywjc
	 eI9U3m84uQ+W5ZdhQIm9LJEXPwcPCiH2KbU7RwuDuOnamN8BzKgOKPN4FusYzEUJDY
	 OUnavKkh+3L8aZFcd6eC68jfPqnpU3FTWXSEUcDoMSP1JV2S0k1fPaedkIgalbuBI5
	 kFbeSBuDUqLd9gHGdsypWbNiQJpQYXxgqUiDKunAodfL0NJNH7xOaxzmj+yXAzO2QT
	 SH1NGGhA7jN5j4w6BosHAjSM=
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e73cb6c87so2179505e9.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 14:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789420762; x=1790025562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e9c5Lc0MvQFExiINqSmAM4SmgxHPisXxegde3km6nbg=;
        b=v8Z/5l2eLcjBBs+8UNiVd+2yjYvKAcmmEp8/RUbd79pfPvABLYT+zk7MrSxAErkrbE
         9RzamKhEWWtvIrxhCF6UN886todWyzBYDyCUd4sIcoiuM2Vv4DQmOh0zcGXBvFpoyMzm
         KnTlSBFDQUS+gqOJuYbpvhEF6EuiaGYKZ5XovTxgfiM/vFnAT9nY2Bn9q9XH5UEhakqD
         INfMbs71i5HbdnTyE8KmlJMxjnBguINKtDqXhrODI/JOgJyiNnGeGzHn4PvwFzE+Ge6b
         nhyB7vyYzsfo1UhOYSXREz/e+J9TQhG/1O7K51WjY8F8se5hjfW8WffdoY5/Xnnmquxf
         mOjw==
X-Gm-Message-State: AFuF++ni/0JD4iFc20PfG6aeNfpNgqIH0O/8fGkjYCrmHI34Szhhrl4m
	ZjsoNav1GI5VbmVPs0Mefr3N7iqzmo8x/c5CZ36gqOmmWi+03i1G1nL6hDosU7im45IxNdy/c44
	GyHvaOJG6nMkjtv6ZV23DRuIwmuvnScHWd0zKdWUqSN06Ya3RSLMkbFSad/Mmwnpxccqkf3CM2h
	QblqxiQw9m
X-Gm-Gg: AYBFou236/HZ5xcploubK/riSJd5E4wfLfomA6qwRmlYnazVzJo6/+LAi+JKHHEsB1I
	WkFVrkahTteaTvgOfWiXnwnbvkBQ0ledxzMLKQIkf80OvPcAvZWOSas4GK4BRmLFj3RRsP4eDYo
	mWIqPFGNsrA87qjK7O6XS54YxueMHzrt1LYOCERmPb4NL+pmbwbxwQsBKfehy+2VwwXJA1nfEuL
	b0aDrt6pYscugx5caklewTEiQI4tRdm06FsTKYmClpazvbAcN5XVDifcoE+ENKqcdZ+HAMCYCGq
	JmQrIFbZb82ZcH6y4c8B6jCDfNiBxPO5rCv1W93uj8tb2JVc0atFrbLXXK/LMkhv7BeaPp4EqWL
	dUxEWaRz7EvpErdnIraNS8aZSuMIn0ER3/YYcELhmIb9SfQcdRw1X
X-Received: by 2002:a05:600c:35cb:b0:49e:479b:c13b with SMTP id 5b1f17b1804b1-49e7a66b723mr56977185e9.1.1789420762628;
        Mon, 14 Sep 2026 14:19:22 -0700 (PDT)
X-Received: by 2002:a05:600c:35cb:b0:49e:479b:c13b with SMTP id 5b1f17b1804b1-49e7a66b723mr56976975e9.1.1789420762316;
        Mon, 14 Sep 2026 14:19:22 -0700 (PDT)
Received: from localhost (host-79-46-33-118.retail.telecomitalia.it. [79.46.33.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d2bb40asm10871855e9.3.2026.09.14.14.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 14:19:21 -0700 (PDT)
From: Edoardo Canepa <edoardo.canepa@canonical.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Xu Du <xudu@redhat.com>,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] selftests/net: run tun tests in a dedicated network namespace
Date: Mon, 14 Sep 2026 23:19:20 +0200
Message-ID: <20260914211921.3786609-1-edoardo.canepa@canonical.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tun_vnet_udptnl fixture creates a fresh tap device and installs an
IPv6 outer neighbor entry as NUD_PERMANENT before sending packets.  On
systems where systemd-udevd is running and a systemd .link file sets

    MACAddressPolicy=persistent

(the default shipped by systemd in 99-default.link, so this is what
most systemd-based hosts inherit), systemd-udevd's net_setup_link
builtin asynchronously sends an RTM_SETLINK to reassign the freshly
created tap device's MAC to a machine-persistent value.  When that
netlink message races the test's ip_neigh_add() call, the address
change kicks the following path:

    do_setlink
    -> netif_set_mac_address
       -> call_netdevice_notifiers_info
          -> ndisc_netdev_event
             -> neigh_changeaddr
                -> neigh_flush_dev(tbl, dev, /* skip_perm = */ false)

which flushes every neighbor entry on the interface, including the one
the test just installed as NUD_PERMANENT.  The subsequent packet
therefore hits __neigh_create(), triggers NDISC, and times out with:

  tun.c:947:send_gso_packet:Expected ret (0) == variant->data_size (1423)
  tun.c:948:send_gso_packet:Expected r_num_mss (0) == variant->r_num_mss (2)

The failure is non-deterministic and can affect both directions.  Both
recv_gso_packet and send_gso_packet variants can hit it; the failure
reproduces on a plain systemd-based VM with no containers, and is
triggered whenever the udev worker's RTM_SETLINK lands after the test
has installed its neighbor entry.

Fix by calling unshare(CLONE_NEWNET) from both fixture setups.  The
harness runs each test in its own forked process, so every test gets a
private network namespace that is torn down with it, and all tap and
geneve devices are created in a namespace that systemd-udevd (running
in the init netns) does not watch, so its RTM_SETLINK never fires
against them.

Creating a network namespace needs CAP_SYS_ADMIN in the current user
namespace and CONFIG_NET_NS=y, neither of which the tests required
before.  Where they are unavailable the unshare() is reported with
SKIP() rather than aborting, so the binary still emits a full TAP
stream and a runner can tell "network namespaces unavailable" apart
from a real tun/tap regression.

Verified on a plain systemd-based VM running the affected kernel, with
the tap and geneve devices removed between iterations so that each one
starts from a clean state.  1000 repeated invocations of

  tun -r tun_vnet_udptnl.4in6_nogsosz_1byte.recv_gso_packet

produce 266 failures without the fix and zero failures with it, and a
full run of the test binary fails in 20 out of 20 attempts without the
fix and in zero out of 20 with it.

Note that without the fix a failure is not self-contained: the fixture
setup aborts before FIXTURE_TEARDOWN runs, so the tap and geneve
devices are left behind in the init netns and every later run fails
right away in geneve_create().  Running in a private namespace also
removes that, since the namespace is torn down with the test process.

Reported-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
Closes: https://bugs.launchpad.net/bugs/2158217
Fixes: 24e59f26eef2 ("selftest: tun: Add helpers for GSO over UDP tunnel")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Edoardo Canepa <edoardo.canepa@canonical.com>
---
v2:
  - Add the unshare(CLONE_NEWNET) to FIXTURE_SETUP(tun) and
    FIXTURE_SETUP(tun_vnet_udptnl) instead of replacing
    TEST_HARNESS_MAIN with a hand-written main(), as suggested by
    Jakub.
  - Report an unshare() failure with SKIP() instead of aborting the
    binary before the harness starts, so the TAP stream stays complete
    and a runner can tell "no network namespaces" apart from a real
    tun/tap regression (raised by Sashiko).
  - Mention the new CAP_SYS_ADMIN / CONFIG_NET_NS prerequisite in the
    commit message (raised by Sashiko).
  - Use the Assisted-by: format documented in
    Documentation/process/coding-assistants.rst.
  - Redo the measurements in the commit message.  The v1 numbers were
    taken without cleaning up the tap and geneve devices that a failed
    run leaves behind, which made runs after the first failure fail in
    geneve_create() rather than on the race being fixed here.
v1: https://lore.kernel.org/netdev/20260905085318.3416670-1-edoardo.canepa@canonical.com/
 tools/testing/selftests/net/tun.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index abe488bac50b..6db21dad0efe 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -4,6 +4,7 @@
 
 #include <errno.h>
 #include <fcntl.h>
+#include <sched.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -488,6 +489,10 @@ FIXTURE(tun)
 
 FIXTURE_SETUP(tun)
 {
+	if (unshare(CLONE_NEWNET))
+		SKIP(return, "Cannot create network namespace: %s",
+		     strerror(errno));
+
 	memset(self->ifname, 0, sizeof(self->ifname));
 
 	self->fd = tun_alloc(self->ifname);
@@ -732,6 +737,10 @@ FIXTURE_SETUP(tun_vnet_udptnl)
 	struct sockaddr_storage ssa, dsa;
 	void *sip, *dip, *smac, *dmac;
 
+	if (unshare(CLONE_NEWNET))
+		SKIP(return, "Cannot create network namespace: %s",
+		     strerror(errno));
+
 	flags = (variant->is_tap ? IFF_TAP : IFF_TUN) | IFF_VNET_HDR |
 		IFF_MULTI_QUEUE | IFF_NO_PI;
 	features = TUN_F_CSUM | TUN_F_UDP_TUNNEL_GSO |
-- 
2.53.0

