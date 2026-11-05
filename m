Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889245;
	b=YayStYc9x+oCB70xq0b3lkTpO4PbB/oPwSegDCdPEkyv61xc2Iq63q+gKgRPvGJ1Dak5
	 VP5xlEe8tlILE+waBnbb06Soc+Fbt9dJ4Wb2Jwx+pt0u3p+4myOrQbHXZqOzzqSuw1WxQ
	 RpgL0Tmaorihr8CSzSDr6zt7niVY7tce7D4KREO8OA7yOMXFffz6+3rbyDCDDMlZaXWz8
	 zy42Jmdwm3MIQl3jvfw5xviPUIEmBkD8FAZG+zsMwPmftEim1ouVNrugb3tJofThDHCJF
	 L2AdafNrEFKP0737z68TWXbUBLBfvRZRXkh7lcfW1ciiDjqE2XZCvj70GCamHVDTM7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=my9OBy1bBkluWAYUioairn9napGH+N/4+ZlIeEPaY8c=;
	b=QQ1vtFUqr9x4yZZ+Uu6kVQhGHDWoea5DtfhmgueEcxJOedj8Mwogq1tXONwS1jOhSOIf
	 OBvTVzQwOl8txVplfUdE6YbcZMQHPBI2Ij8sN7RnORqJsUVhs1V6InNOEn4cNDlNEE6q9
	 ZbR261ySvXZeZwFMTeZepH0J5kHi5T/n/jrnepUS+5iVQFe+Uxz94IwBqHDIOR3xmtfQP
	 j+CgvNsQBzj14gWlT0J8tjXmu+5Gid1ptyuu6itK9Qm0ybSlHpL6RJBjEdePndrUy7oIB
	 R2sQRA5jgS6wSaLwyI7Mt+xKEL/ziHhUQjfKkA8Zoctf046LVBrhso1UcTTNCi+H96w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b="e/BKoors";
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639AC606A32D
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 14:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 639AC606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=e/BKoors
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so303430166b.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 06:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793889244; x=1794494044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=my9OBy1bBkluWAYUioairn9napGH+N/4+ZlIeEPaY8c=;
        b=e/BKoorsJFShcC8l88V2dJXe8612SlmcCnK41t7jRCWKK4eDqHPbYBXK3Dr3Z545N0
         yM+WASdRiPoPoA95bBpkfuTeUH74OTCCYJLwj7cVgLHrZpOnqg1u1w1hTsArDThQqRho
         f0EyI3NUPOaf8wW96n4tYhmikxR8ZCJf6VwS7ZGkMwlZwzY0oFyIAvcm+Yh+a/SZ7quf
         kOqxek4Ske891KPElKAH1lrjoLt/S2O/LqifV0eAheZwxNAVTggE1nXlCY8sexsq+dj3
         43RCqOIJXhaTCRb8kgW0vs33xVe5t6UNTMpJwtEdP2E4mcfykW8kOUGhyygWlW5NXwx5
         k/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793889244; x=1794494044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=my9OBy1bBkluWAYUioairn9napGH+N/4+ZlIeEPaY8c=;
        b=F3CV65TzekZbHotkr95bzKlU8bO1IQAJztsmvOgFsW6BVuiGmbW7gG1gGVzJFAiAlV
         z7OivveEKPmMywrDKZiztwuoFbQivqHMfpuywxn53VnRFw8i0nxtl4sVQJuBUtAMkNEa
         +k3UuqZywdViecxl1g4vXMPayQFNjS/QmeqxL3WslD9FIRTUeZZeBU2n1xBYHsN3cuc3
         BbWeSe5OrO6Ssmu0MqF4lwFm6eGiKDZDNlItab3q8esH+7S3vg9BjUqL3H7OjsPAT2Sq
         ZhgYNaLlXaDKOlw/FwYR8GjpEW/vpneo9E/HLEZupGeO6/w7xHpKNSZwUZZJSrFXif0o
         xVRw==
