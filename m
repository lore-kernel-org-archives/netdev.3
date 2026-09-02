Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E2C4A484E
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364330; cv=none; b=MwW60Rxo/0N4fX7dIOQydcZxiGN+aXHgt+uU9AihhmV4zum70KWa3le87eOTnog69rRV/3h2aGq1APXfuvrOE7dCOX0jrxFrKbKURSVosTX3BxXFHllwd/J0NOHkqSCtyCh/29eXLZvKqRHGOb/X424RAjkPg+ItHeW/v+osJ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364330; c=relaxed/simple;
	bh=0SpbhicSZWyHqnsgQJYVKe/OrfGmV1wPZnJDnaK92og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djTzncxtTZR30DSr1+Q4Sa/6dA7u49GlA5OGWxcfXcAwikFfc5tU50yOBPI2SSlkuw2DsWzHJdlh5KFljDvCT9kccQ3MA3APIbLC7XE3xFIdW0LFGnPRmcmL6/59QU4hO5KvOjk+nTRS+mGCo56KaOOcaZg2OosZoEFBSAdfd/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=qj/3Bahm; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="qj/3Bahm"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15cf78d1a2so129357566b.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 08:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1788364325; x=1788969125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VUWG69b+8W7QCI7X0cbPtOV4RaGoCN51mNnYh+LDOwU=;
        b=qj/3BahmMCM+MIoMQB0bgWjqqZFLzD8R5lnGA+nIvPsQqO0sxeEE82+O22GWie4O24
         vzF43N58I9pCDZvFZTbDXbEsawdCi2LArkdG6XlFj6jLlqLPPBTTcc9d/vR43LuQOnWK
         u/Bv4ttCmHzdQvS024eZPzpufUIXtcKBdpH6/rXT7SXWLXGQVW7lFgOsIaNl6JLzroA1
         QRZUh6lgB6QXi6ZDcQLftzT4P4OqHLZPlP5vhPeknhw3UFJJT3txa0FPHlFXeQifqux8
         EEhcS+8TYPVFUo7VwO3pOlNqodmoWtrhsfWIWimXQOxLURyN7OVdEgBQbkX3fQZTJZN+
         FIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788364325; x=1788969125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VUWG69b+8W7QCI7X0cbPtOV4RaGoCN51mNnYh+LDOwU=;
        b=a6d9nXOjO+z5J2aY5cfsooTu0bNnJF4wBleuAzF+rB9L/VWSWekRXM8dAsXoZn26z5
         n5FLHq1/QtrZbpyKpmd/TExUdHwclja1Eb1D8i5xPkUORLQHrzshaM+QugEr0td0WDCP
         htP65VFvlf63Y8V+OI7MB/2tbMNOkCHeUQImZA/ZZ6FQtkK0j9WQYAUFGnviDlb8VxUv
         mSK5E9icFgjl3hP8o7SYgZTjkBXOPbPpCD6lcc/HVeI2to8ViJxNAYZpaYBonc+DowEG
         EaEoQ1JDGZoe3eUETg0R6eL14MH8F8FxZrZkGIT+zlqb+X4UpigXLjqoeBXKxzcP/cBc
         xAew==
X-Forwarded-Encrypted: i=1; AKwUvBwY0cZn2cgekKL1Ceuti+5zmtYQszFpipHFutrhLAy4p9fyCdggi/lF8rjoa22LQHtqh0lxvYk=@vger.kernel.org
X-Gm-Message-State: AFuF++nK0XyuvMyf7wyeEbSdnLvj+g1Mk0ITmhvklR031MsHXFJOGm9L
	VkdbXXL3y5gvASN/9SgiUk38ZUBUNGjvMAqLB/GrCPKzY9RFjQGcE5F1Cnr0wCkiWw==
