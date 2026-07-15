Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEE337E5C6
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784129448; cv=pass; b=MQgnHWw0w/duZvG4UBfEPQAFRRutRaMr/8zxtUlEdYfdVaZf7ad08vf5JPXvlwMZYgwkgkIt+tYEWHGmpxRxgiSUYx+msKowNb9BZbIRcEtNR7E7gnyxCaK7qUXHDhi5Gh6Mw0gqJvu6li2Cck5bGcOkOIo2c78OZnc02WzXekg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784129448; c=relaxed/simple;
	bh=lXXjOHrd0s8yXav1J7kav1XI5xDGhAIIbsthcPw0y7w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rJFIs8CMY9ilb1Q5GV1oCrmAyayi9FWD0yAwJOqMEekqw8e2zDUbAf8jPluwNuACYSzlajEnubFBc5ax4qfN7ozRr3p4eU1rpYiwDkBDudPiYxlwo+Pf2w6BCuGxEqos8XXj9q5V3ldD2gbztPy8QmRWElZQwED2KoV41ycrNAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcMlB2Wu; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcMlB2Wu"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15f025146dso73200666b.2
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 08:30:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784129445; cv=none;
        d=google.com; s=arc-20260327;
        b=rz49LkiciEvk/8C6q1Phx50uDWUBCEXxXFR1BrNgeI/mjVOgPT/inRKTbCfxBJRLoj
         XcQGaVzu+P+hhXjsOK1cssy2bgTqHatxAdR/tzaTUkvB5OAiVrlNBX2MR8y3eSzRMWfY
         nQ2X3ah4JYxb+4cPcJ4xUCgR4tmr7yWGefDWDu3g4tcyTg13CDlTm95z3OvOjc/dHvmh
         CExcwKLoC2BaaqBi8FWlqT8frOQ6/lQI0kI3dv96nW14Hh0dJem8UfqeRJiCMyxjOxEA
         oQGr3fd+9ROUuFjI5jNtvHQWdnu9jAQGvE4fARWkYwSyB+WDL4oEh1RbPqn3wGBovqBE
         taYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=iJyvWzKMMFmmRLKtpG6KcfWT8Jk8RWHQJwrqiRAxiqw=;
        fh=MK8ndxV1vYU4erojvdwqklFRN3kK3/r/tHEe7+X9c6Q=;
        b=qqBlEfAeS4K2avHiDpsPOvu3Q4CswHPfMq9lRso7Yj5kbiky5QE8Ww2Va35cUmwNaa
         08dazy/cUfEPVEvoF1nfXvkhA4xmEsZY28Vftcuoq8uVpfKbmoodaOMDx6OeJ1yHFbUq
         wHn3IYpg6RrwBk5V1E3P0gD5htxrjy6xVbIZayH9oVsDGk92jgksgbFzoDr1bX9AQJfm
         6jzVomalG96/UbJlCpADc6LUhWR0t6tFXpqrXUJ0Sz1Mk+iH0nUYCcUcurd0OwJABC+W
         yW5bj6iRql8eeWpIxnp6uwqOQ1sUPLDzzOpqq/xFpx0dN5XQWVaQGEzRpk96wBgFoF6Z
         cxEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784129445; x=1784734245; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iJyvWzKMMFmmRLKtpG6KcfWT8Jk8RWHQJwrqiRAxiqw=;
        b=WcMlB2WuUYz7L5u+DGZud16sGA6Tt1tJHOY7VnbIdK31TawC48+r6zKLoGvvVRKg86
         9TA0xAdgL8l8m9uyur7INuADPEJSNuIS9Qqvr4RszTi/Ik3f2cap/tY8moyGknuVIYsC
         YSYaoqiFmetvDSoQsw7ouGZ7xf/odj/f7JxSgBKz2fS4/feNIts2nugClfUiTO6+YMNx
         yATzON1oniSBh/OPchMd4aP3pJPKQzWxQaaS0x9iWDk2IbvApBu6yofyH8KK6nr7OwGl
         hwqVY/ZQ6f6x8bMbDOy2w9zVLDzQ+88/09Bp4OhtwIbs5w/RRF/Nbi19Dtv5y9dBUL/f
         xiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784129445; x=1784734245;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iJyvWzKMMFmmRLKtpG6KcfWT8Jk8RWHQJwrqiRAxiqw=;
        b=Xnu5vP8fjrzpTc9lDJhn7O0LZkZmd8m/pa/x3zLfNj1I0CqGXxlMXoJTZc6xktncjw
         yvatoPxWCt7nORPY4kQUep3EdvX7NVv9a2Qe5fDMWz2uKnOfuiMb5qCovHwYKrh58fl7
         JtHQtpzES0Qej6twAH/jtfFgE86yJxfxQszq+M4kd+qQ70si4jguNtgSW7AhNAmZ7R7S
         MTWKozrKYeaZ61pRPkvEavP8Uk/diodw2sTuEM5SnMRq8MNm/VWmemcTUvbAuqy/xM8Y
         fczcgeAWrIGC26NMJX20YLn6LtPne+jR6PKUijEwud9Sy0WUcRNlrPylsSIQtuZUTx84
         aiqg==
X-Gm-Message-State: AOJu0Yw0l9xdgfdHVXrBL4anmF/ainFpWt7aGA79pPdeIwS98nqQW4Bt
	k5g2o3HTLObflh/wspjSNx7qBMlQkMUpFF9md5jVkmTiqc4OdFd4+x+ZsKFA+PEM98bEdh8/9hB
	Ul9GPu3jSkVnQxyjsiPOnFLWhh6lta7QH3YNzqpg=
