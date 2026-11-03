Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736060;
	b=11HRyGqaaxx0b9CMhBp7pxYpKbSVhZ3HawasCC/pP4xwzwfh3XQoFKvqwgerH4GZoi4x
	 aC4kp29SBGFVi+jTMpXU6JTaclxtDJR6n9TTbSrEPp5XlN7xbTRky3wALT7tPbDIg9Pvh
	 HVF7H7UWZd3RCEAyTcEE0LuYSe1qjANb0q1K4ijRPjL5nDbfcWTEqA87eHnVy28OReRg9
	 ATDNECMkGXbxLHyfKZTLWx+vd6J5AddXFw5+uHc17i4hgKNdE/c5/Yr9OXEqBIcxTE/Wm
	 wi13SSrJWO5uq5KBsJ8gh+TMO/9JF46LlZqDj+Wzk5FG7zh8LLxKOuA/pIdCL3Dk5wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wkydveF0zq5jAFEFr/DEfHBHOLC9wRiqiIlprBvXT0U=;
	b=IpOas/5HXSjOQAQxO0K2WqXXlMN08zp5c4H+LGESPTBpLEUbno5EH6lGqUHTS/yhw50E
	 Z2JCDkGs47kkvr6V8nEpDfb3j/mQST0zUICwnehZAJFDkhmJoJ+DgfDl6TbIXbWHr6a5Q
	 N0pxagL/rLrT3p5H4b3dRcAyBOle2IcHOy4UoMden2nPCwb+y5jaCjJyl1bWa2QkIMlEY
	 MmK9V093/rs+lkWyO44/mwt37khl6CwWOfa5jcw5DOUNd7T/e7MEnQULuhbzoA3aW3Xjq
	 aspydQnwCoDMTrnok5/hPJ6cMPIcMHdy+aCNWyByyzQccEm6ULYvd9dFJT7uWMxw1mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b="F7FIs0/3";
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1EE606A329
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 20:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D1EE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=F7FIs0/3
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so7450955a12.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 12:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793736058; x=1794340858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wkydveF0zq5jAFEFr/DEfHBHOLC9wRiqiIlprBvXT0U=;
        b=F7FIs0/3+Ty6jo5zAhl0l4yDHXyXiG1N7o1sAt0wUS/AVTpd3WJFSFbtxNqjfBVZ/F
         BTb/33O8/v2FPTbLzj6815/tzeGrsxvkee8XbbNsxwMOC+XhJ3PKOzqbFLoydaQ0kfr0
         vntwPSg34Knm3kb3ehlKMDdh2om105Vbf1JhW8bfpiDmGJFRL7Wuq7iBHzwUQ5Q3lGRk
         OSH8zkn4mWYp+2BcjTJa6JrqIkWb41EGFuJ81VtOTmCOtGV3bsCDLBnVHN5BGZ1zmEfI
         LPvMW+pbjg4Gx0TriFAGdrLHOimaedt9Xv3kvmnmGRbtTekGJAs0Viis9pG1QysXVBh6
         2cVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793736058; x=1794340858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wkydveF0zq5jAFEFr/DEfHBHOLC9wRiqiIlprBvXT0U=;
        b=kgh2om0qw9gVHmiNSMJkIg7eElpGP6GzR68nWPDnokC7TFEaxdCDd8iN8qaEIBHDvH
         rrpS4xHFX5J5vs93yeaYo6pdRAEMhOLarWuHAaIxUoNchkrEBJnjRDSX7b7I1itTlKkp
         jOCk8rrqJnuEzQv28r3lpGmBLyKz2KL7gGs7k6HDXud4L8Gzd0knv0YEBzZXvR2YCzFe
         Ybd04YIeLPf2Q8UxkqkawcCV0UF4v68fkTiWswW0Qbxj1QC8YNmZlRzJOHuWRi3iyuw0
         hN+sUSluu8s94oSIw14d7+P85ieMsgTWwOL2P+DhCuE0HebPPbv6QbUH2v8MotP4KPEH
         Ddeg==
