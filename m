Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794332888;
	b=n7rZSsMR25g2pyAJ7k2mWf3anMP7eeoELuoT/u3ohKI5BNfh5JY1nwYPWsMAV9dfSRuX
	 lHBHNNZlwq1szST4rAOj+FScbrryiYsml3PyQ+qABdEKXRZqpju3TpQgY6ZWHZtxLXWqO
	 8/E/2ewJpl4QvCRoEK5fmv7rA3NxSsz7rLQ1I+jFZJSvKp3rWi+DBsTdOX1/xZGGGcI0o
	 eMNMwQjuly2a5zO/9XAOvCaahk4anN6xWX5KFNc08ChEO9zy6StFe2T5MNE2I/qiUYy3O
	 2rC0FzBQwCuzjq44ihT3GRpyq3kMy5mY1mIPceJE3NsMoyv28iCzRM/g4/FJ6gJUZyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=SzKxuVoqSAsV9BJQHp/4PHuznXYFgCUHfSMp8c3cdEE=;
	b=28uTuNsmZg5NJvbY63GG3r+3VqslqNAgGu6KzNoHbbmT8AW3Fp6ZbDjtCW4FUhB64k0a
	 F1Jmakwi5D9+ofHGT6KWz4qtZxNQNEPi7dVvXr22e2w+Xsgcm9SLTkAUM/m+W0rqoUXZI
	 qurndQ/uGIMQFzRNln7/xOJ9t29nPFoQnKnuD4Yqw2ZFLMyL8M7cFkcCGpA/Xq1iOxOhh
	 QuXsQGHVFMhnedxZlWYEBFWNs4Wd6OXXzn4stPwD/Jl/bTcZ133rc2DGqlQtI8JeFrb+D
	 TZThFT/+68t8FOgGtoB/QuaYwb5/cZvKB6ttOCUfzSzCxWVGONRgO24DL79tvmRPWTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q8uftFCZ;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E990606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E990606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q8uftFCZ
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-823e4047037so1171271a34.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794332887; x=1794937687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SzKxuVoqSAsV9BJQHp/4PHuznXYFgCUHfSMp8c3cdEE=;
        b=q8uftFCZiGuRpMGXoVrVUSmqHHTd33a5hXYKaBA8awfuH+v6ApSjmpNV6uNNAklP6l
         b+JqE4Z1kf9z9vjmz+R9998Bf7cXDS88x0YiQkiXqZSJhfHQFxkLIah6NnzJ/upGlv1L
         CkWr4uOSobQvEakQNifQHjKGu4HQsESwYg2YM/KlYeSyQdaS7B+bxTNzSE+6OnDq+FWr
         13SHG0QWM4cOQ/yBo/ATcdk/BNk3HXc2khRK30v9BeOADvM9h1mFA/mc8Fp6LK1JUG4+
         J6dkiSkMeB9GrgNZR1aaIRKYDBSSV6YdDvjx4/ohpV1Jyaoq8sPwfcAtYkpxgq4CZP5G
         nY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794332887; x=1794937687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SzKxuVoqSAsV9BJQHp/4PHuznXYFgCUHfSMp8c3cdEE=;
        b=Ps/kC+2mAOlFdZdu4xolBP7Wp8SwRIw7ubSRjiBlQRoUgdJC8SkUY0YnrvLiDbSS9K
         nf80zG4nYL+LNJK6HdHQvwTyyGE5RcDN9hO/o7+/JANhaWYFMG9mC2JJF2omJkcfvuzl
         lt5css3TQHP0BrIye/iqqrdqJDBlp0PO4ZGnkfXgvIq/Qtmp16pI7yBmV6w+p99aY0gj
         DL7Z24DNtIJvFnhjzo90ebNxqCgDw6QPlgBuWzGy/ci+OIBFBddA//8+bwgA731XcdRS
         Bn4OSCVLzhr3mwjsMwBEcgFitvbLBgh37DOmu/JtAO+8+OxLcQOd/Ao4Ptz+akSMJsd9
         95dw==
