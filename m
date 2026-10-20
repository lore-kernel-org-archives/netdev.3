Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792492528;
	b=uG2HiHFHleNFuhCz66pSbor+tB0pZ99hQkjUTns0t6TUJ36EuNRgDNe/DCwe/we3nBQa
	 PjZb1rp0ZQKXSaxKmPTPtLtVapwVuUHMXf1BqHeUPFu9kjQMb5TCJL4rlTEZTssE8HG7i
	 bJOoJ8+0d4eHkx2OOksyuuZKrIq3gjZ6xxixNQKMmiw4zZQ5Hb8zJH/iALXaQ9Cjlk9kh
	 6F5DwL0K8Y+mdsxu1W7aCV8SiSCMQnFdH+A2FhncTPyxCr6KxUZfUCoayYROFxa2y+Et+
	 VSNZRErapLOgPUwE2CeCQ3qn6iwYwrvQaq1PqXDFqCi6GNaEY8oy4+LMnN9n6TzdGKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792492528;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b6vl8DhBKNBBeDdXDarV+k7b4TukYYKqz3C8gKFsMSM=;
	b=KWPs2MGWmC6oI0oFgGPa/JWczQmww2JJWuUoGCe9CMteBPwFwTuYOxmbkRk5wcmoqgdl
	 klxwbW8JLliJ+EWGNckyLrRoNRpWxfI+uvEgoiAkNozlnPDzkVJb+CRDqcZv1QlxHYB5W
	 faF3aK7YU2g07r6FYhH5Pe9/zJPlYAJmfKFu+vClD3wd1c0EQkWLROcxHt4qY1yrMqoI+
	 iUZo2TI+VplxnoC0Oqno9DF+7FLJ+PqrmWQwcS4aWrMaHubzkUT4wQnjdK+YmyLdyLlW7
	 1JnHRCo8Iyrlvo/jCYbKQqJqUvqOBaVYAAt5zbcjZy8VGzc1wJwZWwhIZHw6OP84CWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Tfy8gPpg;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC659606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC659606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Tfy8gPpg
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c3f8d72d7ceso527540566b.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 03:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792492526; x=1793097326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b6vl8DhBKNBBeDdXDarV+k7b4TukYYKqz3C8gKFsMSM=;
        b=Tfy8gPpgNea4NWmTe/7uKj8VWr03aU0uep+R7u3EFHcdUFS3ae+coI/B/Hu3NW78CT
         y/GZGFdeUTthHmMrLVJpyb/zB/r4//qrjlRALruWMwv0M1SzyvyrhWc7grCEz1dnNnhi
         tjeLbdjlPXE7NqLWScuqc3+OfFtRubc7ukA+lUkYNxyqZ+Hj9HkupJjDRflce8aUJBuB
         wkX8xo5uJOktCCHq9WcXGb5wf/9aI1Uio7EBxdeo37XyAJuGLw0btJme7AOZv4iQrQ2u
         COI/cssbwIY9TtKbVd+2oS8KG+8xAcJrqb3Tj9iT65FxEaCV/PLkyfddaxYrw44i94hU
         uFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792492526; x=1793097326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b6vl8DhBKNBBeDdXDarV+k7b4TukYYKqz3C8gKFsMSM=;
        b=cc5oy0m+MaCElMObMPMHuPImdf/5uIknJRsy0tPJh81BsQNqiPQQC5gr9tP9MmSiDJ
         RIbwoqEZt9g2N96umnzm/jWwEkTj0FDRSZYCVIxyjiisl8hgp127oWU8T0qeSr4SOTzu
         i+RywXTIwrfJ5BhCQTE1atPMSMrc1ogmPDeeJrgb1Fu1G76xZX4cbz5bz8qnsm+PK9Xf
         CMD88BtXRfmC6QNN7QLFnpMlPsJ75PjCqpbG4r5g6C2U7BbflOxxlxFQEIdGTXfSvm3D
         QtgJ3LuftWTjMmu6JgPymSrm/UyMcSeodz/JfgR38zeW4I3phGLvjurpyoSy07Q5CzCe
         Wbkg==
X-Forwarded-Encrypted: i=1; AKwUvByAosj0NwElw9SfUXPWNjjzlKgyEKVaNGU3DTwhK9r9S/1uEaLGX+zgEL7DWfzgpIxwFDCI2OM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJT2cXpKI/0S59YeV7i0ZJu3apI+DF/awH23anL0KB0GAFbpnTd
	2lmBstWKtKQbvDlSV1+DPEgwu8dOm0uIOLuq/TWohMIXoBojpZdfQ7Br
X-Gm-Gg: AYBFou0pydtSlBoB2X7IF/vy9H95ZAICWXukjrsAk7t+Bejsq05yqzYRq0GgDB/aDou
	Dr2/ONJdvVoXNdD1A5YtuA/KR90tSfihXw6gNVS6sUKpzYy/6HxaPhRNSgNCSZyQX3IZYg8smpY
	JSFPXFh6Wae6DTAH18bd4+bUM8U5kBWplMhtgE6+nj47DWlD+y5WgYtw2bQ8UofJbeAWacFqRGw
	qojm8BLCT9EvUOFGAl4abttiIMQLffobX94ViBOagDtYLvO7kTmJDv4YkE27XRD608xlSYC6Kvu
	vUzQ0Q8rim/PzYWyrhueBEq+mbzQ4ZUAgJ0pjU9V4bjc/0N092Cc/V4P6Uqp+HYUihbMVbumX+/
	UyxsrCLmBJlJVcq0A2GRi3ZYkUKH0mM2BKjBtPeJA0dNPvOlTeaPSb4qKifV8YmHoENTjLs4g51
	pwXJuK9cWEnoto9z3/p347zycNzy+Rwz52uqDFNyttaPqrjqrVYxl3D/gtI/ukqnK79Q/4MsHDK
	4uCvMdjIYsGTSBBsECHYAAqhpDKBVQCawkIHDLIUEviIrruCuK15UsgefR5q0alY9CJxknhW44r
	pEE9IqmXFUFBtmw2yOI4bS310uoAyw==
