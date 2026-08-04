Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDF441D126
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 02:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785812389; cv=none; b=IXakV5VctTOdzpoh/2Jp+cSmh7dVYueUkaTMRadZBwFbT91IC0Jv/3a/s0U1wm7DRkx4HnCuy6sVEHuJ+5DMQCLPAV+gddxbthuKSx/VTihUqS1K/XfQ0WFAsHhwIPdVjVTd3cu0ab39cii7NfuDzxqPy/tH5GRWFz7Jzrh4nJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785812389; c=relaxed/simple;
	bh=JmhELRI2ithkLQv4rBVDAJOIi3ocRRvtV26qJNG/l5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmeiUzlNtpqPH74PzbvW3z3IYnNtMZrSuy72Mqd55VNljxugE1r2bGholyQUG5MbVZI5MCk4qdTK4tJ7IG8VfJuc4YbyPQ81A7JJuNySfvBnQ0YpYtHa2ECEEuygwBcP5gAEBJcERZPYoaq9/Dm1TSj61RoflBRl5DKtVKofZWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Umm9D5CG; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Umm9D5CG"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso3125837a91.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 19:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785812384; x=1786417184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fEwXBy8GqBmJpL/bfLNE70Yj9p6IegQd47Zgr1mcc8U=;
        b=Umm9D5CGiqD9wJ5b0bLDhXBjpvJfP1pOA1l9iPfkjuCp0zxa170eMMbJP6pO/CSnmJ
         FKdIq87leBBX2yk08b7BSJccAt4nJClHzldU24pgnJ+WOycec2R+egrdfsOQTsr6AqgX
         Sf1R9pxT1fFyil+tBucAvqDoQc6bcc2epWxq4lpDnUV0A99ucSVHl1QiVgkKROPC4w8W
         Upl6/C9oiFY4A1SW29qlBNRflYbmYV4+H/DeyMApPwY+YWSNFYOXEuherz0i92OzzWbp
         HUWk0vxFD7Op7urQUfZH0gi4l+92WrCkLnf/zLYs2cw63oQsUHysERy1AyO6Y6QBzl/1
         H/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785812384; x=1786417184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fEwXBy8GqBmJpL/bfLNE70Yj9p6IegQd47Zgr1mcc8U=;
        b=RgvV5XhB5Nev5jNVf4dGeVyt/e0GGLRp3kufUkPGm6GgcWPCxFBnA5BbJB7pl9j1J+
         d0uwsSMbIKA4ZFUs6rJ2/1UYuD9z9wrAO4XlOo8ASEGTzqyX50h/zU7PNXPkHPChymuw
         +7g79rxEoOV9O2dss6iOu/M/zn3EBtQe6axlR+ccJE5cRL9WZVoUVXmjCUL6CAQs2x8D
         nfZvLlB01gj3AxiQQOGmB+zVen00gIxcuqWSSZQskV7avqMjQ/9e/Vp4ZxR1cOeMnBoK
         NLuPsfrKIgqc9tiNAlND6/9UwouqWJMm83O1sjY2S6u4Asg8kvkyVedLqqcKuP3SPO4C
         i7oQ==
X-Gm-Message-State: AOJu0Yx/6+No3tJFTSkS4jcS7LDP4UiZe5YKeiq7LtQq56r/PGORPcxR
	w2SP/p678/X/weaub54xT4g1fb0q9M8rSxZYVB767sUzPi4IDRKr8+r6A7RLy3Eq
X-Gm-Gg: AR+sD12KCSUAdF35ETpWg46/geU6B1QbCWQSgIaWg6Tab+amjkJ3bpK4PnlinlfnDnI
	dWjw+YViRbA8v19zJ8L+kF/1owd3jPMYyuCeLyT0Dp75HRM7s2EzQYcvpHIdiv8VBAZS4BLzX1F
	A6LR7gCMiZRROeVIMqxmXmBUGzjS5JVme3r5OEUKj5mT2QV5PA8hrfESNYrmTgU6QJnKJRdw6n9
	2aTxP9PlC7kA/pDNdMANpId8FJ12UyccNpUG4JQtGahO/7OYpPiMMtOyv+B1SlsX+dmr4d0BpBg
	Oh0Qx+L+nBYPHkiDvawxjtq7TGN9cMK5xtuznC+gWc8GzmvjbQNkyv9F05gWE5cncGkOzXwl2yP
	xT4/BHcLRoMpJhYPgR7NT6dYWhjmth8UnHCkCsqq0ynxAD4yWs93HWmKtQFO8W7ghabYm3ybytx
	3V7KOWiY0/a+Ea5yrVeo9oqoE6maADwFLJJmk0h6M0rTj8S3GPS5nWDaj7ojowg4hWyEoBzvawY
	Vn0
X-Received: by 2002:a17:90b:57e6:b0:38f:23d6:b4ad with SMTP id 98e67ed59e1d1-38fbc3f7e43mr11073937a91.8.1785812384145;
        Mon, 03 Aug 2026 19:59:44 -0700 (PDT)
