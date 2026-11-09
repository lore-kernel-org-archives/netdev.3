Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794207585;
	b=U39NTyU9Kmcn16KeQJw6EIPd5pLv7p8iRx2YEpNm/yLDcCj222hqAMimrZBFZgQG7Ne5
	 EWT+IUY0qbXv+Zvv2pMq84Gu7tpyFa3T/K04GXdTiqI8GCFpljwGmQX+WXFl9SDrxCp3S
	 r3KCfzrVGWUC3AfGrAAPKI6m5wwFSxzif8qiBmP7fjx1Kczh5Job8Fzk98Eysh59Jde68
	 l2WqHk0BiQ2GNtbHlFWAOwwnWHvfj8gXqxp8kwa4LUgoBO0Z5H6ixyEN0/X3BkIizC0tX
	 uZgKqPA2dUXGbsQp15cff5ykneabwCLloKcilf+ILC61TjE+ZFt6qFDwv6C9cB/U16g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794207585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=aDlR4SU0MvcNZyb7xeT0WLCHbZ3cA560jShE4hSnDVE=;
	b=vogr37WeWHnwmPGZJaraYXOIPxvoAGLakmwBIqOpV7HPXjqCUd96kAcQnvdy414Vj+m9
	 OS+nokCywdyL+SOfgEx5C8l+JTy7z4EfxZdjVPHkP4SHJlY2CHeJBSbgISt/sLgvfj5z/
	 9ylEaRSN78/RtOmt1pPJgcuWiSZUR9k525EjXw2NnUmC/CPaKAC0UdY0Ovq8+R/K2gU4M
	 D0SmxL5HC+ZwrXzAzfPx7hji6nuhr/5BZtaEhth7ahlWIs3rXwXmwme/lvgxtxVBAuvtm
	 ME85UjV6F/5I9sNHlCkhD4upVlKaMKG5CbuqZ5bRWJNI6HtuMBsaU8lfDPSLniR01lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tbRe44DH;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28418606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 06:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28418606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tbRe44DH
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1931ff67a29so1502712c88.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 22:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794207584; x=1794812384; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aDlR4SU0MvcNZyb7xeT0WLCHbZ3cA560jShE4hSnDVE=;
        b=tbRe44DHoaKTBE0C72EgrLerFNS6Nxe+9whEvl6pBknPsrKJ+fq6Lc6GiI3aAqES0Q
         rnvaCHHbc15ppGyUtmKctp9uxLQnGkuVtRmKriUh5IGVuFgTxL/rMh8sFqsj1SzErwGQ
         hb2W4AP4alQnMTawTKG0aNW258uLL2eoCe+OzxOS773WuL5ZUEnesDn94R09U8MWjDYH
         FOi5uZP/C2jE1tDRZWDaOmuY9/Z+v/+0Gs3kXcQVV42Vsia2aQVhKtMYuVDSqJrtmsZD
         wuDGlqJ9zrEOGVA82iRQNp6/9G9ug9gqBjjJouojNHv70vz2qwvQiUhX2VCW6zmINYge
         EqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794207584; x=1794812384;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aDlR4SU0MvcNZyb7xeT0WLCHbZ3cA560jShE4hSnDVE=;
        b=Jr0rhUPc0Op/UmCvVGUkfUbTZsjK5We78P74RX0UNmyBHvsTykZpM0MkynrsIFVvPs
         JMQFoBRoTyKNLmSZIU2UdjhCmj2vJXyJer4VU/OzzZ286CrRtImokH70r3A9qaJL6yE7
         QUchD58EHosWvN6s+foTJY1anBUUn8jcI3R53ab+LpnEiU6hKG0Vszb3nhtYfIeV+v3H
         TBZ6QNliiQbowEqVwMkWVhLjOceFWT6LXq4gJTaHKp7teVTSKsJ3Mhpur5oTMzL4TGdL
         vQ2Mw8mVyYSDo7CQMWDBvJTodDHxJFN8AxEs0Ul4G/FRAIgHxyoEw6ugaTCodhTxL5Tb
         TKtA==
X-Gm-Message-State: APuU4Z8+v/WPFcnEDliltiroP75EOK12GhuASektAKG6teh6lxVhXN8C
	PZb8FeWM+3fA8JSUSSvepVr5aXwMYmapRyKS/GauWL/V4NUxwmXesoYP
X-Gm-Gg: AYBFou0yV/B6HbuXeJQuaRxCLowpP8XEa4q7FPmrjgSkmuXtAwkpXWsIf/O9cFrPaIZ
	/7kfqr2Qoy9BZdFMdT4snPzIKvCt6DTbBnW646Rag87QdmR8nbNug0lHSXrR6D62Pcjd4GXKpLg
	9GlvseKU7JvhSjSYXmuXqlSQJz3lXYFhRNTTG68/fQlusHairVwD0GSusIy+1z4BFH8z8cW6UI1
	Kd3dKkPhvNh83wXYjO3kFwmZeHDUgq6/cUDi4aV/pdmagWXzH16ZXVckrO9FxiOTyM2HrJKrr6F
	NsKbP+Hhr22WSauGutafxp8Dixg8VYrYfu7p4unf5TqfIfHX1UzvPUojjd7CEkf0V9/mwJMt1Wv
	vhD5uUMuafzh+1l0eiPyvqUEzuXRmqeKDeUJlEO13wr14bzHBpggXUfWZ6z8KteWRXUixZBYary
	mbLR+quCnZ6v8bKUGlSkFu+vWm1tZcMJKJpnO3+9bNH+wamAPOo6IblR59bZqRqGyM77RRlFYBB
	3ZlEGz+wYEvyAFEdPRSCBbxO9birZTKzZmei1vk11Y6/fEEn4zpIMs0zqMZMkDfGD4GIGfPISp4
	x0UaGoy+PPH0a4AWrn8eSn758xmDJKWMqgoCdspQX5ju1vg=