X-Gm-Message-State: APuU4Z8QeePe5a8mhjOlSluHPxbMRDzuuI2TTyTNwStHFTGbKcarzhr2
	9e439Q3qvq2H4KBcY+KLECuYDip5uXo/HT5I5u4S4Ac0PNb0A+G8rDXsbqBeevGSOrUZlVJ8OpJ
	HCOgseFY=
X-Gm-Gg: AYBFou0UAuMzbUWMalX72eQX8zv7bPl3HDvT5DLbJUO9YyejTiS1gQcgsXh/zr68B39
	Asy9nBcjyO60CUmztiV/MIrQyaqEYYYYwq44PhRqpuvKuZeWZY6o5jDnjCny9yCLNELGyDQgXf2
	eNKMd8Y+af2zwQsaTHuXHD4dBjWvAjFDSfMD6U4H0y6ZTqD2q9xSlKIIMS5AjQRQwMdL5idkprH
	4XshcGD7cmYcynTNZ7xdjvgx+EyAKcp1bUjy+m7l/DU0syiG5ZYbDg8AN3HK3ywbKuxJdk4yca+
	8+a01npVU4AV6zAlj9EjQUVMCY/9kZp7oWEcOUy3OWC81yg0zmc6Ft3qxDA2xsTDRV7JoZJuMnC
	CzV052RnJA7g9AK3+wECbDyiS99CjYcjY8fnAMNOuf47fywxmbv9MqNyff5FXjQSSUAh+QsJx/m
	JgLNweNRevzEJf2J81Ylj92FkIbK3P8/Cvz9SRT5Ir+I7Ly9+JewVzAnxSn3bhaOGYDs3j0GwZZ
	arzGfv/AS7/kVxJp5T7SZPLlL/nuzQSu9mNjERGJul+1fdPxnd13AFx9iohMQV0vz5jiBqSf+/S
	tNpC+cxtbNvWLLzRHuKFBBnM9M0TmOsfId8gcAzH0xTC0UE=
X-Received: by 2002:a05:6402:234b:b0:6b1:df89:7e1e with SMTP id 4fb4d7f45d1cf-6b4d33aaff6mr10849177a12.1.1793736057694;
        Tue, 03 Nov 2026 12:00:57 -0800 (PST)