X-Received: by 2002:a17:907:60c8:b0:c43:a881:3f4b with SMTP id a640c23a62f3a-c43a8814361mr595412366b.47.1792492526023;
        Tue, 20 Oct 2026 03:35:26 -0700 (PDT)
Received: from localhost.localdomain (ip-80-113-117-72.ip.prioritytelecom.net. [80.113.117.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919bcae3sm479893666b.57.2026.10.20.03.35.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 03:35:25 -0700 (PDT)
From: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michail Andreas Michalopoulos <mike.michalo@gmail.com>,
	syzbot+521f7e7e2b974abde99a@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH nf] netfilter: flowtable: extend ct timeout of offloaded GRE flows
Date: Tue, 20 Oct 2026 12:35:20 +0200
Message-ID: <20261020103520.76439-1-mike.michalo@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 03428ca5cee9 ("netfilter: conntrack: rework offload nf_conn
timeout extension logic"), the flowtable gc worker extends the timeout
of an offloaded conntrack entry from nf_flow_table_extend_ct_timeout()
once it falls below 5 minutes. That function only knows about TCP and
UDP and hits WARN_ON_ONCE() for any other layer 4 protocol. However,
GRE flows can be offloaded too, both via nft_flow_offload and act_ct,
since commit 4e8d9584d154 ("netfilter: flowtable: Support GRE").

The timeout of an offloaded GRE entry drops below that threshold as soon
as a packet of the flow still goes through conntrack. With ip6gre
tunnels using the default encapsulation limit this is ordinary traffic:
the flowtable does not parse the Destination Options header in front of
GRE, so every packet of the flow takes the classic forwarding path. It
also happens for a packet with ttl <= 1, which the flowtable fast path
passes up to the classic forwarding path. nf_conntrack_gre_packet() then
refreshes ct->timeout to the GRE stream timeout (180 seconds by default),
and the next gc run triggers, as reported by syzbot:

  WARNING: net/netfilter/nf_flow_table_core.c:553 at nf_flow_table_extend_ct_timeout+0x1ee/0x2f0
  Workqueue: events_power_efficient nf_flow_offload_work_gc
  Call Trace:
   nf_flow_offload_gc_step+0x545/0x7b0
   nf_flow_table_iterate+0x13c/0x1f0
   nf_flow_offload_work_gc+0x22/0x70
   process_scheduled_works+0xc3d/0x1630
   worker_thread+0xa47/0xfb0
   kthread+0x38b/0x480

Besides the splat, which panics the machine with panic_on_warn, the
default branch sets the new timeout to 1 jiffy, so the conntrack entry
expires right away and the offloaded flow is torn down.

Handle GRE like UDP and extend the timeout to NF_CT_DAY. GRE conntrack
has no protocol state to take into account, and NF_CT_DAY is also what
flow_offload_add() already sets for every offloaded entry, GRE included.
This also restores the behaviour from before commit 03428ca5cee9, when
the conntrack gc worker extended offloaded entries of any protocol to
NF_CT_DAY.

Fixes: 03428ca5cee9 ("netfilter: conntrack: rework offload nf_conn timeout extension logic")
Reported-by: syzbot+521f7e7e2b974abde99a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=521f7e7e2b974abde99a
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
---
Tested on v7.3 in QEMU, with and without KASAN, lockdep and
DEBUG_OBJECTS, using netns topologies where a router namespace
offloads GRE flows to a flowtable:

 - nft "flow add" and tc act_ct, each with IPv4 GRE and ip6gre
 - ip6gre with the default encapsulation limit (plain pings), and
   ttl=1 GRE packets for IPv4
 - 120s stress runs: 6 GRE tunnels plus TCP/UDP traffic, ttl=1
   packets, flowtable deleted and re-added every ~20s

Without this patch every run hits the WARN above and the GRE
conntrack entries are torn down and recreated over and over (hundreds
of NEW events in the stress run); with panic_on_warn=1 the kernel
panics. With it there is no WARN, GRE entries stay offloaded with a
~1 day timeout, and TCP/UDP behave as before. The nft_flowtable.sh,
nft_offload.sh and nft_interface_stress.sh selftests give the same
results with and without this patch.

 net/netfilter/nf_flow_table_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 36bbc7be2f..94502c97ba 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -544,6 +544,7 @@ static void nf_flow_table_extend_ct_timeout(struct nf_conn *ct)
 
 		switch (l4proto) {
 		case IPPROTO_UDP:
+		case IPPROTO_GRE:
 			new_timeout = NF_CT_DAY;
 			break;
 		case IPPROTO_TCP:
-- 
2.43.0

