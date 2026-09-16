Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97974EA398
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789558033; cv=none; b=YOkIY0Xj+GDL9CneQFCzzKQ44lhxmGhTn6Uozt4PxpKG2A97ySZINEFfv34yFa1xvVNQ80MwfYoO0S1qvLxbC54liR8x3QeAKGczuTR2mQRUuFNjC4UF2UEjv+JMoyVhISeNVM6DYBq1jPW04GxMhFd4YXFbRG4t9PoFi+AfBVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789558033; c=relaxed/simple;
	bh=ZZp0FXqP6ehaWkXjbXrqhJ+mxFtZdYGV4kcnUZ+5mPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mDQ0be+mBa1ytvXzXO1M2s/g/RyV0l+7MjT3sPhE7DzafMFVJWthHji9rkYiSfllQZC7I21YG0b6uMOgdxhhT5UJSnwZP7mHIsbEZzhPVDAXAEsT9nlQNyU1it8MNnZDfzVbUlG8tw8A4HbpQgI4drPHwyLYFKRJoLRTErhPImo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W08uIdYP; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W08uIdYP"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2dd7bcad16cso1987845ad.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 04:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789557996; x=1790162796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a9ViUhwGOM7OIB5s/olFkj6i9s8IeWq2eOJA0tjaMKk=;
        b=W08uIdYPF6SqcnXWAKNJxOGcv4+Zh0qDmq3cAZlbM1Z1KfRCbRM1xsWQA35PUshP6q
         8FPiH9fD9QcdCxL3w2VzJ9qhqivUK4kGu1XqkjjcWLYKfR2y0UBaoanbnh+3mIAtaQIF
         4HJ/EGP8C2DfZrGzaF1hzpuz/8r21C1Si4UPPsV/JOdJm7TAM8M58pzci/AGM1CpcPQn
         aqTc/7dAxUQsyXIVSfE3FL/8OUy9k8Ob/Irig3Cy9Ojg0jYGtN4RGSXQ8Rha+osdTbhc
         C0/I/KT7aJXJpOxTW7b4FbbNdfOO7SCpZOVvz9/YKcrQsp4h+rK4CoW0JQ5S0ThRMsaC
         WzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789557996; x=1790162796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a9ViUhwGOM7OIB5s/olFkj6i9s8IeWq2eOJA0tjaMKk=;
        b=Lz4koJ162vORMMqBfywLeasSqFBwxWUKbmBLjqSnP6uvFxlWNqeTwmvmKfFJbq+5bC
         3FmOPyZNH3ibaUO3jFAO07n2Ejid6TWkMlMc0w6Wj048wS/88bF8Z0P65sGUJlpc9k9v
         FWeBVnqmFUJHo+sGI5ZyP+EK3TIPfvRyjv3ur9YPPKQN1CNMsVkZKS4ttvJuQfoN0hir
         eWDjKyatyCPd+EaIVXunnBEJNrF9e1C4KHz4+zhaBv1xejJoEg76kgzbpZrf80ybUb71
         eRIXkX5ZJCbizQhgs5xNa9OCeJY5mdkT+twLEBXxEay6K68V3GGrJRAwaW6svMqabJfd
         JHYA==
X-Forwarded-Encrypted: i=1; AKwUvBzf802u+Sd43zy5RzfT1KX9KSvQybWEB9dNrWsUCCodYAkOHBOgCmVNwmZr7H6H9/WWIARglgA=@vger.kernel.org
X-Gm-Message-State: AFuF++nxd8js8uXCBaqZH0+ytxad0lC/5nJBIhHOQO2pHtl9ocFRrcFc
	YgcLKIay+6+4+0PFdPl+2WqP/XNLwjeoqdc+fCkwFMV2NgPVUxWJ/NNJ
X-Gm-Gg: AYBFou2AOlWVudkqg5hLBpsGRcsCz2zLgnnkBvFygcCIzvNXluROaYOUHGpfr6KPOQB
	+MEpUBEeLMZIsvDLFOm4fT/JLO+mLlxe17PqMs3ZkgHj/awFRvVBSN3d9Lpr+8U347f3BwqQOkN
	1sqbUnRgbwljWmrGFDB+32yvB/vMoK+R4Uo9h0hpvIYpVOVKNamqmkcDFdn3MVRSOfc1KgMcoME
	PkAHFUgoOd9A+YOS755/f9BjjcaAqw15xTco+U0ORV5lDPf6/hsvRxboStaOcFm0G6zP+MdKCOd
	XAI/lPREmWlK2NvSga0SKi9xh1lSNL8h6m9nwt6dnlXVskllQ4/Rkw6M46jtpoeHmaCVGcqObip
	+14kk+jp2r7ahnXw43u64U9AWDJTgA/OM62IJcj1VFAXVZdkHxveQ6eN5ZDIOloAf+uGZ9uVgj0
	8cD/V50NFW9lhS9CnPe5K89Z5ZH++uj5yk2P0HTX5uAcVAM2XaMEOHnUj3mesFPeSY7LIz/jupc
	on1EVEqlhQqtIG0BAVcCkNN5P3Esw0vQw+zGkCoUdBBOIJro6jsr6GENTwAPNLyegIlkSJ7zwBP
	Bmvxgq6o73IiAJuDBJnhL4E=
