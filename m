Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022504;
	b=2GPfW5tSgEI199c7E1VLbTS3FZXhDLRLipqvN+/tgleLWEtKh8qKW5/eP1MDWyhsQXx0
	 uTJgbXH5m8SWfGuEYyvfpD54fQVFUDfXT1VMgRx/6kKv1jDxEjdo1EAvbjTrpvo7DZzf5
	 jpbih+0DdwnfLoI6Kwu9o1NQ3HJwEczY+2xrvbM2Ed1lryoYj5QNVUmHfhdvGDTe01OCw
	 x0w0IvFveOj6W5uCGybXOXU2yQ/3DU5c9oPbXffihT4WrZZ0stl01Db1CLk89RHs7oZNF
	 2fDhfxL2kaitywTnf/ezLnJTo8BR/h1apywo6bGqQth2AHvSQrTmC5Ch8PJLUpIKWig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022504;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Y2Cswb7mk/fWftpb46x4/HWwEQMmKQ5VhCwrWS+t9Nk=;
	b=icuexRtFgKkJAOfj23jFYpSL3DPtP5puw1TG6vwutdzeOERGwoeOOEuC2ZoTFCIBqHvN
	 TlYZzRzQKMCDw8tzCZjKrvvPSoWMyS4qbWOs2nggh92YSG9xfUTR1KP3xZRHbuGpbR8+R
	 O6aeGiihn2pp8OYSr5zhA96fxSbcV9y6dAoH9sPfAEIhzONA+fYAgpx72yvisa9496HQ8
	 vDciycmapMIQ/t1574WfktuCCZMkxbPxuYMtOl+kgZFfxKqNl0CDQvSBwAtClphGImAew
	 DlhIMjHE56HEvxyWEhZyIKN/q0O4Mm5Eh4W1LqB1FiG3HHLmyAqSsPV04RMzcwXNq2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=FBwvPkc7;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371BB606A330
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 03:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 371BB606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=FBwvPkc7
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4d427836e9so141259866b.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 19:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794022503; x=1794627303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y2Cswb7mk/fWftpb46x4/HWwEQMmKQ5VhCwrWS+t9Nk=;
        b=FBwvPkc7z8JVDjkl73iuc92D8aW2aMEQAEb6jLcZyC+w/4wNdwq3GTXx86Dfokk4XB
         z7GSApEqc5O2lUJpormi/ofX5P+/mFwqp92hk3CrcS96cypHYEE1jPhc9Ocsfoi0EoQ3
         gB8275Jg6imTHB3wCfmjrUkbapIBqFl9dfmegq720u10UnOmoVAJCrklADFRzP0/55t1
         KfghEAF9+EyzwaQZRbtC1ou7O9n5+XJyiGqY1Kspi5a/5Aa2ZTjE/KZnAQUT2GGBOS9P
         BlSdO4LUV6w+xBZpA/v6egSVJS2ZJSYUivpY8Iq1E4olqBvypaIbtMJKbGB8PpZrH10X
         Z8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022503; x=1794627303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y2Cswb7mk/fWftpb46x4/HWwEQMmKQ5VhCwrWS+t9Nk=;
        b=L5Ava1TqvuYGZuWLVnpGxIkzWW+pSGQF8uRofQz2UOhACUoeZxUafkU5QCgbEUfQOb
         2EoXSR+Tdri3Pk+zwcwTM2WSaxcLCMTsLZKUlDxNuO26/ibuhT3pUxOlZN77WjycYJms
         SnDkxfoBSXUVxdyK2FVcGmj+lJRfzAU86g6Mt+hhPj3mzWkENIiptCrQ9LvUEzJHFTtY
         JloxF8//nMh4ZSDaVeaMfPiGzLOUJyrhmUxC7eVueznphDZNcFVDIMxHviEK+Ulx5O3C
         3mbrsgywJjOkzSznaTz3nQNKivW7gDQbEvbrE5oCJR9qNj7X3iZp6b0Bn7W0e+hIl/+q
         a+Tw==
X-Gm-Message-State: APuU4Z9aOr68b1QDc22b8R6r8aIvlNJfvogQjYmPaEQOFKdGWj5w+23v
	kn1jUO4Yat+pyF+jmc4MQ3zXRGj+OCUnNfhtKF41KQ1D5NCZX0UZWMbFxAV/2R92/PGmOaZgP7g
	3bmAqX2g=
