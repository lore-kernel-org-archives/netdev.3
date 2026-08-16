Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564ED3D3326
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 06:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786862917; cv=none; b=QM1KnRe98lyi51a3ytTJzJgyUE8hUZF8Idkc6S3L8WjjTxsTjraWy8Ds9zK03ion1mk0o2jk+l5fdbIVsALgRDUKw51VK4LYfwvSY2GewCCuK5WRSoQ0kViMVQ8sRM0WzdE0DmmSxC0nYE5E7ESGdSJoU6Sg+P58VHw8BpCdsm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786862917; c=relaxed/simple;
	bh=F+bGEiS5gw0FZej2DVGzweBwyXymBwF74IVfFGxRT58=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=mHigz5boZbgN4Rw7omBaH1IyevF2ktDXmJEA0d3HVqE8Prb04bLkwEcreBX//4ZaQwfvh/1OpuCJF5hrjTtc6PDt3x8O/pvsoSs3mape529OYJOGeLcwqMsDI9NokIjhgxBNs5uwVscsaMICElIjkkb+cxkeJUKIneR7UydSgCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=RDJ2l4wm; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="RDJ2l4wm"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f633e6058so2102879f8f.0
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 23:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1786862913; x=1787467713; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0R0Zw/HkUDZMbi5hHNtxhDJIPUOrTmG22sQlP42xSfw=;
        b=RDJ2l4wmxQbL1cZGgtjsxsSCskNccmSTaDpdz6i8HWyHBvRYzjJ4hsF0R9E84Ha47w
         1Hi90UdoSlR27Erkl8djHLvbV57CXLYkpyOl8g9CzL81HWsSK2Vl7v+9ywUvK/hFRI+x
         dGv0uuQA8+h85PrS1GjO2lX1PDzXuMVv7RicQ34ckuUVVZbghXTmPii2aqkORvVwV+CB
         84Ka6DaIN/XGPpd3dULasGWmt0eof0Fn9NrQvJhjhb7Ic/Yv6eH534hesqO21bqBSU7O
         M0fz09oEpBwe6tWMYD2kRTvbn7YG5sp7tR9UKhM2mSjk8jizdIxvcP8MVOw/5ZB27AEj
         69Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786862913; x=1787467713;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0R0Zw/HkUDZMbi5hHNtxhDJIPUOrTmG22sQlP42xSfw=;
        b=pLdiuQZioq0wqAMizVTW+l5gg/5gqYOqQ8oX6UPBpxknJNgVrqAZhpgGFyZnmbYNiy
         QZ5nPlcaxA7Kg0bgcCBqp9ztqKsZorCYA5JK7OOGEm9uUgtQ9iNBPHLNBCGviJfO72rE
         EylBVBpLfbGFh1GjR7ccnEER7TfWAxP826t0JrykLmYr8fxysuxrod/EeaFinyQVX2Jh
         7nxk7ybys6pZv3YfWmz/jOs6DWNyke7+KHcBAm1pOxmmnlWVz3AYo4ko175pVrGKkgxm
         RIE9oLtr+PqzUQbAESoUK5YtvvJWGm0DCPGenUKD2GLJgtZXX283+8LvpCRNOej96EVg
         PyEw==
X-Gm-Message-State: AOJu0YwNE8Wf+4jQc2vNpeAQV3FiiusOVm9P50cDcEkhbjlIy3IrxcqH
	MDIblUPvjAcwnP101sv6AlJoCMtEGcgb2fDedTqtp97CNMolvjkZHuh8Gr3KarQeTrpLYKBBL/p
	bwrMHTJ7/4w==
X-Gm-Gg: AR+sD13Ihc5LP+TBVQ8Y/BCv+DRCujhUzvu/uQN/NHlOoqdJK3iSeEceo8e87PElxWl
	sRpHOHgEPRAzaPoRXWxvI1vxhOXFq9b1gS0EFQj4SsZgFaJQLVvGRevCnSLl4Qj/7HP5cYZJW1U
	8MALJ6SPKowEmUyqRAPcLVm5GBrqimukg3FxKcpASg+FPjxq9FgchWcrEfiy7spP4NpUivRNaEs
	DmluV5IzgEFy4qBlJ8TlLHr8SoxqfkWHopqMivttccE0v3PgCBqvh08a24tzjemGEcuTZZeq5T8
	lhhpBICZN9VNPD9rov8TGnafSnAIl164JJjUB+0FwZzTaw544uBmox3w3OLhertOphFjnKCAHeV
	EDcESHxoN5fdVlTqFI5xW6HgrTZF1vC4J7RvBlHq3tjWaqKhtsk8Z0GlFGilY4LC2xR2V33SO26
	kMPLFCHMUjMT0Jf3iNEfAP7YG5a2VaMZRvoLYyUiil7nChE+pCb+QU0gVhaXW6tXADAyiDb3kI8
	bbZ/sepF+xjzgs0zHvKVF32hTTMm2tHqniMWcMMjatvM5AQ+mi1Pw7K+8/4f912IxpsKgbVXpzN
	gkRfIRwjqzXcsaGuUo86AA==
X-Received: by 2002:a05:6000:18a6:b0:47f:5ec2:d54 with SMTP id ffacd0b85a97d-481607351d6mr27938390f8f.5.1786862913396;
        Sat, 15 Aug 2026 23:48:33 -0700 (PDT)
Received: from smtpclient.apple (78-141-71-213.dynamic.orange.sk. [78.141.71.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c6115sm21793691f8f.32.2026.08.15.23.48.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Aug 2026 23:48:32 -0700 (PDT)
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
Subject: [PATCH net v2 0/3] net: don't strip zerocopy frag markers from a
 forwarded skb
Message-Id: <AD1B7BEE-C04C-4A1B-982C-8385F1908911@doyensec.com>
Date: Sun, 16 Aug 2026 08:48:21 +0200
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>,
 linux-kernel@vger.kernel.org,
 dev@openvswitch.org
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
-- but producers that do not set that flag, such as af_packet's TX_RING
path, can.

Patch 3 is new in v2. It stops skb_tx_error() from touching skb_shinfo()
state that is shared with clones, so patch 1's new call site cannot =
reach
a live skb either. For a non-last OVS_ACTION_ATTR_RECIRC action
clone_execute() sends a skb_clone() into ovs_dp_process_packet() while
do_execute_actions() keeps forwarding the original, and skb_clone() does
not privatise the frags for these skbs -- skb_orphan_frags() returns =
early
on SKBFL_DONT_ORPHAN -- so a flow miss on the clone strips
SKBFL_SHARED_FRAG from the packet still in flight.

As Ilya noted, that makes patch 3 the general fix -- an skb can enter =
any
skb_tx_error() caller already cloned elsewhere in the stack -- while
patches 1 and 2 keep the callers from acting on an skb they do not own.
Removing skb_tx_error() altogether looks like the right long-term =
cleanup
and is planned as a net-next follow-up.

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

 net/core/skbuff.c          | 10 ++++++----
 net/openvswitch/datapath.c |  3 +--
 2 files changed, 7 insertions(+), 6 deletions(-)

--=20
2.55.0

