Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520AC3C3F5B
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791134202; cv=none; b=RBpbQzji+17Q5/RfUSBYxuC7XiJPWCy1RFq+9RHZsxqqhVF0tM4XNi50MQLhN6km0ean5nQwav6+aMsAFTtX0g6sw9N47Eyj66ntxyivyLWVgqku+GIWUiop5Mqjmj8IcLTVLVc2y6nMLO+j17+1vagmUecfuXC63BlS9SZ8ZNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791134202; c=relaxed/simple;
	bh=o2jtQj2OHXY/6owvSxAwiCPLhU1mv6LvtL3CrbNafTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDMmVUHaCSZ4rF/tu+soYwkEmRnvXLSb18sY3Y5KPbzoR/nYC/gHdclkKAtoDCCfEa1QhRhTM0wSwSo+HlgKY7qdwr6xhLKNe+3KSoswnBUJQxtp8BiE3k4fi0F5EtB9gWpU0lWqmBC6XQknQsXHeTVb3Lr4+7ro9UAozTZO/7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=wtHi+Nmp; arc=none smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="wtHi+Nmp"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2e3dcfe205so157966066b.0
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 10:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1791134193; x=1791738993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+bqyPjoRf7iBEIUgxbf57WQODywLy9nIG08b3lo6o1E=;
        b=wtHi+NmpZ551fCDywJJyI4la05CKLKTZBQQjTmR4d5x9DA1AUt6lvv0VPcDWFuIeaG
         ni9NvMmw1JAAREcGSLz/4Denmv7Y6YfNeq2abzlxrACYALFiW47+FmRvPgw2uvfwtNYL
         sT3cEWrU03xoijwLauCzEhcT+invUb28ENQof69s88FyMX5NWaYRVZRNCVZyHeqGVO2J
         +zb6t+bZqfC7Hj6KHYfJMUKZtlPVOMDgHAUKH3nmV8sE9s/JkCNqePsJNI3yP1Tk59n5
         ybQwhOPV4FcfETIus11kqR6huE/BoRZIl45/2DBj+5w/v82utBRFkcwYNTIl64N765rm
         V90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791134193; x=1791738993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+bqyPjoRf7iBEIUgxbf57WQODywLy9nIG08b3lo6o1E=;
        b=2coaARxtS1qHZhiQhkpaZnKq0dECafvbH5+VcCYTDqW8qKLaTV5sYINynhSkjaWnYt
         qocw9DggkiOtaG/NacN7jLrkyZeqZgBDdlr4PtwCnIFS/iKuN/FN6cUAvKTGwYCer2ZU
         Q6SpGo3b2oe8JPfocb3An5Npea/jIHHotF4wxQnN++e5o8MrNj14Udv8eEnK3RPmQxFg
         h/2pcrulJBjVJ9KkCbZrtGhexyC2x0aPkWp22qPCMFJ/yxjt7jsDcO6V4IT5wR7vuJ3l
         sG28pYFF9gbdvRGhtDOYbAESbgLgi/yCXe3GUtNk+EQNlQFSi5es/lCiLwemfQeXi2gV
         kSJA==
X-Forwarded-Encrypted: i=1; AKwUvBxDiien1FCIS0ViwidFMAnzeARVDQ8JHJJy62wQUUSkq3F+KR97Cc8MWo5jjpgaSZn83yeuphw=@vger.kernel.org
X-Gm-Message-State: AFuF++kw66rigq7jqKWcRyF827LxzDA7JrNh6mFzmP29bYO/vK5yAQag
	MJFV/MtCXjsrd6gxfqIIGOqwdKr0cFyDjtYjYfBGPq/un8mU6l9ACY8Lka1Hj/UtWA==
X-Gm-Gg: AYBFou2Vq+yp7UZrM+jNwENJUoVHwj8aRejX92eKCoKpoX53JAtYAL5eHam2iFeDspc
	j4E3TrNw2zbzS3ea6MHk9bPjIKw0Is7FJwyG0cOI6piE6eEXoaY9KIyjNAFKkADhDrqrOFn8xSn
	vYCXN3/JxlosZ5tmB1sPsJh+sTKzndmpflqZZM2nHrbKnLdgZKWXReqdFc611iz29oSangDzTFH
	DnTeqEc6DSz82hmor9rxbWvp91I6XbOzWhVQW3w3K9AG3E42guxfVfAIvQ8KcNKgedh9R+b+6S2
	XFXoItIehGEC/2jPARa6PJwwdcu3IQfnTidy1hdllJG/50efV0NFMI8B8qQoiV/lFoUqDRL85fo
	6uPCUztoNC/daiEPN5LQzW54VMpg/qGEBAsZ6l67TUD9kV2yh/vj6SB0SX+5gGoUVeDPSV+NbK2
	aoQcworNJb1tDRSJz6PanpaNHQFIm8B1xHmGH6jHR34OeH5OZn+uPLdc8x1KwKUDzp5yzq6dEaA
	4due8HxeAO2zUMNPb8TRwhga9eNzeIow1Mhxykgf/Q800nLeR0VT3JtJXjMkRe7cgurs6HmTgNn
	ogN34QyxuhN1DpR4f/8YJdKJhybW+GMC/Dqri+vsv7g68sjXFI+jWqErxC7Kw5hIzd+kSeu6pJy
	ZmFXPUlSiymlEG32PamwmAJregybkRIPggXYdHDCg6qcPcsIeyam3pVrCRXnDXxneZw2uv/Zutm
	N3vMm15I5/0JKBT1OHnGwU1a8=