X-Received: by 2002:a17:903:1a2d:b0:2db:3d84:efff with SMTP id d9443c01a7336-2dd8e8b20a3mr27548885ad.2.1789557995925;
        Wed, 16 Sep 2026 04:26:35 -0700 (PDT)
Received: from blackbox ([2401:4900:8838:4a03:4141:6b61:e799:72f6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89d8fe2esm10102775ad.6.2026.09.16.04.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 04:26:35 -0700 (PDT)
From: Madhav Khosla <madhav.khoslaa@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: alexis.lothore@bootlin.com,
	Madhav Khosla <madhav.khoslaa@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	bpf@vger.kernel.org (open list:BPF [SELFTESTS] (Test Runners & Infrastructure)),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [PATCH v2 bpf] selftests/bpf: Fix csum_partial() dropping trailing byte on odd length
Date: Wed, 16 Sep 2026 11:25:53 +0000
Message-ID: <20260916112554.413933-1-madhav.khoslaa@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

csum_partial() computes num_u16 = len >> 1 and only sums that many
16-bit words, so the last byte of an odd-length buffer never gets
added to the checksum. RFC 1071 says it should be padded with a zero
byte and summed as one more word, not dropped.

This backs build_ip_csum(), build_udp_v4_csum() and
build_udp_v6_csum(), used by flow_dissector_classification.c and
xdp_metadata.c to hand-build packets. No current caller builds an
odd-length payload, so nothing fails today, but a future one would
get a silently wrong checksum.

Also bump flow_dissector_classification's TEST_PACKET_LEN from 100 to
99 so this actually gets exercised instead of staying latent.

Without the fix and with TEST_PACKET_LEN=99, flow_dissector_classification
fails under vmtest.sh:

    test_flow_dissector_classification:FAIL:test third port unexpected
    test third port: actual 0 != expected 10
    #137/6   flow_dissector_classification/ipv6:FAIL
    #137     flow_dissector_classification:FAIL
    Summary: 1/0 PASSED, 0 SKIPPED, 1/6 FAILED

Kernel just drops the packet over a bad checksum. With the fix, both
flow_dissector_classification and xdp_metadata pass.

v1 -> v2:
- comment style: opening /* on its own line, per BPF selftests style
- Retarget the Fixes tag to bcc00987bc56. commit f4504af68575
  ("selftests/bpf: move ip checksum helper to network helpers") moved
  the helper, but sizeof(iphdr) is always a multiple of 32 bit words /
  4 Bytes (iph->ihl counts in 4-byte words), so the odd-length path
  was never reachable through build_ip_csum(). csum_partial() first
  gets called with a length that isn't guaranteed even in
  bcc00987bc56, via build_udp_v4_csum()/build_udp_v6_csum().
- TEST_PACKET_LEN 100 -> 99 so an existing test catches this instead
  of the bug staying unexercised

Fixes: bcc00987bc56 ("selftests/bpf: add network helpers to generate udp checksums")
Link: https://lore.kernel.org/bpf/DLG5TIIHIMC2.2YCCY0UX86YQF@bootlin.com/T/#t
Signed-off-by: Madhav Khosla <madhav.khoslaa@gmail.com>
---
 tools/testing/selftests/bpf/network_helpers.h     | 15 +++++++++++++--
 .../prog_tests/flow_dissector_classification.c    |  2 +-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 75133119c04a..878c9fc5c37c 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -129,12 +129,23 @@ static __u16 csum_fold(__u32 csum)
 
 static __wsum csum_partial(const void *buf, int len, __wsum sum)
 {
-	__u16 *p = (__u16 *)buf;
+	const __u8 *p = buf;
 	int num_u16 = len >> 1;
 	int i;
 
 	for (i = 0; i < num_u16; i++)
-		sum += p[i];
+		sum += ((const __u16 *)p)[i];
+
+	/*
+	 * RFC 1071: an odd-length buffer's trailing byte is paired with
+	 * a zero pad byte to form the final 16-bit word.
+	 */
+	if (len & 1) {
+		__u16 tail = 0;
+
+		__builtin_memcpy(&tail, p + len - 1, 1);
+		sum += tail;
+	}
 
 	return sum;
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector_classification.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector_classification.c
index 80b153d3ddec..421dfa6c4ea3 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector_classification.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector_classification.c
@@ -27,7 +27,7 @@
 #define TEST_NAME_MAX_LEN (32 + SUBTEST_NAME_MAX_LEN)
 #define MAX_SOURCE_PORTS 3
 #define TEST_PACKETS_COUNT 10
-#define TEST_PACKET_LEN 100
+#define TEST_PACKET_LEN 99
 #define TEST_PACKET_PATTERN 'a'
 #define TEST_IPV4 "192.168.0.1/32"
 #define TEST_IPV6 "100::a/128"
-- 
2.55.0

