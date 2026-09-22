Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2A24A5EBC
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 06:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790057346; cv=none; b=cq63mQjrnAMVQs4nTbZqvJg6ROnw9ayroM0iJSCrNLKAcmilN58oCQIuk0228FrzSg4T/efwVp1qoig4ELWxVem4luW5uy4ZDAccbtI/tJDSocHTE4vXvpRU4M06EqsEjdHlGgKo83w2Nam9kMf9X2iMnpw0sfkFXyXFLM6Ic6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790057346; c=relaxed/simple;
	bh=ANIBEZlzcO2SCX6d6dVKmVta7zlqyEORci5vhQ+m+Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SsXL+o0dDfH8lKj3bJC1UChe9RiztDUU8ZHY/29iYeu0cfGRTi26hkhCPkg98b5lEOtl7cODBhP+vpJJow/BV+VG1tsJYbf22w/WvQtReVv0kXH4kR9K4Qzq1V3CX3MAtfpy+VMQygG8MVA5+CQ5E5OftNhAo8BURZ7iwyXPa0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=O1v7NbyG; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="O1v7NbyG"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cc9f581c4so15722205e9.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 23:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1790057342; x=1790662142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nGjhsho1Obg08C0DESqhyAgHndfwuo1MvWkQ6H1llpo=;
        b=O1v7NbyGvmneOB2mXrsUGgESBPK7fW+bvoyDwrJ+hU43o+5fj4M+Le/Tbw9qMF/D2W
         hvMsd3NPaV+7Y32fsC0PKmdeT9sy4fQp3dsxbbQczJ6Rhxc7CvDEWQTyZH85A6eBdBvU
         2Xjn5bLGPR7ySHv0QFiVzAGXzhZdrupEZaBeYXCWMbPq8kHA25qC45h8JTF4HF7Y4FbH
         2ks6ZWqvialB4xjs8JUo/aI6Bs1sY5c3YEly5hIiTwoU7wfl0QPuygVw6IY8D3CpkugC
         p6fNkC9AeCfBHzlNM13n/gPdbpZBtHnPA/ba0cOEATty2eqOWbNvk9CEqU4Af7i2o9aE
         BQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790057342; x=1790662142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nGjhsho1Obg08C0DESqhyAgHndfwuo1MvWkQ6H1llpo=;
        b=CQnE2GggTNEs42tXHLmSPCvf9H5oihXDkFBr9iVCKWc+AorljD33LcN2No+Lslc/u/
         LLPK67kT5fWa4WuxSDoB2SmmcEn8BW0s0JdjZEY4NdfRhlo56fke1j7B/zCCNolEdBMo
         /coGwLPpmc9FgbaxufjbGsl9b7d5/QaHIjRO+gnAHL3tK8j2+sYNytwkYcxcWWvPPpGY
         DAZ5pMncz1JS6ImCm5aLfj35rmSYmPYAxLt1B56/xRL94oVJ3HcX0gQJO9GqF5bnY7Pt
         VEdPWs8wUuQ7Cnc3PlBlTs8xY08eG/7nR4Bk4XOnecYOTR6sZYvpz9A0hKwyNmSuqug3
         6RgA==
X-Gm-Message-State: AFuF++lDQgpzYHghVZyC9DxpmvkTK32R4659/mX4YmbhYW7PWhjF+E6w
	fW7pHtZjSYN2vgzPtP9SAlt4XW31Ig9ToTFcsKpcyhFKijdVKNieTkMVEdyWnS69mkNb/OvYlOo
	DFVKleb6Pg3fupE7dPycP7ANw3iGxzm2W6o9M+nUwdGceiEliqDIr9gmJPIhAnFfK8eE=
X-Gm-Gg: AYBFou0QLrlpwNC2fPbS0Of0OvPI5n2inrEAd16nZEAZByAjcgnts4fhg5VE4Xd1ofs
	ZI8l1W6bAkfxFxmrYdqDpgUZ00GBi6XBcK1G7y+RC8TDtdXomSgEofINJVod6uI438xTTZ/qP+L
	Ac/3hg7cHmBj/S2VboXXVl5ElU04ru1a2d1q1GbJ+m4KKnCm4JSWLK3fuBy0IN09orQACVtSsfh
	+8oc484UmwMDA59MTEZrvYAu2Y6lhUoZu24wMLVEinZfv4b8yffpjtbCUmguwoOPXPkFRCD2nbA
	F1wuA2As036hZOwo1gZ4sysrde95raFUYnzX3gKxqeU87cIbOkaewXn7E9MDj/tuinefc2QXNif
	+7zxqMZ+D+w6LPmgui8coiejO1xKP5QaTH9Qi+no2Yg81222r9mrQtkCwqFiksCSJHkCEdWf8GB
	VM9vdXCQvwmP3EIy7ELoMc7fxlL85Eu2aQ7sCAmuj2KbYMbJUW3+mEsblPThksBo9VLJKgWZ5vW
	PRefsaQw1cBdRIkxFYFFA==
