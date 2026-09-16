Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8186F4B0E2C
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585467; cv=none; b=W61FLXw8NfPLlKViFSMYsU67g9YA2cB0DA3A7CPjVy2+0yqlypeBTyeQ3DS7rKQL9F/f9+uwUBDkvmZEHLePGh5qNL2bcxGa+q34ev+mBbWWjib7tD0zVswityb01unaG1gYoa2YD2tbfxR2exc57Iez0CFEbDVE2j1A9oX/O9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585467; c=relaxed/simple;
	bh=XIdj393/uGLAGoQrs5sBPVhtuMeWqXLxiabflG7zgvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5JmPJFJdLIF5+JicIeZs4FP0EWv4GhYyPfxhy3yT4Fgcf+4VCkCuuw6/FYoMfsnAgXm3FyEhHzEl3z/bACeYGyMIHgKhFz6mdL7ThNdtMj6br3UrxnfOIWeXvY8/fsykxdOPPlc2v2+vbhWdIPV/7I5rM7QNCQFFCxPCxOvp28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvntODF0; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvntODF0"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3896ccc93b5so4008a91.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789585458; x=1790190258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AR/7xsA5W1McjKPhM3Yv4WtnQE6Tf0J/12gpTbZqeQU=;
        b=NvntODF01yKCuMc+RtGy26zikwPQM1E4aYam12COhfCZ3dePq54whWUGb8yOWkKCLR
         0aOWXKWjyIX9LHDelt0tgMWNS3DIOcauVqGI0EC58zEFY0sUKxdmmePCeSbJFBgAqj6D
         2EZoESm35WfdJVenS6e+ofKJSh8pFkaXQyXC4nOYx4y9rxIbHzCVUB/k+fj+B4FctDA7
         yYD//v/IfC1cG06N8tG48FSJou1rabkH7klWh85Ls+A6ngTXTjpdNUx0LWCiMvHMb7ZI
         m1GQxMoratEiasVosUvpRVDY3k1H5swIfcTb4euVbqSatrXS5gJeXiU9y1TaTsKswCTL
         4UBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789585458; x=1790190258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AR/7xsA5W1McjKPhM3Yv4WtnQE6Tf0J/12gpTbZqeQU=;
        b=1WLUu4Hk6WkqOVNyiyXO2jt7Oc+WYUgSJj2taz3/insgH4rulO7svnrwgocZcn/lLb
         vXT4p98794nfltUTmGsDpkccczJUltXNMvHYws2KOTiwpcstk4NzTcKq60T6+fkoa6ti
         KjuqbyKImr3KPRQoxeo2oQgJRtWft/NyDr2+gJmAHUV+CAcd3lcOUFazO0rF91xwJgRc
         8bWud/Jjue78A6AxW01GQ2MQhmOgK5wcvhgWi9TDNID49m7BU+fqBRGelSTzNdxohSk/
         sIO1JklfAlgWVdC/3eSqMcWBzhbx9rxT1r2kU6KEbM0DrcRC5quyQrR3/3swFd+R1wmJ
         FNKQ==
X-Gm-Message-State: AFuF++ll7qW49oORXsdB9L8Erc42Ng+E0BcZejmjBIaekBY8GpIki8P/
	bAnTgBO+G21UnmEW3w0AMWJ1x5g5c88Zbg6lLytoH8s0nMG/VwJBS7ILHDcgCzwY
X-Gm-Gg: AYBFou063bF61huHUKNQO4EWXB0TRdfyFR+naFodqMa4dP93csG8Kz542/W/RRG7HKQ
	Npn+V/Y7pY2Qi/FWj8eexDq3b6u/hEB0lgUA6u2VyM0T9Q++YZ/xTolqiRfvLPalcEohZ9T5yv5
	uki2tpmORdS4tlmDNd/5rEkZgPvooZqzKJCWWzcNczG+W/j5KAVMIbHoqbq9zrEhtWpfpv3aept
	Cx10zwqXDVqbBeLMHyX5Sq5k+nVWT7kCBtvSG1FeRsAz8zn6JNUtUcPnnTT3fJswMHaEBon5y1G
	gjeH6XuPdfUJe+1tQWnO0HZ7S4rn4kkvxR5GAvrBSCtQCBYPFtAsnLd4tXezhAj4yrcP9jwxnZn
	WokE0Ob1UJK8m1nCJwaWx6FXJZkt0xR0LYyFQBytwNwFafDgW0YSybPOgH+JpDgD7hvBycqJw7f
	1PeVQLjj74RyU5A93wBEe1KQkpRZWwxaGNBe2BtTCXeBnyvW67KhgJcpNv6DgsvjhEpNqSpcKx7
	zY=
X-Received: by 2002:a17:90b:2645:b0:398:9be9:ab92 with SMTP id 98e67ed59e1d1-39e1e5777famr9204363a91.23.1789585458246;
        Wed, 16 Sep 2026 12:04:18 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e362e9402sm717041a91.15.2026.09.16.12.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:04:17 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC net-next 6/6] selftests: drv-net: measure devmem performance with kperf