X-Gm-Gg: AYBFou1pUcSq64Fue+awNI32Zwj/QXACP9YB/0F1AopS6U3c5JIhSTG4DMRwj1TyQwC
	FjzHvyvU0cfkjfH8tjlqy5cby5bMURVn7yueBLwqSGLNWFsjTJDL5ze6q4kpoMwlukZOeknsuxr
	4LuWYOAcUeZXGbrELr+PeOoBfqiWD3rDEcySKR71G04XQoKyXKDhTvgd/6wwXty/WveQqo6KYpk
	eZ/oPmIjVAcDo9QcYV854sDS/fWOIpYRw1vRJJcRF29ZbjskL2lZqkD22Bw6A8NIgJz8qeHeZjL
	oUg2Gwl5svjObfOlb/80fOYXOAiTNgzt4OcCTf0MRjO/4+2bFPh9EdO8yoZlLsqnUIOiX2GFPoe
	pDAEUjNzib27jSNDzOaxq3vIXpiFOAY/DEHMlGAqSPly7iXaMA8lQt05gyw2ge4cEa8Nikd4DRG
	jqJndhwVCQyRJiIS4kB2XXminjHlRv1LrTXivdg9ZZ8xSAvKrpWwCaWx/91lIUWdJQAwDv24DUL
	27Pl5aoJGmcIfgjGHXjesT0VyID7TIRTKCFuTAgZfOuUyTcTss7c+0KTrxN1jeGQLrn0WrPlCRf
	n0NB/iIhCykJBm/mS3ICKaVPJW89D28LV1b1G6dGwP3XL9XKhi4+ADJhyiTp3cPal1RXYMop2Qz
	wPc2TbQhpIHuVZ889VwvOupwWvN69UcyQjFlLQsEYxt1Tt3hzCXs08siixU0ngEA/oRbj9Qz793
	tIDuxJ8BYqq9Ns6mgSU8A8iA==
X-Received: by 2002:a17:907:dab:b0:c20:21be:ea75 with SMTP id a640c23a62f3a-c25d52b715amr356033066b.8.1788364324671;
        Wed, 02 Sep 2026 08:52:04 -0700 (PDT)
Received: from Desktop (pd9513d53.dip0.t-ipconnect.de. [217.81.61.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d03fbb75sm160187366b.49.2026.09.02.08.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:52:04 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: pablo@netfilter.org,
	fw@strlen.de
Cc: phil@nwl.cc,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH nf-next v2 2/2] selftests: netfilter: nft_flowtable.sh: check the priority a flow carries
Date: Wed,  2 Sep 2026 17:51:36 +0200
Message-ID: <20260902155136.4963-2-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902155136.4963-1-julius@bairaktaris.de>
References: <20260902155136.4963-1-julius@bairaktaris.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Count, on the egress hook of both router interfaces, the TCP packets
that leave with priority 0:3 and the ones that leave with none, first
with no priority set and then with "meta priority set 0:3" in a forward
chain that runs ahead of the one adding the flow. Without it no packet
carries the priority; with it every packet does, in both directions,
including the ones the flowtable forwarded past the chain that set it.
The test runs at the MTU where the fast path handles the transfer, for
IPv4 and IPv6, and fails on a flowtable that does not store the
priority.

Assisted-by: Claude:claude-fable-5-1
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
New in v2.

 .../selftests/net/netfilter/nft_flowtable.sh  | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/tools/testing/selftests/net/netfilter/nft_flowtable.sh b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
index 449c518bd947..ab7732358e1d 100755
--- a/tools/testing/selftests/net/netfilter/nft_flowtable.sh
+++ b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
@@ -458,6 +458,106 @@ fi
 	check_dscp "dscp_fwd" "$pmtu"
 }
 