X-Gm-Message-State: APuU4Z/BbMei1I68pqmznI9zE4dqHQatjIgz26atSFHT+UxbbeYyv8G3
	uC3LydtUrlrelAvCBgSJKRay8rFXa+tRRhtkvHr82HGG0csxzfq0+UoHSCcfadDRq9eOFvtFPjA
	IoNoXn28IMA==
X-Gm-Gg: AYBFou30lLT7H6yT+mRObH92IcOjnk9cScpy4HAN6px52+3PsDBPoTgAEO3u6hH/6Yc
	+kORfHfDP/qRwiABivKTiiUKiZ3HOYJ7ENP0mKngSGWfL3pvzrwYcG2EBy2WMFkGFvSu73diORv
	lb6/d0Bzav61p3ULq47wNcrKP4wlYh4UJ0MtCLgRKvaIc1LpzzWgFDvJ79nvpAjbnMtEBCMO42m
	F9Y1b2IWxvn5TvoqQx9Gg//waglklBaD8RaT1nZX/IlQD/bOqPz2A9sGmI7xQsZQ+z0W8Ny/vZm
	Q/knUPLxL29sjx0bHfnThsVNcqLlprQYmEetn22xftm0tCNvWSb+Y4hLK1u4+1I0GVw53WVFNi+
	gNogpeKZ/vxjd53qTaCXTVHwt8IVqlxdQSV2fugRx7SySqYbpSxUK8JepovE0x5cJ+7oiYhK3Wt
	S1Ha9wo63FPJj8jqGNIrx0VOA7CsDjN7B/N4ktv4JnLAGPf3Mok9xSF2RuaPQe4FdptfLY1i9y0
	Ulqxjdcoh20ibn0+qWDrjqgRmiHHPsxmWP1RyLwxDMlRST4Dx2IJWZL29u2TaLXtCsn4248kjU+
	jSXQVz8/TWBdnScCDxotDxV+UNUFmknq
X-Received: by 2002:a17:907:f20b:b0:c4c:eb16:4014 with SMTP id a640c23a62f3a-c4ceb1640e5mr896680666b.1.1793889243799;
        Thu, 05 Nov 2026 06:34:03 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e466be0sm178671066b.54.2026.11.05.06.34.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 06:34:03 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	toke@redhat.com,
	lorenzo@kernel.org,
	horms@kernel.org,
	bpf@vger.kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	kernel-team@cloudflare.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	jiayuan.chen@linux.dev,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next 3/3] selftests: net: veth: test RX queue NAPI links
Date: Thu,  5 Nov 2026 14:33:56 +0000
Message-ID: <20261105143356.17062-4-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105143356.17062-1-tianyi@cloudflare.com>
References: <20261105143356.17062-1-tianyi@cloudflare.com>
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

Check that the napi-id of every RX queue matches a NAPI instance of the
device. Also check that the queues are linked only while NAPI is
enabled. Run the checks with GRO on and with XDP attached, and across RX
channel changes and link down/up.

queue-get and napi-get are only visible through netlink. Read them with
the ynl CLI, as the ndo-xmit checks do. Compare the results with jq.
Skip the checks if the ynl CLI or jq is not found.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 tools/testing/selftests/net/veth.sh | 79 ++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 17cfe412a266..affcdbf772b3 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -107,6 +107,44 @@ chk_xdp_feature() {
 	fi
 }
 
