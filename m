Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448226;
	b=TQl2CjY7x3gqQ4adtx0TvY2LV9rXzdk3iWgb03gwDZC7irYTrYD2bipEiaEMfQcve6ZV
	 L72WQqL1ea/GOx1r9lkOcpfqi1rHot8U0/xVvmOoTpGaYUArsPWG9iEqQoGn6qN1I4gef
	 1P0+pDW6mqHKKmipE/jaO8i66ubaC5ZwBER6NkVJ4doslVGXMzHy14pfyDKmpiRLFFToh
	 HTv1mXPk3qswsnqzhYIyWPzSvQqxEmyHT0uSUkMGoRXZ6egatrVmTz9zxOQLNEBY4LRQP
	 vysyjnc4HvfpkXom+9LYfhb3FRQW3MXykwt3bwZ3vxGfnADNAEzS4O5gPyHUS/SEk/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=VLQE4yDc+yHcjX02+9IxETSLcgSpZnI6ZugK4stcO84=;
	b=1RxJItdernLTXdBZfI6/nN/sK2U41yCeYkmypqoonST+Q6wSg5EduitjhYcQ/d8PM2jT
	 hlkasXYC65JvYust8Tvz1cF6DHyfhsG/gouuXgkXVTVFzzcTFpZfdRpNK3lsoLEaS5H1z
	 jzLjufbq6jTcRbaj7nBPVZrYQPpNAAb4WQsXkkeRdj7e7xML25U0NAOdNQ4cEyOSbk2j1
	 PrS2yINdSvrjo+bd371XZY2l3Sbs0Hoaj0ig9jpUxQLr7h7CR1g0tqcoLYoHI+FLwooSl
	 tSPC38gAU/OdFheBMmNu2Eq42Jw30+C7GDR3jloVjkoMbgDy3+/jo7rmh5nAPDuRRbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--treapking.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hVOCFnWv;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9DB606A33C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 01:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A9DB606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--treapking.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hVOCFnWv
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b0ac277beaso3274035a91.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 17:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794448226; x=1795053026; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VLQE4yDc+yHcjX02+9IxETSLcgSpZnI6ZugK4stcO84=;
        b=hVOCFnWvw2kpR0Ty2a//IAtp0NaWopqYg9Y77OHi2YgXXr4JV7EusYpPk2xfSXstwF
         s/FL6H53Tur7xvhdNVnz6j/N60u2/qO3+3UYOaShx48ePVv7YPRmt3F1+ym0uw1Ec64T
         OgiNa2aVbsXi2OaBdMv7g0nsfZ50LBFrxmRLNuzfL7T3/ZcefwKkEDRCe0wD+etvtMBQ
         AurfZ/pTdMbSWfkE0tyT0c0U9eRteseMU35Ck7lf1dRN/gHmamQWjCMs/RDd6q+Ts8G4
         9IwIc6H+Gy+vciWG1QWJ6IMHb9PNwPbf9nfv+LBZhDMGfNOv1Dp8szx67m6ZkNOMot7L
         hDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794448226; x=1795053026;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VLQE4yDc+yHcjX02+9IxETSLcgSpZnI6ZugK4stcO84=;
        b=K7jkSpwi+SyI4Bi3rzs4t2c5q4uev4w2aXVEvK0rdy8uuBvGek6yQ2n7XSDDvMEzd4
         alpFCrLaBjZWoTvCBsvu9RtGg9KgqE4b+Ot8P86pfnbt9/56F0CrkOADJ0KiD8S96NI+
         UffSEc2QpnWPrkkjQpq5QHFzkm2+TbLxb1ouXXl6kN01kaDb7r4dUlmiRIR1MpCFzyNv
         Qx2RU68cGEoBY5ImGyZzR/hzOZhip9pzsBBy/VG3uueBIJOFdlek5IH1FM+5hZrPsfV0
         gU4lIBMzBqLWpfEtH5Nm5t3prQRgWGSnLmLWIs48dOZwxGO+vjlvlmgAKHWUFDA0XHBK
         EgjQ==
X-Gm-Message-State: APuU4Z8pThPveed8cp9wN/bE1EAP436EaZ7l4lPlKLBDWWvtnDIkoOKR
	v11D9iiR8rYp1QBenPDge4xOJ3fjd1qAu35pDhQVKeFa3IfCgIHNLRMrut7nnlzapsXbGM6M/IW
	XUxGbrv6E9Wuztsd1kw==
