Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333638;
	b=DOFsMqzz4owpqoq+T6x0ZRqfd5NY0ZdheKZ6KYjvW2mA72KhHqnhIo9M7J5vReq8zxLU
	 RdHivdKI74AbxnhHHMKmxujlZhpCKK4jrZHGGa4kBLboISw2lDb71ohdCJTk03UZ08gEF
	 8JWFo5+BNzWZHu7ndy+SwPyl7aTEf/DA5LNpEFKcTo1MIyIm5jr6wZwPnRjGlp6rZ+WmK
	 7J3GCkv8tOoA+YQd2vcy/7syaxoOMMUboJXnlffVHJoKwwVdaNInUPkwFBYfOul+ABpLb
	 8Ajut5o2tvXwS+82j1bmF+QWwhcEPMqG7mFeGwDFGmFxHGMwKdOaqsDytIpyk0HaI4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=9LuItXp5s8cFtxPZ9H5FlDtsQK3I8Ay0nxSYFMAUyVk=;
	b=CkIrMGsNc1ZdthUEgWV06xcbl4TEQgF8b7/ZJuK91UyQlOYfR3j3O4njF6Kj61HDU7kP
	 0xlk6DFhFPWOfj+SW45tTPfDegsBR8VfPXpQcabFc/DG/JlviP/NBPWGOeCz8THNJQGJB
	 HjIcrhPEF51VAPePd7wCiHCmCsakTz3kKGUdlAGzlQpsVuVRUAN+8spyjiVLuBbhqLE6z
	 8DfjEnIx/W65iBc1vtIsrNAF9OklvJaRPpv6Y2XzYaRVncDnW+nLhoOolk/Pdp1U2Pmr1
	 D1j0V9uIJAeGE22g5b6TPfrRHiR3vwlJn6850sTRhlg026CrduH0/Wp0ZGZjOw8EwPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QClyyri8;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34968606A320
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 18:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34968606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QClyyri8
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4d473cfff6so333045766b.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 10:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794333637; x=1794938437; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9LuItXp5s8cFtxPZ9H5FlDtsQK3I8Ay0nxSYFMAUyVk=;
        b=QClyyri8MkVapcikBH87n/uuQNzP60fqChANntJ3ziDZdO1/muz3JPTQnI9+dnIWGW
         krWveAsXgNtJ+6rZO0LBkhP9hiHu+NJrC7r2vqGYszAl+3tUeO+PLdgfkiLw9ZXhNl4v
         +Ol/vrn6v7ayIWCwZPkFRkx3wn9GN2PgOZMQo1TyXlL16cUteA05D3ZwvDbzruo1XSu3
         QSkA4LEljNLQ4Mk/ufyBM1g2NK7Zbw1nwXTFtWoOHcmlYbp/W52VWZND91c7xwZoo1Ad
         UhO/caV3NrZpsGjh6+kqKbPPdQCLCzCIykR/Jl5Ku+NWwN5VaOTeZBjGVJbeHEZmrP4f
         tTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794333637; x=1794938437;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9LuItXp5s8cFtxPZ9H5FlDtsQK3I8Ay0nxSYFMAUyVk=;
        b=MQylKAlBeKuxCDmmdWZSWpBUH3Jm6fyfIntv3erSDERk7mxXtHq79izCjNmdcz6Hjw
         zgR2F6XvT/yT14bZCw7wgJA8xHCf7LX5Ln1DvkUELNJfJGnUKHJQ4P1TNwzDdSt4mq/7
         T/jHplNOZ+hDTKGCjx21wzO9KPoexqkQoT6xRR9RUR4EaApIImgDzmxrQw4bmvcdAcZZ
         NvbmC6esaiVojXxwTxR1DSS8itWMhQoOkBCsfqX+/ZuoGTtF/Wq6he/hIYVkiOl6QKsp
         hzOtGV7UaE4LEwaA2ba+onLgR9IhVtNzc8Huo+snUgKZLrLZyyXwOkzUT27NJRoSZFsW
         UIZQ==
X-Gm-Message-State: APuU4Z/JFpzheg5xkcmHUOqkH3jlXhiFqQbOvY+m2/XFWr5IEXWSYhNr
	oy94c1R/7182sG5DrudVBoFvynhzj+T0XC1VY2kOS2YY7+3nOS0XOHx1
X-Gm-Gg: AYBFou2iqg4a3s1213Ij24wk53w6sgqVN6V7+CPYVmz+QBPrhV+nfHvR8A7OikF1fwQ
	bjtu0Qsz0dw9xU/e8eF/2eXSeX1WMjE6RtVFGmgZhSg0GXfv44bCQkluA1rEaU2Vk/uDz1A6U/E
	rmOgJiJzzieFztQNsLN+iZzbVOOpHCgHZe+iuBCRrNJaR0QtXkxMH/xfYG/WTOs3aYvc6jL/K1w
	oNYZmctD5UozO3wHRuflrVDhE6rLBiwQMdnCP6667JWcdjsukwhcPglLNsOt9shDIXaxIjhq+ul
	fa1HDAMJ25yB84ScZ/aGaRZ1vRqxkwZ5O5u2GONDaa4l87IpcWA48YYIH2Ey4HEnI/Rqwt1vlaz
	3Sda3Rm/oPfVpVsehHIlkqFIZASVP7H8Gy/+5TYX0E6hR7Id2bWSdeBiTGWXbZ2xfXFfg3/DMGI
	slA8QmZBvGY7gI0bkBVLf7mbY7kI76C+x5JcBdVC+DVSJ6j4FIhjSZtvUsabxLofW5jN8rzSEyP
	CyOivV6rZAUExCefZL36LyKosTHzmi7fXiugW0cKbt7u9CY4t/oWumF2Q2ynDFhn+rEcBVDuyvz
	B8Mhb7e91MoJzmtRy+9JUBkb4Tca/WsljNfumQbAA/kOdWJS