+chk_queue_napi() {
+	local msg="$1"
+	local target=$2
+	local expected=$3
+	local ns=$BASE$target
+	local ifindex
+	local queues
+	local napis
+	local st
+	local linked
+
+	ifindex=`ip netns exec $ns cat /sys/class/net/veth$target/ifindex`
+	queues=`ip netns exec $ns "$YNL" --family netdev --dump queue-get \
+		--output-json --json "{\"ifindex\": $ifindex}" 2>&1`
+	st=$?
+	napis=`ip netns exec $ns "$YNL" --family netdev --dump napi-get \
+		--output-json --json "{\"ifindex\": $ifindex}" 2>&1` || st=$?
+
+	printf "%-60s" "$msg"
+	if [ $st -ne 0 ]; then
+		echo " fail - ynl cli error: $queues $napis"
+		ret=1
+		return
+	fi
+
+	queues=`echo "$queues" | \
+		jq -c 'map(select(.type == "rx") | ."napi-id" // empty) | sort'`
+	napis=`echo "$napis" | jq -c 'map(.id) | sort'`
+	linked=`echo "$queues" | jq length`
+
+	if [ "$queues" = "$napis" ] && [ "$linked" = "$expected" ]; then
+		echo " ok "
+	else
+		echo " fail - expected $expected found $queues napis $napis"
+		ret=1
+	fi
+}
+
 chk_channels() {
 	local msg="$1"
 	local target=$2
@@ -255,7 +293,8 @@ fi
 
 [ $CPUS -lt 2 ] && echo "Only one CPU available, some tests will be skipped"
 [ $STRESS -gt 0 -a $CPUS -lt 3 ] && echo " stress test will be skipped, too"
-[ ! -f "$YNL" ] && echo "ynl cli not found, ndo-xmit tests will be skipped"
+[ ! -f "$YNL" ] && echo "ynl cli not found, ndo-xmit/napi tests will be skipped"
+[ ! -x "$(command -v jq)" ] && echo "jq not found, napi tests will be skipped"
 
 create_ns
 chk_gro_flag "default - gro flag" $SRC off
@@ -364,6 +403,44 @@ else
 fi
 cleanup
 
+if [ -f "$YNL" ] && [ -x "$(command -v jq)" ]; then
+	create_ns
+	RXQ=1
+	if [ $CPUS -gt 1 ]; then
+		ip netns exec $NS_DST ethtool -L veth$DST rx 2
+		RXQ=2
+	fi
+	chk_queue_napi "queue napi - default" $DST 0
+	ip netns exec $NS_DST ethtool -K veth$DST gro on
+	chk_queue_napi "           - with gro on" $DST $RXQ
+	if [ $CPUS -gt 1 ]; then
+		ip netns exec $NS_DST ethtool -L veth$DST rx 1
+		chk_queue_napi "           - fewer rx channels with gro" $DST 1
+		ip netns exec $NS_DST ethtool -L veth$DST rx 2
+		chk_queue_napi "           - more rx channels with gro" $DST 2
+	fi
+	ip -n $NS_DST link set dev veth$DST xdp object ${BPF_FILE} section xdp
+	chk_queue_napi "           - with gro and xdp on" $DST $RXQ
+	ip -n $NS_DST link set dev veth$DST xdp off
+	chk_queue_napi "           - after xdp off with gro on" $DST $RXQ
+	ip netns exec $NS_DST ethtool -K veth$DST gro off
+	chk_queue_napi "           - after gro off" $DST 0
+	ip -n $NS_DST link set dev veth$DST xdp object ${BPF_FILE} section xdp
+	chk_queue_napi "           - with xdp on" $DST $RXQ
+	if [ $CPUS -gt 1 ]; then
+		ip netns exec $NS_DST ethtool -L veth$DST rx 1
+		chk_queue_napi "           - fewer rx channels with xdp" $DST 1
+		ip netns exec $NS_DST ethtool -L veth$DST rx 2
+		chk_queue_napi "           - more rx channels with xdp" $DST 2
+	fi
+	ip -n $NS_DST link set dev veth$DST down
+	ip -n $NS_DST link set dev veth$DST up
+	chk_queue_napi "           - after down and up" $DST $RXQ
+	ip -n $NS_DST link set dev veth$DST xdp off
+	chk_queue_napi "           - after xdp off" $DST 0
+	cleanup
+fi
+
 create_ns
 
 CUR_TX=1
-- 
2.56.0