X-Received: from plpk4.prod.google.com ([2002:a17:903:3da4:b0:2e8:8642:f035])
 (user=treapking job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:224b:b0:3ab:f38:2b3c with SMTP id 98e67ed59e1d1-3b182f1feeamr3842902a91.28.1794448225397;
 Wed, 11 Nov 2026 17:50:25 -0800 (PST)
Date: Wed, 11 Nov 2026 17:46:18 -0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261112014942.2946303-1-treapking@google.com>
Subject: [PATCH net] selftests: bonding: fix failover race in bond_options.sh
 prio test
From: Pin-yen Lin <treapking@google.com>
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, Matthieu Baerts <matttbe@kernel.org>, 
	linux-kernel@vger.kernel.org, Jonathan Toppins <jon.toppins+linux@gmail.com>, 
	linux-kselftest@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>, 
	Pin-yen Lin <treapking@google.com>
Content-Type: text/plain; charset="UTF-8"

The prio test intermittently fails in the arp_ip_target and
ns_ip6_target variants:

  TEST: prio (active-backup ns_ip6_target primary_reselect 1)   [FAIL]
  	Current active slave is eth0 but not eth2

The ARP/NS monitor marks a slave down when it has received nothing for
too long. With arp_interval 100 and the default arp_missed_max, that is
about 250ms for the active slave (eth1) and 350ms for a backup slave
(eth0, eth2). Every 100ms, eth1 sends a probe: eth1 receives the reply,
and eth0/eth2 receive a copy forwarded by the gateway bridge. Once eth1
is down, its probes reach no one and no slave receives anything, so
eth1 normally times out first and the new active slave is picked by
prio:

  t=0    probe: eth1 gets the reply, eth0/eth2 get a copy
  t=10   test sets eth1 down
  t=300  monitor: eth1 idle 300ms -> down
                  eth0/eth2 idle 300ms -> up, eth2 picked by prio

But the test takes eth1 down right after bond_check_connection(), whose
ping replies only arrive on eth1:

  t=0    probe: eth1 gets the reply, eth0/eth2 get a copy
  t=70   ping reply on eth1 only
  t=85   test sets eth1 down
  t=300  monitor: eth1 idle 230ms -> still up
  t=400  monitor: eth1 idle 330ms -> down
                  eth2 idle 400ms -> down too

eth2 can then no longer be picked. eth0 becomes the active slave if it
happened to receive some other packet (e.g. an MLD report), otherwise
whichever slave comes back first does. With primary_reselect 1 or 2,
the bond keeps eth0 even after eth2 comes back.

Before taking the active slave down, wait two monitor intervals
(200ms), so that at least one more probe is sent after the last ping
reply and all slaves last received that probe. The miimon variants do
not need the wait, but the extra delay is negligible.

Hit in our CI on GCE VMs (4 of 51 runs); the test only uses veth. On
the same VMs, 7 of 30 loops of the prio tests failed without this
change, and 20 of 20 loops passed with it.

Fixes: 481b56e0391e ("selftests: bonding: re-format bond option tests")
Signed-off-by: Pin-yen Lin <treapking@google.com>
---

 .../drivers/net/bonding/bond_options.sh       | 26 ++++++++++++++++---
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond_options.sh b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
index 187b478d0ddf..16c1c2d97005 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_options.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
@@ -13,6 +13,24 @@ ALL_TESTS="
 
 lib_dir=$(dirname "$0")
 source ${lib_dir}/bond_topo_3d1c.sh
+
+# The ARP/NS monitor marks a slave down when it has received nothing for too
+# long: ~250ms for the active slave and ~350ms for a backup slave with
+# arp_interval 100. The backups only receive the copies of the active slave's
+# probes that the gateway bridge forwards, but the active slave also gets the
+# replies to the pings in bond_check_connection(). If the active slave goes
+# down right after such a reply, it times out in the same monitor run as the
+# backups, and the new active slave is then not picked by prio. Wait two
+# monitor intervals, so that at least one more probe is sent and all slaves
+# last received that probe.
+bond_link_down()
+{
+	local slave=$1
+
+	sleep 0.2
+	ip -n ${s_ns} link set "$slave" down
+}
+
 c_maddr="33:33:ff:00:00:10"
 g_maddr="33:33:ff:00:02:54"
 
@@ -97,12 +115,12 @@ prio_test()
 	check_active_slave eth1
 
 	# active slave should be the higher prio slave
-	ip -n ${s_ns} link set $active_slave down
+	bond_link_down $active_slave
 	check_active_slave eth2
 	bond_check_connection "fail over"
 
 	# when only 1 slave is up
-	ip -n ${s_ns} link set $active_slave down
+	bond_link_down $active_slave
 	check_active_slave eth0
 	bond_check_connection "only 1 slave up"
 
@@ -134,7 +152,7 @@ prio_test()
 			;;
 		"2")
 			check_active_slave "$pre_active_slave"
-			ip -n ${s_ns} link set $active_slave down
+			bond_link_down $active_slave
 			bond_check_connection "pre_active slave down"
 			check_active_slave "eth1"
 			;;
@@ -153,7 +171,7 @@ prio_test()
 		check_err $? "eth3 prio is not -50"
 		check_active_slave "eth1"
 
-		ip -n ${s_ns} link set $active_slave down
+		bond_link_down $active_slave
 		check_active_slave "eth0"
 		bond_check_connection "change slave prio"
 	fi
-- 
2.56.1.703.gf848ed807c-goog

base-commit: 665b4149e91b781a71bce8637c3a4d7d64dba05f