X-Gm-Message-State: APuU4Z/DIHvR2CPhXP4UTRXFcs3RAqpLClpH3te7Ou1spXrrHAsFJF46
	XBtYt+XNQMr+GPQza5Vx8dkzVxepT59rwfOxFd/cm7VgeFacL9T6Fo9I4MajAVhP
X-Gm-Gg: AYBFou3pTgV/ip1lhB1FkSNkIDHqXewCem5aOnLVfEjPRywVhszA8RcrArnTPlamSYV
	VP5TP1nD+zS+kZ5aNdttoT2pgeMZ4/HAnfA+/MJ2OfFTHuoDHlOGWqWTijnVQJc5J2PdeC/fVZ9
	KtxAP2ZDq+QLb9UameejiVS92w3PtkWpCfVbEdwdOdoy3UmBFMzydydCdCVPloKn5QbwX33rOL9
	yvc1M3t8spKp+BTHWkPGad1wAXiZsIg5hfk2gflCKF1umIjPXI7JOXVXEWDnX0lgNjnPiRJw+5w
	ziE1CYjCD7FLesQ8dKMBb9Gpv4Qt2NFGy6R6I1MDYDD7rLHz7RJjH1rRSpAi3Ip8xlmd34FUcnt
	TGp/oVYOr6SkeAkrWE8M6YmAxBiy/6JkQMfLdqN8Tx7intfUoouCNQkaJt71IPIdBkXLG0OnSKc
	uGEY3gDf45rDgZQXX/5ot27RerDIwc9rTOp2YKGXhzT1L/a9uoAIzO+0F0JVsS4gXfu57uXwpA4
	goWiGX32XGLgoHlWa59nUJaq1Ru3lSnDuntYz11eUr7l4/T7n1dRJkeMiFlm3wdC/FJrMaGGaxT
	x0GKVjG7d/2HIyQYntHvmFTA
X-Received: by 2002:a05:6830:3113:b0:844:a8bf:7dc7 with SMTP id 46e09a7af769-860dc6e32b6mr2889746a34.17.1794332886902;
        Tue, 10 Nov 2026 09:48:06 -0800 (PST)
Received: from houminxi ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dca42411sm2389254a34.1.2026.11.10.09.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 09:48:06 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org
Subject: [PATCH net-next v7 0/2] netlink: specs: fill in the missing ovs operations
Date: Tue, 10 Nov 2026 12:47:49 -0500
Message-ID: <20261110174751.973464-1-houminxi@gmail.com>
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

The ovs specs describe get and new but not the set and del commands the
kernel has registered since the families were added. This series adds
them and names the attributes each handler reads. Nothing here changes
how the kernel behaves.

v7:
https://lore.kernel.org/netdev/20261107120647.874906-1@gmail.com/
  - The ufid docs said a value outside 1-16 octets is read as absent, and
    that a dump ignores the attribute. Only a value longer than 16 octets
    is read as absent. A zero length value fails the policy check before
    the command runs, and the request fails with -ERANGE; a dump accepts
    the attribute and does not read it.
  - The del and key docs said that a del with an out of range ufid
    flushes the data path. That only holds when the request carries no
    key, which the text now says.
  - The get reply list names the last-used time and the TCP flags, which
    ovs_flow_cmd_fill_stats() fills for get and for dump, and the docs of
    the stats, the used time and the TCP flags now say replies and
    notifications rather than notifications only.
  - The vport set doc says what the command does instead of explaining
    why two attributes are missing from the list, and says that the type
    only has to match.
  - The datapath new doc reads as a sentence again, the masks cache size
    records its upper bound of 4096, and the vport new request list gains
    the port number, which its handler reads.
  - Patch 2 says why ifindex is s32, which is to match the policy and
    nla_get_s32_default() in the request path, and that the generated
    reply struct follows with a __s32 field while the reply itself keeps
    putting the value as u32.

