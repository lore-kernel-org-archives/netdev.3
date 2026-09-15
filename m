Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799EB45563C
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 19:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789502160; cv=none; b=dfdls4fYOb4cC1A+uPVqptZ2aFyCV6Llq0mF1Ey0J8EYY0IuNW0kS+RPNJDqt8QwddA0mkP7exEwo+BEDRHVxdgmpc/8l5Kf/URpIx/KgdTaUCrnNMYW9oztbwjEcarQYzL5iDdFDM+INfX9GP2vdUYAqKzeGeFPz0xzi6Lo8nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789502160; c=relaxed/simple;
	bh=jrv2n3UsjXfobuwALu1G+A5+pU0CPVohtvuwd05zAsQ=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=XfEUPlLnEsCKs7zIWOujAwRO0J6dP/oRvULrGb/rGdxe2SAklZb/c/al/UjK9Dc46caCm9eGmkCbqPtI1tmKjvyFhu/6FssFOiddlnC8Sin/5fG5pcM3MDqFd0kO7aehq3/iq8JhBhWCQP3dSbE8qjSETtXlLIpAjCI/fR8C8s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=BFvoQIL9; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="BFvoQIL9"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6063d7dc4so317633a12.3
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1789502156; x=1790106956; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8BdL/nTWbKRgylMc5hg7bQyOMQwMDBoJsjLllCCKqYo=;
        b=BFvoQIL9RTbpuv94wU/OLRA2wWPbcUnFmGR9mjRF0Kwi9Se7O65PudziwFwNoxgjcg
         SpSbzhROR9zp827DfUH4JavVHg8wuaHLiIi4mTbgRG8Jiq7ivrETsZ/DUbWTzMacR6iD
         W3UEF/VorIOVXJmIs5ikbrec3iL23F9m/tpdFeQAzM4ox4pQtInRnHQl/lgPbF3ZVQOx
         v+vP51dYyDU4Q0bhIqOXsBCrQ6YUGqS/Ww1AyeNGPhhORxfFl9vGmduWGH8/TIyBtUJ7
         687zJwiX43uW8ZyrPwpI6bar+e4ojs8oFittNsPlIGybwSTjMkWnagptSK/cfnXTbCVv
         uobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789502156; x=1790106956;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8BdL/nTWbKRgylMc5hg7bQyOMQwMDBoJsjLllCCKqYo=;
        b=gMxT8KtR+FLWzbsjuI5w7afu+XkTj/tEkhMLkvSk95BXzB+Ju+imQfyu4MCxpmxX3P
         s0cufh/hTG8/+Bd3WlSnR9nWYiPRr+9icODfFzVDyQ7JK6waKQkW0gJJKLA5H+mad4RU
         BpYkt2egoPGFVrWFmRfcYynxMEtSvR3YPvFyZXuRGkg/D5KjfCRHiASVJI4Xubn2zHTF
         yilqR7cR4M6mHV30kRADrXPOfEpFtJhiWtMZta+4S4nyP1LuJKoecIOCAcs5juJUhX5x
         m5XNnwwMXwa+e9NeMRB937FR26FOOrVfORsK5xfDIJQYhhV8HD7KlzKmvNYbPZ3+qzcM
         XHRg==
X-Gm-Message-State: AFuF++m5DjxanVi8i5OmFh4SedQIwLjWRTagN+lw612NiBoL5Ea09xc/
	nG2vg+AHJzr/1SJ56dIB4kj/Mnc4cIcvhaxlS+2tzeeA2YjlwikbJfPRUG40AcEIz1SK7at3Kqi
	EpXVrdCy/+A==