X-Received: by 2002:a05:600c:4592:b0:49e:6836:5386 with SMTP id 5b1f17b1804b1-49fd8517e22mr30031235e9.0.1790057341936;
        Mon, 21 Sep 2026 23:09:01 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:b03b:2cfc:7208:2ecf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdad6306esm25814125e9.15.2026.09.21.23.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 23:09:01 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Marco Baffo <marco@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 4/5] selftests: ovpn: enable TCP_NODELAY on TCP sockets
Date: Tue, 22 Sep 2026 08:08:50 +0200
Message-ID: <20260922060852.2266148-5-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922060852.2266148-1-antonio@openvpn.net>
References: <20260922060852.2266148-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marco Baffo <marco@mandelbit.com>

Userspace now enables TCP_NODELAY by default. Enable it for
ovpn-cli's TCP sockets too.

The TCP peer ID capture assumes that every TCP segment starts with an
ovpn length prefix followed by a data header. TCP does not preserve
record boundaries, and enabling TCP_NODELAY makes this check unreliable.
Restrict the capture-based peer ID check to UDP.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/common.sh  | 20 +++-----
 tools/testing/selftests/net/ovpn/ovpn-cli.c | 22 +++++++++
 tools/testing/selftests/net/ovpn/test.sh    | 54 ++++++++++-----------
 3 files changed, 56 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index 2d844eb3aa6e..de96d333ee2b 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -178,20 +178,14 @@ ovpn_setup_ns() {
 
 ovpn_build_capture_filter() {
 	# match the first four bytes of the openvpn data payload
-	if [ "${OVPN_PROTO}" == "UDP" ]; then
-		# For UDP, libpcap transport indexing only works for IPv4, so
-		# use an explicit IPv4 or IPv6 expression based on the peer
-		# address. The IPv6 branch assumes there are no extension
-		# headers in the outer packet.
-		if [[ "${2}" == *:* ]]; then
-			printf "ip6 and ip6[6] = 17 and ip6[48:4] = %s" "${1}"
-		else
-			printf "ip and udp[8:4] = %s" "${1}"
-		fi
+	# For UDP, libpcap transport indexing only works for IPv4, so
+	# use an explicit IPv4 or IPv6 expression based on the peer
+	# address. The IPv6 branch assumes there are no extension
+	# headers in the outer packet.
+	if [[ "${2}" == *:* ]]; then
+		printf "ip6 and ip6[6] = 17 and ip6[48:4] = %s" "${1}"
 	else
-		# openvpn over TCP prepends a 2-byte packet length ahead of the
-		# DATA_V2 opcode, so skip it before matching the payload header
-		printf "ip and tcp[(((tcp[12] & 0xf0) >> 2) + 2):4] = %s" "${1}"
+		printf "ip and udp[8:4] = %s" "${1}"
 	fi
 }
 
diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index f4effa7580c0..6b458a654a33 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -470,6 +470,18 @@ static int ovpn_parse_key_direction(const char *dir, struct ovpn_ctx *ctx)
 	return 0;
 }
 
+static int ovpn_tcp_nodelay(int socket)
+{
+	int opt = 1;
+	int ret;
+
+	ret = setsockopt(socket, IPPROTO_TCP, TCP_NODELAY, &opt, sizeof(opt));
+	if (ret < 0)
+		perror("setsockopt for TCP_NODELAY");
+
+	return ret;
+}
+
 static int ovpn_socket(struct ovpn_ctx *ctx, sa_family_t family, int proto)
 {
 	struct sockaddr_storage local_sock = { 0 };
@@ -606,6 +618,12 @@ static int ovpn_accept(struct ovpn_ctx *ctx)
 		goto err;
 	}
 
