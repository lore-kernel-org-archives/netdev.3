Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D29443AB6
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785520328; cv=none; b=bI6tTNUeeeVAGuvqmtKA4DvaaJ0W5EyWPV3xmJ4eL3XzRHsYCeLPegNYLfmEmJELMLLl1Xuh6WzJ+zls0Q+Sm8smDWR7g3tUoUi+eZ88bPKtjGfcj0mKm3VZFhk3kAebhwU8N9jW31/RoRUp02UkWLwssYuFD1VJjMrMfbTPWy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785520328; c=relaxed/simple;
	bh=0EHZSXZWmDohLu6impw6EoIqHr8a2I0Rb8/ORbbncZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ADuuCdSp78OcQRpfZdqm89m/ydLTkIhzXuxXwJOJnPIQVjSw3pEIZyLt4KsON9z/FgXr6EJuxscsrKa04N5svN/EqEY7a1G5sy4ZOzZs78xygwWQREVSyW3yYiJJ5xcB6mgmSUBfHe8aqdPy58fkkrclIKh+QqqBGgHbrANJq2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shivajikant.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y+I6FlVi; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shivajikant.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+I6FlVi"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb7049fa552so850162a12.2
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 10:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785520322; x=1786125122; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mzxzaArWF5mA4vQFBpkZwR8ND0B5r/Z01WR537lxUSI=;
        b=Y+I6FlViMQiocp2PZ4LNdNmHhxPRy655v7x4QBqB1QMqvaXCRzoQLPThshKXfjKRFx
         8S+yEt3dkGPujntYb/Y3rZQbGeeOcmECwqzuBy3jrayQXPq2SXNiTsBXAtYrxqUX09L1
         YbpGKCPxyEclG521K1+HEPMrxpiwiMqYnJI/ch/fN2nVQAo3fJ2lrDIGdU02RQrtC9/B
         vI7uUFB5XAcayeNzJI7PxVlA5/FHOj9aGlXBF4zl9eRarwkb+gmmEFhSnYL/By3TCylz
         4mTUuJd8Aq4b2mlZxuFWMXoEnmagShGpvRQfDvLo97JlqvFZtnTmt//3tAH7NnZ/lOfD
         w5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785520322; x=1786125122;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mzxzaArWF5mA4vQFBpkZwR8ND0B5r/Z01WR537lxUSI=;
        b=FhfcKuS0Iuu001XXxu7XxS7+3xfjFQiEqzllP3rbwst0Wdds5I9gFtYONsfvSUylC/
         GnMl9XzJG/Ld0Y7tsGCVzk6kX6qwJspTYIcE3YlfqsunIj3cgYflWoM9ehoWKYA0GCgh
         cCcT6Kcfj3n3y5tix7Ke59bGBpDQuf7oChtqh9X9n1QZncJ1gEuQeYqVbWEFqHP5wfSw
         XTBZJ/GU2gqc9acDEq2dIEemEwzpgN/eRlxRmbGPJMQjkn4GZ0/iuNzGaIgK2c5LzVUb
         PCLdyKOo97gq5uXmEKoK1T2fe/OkBGJAHMuLb5WLahWv+jfK5HZmfqLJzIXvEvzI0waO
         qllg==
X-Gm-Message-State: AOJu0YwaFtbxdKw0PeyDxo0dEW45LMWJprKbtOc1Xb2I/9+mB6WFjlou
	ghlEHdcCsXrbyhnnX9eLZq6JEcJVHf7iRTdlUQJcagW5VivOzKEKNGwhB7OHUj7+x4WaK+rf3oN
	V6oOG9s0VoO46UPz7v5m2C7pkGA==
X-Received: from pggr14.prod.google.com ([2002:a63:d90e:0:b0:c8f:f76a:4b22])
 (user=shivajikant job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6e03:b0:3c0:9c19:b275 with SMTP id adf61e73a8af0-3c92ab2ab0bmr629681637.67.1785520322263;
 Fri, 31 Jul 2026 10:52:02 -0700 (PDT)
Date: Fri, 31 Jul 2026 17:51:34 +0000
In-Reply-To: <20260731175141.284757-1-shivajikant@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731175141.284757-1-shivajikant@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731175141.284757-2-shivajikant@google.com>
Subject: [PATCH net-next 2/2] selftests/bpf: Add IP_TRANSPARENT and
 IPV6_TRANSPARENT to setget_sockopt
From: Shivaji Kant <shivajikant@google.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kuniyu@google.com, anubhavsinggh@google.com, 
	Shivaji Kant <shivajikant@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
	Amery Hung <ameryhung@gmail.com>, Hoyeon Lee <hoyeon.lee@suse.com>, 
	Leon Hwang <leon.hwang@linux.dev>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add test coverage for IP_TRANSPARENT and IPV6_TRANSPARENT socket options
in the setget_sockopt BPF selftest to verify bpf_setsockopt() and
bpf_getsockopt() helpers.

Tested-by: Anubhav Singh <anubhavsinggh@google.com>
Signed-off-by: Shivaji Kant <shivajikant@google.com>
---
 tools/testing/selftests/bpf/progs/bpf_tracing_net.h | 2 ++
 tools/testing/selftests/bpf/progs/setget_sockopt.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
index d8dacef37c16..58b791e03a2d 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -28,10 +28,12 @@
 #define __SO_ACCEPTCON		(1 << 16)
 
 #define IP_TOS			1
+#define IP_TRANSPARENT		19
 
 #define SOL_IPV6		41
 #define IPV6_TCLASS		67
 #define IPV6_AUTOFLOWLABEL	70
+#define IPV6_TRANSPARENT	75
 
 #define TC_ACT_UNSPEC		(-1)
 #define TC_ACT_OK		0
diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/testing/selftests/bpf/progs/setget_sockopt.c
index 636a7cd8e2fa..d96e99b67aeb 100644
--- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
@@ -69,12 +69,14 @@ static const struct sockopt_test sol_tcp_tests[] = {
 
 static const struct sockopt_test sol_ip_tests[] = {
 	{ .opt = IP_TOS, .new = 0xe1, .expected = 0xe1, .tcp_expected = 0xe0, },
+	{ .opt = IP_TRANSPARENT, .flip = 1, },
 	{ .opt = 0, },
 };
 
 static const struct sockopt_test sol_ipv6_tests[] = {
 	{ .opt = IPV6_TCLASS, .new = 0xe1, .expected = 0xe1, .tcp_expected = 0xe0, },
 	{ .opt = IPV6_AUTOFLOWLABEL, .flip = 1, },
+	{ .opt = IPV6_TRANSPARENT, .flip = 1, },
 	{ .opt = 0, },
 };
 
-- 
2.55.0.508.g3f0d502094-goog

