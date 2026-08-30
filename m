Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947E8353A92
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 23:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788132135; cv=none; b=eiOeqjJ4gFOxK+tPhX2vfa7ABKqgLtjSM28RG8i1rRlhQgoCrYADzxDNNHeyqSeAbsONWi83oEQNjA7UF86QIV3VFlId2yrdaCCZ/3xg0MXMsNZR/zVrqa6vN3qX7JcyOZR7EoBavrNJ/FPtIEPm/1j0MU4GFkGObzKUi6+OLJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788132135; c=relaxed/simple;
	bh=Ev3T7nRFXsNE7bJfZqzSGPSEaUayY0VO+QHWI+zeEKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n3cY8RWJKc2mi8L4jBUUgQ3o8AMVWVy2pTMJju7w09qVFw2MnVesj+3O5cdeOrwKrEM32/pACKmg72gaQCiG5D5+wPbTHPAGUv8LXwY/IAkBCdq5CnshU95riYFjHqULgr1l0WlblXHH6cEhKNw08J1j28iX923TIg0mdVpwkQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ON9EYsEn; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ON9EYsEn"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-81e6f0b4610so26056237b3.2
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 16:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788132132; x=1788736932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n4rOnTRkH1wkU5lCvSZzN1icwwcD6oE7qDsPfernsaU=;
        b=ON9EYsEnjlTGCicprOiA1hQi9sfgPdkhmeaqIEg4xHLupF2/qZ7KweQ1P8NisvvPTx
         S+hZ3aEZBvQKHvWse0c81dj4R1+AY9lksBRxOxB2C1aedfiltUFb8JoLF22XBD/ez7F1
         EsXKwkfRy95XxCQuksTryoP7gC1duhYRRQBoqCUHLLJ09cPrA/mYiNxjfxXrd6AHr5OF
         +k42eDdfz/DCEBsZhlSx5ei3sWRN+jnpLH779gumKBZHiZbH78VcssS092utL9FhzFcu
         oedvgKZbkFw11KxPt3441jmpX7Gfgw5qOq+iab4dsSiNxm6KCkO/RfFNnYBMRUkZrU0q
         K+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788132132; x=1788736932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n4rOnTRkH1wkU5lCvSZzN1icwwcD6oE7qDsPfernsaU=;
        b=n4jzIokCWFlv2GL9n8TYTmswOJ4CEArgmBIfnvPUSMa32+rMl48scD62t2fsg+fNci
         j5Rh/Xzg1bXuOEQEoN0ZKVs1puiGTWMMCjWeMdyX/Rmagtb6OeyeJ/eMqEiTLeMTzB2m
         YzyA26pq2x79t0NHEoGUtwLVXO21lS75LavAS3xb+lv8BK6RyM7j0FE4zvMvMXQWclQ5
         JLNuvkD7EeAVBV8DwesA/PJirFtemnq742AMyGV1pSVzkKLYj75qvl7269YL8PD2PFRN
         Qhp7j1hrU066zO3Fb/LPtyjTw1AH6R1liCoWD3w9srsnIQXWDsUKo3CLlM1Bm+JOcAfQ
         qgJg==
X-Gm-Message-State: AFuF++nUW/iKAISnwQd2F7Jccz7waPJdaElKzVIra3k0AREy4PScXUPz
	ES9MuGdRRMkz/BPhHsI3kezZzeNai8B4bGwrMsCnyZAjvefAXQq2uid0
X-Gm-Gg: AYBFou0KPKOEWDzMjipTVH336ATTHi9nLYWfKq4PguXJW1UK6JyV6PEEhNMmnatiR5D
	P+w3j2ZRcS4PCOmZfNJ3b6kTxJjgaSuCOfcpIAYzhCen8hVXSwN+eqAhL05LOI+59TlHaKgnsO6
	gt9Z9m2pivruVfC8KzHQ4WNnsfg6lanlX5GmH+kUpg/yJi+FWLT3AtSrorNBOysdqriYKw7aokF
	ia2CfHMm3QZo+ruzqMGpv02cXST9rJkAPEpT/RN+KGJ0XX4N16QJEoHru6Ylrg+qyS2MolEoS5I
	9cyciIZhBgwjfE0Fh26P1wSsOm6ERd303qV2clKWAt5fUxF7yge53NgawsektQY8C/QBQjLppOH
	pCsYbhYdC0WrbH2VfPR5s0VoDLdTJxyy4quRXVe/jNcqC1DS3OZ4IP1fDqsyzmBG7D6LLGQDOcn
	3UgueMRGd2eW/l0imoZ4TRKSlEw30hqc0tlRtI0SYG
