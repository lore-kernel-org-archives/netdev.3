Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6D9496D26
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791374363; cv=none; b=sJd7kxbp2fUAM9PSSPNwW2Q9YPK048liQW9rtRY1qn8oK5hgGantY9Ypa3CWM2sKXRRHLT3e39e7JlqPcnYiB+So5LSqMgjmMU9oOP4DamEwRy2ijTzUUQ4/gAcyNxdBoLVep8BQbu4mZLuSHm2QeeFl7IwRdUmb4wYkv2wp3bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791374363; c=relaxed/simple;
	bh=USMYquWjDSlhNyRAuuQZlk822YJxe0sgKgXXZbTaiuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9kTCDEepMaXbmLQQK97oEa1UR032c1RJ4rtCW21J2jDHQMwAtDkHJUr8+4p94u4YkNL/QYNYpobPffbpxfSngGUeIVk+1YVBt8OtumkrQJg4FosAxBnrS2WwAY7jhXyMpN5xAeRVGR2sxyVxRRJJWuskJw5fF2XfiDg7aGybRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ir3Y+PfV; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ir3Y+PfV"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-398b3c37877so1160961a91.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 04:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791374344; x=1791979144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RNJQaLaUPhfizQ3mt3ZckrLpssIZdRd+0u34vIFrxiI=;
        b=ir3Y+PfVvkQz2sPu/v4KfKcdRpBs11xY/pwU06eR/s6le1VMzV77ABFUFCMkVmKyT/
         rQ34l2rcnM7aBPCum6XHA0nVIFVdIPaeou9V9SC0axANiq1GykxCW/L69GdQKqf6bi9F
         JC3qwez6aTH8xl6TpJuvhUaxtVuxvFuWQkjhrjZGJuGdNsE0jBygLbmA66q7iqhG/jZi
         UQN6CZ4+Wu8FLBT1bqkwF4jpoJ5rBQS/8pPyf4StHg5bYzAt0FAwESvWlH65Pq1BTLCh
         zUJVyNviNIP2hC+TaJNArB0RKOpqcA/bkIG+k4JZOrT6GWjfJM5F2ramV0AzkQN+kHH4
         irHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791374344; x=1791979144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RNJQaLaUPhfizQ3mt3ZckrLpssIZdRd+0u34vIFrxiI=;
        b=i2nstrt45YjE6PWcKSfF7xBDgwLNObAlBH3v6Awv08hRUhZvUowgdoeoBiWRgzPmLI
         vmfeXczRooFjuo5Mawpp1cEByXf6YB/ph7C/cqnlE7P9L9gj0HkZR57Th8La/pKulNw1
         lSsWqeTGI8/YT1cAR0uPKJ8q6yWI6Kq7aZRsdh55hm8doAYIC1QjAE/YxfJ72EvAusWi
         2BKcjtGFLp78Lbh9p8XDDj/Vr4iEYsG9eNEobqGkNDdA432w0SCsw8gWHPi44McTfXjH
         jAcWNfTvJTROb5c1L+RP8Qv602HZUgLgsysgjN5Pexyij3qmz10JUUXkq4TH0losQ/j6
         +TPA==
X-Forwarded-Encrypted: i=1; AKwUvByVKaGZOemnoKqSK4E16+pd3IF3yAjPGoyUFFhy7olH1mxwB3nQgnF7LFctv89bhOwhoT1EXoc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJy+JoHoKAcnBEhAFF8m2aSHkGEMna/N02xB3luOh7/I22FaEzI
	AwbwFTXgrqHLFOjZpz6zIdxWcYqMypXA/Z93ivqJk08JScSybSQbz+xd