+check_priority()
+{
+	local what=$1
+	local pmtu="$2"
+	local ok=1
+
+	local counter
+	counter=$(ip netns exec "$nsr1" nft reset counter netdev priocheck prio3 | grep packets)
+	local pc3=${counter%*bytes*}
+	pc3=${pc3#*packets}
+
+	counter=$(ip netns exec "$nsr1" nft reset counter netdev priocheck prio0 | grep packets)
+	local pc0=${counter%*bytes*}
+	pc0=${pc0#*packets}
+
+	local failmsg="FAIL: pmtu $pmtu: $what counters do not match, expected"
+
+	case "$what" in
+	"prio_none")
+		if [ "$pc3" -gt 0 ] || [ "$pc0" -eq 0 ]; then
+			echo "$failmsg prio3 == 0, prio0 > 0, but got $pc3,$pc0" 1>&2
+			ret=1
+			ok=0
+		fi
+		;;
+	"prio_fwd")
+		if [ "$pc3" -eq 0 ] || [ "$pc0" -gt 0 ]; then
+			echo "$failmsg prio3 > 0, prio0 == 0, but got $pc3,$pc0" 1>&2
+			ret=1
+			ok=0
+		fi
+		;;
+	*)
+		echo "$failmsg: Unknown priority check" 1>&2
+		ret=1
+		ok=0
+	esac
+
+	if [ "$ok" -eq 1 ] ;then
+		echo "PASS: $what: priority packet counters match"
+	fi
+}
+
+test_tcp_forwarding_set_priority()
+{
+	local pmtu="$3"
+	local proto="$4"
+	local dstip="$5"
+	local dstport="$6"
+	local lret=0
+
+ip netns exec "$nsr1" nft -f - <<EOF
+table netdev priocheck {
+   counter prio0 { }
+   counter prio3 { }
+
+   chain egress0 {
+      type filter hook egress device "veth0" priority 0; policy accept
+      meta l4proto tcp meta priority 0:3 counter name "prio3"
+      meta l4proto tcp meta priority none counter name "prio0"
+   }
+
+   chain egress1 {
+      type filter hook egress device "veth1" priority 0; policy accept
+      meta l4proto tcp meta priority 0:3 counter name "prio3"
+      meta l4proto tcp meta priority none counter name "prio0"
+   }
+}
+EOF
+	if [ $? -ne 0 ]; then
+		echo "SKIP: Could not load netdev:egress for veth0 and veth1"
+		return 0
+	fi
+
+	if ! test_tcp_forwarding_ip "$1" "$2" "$pmtu" "$proto" "$dstip" "$dstport"; then
+		lret=1
+	fi
+	check_priority "prio_none" "$pmtu"
+
+	# The flow stores the priority set before it is added, so the packets
+	# the flowtable forwards leave with it too, in both directions.
+ip netns exec "$nsr1" nft -f - <<EOF
+table inet prioset {
+   chain forward {
+      type filter hook forward priority -1; policy accept
+      meta priority set 0:3
+   }
+}
+EOF
+	if ! test_tcp_forwarding_ip "$1" "$2" "$pmtu" "$proto" "$dstip" "$dstport"; then
+		lret=1
+	fi
+	check_priority "prio_fwd" "$pmtu"
+
+	ip netns exec "$nsr1" nft delete table inet prioset
+	ip netns exec "$nsr1" nft delete table netdev priocheck
+
+	return $lret
+}
+
 test_tcp_forwarding_nat()
 {
 	local nsa="$1"
@@ -516,6 +616,11 @@ else
 	ret=1
 fi
 
+if ! test_tcp_forwarding_set_priority "$ns1" "$ns2" 0 6 "[dead:2::99]" 12345; then
+	echo "FAIL: IPv6 flow offload for ns1/ns2 with priority update" 1>&2
+	ret=1
+fi
+
 # delete default route, i.e. ns2 won't be able to reach ns1 and
 # will depend on ns1 being masqueraded in nsr1.
 # expect ns1 has nsr1 address.
@@ -572,6 +677,11 @@ if ! test_tcp_forwarding_set_dscp "$ns1" "$ns2" 1 4 10.0.2.99 12345; then
 	exit 0
 fi
 
+if ! test_tcp_forwarding_set_priority "$ns1" "$ns2" 1 4 10.0.2.99 12345; then
+	echo "FAIL: flow offload for ns1/ns2 with priority update and pmtu discovery" 1>&2
+	ret=1
+fi
+
 ip netns exec "$nsr1" nft reset counters table inet filter >/dev/null
 
 if ! test_tcp_forwarding_nat "$ns1" "$ns2" 1 ""; then
-- 
2.53.0

