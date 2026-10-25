Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792924463;
	b=rp7TT63M41QffZ1JytArMGX7ER1O2RVkFDlGdq8ActGpsb2no9Wg6TqFtXXpZ76/ynxB
	 oEMJCTHV8d7LUKBYejBcSiQu9JgEuFAWM7tSRYNQC77eFkqAYR23FuPafr6KNRmR0W6Iz
	 T8rIbxQNmyA6rsYCSJY2/NyuziDysREgzBih8YBW8ceHqxOX7Qac7T4+7dR8TzEjr4u2U
	 5w0beoYbghgskhvM1WItMVxTNAVPsD9IcloXKMAyCX2Inxi15XvWCEmRIp4uL/KPVnqdg
	 smK9RVWKP7JdcTM7MDME6MaMImKy0okwtHv6nTC8r5p+C1WaqwRGhBfseNtkonvtIuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792924463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=xX18rm2fSKpktE7R5NKMmfAPZiqXiSqfGltd3rmECrU=;
	b=KC0D1T5d2yprXgsePufIOYWbZpfZWT0/C2D5mZVarFApLBlT8l5TObnxbJq3aP5z6uZZ
	 QvT50T89WLf3r0j3dZT0FJc5rh8eF7TJ3KdIuiyRrNRYU6qFc01IvXhXCUDsMCcm40lzj
	 N9UVxo9Ralkpx7EbWPnHYY5w8weDdD7Ao3Gn1SngVbRRm6CRI0N81vY0j19uOlKsvaEAo
	 on3T56T5NBaJDgE3vBEEP7fAch8Z4S4TwUxkt3nvSEUY5Kubwr8tg7huunwIuRwLJioNE
	 mQ7MXEB7JSvpI/GQ/rP2o6JEoywIBM9FibAMDSJQK5G3aQHDI3IES+V+c8Bn3xmD/Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PJtwLDMy;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6AB606A31D
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 10:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D6AB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PJtwLDMy
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso3759877eec.1
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 03:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792924462; x=1793529262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xX18rm2fSKpktE7R5NKMmfAPZiqXiSqfGltd3rmECrU=;
        b=PJtwLDMyxGsISgg3SxVc9JbROBBu/yla/3KomvCueLaqjg/ZGJv7gDX0tyz+jx/Iph
         wYtpT1w3JkdComAVsIrqkWtFUiVIHzq3HJ6d1wexOrbAJeLp87Om66Z6lA8LmQt0Mibr
         3T/kdtNXYl9H2FcYzrNr6jLMGqrvtLej02rBOry35gO+SgU0NsbQHKejmadxm4/In69J
         23eEPKnPRKbeJs8qO6HwVetp3B+7qbxjwPLMhZs7RC4EbrFgavxCya6fQkmfUYRD5MN1
         hXDJlNSGOqw/6hdEfauwH5/lk/DGMILo5bajJwFFpnMhkK+MmgMIxNd73w4unDhF9Fsm
         B4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792924462; x=1793529262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xX18rm2fSKpktE7R5NKMmfAPZiqXiSqfGltd3rmECrU=;
        b=DpqYV9Xz+GJdK45927a+3/RvqeChFkYhz9FHdhUXhgrNTDidUn3Xqf4RmOXon35ZMY
         RTJ4k7NpUXpxJsHHj9tef/RxPO+VfudQhR7R2eDTUjX6tsGO5vOYmDCn9RKUvA4cVu3n
         N3wiwt1qVg340B1SbdBaGW9dunIlYhN5To1nhiQaYtxgMrCbTsz/BGSSI0YQUBwRmUCg
         KTxhHbgfDM2W+xnfwZEI01CqAL/x6D0in+lpE3SQy6XajrTSFeiIjA2SbNUQAELqdPuU
         NzzXsue/BZJrtlCMTcAqwua8Hit7b6RAFYXfOb5LGgiHBgCycxubmGc50lVm3IUGKbKA
         cTog==
X-Gm-Message-State: AFq9FYIYpx+rXpqubs+Y5mf3FPJu89pDi1DysaUb4bqq0E4FPZeDgBDV
	RyNqNP9ELSl00AMDeStb3XDgtKuVcSln9vnGE5AOW4Sb0Oj066Y2lPb/b3kFqi5fNLI=
X-Gm-Gg: AYBFou347LIU0YqaMuZ/hkgVfvb9feZ/zy7gSgME4ffOZ1/N/scSi74hZK/syqLvhIx
	3a/iYuA2nwoEwNhrBxSXqLoWOsOttDhUF65k8V8f+H9z+OKk+nHlQYkjhsSTcpXDR/h7SBGIYNS
	ZTif3xXyanDO2190SWkdAEhn+LEqo8XlK2aB/MhHqnZMvkLwT5UHkVPOBrvLjPj3/RP03ccTqtq
	zJva2/GywXOEAft36Yav1ofz2MUJEs+owADNk5PxN25yb4XLZB09y3TrRd0DoZODJMNbnnzaOfc
	ud57biFCTiqrE6yWN+j8QjBVPMRqyaYPaFNIbMJiSzTxNycT7J9lqCi66btIGUu2e3gsyXWqh0e
	d6b66ABMYj6VpjGs3I49ZRSD34XXkYf6y4+59elEOSbJ6e+NRWTDue7y9NPtiouFUjSl6TNQWeu
	anbWx9srEfCgJZhTkI1qGrr/JlEr/E6gGhroqGQFLl1NUJk9oLbuQAHtULFOviKiqqncH2s4g1k
	jap+4yhRULD87gRu5zjesie4R22QcQ802EMO2d9cuHMBF34nA==
X-Received: by 2002:a05:7300:1c1e:b0:353:8103:ecae with SMTP id 5a478bee46e88-369e863c98emr6319497eec.23.1792924461405;
        Sun, 25 Oct 2026 03:34:21 -0700 (PDT)
Received: from houminxi ([61.170.150.30])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369ef6a71easm12597256eec.5.2026.10.25.03.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 03:34:20 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v4 0/2] netlink: specs: fill in the missing ovs operations
Date: Sun, 25 Oct 2026 06:34:07 -0400
Message-ID: <20261025103409.3519874-1-houminxi@gmail.com>
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
the kernel.

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
  - The commit message no longer says the uapi header was updated. The
    same sentence in include/uapi/linux/openvswitch.h is unchanged.

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

 Documentation/netlink/specs/ovs_datapath.yaml | 21 +++++++++
 Documentation/netlink/specs/ovs_flow.yaml     | 46 ++++++++++++++++++-
 Documentation/netlink/specs/ovs_vport.yaml    | 21 +++++++++
 3 files changed, 86 insertions(+), 2 deletions(-)


base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.56.0