X-Received: by 2002:a17:906:830c:b0:c42:102f:15df with SMTP id a640c23a62f3a-c504951eb29mr193190866b.8.1794333636284;
        Tue, 10 Nov 2026 10:00:36 -0800 (PST)
Received: from Air-pasichndev ([188.163.8.107])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a59fd2csm141668066b.44.2026.11.10.10.00.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 10:00:35 -0800 (PST)
From: Andrii Pasichnyk <apasichnik9@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org,
	wireguard@lists.zx2c4.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] wireguard: peer: free packets left on the per-peer queues on removal
Date: Tue, 10 Nov 2026 20:00:34 +0200
Message-ID: <20261110180034.76136-1-apasichnik9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <avNIS67grg_Qc5Vy@zx2c4.com>
References: <20261003201625.4572-1-apasichnik9@gmail.com> <avNIS67grg_Qc5Vy@zx2c4.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Nov 10, 2026 at 05:37:31PM +0100, Jason A. Donenfeld wrote:
> I'd be interested in seeing your adjustment to netns.sh so that I can
> test this myself and validate various approaches. Do you have something
> really minimal? Also, is this a test case that could be implemented
> minimally enough that we could integrate this into netns.sh permanently?

Here is a minimal version. It relies on the created/destroyed object
check netns.sh already does at the end:

diff --git a/tools/testing/selftests/wireguard/netns.sh b/tools/testing/selftests/wireguard/netns.sh
index a8f550aec..8303802c0 100755
--- a/tools/testing/selftests/wireguard/netns.sh
+++ b/tools/testing/selftests/wireguard/netns.sh
@@ -207,6 +207,20 @@ n0 iptables -F INPUT
 ip1 link set wg0 mtu $orig_mtu
 ip2 link set wg0 mtu $orig_mtu
 
+# Remove a peer while a UDP flood keeps its receive queue busy, then re-add it;
+# packets left on the per-peer queues would keep it from being destroyed,
+# which the created/destroyed check at the end catches.
+for ((i = 0; i < 10; ++i)); do
+	n1 iperf3 -s -1 -B 192.168.241.1 &
+	pids=( $! ); waitiperf $netns1 $!
+	n2 iperf3 -Z -t 2 -b 0 -u -l 64 -P 4 -c 192.168.241.1 >/dev/null 2>&1 &
+	pids+=( $! ); sleep 1
+	n1 wg set wg0 peer "$pub2" remove
+	kill "${pids[@]}" 2>/dev/null || true; wait "${pids[@]}" || true
+	n1 wg set wg0 peer "$pub2" preshared-key <(echo "$psk") allowed-ips 192.168.241.2/32,fd00::2/128 endpoint 127.0.0.1:2
+	n1 ping -c 1 -W 1 192.168.241.2
+done
+
 # Test using IPv4 that roaming works
 ip0 -4 addr del 127.0.0.1/8 dev lo
 ip0 -4 addr add 127.212.121.99/8 dev lo
diff --git a/tools/testing/selftests/wireguard/qemu/kernel.config b/tools/testing/selftests/wireguard/qemu/kernel.config
index 368fd9d60..c69a408a5 100644
--- a/tools/testing/selftests/wireguard/qemu/kernel.config
+++ b/tools/testing/selftests/wireguard/qemu/kernel.config
@@ -67,7 +67,7 @@ CONFIG_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 CONFIG_CONSOLE_LOGLEVEL_DEFAULT=15
-CONFIG_LOG_BUF_SHIFT=18
+CONFIG_LOG_BUF_SHIFT=20
 CONFIG_PRINTK_TIME=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_LEGACY_VSYSCALL_NONE=y

Two details matter:

- The ping after the re-add. Without it the re-added peer has no
  session while the other side keeps using the old keypair, so nothing
  flows until the next handshake and only the first removal happens
  under load. My original reproducer had this flaw, so the "5 in 2140"
  in the commit message undercounts: most of those removals were idle.

- The log buffer. With message_cost=0 each removal under load logs up
  to ~1000 "Packet has unallowed src IP" lines, which overflow the
  default 256 KB buffer; the object check then reports false "merely
  destroyed" errors and can miss real leaks. 1 MB is enough for 10
  iterations. Without the kernel.config change, 2 iterations fit in the
  default buffer, but caught the leak in only 2 of 6 runs.

Results on net-next 66974df65a0b, x86 KVM:

  unpatched, 1 vCPU:  failed in all 3 runs; 25-40% of loaded removals
                      leak a peer and its keypair
  unpatched, 2 vCPUs: failed (1 run)
  unpatched, 4 vCPUs: passed (1 run)
  patched, 1 and 4 vCPUs: passed; 0 leaks in 212 loaded removals,
                      including a 200-iteration run

A leak shows as "Error: wg0: Peer N: merely created" plus a matching
"Keypair M: merely created". One gotcha when switching NR_CPUS: the
qemu Makefile does not regenerate the kernel .config, so delete
build/<arch>/kernel/.config first.

So yes, I think it can go into netns.sh permanently: 10 iterations add
about 13 seconds and caught the bug on every 1-vCPU run of an unpatched
kernel. I can send it as a separate patch, or fold it into a v2 of the
fix, whichever you prefer.

Thanks,
Andrii
