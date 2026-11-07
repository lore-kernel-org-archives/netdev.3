Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053225;
	b=JhZEtiUP4IhmfV5LLuKj1E23qs6LAHwZtHEzM938HpNUt3SXnBT+yXbSH8sLiWWlXkiv
	 A12sSrl+iJuVnTi0CEwcJi9ROtqKl9N7tbAPuGWUQljHPxky64xvFNcn5XD+QF6DNpdAc
	 M7PtmogvoelTBswV5Z1zIHlvWwrHs5QrvA/wRGcFULTzgIh8Pc8OWXttf3UiQUp+rMOpN
	 hYManF75IhdOwwwie+MIR94/cXC1v055zmmX81YvFM5EB/zjZIhy2DShHMzu5RZW+HS5k
	 SUKtXgju5B0D9PH5Raz3FjGxn7Y2+kl8Or5X4H2dDw2FWiZPvIb5Fn66PdZtyCjTJlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053225;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=pbRWUgFzstEx20sAnwfteY/8tUQcjocHNqkIohI528M=;
	b=mzAu6kLU1TfBJGI5a8KsPZTq/EfE9bFhXp2Z+O4J9IkkNWzc79Si8URw1Um6a4KXcieC
	 irPRy94mW/qjoYL1TkdTDXfefDCweZ5cA8tF3kvcxjC5vmVoKr70vXL4gVNYSZBxZr1wu
	 Y8PQDXz9spSKOraYpBF0HdHW1eIS1jgdg5n53mDlxM/7JX5Ua45M7HcIAdEQAzWP7nFvN
	 sRfmDxAaNxSUTthbxsDMftT0gpUa2j6EdNGKzmuKAPNri4z1ia4ZhQER/vPgsGBYIv+3z
	 K+7vh1TVUX3YdVWO8JpiOY9yM7GaOtFA3qonaSJFV/q17xDd4f3zgdc0CdlebLVo8AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UXYGz64Y;
	arc=none smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B61B606A32D
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 12:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B61B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UXYGz64Y
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67be4f2f4d4so1714748d50.2
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 04:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794053224; x=1794658024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pbRWUgFzstEx20sAnwfteY/8tUQcjocHNqkIohI528M=;
        b=UXYGz64Ydu19JZiz182rbonA6mfNLwsUYdmZbtKG1Xu08S+kaaLW4WcJemh/6ZXFW+
         VV+YdTk7SQSbqZsHO0sDkpgcIpLtScXshRYJLYzUeLaPcchc6tHfVe+2Dl4UAyczhGQi
         9I1rpHbjmYr4PP9Pkjkawi+Qu6pJO0s4poHcAlW3xOEumFtquhVa6lpp0vugZKxbRJDk
         1lmw+90BquKx8Lm9HMcOkUlag/4M0nC7QtC4x+WzcKF+OylCC1kDem8r1F4CMIVzIxLF
         hcZh31T6NgQj0QtpK/LhWnBp2RaAyGbGIaaJx3tP2yVARVUvJfg6zkvJ8PHVViMXnJ/p
         7A9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794053224; x=1794658024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pbRWUgFzstEx20sAnwfteY/8tUQcjocHNqkIohI528M=;
        b=bTnDtQq+U7ndToFJ4hVX2cIsGhnB7XbmRriIQWPFVkOL9zAN0ygHVJeo5lzofhSvOQ
         53o0jTAneIJbz2j6gCxgUJcfkAdOENotiGEW0Xlmcepr8LxGxANUG671gexgtH8+tw35
         rBU1grsTqUXrTIBYcPHlmdnj/m1CHe9Uzck6KSz4qIfzEZHoJ5Fq8QxbOai+FeljuChS
         EaMeg4YZc9zbgFC22BxYV8x2XVf+J9OshQgjkw7nafZvM+RZu/dJcJUBJ64lnvzQEhmv
         k7Ak80g0qL08hx/7Y3OZMZa9KbJNSgtsy2qE7JSY2g/NYAlITe3IlMpxH99rO09vDnxu
         LXyw==
X-Gm-Message-State: APuU4Z/YLm5Y/LvZ0NxcEn+BUClsPJATwp5dx/Mahdx+ViPlNpRu/+xe
	lFrK38hn3r7tRltEmRv238HVqODzi6CIAe17hNNxNeH46oDCNyOaSRabO/ZlhJuO
X-Gm-Gg: AYBFou2fVUQAgWMqjW6yNmslFHIHuoBS+IlmzhnPiIPQdRGs8Qe9Mvcd33T6EeEIeZE
	co0janT+/s/HdK0GkZeT25yeXx2KVqHGR7m9klQdwMfUy390wXLNUdU1xSYUhcljNZ40IT96tmn
	GLE/gDjvD5c0hud3MhFRbuC5PrRy664Kji3JHInubRlbDN4zlkNTgpfFWmLReV3fHcTDirXXZgR
	OC/JJ3BZJCtU23moJyZmXWdYt83nJtAd23xJnDzcDArVZVDHUbGXc/8LW66wyMnW7yATXPiyyuT
	+pLNJ2T9KPqzKnvjxwWGkvRPyuQCLw6kc8dT0YoJpq/X5jnnqxAxiZmKMrYIrI5EDdLMfip5Va2
	OzmSQA1veAQri/HZvK9K/YoRIwceX9zhD1HB8wVQfrT4Ly2xhWzMK4Zh5nPECZ40GU2VGgTkdhb
	720FZOt886TxVq3N8xZFlUnNS4MfcuW9oDG9U8aoeF7eKRzUHEMD2GYnCjIMLaCu9XXP4grcFkU
	AxQACXhsCkxmtkXLjB4G1WYJ0O8f7kwQXf5B2SdaKjUE9EU5S2kbY2Y78m2dFI/i+YEbJMdL1Nq
	bujPIweSzdYb1zOmCRJzj6hX
X-Received: by 2002:a05:690c:c1c2:b0:8ab:422f:a8a3 with SMTP id 00721157ae682-8b341b30203mr19939877b3.104.1794053224038;
        Sat, 07 Nov 2026 04:07:04 -0800 (PST)
Received: from houminxi ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f77055bsm39518927b3.8.2026.11.07.04.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 04:07:03 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	dev@openvswitch.org,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net-next v6 0/2] netlink: specs: fill in the missing ovs operations
Date: Sat,  7 Nov 2026 07:06:45 -0500
Message-ID: <20261107120647.874906-1-houminxi@gmail.com>
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

 Documentation/netlink/specs/ovs_datapath.yaml | 35 +++++++-
 Documentation/netlink/specs/ovs_flow.yaml     | 86 ++++++++++++++++---
 Documentation/netlink/specs/ovs_vport.yaml    | 30 ++++++-
 include/uapi/linux/openvswitch.h              | 23 +++--
 4 files changed, 150 insertions(+), 24 deletions(-)


base-commit: fa5196392691051963726787944db872420dfa75
-- 
2.56.0