X-Gm-Gg: AYBFou01hhyLFYfVT1tLdet9I6ZuFlD7pnYiJSbf4GbInTwzjKZTlZgxSfl70N+v19V
	sjpjN1EMb48msNWrnaTBZa5FmV3mjgDZ1VNUO+JPMwUTI8rMVOnaNSzC++XlJB9WD/Xp61p7p3m
	St52xNnLuc/usEldvrPnFk/kNlv8PpTZBmIniLITamDqdd9XBwbM/54mgP5SvXHXE4nhdXqmANl
	0q85WRJJnnsnlRlBXmf/v34FKdQW9adaW4Ih8UpgQRhngiWoSj7fCRaLHke3+ctBRQsbpmsxnQ5
	Lmu73pe1s0E7FT4EMq6JeHi5iMoDlBdWf8gW7Omc7fUlnvDSbmpBU9jIfbPF88U2Bn8u7AsKDlv
	3XpsNZ+J4Zsp3VE/V0nQj0ql1n2EZtVIgtyE3+zSsFb7NEH7jdrcq2GcMIPmMsylrFbv7pFGiao
	pdNQRBKEzOAFaexVe9wpPEUZfa6kCWwoArTaMKDdlu/cfdROajnOXTj2fbhvnwXhIqrnmmDp8ym
	2QIRIW3VV60epDVtxPUClczM99ljHAQXI6WwH/7danuPJPKVEbn47ROzuGigFnpiOXcqxZmXm2O
X-Received: by 2002:a17:90b:1dc2:b0:3a8:545f:520d with SMTP id 98e67ed59e1d1-3a8a1ae940cmr1539624a91.32.1791374343687;
        Wed, 07 Oct 2026 04:59:03 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan (oki-109-236-14-10.jptransit.net. [109.236.14.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8987b09e2sm4456582a91.2.2026.10.07.04.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 04:59:03 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Ajay Singh <ajay.kathat@microchip.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Kees Cook <kees@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Nikolaos Gkarlis <nickgarlis@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v10 5/6] netlink: specs: rt-addr: document AF_PACKET multicast dumps
Date: Wed,  7 Oct 2026 20:58:20 +0900
Message-ID: <20261007115821.11332-6-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007115821.11332-1-sigefriedhyy@gmail.com>
References: <20261007115821.11332-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the global flag, list the attributes the AF_PACKET dump uses and
describe how ifa-family selects IPv4, IPv6 or link-layer output for
RTM_GETMULTICAST.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 Documentation/netlink/specs/rt-addr.yaml | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/rt-addr.yaml b/Documentation/netlink/specs/rt-addr.yaml
index 17ead22034515..cccfccf49cc11 100644
--- a/Documentation/netlink/specs/rt-addr.yaml
+++ b/Documentation/netlink/specs/rt-addr.yaml
@@ -77,6 +77,8 @@ definitions:
         name: mcautojoin
       -
         name: stable-privacy
+      -
+        name: global
 
 attribute-sets:
   -
@@ -168,7 +170,17 @@ operations:
           attributes: *ifaddr-all
     -
       name: getmulticast
-      doc: Get / dump IPv4/IPv6 multicast addresses.
+      doc: |
+        Get / dump multicast addresses. ifa-family must select the address
+        family: AF_INET or AF_INET6 for the IP multicast groups joined on
+        a device, AF_PACKET for the link-layer multicast addresses in the
+        device filter. Link-layer entries added explicitly, e.g. with
+        SIOCADDMULTI or "bridge fdb add ... self", rather than by a
+        protocol join are reported with the global flag set. For AF_PACKET
+        a non-zero ifa-index restricts the dump to that device and
+        ifa-prefixlen, ifa-flags and ifa-scope must be zero, AF_INET and
+        AF_INET6 apply this and target-netnsid with NETLINK_GET_STRICT_CHK
+        only.
       attribute-set: addr-attrs
       fixed-header: ifaddrmsg
       do:
@@ -181,10 +193,13 @@ operations:
             - multicast
             - mc-users
             - cacheinfo
+            - flags
+            - target-netnsid
       dump:
         request:
           value: 58
-          attributes: []
+          attributes:
+            - target-netnsid
         reply:
           value: 58
           attributes: *mcaddr-attrs
-- 
2.43.0