X-Gm-Gg: AYBFou3n1SeKSoxW9LjM+IsbZJJnRQ/bXWS9U2zAZM1utOg0jdcZYe+piNpw8+oR0dx
	DxrPhl1bfKmloxnW89q5Z9Zv6A0Y5YhZT5QwOdPlDhDF5g/7gxz04VaQ4c2reBWLiF/KJXHUwOT
	CK8MyRE2QGwOUhstFysfTVmRQ9qhJzNAEUd+87fbdbQmolzqVwyXsJ8/8O23dGdAyCu9hQ6IVpi
	gDZqO+8fXdMzm3Ca2BLXBLqETTdjKQ0ZKXxN51Hn/4ZM5Na/8nVASNQ/wpbFMy477BtOQq8JxXf
	HJs7gYQ3TC7oXkvXEhNeNBhZxFoE5eLToErJs0l4/mdkquFq2rLgbVJXaZI7yq4OW66hu5CSbZx
	X66BzUmioKJ1VqMpjhE2a0ybYMvDx4CVWGBpFp2vf3thNtQMjeMQlFWnCDbU0Qpb3Y0CTFHxonZ
	ppYPW8mh0atg+DFjYCR/FdOuKNXc0gjHiuTmNAkP3V5JsPGJt+I7YtVSJegb+y7FYl4/tHkVgIr
	PBAL5g0fUQwb+6hCRDTXadjH8VfGvYPH1WhKyONr5BACB1UR7uHhMBejw==
X-Received: by 2002:a05:6402:5406:b0:6a6:32f9:e9f1 with SMTP id 4fb4d7f45d1cf-6a9f6377c5emr12290444a12.20.1789502155390;
        Tue, 15 Sep 2026 12:55:55 -0700 (PDT)
Received: from smtpclient.apple (83.10.8.214.ipv4.supernova.orange.pl. [83.10.8.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa1cfe07e4sm205239a12.2.2026.09.15.12.55.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2026 12:55:54 -0700 (PDT)
From: Norbert Szetei <norbert@doyensec.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: [PATCH net] openvswitch: reject a negative transport length in the
 IPv6 L4 checksum update
Message-Id: <114FAFBD-F7BC-46AE-AF9F-0D15124F130E@doyensec.com>
Date: Tue, 15 Sep 2026 21:55:43 +0200
Cc: Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 dev@openvswitch.org,
 linux-kernel@vger.kernel.org
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3864.700.51.1.1)

update_ipv6_checksum() computes

	int transport_len =3D skb->len - skb_transport_offset(skb);

and gates the L4 access on

	if (likely(transport_len >=3D sizeof(struct tcphdr)))

sizeof yields size_t, so transport_len is converted to unsigned and =
every
negative value passes the guard.  inet_proto_csum_replace16() then reads
the transport checksum field out of bounds, and writes the updated value
back to the same address:

  BUG: KASAN: slab-use-after-free in =
inet_proto_csum_replace16+0x445/0x470
  Read of size 2 at addr ffff888131a4cb06 by task ovs_ipv6_oob/696
  CPU: 3 UID: 1000 PID: 696 Comm: ovs_ipv6_oob Tainted: G N 7.3.0-rc2+ =
#338
  Call Trace:
   inet_proto_csum_replace16+0x445/0x470
   set_ipv6_addr+0x3dd/0x460
   do_execute_actions+0x6a3d/0x7c40
   ovs_execute_actions+0xfd/0x480
   ovs_packet_cmd_execute+0xc38/0xf20
   genl_rcv_msg+0x59e/0x870
   netlink_rcv_skb+0x18b/0x450
   genl_rcv+0x2d/0x40
   netlink_unicast+0x6bc/0xa20

  The buggy address belongs to the object at ffff888131a4c980
   which belongs to the cache skbuff_small_head of size 704
  The buggy address is located 390 bytes inside of
   freed 704-byte region [ffff888131a4c980, ffff888131a4cc40)

ipv6_find_hdr() walks the extension header chain, skipping each header
by the length that header itself declares, and ipv6_optlen() returns up
to 2048.  The last skip is never checked against skb->len, and
parse_ipv6hdr() installs the result as the transport header.

Reject a negative length.

Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
---
Reproducer available on request.

 net/openvswitch/actions.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index dc5ff859f114..4fdc08cca058 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -360,6 +360,9 @@ static void update_ipv6_checksum(struct sk_buff =
*skb, u8 l4_proto,
 {
 	int transport_len =3D skb->len - skb_transport_offset(skb);
=20
+	if (unlikely(transport_len < 0))
+		return;
+
 	if (l4_proto =3D=3D NEXTHDR_TCP) {
 		if (likely(transport_len >=3D sizeof(struct tcphdr)))
 			inet_proto_csum_replace16(&tcp_hdr(skb)->check, =
skb,
--=20
2.55.0