Received: from fedora ([2804:1b3:a8c3:8ee5:1c39:64d9:e257:73dc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab2530c0sm35974758c88.8.2026.08.03.19.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 19:59:43 -0700 (PDT)
From: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
Subject: [PATCH net-next v2 3/4] selftests: net: test IPV6_FL_F_REFLECT
Date: Mon,  3 Aug 2026 23:59:09 -0300
Message-ID: <20260804025910.50145-4-marcelomspessoto@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804025910.50145-1-marcelomspessoto@gmail.com>
References: <20260804025910.50145-1-marcelomspessoto@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to source code, flowlabel_consistency must be deactivated
for the IPV6_FL_F_REFLECT flag to work. Therefore, take the following
measures: deactivate it on the wrapper .sh script, and skip this test
if it is run on an environment that does not correspond.

The previously defined tcp_listen and tcp_connect helpers were reused,
since the connection flow required for REFLECT validation is very
similar to REMOTE.

Signed-off-by: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
---
 tools/testing/selftests/net/ipv6_flowlabel.sh |  3 +-
 .../selftests/net/ipv6_flowlabel_mgr.c        | 61 +++++++++++++++++++
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/ipv6_flowlabel.sh b/tools/testing/selftests/net/ipv6_flowlabel.sh
index cee95e252bee..4c3de3a27807 100755
--- a/tools/testing/selftests/net/ipv6_flowlabel.sh
+++ b/tools/testing/selftests/net/ipv6_flowlabel.sh
@@ -8,7 +8,8 @@
 set -e
 
 echo "TEST management"
-./in_netns.sh ./ipv6_flowlabel_mgr
+./in_netns.sh \
+  sh -c 'sysctl -q -w net.ipv6.flowlabel_consistency=0 && ./ipv6_flowlabel_mgr'
 
 echo "TEST datapath"
 ./in_netns.sh \
diff --git a/tools/testing/selftests/net/ipv6_flowlabel_mgr.c b/tools/testing/selftests/net/ipv6_flowlabel_mgr.c
index d482be2e9f9f..af87eec799c8 100644
--- a/tools/testing/selftests/net/ipv6_flowlabel_mgr.c
+++ b/tools/testing/selftests/net/ipv6_flowlabel_mgr.c
@@ -6,6 +6,7 @@
 #include <arpa/inet.h>
 #include <error.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <limits.h>
 #include <linux/in6.h>
 #include <stdbool.h>
@@ -158,6 +159,22 @@ static void tcp_connect(int listener, uint32_t flowlabel, int *client, int *acce
 	*accepted = afd;
 }
 
+static bool flowlabel_consistency_enabled(void)
+{
+	char buf[2] = {};
+	int fd;
+
+	fd = open("/proc/sys/net/ipv6/flowlabel_consistency", O_RDONLY);
+	if (fd == -1)
+		return true;
+
+	if (read(fd, buf, sizeof(buf) - 1) < 0)
+		buf[0] = '1';
+	close(fd);
+
+	return buf[0] != '0';
+}
+
 static void run_tests(int fd)
 {
 	int wstatus;
@@ -288,6 +305,50 @@ static void run_tests(int fd)
 		close(remote_cfd);
 		close(remote_listener);
 	}
+
+	if (flowlabel_consistency_enabled()) {
+		fprintf(stderr,
+			"[INFO] skip REFLECT flag validation (net.ipv6.flowlabel_consistency must be 0)\n");
+	} else {
+		struct in6_flowlabel_req reflect_query = {
+			.flr_action = IPV6_FL_A_GET,
+		};
+		struct in6_flowlabel_req reflect_off = {
+			.flr_action = IPV6_FL_A_PUT,
+			.flr_flags = IPV6_FL_F_REFLECT,
+		};
+		struct in6_flowlabel_req reflect_on = {
+			.flr_action = IPV6_FL_A_GET,
+			.flr_flags = IPV6_FL_F_REFLECT,
+		};
+		socklen_t reflect_query_len = sizeof(reflect_query);
+		int reflect_listener = tcp_listen();
+		int reflect_cfd, reflect_afd;
+
+		explain("Enable REFLECT on the listener before the client connects");
+		expect_pass(setsockopt(reflect_listener, SOL_IPV6, IPV6_FLOWLABEL_MGR,
+				       &reflect_on, sizeof(reflect_on)));
+
+		tcp_connect(reflect_listener, 8, &reflect_cfd, &reflect_afd);
+
+		explain("Query the accepted socket's outgoing label, should be reflected");
+		expect_pass(getsockopt(reflect_afd, SOL_IPV6, IPV6_FLOWLABEL_MGR,
+				       &reflect_query, &reflect_query_len));
+		if (ntohl(reflect_query.flr_label) != 8)
+			error(1, 0, "unexpected reflected flowlabel %u",
+			      ntohl(reflect_query.flr_label));
+
+		explain("PUT+REFLECT disables reflection on the accepted socket");
+		expect_pass(setsockopt(reflect_afd, SOL_IPV6, IPV6_FLOWLABEL_MGR,
+				       &reflect_off, sizeof(reflect_off)));
+		explain("cannot disable reflection twice");
+		expect_fail(setsockopt(reflect_afd, SOL_IPV6, IPV6_FLOWLABEL_MGR,
+				       &reflect_off, sizeof(reflect_off)));
+
+		close(reflect_afd);
+		close(reflect_cfd);
+		close(reflect_listener);
+	}
 }
 
 static void parse_opts(int argc, char **argv)
-- 
2.55.0

