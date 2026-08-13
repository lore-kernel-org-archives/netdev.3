Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50BD248F72
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 17:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786642529; cv=none; b=PNiP5jnzdUcKoxmvl7DoDLOi8dlE9CWQmyz2B1ehS98VntCZJHw/KjCyUejgX3uBf6hZXQy/w/tVQabIShmgJLCFeuFDWc0QOSbZvgwESxPvrQDx50P6WjpGWfkNBjz92bVTBu6HDG41gjuLWEuR/REodNVv7SxigcAiVaQVXOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786642529; c=relaxed/simple;
	bh=2AmYLaBeRvmo0E0Ot6PlOwjfHF04diR34DS+q7GbaHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pqBvVa0KEte6TDbbYVybga7k9piBR0oKjLfS7Kp7xL0iQjYTjA3TXCeePHHVlOPIQ7BXzJm2XGWTksjvC8UQAsqmYUBV2/4wzarBdhGwQxlLUNggAghJDihvXDfmxsjaSrPrTCdZ4j5nF/RSF1ua8OkQDjmLpGVvJ2Ua5keQ5eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=HNmAs2vA; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="HNmAs2vA"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38759bcd877so132791a91.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 10:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786642527; x=1787247327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=11mAYyTHtyMh8m66yjwX1HQ+J0T8aC5ikUMnU/4nEwM=;
        b=HNmAs2vAZ67N9dpBdycCfur6Tt1eOJc3qERJkE+XB7fp0VWqc4f1z72GGOoSC268U6
         Guml6sF/DjKlFwcMRcRd9v2I3DhMOltFCXJP3HtUNPKNBHovxLzW7NgW8oVLc+jWFg5B
         92tvDh0F/JPh1qD4AhYF56nNyJBvr4jtdDugH3z3oB4pUhHj3mxy6WiK5cWeXdRn7wyW
         NwOTZti0YvgKStwelmr5KkNUq5xpwAPzQotyI2EEGdH2jQyVhaZxEa/rB2bd5BlEc7RH
         IGLx6QT6b1lE0AkrIK8OycwfNfbubjsFC0FJsD+Ifyn8XSFCnjWinVltanOIsvYAQNj5
         zr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786642527; x=1787247327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=11mAYyTHtyMh8m66yjwX1HQ+J0T8aC5ikUMnU/4nEwM=;
        b=FDDinGK2+9Sx9Gm0Fap5KcEBtPV7xdSYN7t5Lz4BjJUt3qz9/LVK5ml89owqjqFNQQ
         RquxIeFzDCVVGk83Re2uQWaKnT1TKtoADM3JXAW892NnfgHnpmVkGX8npG21IfnkNXLI
         /T/QvQCQZgp9/uTw3Bp5OPGdYwZmtS/E/2AXf6w23QGpS+T7MDsPQCzwxD6+N6Sg+9+P
         KYwgHSXV9Z20CPEfkR175NEv1HyEmWnc6p1CXM948E3LcDZOLg5pEiPJLferNxCZnF53
         aHVKjerZHjW3DlYhNOGxxnP99VLvWL2JbaQgLV68mMJj96fMcfPyONC12HmJIaQPleBN
         ezfQ==
X-Gm-Message-State: AOJu0YwhLgKcOjJBulFijQmhiN9z6q4hfYJG9N3Lq5IAYkjm9UyktVM6
	ZkK7+iwvlcQIKBE4vVmP4pGoQ0aIUti+RwfvzK6kowpyUG9g20uMamjGhAbAXteP+t9ayngOWuA
	h8HdBwUQK
X-Gm-Gg: AR+sD102LRI+RxyzwNt0fzEhiP6PYVcQPxqEKd+A1vbi0Jpq8ybTE64bOL8BSXy5NPr
	6so5ziEdowzWq8CKtFSV+0VAmQA9o25WDrKGlikCo6vUrrIw4m+Q8IDE3K0wGzxaTKnzzwVUK9j
	oKGeb6cMkZhWieUzTq2JZfFzlriq3Lu99px61XPiGxkmQdv3M1YVJz5gle4Udh0H64JuP72scM4
	1DW2A00mrHyqLfKmaJk19QrSG3VIvsA76BnnEp2MqfjyV6icjxB2lz8VsET+q6e+EhtUgYxlZSL
	+7TU3DsYqEmCsVvEsSD9cPFR74mHeOpNOr7VO5TNinaIryBjtX+KsUhZ89dc804/EMpPADSn7al
	1XiJrXdw1oCa9ONBYphd5jvwaiRJnFTV8RuMFSkpvIlSpls6S7F+wS6H843Rg8jhGuUzGoW3d7S
	uCnD/Mxd6VfQGCEyyY1pAUjJc1IEEp59EOaSP5f5DfPmTGx5SKJmY7SWEVXeJjixiTdzE8ew==
