Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD58638D6A2
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787389825; cv=none; b=RPGO1kid7/g/1cb4jBN/1wboaL7/wLOrzfYwOq69pvWnDzHIXG93hKe63B7H2CpoLmOP9fKU0fZ6CrOjxwo3o6+Xntes3buZ20n1SVhcBiQ0jDSPIZU91nxh6q2UHTagDrjFjazFS1361D/edQn7t43po1v5UF6kPnpWjci9wag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787389825; c=relaxed/simple;
	bh=g61Q7meI59V8lUroCSzctVsJUOyOlfKbSpw9XUkVZ60=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=gyYF2CpDojTwz6Bpg5yZomolUacR4SDdlGLaXw0GHaELSRGwBHVRpCKqVIUopegC3vKrXqp+36TiJJk2N89ck7AL7O/nPLcYO8kSOAd0ol1cuIV21D43NoOdUdZLnTeawKjlbrckILFQu5aIDYof3bS98CuC8XOkrWO6OVfdd5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=ZaIoKjxH; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="ZaIoKjxH"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a082b3671fso3051868a12.3
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 02:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1787389822; x=1787994622; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NGycyJVIW/OPIaiabbiESbEirLCCLD6vpNHjVSKQh1I=;
        b=ZaIoKjxHU4lZAoheA49TmejxsmuPVHc7tZVB/wgRfTnRfaH1ueo+cd0w+HkIcqfMAe
         47wxn8t0jLp1feGw5IVysLcUp7K55gtB1nQUYBGqRV4nEKzk9whMMobLZTdK2evA7FMY
         kExmudcwQkIVOY2ksU9rkg5fISPOOupuvE/vwnBeuumz22PV3Q8n5CjGBHurv2ysnkjE
         R+TKMZ4wVLiTv7kLfMT3KC141oX3ccKe2WXUr+eX8y9URptd8jQpokZH5nPTRYLKkk6n
         kvF7kXttL/wJtfBGxpznH4gThJa1Cx90ko/J2V+6a3SIEH0NvF2bCD9kMOheovpf9xsW
         /RhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787389822; x=1787994622;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NGycyJVIW/OPIaiabbiESbEirLCCLD6vpNHjVSKQh1I=;
        b=Uwa4VqgtDXAeFmDI2/ASUMt1Uq/4E58wksCpB87H7zP8yRc92FMdKsDN7s7v+tU0PU
         7TcJcUN/pPFA1UuC0GIIqYG5at7PuActuOkvrpvq8s65ZZVF3mf8XYoRBm+JrdR5DFzr
         2NlufXVT1iXv5pMTANd+yutyM4TLEx2Zu0B7pw39WSNLCBUK6rdB7em6wsCBwTtyallE
         ub4XQSEKxwaa1KJOqLc0ESASitBKAqtPNh0mScnpw/1xcbtrgiW/ZUt952N3c8CyYp3+
         UHlqwBEMszDbouHQrjsbWe4dlYzVm/SHooomeWKnhLf+J+DPZxTsLFERupmeEdI0wE59
         v2Rw==
X-Gm-Message-State: AFuF++m3eN/rVIH9yVkNjWDFRnl1zxIQFP1U3yHGERW3PG7fMst5vUkL
	fWRlSAy54eZpxK0H/OAWjibGEhiNHObzgynhJ0N76sk84GX6pAEllgU3xTlwyAukMfdhO7MslL7
	t6jslnP1fyA==
X-Gm-Gg: AR+sD12ZkRQ7Cs0pBqHNMnykHteBehZ+2YO4boU4mCtyPVY/Xhwn+FiBrHUc7R28N8e
	TRLeNlQv/fhVjNkZngDwVDKPfgwGIeEp8nZntL3bsE0ywe4EVTa4uyKxNC5v+Qlvi1aBe9bZfRF
	v7rX2CYKGk7XkTwxjVoCSrtkynaOeHURt+cbtu3NmtBKeNzu48UseHIsTolfa7Cegir4Q0CNXFe
	s6LtP78DvUmusMh09GGpRGUR7pc6KypCmCJLWnFoV/xt3zWjgNkRD5wxgfejoTacdNsB0aXIzJP
	D9wmcrrR0JJNbNz73pbsCUluqRWZ5uD8pKvPd97pL0NgptKrBXguZt8+zruF0dG+QzzwHTuXkgt
	WLRXwiTUmoacilHEvQwL0QLrZ+MV8efmYMw31vFvMMLnAypmlDVhm7o/yUzLnMI2zDNdqJKHrhQ
	4Qzz5SduwN9PrhPOfbzRbIruI3GLEjzf9/TaFbqxUlIyOGILm3iC6oGGaWapd1bGLlag8w9DUXP
	ZpZElZy6eU1j7ftvQc6WxUOWRmRZBT/4GD1cupuxr/uRq0S823O4byiz8nS4m1isSufaN6+rjPQ
	dbv06SK1XcEd2aDjzQwecWC4E+eGc1r3
X-Received: by 2002:a17:906:99c4:b0:c20:af9d:4544 with SMTP id a640c23a62f3a-c246a4e6388mr1169614066b.6.1787389821846;
        Sat, 22 Aug 2026 02:10:21 -0700 (PDT)