X-Received: by 2002:a05:690c:38a:b0:861:d742:8c1 with SMTP id 00721157ae682-86722c33022mr677777b3.2.1788132132176;
        Sun, 30 Aug 2026 16:22:12 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e677606aesm39025937b3.45.2026.08.30.16.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 16:22:11 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matt Vollrath <tactii@gmail.com>
Subject: [PATCH iwl-next 0/8] e1000e: use page pool
Date: Sun, 30 Aug 2026 19:21:38 -0400
Message-ID: <20260830232146.36948-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converges the three e1000e Rx paths into one and then makes
it use a page pool. The jumbo path is chosen as the golden path because
it is the only one that can handle every combination of MTU and page
size. Any performance regression caused by using that path for all
configurations is remedied by eliminating allocations and DMA mapping
from the hot path, as shown in benchmarks below.

There are some general modernizations in this conversion, intended to
make this driver match conventions found in other Intel drivers. The
copybreak parameter is removed. The NAPI skb cache is used. The netmem
API is used for chained frames. Prefetch is used optimistically in the
cleaner loop to pull in the next descriptor and the frame headers.

User-visible changes:
* The copybreak module parameter and its documentation are removed.
* The rx_header_split ethtool stat is removed.
* Small packets are charged at the buffer's full 2 KB truesize at
  standard MTU.
* Jumbo MTU frames are delivered as 2 KB chunks. At MTU > 2026 this
  increases userspace copy overhead by gathering more fragments and
  increases truesize accounting per frame. This is described in more
  detail below.

The series begins by fixing some existing bugs which would either be
more reachable or have worse consequences after the conversion.
Missing support for CrcStripping=0 is added. The page dump routine's
mis-read of jumbo buffers is remedied. A race between the reset task
and runtime PM is guarded.

Then the standard and packet-split paths are removed, making the jumbo
path the only way to Rx. At this point standard-MTU Rx allocates and
maps a page per packet, until the page pool conversion removes that
cost.

Next NAPI is disabled while the adapter is down, which is required to
pass assertions when the page pool is destroyed.

Next is the main event, the singular Rx path is converted to use a page
pool with support from libeth.

Finally, a small change to Tx to return skbs to the NAPI cache, which
the Rx side now pulls from when constructing frame heads.

Benchmarks were run on an I218-V and Xeon E3-1240v3 pinned at 3.8GHz.
NAPI was isolated on one core and iperf3 on another. ITR was fixed at
4000/s because the adaptive scaling can take a few minutes to settle (to
be fixed separately). C-states above C1 and EEE were disabled. Kernel
version was 7.1.12. Direct link from sender to receiver.

The sender was an 82574L in a Xeon E3-1270 pinned at 3.4GHz, NIC vectors
and iperf3 -s pinned to separate cores, ITR fixed.

For cycle measurements, each cell is perf stat cycles on the core
divided by packets received over 30s, averaged over three runs. IOMMU
"lazy" is the default DMA-FQ. Throughput was identical between stock
and series, with one exception noted below. The stock driver is
configured at the default copybreak=256. Note that the stock copybreak
features is flawed; it always remaps DMA when sending an already-mapped
buffer back to the h/w.

Bulk TCP, segments sized to the MTU (line rate at both MTUs):

                      NAPI core cycles/pkt    consumer core cycles/pkt
  MTU   IOMMU   kpps    stock  series  change   stock  series  change
  1500  off     81.4     2523    1784    -29%    2193    2193      0%
  1500  lazy    81.4     5170    1938    -63%    2369    2323     -2%
  9000  off     13.9    11590    7574    -35%   11764   12792     +9%
  9000  lazy    13.9    21781    8423    -61%   12129   13396    +10%

The increase in consumer cost at MTU 9000 is probably because the frame
arrives as five 2 KB chunks instead of three pieces from the legacy
packet-split path. The copy to userspace walks more fragments and GRO
merges fewer frames per skb.