X-Gm-Gg: AfdE7clhWXwfMUph08OGYyOKb5SKhjj7pRg5NhNDdQuumjwJdjDhpzkA+7vJTpSXdcM
	/QaKmyLle4rhpYjOgvqmV/aJkfIAG+YJcD0xoIzEsBJKurfQs6CZvjb7mtnA8VmUFkrLj+YZt00
	9qjLKChjVlCfeTuMS9asUnmdL0GWWPJ0HWuhtRR7hEOO6I+0Le8HnOKByw2PkvFB+x23prQHTYF
	yDY+iuViBJ7M/PPY7pL1IrUBQTw4bDxrSZqmjKUPmhOHfbTHhyMWVn8OitMHoWlsiaofX8=
X-Received: by 2002:a17:907:940b:b0:c15:e277:c550 with SMTP id
 a640c23a62f3a-c161ea025c9mr536614866b.5.1784129445240; Wed, 15 Jul 2026
 08:30:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Muhammad Ziad <muhzi100@gmail.com>
Date: Wed, 15 Jul 2026 17:30:42 +0200
X-Gm-Features: AUfX_mzM_jJdwrB2qnWedvlUdNgcANghpAbq2fnBKMu_EJg0bTzDt3D1guNYbNE
Message-ID: <CAOAwikA60AYKdFr_UDLyja3oU4hqyAE7uFZWqum5uRdaQsgRYg@mail.gmail.com>
Subject: ipv4: icmp: icmp_route_lookup() relookups pick wrong netdev with
 policy routing + strict rp_filter
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

There appears to be a bug in mainline Linux in ICMP reverse-path
relookup logic inside icmp_route_lookup() (called by __icmp_send())
when strict rp_filter setting is in place.

When Linux forwards a packet between two interfaces and needs to
generate an ICMP error, icmp_route_lookup() performs a "secondary"
reverse-path lookup to find a suitable route back towards the original
source via ip_route_input(). To simulate the reverse path, the kernel
derives the incoming netdev by calling ip_route_output_key() with a
decoy flow that has *only* daddr assigned in it:

    struct flowi4 fl4_2 = {};
    fl4_2.daddr = fl4_dec.saddr;
    rt2 = ip_route_output_key(net, &fl4_2); /* no saddr */
    ...
    ip_route_input(skb_in, fl4_dec.daddr, fl4_dec.saddr,
                    dscp, rt2->dst.dev);

This can lead to a mismatch between rt2->dst.dev and the netdev the
real reverse packet would use once routing policy rules are in
effect. With strict rp_filter, passing the wrong netdev to
ip_route_input() causes the relookup to fail and a "martian source"
message to be logged, after which icmp_route_lookup() falls back to
the earlier output route lookup (relookup_failed).

In such a scenario, I would expect the relookup to use a canonical
netdev and the kernel to not produce spurious "martian source" log
messages as a result. This suggests the decoy flow would possibly
need to carry saddr too so that ip_route_output_key() is able to
resolve the right netdev.

I tested this on: Ubuntu kernel 6.17.0-35-generic.

Here is a reproducer script that sets up two net namespaces: a
"forwarder" with two routes to the same dst in separate routing tables
picked according to saddr, and a "sender" netns behind it which sends
a ping with ttl=1 via the forwarder forcing it to generate an ICMP
error as a response which leads to the result explained above:

    #!/bin/bash

    if [ "${forwarder_ns:-}" != "1" ]; then
    exec env forwarder_ns=1 unshare -Urn bash "$0" "$@"
    fi

    SRC=10.0.1.2
    DST=198.51.100.5

    # Current netns is the "forwarder".
    # Create a second namespace for the sender.
    unshare -n sleep 120 &
    cpid=$!
    trap 'kill "$cpid" 2>/dev/null || true' EXIT
    in_ns() { nsenter -t "$cpid" -n "$@"; }

    # veth r0(router) <-> s0(src)
    ip link add s0 type veth peer name r0
    ip link set s0 netns "$cpid"
    ip link set lo up
    ip link set r0 up
    ip addr add 10.0.1.1/24 dev r0
    ip link add dumA type dummy
    ip addr add 203.0.113.1/24 dev dumA
    ip link set dumA up
    ip link add dumB type dummy
    ip addr add 192.0.2.1/24 dev dumB
    ip link set dumB up

    sysctl -q -w net.ipv4.ip_forward=1
    for c in all default r0 dumA dumB; do
    sysctl -q -w "net.ipv4.conf.$c.rp_filter=1"
    sysctl -q -w "net.ipv4.conf.$c.log_martians=1"
    done

    # Destination reachable two ways.
    # Policy rule diverts traffic FROM src to dumB
    ip route add 198.51.100.0/24 dev dumA
    ip route add 198.51.100.0/24 dev dumB table 100
    ip rule add from "$SRC" lookup 100

    # sender namespace setup.
    in_ns ip link set lo up
    in_ns ip link set s0 up
    in_ns ip addr add 10.0.1.2/24 dev s0
    in_ns ip route add default via 10.0.1.1

    # This will trigger a "martian source" log.
    in_ns ping -q -c1 -W2 -t1 "$DST" &>/dev/null


Happy to test patches or provide additional traces, if needed.

Thank you,
Mohamed Ghazy
