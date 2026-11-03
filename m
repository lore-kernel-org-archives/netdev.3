Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730815;
	b=ctTYkhgnjUGfEpyHguVJNSe4H2huAUEo3KIeaCLvd9eo68C325P7hL034puHtcrwW6f8
	 FtnJKOBucGG0iYq33aKrxM+4HHJdXbToIuwJfiEQfGcBr3n6gVmpFgElnck/C2jtIBpPV
	 bGmz3NSOLoGcnZ7NE7Cfpi+ZTveplVVFsR6u54cXVz5QGb3lKeDRUhzkl7/oIM/Ufowy+
	 NHxOzi1asQLk9mBCdt5/0SEsOkqoly8nRYsbF9CXJNSYnOf6uwWKBkIHNYFcGq9jVrv31
	 B0nd8GPTrHNT6vHzUK8u+ASve3IXhOo1GhhBMam8CXe2JVsNN7UWq0RmHX1fqz6P1yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730815;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=yY3MeG81OT2ZjM+fXhqc4xQSnDhP0u6R6+5yw+rjVag=;
	b=c8UQq8CeDI/+lYmOTcBwLlvApyGDYF+DDxz61npe/Y1C5/lQztjpNS3ivTEh3ue2cOHb
	 Hv8zPkmWn+jBaTJs+RMdxzjG8+XrQxFesfxCm/aRRJvpNnh0SylupXHMupDBQIDQco+eV
	 iNoogYMfsCFnOiyWNTavrp06i0y/sKDEXOTOoNRWez4xha1GYH3wY/q1cHpfyy1g/c7o5
	 az7520OqE97YAGfVybc/zRBHvvbhV2OK89pmsnoDGjtiOmHHrYeep6KmgUxzJr6gywzw0
	 z/17BZvwlwe2IhBo+2yl4eBVds8ImfCYKWYIkLAZLQ74S8uQlSm3w6h9X5rWW1ONv+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NF5k3H2O;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51BB606A326
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 18:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D51BB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NF5k3H2O
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93f1cf92c9eso423941385a.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 10:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793730814; x=1794335614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yY3MeG81OT2ZjM+fXhqc4xQSnDhP0u6R6+5yw+rjVag=;
        b=NF5k3H2OMGdP6+mVYUtUjcFuJwZDoHpvCKv1GA8S3kE020Qp/xH0nG4H5qzI1hMj2A
         KeV5DeL665B7dDf0Ear/igKl64/TY9cdtSAZgdBOk17QO8/KwZ9RI4b+LE7h2vjp3i61
         94+THhu/Zm7smAW7P06xXJMVr29G+OeitwinJnvW9owIF2mn9eLhXsoLykNQbECNHBud
         Ihv/9xuoTtSVtXFoMft+9SGzmRVh7Tik9e9ZJ2uWDyHf3T/sKphJOj6GIF8KKMe6/w9q
         CcP+/d7Dvz5UKxiraBjQiUhQ3JQAhm/VrIs3nxrPMVYuC0Akx3IT8pIzAt9A5/RUjmpP
         BheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793730814; x=1794335614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yY3MeG81OT2ZjM+fXhqc4xQSnDhP0u6R6+5yw+rjVag=;
        b=aa7DfjkyJSmpzGoBr2hy32hihx5oOjYGiWvJbqoTdaQBSkl8QunOWthfWx5xwPbdly
         wyQLKQHLGxZlo+nPw5JKOh4mIBxCp+SbBTsv0KTfoOvQK86BS0PtVjnkyv0IhbCjvakF
         umDVBCrYwogPBgELBBbNltqd6tlz+buD9We2SdoJYTHLckrL+Kdf9KcvlXRtLCZe8tX7
         KPMnIUxiELodegU6Q8QeQKia74Go+6AB3NjTEASaN1TJoMeW0PZSyQv4ZCAFA0ax3YXi
         LAucz+gb7XtQrvyAYnX/IoFhMNIs7ZzoWSL6D+T4k83BvQ5xodMA+nUHpCC2XLJm9Rns
         taEA==
X-Gm-Message-State: APuU4Z/OySf/g1GxyhYJ9gAVVJfgjQdsmIjj7SJjjrxGkPQB7+6AGfGA
	41UI9w1QTEF1+jtlbOrY4qPZCvboBoauW6eLlz0k1n/dySN7xxxeqODUCzhGirzG
X-Gm-Gg: AYBFou01fQGZjSDRfWzJQcCHLX5jwoc4mBTQY5jIPvOHeaCcmjpVODHVC/vpuR6fSLg
	ZwxdfUZj5vRcJKBMqLorJSWGQAZA1bDhCXIz46TQiy4LvK3kjOhax0UR0EDTpW54eXKdiBJneia
	2M/dW7GYZ6/W+Qax8AJpAziLFGv0BERH6bZCE1GDPZqx0hIxkCzJbBM/fb8gyjRhj/iCbcqocQC
	lWXKe7Ngnj2lnxD5M4fjHzZF9+PXMOiUxl6d3UdwyuamGGEo/2o8NBvKhlStk1bjsivFolYA4eY
	XeJdac2fgp20WhODH5Z5DvSQRiJPI2aYdCm66JivO4XCGUvRBTjwvu6HITTixU6rAZYMOk/tfSp
	U8g7fw9bgpprCpZ1KkQoOiW7FxmD07X5X0PlJBqSqbwxjNm4Qo7EGHTdQb+w1BBJTc8+Su1ClR3
	o/D+9co4Xx9zBYrH3Oq/mx4DTZRyA+WhzDxOT+aoeculTmPYLBv9TWSkiO0/a5JJTOHRj64KE9+
	IA08WFpn6M8rcXVD+AGvTljO86I4TKkahrYGpOuyZEkQWvwrLWK25A0/YVHRoS5zBft6tivAF/o
	K7d75XsKS4IJosPFzR7Qm/p5
X-Received: by 2002:a05:620a:2a01:b0:93e:c12c:f136 with SMTP id af79cd13be357-94421824e76mr2297643085a.81.1793730813645;
        Tue, 03 Nov 2026 10:33:33 -0800 (PST)
Received: from houminxi ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d468fbe9sm1912585a.3.2026.11.03.10.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:33:33 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v5 0/2] netlink: specs: fill in the missing ovs operations
Date: Tue,  3 Nov 2026 13:33:17 -0500
Message-ID: <20261103183319.2730567-1-houminxi@gmail.com>
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
  netlink: specs: add ovs_flow del and set operations
  netlink: specs: add ovs datapath and vport set operations

 Documentation/netlink/specs/ovs_datapath.yaml | 27 ++++++-
 Documentation/netlink/specs/ovs_flow.yaml     | 76 +++++++++++++++----
 Documentation/netlink/specs/ovs_vport.yaml    | 22 ++++++
 include/uapi/linux/openvswitch.h              | 17 +++--
 4 files changed, 123 insertions(+), 19 deletions(-)


base-commit: 7b6ab4dbc156e2f96419715130b3d5738a306c93
-- 
2.56.0

