Received: from mta0.migadu.com (out-60.mta0.migadu.com [91.218.175.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCACA4756D8
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792149422; cv=none; b=j1IvG1wRvTuOJJ+PkJl8Big7gXKdy3oj46HCelxampcIQtbAmnlEFP4HwbD2nswM0Hr/rWT6/UEhSH+qLV5VpARxTlLSiGveuY96Yh/iIos8o9H2Nnr00ckp1qPno8MJ4h57W7r9I6ByXSn6Eq0iii1pV1xwwBfkjRZY3WnIUko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792149422; c=relaxed/simple;
	bh=WZ6dLcgrQjwdEPJGDFfYZRVQIr0dB7OD7+Bd/3cCH8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fxpDZifvFjipEj4UmDCZGfRAgSX9jHmliFb4TbiJ5OygFVD5+ogg8X3ViRskF6zFRiRMIjI8a6fwnVpyM3sxHd18jGtTy7HQyevptlV542u3racvclx0vMbAihQGbsMudfG0jxLG94nYtZTNNfHyZ2/AiYEg80FphYIk0TpVsn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OeMMXyzT; arc=none smtp.client-ip=91.218.175.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OeMMXyzT"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WZ6dLcgrQjwdEPJGDFfYZRVQIr0dB7OD7+Bd/3cCH8k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792149418; v=1; x=1792754218;
 b=OeMMXyzTDIop3AzZOaNY4CwfOsebZLkr1rUB3Md96Sqdb4IjuPjb2Ze6fbnFeqceS6Tbcdpo
 3Aklpw6M7vBprnBBSYPmsPkkSYrKset75kvv2Pm0dxP11Wruc+C3er0h2y4CRTgNoMhSkzjpQBw
 Sv9rWf9sGIx+SGCMyq8l/mfg=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8fa13fae177cef9b;
	Fri, 16 Oct 2026 11:16:58 +0000
X-Mizu-Trace-ID: 8fa13fae177cef9b
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Kaiyan Mei <M202472210@hust.edu.cn>,
	Yinhao Hu <dddddd@hust.edu.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf: Fix verifier WARN on narrow read of bpf_tcp_sock u64 fields
Date: Fri, 16 Oct 2026 19:16:42 +0800
Message-ID: <20261016111643.247553-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A BPF program can read the middle of a u64 field in struct bpf_tcp_sock:

	tp = bpf_tcp_sock(listener);
	/* +0x54 is in the middle of the u64 bytes_received */
	unsigned hi = *(unsigned *)((char *)tp + 0x54);

bpf_tcp_sock_is_valid_access() allows this 4-byte read (the default case
only checks size == 4), but bpf_tcp_sock_convert_ctx_access() only knows
the field starts and has no idea how to handle such an offset. It emits
no instruction, cnt stays 0 and the fixup pass trips verifier_bug():

	verifier bug: error during ctx access conversion (0)

Just disallow the narrower access by matching the whole u64 range of the
two fields, so it is turned down at check time:

	invalid tcp_sock access off=84 size=4

Fixes: 655a51e536c0 ("bpf: Add struct bpf_tcp_sock and BPF_FUNC_tcp_sock")
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
Closes: https://lore.kernel.org/bpf/7a8ff335.1024c.1a14395f3e5.Coremail.kaiyanm@hust.edu.cn/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index ba536be2915f..f0eae1c14b2f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7600,8 +7600,8 @@ bool bpf_tcp_sock_is_valid_access(int off, int size, enum bpf_access_type type,
 		return false;
 
 	switch (off) {
-	case offsetof(struct bpf_tcp_sock, bytes_received):
-	case offsetof(struct bpf_tcp_sock, bytes_acked):
+	case bpf_ctx_range(struct bpf_tcp_sock, bytes_received):
+	case bpf_ctx_range(struct bpf_tcp_sock, bytes_acked):
 		return size == sizeof(__u64);
 	default:
 		return size == sizeof(__u32);
-- 
2.43.0