Date: Wed, 16 Sep 2026 12:04:09 -0700
Message-ID: <20260916190409.1222272-7-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916190409.1222272-1-sdf@fomichev.me>
References: <20260916190409.1222272-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devmem performance test using kperf and SystemMonitor.

Tested on two mlx5 hosts. Benchmark metric output:

  # # ktap-metric-policy-json: {"name":"throughput","regression":{"better":"higher","compare":"p50","relative_tolerance":0.05},"summarize":"distribution"}
  # # ktap-metric-policy-json: {"name":"tcp.retransmits","summarize":"max"}
  # # ktap-metric-json: {"host":"remote","name":"throughput","shape":"scalar","time":20.457972,"value":321.225}
  # # ktap-metric-json: {"host":"remote","name":"tcp.retransmits","shape":"scalar","time":20.457989,"value":903.0}
  # # ktap-metric-json: {"host":"local","name":"throughput","shape":"scalar","time":20.457993,"value":321.16499999999996}
  # # ktap-metric-json: {"host":"local","name":"tcp.retransmits","shape":"scalar","time":20.457998,"value":0.0}
  # ok 6 devmem.check_kperf
  # # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:1 error:0

Note this is still CUDA (because 4K udmabuf needs my posted genpool
changes), will move to udmabuf once the genpoll stuff lands.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../selftests/drivers/net/hw/devmem.py        | 70 ++++++++++++++++++-
 1 file changed, 67 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index 82c11ffc4add..4795b33e5efc 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -3,8 +3,9 @@
 
 from os import path
 from devmem_lib import (setup_test, run_rx, run_tx, run_tx_chunks, run_rx_hds,
-                        run_rx_large_niov)
-from lib.py import ksft_run, ksft_exit, ksft_disruptive
+                        run_rx_large_niov, require_devmem)
+from lib.py import (defer, EthtoolFamily, KperfRunner, ksft_run, SystemMonitor,
+                    ksft_exit, ksft_disruptive)
 from lib.py import NetDrvEpEnv
 
 
@@ -36,12 +37,75 @@ from lib.py import NetDrvEpEnv
     run_rx_large_niov(cfg)
 
 
+@ksft_disruptive
+def check_kperf(cfg) -> None:
+    """Measure CUDA-backed devmem RX performance with kperf."""
+    cfg.require_nsim(False)
+
+    kperf = KperfRunner(cfg)
+
+    dmabuf_size = 2048
+    # once udmabuf works well with 4K:
+    # dmabuf_size = 64
+    # if cmd("test -c /dev/udmabuf", fail=False).ret:
+    #     raise KsftSkipEx("Test requires /dev/udmabuf")
+    # size_limit = cmd("cat /sys/module/udmabuf/parameters/size_limit_mb",
+    #                  fail=False)
+    # if size_limit.ret == 0 and int(size_limit.stdout) < dmabuf_size:
+    #     raise KsftSkipEx(
+    #         f"Test requires a {dmabuf_size} MiB udmabuf size limit")
+
+    require_devmem(cfg)
+
+    ethnl = EthtoolFamily()
+    rings = ethnl.rings_get({"header": {"dev-index": cfg.ifindex}})
+    defer(ethnl.rings_set, {
+        "header": {"dev-index": cfg.ifindex},
+        "tcp-data-split": rings.get("tcp-data-split", "unknown"),
+        "rx": rings["rx"],
+    })
+    ethnl.rings_set({
+        "header": {"dev-index": cfg.ifindex},
+        "tcp-data-split": "enabled",
+        "rx": rings["rx-max"],
+    })
+
+    rss = ethnl.rss_get({"header": {"dev-index": cfg.ifindex}})
+    defer(ethnl.rss_set, {
+        "header": {"dev-index": cfg.ifindex},
+        "indir": rss["indir"],
+    })
+
+    devmem_args = [
+        "--time", "15",
+        "--num-connections", "4",
+        "--read-size", str(64 << 20),
+        "--write-size", str(64 << 20),
+        "--pin-off", "4",
+        "--num-rx-queues", "4",
+        "--dmabuf-rx-size-mb", str(dmabuf_size),
+        "--dmabuf-tx-size-mb", str(dmabuf_size),
+        "--validate", "no",
+        "--devmem-rx",
+        "--devmem-tx",
+        "--devmem-rx-memory", "cuda",
+        "--devmem-tx-memory", "cuda",
+        "--devmem-src-dev", "0000:4e:00",
+        "--devmem-dst-dev", "0000:4e:00",
+    ]
+
+    # The remote source uses CUDA TX and the local destination uses CUDA RX.
+    with kperf:
+        with SystemMonitor(cfg):
+            kperf.run(client_args=devmem_args)
+
+
 def main() -> None:
     """Run the devmem test cases."""
     with NetDrvEpEnv(__file__) as cfg:
         setup_test(cfg, path.abspath(path.dirname(__file__) + "/ncdevmem"))
         ksft_run([check_rx, check_tx, check_tx_chunks, check_rx_hds,
-                  check_rx_large_niov],
+                  check_rx_large_niov, check_kperf],
                  args=(cfg,))
     ksft_exit()
 
-- 
2.53.0-Meta