v6:
https://lore.kernel.org/netdev/20261103183319.2730567-1-houminxi@gmail.com/
  - A del flushes the data path when it carries no key and no valid ufid,
    not when it carries neither. The kernel reads a ufid outside 1-16
    octets as absent, so such a request flushes as well. The ufid doc now
    says that, and that a new request with such a value indexes the flow
    by its key instead, and the attribute records the minimum length the
    policy enforces. The same sentences in
    include/uapi/linux/openvswitch.h follow.
  - ifindex is declared s32 with a minimum of 0, which is how both
    policies read it. No request used the attribute before this series,
    which is why the type went unnoticed.
  - The ops skip strict and dump validation in the kernel, so get, new,
    del and set say so in all three specs.
  - Rebased onto current net-next.

v5:
https://lore.kernel.org/netdev/20261025103409.3519874-1-houminxi@gmail.com/
  - ovs_flow dump gets a request list of its own with ufid-flags. It
    shared the get list, which offered a key and a ufid the kernel
    ignores on a dump. The reply is unchanged.
  - The key, actions and ufid docs no longer claim those attributes are
    always present, and say what the exceptions are: a ufid-identified
    flow sends no key or actions when the request asked for them to be
    left out, a dump leaves the actions out when they do not fit, and a
    dump ignores the ufid. The same sentences in
    include/uapi/linux/openvswitch.h are updated to match, since the
    spec text was copied from there.
  - The key doc now says a get and a set need a key or a ufid, that a
    new request needs a key, and that a del carrying neither flushes the
    data path.
  - The ovs_datapath new and set docs say per-cpu-pids takes effect only
    when the same request sets OVS_DP_F_DISPATCH_UPCALL_PER_CPU in
    user-features.
  - The ovs_vport set doc says the vport is picked by name or by port
    number, names the rejections in the order the kernel checks them,
    and says upcall-pid is the only attribute that changes state.
  - Rebased onto current net-next after the merge window.

v4:
https://lore.kernel.org/netdev/20261015024132.698658-1-houminxi@gmail.com/
  - ovs_vport set lists port-no and ifindex. lookup_vport() finds a
    vport by name or by port number, and returns -EOPNOTSUPP as soon as
    it sees an ifindex, before the type or the options are looked at.
  - ovs_datapath new lists masks-cache-size, per-cpu-pids and ifindex.
    new calls ovs_dp_change(), which reads the first two, and reads
    ifindex itself.
  - ovs_flow get lists probe. ovs_flow_cmd_get() reads it to decide
    whether to log.
  - The key attribute doc now says a new request needs a key even when
    it finds an existing flow and replaces its actions, and that a dump
    reads neither the key nor the ufid. A del with neither flushes the
    data path, and the del operation doc says so too.

v3:
https://lore.kernel.org/netdev/20261012065552.2426415-1-houminxi@gmail.com/
  - no change since v2.

v2:
https://lore.kernel.org/netdev/20261006130533.1620706-1-houminxi@gmail.com/
  - ovs_flow new lists ufid-flags and probe, which ovs_flow_cmd_new()
    reads.
  - The commit message now says probe changes from binary to flag, and
    that new needs CAP_NET_ADMIN.
  - The key attribute doc no longer says a key is required for every
    request except a dump. get, set and del accept a ufid with no key,
    and only a new flow needs a key. A set that replaces the actions
    still needs a key.

Signed-off-by: Minxi Hou <houminxi@gmail.com>

Minxi Hou (2):
Minxi Hou (2):
  netlink: specs: add ovs_flow del and set operations
  netlink: specs: add ovs datapath and vport set operations

 Documentation/netlink/specs/ovs_datapath.yaml |  36 ++++++-
 Documentation/netlink/specs/ovs_flow.yaml     | 102 ++++++++++++++----
 Documentation/netlink/specs/ovs_vport.yaml    |  29 ++++-
 include/uapi/linux/openvswitch.h              |  35 +++---
 4 files changed, 167 insertions(+), 35 deletions(-)


base-commit: fa5196392691051963726787944db872420dfa75
-- 
2.56.0