X-Received: by 2002:a17:90b:5310:b0:38e:97f0:aa4b with SMTP id 98e67ed59e1d1-3931e23f2f3mr8528721a91.13.1786642526994;
        Thu, 13 Aug 2026 10:35:26 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39339eca063sm204504a91.1.2026.08.13.10.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 10:35:26 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	edragain@163.com,
	weir@nebusec.ai
Subject: [PATCH net v2 0/1] ipv4: fix a non-progressing fragmentation loop from undersized effective MTUs
Date: Fri, 14 Aug 2026 01:35:25 +0800
Message-ID: <cover.1786599079.git.edragain@163.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yong Wang <edragain@163.com>

Hi Linux kernel maintainers,

This series fixes a non-progressing IPv4 fragmentation loop in
net/ipv4/ip_output.c. The bug is reachable by a non-root user with
CAP_NET_ADMIN in a user-created user and network namespace.

---- details below ----

Bug details:

ip_do_fragment() subtracts the IPv4 header length from the effective
MTU and passes the resulting payload MTU to ip_frag_next().

If the effective MTU is smaller than hlen + 8, ip_frag_next() rounds
the fragment payload length down to zero. The fragmentation state then
never makes forward progress: state->left, state->ptr and state->offset
stay unchanged while ip_do_fragment() keeps allocating and transmitting
header-only fragments until the softlockup detector fires.

This is reproducible with a route installed using "mtu lock 20", but it
is also reproducible without route MTU lock, for example by forwarding a
packet to a device whose MTU is 20.

Because the failure happens in the fragmentation path itself, this
series fixes it in ip_do_fragment() by rejecting mtu < hlen + 8 with
-EMSGSIZE, matching the existing IPv6 fragmentation check.

The bug is reachable through more than one userspace-controlled path. A
user with CAP_NET_ADMIN in a user-created network namespace can trigger
it either by installing an undersized locked route MTU or by forwarding
through an egress device whose MTU is too small.

Tested in a 2 vCPU, 2 GB RAM x86 QEMU guest:

- the old kernel reproduces the softlockup both with "mtu lock 20" and
  with a dummy egress device whose MTU is 20
- the new kernel returns packet loss in the no-route-mtu-lock reproducer
  and the guest remains alive

Reproducer:

Run inside the guest as root:

    bash poc.sh

The PoC sets up forwarding through an egress dummy device whose MTU is
20, without installing any route MTU lock, and injects one forwarded
non-DF ping from a child netns.

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

v2:
  - move the fix from ip_metrics_convert() to ip_do_fragment()
  - update the commit message and cover letter per reviewer and Sashiko
    feedback
  - switch the cover-letter reproducer to the no-route-mtu-lock
    dummy-device case

v1: https://lore.kernel.org/netdev/cover.1786094799.git.edragain@163.com/

------BEGIN poc.sh------

#!/bin/bash

sysctl -w net.ipv4.ip_forward=1

ip link add name dummy1 up mtu 20 type dummy
ip address add 192.0.2.1/24 dev dummy1

ip link add veth0 type veth peer name veth1
ip addr add 198.51.100.1/24 dev veth0
ip link set veth0 up

ip netns add ns1
ip link set veth1 netns ns1
ip -n ns1 address add 198.51.100.2/24 dev veth1
ip -n ns1 link set veth1 up
ip -n ns1 route add default via 198.51.100.1
ip netns exec ns1 ping -M dont -s 1000 -c 1 192.0.2.2

------END poc.sh--------

Best regards,
Yong Wang

Yong Wang (1):
  ipv4: reject undersized MTUs in ip_do_fragment()

 net/ipv4/ip_output.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.53.0