X-Received: by 2002:a05:7023:a44:b0:16c:4eef:a526 with SMTP id a92af1059eb24-1b39fece490mr5565074c88.15.1794207583872;
        Sun, 08 Nov 2026 22:59:43 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372669d2826sm11471893eec.29.2026.11.08.22.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:59:43 -0800 (PST)
Date: Mon, 9 Nov 2026 15:59:39 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mat Martineau <martineau@kernel.org>
Cc: netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net] tcp: reject v4mapped source addresses in IPv6 SYN cookie
 ACKs
Message-ID: <avFvW7nn7GIZmZ-a@v4bel>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit dcc32f4f183a ("ipv6: weaken the v4mapped source check") removed
the v4mapped source address check from the IPv6 input path and moved
the TCP check to tcp_v6_conn_request(). The check is applied to SYN
packets handled by tcp_v6_conn_request(). However, an ACK that passes
SYN cookie validation is handled by cookie_v6_check() without passing
through tcp_v6_conn_request().

cookie_v6_check() initializes the IPv6 address fields of the request
socket, but not its IPv4 address fields. In the normal SYN cookie case,
inet_csk_clone_lock() copies those uninitialized IPv4 address fields
to the child socket.

The child is an AF_INET6 socket, but its remote IPv6 address is
v4mapped. sk_ehashfn() therefore uses the IPv4 address fields and TCP
ports to compute the hash. The child is then inserted into ehash with
that hash.

tcp_v4_err() uses __inet_lookup_established(), which does not exclude
AF_INET6 sockets. An ICMPv4 error can therefore find this child socket
if its quoted IPv4 tuple matches and the interface and sequence checks
pass.

For testing, the PoC used a server helper to construct an ACK with a
v4mapped source address that passed SYN cookie validation. Before
accept(), a matching ICMPv4 Fragmentation Needed message passed the
socket lookup and sequence checks in tcp_v4_err().

At that point sock_owned_by_user() returned false, so tcp_v4_err()
called tcp_v4_mtu_reduced() directly. inet_csk_rebuild_route() then
created an IPv4 rtable and cached it in the socket.

When the socket next transmitted over IPv6, ipv4_dst_check() returned
the cached rtable. ip6_xmit() then called ip6_dst_idev(), which
interpreted the rtable as struct rt6_info and read rt6i_idev. KASAN
reported a read of 8 bytes starting 32 bytes past the end of an rtable
object whose size was 176 bytes.

KASAN report:

  BUG: KASAN: slab-out-of-bounds in ip6_xmit+0x119/0xb10
  Read of size 8 at addr ffff88810356a9d0 by task target-server/79
  ...
  Call Trace:
   <TASK>
   ...
   ip6_xmit+0x119/0xb10
   ...
   inet6_csk_xmit+0x124/0x1d0
   __tcp_transmit_skb+0xda0/0x1be0
   ...
   tcp_write_xmit+0x985/0x2f80
   __tcp_push_pending_frames+0x5a/0x150
   tcp_sendmsg_locked+0xe7f/0x1b60
   ...
   </TASK>
  ...
  Allocated by task 0:
   ...
   dst_alloc+0x52/0x250
   rt_dst_alloc+0x33/0x170
   ip_route_output_key_hash_rcu+0x6df/0xe20
   ip_route_output_flow+0xab/0x160
   inet_csk_rebuild_route+0x2a8/0x300
   inet_csk_update_pmtu+0x85/0xb0
   tcp_v4_mtu_reduced+0x52/0x170
   tcp_v4_err+0x651/0x710
   icmp_unreach+0x1c7/0x370
   icmp_rcv+0x466/0x5a0
   ...
  The buggy address belongs to the object at ffff88810356a900
   which belongs to the cache rtable of size 176
  The buggy address is located 32 bytes to the right of
   allocated 176-byte region [ffff88810356a900, ffff88810356a9b0)

Reject v4mapped source addresses in cookie_v6_check() before creating
the child socket. As in tcp_v6_conn_request(), increment
IPSTATS_MIB_INHDRERRORS and drop the packet.

Fixes: dcc32f4f183a ("ipv6: weaken the v4mapped source check")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/ipv6/syncookies.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index b581cb1ee2e8a..6c5bb4bbd349c 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -189,6 +189,12 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	    !th->ack || th->rst)
 		goto out;
 
+	if (ipv6_addr_v4mapped(&ipv6_hdr(skb)->saddr)) {
+		__IP6_INC_STATS(net, NULL, IPSTATS_MIB_INHDRERRORS);
+		SKB_DR_SET(reason, IP_INHDR);
+		goto out_drop;
+	}
+
 	if (cookie_bpf_ok(skb)) {
 		req = cookie_bpf_check(sk, skb);
 	} else {
-- 
2.43.0