X-Received: by 2002:a17:906:4fc5:b0:c26:1649:47b4 with SMTP id a640c23a62f3a-c2e4afee0demr740206366b.42.1791134192866;
        Sun, 04 Oct 2026 10:16:32 -0700 (PDT)
Received: from Desktop (pd9513667.dip0.t-ipconnect.de. [217.81.54.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cf9ddbesm317345166b.69.2026.10.04.10.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 10:16:32 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: pablo@netfilter.org,
	netfilter-devel@vger.kernel.org
Cc: kadlec@netfilter.org,
	fw@strlen.de,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	geldot@protonmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH nf-next v2 4/4] selftests: netfilter: cover a TCP flow whose reply is never seen
Date: Sun,  4 Oct 2026 19:16:28 +0200
Message-ID: <20261004171628.3544978-5-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004171628.3544978-1-julius@bairaktaris.de>
References: <20261004171628.3544978-1-julius@bairaktaris.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a case where ns2 answers over a direct link, so nsr1 only sees the
original direction. The forward hook must count less than half of the
transferred bytes, which only happens when the flowtable takes over the
connection.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 .../selftests/net/netfilter/nft_flowtable.sh  | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/testing/selftests/net/netfilter/nft_flowtable.sh b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
index 449c518bd947..2c2669b8fccf 100755
--- a/tools/testing/selftests/net/netfilter/nft_flowtable.sh
+++ b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
@@ -516,6 +516,81 @@ else
 	ret=1
 fi
 
+# Asymmetric path test:
+# ns2 answers over a direct link, so nsr1 sees the original direction only.
+# Such a connection never becomes assured, but the flowtable is expected to
+# take over the direction that nsr1 does see.
+check_orig_offloaded()
+{
+	local what=$1
+
+	local orig
+	orig=$(ip netns exec "$nsr1" nft reset counter inet filter routed_orig | grep packets)
+	local orig_cnt=${orig#*bytes}
+
+	local fs
+	fs=$(du -sb "$nsin")
+	local max_orig=$(( ${fs%%/*} / 2 ))
+
+	# the flowtable takes over after the first few packets, so the forward
+	# hook must see a small fraction of the transferred file.
+	if [ "$orig_cnt" -gt "$max_orig" ];then
+		echo "FAIL: $what: original counter $orig_cnt exceeds expected value $max_orig" 1>&2
+		ret=1
+		return 1
+	fi
+
+	echo "PASS: $what"
+}
+
+test_asymmetric_path()
+{
+	ip link add name eth1 netns "$ns1" type veth peer name eth1 netns "$ns2"
+	ip -net "$ns1" addr add 10.0.9.99/24 dev eth1
+	ip -net "$ns2" addr add 10.0.9.98/24 dev eth1
+	ip -net "$ns1" addr add dead:9::99/64 dev eth1 nodad
+	ip -net "$ns2" addr add dead:9::98/64 dev eth1 nodad
+	ip -net "$ns1" link set eth1 up
+	ip -net "$ns2" link set eth1 up
+
+	# ns1 keeps sending through nsr1, ns2 answers on the direct link.
+	ip -net "$ns2" route add 10.0.1.99 via 10.0.9.99 dev eth1
+	ip -6 -net "$ns2" route add dead:1::99 via dead:9::99 dev eth1
+
+	# with PMTU discovery the endpoints size their packets for the
+	# router's link, so the fast path forwards them unfragmented
+	ip netns exec "$ns1" sysctl -q net.ipv4.ip_no_pmtu_disc=0
+	ip netns exec "$ns2" sysctl -q net.ipv4.ip_no_pmtu_disc=0
+
+	ip netns exec "$nsr1" nft reset counters table inet filter >/dev/null
+
+	if test_tcp_forwarding "$ns1" "$ns2" 1 4 10.0.2.99 12345; then
+		check_orig_offloaded "flow offloaded for ns1/ns2 without reply"
+	else
+		echo "FAIL: flow offload for ns1/ns2 without reply" 1>&2
+		ip netns exec "$nsr1" nft list ruleset 1>&2
+		ret=1
+	fi
+
+	ip netns exec "$nsr1" nft reset counters table inet filter >/dev/null
+
+	if test_tcp_forwarding "$ns1" "$ns2" 1 6 "[dead:2::99]" 12345; then
+		check_orig_offloaded "IPv6 flow offloaded for ns1/ns2 without reply"
+	else
+		echo "FAIL: IPv6 flow offload for ns1/ns2 without reply" 1>&2
+		ip netns exec "$nsr1" nft list ruleset 1>&2
+		ret=1
+	fi
+
+	ip netns exec "$ns1" sysctl -q net.ipv4.ip_no_pmtu_disc=1
+	ip netns exec "$ns2" sysctl -q net.ipv4.ip_no_pmtu_disc=1
+
+	ip -net "$ns1" link del eth1
+	ip netns exec "$nsr1" nft reset counters table inet filter >/dev/null
+}
+
+test_asymmetric_path
+
 # delete default route, i.e. ns2 won't be able to reach ns1 and
 # will depend on ns1 being masqueraded in nsr1.
 # expect ns1 has nsr1 address.
-- 
2.53.0