Received: from smtpclient.apple (78-141-71-213.dynamic.orange.sk. [78.141.71.213])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2495ee5295sm237495266b.0.2026.08.22.02.10.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Aug 2026 02:10:21 -0700 (PDT)
From: Norbert Szetei <norbert@doyensec.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: [PATCH net v4 0/3] net: don't strip zerocopy frag markers from a
 forwarded skb
Message-Id: <4B5CCA6E-2C49-4F86-8C4E-E1BE15C16C0A@doyensec.com>
Date: Sat, 22 Aug 2026 11:10:09 +0200
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Kuan-Ting Chen <h3xrabbit@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Willem de Bruijn <willemb@google.com>,
 linux-kernel@vger.kernel.org,
 dev@openvswitch.org,
 Jongmin Jang <payload.jang@gmail.com>
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.4)

queue_userspace_packet() calls skb_tx_error() on the packet skb in its
error path, but it only borrows that skb: on the =
OVS_ACTION_ATTR_USERSPACE
action path do_execute_actions() ignores output_userspace()'s return =
value
and keeps forwarding the same skb through the flow's remaining actions.
skb_tx_error() completes the zerocopy uarg and clears =
SKBFL_ALL_ZEROCOPY,
and with it SKBFL_SHARED_FRAG.

For a MSG_ZEROCOPY skb carrying page-cache frags, SKBFL_SHARED_FRAG is
what makes esp_input() skb_cow_data() instead of taking the in-place =
AEAD
path. Once it is stripped, a later local ESP delivery decrypts in place
over pages the sender still shares with the page cache.

Patch 1 moves the skb_tx_error() into the one path that does drop the
packet, the "default" arm of ovs_dp_process_packet()'s switch(error).

Patch 2 removes a second such strip, in skb_zerocopy(), which calls
skb_tx_error() on its source when skb_orphan_frags() fails. A copy =
helper
should not perform a destructive action on its source, and both callers
already report the error on their own drop path. MSG_ZEROCOPY skbs =
cannot
reach that one -- SKBFL_DONT_ORPHAN makes skb_orphan_frags() return =
early
-- but producers that do not set that flag, such as vhost-net, can.
Patch 3 is new in v2. It stops skb_tx_error() from touching skb_shinfo()
state that is shared with clones, so patch 1's new call site cannot =
reach
a live skb either. For a non-last OVS_ACTION_ATTR_RECIRC action
clone_execute() sends a skb_clone() into ovs_dp_process_packet() while
do_execute_actions() keeps forwarding the original, and skb_clone() does
not privatise the frags for these skbs -- skb_orphan_frags() returns =
early
on SKBFL_DONT_ORPHAN -- so a flow miss on the clone strips
SKBFL_SHARED_FRAG from the packet still in flight. Confirmed on a KASAN
build with a flow matching recirc_id 0 and actions RECIRC(1),OUTPUT(0):
with patches 1 and 2 applied it still reproduces the page-cache write,
with patch 3 on top it no longer does (5/5 runs). A kprobe on
skb_tx_error() shows the datapath drop path is still reached in both
cases, so the difference is the guard and not the reproducer.

As Ilya noted, that makes patch 3 the general fix -- an skb can enter =
any
skb_tx_error() caller already cloned elsewhere in the stack -- while
patches 1 and 2 keep the callers from acting on an skb they do not own.
Removing skb_tx_error() altogether looks like the right long-term =
cleanup
and is planned as a net-next follow-up.

v4:
  - rebased on net after commit 68d8c6532659 ("net: core: propagate
    unreadable flag in skb_zerocopy"); patch 2 now only drops the
    skb_tx_error() call from the error block, the -EFAULT/put_page()
    handling added there stays (Ilya Maximets, Jakub Kicinski)
  - Reviewed-by from Ilya Maximets picked up on patch 3
  - v3: =
https://lore.kernel.org/netdev/F3B9E5BA-0AC1-4AD1-A7D9-F38033304270@doyens=
ec.com/

v3:
  - patch 3: Fixes tag corrected to 25121173f7b1 ("skb: api to report
    errors for zero copy skbs"), the commit that added skb_tx_error()
    (Ilya Maximets)
  - Tested-by from Jongmin Jang picked up on patches 1 and 3
  - v2: =
https://lore.kernel.org/netdev/AD1B7BEE-C04C-4A1B-982C-8385F1908911@doyens=
ec.com/

v2:
  - new patch 3: skip the shared skb_shinfo() work in skb_tx_error() =
when
    the skb is cloned, which also covers the OVS_ACTION_ATTR_RECIRC path
    that patch 1 alone leaves open (suggested by Ilya Maximets)
  - patches 1 and 2 unchanged, Reviewed-by from Ilya Maximets picked up
  - v1: =
https://lore.kernel.org/netdev/8063260C-05C9-4997-B9B6-2135063C4858@doyens=
ec.com/

Norbert Szetei (3):
  openvswitch: only skb_tx_error() a packet we are about to drop
  net: skbuff: don't skb_tx_error() the source skb in skb_zerocopy()
  net: skbuff: don't touch shared zerocopy state in skb_tx_error()

 net/core/skbuff.c          | 6 ++++--
 net/openvswitch/datapath.c | 3 +--
 2 files changed, 5 insertions(+), 4 deletions(-)

--=20
2.55.0=
