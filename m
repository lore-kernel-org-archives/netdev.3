Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4D8427F89
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 08:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787042633; cv=none; b=IutEirjC1FLYDyuWx/mNIfK5NwIMANQh7VHKvOG5p3tAQgiduWEQVEkv27JyxgMWfwY57DhmPauFPmNPOkmAgcpsX5tEuuEOG98TjrojmnE9UGrRMKN2fqpIgEXbFvj7sYvZx2pCPfTPlQ8txpaGBuQP/SvaY7CWmfllL3jCQmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787042633; c=relaxed/simple;
	bh=d+AcDrmAxfCa/i22W0Vd49VJJ0xOJNkLTcqi1xjBntg=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=l6cO8LXM4G/rZ+RYF9uYDK/p6JQNQ015KXeyQOn0lLlHuECWgHiTKLhTpn42q1+iOqx7CwWHui1q61uS83dz17hWG3KFohaRrPRV0sk8iB4b6H2somy8FIdVmo7/Dk3flxvysA3hZeTzsSLTIXs5+3eJt/z5ADJe7TWz6DN1a6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=CxgQmK4V; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="CxgQmK4V"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f7027ca11so2646967f8f.3
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 01:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1787042628; x=1787647428; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eF+D7QHXl9Um2Yz/j4UUQPsiIDEgyjQxbmrGMBzdulY=;
        b=CxgQmK4Vr6hI0oa86XRV/kPu3SFkR1LkMpSKRKadNqJ6e9HLLejL8RzsPW5LTL8Krs
         +QK/ZbqvOsgzI4sWbEyJb8Rx2NJHsu4iJf5OnTpANWaWV95T2FluX+QiE8STaRvN0R6V
         +vQOMVTnyrAIRtkWSpGos+snOt54PPJR1G3b46h0KisahqPzt+LC+DlZm7WYWst3ZJgz
         CnNt7hFWNerM1HEqojxpfm9YCxC+Pj5TeC0qGy0mvs2i46owiIuV9GiY/wF5YkKyWDXr
         5iTmMWL4BUBo0D2rdOD+9JYXLssaJU2xf70xyaJkf5mWXoamQ11b+oA3+Y3e6WRVyI1A
         etnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787042628; x=1787647428;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eF+D7QHXl9Um2Yz/j4UUQPsiIDEgyjQxbmrGMBzdulY=;
        b=oiXvMsG6KUfbvJZ6wM2xUvmFes6VpwMbPtvaOcupLnOSuwvHc4ogWdzbJSP0eaxVK0
         tJ1y+/pvyNp1KfbOsdJhg/M+o6W/mFD/8AJ11YBeQeex1juRq70W4KvY3ERQ2YvDlitL
         krC+qtkGhySUBNaWhxTlbOHMOQpgPhj/W7z3Xqzuu5Ak9o+U0j2lXa4lUrVxVYX0GZAF
         OVsyrvLQUtExZNms24Io+Jb+jujhS6AQYY7vQemwhbSNMhjzFImL0PBaaEeSfote/Cq1
         N4rnTn0snBsZwCotk/lM9iZr1epPpJXP2OOExDXyzUwGt/aYt5OIu+M8dnIGXcxXOmIC
         Qtdw==
X-Gm-Message-State: AOJu0YxENn7uAAZ02idt/IoN5GtE+bGRCqkPd9rh60OFaagsveCJn5pu
	3Y+XwFJpSPQXAP85fxxaPIl1/XgtoLeHfOd2Ti+SiJ+18Gl6okesNZ6cCcpnzdXPfnzOBBqoSW2
	g3mj04a3wfA==
X-Gm-Gg: AR+sD13vB+TAaSWjMwkUx2cMIyFt9BxM2YTIKCsMn3wdU47tDgCaO2/NxJYj3YvOMm1
	LJ/DY1cv428uYOtSs2vspde1DLSGzL5E9UWrAZHFpk/Xga4R6goed1mtsLX17ExjKBqOPdIEePS
	vcuk5O6Oymf/2/Rhe+32cTyxPM8YCge3DNftKs4SVLfXQD2UCHXAIhNcKAW2HYK6ogKNa3TxZ6w
	Pu+uboZ37S5TWAiQZSVag7Mn1uHfyJjVMv61knNV58P21GT9BqcdkqjOY1n9jm/ZYWyMuZ7PxVO
	v4hjsLuqbXcuLuizY1Ykf2g0o8u8U8g0QncOQFWWyOAshjA3Xv/1R0ByswCW1YmSZe4f+IywrMG
	S93rQuK87mZVYi9yoZv0fOhVKk4d1UlPFeufpxGEVHear9X5f65k0mJlu7xpPMyta+Hj9Z310/B
	FsqQtW1uObePHtM3hoNfH2Bt2EqzQD2uxjSs9YwRJ8clnaJ5oJraP6fYF45gsSPM0GY7vnjfBu5
	Mla+akACdCthUKwn05RP/NYaoEWq+hWbTn7jFq1T7PWcB+nR8I33MGBx/+TDoafoTkHKF/iIfk9
	rko4UooplWqtl9rmSfChkg==
X-Received: by 2002:a05:6000:29cf:b0:481:5d18:eb9e with SMTP id ffacd0b85a97d-481607833ecmr39396679f8f.17.1787042627694;
        Tue, 18 Aug 2026 01:43:47 -0700 (PDT)
Received: from smtpclient.apple (78-141-71-213.dynamic.orange.sk. [78.141.71.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a7c55bsm9930042f8f.20.2026.08.18.01.43.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Aug 2026 01:43:46 -0700 (PDT)
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
Subject: [PATCH net v3 0/3] net: don't strip zerocopy frag markers from a
 forwarded skb
Message-Id: <F3B9E5BA-0AC1-4AD1-A7D9-F38033304270@doyensec.com>
Date: Tue, 18 Aug 2026 10:43:35 +0200
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

 net/core/skbuff.c          | 10 ++++++----
 net/openvswitch/datapath.c |  3 +--
 2 files changed, 7 insertions(+), 6 deletions(-)

--=20
2.55.0