+	if (ovpn_tcp_nodelay(ret) < 0) {
+		close(ret);
+		ret = -1;
+		goto err;
+	}
+
 	return ret;
 err:
 	close(ctx->socket);
@@ -623,6 +641,10 @@ static int ovpn_connect(struct ovpn_ctx *ovpn)
 		return -1;
 	}
 
+	ret = ovpn_tcp_nodelay(s);
+	if (ret < 0)
+		goto err;
+
 	switch (ovpn->remote.in4.sin_family) {
 	case AF_INET:
 		socklen = sizeof(struct sockaddr_in);
diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
index 9b5610837032..d744c1a97d5f 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -67,35 +67,33 @@ ovpn_run_basic_traffic() {
 	local tcpdump_timeout="1.5s"
 
 	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
-		# The first part of the data packet header consists of:
-		# - TCP only: 2 bytes for the packet length
-		# - 5 bits for opcode ("9" for DATA_V2)
-		# - 3 bits for key-id ("0" at this point)
-		# - 12 bytes for peer-id:
-		#     - with asymmetric ID: "${p}" one way and "${p} + 9" the
-		#	other way
-		#     - with symmetric ID: "${p}" both ways
-		header1=$(printf "0x4800000%x" ${p})
-		header2=$(printf "0x4800000%x" $((p + OVPN_ID_OFFSET)))
-		raddr=""
 		if [ "${OVPN_PROTO}" == "UDP" ]; then
+			# The first part of the data packet header consists of:
+			# - 5 bits for opcode ("9" for DATA_V2)
+			# - 3 bits for key-id ("0" at this point)
+			# - 3 bytes for peer-id:
+			#     - with asymmetric ID: "${p}" one way and "${p} + 9" the
+			#	other way
+			#     - with symmetric ID: "${p}" both ways
+			header1=$(printf "0x4800000%x" ${p})
+			header2=$(printf "0x4800000%x" $((p + OVPN_ID_OFFSET)))
 			raddr=$(awk "NR == ${p} {print \$3}" \
 				"${OVPN_UDP_PEERS_FILE}")
+			peer_ns="ovpn_peer${p}"
+
+			timeout ${tcpdump_timeout} ip netns exec "${peer_ns}" \
+				tcpdump --immediate-mode -p -ni veth${p} -c 1 \
+				"$(ovpn_build_capture_filter "${header1}" "${raddr}")" \
+				>/dev/null 2>&1 &
+			tcpdump_pid1=$!
+			timeout ${tcpdump_timeout} ip netns exec "${peer_ns}" \
+				tcpdump --immediate-mode -p -ni veth${p} -c 1 \
+				"$(ovpn_build_capture_filter "${header2}" "${raddr}")" \
+				>/dev/null 2>&1 &
+			tcpdump_pid2=$!
+
+			sleep 0.3
 		fi
-		peer_ns="ovpn_peer${p}"
-
-		timeout ${tcpdump_timeout} ip netns exec "${peer_ns}" \
-			tcpdump --immediate-mode -p -ni veth${p} -c 1 \
-			"$(ovpn_build_capture_filter "${header1}" "${raddr}")" \
-			>/dev/null 2>&1 &
-		tcpdump_pid1=$!
-		timeout ${tcpdump_timeout} ip netns exec "${peer_ns}" \
-			tcpdump --immediate-mode -p -ni veth${p} -c 1 \
-			"$(ovpn_build_capture_filter "${header2}" "${raddr}")" \
-			>/dev/null 2>&1 &
-		tcpdump_pid2=$!
-
-		sleep 0.3
 		ovpn_cmd_ok "send baseline traffic to peer ${p}" \
 			ip netns exec ovpn_peer0 \
 			ping -qfc 100 -w 3 5.5.5.$((p + 1))
@@ -103,8 +101,10 @@ ovpn_run_basic_traffic() {
 			ip netns exec ovpn_peer0 \
 			ping -qfc 100 -s 3000 -w 3 5.5.5.$((p + 1))
 
-		wait "${tcpdump_pid1}" || return 1
-		wait "${tcpdump_pid2}" || return 1
+		if [ "${OVPN_PROTO}" == "UDP" ]; then
+			wait "${tcpdump_pid1}" || return 1
+			wait "${tcpdump_pid2}" || return 1
+		fi
 	done
 }
 
-- 
2.55.0