X-Gm-Gg: AYBFou2O6Prfs/bENrGW+lXauvMtbPxMC/fKMCN1AHVX7d2lEt9vTuiWY040pbrBtUN
	py5X5Wp9e7SaNwYnD4kGRLEDTdR+8Wt305rQ6xtqgxYDbsoIVDtc2pnTs6iJlxZG9n2ZBb4Q9nJ
	i+rxc3R60pq1bOB/frjHMZW/5y13+sKCfhHB+aArAcbqWrEKhyumP5QBpvyHA9LA2FQCxBbnsOp
	uTV9CuNCfUFfLSn0NWN56N+Xk/xieaBSrfyLnF0tQrbYqmsxriC01eepBtgW8jvsvPnqNzrBrCv
	AVPtO/emgwPte1LkFwV2PuWw8MOv2cW14+d53rXIN5vyGpeuxxfMEuG5OTDlTKKrV+7TiJtV0qr
	eg1QzshPYsoBEr8kHstYdtWaNTELD/hc5fSgQDqApJ3IGEJXuAdW2rZqfG3cLAA4pyEflNa1jZ4
	fdlCpbqzSujvDX2hQA4mn8ctMvNRw7z+eSYGjJZqut85JrabiiK2S4HhOhcc8iHWcXlwTL08qQk
	hUVNg2HLA8HsrytNFEfR7Z1wXSzmZHDqcZ4sT+H1M3ZOEeQ8fz2eWdACJAAfF4JQYbL4l9tQxnl
	stY4j8Z5UFhsS7yEykhNc9RIeMK/BfBY14HYoa6HAltfIVdh8i14pjtPxKfmpGU=
X-Received: by 2002:a17:907:ea7:b0:c46:cf73:bdf9 with SMTP id a640c23a62f3a-c4d35446bd9mr357150166b.21.1794022502674;
        Fri, 06 Nov 2026 19:35:02 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d3562e00dsm121104166b.21.2026.11.06.19.34.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 19:35:01 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	David Keogh <dkeogh@amazon.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Nimrod Oren <noren@nvidia.com>,
	Alasdair McWilliam <alasdair@mcwilliam.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Breno Leitao <leitao@debian.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Danielle Ratson <danieller@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com,
	nh-open-source@amazon.com,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next 8/8] selftests: net: tx_extra_headroom: test veth peer at creation
Date: Sat,  7 Nov 2026 03:34:27 +0000
Message-ID: <73b9d23a4190cdd02e89d3a2ce8a1a21ad5feadb.1794020868.git.tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794020868.git.tianyi@cloudflare.com>
References: <cover.1794020868.git.tianyi@cloudflare.com>
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

veth_newlink() parses the attributes of the peer from VETH_INFO_PEER and
passes them to rtnl_create_link(). So one request can set
IFLA_TX_EXTRA_HEADROOM on both ends of a veth pair. test_newlink() only
covers a dummy device.

Create a veth pair with ip and give each end a different value. Then
read both values back with YNL. With a different value on each end, the
test fails if one end gets the value of the other end. The YNL rt-link
spec does not describe veth, so ip creates the pair. Skip the test if ip
does not support tx_extra_headroom.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
The test needs the iproute2 patch "iplink: add tx_extra_headroom
attribute", which is sent separately to iproute2-next. With an older
ip, the test is skipped.
---
 tools/testing/selftests/net/tx_extra_headroom.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/net/tx_extra_headroom.py b/tools/testing/selftests/net/tx_extra_headroom.py
index f94eb29a25d9..8a2284f1b343 100755
--- a/tools/testing/selftests/net/tx_extra_headroom.py
+++ b/tools/testing/selftests/net/tx_extra_headroom.py
@@ -141,6 +141,19 @@ def test_not_inherited() -> None:
                 4, "vlan needed_headroom")
 
 
+def test_veth_peer_at_creation() -> None:
+    """ip can set a different value on each end of a new veth pair."""
+    if "tx_extra_headroom" not in cmd("ip link help", fail=False).stderr:
+        raise KsftSkipEx("iproute2 does not support tx_extra_headroom")
+
+    with NetNS() as ns, NetNSEnter(str(ns)):
+        ip("link add veth0 tx_extra_headroom 256 type veth "
+           "peer name veth1 tx_extra_headroom 128")
+        rtnl = RtnlFamily()
+        ksft_eq(get(rtnl, ifindex("veth0")), 256)
+        ksft_eq(get(rtnl, ifindex("veth1")), 128)
+
+
 def setup_veth(peer_ns):
     """Create veth0 in the current netns and its peer veth1 in peer_ns."""
     ip("link add veth0 type veth peer name veth1")
@@ -307,6 +320,7 @@ def main() -> None:
               test_survives_down_up,
               test_survives_netns_move,
               test_not_inherited,
+              test_veth_peer_at_creation,
               test_push,
               test_peer_xdp])
     ksft_exit()
-- 
2.56.0