TCP with an 88-byte MSS (iperf3 -M 88, ~142-byte frames):

                      NAPI core cycles/pkt    consumer core cycles/pkt
  MTU   IOMMU   kpps    stock  series  change   stock  series  change
  1500  off    754.3     1453     793    -45%     446     484     +8%
  1500  lazy   754.3     3819     809    -79%     387     496    +28%
  9000  off    754.4     2231     780    -65%     498     509     +2%
  9000  lazy 520/754     6920     798    -88%     430     523    +22%

At MTU 9000 with IOMMU on, the stock driver can't keep up with the
stream at line rate. It polls continuously at 95% of the core and can't
send descriptors back to h/w fast enough, so it sends pause frames and
flow control throttles the sender.

Differences in consumer cost are likely explained by two things:
* The stock copybreak=256 leaves the payload in the NAPI core's cache.
* The high IOMMU cost in the stock driver causes it to return more bytes
  per read.

UDP, one full-size datagram per frame (1472/8972 bytes, line rate):

                      NAPI core cycles/pkt    consumer core cycles/pkt
  MTU   IOMMU   kpps    stock  series  change   stock  series  change
  1500  off     81.4     4991    4417    -11%    6409    6381      0%
  1500  lazy    81.4     7426    4397    -41%    6619    6395     -3%
  9000  off     13.9    12070    8286    -31%   12861   13624     +6%
  9000  lazy    13.9    21494    8289    -61%   12566   13772    +10%

Here we see a similar tax on the jumbo MTU consumer due to gathering
more fragments.

UDP, 64-byte datagrams paced at 150 kpps:

                      NAPI core cycles/pkt    consumer core cycles/pkt
  MTU   IOMMU   kpps    stock  series  change   stock  series  change
  1500  off    150.2     4202    3939     -6%    5541    5525      0%
  1500  lazy   150.3     6663    3919    -41%    6151    5465    -11%
  9000  off    150.2     4376    3956    -10%    5535    5428     -2%
  9000  lazy   150.2     6821    3953    -42%    6154    5453    -11%

At MTU 9000, this rate of datagrams runs up against the socket receive
buffer's limits in the series, causing a 0.003% drop rate. Because each
datagram sits in a full page buffer, the default 213 KB socket buffer
only holds 48 vs. stock's ~275. This can be remedied by increasing
SO_RCVBUF or rmem_default. This is another example of copybreak truesize
compression value in the stock driver.

Payload Density:

This table shows pieces per frame and density at every MTU breakpoint.
Stock is the standard path at 1500 and packet-split above it.

                stock (std / packet split)    series (2 KB chunks)
MTU            pieces truesize   density    pieces truesize   density
<= 1500           1     2688      0.56         1     2304      0.66
1501-2026         1     4864   0.31-0.42       1     4352   0.35-0.47
2027-4074         1     4864   0.42-0.84       2     8448   0.24-0.48
4075-4096         1     4864      0.84         3    12544      0.33
4097-6122         2     8960   0.46-0.68       3    12544   0.33-0.49
6123-8170         2     8960   0.68-0.91       4    16640   0.37-0.49
8171-8192         2     8960   0.91-0.92       5    20736   0.39-0.40
8193-9212         3    13056   0.63-0.71       5    20736   0.40-0.44

Series chunk counts assume the worst-case frame (MTU + 22: VLAN tag
and FCS present).

This series is hungrier for socket buffer size under two conditions:
* At higher-than-standard MTU, some page size is wasted because
  RCTL.BSIZE only accepts powers of two, unlike the more granular
  settings of later h/w.
* For small packets at any MTU, copybreak no longer moves the payload
  into an appropriately-sized buffer.

Matt Vollrath (8):
  e1000e: add jumbo Rx CRC stripping
  e1000e: dump pages for jumbo Rx buffers
  e1000e: prevent race between PM and reset task
  e1000e: remove packet-split Rx path
  e1000e: always use jumbo Rx path
  e1000e: disable NAPI while interface is down
  e1000e: use libeth page_pool for Rx
  e1000e: return skbs to NAPI cache

 .../device_drivers/ethernet/intel/e1000e.rst  |   15 -
 drivers/net/ethernet/intel/Kconfig            |    1 +
 drivers/net/ethernet/intel/e1000e/e1000.h     |   53 +-
 drivers/net/ethernet/intel/e1000e/ethtool.c   |    1 -
 drivers/net/ethernet/intel/e1000e/netdev.c    | 1374 +++++------------
 drivers/net/ethernet/intel/e1000e/param.c     |    6 -
 6 files changed, 382 insertions(+), 1068 deletions(-)


base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
-- 
2.43.0