Received: from D90XRJJJNQ ([2a09:bac6:37af:1e5a::306:a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4ec91e2f2sm4499801a12.0.2026.11.03.12.00.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 12:00:56 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net 2/2] selftests: drv-net: ping: test generic XDP redirect to cpumap
Date: Tue,  3 Nov 2026 20:00:37 +0000
Message-ID: <20261103200036.65764-4-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103200036.65764-2-tianyi@cloudflare.com>
References: <20261103200036.65764-2-tianyi@cloudflare.com>
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

The generic XDP tests in ping.py only cover XDP_PASS. Add a test that
redirects all packets to a cpumap with an xdp.frags program. It runs
the same ping and TCP checks as the other tests.

xdp_cpumap.bpf.c is a new program. It redirects every packet to entry 0
of a cpumap. It is not added to xdp_dummy.bpf.c. test_xdp_offload loads
xdp_dummy.bpf.o in offload mode, which would fail on a cpumap.

The new test extends _set_xdp_generic_mb_on() with two optional
arguments. The first argument, prog, is the XDP program file name, with
default "xdp_dummy.bpf.o". The second argument, on_attach, is a
callback function, with default None. on_attach runs right after the
program is attached. The new test passes "xdp_cpumap.bpf.o" to prog and
a lambda that adds the cpumap entry to on_attach.

Without the previous patch, the new test fails on netdevsim because ping
gets no reply.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 tools/testing/selftests/drivers/net/ping.py   | 27 ++++++++++++++++---
 .../selftests/net/lib/xdp_cpumap.bpf.c        | 19 +++++++++++++
 2 files changed, 43 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/net/lib/xdp_cpumap.bpf.c

diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
index da3623c5e8a9..a0de9a98d906 100755
--- a/tools/testing/selftests/drivers/net/ping.py
+++ b/tools/testing/selftests/drivers/net/ping.py
@@ -7,7 +7,7 @@ from lib.py import ksft_run, ksft_exit
 from lib.py import ksft_eq, KsftSkipEx, KsftFailEx
 from lib.py import EthtoolFamily, NetDrvEpEnv
 from lib.py import bkg, cmd, wait_port_listen, rand_port
-from lib.py import defer, ethtool, ip
+from lib.py import bpf_map_set, defer, ethtool, ip
 
 no_sleep=False
 
@@ -75,16 +75,23 @@ def _set_xdp_generic_sb_on(cfg) -> None:
     if no_sleep != True:
         time.sleep(10)
 
-def _set_xdp_generic_mb_on(cfg) -> None:
-    prog = cfg.net_lib_dir / "xdp_dummy.bpf.o"
+def _set_xdp_generic_mb_on(cfg, prog="xdp_dummy.bpf.o", on_attach=None) -> None:
+    prog = cfg.net_lib_dir / prog
     cmd(f"ip link set dev {cfg.remote_ifname} mtu 9000", shell=True, host=cfg.remote)
     defer(ip, f"link set dev {cfg.remote_ifname} mtu 1500", host=cfg.remote)
     ip("link set dev %s mtu 9000 xdpgeneric obj %s sec xdp.frags" % (cfg.ifname, prog))
     defer(ip, f"link set dev {cfg.ifname} mtu 1500 xdpgeneric off")
+    if on_attach:
+        on_attach()
 
     if no_sleep != True:
         time.sleep(10)
 
+def _set_xdp_generic_cpumap_mb_on(cfg) -> None:
+    cfg.require_cmd("bpftool")
+    _set_xdp_generic_mb_on(cfg, "xdp_cpumap.bpf.o",
+                           on_attach=lambda: bpf_map_set("map_cpumap", 0, 2048))
+
 def _set_xdp_native_sb_on(cfg) -> None:
     prog = cfg.net_lib_dir / "xdp_dummy.bpf.o"
     cmd(f"ip link set dev {cfg.remote_ifname} mtu 1500", shell=True, host=cfg.remote)
@@ -192,6 +199,19 @@ def test_xdp_generic_mb(cfg, netnl) -> None:
     _test_v6(cfg)
     _test_tcp(cfg)
 
+def test_xdp_generic_cpumap_mb(cfg, netnl) -> None:
+    """Redirect all packets to a cpumap from a generic xdp.frags program."""
+    _schedule_checksum_reset(cfg, netnl)
+    _set_xdp_generic_cpumap_mb_on(cfg)
+    _set_offload_checksum(cfg, netnl, "off")
+    _test_v4(cfg)
+    _test_v6(cfg)
+    _test_tcp(cfg)
+    _set_offload_checksum(cfg, netnl, "on")
+    _test_v4(cfg)
+    _test_v6(cfg)
+    _test_tcp(cfg)
+
 def test_xdp_native_sb(cfg, netnl) -> None:
     _schedule_checksum_reset(cfg, netnl)
     _set_xdp_native_sb_on(cfg)
@@ -230,6 +250,7 @@ def main() -> None:
                   test_default_v6,
                   test_xdp_generic_sb,
                   test_xdp_generic_mb,
+                  test_xdp_generic_cpumap_mb,
                   test_xdp_native_sb,
                   test_xdp_native_mb,
                   test_xdp_offload],
diff --git a/tools/testing/selftests/net/lib/xdp_cpumap.bpf.c b/tools/testing/selftests/net/lib/xdp_cpumap.bpf.c
new file mode 100644
index 000000000000..150352343114
--- /dev/null
+++ b/tools/testing/selftests/net/lib/xdp_cpumap.bpf.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_CPUMAP);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} map_cpumap SEC(".maps");
+
+SEC("xdp.frags")
+int xdp_cpumap_prog_frags(struct xdp_md *ctx)
+{
+	return bpf_redirect_map(&map_cpumap, 0, XDP_DROP);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0

